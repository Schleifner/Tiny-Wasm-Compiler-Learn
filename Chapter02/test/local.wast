(module

  (func (export "type-local-i32") (result i32) (local i32) (local.get 0))
  (func (export "type-local-i64") (result i64) (local i64) (local.get 0))

  (func (export "type-param-i32") (param i32) (result i32) (local.get 0))
  (func (export "type-param-i64") (param i64) (result i64) (local.get 0))

)

(assert_return (invoke "type-local-i32") (i32.const 0))
(assert_return (invoke "type-local-i64") (i64.const 0))

(assert_return (invoke "type-param-i32" (i32.const 2)) (i32.const 2))
(assert_return (invoke "type-param-i64" (i64.const 3)) (i64.const 3))


(module
  ;; Typing

  (func (export "type-local-i32") (local i32) (local.set 0 (i32.const 0)))
  (func (export "type-local-i64") (local i64) (local.set 0 (i64.const 0)))

  (func (export "type-param-i32") (param i32) (local.set 0 (i32.const 10)))
  (func (export "type-param-i64") (param i64) (local.set 0 (i64.const 11)))


  (func (export "type-mixed") (param i64 i32 i32) (local i64 i64)
    (local.set 0 (i64.const 0))
    (local.set 1 (i32.const 0))
    (local.set 2 (i32.const 0))
    (local.set 3 (i64.const 0))
    (local.set 4 (i64.const 0))
  )
)

(assert_return (invoke "type-local-i32"))
(assert_return (invoke "type-local-i64"))

(assert_return (invoke "type-param-i32" (i32.const 2)))
(assert_return (invoke "type-param-i64" (i64.const 3)))
(assert_return (invoke "type-mixed"(i64.const 0)(i32.const 0)(i32.const 0)))


(module
  (func (export "type-local-i32") (result i32) (local i32) (local.tee 0 (i32.const 1)))
  (func (export "type-local-i64") (result i64) (local i64) (local.tee 0 (i64.const 1)))


  (func (export "type-param-i32") (param i32) (result i32) (local.tee 0 (i32.const 10)))
  (func (export "type-param-i64") (param i64) (result i64) (local.tee 0 (i64.const 11)))


  (func (export "as-local.set-value") (local i32)
    (local.set 0 (local.tee 0 (i32.const 1)))
  )
  (func (export "as-local.tee-value") (param i32) (result i32)
    (local.tee 0 (local.tee 0 (i32.const 1)))
  )
)

(assert_return (invoke "type-local-i32") (i32.const 1))
(assert_return (invoke "type-local-i64") (i64.const 1))


(assert_return (invoke "type-param-i32" (i32.const 2)) (i32.const 10))
(assert_return (invoke "type-param-i64" (i64.const 3)) (i64.const 11))

(assert_return (invoke "as-local.set-value"))
(assert_return (invoke "as-local.tee-value" (i32.const 0)) (i32.const 1))

