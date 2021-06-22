# Python Solution: output computation result by generating svg file from latex
class ImageFile(object):
    """Class displayes images in notebook code cell output"""

    def __init__(self, fpath):
        self.fpath = fpath
        self.format = fpath.split('.')[-1]

    def _repr_png_(self):
        if self.format == 'png':
            return open(self.fpath, 'r').read()

    def _repr_jpeg_(self):
        if self.format == 'jpeg' or self.format == 'jpg':
            return open(self.fpath, 'r').read()

    def _repr_svg_(self):
        if self.format == 'svg':
            return open(self.fpath, 'r').read()

def svg_from_tex( tex_file, svg_file ):
    """create an svg file from a tex file"""
    from os import chdir, getcwd
    from subprocess import call
    d = getcwd()
    chdir('/tmp')
    call(["latexmk", "-xelatex", d+'/'+tex_file])
    call(["pdf2svg", tex_file.replace('.tex','.pdf'), tex_file+'.svg'])
    chdir(d)
    call(["inkscape", "-D", "--without-gui","--file=/tmp/%s.svg"%tex_file, "--export-plain-svg=%s"%svg_file])

def svg_from_texstring( txt, svg_file ):
    """create an svg file from a tex file string"""

    tex_file = svg_file.replace('.svg', '.tex')
    with open( tex_file, 'w') as fh:
        fh.write(txt)
    svg_from_tex( tex_file, svg_file )

def tex2svg( tex_file, svg_file):
    """display an svg image from a tex file"""
    svg_from_tex( tex_file, svg_file )
    return ImageFile( svg_file )

def texstring2svg(txt, svg_file ):
    """display an svg image from a tex string"""
    svg_from_texstring( txt, svg_file )
    return ImageFile( svg_file )
