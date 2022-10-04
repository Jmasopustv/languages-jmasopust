(*http://progopedia.com/. (n.d.). Fibonacci numbers. Progopedia. 
Retrieved October 3, 2022, from http://progopedia.com/example/fibonacci/ *)

let rec fibonacci n =
  if n < 3 then
    1
  else
    fibonacci (n-1) + fibonacci (n-2)

let () =
  for n = 1 to 16 do
    Printf.printf "%d, " (fibonacci n)
  done;
  print_endline "..."