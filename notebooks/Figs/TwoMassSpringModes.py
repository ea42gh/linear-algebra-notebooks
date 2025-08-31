# two_mass_spring.py
# Manim Community (e.g., v0.18). Renders two normal modes for a 2-mass/2-spring chain.

from manim import *
import numpy as np


# --- Physical model (K, M) ----------------------------------------------------
# m1 = m2 = 1, k1 = 2, k2 = 1
# K = [[k1 + k2, -k2],
#      [-k2     ,  k2]]
K = np.array([[3.0, -1.0],
              [-1.0, 1.0]])
M = np.eye(2)

# Eigenpairs of Kx = λMx (M = I)
lam, V = np.linalg.eig(K)  # λ = ω^2
idx = np.argsort(lam.real)
lam = lam[idx].real
V = V[:, idx].real

# Normalize eigenvectors for display (scale so max(|component|)=1)
V = V / np.max(np.abs(V), axis=0, keepdims=True)

# Frequencies
omega = np.sqrt(lam)  # ω1 < ω2

# --- Helpers -------------------------------------------------------------------
def zigzag(start: np.ndarray, end: np.ndarray, coils=12, amp=0.15) -> VMobject:
    """
    2D zigzag spring from start to end in world coords.
    """
    start = np.array(start[:2])
    end = np.array(end[:2])
    vec = end - start
    L = np.linalg.norm(vec)
    if L < 1e-9:
        return VMobject()
    t_hat = vec / L
    n_hat = np.array([-t_hat[1], t_hat[0]])  # rotate by +90° in plane
    # Build points along the spring
    pts = [start]
    # small straight lead-in/out to visually attach to bodies
    lead = 0.07
    s0 = start + lead * t_hat
    e0 = end - lead * t_hat
    span = np.linalg.norm(e0 - s0)
    # number of interior peaks:
    N = max(1, int(coils))
    for i in range(N + 1):
        s = i / N
        p = s0 + s * (e0 - s0)
        off = ((-1) ** i) * amp * n_hat
        if i in (0, N):
            pts.append(p)  # endpoints land on axis
        else:
            pts.append(p + off)
    pts.append(end)
    path = VMobject()
    path.set_points_as_corners([*map(lambda xy: np.array([xy[0], xy[1], 0.0]), pts)])
    return path

def wall(x=0.0, height=2.0, width=0.2) -> VGroup:
    r = Rectangle(width=width, height=height).set_fill(GREY_E, opacity=1.0).set_stroke(width=0)
    r.move_to(np.array([x, 0, 0]))
    # hatch lines
    hatch = VGroup()
    for y in np.linspace(-height/2, height/2, 9):
        seg = Line([x - width/2, y, 0], [x + width/2, y + 0.15, 0]).set_stroke(GREY_B, 2)
        hatch.add(seg)
    return VGroup(r, hatch)

# Small helper to convert plain digits to Unicode subscripts
def subscript(num: int) -> str:
    subs = str.maketrans("0123456789", "₀₁₂₃₄₅₆₇₈₉")
    return str(num).translate(subs)

def label_mode(i, lam_i, omega_i, vec):
    v = vec / (np.max(np.abs(vec)) + 1e-12)
    si = subscript(i)  # e.g. 1 → "₁"

    # First line: eigenvalue and frequency with subscripts
    line1 = Text(
        f"Mode {i}: λ{si} = {lam_i:.3f},   ω{si} = √(λ{si}) = {omega_i:.3f}",
        font_size=28,
        color=BLACK
    )
    # Second line: eigenvector with subscript
    line2 = Text(
        f"x{si} ∝ [{v[0]:.3f}, {v[1]:.3f}]ᵀ",
        font_size=28,
        color=BLACK
    )

    txt = VGroup(line1, line2).arrange(DOWN, aligned_edge=LEFT).scale(0.6)
    txt.to_corner(UL).shift(DOWN*0.3 + RIGHT*0.1)
    return txt


