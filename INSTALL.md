## Building the Library

```shell
cmake -S . -B build
cmake --build build --config Release
```

[CMake options](https://raw.githubusercontent.com/KaiserLancelot/cpp-template/master/cmake/Options.cmake)

## Installing the Library

```shell
sudo cmake --build build --config Release --target install
```

## Usage with CMake

```cmake
add_subdirectory(klib)
```

or

```cmake
find_package(klib)
target_link_libraries(<your-target> PRIVATE klib::klib)
```
