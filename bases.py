#!/usr/bin/env python
import sys
import os
from pprint import pprint
from optparse import OptionParser
import sh

def make_folder(basis, style, morphology, connection):
    path = "/".join([basis, style, morphology, connection])
    sh.mkdir("-p", path)
    return path

def _connector_setting(args, connector_setting):
    if connector_setting:
        args.append("-D")
        args.append('LOCK="%s"' % connector_setting)
    else:
        args.append("-D")
        args.append('LOCK="none"')

def _magnet_setting(args, magnet_setting, magnet_priority):
    if magnet_setting:
        args.append("-D")
        args.append('MAGNETS="%s"' % magnet_setting)
        args.append("-D")
        args.append("MAGNET_HOLE=6")
        args.append("-D")
        args.append('PRIORITY="%s"' % magnet_priority)
    else:
        args.append("-D")
        args.append('MAGNETS="none"')
        args.append("-D")
        args.append("MAGNET_HOLE=0")
        args.append("-D")
        args.append('PRIORITY="lock"')

def run_openscad_risers(filename, scad, x, y, z, lock, **kwargs):
    args = []
    args.append("-o")
    args.append(filename)
    args.append("-D")
    args.append("x=%s" % x)
    args.append("-D")
    args.append("y=%s" % y)
    args.append("-D")
    args.append("z=%s" % z)
    args.append("-D")
    args.append('LOCK="%s"' % lock)
    args.append(scad)
    print(filename)
    print(args)
    sh.openscad(*args)


def run_openscad_large_curved(filename, scad, x, y, magnet_priority, large, connector_setting=None, magnet_setting=None, **kwargs):
    args = []
    args.append("-o")
    args.append(filename)
    args.append("-D")
    args.append("x=%s" % x)
    args.append("-D")
    args.append("y=%s" % y)
    args.append("-D")
    args.append('SQUARE_BASIS="inch"')

    _connector_setting(args, connector_setting)
    _magnet_setting(args, magnet_setting, magnet_priority)

    if 'topless' in kwargs:
        args.append("-D")
        args.append('TOPLESS="%s"' % kwargs['topless'])

    args.append("-D")
    args.append('CURVED_LARGE="%s"' % large)
    args.append(scad)
    print(filename)
    print(args)
    sh.openscad(*args)

def run_openscad_hex(filename, scad, size, magnet_priority, connector_setting=None, magnet_setting=None, **kwargs):
    args = []
    args.append("-o")
    args.append(filename)
    args.append("-D")
    args.append("size=%s" % size)
    args.append("-D")
    args.append('SQUARE_BASIS="inch"')

    _connector_setting(args, connector_setting)
    _magnet_setting(args, magnet_setting, magnet_priority)

    if 'topless' in kwargs:
        args.append("-D")
        args.append('TOPLESS="%s"' % kwargs['topless'])

    args.append(scad)
    print(filename)
    print(args)
    sh.openscad(*args)

def run_openscad_curved_inverted(filename, scad, x, cut, id, magnet_priority, connector_setting=None, magnet_setting=None, **kwargs):
    args = []
    args.append("-o")
    args.append(filename)
    args.append("-D")
    args.append("x=%s" % x)
    args.append("-D")
    args.append("cut=%s" % cut)
    args.append("-D")
    args.append("id_radial_connectors=%s" % id)
    args.append("-D")
    args.append('SQUARE_BASIS="inch"')

    _connector_setting(args, connector_setting)
    _magnet_setting(args, magnet_setting, magnet_priority)

    if 'topless' in kwargs:
        args.append("-D")
        args.append('TOPLESS="%s"' % kwargs['topless'])
    if 'large' in kwargs:
        args.append("-D")
        args.append('CURVED_LARGE="%s"' % kwargs['large'])

    args.append(scad)
    print(filename)
    print(args)
    sh.openscad(*args)

def run_openscad_curved_radial(filename, scad, x, cut, angle, id, od, magnet_priority, connector_setting=None, magnet_setting=None, **kwargs):
    args = []
    args.append("-o")
    args.append(filename)
    args.append("-D")
    args.append("x=%s" % x)
    args.append("-D")
    args.append("cut=%s" % cut)
    args.append("-D")
    args.append("angle=%s" % angle)
    args.append("-D")
    args.append("id_radial_connectors=%s" % id)
    args.append("-D")
    args.append("od_radial_connectors=%s" % od)
    args.append("-D")
    args.append('SQUARE_BASIS="inch"')

    _connector_setting(args, connector_setting)
    _magnet_setting(args, magnet_setting, magnet_priority)

    if 'topless' in kwargs:
        args.append("-D")
        args.append('TOPLESS="%s"' % kwargs['topless'])

    args.append(scad)
    print(filename)
    print(args)
    sh.openscad(*args)


