# GLFW packaged for the Zig build system

This is a fork of [glfw](https://github.com/glfw/glfw), packaged for Zig. Unnecessary files have been deleted, and the build system has been replaced with build.zig.

_Looking for Zig bindings to GLFW?_ See [zlfw](https://github.com/Batres3/zlfw).

## Usage
```
git clone https://github.com/Batres3/glfw/
cd glfw
zig build
```

If you would like to integrate this into your own project, it is as simple as adding the dependency to `build.zig.zon`,
and adding the following to your `build.zig`
```
const glfw = b.dependency("glfw", .{
    .target = target,
    .optimize = optimize,
    // Additional options here
});

your_module.linkLibrary(glfw.artifact("glfw"));

```
By default, the the library adds the `include/` folder as an include path, meaning that you may access `glfw3.h` via `GLFW/glfw3.h`, however,
if you would like access to the files in `src/` you must add the `include_src` build option.
## Updating

To update this repository, run `./update.sh` followed by `./verify.sh` to verify the repository contents.

## Verifying repository contents

For supply chain security reasons (e.g. to confirm we made no patches to the code) we provide a `git diff` command you can run to verify the contents of this repository:

```sh
./verify.sh
```

If nothing is printed, there is no diff. Deleted files, and changes to `README.md`, `build.zig`, `.github` CI files and `.gitignore` are ignored.

## Dependencies
Technically, glfw has no _explicit_ dependencies and can, in theory, obtain all necessary code to compile directly from the user,
this would include things such as vulkan headers, wayland headers and so on. However, considering that one of the main selling points of zig
is the seamless cross compilation, it would defeat the point to use system dependencies, as such, the necessary files are included as dependencies
in `build.zig.zon`, of those dependencies, x11, wayland and vulkan, which are public, are simple forks of the sources.
On the other hand the macos dependencies are private, and can only be found on mac systems, I do not have access to one of these, so for
now I am using the [mach xcode repo](https://github.com/hexops/xcode-frameworks), which is maintained by the [mach](https://machengine.org/) team

However, I understand now wanting to depend on some other repo for dependencies to header file, therefore, I have added the `native` build option
which will simply ignore the dependencies and assume that the user will provide the appropriate headers. If you are building for your own system,
this method is entirely equivalent to the other one, however, you will not be able to cross-compile.

### Wayland
There is a caveat here for wayland, since it does not provide the headers files for many of its protocols, even when natively running wayland
if you would like to build it natively, you may use `wayland-scanner` to do so, see [wayland-headers](https://github.com/Batres3/wayland-headers/)
to see an example of how this is done.
