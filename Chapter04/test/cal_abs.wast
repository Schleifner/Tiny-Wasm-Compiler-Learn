(module
  (func $abs (param $x i32) (result i32)

    ;; Check if the number is negative

    (i32.lt_s (local.get $x) (i32.const 0))

    ;; If negative, return the negation of the number
    (if (result i32)

      (then
        (i32.sub (i32.const 0) (local.get $x))
      )
      ;; Else, return the number itself
      (else
        (local.get $x)
      )
    )
  )
  (export "abs" (func $abs))
)

(assert_return (invoke "abs" (i32.const -1)) (i32.const 1))
(assert_return (invoke "abs" (i32.const 1)) (i32.const 1))
