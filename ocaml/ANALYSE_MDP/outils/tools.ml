(*VADE GRELET Lucas
  SIBE Adam*)

#use "topfind";;
#require "cryptokit";;
#require "base64";;
  

let read_data_from_file file =
  let f = open_in file in
  let rec aux acc =
    try
      let login = input_line f 
      and pwd = input_line f
       in
        aux ((login, pwd) :: acc)
    with End_of_file ->
      close_in f;
    List.rev acc
  in
  aux []
;;

let hash_password pwd =
  Base64.encode_exn(Cryptokit.hash_string (Cryptokit.Hash.sha256 ()) pwd)
;;

(*----------------------*)
(*   fonction ajouter   *)
(*----------------------*)

(* fonction d'au dessus modifi� pour lire le fichier french_password_top20000.txt*)
let mdp_from_file file =
  let f = open_in file in
  let rec aux acc =
    try
      let pwd = input_line f in
      aux(pwd :: acc)
    with End_of_file ->
      close_in f;
      List.rev acc
  in
  aux []
;;


(* chatgpt prompt : genere moi une fonction en ocaml pouvant ecrire une data en prenant en compte le format de la data *)
let write_list_to_file_generic(filename,data,format : string * 'a list * ('a->string)) =
  let oc = open_out filename in (* Ouvre le fichier en écriture *)
  List.iter (fun item ->
    output_string oc (format item ^ "\n") (* Utilise le format fourni pour chaque élément *)
  ) data;
  close_out oc (* Ferme le fichier *)
;;

(* trouver dans le fichier aputil.ml sur updago *)
let time_eval(myfunc, myparam : ('a -> 'b) * 'a) : float =
  let mem_tm : float = Sys.time() in
  (
    ignore(myfunc(myparam)) ;
    Sys.time() -. mem_tm
  )
;;

(* inverser une liste*)
let rev (lst: 'a list): 'a list =
  let rec reverse (lst ,tmp : 'a list  * 'a list) =
    if lst = [] 
    then tmp
    else reverse (List.tl lst) ((List.hd lst) :: tmp)
  in
  reverse lst []
;;



