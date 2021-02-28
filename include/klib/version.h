/**
 * @file version.h
 * @brief Contains the declaration of the macro
 */

#pragma once

/**
 * @brief klib major verion
 */
#define KLIB_VER_MAJOR 2

/**
 * @brief klib minor version
 */
#define KLIB_VER_MINOR 9

/**
 * @brief klib patch version
 */
#define KLIB_VER_PATCH 1

/**
 * @brief klib version
 */
#define KLIB_VERSION \
  (KLIB_VER_MAJOR * 10000 + KLIB_VER_MINOR * 100 + KLIB_VER_PATCH)
