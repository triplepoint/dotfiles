#!/usr/bin/env python3

import json
import re
import subprocess
import typing as T


def get_map_items_depedencies(str: bytes) -> T.Dict[str, T.List[str]]:
    ret = {}
    for x in str.splitlines():
        y = re.sub(r'\s+', ' ', x.decode('cp437'))
        items = y.strip().split(" ")
        if items[0]:
            item = items.pop(0)
            ret[item] = items
    return ret


def gen_map_dependencies_to_items(map_deps: T.Dict[str, T.List[str]]) -> T.Dict[str, T.List[str]]:
    ret: T.Dict[str, T.List[str]] = {}
    for item, deps in map_deps.items():
        ret[item] = []
        for item2, deps2 in map_deps.items():
            if item in deps2:
                ret[item].append(item2)
    return ret


def capture_brew_list_with_dependencies() -> bytes:
    brew_cmd = '''brew list --formula | while read cask; do /bin/echo -n $cask; brew deps $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done'''
    dep_str = subprocess.run(brew_cmd, shell=True, capture_output=True)
    return dep_str.stdout


def main():
    print("Capturing brew list...")
    dep_str = capture_brew_list_with_dependencies()
    print("Complete.")

    map_items_to_deps = get_map_items_depedencies(dep_str)
    map_deps_to_items = gen_map_dependencies_to_items(map_items_to_deps)

    not_dependencies: T.List[str] = []
    print("\n\nInstalled Item: Packages that Depend on It")
    for item, deps in map_deps_to_items.items():
        print("{}: {}".format(item, deps))
        if deps == []:
            not_dependencies.append(item)

    print("\n\nPackages that aren't dependencies of other packages:")
    for item in not_dependencies:
        try:
            result = subprocess.run(['brew', 'info', item, '--json=v1'], capture_output=True)
            json_info = json.loads(result.stdout)
            print("{}: {}".format(item, json_info[0]['desc']))
        except Exception as e:
            print("{}: *** Error getting description: {}".format(item, e))


if __name__ == "__main__":
    main()
