# Copyright (c) 2024, NVIDIA CORPORATION.

import pytest


def pytest_collection_modifyitems(config, items):
    if (
        config.pluginmanager.hasplugin("xdist")
        and config.getoption("--dist") == "worksteal"
    ):
        serial_modules = config.getini("serial_modules")
        for item in items:
            if item.module.__name__ in serial_modules:
                item.add_marker(pytest.mark.shard_count(1))
