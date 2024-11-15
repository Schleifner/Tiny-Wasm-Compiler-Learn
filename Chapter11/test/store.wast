(module
  (memory 1)

  (func (export "as-block-value")
    (block (i32.store (i32.const 0) (i32.const 1)))
  )
  (func (export "as-loop-value")
    (loop (i32.store (i32.const 0) (i32.const 1)))
  )

  (func (export "as-br-value")
    (block (br 0 (i32.store (i32.const 0) (i32.const 1))))
  )
  (func (export "as-br_if-value")
    (block
      (br_if 0 (i32.store (i32.const 0) (i32.const 1)) (i32.const 1))
    )
  )
  (func (export "as-br_if-value-cond")
    (block
      (br_if 0 (i32.const 6) (i32.store (i32.const 0) (i32.const 1)))
    )
  )

  (func (export "as-return-value")
    (return (i32.store (i32.const 0) (i32.const 1)))
  )

  (func (export "as-if-then")
    (if (i32.const 1) (then (i32.store (i32.const 0) (i32.const 1))))
  )

  (func (export "as-if-else")
    (if (i32.const 0) (then) (else (i32.store (i32.const 0) (i32.const 1))))
  )

  (func (export "address-as-param") (param $index i32) (param $value i32)
    (i32.store (local.get $index) (local.get $value))
  )
)

(assert_return (invoke "as-block-value"))
(assert_return (invoke "as-loop-value"))

(assert_return (invoke "as-br-value"))
(assert_return (invoke "as-br_if-value"))
(assert_return (invoke "as-br_if-value-cond"))

(assert_return (invoke "as-return-value"))

(assert_return (invoke "as-if-then"))
(assert_return (invoke "as-if-else"))
(assert_trap (invoke "address-as-param" (i32.const 0xFFFFFF)(i32.const 0)) "out of bounds memory access")
(assert_trap (invoke "address-as-param" (i32.const 0xFFFE)(i32.const 0)) "out of bounds memory access")