class TwoMassSpringModes(Scene):
    def construct(self):
        self.camera.background_color = WHITE

        # Geometry constants
        y0 = 0.0
        wall_gap = 0.45
        mass_w = 0.6
        mass_h = 0.4

        # Anchor positions (rest)
        xL = -5.0
        xR =  5.0
        # Rest positions of masses along x
        x1_0 = -1.5
        x2_0 =  1.2

        # Static elements: walls
        left_wall  = wall(x=xL + 0.2)
        right_wall = wall(x=xR - 0.2)
        self.add(left_wall, right_wall)

        # Mass blocks
        m1 = Rectangle(width=mass_w, height=mass_h).set_fill(BLUE_E, 1.0).set_stroke(BLUE_E, 2)
        m2 = Rectangle(width=mass_w, height=mass_h).set_fill(RED_E, 1.0).set_stroke(RED_E, 2)

        # Place at rest
        m1.move_to([x1_0, y0, 0])
        m2.move_to([x2_0, y0, 0])

        # Springs: k1 (wall to m1), k2 (m1 to m2); show a rigid bar to the right wall (optional)
        coils = 10
        amp = 0.14

        spring1 = always_redraw(lambda:
            zigzag([xL + wall_gap, y0, 0], [m1.get_left()[0], y0, 0], coils=coils, amp=amp).set_stroke(GREY_D, 3)
        )
        spring2 = always_redraw(lambda:
            zigzag([m1.get_right()[0], y0, 0], [m2.get_left()[0], y0, 0], coils=coils, amp=amp).set_stroke(GREY_D, 3)
        )
        # optional guide to right wall (no spring in this model)
        guide = always_redraw(lambda:
            Line([m2.get_right()[0], y0, 0], [xR - wall_gap, y0, 0]).set_stroke(GREY_B, 2, opacity=0.6)
        )

        # Axes baseline
        baseline = NumberLine(x_range=[-6, 6, 1], include_numbers=False).set_stroke(GREY_B, 1)
        baseline.shift(DOWN*1.2)
        self.add(baseline)

        self.add(spring1, spring2, guide, m1, m2)

        # Time tracker
        t = ValueTracker(0.0)

        # Mode animators --------------------------------------------------------
        def attach_mode(mode_index):
            # mode_index: 0 or 1
            vec = V[:, mode_index]
            w = omega[mode_index]
            A = 0.6  # overall amplitude scale

            # Update functions for positions
            def x1():
                return x1_0 + A * vec[0] * np.sin(w * t.get_value())
            def x2():
                return x2_0 + A * vec[1] * np.sin(w * t.get_value())

            # Move masses per frame
            m1.add_updater(lambda mob: mob.move_to([x1(), y0, 0]))
            m2.add_updater(lambda mob: mob.move_to([x2(), y0, 0]))

            # Arrows to show direction/relative amplitude at t=0 snapshot
            a1 = Arrow(start=[x1_0, y0 - 0.8, 0], end=[x1_0 + 0.8*np.sign(vec[0]), y0 - 0.8, 0],
                       buff=0, stroke_width=5, max_tip_length_to_length_ratio=0.12, color=BLUE_E)
            a2 = Arrow(start=[x2_0, y0 - 0.8, 0], end=[x2_0 + 0.8*np.sign(vec[1]), y0 - 0.8, 0],
                       buff=0, stroke_width=5, max_tip_length_to_length_ratio=0.12, color=RED_E)

            title = label_mode(mode_index+1, lam[mode_index], w, vec)
            return title, a1, a2

        # --- Intro text
        header = Tex(r"Two-mass/Two-spring system: $Kx=\lambda Mx$, $M=I$, $K=\begin{bmatrix}3&-1\\-1&1\end{bmatrix}$") \
                 .scale(0.6).to_edge(UP)
        self.play(FadeIn(header), run_time=0.8)

        # --- Mode 1 (lower frequency, in-phase)
        title1, a1_1, a1_2 = attach_mode(0)
        self.play(FadeIn(title1), FadeIn(a1_1), FadeIn(a1_2), run_time=0.8)

        # Evolve time for a few periods
        T1 = 2*np.pi / omega[0]
        self.play(t.animate.set_value(3*T1), run_time=6.0, rate_func=linear)

        self.play(FadeOut(title1), FadeOut(a1_1), FadeOut(a1_2), run_time=0.5)

        # Remove updaters before switching modes
        m1.clear_updaters(); m2.clear_updaters()
        t.set_value(0.0)

        # --- Mode 2 (higher frequency, out-of-phase)
        title2, a2_1, a2_2 = attach_mode(1)
        self.play(FadeIn(title2), FadeIn(a2_1), FadeIn(a2_2), run_time=0.8)

        T2 = 2*np.pi / omega[1]
        self.play(t.animate.set_value(3*T2), run_time=6.0, rate_func=linear)

        self.play(FadeOut(title2), FadeOut(a2_1), FadeOut(a2_2), run_time=0.5)

        # Cleanup
        m1.clear_updaters(); m2.clear_updaters()
        self.wait(0.5)

