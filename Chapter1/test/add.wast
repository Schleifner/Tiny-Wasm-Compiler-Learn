(module
  (export "foo" (func $f))
  (func $f (param $n i32) (result i32)
    (return (i32.add (local.get $n) (i32.const 1)))
  )
)
(assert_return (invoke "foo" (i32.const 42)) (i32.const 43))