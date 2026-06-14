(*VADE GRELET Lucas
  SIBE Adam*)

#use "partie3.ml";;

let test_is_hached_pwd (): bool =
  let db = [("login1", "hash_mdp1"); ("login2", "hash_mdp2")] in
  (is_hached_pwd ("hash_mdp1", db) = true) && (is_hached_pwd ("hash_mdp3", db) = false) = true
;;

let test_verif_in (): bool =
  (verif_in true = 1) && (verif_in false = 0) = true
;;

let test_search (): bool =
  let db = [("login1", "hash_mdp1");
            ("login2", "hash_mdp2");
            ("login3", "hash_mdp1")] in
  let hashed_password = "hash_mdp1" in
  
  (search ([], db,hashed_password) = ["login3"; "login1"]) = true
;;

let test_associated_logins (): bool =
  let db = [("login1", "hash_mdp1"); ("login2", "hash_mdp2"); ("login3", "hash_mdp1")] in
  let hashed_password = "hash_mdp1" in
  let result = ["login3"; "login1"] in
  
  let associated_logins (db : (string * string) list) : string list =
    search ([], db,hashed_password) in
  
  (associated_logins db = result) = true
;;

let test_format_login (): bool =
  let login = "user" in
  let mdp = "hash_mdp1" in
  let a = 1 in
  let b = 1 in
  let c = 0 in
  let log = ["login1"; "login2"] in
  let result = "(user, hash_mdp1, 1, 1, 0, [login1; login2])" in
  (format_login (login, mdp, a, b, c, log) = result) = true
;;

let alltestpart3()=
  test_is_hached_pwd () &&
  test_verif_in () &&
  test_verif_in () &&
  test_search () &&
  test_search () &&
  test_associated_logins () &&
  test_format_login ()
;;

alltestpart3();;
