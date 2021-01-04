from conans import ConanFile

required_conan_version = ">=1.28"

class IntegrationConan(ConanFile):
    name = "integration"
    version = "3.0.0"
    keep_imports = True
    options = {
        "my_option": "ANY"
    }
    default_options = {
        "my_option": "value0"
    }

    requires = "comp-a/[>0.0]@mjb6/testing", "comp-b/[>0.0]@mjb6/testing"

    def imports(self):
        self.copy("*", dst="target_delivery/a", root_package="comp-a*")
        self.copy("*", dst="target_delivery/b", root_package="comp-b*")

    def package(self):
        self.copy("*")

