## Code format requirement

[clang-format](https://clang.llvm.org/docs/ClangFormat.html) is a often used tool to check C++ code format.
This repo provided a recommended [.clang-format](../.clang-format) configure file
For check code format with clang-format, following command can be used

```shell
find src test  -regex ".*\\.\\(cpp\\|hpp\\|c\\|h\\)" | xargs clang-format -style=file --Werror --dry-run
```

## Code static checker

[clang-tidy](https://clang.llvm.org/extra/clang-tidy/) is a often used C++ code static checker. "Its purpose is to provide an extensible framework for diagnosing and fixing typical programming errors, like style violations, interface misuse, or bugs that can be deduced via static analysis. clang-tidy is modular and provides a convenient interface for writing new checks" by LLVM

CMake already support [enable clang-tidy during build](https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_CLANG_TIDY.html)

This project also provided a recommended [.clang-tidy](../.clang-tidy) configure file

Following code is an example of using clang-tidy in CMakeLists.txt

```cmake
set(CMAKE_CXX_CLANG_TIDY clang-tidy --config-file ${CMAKE_CURRENT_LIST_DIR}/.clang-tidy "--header-filter=${CMAKE_CURRENT_LIST_DIR}/(src|tests)/.*")
```

## Code dynamic checker

[Address sanitizer](https://clang.llvm.org/docs/AddressSanitizer.html) is a feature of GCC and Clang to check memory related misbehavior, such as dangling pointer, memory leak.

This can be enabled by add a compile flag in cmake

```cmake
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address")
```

## Github action

Setup a [github action](https://docs.github.com/en/actions) to ensure code quality

1.  trigger on PR.
2.  check clang-format.
3.  build by cmake with clang-tidy enabled.
4.  build with address sanitizer enabled and run test.
