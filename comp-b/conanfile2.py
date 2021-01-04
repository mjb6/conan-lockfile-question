import os
from conans import ConanFile

required_conan_version = ">=1.28"

class CompBConan(ConanFile):
    name = "comp-b"
    version = "2.1.0"
    exports_sources = "bin/*"
    options = {
        "my_option": "ANY",
    }
    default_options = {
        "my_option": "value0",
    }

    def package(self):
        self.copy("comp-b.txt", dst="20_bin", src="bin")