def run_openscad(filename, scad, x, y, magnet_priority, connector_setting=None, magnet_setting=None, **kwargs):
    args = []
    args.append("-o")
    args.append(filename)
    args.append("-D")
    args.append("x=%s" % x)
    args.append("-D")
    args.append("y=%s" % y)
    args.append("-D")
    args.append('SQUARE_BASIS="inch"')

    _connector_setting(args, connector_setting)
    _magnet_setting(args, magnet_setting, magnet_priority)

    if 'topless' in kwargs:
        args.append("-D")
        args.append('TOPLESS="%s"' % kwargs['topless'])
    if 'notch' in kwargs:
        args.append("-D")
        args.append('NOTCH="%s"' % kwargs['notch'])
    if 'notch_x' in kwargs:
        args.append("-D")
        args.append('NOTCH_X=%s' % kwargs['notch_x'])
    if 'notch_y' in kwargs:
        args.append("-D")
        args.append('NOTCH_Y=%s' % kwargs['notch_y'])
    if 'wall_locks' in kwargs:
        args.append("-D")
        args.append('WALL_LOCKS="%s"' % kwargs['wall_locks'])

    args.append(scad)
    print(filename)
    print(args)
    sh.openscad(*args)

def hex_coords():
    return [2,3,4]

def riser_coords(limited=False):
    xsizes = [1,2,3,4]
    ysizes = [1,2,3,4]
    zsizes = [1,2,3,4]
    retlist = []
    if limited:
        xy = [(1,1), (2,2), (3,3), (4,4), (2,4), (4,2)]
        for x,y in xy:
            for z in zsizes:
                retlist.append((x,y,z))
    else:
        for x in xsizes:
            for y in ysizes:
                for z in zsizes:
                    retlist.append((x,y,z))
    return retlist

def coords(limited=False):
    if limited:
        return [(1,1), (2,2), (3,3), (4,4), (2,4), (4,2)]
    xsizes = [1,2,3,4]
    ysizes = [1,2,3,4]
    retlist = []
    for x in xsizes:
        for y in ysizes:
            retlist.append((x,y))
    return retlist

def minimal_coords(ones=True):
    if ones:
        return [(1,1), (2,1), (2,2), (3,1), (3,3), (4,1), (4,2), (4,4)]
    return [(2,2), (3,3), (4,2), (4,4)]

def corner_coords(ones=True):
    if ones:
        return [(1,1), (2,2), (3,3), (4,4)]
    return [(2,2), (3,3), (4,4)]

def connections():
    return [
        # dirname, active, connectors, connector_setting, magnet_setting, options, kv 
        ("magnetic+flex", True, ["magnetic"], None, "flex_magnetic", "flex", {}),
        ("openlock", True, ["openlock"], "triplex", None, None, {"topless": "false"}),
        #("openlock+topless", True, ["openlock"], "openlock", None, "topless", {"topless": "true"}),
        ("openlock,magnetic+flex", True, ["openlock", "magnetic"], "openlock", "flex_magnetic", "flex", {"topless": "false"}),
        ("openlock,magnetic+topless,flex", True, ["openlock", "magnetic"], "openlock_topless", "flex_magnetic", "topless,flex", {"topless": "true"}),
        #("infinitylock", True, ["infinitylock"], "infinitylock", None, None, {}),
        #("infinitylock,magnetic+flex", True, ["infinitylock", "magnetic"], "infinitylock", "flex_magnetic", "flex", {}),
        ("dragonlock", True, ["dragonlock"], "dragonlock", None, None, {}),
        ("dragonlock,magnetic+flex", True, ["dragonlock", "magnetic"], "dragonlock", "flex_magnetic", "flex", {}),
    ]

