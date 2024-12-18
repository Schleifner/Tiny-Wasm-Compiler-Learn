(module
  (type $T (func (param) (result i32)))
  (type $U (func (param) (result i32)))
  (table funcref (elem $t1 $t2 $t3 $u1 $u2 $t1 $t3))

  (func $t1 (type $T) (i32.const 1))
  (func $t2 (type $T) (i32.const 2))
  (func $t3 (type $T) (i32.const 3))
  (func $u1 (type $U) (i32.const 4))
  (func $u2 (type $U) (i32.const 5))

  (func (export "callt") (param $i i32) (result i32)
    (call_indirect (type $T) (local.get $i))
  )

  (func (export "callu") (param $i i32) (result i32)
    (call_indirect (type $U) (local.get $i))
  )
)

(assert_return (invoke "callt" (i32.const 0)) (i32.const 1))
(assert_return (invoke "callt" (i32.const 1)) (i32.const 2))
(assert_return (invoke "callt" (i32.const 2)) (i32.const 3))
(assert_return (invoke "callt" (i32.const 3)) (i32.const 4))
(assert_return (invoke "callt" (i32.const 4)) (i32.const 5))
(assert_return (invoke "callt" (i32.const 5)) (i32.const 1))
(assert_return (invoke "callt" (i32.const 6)) (i32.const 3))
(assert_trap (invoke "callt" (i32.const 7)) "undefined element")
(assert_trap (invoke "callt" (i32.const 100)) "undefined element")
(assert_trap (invoke "callt" (i32.const -1)) "undefined element")

(assert_return (invoke "callu" (i32.const 0)) (i32.const 1))
(assert_return (invoke "callu" (i32.const 1)) (i32.const 2))
(assert_return (invoke "callu" (i32.const 2)) (i32.const 3))
(assert_return (invoke "callu" (i32.const 3)) (i32.const 4))
(assert_return (invoke "callu" (i32.const 4)) (i32.const 5))
(assert_return (invoke "callu" (i32.const 5)) (i32.const 1))
(assert_return (invoke "callu" (i32.const 6)) (i32.const 3))
(assert_trap (invoke "callu" (i32.const 7)) "undefined element")
(assert_trap (invoke "callu" (i32.const 100)) "undefined element")
(assert_trap (invoke "callu" (i32.const -1)) "undefined element")


(module
  (type $T (func (result i32)))
  (table funcref (elem 0 1))

  (func $t1 (type $T) (i32.const 1))
  (func $t2 (type $T) (i32.const 2))

  (func (export "callt") (param $i i32) (result i32)
    (call_indirect (type $T) (local.get $i))
  )
)

(assert_return (invoke "callt" (i32.const 0)) (i32.const 1))
(assert_return (invoke "callt" (i32.const 1)) (i32.const 2))


(module
  (type $sig_i (func (param i32) (result i32)))
  (type $sig_v (func (param i32) (result)))

  (func $add_one (type $sig_i) (param $x i32) (result i32)
    local.get $x
    i32.const 1
    i32.add)

  (func $do_nothing (type $sig_v) (param $x i32))

  (table 2 funcref)
  (elem (i32.const 0) $add_one $do_nothing)

  (export "table" (table 0))

  (func $call_indirect (param $index i32) (param $x i32) (result i32)
    (call_indirect (type $sig_i)  (local.get $x) (local.get $index)))
  (export "call_indirect" (func $call_indirect))
)

(assert_return (invoke "call_indirect" (i32.const 0) (i32.const 10)) (i32.const 11))
(assert_trap (invoke "call_indirect" (i32.const 1) (i32.const 10)) "indirect call type mismatch")
