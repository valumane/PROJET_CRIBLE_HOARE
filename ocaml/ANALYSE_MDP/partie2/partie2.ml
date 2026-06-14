(*VADE GRELET Lucas
  SIBE Adam*)

#use "./partie1/partie1.ml";;
#use "././outils/tools.ml";;

(*----------------*)
(*    partie 2    *)
(*----------------*)

let extract_logins(db:('a*'a)list):'a list=
  let rec extract_login_aux(tmp,db:'a list*('a*'a) list ):'a list=
    if db = []
    then tmp
    else
      let l,p = List.hd db in
      extract_login_aux(l::tmp,List.tl db)
  in
  rev(extract_login_aux([],db))
;;

(* merge et enleve les elements en double dans la liste finale *)
let merge_three_list_no_duplicates(db1,db2,db3:'a list*'a list*'a list) : 'a list =
  if db_isempty(db1) || db_isempty(db2) || db_isempty(db3)
  then failwith "erreur merge_and_remove_duplicates : db1 ou db2 ou db3 vide"
  else unique_list(db1 @ db2 @ db3)
;;

let init_login():string list*string list*string list*string list=
  let logindepensetout = extract_logins(depensetout) in
  let loginslogram = extract_logins(slogram) in
  let logintetedamis = extract_logins(tetedamis) in

  let alllogin = merge_three_list_no_duplicates(
                     logindepensetout,
                     loginslogram,
                     logintetedamis) in
  
  (logindepensetout,loginslogram,logintetedamis,alllogin)
;;
let ( logindepensetout,
      loginslogram,
      logintetedamis,
      alllogins ) = init_login();;
(* liste de tout les logins*)

(*on regarde ou se trouve le login dans chaque db*)
let check_occurence_of_login_in_db (login, db : 'a * ('a * 'a) list) : int list =
  let rec aux(index,acc,lst) =
    if lst = []
    then rev acc
    else
      let (log, _) = List.hd lst in
      if login = log
      then aux( (index + 1), (index :: acc), List.tl lst)
      else aux( (index + 1), acc, List.tl lst)
  in
  aux(0,[],db)
;;

(* login dans plusieurs db ou pas ?*)
let generate_login_tuple(login,dba,dbb,dbc:'a*('a*'a)list*('a*'a)list*('a*'a)list):
      'a*'a*'int list*'a *int list*'a*int list=
  (login,
   "depensetout", check_occurence_of_login_in_db(login, dba),
   "slogram", check_occurence_of_login_in_db(login, dbb),
   "tetedamis", check_occurence_of_login_in_db(login, dbc))
;;

(* je regarde pour tout les logins ( un peut long ) *)
let check_occurence_of_login(alllogin,dba,dbb,dbc:string list*('a*'a)list*('a*'a)list*('a*'a)list):('a*'a*int list*'a*int list*string*int list) list=
  let rec aux(result,all)=
    if all = []
    then result
    else
      let login = List.hd all in
      aux( generate_login_tuple(login,dba,dbb,dbc)  :: result,
          List.tl all)
  in
  aux([],alllogin)
;;
(*let login_occurence =
  check_occurence_of_login(alllogins,depensetout,slogram,tetedamis);;*)

let format_allogins (login, depensetout, depensetout_ids,
                     slogram, slogram_ids,
                     tetedamis, tetedamis_ids) =
  Printf.sprintf "(%s, %s, [%s], %s, [%s], %s, [%s])" login depensetout (String.concat "; " (List.map string_of_int depensetout_ids)) slogram (String.concat "; " (List.map string_of_int slogram_ids)) tetedamis (String.concat "; " (List.map string_of_int tetedamis_ids)) ;;

(*---------------*)



(* on regarde juste le nbr d'occurence pour les login*)
(* avec certaine conditions *)
let search_by_how_many_occurence(db,dep,slo,tet:(string * string * int list * string * int list * string * int list)list*int*int*int):(string * string * int list * string * int list * string * int list) list=
  let result : 'a ref = ref [] in

  let depensetout = if dep = 1
                    then 0
                    else 10 in
  let slogram = if slo = 1
                then 0
                else 10 in
  let tetedamis = if tet = 1
                  then 0
                  else 10 in

  for i=0 to List.length db -1
  do
    let (login,s1,i1,s2,i2,s3,i3) = List.nth db i in
    if List.length(i1) >= depensetout ||
       List.length(i2) >= slogram ||
       List.length(i3) >= tetedamis
    then result := (login,s1,i1,s2,i2,s3,i3) :: !result
  done;
  !result
;;

(*ptit bool pour savoir si un login specifique et dans plusieurs db ou pas*)
let is_login_in_multiple_db(login,dba,dbb,dbc:string*(string*string) list*(string*string) list *(string*string) list):bool=
  let (login,s1,i1,s2,i2,s3,i3) = generate_login_tuple(login,dba,dbb,dbc) in
  not(i1=[]) &&  not(i2=[]) ||
                 not(i2=[]) &&  not(i3=[]) ||
  not(i1=[]) &&                 not(i3=[])
;;


(* on regarde toute les combinaisons possible de comparaisons d'indice*)
let all_possible_combinations(n,dba,dbb,dbc,loginoccurence:int * 'a list * 'a list * 'a list *
  (string * 'b * int list * 'c * int list * 'd * int list) list):string*(string*int*string*int*bool) list =
  let (login, _, list_dep, _, list_slo, _, list_tet) = List.nth loginoccurence n in
  let results = ref [] in
  
  (* Boucle sur list_a *)
  for i = 0 to List.length list_dep - 1
  do
    let a = List.nth list_dep i in

    (* Boucle sur list_b *)
    for j = 0 to List.length list_slo - 1
    do
      let b = List.nth list_slo j in
      results := ("d", a, "s", b,
                  List.nth dba a = List.nth dbb b) :: !results;

      (* Boucle sur list_c *)
      for k = 0 to List.length list_tet - 1
      do
        let c = List.nth list_tet k in
        results := ("d", a, "t", c,
                    List.nth dba a = List.nth dbc c) :: !results;
        results := ("s", b, "t", c,
                    List.nth dbb b = List.nth dbc c) :: !results;
      done;
    done;
  done;
  (login,!results)
;;

(* on filtre les combinaisons vrai *)
let filter_combinations(combinations:string*(string*int*string*int*bool) list ):string*(string*int*string*int*bool) list =
  let login, comb = combinations in
  let rec filter acc i =
    if i >= List.length comb
    then acc
    else
      let elem = List.nth comb i in
      let (_, _, _, _, is_valid) = elem in
      if is_valid
      then filter (elem :: acc) (i + 1)
      else filter acc (i + 1)
  in
  (login,filter [] 0)
;;

(* on combine les 2fonctions d'au dessus *)
let get_valid_combinations(n,dba,dbb,dbc,loginoccurence)=
  filter_combinations( all_possible_combinations(n,dba,dbb,dbc,loginoccurence) )
;;

(* on convertit les indices en mdp *)
let convert_indices_to_passwords(valid_combinations,dba,dbb,dbc)=
  let login,valid = valid_combinations in
  let result : 'a list ref = ref [] in
  for i = 0 to List.length valid -1
  do
    let a,b,c,d,_ = List.nth valid i in
    
    if (a,c) = ("d","s")
    then
      (
        let login_dep,pwd_dep = List.nth dba b in
        let login_slo,pwd_slo = List.nth dbb d in
            result := ("d",pwd_dep,"s",pwd_slo) :: !result
      );
    if (a,c) = ("d","t")
    then
      (
        let login_dep,pwd_dep = List.nth dba b in
        let login_tet,pwd_tet = List.nth dbc d in
        result := ("d",pwd_dep,"t",pwd_tet) :: !result
      );

    if (a,c) = ("s","t")
    then
      (
        let login_slop,pwd_slo = List.nth dbb b in
        let login_tet,pwd_tet = List.nth dbc d in
        result := ("s",pwd_slo,"t",pwd_tet) :: !result
      ); 
   
  done;
  (login,!result)
;;

(* on met tout dans un format ergonomique et simple a lire*)
let transform_to_final_format (tupleloginmdp : string * (string * string * string * string) list) : string * string * string list =
  let login, valid = tupleloginmdp in
  let pwd =
    if List.length valid = 0
    then ""
    else
      let _, x, _, _ = List.nth valid 0 in
      x
  in
  let result = ref [] in

  let already_in_result category =
    let rec aux(i)=
      if i >= List.length !result
      then false
      else
        if List.nth !result i = category
        then true
        else aux(i + 1)
    in
    aux(0)
  in

  for i = 0 to List.length valid - 1
  do
    let a, _, c, _ = List.nth valid i in

    if not(already_in_result a)
    then result := a :: !result;

    if not(already_in_result c)
    then result := c :: !result;
  done;

  (login, pwd, rev !result)
;;

(* on regroupe toute les actions dans une fonction faciles a appeller *)
let find_tuple_identic_password(n,loginoccurence)=
  transform_to_final_format(
      convert_indices_to_passwords(
          get_valid_combinations(
              n,depensetouthache,slogram,tetedamis,
              loginoccurence
            ),depensetouthache,slogram,tetedamis
        )
    )
;;
(*find_tuple_identic_password(14811,login_occurence);;*)

let find_login_with_identic_password_in_multiple_db(loginoccurence:
      (string * 'a * int list * 'b * int list * 'c * int list) list):(string * string * string list) list=
  let result : 'a list ref = ref [] in
  for i = 0 to List.length loginoccurence-1
  do
    result := find_tuple_identic_password(i,loginoccurence) :: !result
  done;
  rev(!result)
;;
(*find_login_with_identic_password_in_multiple_db(login_occurence);;*)

let delete_void_element(list:('a * 'b * 'c list) list):('a * 'b * 'c list) list=
  let rec aux(tmp,lst) =
    if lst = []
    then tmp
    else
      let login,mdp,site = List.hd lst in
      if site = []
      then aux(tmp, List.tl lst)
      else aux(List.hd lst :: tmp, List.tl lst)
  in
  aux([],list)
;;

(*let find_login_pwd_in_multiple_db()=
  delete_void_element(
      find_login_with_identic_password_in_multiple_db(
          login_occurence
        )
    )
;;
let b = find_login_pwd_in_multiple_db();;
 *)

(* format d'ecriture*)
let format_triplet (triplet : string * string * string list) : string =
  let login, pwd, categories = triplet in
  Printf.sprintf "(%s, %s, [%s])" 
    login 
    pwd 
    (String.concat "; " categories) (* au secours un module pas recommandé d'utilisé *)
;;
