 (module
 
  (func $exhaust (export "exhaust")
    (local i32) (local i32) (local i32) (local i32) (local i32) (local i32) (local i32)
    i32.const 0
    local.set  0
    i32.const 1
    local.set  1
    i32.const 2
    local.set  2
    i32.const 3
    local.set  3
    i32.const 4
    local.set  4
    call $exhaust
  )

)

(assert_exhaustion (invoke "exhaust") "call stack exhausted")

