(module
  (memory $mem 1)
  (export "memory" (memory $mem))
  (data (i32.const 0) "Hello, WebAssembly!")
  (func $read_byte (param $index i32) (result i32)
    (i32.load8_u (local.get $index)))
  (export "read_byte" (func $read_byte))
)

(assert_return (invoke "read_byte" (i32.const 0)) (i32.const 72))  ;; 'H'
(assert_return (invoke "read_byte" (i32.const 1)) (i32.const 101)) ;; 'e'
(assert_return (invoke "read_byte" (i32.const 2)) (i32.const 108)) ;; 'l'
(assert_return (invoke "read_byte" (i32.const 3)) (i32.const 108)) ;; 'l'
(assert_return (invoke "read_byte" (i32.const 4)) (i32.const 111)) ;; 'o'
(assert_return (invoke "read_byte" (i32.const 5)) (i32.const 44))  ;; ','
(assert_return (invoke "read_byte" (i32.const 6)) (i32.const 32))  ;; ' '
(assert_return (invoke "read_byte" (i32.const 7)) (i32.const 87))  ;; 'W'
(assert_return (invoke "read_byte" (i32.const 8)) (i32.const 101)) ;; 'e'
(assert_return (invoke "read_byte" (i32.const 9)) (i32.const 98))  ;; 'b'
(assert_return (invoke "read_byte" (i32.const 10)) (i32.const 65)) ;; 'A'
(assert_return (invoke "read_byte" (i32.const 11)) (i32.const 115)) ;; 's'
(assert_return (invoke "read_byte" (i32.const 12)) (i32.const 115)) ;; 's'
(assert_return (invoke "read_byte" (i32.const 13)) (i32.const 101)) ;; 'e'
(assert_return (invoke "read_byte" (i32.const 14)) (i32.const 109)) ;; 'm'
(assert_return (invoke "read_byte" (i32.const 15)) (i32.const 98))  ;; 'b'
(assert_return (invoke "read_byte" (i32.const 16)) (i32.const 108)) ;; 'l'
(assert_return (invoke "read_byte" (i32.const 17)) (i32.const 121)) ;; 'y'
(assert_return (invoke "read_byte" (i32.const 18)) (i32.const 33))  ;; '!'