def curved_connections():
    return [
        # dirname, active, connectors, connector_setting, magnet_setting, options, kv 
        ("magnetic+flex", True, ["magnetic"], None, "flex_magnetic", "flex", {}),
        ("openlock", True, ["openlock"], "openlock", None, None, {"topless": "false"}),
        #("openlock+topless", True, ["openlock"], "openlock", None, "topless", {"topless": "true"}),
        ("openlock,magnetic+flex", True, ["openlock", "magnetic"], "openlock", "flex_magnetic", "flex", {"topless": "false"}),
        ("openlock,magnetic+topless,flex", True, ["openlock", "magnetic"], "openlock_topless", "flex_magnetic", "topless,flex", {"topless": "true"}),
        #("infinitylock", True, ["infinitylock"], "infinitylock", None, None, {}),
        #("infinitylock,magnetic+flex", True, ["infinitylock", "magnetic"], "infinitylock", "flex_magnetic", "flex", {}),
        ("dragonlock", True, ["dragonlock"], "dragonlock", None, None, {}),
        ("dragonlock,magnetic+flex", True, ["dragonlock", "magnetic"], "dragonlock", "flex_magnetic", "flex", {}),
    ]

def wall_lock_connections():
    return [
        # dirname, active, connectors, connector_setting, magnet_setting, options, kv 
        ("openlock,magnetic+flex", True, ["openlock", "magnetic"], "openlock", "flex_magnetic", "flex", {"topless": "false"}),
        ("openlock,magnetic+topless,flex", True, ["openlock", "magnetic"], "openlock_topless", "flex_magnetic", "topless,flex", {"topless": "true"}),
        #("infinitylock,magnetic+flex", True, ["infinitylock", "magnetic"], "infinitylock", "flex_magnetic", "flex", {}),
        ("dragonlock,magnetic+flex", True, ["dragonlock", "magnetic"], "dragonlock", "flex_magnetic", "flex", {}),
    ]

def riser_connections():
    return [
        # dirname, active, connector, title, kv
        ("openlock", True, "openlock", "openlock", {}),
        #("infinitylock", True, "infinitylock", "infinitylock", {}),
        ("dragonlock", True, "dragonlocktriplex", "dragonlock", {}),
    ]

def riser_names(z):
    if z == 1:
        return "platform"
    elif z == 2:
        return "low"
    elif z == 3:
        return "medium"
    elif z == 4:
        return "high"
    assert False, "z can only be 1-4"

def riser_generate(coords, connections, shape, fxn, scad, **kwargs):
    def _run(fn, **kwargs):
        kwargs['x'] = x
        kwargs['y'] = y
        kwargs['z'] = z
        kwargs['lock'] = connector
        filename = fn + ".%s" % title
        filename += ".stl"
        filename = "/".join([path, filename])
        fxn(filename, scad, **kwargs)

    for connection in connections:
        dirname, active, connector, title, kv = connection
        kwargs.update(kv)
        for x, y, z in coords:
            shapename = shape
            size = "%sx%s" % (x,y)
            if 'large' in kwargs:
                size += ",%s" % kwargs['large']
            if 'notch' in kwargs:
                shapename += ",notch"
            shapename += ",%s" % riser_names(z)
            if active:
                print("%s/plain#riser+%s.%s.%s" % (dirname, shapename, size, title))
                path = make_folder("inch", "plain", "%s+riser" % shape, dirname)
                fn = "plain#riser+%s.%s" % (shapename, size)
                _run(fn, **kwargs)

def generate(coords, connections, shape, fxn, scad, flip=False, **kwargs):
    def _run(fn, connectors, magnet_priority, **kwargs):
        kwargs['x'] = x
        kwargs['y'] = y
        kwargs['connector_setting'] = connector_setting
        kwargs['magnet_setting'] = magnet_setting
        kwargs['magnet_priority'] = magnet_priority
        filename = fn + ".%s" % ",".join(connectors)
        if options:
            filename += "+%s" % options
        filename += ".stl"
        filename = "/".join([path, filename])
        fxn(filename, scad, **kwargs)

    for connection in connections:
        dirname, active, connectors, connector_setting, magnet_setting, options, kv = connection
        kwargs.update(kv)
        for x, y in coords:
            shapename = shape
            size = "%sx%s" % (x,y)
            if 'large' in kwargs:
                size += ",%s" % kwargs['large']
            if 'notch' in kwargs:
                shapename += ",notch"
            if 'wall_locks' in kwargs:
                shapename += ",wall_locks"
            print("%s/plain#base+%s.%s.%s+%s" % (dirname, shapename, size, ",".join(connectors), options))
            if active:
                path = make_folder("inch", "plain", shape, dirname)
                fn = "plain#base+%s.%s" % (shapename, size)
                if len(connectors) > 1:
                    if x == 1 or y == 1 or flip:
                        _run(fn, connectors, "lock", **kwargs)
                        _run(fn, connectors[::-1], "magnets", **kwargs)
                    else:
                        _run(fn, connectors, "magnets", **kwargs)
                else:
                    _run(fn, connectors, "magnets", **kwargs)

