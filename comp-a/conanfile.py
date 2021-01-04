import os
from conans import ConanFile

required_conan_version = ">=1.28"

class CompAConan(ConanFile):
    name = "comp-a"
    version = "1.0.0"
    exports_sources = "bin/*"
    options = {
        "my_option": "ANY",
    }
    default_options = {
        "my_option": "value0",
    }

    def package(self):
        self.copy("comp-a.txt", dst="20_bin", src="bin")
