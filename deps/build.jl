using BinDeps

@BinDeps.setup

libspg = library_dependency("libsymspg")
provides(Sources, URI("https://sourceforge.net/projects/spglib/files/spglib/spglib-1.9/spglib-1.9.4.tar.gz"), libspg)
provides(BuildProcess, Autotools(libtarget = joinpath("src", "libsymspg.la")), libspg)
@BinDeps.install Dict(:libsymspg => :spglib)
