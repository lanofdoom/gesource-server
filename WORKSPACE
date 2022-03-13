load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "59536e6ae64359b716ba9c46c39183403b01eabfbd57578e84398b4829ca499a",
    strip_prefix = "rules_docker-0.22.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.22.0/rules_docker-v0.22.0.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

#
# Steam Dependencies
#

http_archive(
    name = "com_github_lanofdoom_steamcmd",
    sha256 = "ba08a3cea3b1534bee6a6b1e625f34aa3c019d6f0cfb9bdeeade201f250776a1",
    strip_prefix = "steamcmd-bbeb7373f047aa3271d9f3442bc7985a6049f879",
    urls = ["https://github.com/lanofdoom/steamcmd/archive/bbeb7373f047aa3271d9f3442bc7985a6049f879.zip"],
)

load("@com_github_lanofdoom_steamcmd//:repositories.bzl", "steamcmd_repos")

steamcmd_repos()

load("@com_github_lanofdoom_steamcmd//:deps.bzl", "steamcmd_deps")

steamcmd_deps()

load("@com_github_lanofdoom_steamcmd//:nugets.bzl", "steamcmd_nugets")

steamcmd_nugets()

#
# Server Dependencies
#

http_archive(
    name = "auth_by_steam_group",
    sha256 = "2ce9f93038773affe8d7c7acc4fe156735f095f287889cafeb07fb78f512007d",
    urls = ["https://lanofdoom.github.io/auth-by-steam-group/releases/v2.3.0/auth_by_steam_group.zip"],
    build_file_content = "filegroup(name = \"all\", srcs = glob(include = [\"**/*\"], exclude = [\"WORKSPACE\", \"BUILD.bazel\"]), visibility = [\"//visibility:public\"])",
)

http_file(
    name = "goldeneye",
    downloaded_file_path = "goldeneye.7z",
    sha256 = "79643189e9d6549e13ed9545d2277cb34bac05fff645d44d9de1f0ab030610d3",
    urls = ["https://www.moddb.com/downloads/mirror/126201/124/30a55e00027a8849b7e7dc398862b20c/"],
)

http_archive(
    name = "metamod",
    sha256 = "764ef206a00768dc6810ff7344dfabd7b2d8ab4b3d426c5fad49d4818ac3228d",
    urls = ["https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1145-windows.zip"],
    build_file_content = "filegroup(name = \"all\", srcs = glob(include = [\"**/*\"], exclude = [\"WORKSPACE\", \"BUILD.bazel\"]), visibility = [\"//visibility:public\"])",
)

http_archive(
    name = "sourcemod",
    sha256 = "1361a2df2b98658c88adb1793fdc152926180ed6c04f7d36457b7de4f8c0c415",
    urls = ["https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6528-windows.zip"],
    build_file_content = "filegroup(name = \"all\", srcs = glob(include = [\"**/*\"], exclude = [\"WORKSPACE\", \"BUILD.bazel\"]), visibility = [\"//visibility:public\"])",
)

#
# Container Base Image
#

container_pull(
    name = "base_image",
    registry = "index.docker.io",
    repository = "i386/debian",
    tag = "bullseye-slim",
)
