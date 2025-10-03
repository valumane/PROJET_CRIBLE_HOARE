(*VADE GRELET Lucas
  SIBE Adam*)

#use "././outils/tools.ml";;

(*db = fuite de donnee = Data Base = db*)

(*----------------*)
(* premier partie *)
(*----------------*)

(*check si une db est vide *)
let db_isempty(db : 'a list) : bool= 
  db=[]
;;

let rec is_element_in_db (e, db : 'a * 'a list) : bool =
  if db = [] || List.hd db = e
  then db <> []
  else is_element_in_db (e, List.tl db)
;;

(* supprime les doublons d'une liste*)
let unique_list(lst:'a list):'a list=
  let rec aux(acc,lst:'a list*'a list):'a list=
  if lst = []
  then acc
  else
    if is_element_in_db(List.hd lst,acc)
    then aux(acc,List.tl lst)
    else aux(List.hd lst :: acc, List.tl lst)
  in
  rev(aux([],lst))
;;

(* merge deux listes*)
let rec merge(db2,db1: 'a list * 'a list):'a list=
  if db1=[]
  then db2
  else merge(List.hd db1 :: db2, List.tl db1)
;;


(* merge et supprime les doublons de 2listes*)
let merge_two_list_no_duplicates(db1,db2:'a list*'a list):'a list=
  if db_isempty(db1) || db_isempty(db2)
  then failwith "erreur merge_no_duplicates : db1 ou db2 vide"
  else unique_list(  merge(db1,db2)  )
;;



(*fonction pour hache une db*)
let hache_db (db : ('a * string) list) : ('a * string) list =
  let length = List.length db in
  let result : ('a * string) list ref = ref [] in
  for i = 0 to length - 1 do
    let (login, password) = List.nth db i in
    result := (login, hash_password password) :: !result
  done;
  rev(!result)
;;

(* initialise toute les bd *)
let init_sheet ():(string * string) list *
                  (string * string) list *
                  (string * string) list *
                  (string * string) list =
  (* Lecture des fichiers individuels *)
  let depensetout01 = read_data_from_file "./fuite/depensetout01.txt" and
      depensetout02 = read_data_from_file "./fuite/depensetout02.txt" in 

  let slogram01 = read_data_from_file "./fuite/slogram01.txt" and
      slogram02 = read_data_from_file "./fuite/slogram02.txt" in

  let tetedamis01 = read_data_from_file "./fuite/tetedamis01.txt" and
      tetedamis02 = read_data_from_file "./fuite/tetedamis02.txt" in

  (* Fusion des bases de donnees *)
  let depensetout = merge_two_list_no_duplicates(depensetout01,depensetout02) and
      slogram = merge_two_list_no_duplicates(slogram01,slogram02) and
      tetedamis = merge_two_list_no_duplicates(tetedamis01,tetedamis02) in

  (*hache tout les mdp de depensetout*)
  let depensetouthache = hache_db(depensetout) in
  
  (* Retourne un tuple contenant toutes les bases de donn es *)
  (depensetout, slogram, tetedamis, depensetouthache)
;;

(*let (depensetout,slogram,tetedamis,depensetouthache) = init_sheet();;*)


(* AUUUU SECOURS ECRITURE FONCTIONNELLLLE AAAAAAAAAAAAAH*)
let format_fuite () : string * string -> string =
  (fun (login, pwd) -> Printf.sprintf "(%s,%s)" login pwd)
;;
