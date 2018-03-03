{{#if with_docs ~}}
# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used along with `$pkg_origin`,
# and `$pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
$pkg_name="{{ pkg_name }}"

# Required unless overridden by the `HAB_ORIGIN` environment variable.
# The origin is used to denote a particular upstream of a package.
$pkg_origin="{{ pkg_origin }}"

# Required.
# Sets the version of the package
{{#if pkg_version ~}}
$pkg_version="{{ pkg_version }}"
{{else ~}}
$pkg_version="0.1.0"
{{/if}}

# Optional.
# The name and email address of the package maintainer.
{{#if pkg_maintainer ~}}
$pkg_maintainer="{{ pkg_maintainer }}"
{{else ~}}
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
{{/if}}

# Optional.
# An array of valid software licenses that relate to this package.
# Please choose a license from http://spdx.org/licenses/
{{#if pkg_license ~}}
$pkg_license="{{ pkg_license }}"
{{else ~}}
$pkg_license=@("Apache-2.0")
{{/if}}

# Optional.
# A URL that specifies where to download the source from. Any valid wget url
# will work. Typically, the relative path for the URL is partially constructed
# from the pkg_name and pkg_version values; however, this convention is not
# required.
{{#if pkg_source ~}}
$pkg_source="{{ pkg_source }}"
{{else ~}}
# $pkg_source="http://some_source_url/releases/$pkg_name-$pkg_version.zip"
{{/if}}

# Optional.
# The resulting filename for the download, typically constructed from the
# pkg_name and pkg_version values.
{{#if pkg_filename ~}}
$pkg_filename="{{ pkg_filename }}"
{{else ~}}
# $pkg_filename="$pkg_name-$pkg_version.zip"
{{/if}}

# Required if a valid URL is provided for pkg_source or unless Invoke-Verify is overridden.
# The value for pkg_shasum is a sha-256 sum of the downloaded pkg_source. If you
# do not have the checksum, you can easily generate it by downloading the source
# and using Get-FileHash. Also, if you do not have
# Invoke-Verify overridden, and you do not have the correct sha-256 sum, then the
# expected value will be shown in the build output of your package.
{{#if pkg_shasum ~}}
$pkg_shasum="{{ pkg_shasum }}"
{{else ~}}
$pkg_shasum="TODO"
{{/if}}

# Optional.
# An array of package dependencies needed at runtime. You can refer to packages
# at three levels of specificity: `origin/package`, `origin/package/version`, or
# `origin/package/version/release`.
{{#if pkg_deps ~}}
$pkg_deps={{ pkg_deps }}
{{else ~}}
$pkg_deps=@()
{{/if}}

# Optional.
# An array of the package dependencies needed only at build time.
{{#if pkg_build_deps ~}}
$pkg_build_deps={{ pkg_build_deps }}
{{else ~}}
$pkg_build_deps=@()
{{/if}}

# Optional.
# An array of paths, relative to the final install of the software, where
# libraries can be found for native builds.
{{#if pkg_lib_dirs ~}}
$pkg_lib_dirs={{ pkg_lib_dirs }}
{{else ~}}
# $pkg_lib_dirs=@("lib")
{{/if}}

# Optional.
# An array of paths, relative to the final install of the software, where
# headers can be found.
{{#if pkg_include_dirs ~}}
$pkg_include_dirs={{ pkg_include_dirs }}
{{else ~}}
# $pkg_include_dirs=@("include")
{{/if}}

# Optional.
# An array of paths, relative to the final install of the software, where
# binaries can be found. Used to populate $ENV:PATH for software that depends on
# your package.
{{#if pkg_bin_dirs ~}}
$pkg_bin_dirs={{ pkg_bin_dirs }}
{{else ~}}
# $pkg_bin_dirs=@("bin")
{{/if}}

# Optional.
# The command for the Supervisor to execute when starting a service. You can
# omit this setting if your package is not intended to be run directly by a
# Supervisor of if your plan contains a run hook in hooks/run.
{{#if pkg_svc_run ~}}
$pkg_svc_run="{{ pkg_svc_run }}"
{{else ~}}
# $pkg_svc_run="MyBinary.exe"
{{/if}}

# Optional.
# A hashtable representing configuration data which should be gossiped to peers. The keys
# in this hashtable represent the name the value will be assigned and the values represent the toml path
# to read the value.
{{#if pkg_exports ~}}
$pkg_exports={{ pkg_exports }}
{{else ~}}
# $pkg_exports=@{
#   host="srv.address"
#   port="srv.port"
#   ssl-port="srv.ssl.port"
# }
{{/if}}

# Optional.
# An array of `$pkg_exports` keys containing default values for which ports that this package
# exposes. These values are used as sensible defaults for other tools. For example, when exporting
# a package to a container format.
{{#if pkg_exposes ~}}
$pkg_exposes={{ pkg_exposes }}
{{else ~}}
# $pkg_exposes=@("port," "ssl-port")
{{/if}}

# Optional.
# A hashtable representing services which you depend on and the configuration keys that
# you expect the service to export (by their `$pkg_exports`). These binds *must* be set for the
# Supervisor to load the service. The loaded service will wait to run until it's bind becomes
# available. If the bind does not contain the expected keys, the service will not start
# successfully.
{{#if pkg_binds ~}}
$pkg_binds={{ pkg_binds }}
{{else ~}}
# $pkg_binds=@{
#   database="port host"
# }
{{/if}}

# Optional.
# Same as `$pkg_binds` but these represent optional services to connect to.
{{#if pkg_binds_optional ~}}
$pkg_binds_optional={{ pkg_binds_optional }}
{{else ~}}
# $pkg_binds_optional=@{
#   storage="port host"
# }
{{/if}}

# Required for core plans, optional otherwise.
# A short description of the package. It can be a simple string, or you can
# create a multi-line description using markdown to provide a rich description
# of your package.
{{#if pkg_description ~}}
$pkg_description="{{ pkg_description }}"
{{else ~}}
# $pkg_description="Some description."
{{/if}}

# Required for core plans, optional otherwise.
# The project home page for the package.
{{#if pkg_upstream_url ~}}
$pkg_upstream_url="{{ pkg_upstream_url }}"
{{else ~}}
# $pkg_upstream_url="http://example.com/project-name"
{{/if}}

{{#if with_callbacks ~}}
# Callback Functions
#
# When defining your plan, you have the flexibility to override the default
# behavior of Habitat in each part of the package building stage through a
# series of callbacks. To define a callback, simply create a shell function
# of the same name in your plan.sh file and then write your script. If you do
# not want to use the default callback behavior, you must override the callback
# with an empty implementation in the function definition.
#
# Callbacks are defined here with either their "Invoke-DefaultX", if they have a
# default implementation, or empty if they have no default implementation. If callbacks do
# nothing or do the same as the default implementation, they can be removed from
# this template.
#
# The default implementations (the Invoke-Default* functions) are defined in the
# plan build script:
# https://github.com/habitat-sh/habitat/tree/master/components/plan-build-ps1/bin/hab-plan-build.ps1

# There is no default implementation of this callback. You can use it to execute
# any arbitrary commands before anything else happens.
function Invoke-Begin {}

# The default implementation is that the software specified in $pkg_source is
# downloaded, checksum-verified, and placed in $HAB_CACHE_SRC_PATH/$pkgfilename,
# which resolves to a path like /hab/cache/src/filename.zip. You should
# override this behavior if you need to change how your binary source is
# downloaded, if you are not downloading any source code at all, or if your are
# cloning from git. If you do clone a repo from git, you must override
# Invoke-Verify with an empty implementation.
function Invoke-Download {
  Invoke-DefaultDownload
}

# The default implementation tries to verify the checksum specified in the plan
# against the computed checksum after downloading the source zip to disk.
# If the specified checksum doesn't match the computed checksum, then an error
# and a message specifying the mismatch will be printed to stderr. You should
# not need to override this behavior unless your package does not download
# any files.
function Invoke-Verify {
  Invoke-DefaultVerify
}

# The default implementation removes the $HAB_CACHE_SRC_PATH/$pkg_dirname folder
# in case there was a previously-built version of your package installed on
# disk. This ensures you start with a clean build environment.
function Invoke-Clean {
  Invoke-DefaultClean
}

# The default implementation extracts your zipped source file into
# $HAB_CACHE_SRC_PATH.
function Invoke-Unpack {
  Invoke-DefaultUnpack
}

# There is no default implementation of this callback. At this point in the
# build process, the zipped source has been downloaded, unpacked, and the build
# environment variables have been set, so you can use this callback to perform
# any actions before the package starts building.
function Invoke-Prepare {}

# There is no default implementation of this callback. You should override this
# callback with the commands necessary to build your application.
function Invoke-Build {
  Invoke-DefaultBuild
}

# The default implementation runs nothing during post-compile. To use this callback, two
# conditions must be true. A) Invoke-Check function has been declared, B) DO_CHECK
# environment variable exists and set to true, $ENV:DO_CHECK=$true.
function Invoke-Check {}

# There is no default implementation of this callback. Typically you will override
# this callback to copy the compiled binaries or libraries in
# $HAB_CACHE_SRC_PATH/$pkg_dirname to $pkg_prefix.
function Invoke-Install {
  Invoke-DefaultInstall
}

# There is no default implementation of this callback. This is called after the
# package has been built and installed. You can use this callback to remove any
# temporary files or perform other post-install clean-up actions.
function Invoke-End {}
{{/if ~}}
{{else ~}}
$pkg_name="{{ pkg_name }}"
$pkg_origin="{{ pkg_origin }}"
{{#if pkg_version ~}}
$pkg_version="{{ pkg_version }}"
{{else ~}}
$pkg_version="0.1.0"
{{/if ~}}
{{#if pkg_maintainer ~}}
$pkg_maintainer="{{ pkg_maintainer }}"
{{else ~}}
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
{{/if~}}
{{#if pkg_license ~}}
$pkg_license={{ pkg_license }}
{{else ~}}
$pkg_license=@("Apache-2.0")
{{/if ~}}
{{#if scaffolding_ident ~}}
$pkg_scaffolding="{{ scaffolding_ident }}"
{{/if ~}}
{{#if pkg_source ~}}
$pkg_source="{{ pkg_source }}"
{{else ~}}
$pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.zip"
{{/if ~}}
{{#if pkg_filename ~}}
$pkg_filename="{{ pkg_filename }}"
{{else ~}}
# $pkg_filename="$pkg_name-$pkg_version.zip"
{{/if ~}}
{{#if pkg_shasum ~}}
$pkg_shasum="{{ pkg_shasum }}"
{{else ~}}
# $pkg_shasum="TODO"
{{/if ~}}
{{#if pkg_deps ~}}
$pkg_deps={{ pkg_deps }}
{{else ~}}
# $pkg_deps=@()
{{/if ~}}
{{#if pkg_build_deps ~}}
$pkg_build_deps={{ pkg_build_deps }}
{{else ~}}
# $pkg_build_deps=@()
{{/if ~}}
{{#if pkg_lib_dirs ~}}
$pkg_lib_dirs={{ pkg_lib_dirs }}
{{else ~}}
# $pkg_lib_dirs=@("lib")
{{/if ~}}
{{#if pkg_include_dirs ~}}
$pkg_include_dirs={{ pkg_include_dirs }}
{{else ~}}
# $pkg_include_dirs=@("include")
{{/if ~}}
{{#if pkg_bin_dirs ~}}
$pkg_bin_dirs={{ pkg_bin_dirs }}
{{else ~}}
# $pkg_bin_dirs=@("bin")
{{/if ~}}
{{#if pkg_svc_run ~}}
$pkg_svc_run="{{ pkg_svc_run }}"
{{else ~}}
# $pkg_svc_run="MyBinary.exe"
{{/if ~}}
{{#if pkg_exports ~}}
$pkg_exports={{ pkg_exports }}
{{else ~}}
# $pkg_exports=@{
#   host="srv.address"
#   port="srv.port"
#   ssl-port="srv.ssl.port"
# }
{{/if ~}}
{{#if pkg_exposes ~}}
$pkg_exposes={{ pkg_exposes }}
{{else ~}}
# $pkg_exposes=@("port", "ssl-port")
{{/if ~}}
{{#if pkg_binds ~}}
$pkg_binds={{ pkg_binds }}
{{else ~}}
# $pkg_binds=@{
#   database="port host"
# }
{{/if ~}}
{{#if pkg_binds_optional ~}}
$pkg_binds_optional={{ pkg_binds_optional }}
{{else ~}}
# $pkg_binds_optional=@{
#   storage="port host"
# }
{{/if ~}}
{{#if pkg_description ~}}
$pkg_description="{{ pkg_description }}"
{{else ~}}
# $pkg_description="Some description."
{{/if ~}}
{{#if pkg_upstream_url ~}}
$pkg_upstream_url="{{ pkg_upstream_url }}"
{{else ~}}
# $pkg_upstream_url="http://example.com/project-name"
{{/if ~}}
{{#if with_callbacks ~}}
function Invoke-Begin {}

function Invoke-Download {
  Invoke-DefaultDownload
}

function Invoke-Verify {
  Invoke-DefaultVerify
}

function Invoke-Clean {
  Invoke-DefaultClean
}

function Invoke-Unpack {
  Invoke-DefaultUnpack
}

function Invoke-Prepare {}

function Invoke-Build {
  Invoke-DefaultBuild
}

function Invoke-Check {}

function Invoke-Install {
  Invoke-DefaultInstall
}

function Invoke-End {}

{{/if ~}}
{{/if ~}}