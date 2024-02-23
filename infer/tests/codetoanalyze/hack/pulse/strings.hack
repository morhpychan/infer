// Copyright (c) Facebook, Inc. and its affiliates.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

namespace StringTests;

class Main {

  // generates $builtins.hhbc_cast_string
  public static function cast_test(mixed $arg): string {
    return (string)$arg;
  }

  // generates $builtins.hhbc_is_type_str
  public static function is_test(mixed $arg): string {
    if ($arg is string) {
      return $arg;
    } else {
      return "";
    }
  }

  // generates $builtins.hhbc_concat
  public static function concat_test(string $arg1, string $arg2): string {
    return $arg1.$arg2;
  }

}

class Tests {

  public static function cast_bad(): void {
    $msg = "hello";
    if (Main::cast_test($msg) == $msg) {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function cast_v1_ok(): void {
    $msg = "hello";
    if (Main::cast_test($msg) != $msg) {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function cast_v2_ok(): void {
    $msg = "hello";
    if (Main::cast_test($msg) == "hello!") {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function is_v1_bad(): void {
    $msg = "hello";
    if (Main::is_test($msg) == $msg) {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function is_v2_bad(): void {
    if (Main::is_test(0) == "") {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function is_v1_ok(): void {
    $msg = "hello";
    if (Main::is_test($msg) != $msg) {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function is_v2_ok(): void {
    if (Main::is_test(0) != "") {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function concat_bad(): void {
    if (Main::concat_test("hello", "world") == "helloworld") {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

  public static function FP_concat_ok(): void {
    if (Main::concat_test("hello", "world") == "hello world") {
      \Level1\taintSink(\Level1\taintSource());
    }
  }

}
