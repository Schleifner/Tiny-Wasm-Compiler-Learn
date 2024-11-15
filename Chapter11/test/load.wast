(module
  (memory 1)

  (func (export "as-br-value") (result i32)
    (block (result i32) (br 0 (i32.load (i32.const 0))))
  )

  (func (export "as-br_if-cond")
    (block (br_if 0 (i32.load (i32.const 0))))
  )

  (func (export "as-br_if-value") (result i32)
    (block (result i32)
      (drop (br_if 0 (i32.load (i32.const 0)) (i32.const 1))) (i32.const 7)
    )
  )
  
  (func (export "as-br_if-value-cond") (result i32)
    (block (result i32)
      (drop (br_if 0 (i32.const 6) (i32.load (i32.const 0)))) (i32.const 7)
    )
  )

  (func (export "as-return-value") (result i32)
    (return (i32.load (i32.const 0)))
  )

  (func (export "as-if-cond") (result i32)
    (if (result i32) (i32.load (i32.const 0))
      (then (i32.const 0)) (else (i32.const 1))
    )
  )

  (func (export "as-if-then") (result i32)
    (if (result i32) (i32.const 1)
      (then (i32.load (i32.const 0))) (else (i32.const 0))
    )
  )

  (func (export "as-if-else") (result i32)
    (if (result i32) (i32.const 0)
      (then (i32.const 0)) (else (i32.load (i32.const 0)))
    )
  )

  
  (func (export "as-call-first") (result i32)
    (call $f (i32.load (i32.const 0)) (i32.const 2) (i32.const 3))
  )
  (func (export "as-call-mid") (result i32)
    (call $f (i32.const 1) (i32.load (i32.const 0)) (i32.const 3))
  )
  (func (export "as-call-last") (result i32)
    (call $f (i32.const 1) (i32.const 2) (i32.load (i32.const 0)))
  )

  (func $f (param i32 i32 i32) (result i32) (i32.const -1))


  (func (export "as-local.set-value") (local i32)
    (local.set 0 (i32.load (i32.const 0)))
  )
  (func (export "as-local.tee-value") (result i32) (local i32)
    (local.tee 0 (i32.load (i32.const 0)))
  )

  (global $g (mut i32) (i32.const 0))
  (func (export "as-global.set-value") (local i32)
    (global.set $g (i32.load (i32.const 0)))
  )

  (func (export "as-load-address") (result i32)
    (i32.load (i32.load (i32.const 0)))
  )
  (func (export "as-loadN-address") (result i32)
    (i32.load8_s (i32.load (i32.const 0)))
  )

  (func (export "as-store-address")
    (i32.store (i32.load (i32.const 0)) (i32.const 7))
  )
  (func (export "as-store-value")
    (i32.store (i32.const 2) (i32.load (i32.const 0)))
  )

  (func (export "as-storeN-address")
    (i32.store8 (i32.load8_s (i32.const 0)) (i32.const 7))
  )
  (func (export "as-storeN-value")
    (i32.store16 (i32.const 2) (i32.load (i32.const 0)))
  )

  (func (export "as-unary-operand") (result i32)
    (i32.clz (i32.load (i32.const 100)))
  )

  (func (export "as-binary-left") (result i32)
    (i32.add (i32.load (i32.const 100)) (i32.const 10))
  )
  (func (export "as-binary-right") (result i32)
    (i32.sub (i32.const 10) (i32.load (i32.const 100)))
  )

  (func (export "as-test-operand") (result i32)
    (i32.eqz (i32.load (i32.const 100)))
  )

  (func (export "as-compare-left") (result i32)
    (i32.le_s (i32.load (i32.const 100)) (i32.const 10))
  )
  (func (export "as-compare-right") (result i32)
    (i32.ne (i32.const 10) (i32.load (i32.const 100)))
  )

  (func (export "as-memory.grow-size") (result i32)
    (memory.grow (i32.load (i32.const 100)))
  )

  (func (export "address-as-param") (param i32) (result i32)
    (memory.grow (i32.load (local.get 0)))
  )
)


(assert_return (invoke "as-br-value") (i32.const 0))

(assert_return (invoke "as-br_if-cond"))
(assert_return (invoke "as-br_if-value") (i32.const 0))
(assert_return (invoke "as-br_if-value-cond") (i32.const 7))

(assert_return (invoke "as-return-value") (i32.const 0))

(assert_return (invoke "as-if-cond") (i32.const 1))
(assert_return (invoke "as-if-then") (i32.const 0))
(assert_return (invoke "as-if-else") (i32.const 0))


(assert_return (invoke "as-call-first") (i32.const -1))
(assert_return (invoke "as-call-mid") (i32.const -1))
(assert_return (invoke "as-call-last") (i32.const -1))


(assert_return (invoke "as-local.set-value"))
(assert_return (invoke "as-local.tee-value") (i32.const 0))
(assert_return (invoke "as-global.set-value"))

(assert_return (invoke "as-load-address") (i32.const 0))
(assert_return (invoke "as-loadN-address") (i32.const 0))
(assert_return (invoke "as-store-address"))
(assert_return (invoke "as-store-value"))
(assert_return (invoke "as-storeN-address"))
(assert_return (invoke "as-storeN-value"))

(assert_return (invoke "as-unary-operand") (i32.const 32))

(assert_return (invoke "as-binary-left") (i32.const 10))
(assert_return (invoke "as-binary-right") (i32.const 10))

(assert_return (invoke "as-test-operand") (i32.const 1))

(assert_return (invoke "as-compare-left") (i32.const 1))
(assert_return (invoke "as-compare-right") (i32.const 1))

(assert_return (invoke "as-memory.grow-size") (i32.const 1))

(assert_trap (invoke "address-as-param" (i32.const 0xFFFFFF00)) "out of bounds memory access")
(assert_trap (invoke "address-as-param" (i32.const 0xFFFE)) "out of bounds memory access")