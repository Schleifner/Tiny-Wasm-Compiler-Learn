(module
  (func $abs (param $x i32) (result i32)
    (block $return
      ;; Check if the number is non-negative
      local.get $x
      i32.const 0
      i32.ge_s
      br_if $return

      ;; If the number is negative, return its negation
      i32.const 0
      local.get $x
      i32.sub
      return
    )
    ;; If the number is non-negative, return it as is
    local.get $x
  )
  (export "abs" (func $abs))
)

(assert_return (invoke "abs" (i32.const -1)) (i32.const 1))
(assert_return (invoke "abs" (i32.const 1)) (i32.const 1))
(assert_return (invoke "abs" (i32.const 0)) (i32.const 0))
(assert_return (invoke "abs" (i32.const -123)) (i32.const 123))
(assert_return (invoke "abs" (i32.const 2147483647)) (i32.const 2147483647))
(assert_return (invoke "abs" (i32.const -2147483648)) (i32.const -2147483648))