def curved_radial_generate(coords, connections, shape, fxn, scad, full=False, **kwargs):
    def _run(fn, connectors, magnet_priority, **kwargs):
        kwargs['x'] = x
        kwargs['cut'] = cut
        kwargs['angle'] = angle
        kwargs['id'] = id
        kwargs['od'] = od
        kwargs['connector_setting'] = connector_setting
        kwargs['magnet_setting'] = magnet_setting
        kwargs['magnet_priority'] = magnet_priority
        filename = fn + ".%s" % ",".join(connectors)
        if options:
            filename += "+%s" % options
        filename += ".stl"
        filename = "/".join([path, filename])
        fxn(filename, scad, **kwargs)

    for connection in connections:
        dirname, active, connectors, connector_setting, magnet_setting, options, kv = connection
        kwargs.update(kv)
        for x, cut, angle, id, od in coords:
            shapename = shape
            if full:
                size = "%sx%s" % (x,x)
            else:
                size = "%sx%s°" % (x,angle)
            print("%s/plain#base+%s.%s.%s+%s" % (dirname, shapename, size, ",".join(connectors), options))
            if active:
                path = make_folder("inch", "plain", shape, dirname)
                fn = "plain#base+%s.%s" % (shapename, size)
                _run(fn, connectors, "magnets", **kwargs)

def curved_inverted_generate(coords, connections, shape, fxn, scad, large=False, **kwargs):
    def _run(fn, connectors, magnet_priority, **kwargs):
        kwargs['x'] = x
        kwargs['cut'] = cut
        kwargs['id'] = id
        kwargs['connector_setting'] = connector_setting
        kwargs['magnet_setting'] = magnet_setting
        kwargs['magnet_priority'] = magnet_priority
        filename = fn + ".%s" % ",".join(connectors)
        if options:
            filename += "+%s" % options
        filename += ".stl"
        filename = "/".join([path, filename])
        fxn(filename, scad, **kwargs)

    for connection in connections:
        dirname, active, connectors, connector_setting, magnet_setting, options, kv = connection
        kwargs.update(kv)
        for x, cut, id, in coords:
            shapename = shape
            size = "%sx%s+%sr" % (x,x,cut)
            print("%s/plain#base+%s.%s.%s+%s" % (dirname, shapename, size, ",".join(connectors), options))
            if active:
                path = make_folder("inch", "plain", shape, dirname)
                if large:
                    for l in ["a", "b", "c"]:
                        fn = "plain#base+%s,%s.%s" % (shapename, l, size)
                        kwargs['large'] = l
                        _run(fn, connectors, "lock", **kwargs)
                else:
                    fn = "plain#base+%s.%s" % (shapename, size)
                    _run(fn, connectors, "lock", **kwargs)

def hex_generate(sizes, connections, shape, fxn, scad, **kwargs):
    def _run(fn, connectors, magnet_priority, **kwargs):
        kwargs['size'] = size
        kwargs['connector_setting'] = connector_setting
        kwargs['magnet_setting'] = magnet_setting
        kwargs['magnet_priority'] = magnet_priority
        filename = fn + ".%s" % ",".join(connectors)
        if options:
            filename += "+%s" % options
        filename += ".stl"
        filename = "/".join([path, filename])
        fxn(filename, scad, **kwargs)
    
    for connection in connections:
        dirname, active, connectors, connector_setting, magnet_setting, options, kv = connection
        kwargs.update(kv)
        for size in sizes:
            if shape == 'hex':
                shapename = "60°"
            else:
                shapename = shape
            print("%s/plain#base+%s.%sx.%s+%s" % (dirname, shapename, size, ",".join(connectors), options))
            if active:
                path = make_folder("inch", "plain", shapename, dirname)
                fn = "plain#base+%s.%sx" % (shapename, size)
                if len(connectors) > 1:
                    _run(fn, connectors, "magnets", **kwargs)
                else:
                    _run(fn, connectors, "magnets", **kwargs)

def generate_curved_std():
    generate(coords(True), curved_connections(), "curved", run_openscad, "bases#curved.scad")
    generate([(4,4)], curved_connections(), "curved", run_openscad, "bases#curved.scad", notch="true", notch_x=2, notch_y=2)

