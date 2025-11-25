from manim import *
import numpy as np


# ----------------------------
# Model parameters
# ----------------------------
k1 = 100.0
k2 = 10.0

# (epsilon, text description)
EPS_INFO = [
    (1,   r"\text{generic}"),
    (0.01,  r"\text{emerging fast--slow}"),
    (0.0001,  r"\text{almost decoupled}"),
]

# Link lengths and visualization scaling
# Chosen to fit comfortably in the default frame.
L1 = 1.1
L2 = 1.1
AMPLITUDE = 0.4   # mode shape scaling for animation


def K_matrix(k1, k2):
    return np.array([[k1 + k2, -k2],
                     [-k2,      k2]], dtype=float)


def M_eps(eps):
    return np.array([[1.0 + eps, eps],
                     [eps,       eps]], dtype=float)


def eigenmodes(eps):
    """
    Compute eigenvalues/eigenvectors of M^{-1}K for given epsilon.
    Returns sorted eigenvalues and corresponding eigenvectors.
    """
    K = K_matrix(k1, k2)
    M = M_eps(eps)
    A = np.linalg.solve(M, K)          # M^{-1} K
    lam, V = np.linalg.eig(A)
    idx = np.argsort(np.real(lam))
    lam = np.real(lam[idx])
    V = np.real(V[:, idx])
    return lam, V


class RobotArmModes(MovingCameraScene):
    def construct(self):
        self.camera.frame.set_height(8)  # smaller -> less vertical space

        # Precompute modes for all eps
        mode_data = []  # list of dicts: {eps, desc, mode_index, omega, v, shift}

        n_eps = len(EPS_INFO)

        # Layout parameters (in scene units)
        dx = 4.0    # horizontal spacing between columns
        dy = 2.8    # vertical spacing between rows

        # Center grid around origin: top row at y0
        y0 = 1.1    # mode 0 row center; mode 1 below
        x0 = -(n_eps - 1) * dx / 2.0   # column centers: -4, 0, 4

        for col, (eps, desc) in enumerate(EPS_INFO):
            lam, V = eigenmodes(eps)
            for mode_idx in (0, 1):
                omega = np.sqrt(lam[mode_idx])
                v = V[:, mode_idx].copy()
                v /= (np.max(np.abs(v)) + 1e-12)  # normalize

                x_shift = x0 + col * dx
                y_shift = y0 - mode_idx * dy
                shift = np.array([x_shift, y_shift, 0.0])

                mode_data.append(
                    dict(eps=eps,
                         desc=desc,
                         mode_index=mode_idx,
                         omega=omega,
                         v=v,
                         shift=shift)
                )

        # Global time tracker
        t_tracker = ValueTracker(0.0)

        # Build animated arms and per-panel labels
        arms = VGroup()
        panel_labels = VGroup()

        for data in mode_data:
            eps = data["eps"]
            mode_idx = data["mode_index"]
            omega = data["omega"]
            v = data["v"]
            shift = data["shift"]

            arm = self._make_arm_mobject(
                t_tracker=t_tracker,
                omega=omega,
                v=v,
                shift=shift
            )
            arms.add(arm)

            # Per-panel label: epsilon and mode, just below the base
            plabel = MathTex(
                r"\epsilon = " + f"{eps:.0e}" + r",\ \text{mode }" + f"{mode_idx}"
            ).scale(0.45)
            plabel.next_to(shift + np.array([0, -0.2, 0.0]), DOWN, buff=0.15)
            panel_labels.add(plabel)

        # Column labels: epsilon on top, descriptor below
        col_labels = VGroup()
        y_label = 3.6 - 0.8  # vertical location inside frame

        for col, (eps, desc) in enumerate(EPS_INFO):
            x_shift = x0 + col * dx

            # First line: epsilon value
            eps_tex = MathTex(r"\epsilon = " + f"{eps:.0e}").scale(0.6)

            # Second line: descriptor (generic, emerging..., almost decoupled)
            desc_tex = MathTex(desc).scale(0.5)

            # Stack them vertically, epsilon above descriptor
            label = VGroup(eps_tex, desc_tex).arrange(DOWN, buff=0.1)
            label.move_to(np.array([x_shift, y_label, 0.0]))

            col_labels.add(label)


        # Row labels: "mode 0" and "mode 1", left of each row
        row_labels = VGroup()
        x_row_label = -6.0  # comfortably inside left boundary
        for mode_idx in (0, 1):
            y_row = y0 - mode_idx * dy
            rlabel = MathTex(r"\text{mode }" + f"{mode_idx}").scale(0.6)
            rlabel.move_to(np.array([x_row_label, y_row, 0.0]))
            row_labels.add(rlabel)

        # Add everything to the scene
        self.add(arms, panel_labels, col_labels, row_labels)

        # Animate time from 0 to T_FINAL
        T_FINAL = 20.0
        self.play(
            t_tracker.animate.set_value(T_FINAL),
            run_time=10.0,
            rate_func=linear
        )
        self.wait(1.0)

    def _make_arm_mobject(self, t_tracker, omega, v, shift):
        """
        Create an always_redraw VGroup representing the arm
        oscillating in a single mode with eigenvector v and frequency omega,
        shifted in the scene by 'shift'.
        """
        def arm_group():
            t = t_tracker.get_value()
            theta1 = AMPLITUDE * v[0] * np.sin(omega * t)
            theta2 = AMPLITUDE * v[1] * np.sin(omega * t)

            p0 = shift
            p1 = shift + np.array([L1 * np.cos(theta1),
                                   L1 * np.sin(theta1),
                                   0.0])
            p2 = p1 + np.array([L2 * np.cos(theta2),
                                L2 * np.sin(theta2),
                                0.0])

            link1 = Line(p0, p1, stroke_width=4)
            link2 = Line(p1, p2, stroke_width=4)

            joint0 = Dot(p0, radius=0.06)
            joint1 = Dot(p1, radius=0.06)
            joint2 = Dot(p2, radius=0.06)

            return VGroup(link1, link2, joint0, joint1, joint2)

        return always_redraw(arm_group)

