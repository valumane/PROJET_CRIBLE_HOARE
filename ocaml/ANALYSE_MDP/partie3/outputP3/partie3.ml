(*compare si le mot de passe haché de depensetout est égal a un autre mot de passe haché dans une autre bd*)
let is_hached_pwd (hashed_pwd, db) =
  let rec exist (db : (string * string) list): bool =
    if db = [] 
    then false
    else
      let (_, pwd) = List.hd db in
      if pwd = hashed_pwd 
      then true
      else exist (List.tl db)
  in
  exist db
;;

  
(*FONCTION PRINCIPALE*)
(* Fonction pour determiner la presence des mots de passe haches *)
let search_hashed_passwords_in_multiple_dbs () =
  let result = ref [] in

  (* Parcours de la base depensetout *)
  for i=0 to List.length depensetout-1
  do
    let (login, password) = List.nth depensetout i in
    let hashed_password = hash_password password in

    (* Verifie si le mot de passe hache est dans les autres bases *)
    let in_slogram = is_hached_pwd(hashed_password,slogram) in
    let in_tetedamis = is_hached_pwd(hashed_password,tetedamis) in

    (* Si le mot de passe hache est present, recupere les logins associes *)
    if in_slogram || in_tetedamis 
    then
      let associated_logins (db : (string * string) list) : string list =
        let rec search (res, db : string list * (string * string) list): string list =
          if db = []
          then res
          else
            let (l, pwd) = List.hd db in
            if pwd = hashed_password
            then search( (l :: res), (List.tl db))
            else search( res, (List.tl db) )
        in
        search([],db)
      in

      let associated_logins_slogram = associated_logins slogram in
      let associated_logins_tetedamis = associated_logins tetedamis in

      (* Ajoute les resultats dans la liste finale *)
      let in_slogram_int = if in_slogram
                           then 1
                           else 0 in
      let in_tetedamis_int = if in_tetedamis
                             then 1
                             else 0 in
      let combined_logins = associated_logins_slogram @ associated_logins_tetedamis in
      result := (login, hashed_password, 1,
                 in_slogram_int, in_tetedamis_int,
                 combined_logins) :: !result ;

  done;
  !result
;;  


let format_login(login, mdp, a,b,c,log) =
  let formatted_sites = String.concat "; " log in
  Printf.sprintf "(%s, %s, %d, %d, %d, [%s])" login mdp a b c formatted_sites
;;
