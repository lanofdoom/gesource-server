load("@io_bazel_rules_docker//container:container.bzl", "container_image", "container_layer", "container_push")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")
load("@com_github_lanofdoom_steamcmd//:defs.bzl", "steam_depot_layer")

#
# Source Dedicated Server Layer
#

steam_depot_layer(
    name = "srcds",
    app = "205",
    directory = "/opt/game",
    os = "windows",
)

#
# Source SDK Base 2007 Layer
#

steam_depot_layer(
    name = "sdk",
    app = "310",
    directory = "/opt/game",
    os = "windows",
)

#
# GoldenEye: Source Layer
#

container_image(
    name = "goldeneye_image",
    base = "@base_image//image",
    directory = "/",
    files = [
        "@goldeneye//file",
    ],
)

container_run_and_extract(
    name = "goldeneye_convert",
    image = ":goldeneye_image.tar",
    commands = [
        "apt update && apt install -y p7zip-full",
        "cd /opt",
        "7z x /goldeneye.7z",
        "tar -czf /goldeneye.tar.gz gesource"
    ],
    extract_file = "/goldeneye.tar.gz",
)

container_layer(
    name = "goldeneye",
    directory = "/opt/game",
    tars = [
        ":goldeneye_convert/goldeneye.tar.gz",
    ],
)

#
# MetaMod Layer
#

container_layer(
    name = "metamod",
    data_path = "./../metamod",
    directory = "/opt/game/gesource",
    files = [
        "@metamod//:all",
    ],
)

#
# SourceMod Layer
#

container_layer(
    name = "sourcemod",
    data_path = "./../sourcemod",
    directory = "/opt/game/gesource",
    files = [
        "@sourcemod//:all",
    ],
)

#
# Authorization Layer
#

container_layer(
    name = "authorization",
    data_path = "./../auth_by_steam_group",
    directory = "/opt/game/gesource",
    files = [
        "@auth_by_steam_group//:all",
    ],
)

#
# Config Layer
#

container_layer(
    name = "config",
    directory = "/opt/game/gesource/cfg/templates",
    files = [
        ":server.cfg",
    ],
)

#
# Server Base Image
#

download_pkgs(
    name = "server_deps",
    image_tar = "@base_image//image",
    packages = [
        "ca-certificates",
        "wine",
        "xvfb",
    ],
)

install_pkgs(
    name = "server_base",
    image_tar = "@base_image//image",
    installables_tar = ":server_deps.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "server_base",
)

#
# Build Final Image
#

container_image(
    name = "server_image",
    base = ":server_base",
    entrypoint = ["/entrypoint.sh"],
    env = {
        "GE_ADMIN": "",
        "GE_HOSTNAME": "",
        "GE_MAP": "ge_temple_classic",
        "GE_MOTD": "",
        "GE_PASSWORD": "",
        "GE_PORT": "27015",
        "RCON_PASSWORD": "",
        "STEAM_GROUP_ID": "",
        "STEAM_API_KEY": "",
    },
    files = [
        ":entrypoint.sh",
    ],
    layers = [
        ":srcds",
        ":sdk",
        ":goldeneye",
        ":metamod",
        ":sourcemod",
        ":authorization",
        ":config",
    ],
)

container_push(
    name = "push_server_image",
    format = "Docker",
    image = ":server_image",
    registry = "ghcr.io",
    repository = "lanofdoom/gesource-server",
    tag = "latest",
)