def generate_curved_large():
    generate([(6,6)], curved_connections(), "curved", run_openscad_large_curved, "bases#curved.scad", flip=True, large="a")
    generate([(8,8)], curved_connections(), "curved", run_openscad_large_curved, "bases#curved.scad", large="a")
    generate([(6,6), (8,8)], curved_connections(), "curved", run_openscad_large_curved, "bases#curved.scad", large="b")
    generate([(6,6)], curved_connections(), "curved", run_openscad_large_curved, "bases#curved.scad", flip=True, large="c")
    generate([(8,8)], curved_connections(), "curved", run_openscad_large_curved, "bases#curved.scad", large="c")

def generate_curved_radial():
    curved_radial_generate([(2,0,90,0,3), (4,0,90,0,3)], curved_connections(), "curved", run_openscad_curved_radial, "bases#curved,radial.scad", full=True)
    curved_radial_generate([(4,2,90,3,3), (4,2,45,1,1), (4,2,22.5,0,0)], curved_connections(), "curved,radial", run_openscad_curved_radial, "bases#curved,radial.scad")
    curved_radial_generate([(6,4,45,3,3), (6,4,22.5,1,1), (6,4,11.25,0,0)], curved_connections(), "curved,radial", run_openscad_curved_radial, "bases#curved,radial.scad")

def generate_curved_inverted():
    curved_inverted_generate([(3,2,3), (5,4,3)], curved_connections(), "curved,inverted", run_openscad_curved_inverted, "bases#curved+inverted.scad")
    curved_inverted_generate([(7,6,3)], curved_connections(), "curved,inverted", run_openscad_curved_inverted, "bases#curved+inverted.scad", large=True)

def generate_squares():
    generate(coords(), connections(), "square", run_openscad, "bases_square.scad")
    generate([(3,3)], connections(), "square", run_openscad, "bases_square.scad", flip=True, notch="true", notch_x=2, notch_y=2)
    generate([(4,4)], connections(), "square", run_openscad, "bases_square.scad", flip=True, notch="true", notch_x=2, notch_y=2)

def generate_square_s2w_wall():
    generate(minimal_coords(ones=False), wall_lock_connections(), "square+s2w,wall", run_openscad, "bases#square+wall.scad", wall_locks="true")
    generate(minimal_coords(ones=False), connections(), "square+s2w,wall", run_openscad, "bases#square+wall.scad")

def generate_square_s2w_corner():
    generate(minimal_coords(ones=False), wall_lock_connections(), "square+s2w,wall", run_openscad, "bases#square+wall.scad", wall_locks="true")
    generate(minimal_coords(ones=False), connections(), "square+s2w,wall", run_openscad, "bases#square+wall.scad")

def generate_hexes():
    hex_generate(hex_coords(), connections(), "hex", run_openscad_hex, "bases#hex.scad")

def generate_square_risers():
    riser_generate(riser_coords(), riser_connections(), "square", run_openscad_risers, "risers_square.scad")

def generate_curved_risers():
    riser_generate(riser_coords(True), riser_connections(), "curved", run_openscad_risers, "risers_curved.scad")

def generate_bases(options, args):
    def _runme(names, fxn):
        if len(args) == 0:
            return fxn()
        for name in names:
            if name in args:
                return fxn()

    _runme(["squares"], generate_squares)
    _runme(["square_s2w", "square_s2w.wall"], generate_square_s2w_wall)
    _runme(["square_s2w", "square_s2w.corner"], generate_square_s2w_corner)
    _runme(["hexes"], generate_hexes)
    _runme(["curved", "curved.std"], generate_curved_std)
    _runme(["curved", "curved.large"], generate_curved_large)
    _runme(["curved", "curved.radial"], generate_curved_radial)
    _runme(["curved", "curved.inverted"], generate_curved_inverted)
    _runme(["risers", "risers.square"], generate_square_risers)
    _runme(["risers", "risers.curved"], generate_curved_risers)

def option_parser(usage):
	parser = OptionParser(usage=usage)
	return parser

def validate_args(args):
    shapes = [
        "squares",
        "square_s2w",
        "square_s2w.wall",
        "square_s2w.corner",
        "hexes",
        "curved",
        "curved.std",
        "curved.large",
        "curved.std",
        "curved.radial",
        "curved.inverted",
        "risers"
        "risers.square",
        "risers.curved"
    ]
    for arg in args:
        if arg not in shapes:
            print("Invalid shape: %s" % arg)
            sys.exit(1)

def main():
    usage = "usage: %prog [options] [filenames]\nGenerates bases"
    parser = OptionParser(usage=usage)
    (options, args) = parser.parse_args()
    validate_args(args)
    generate_bases(options, args)

if __name__ == "__main__":
	sys.exit(main())
