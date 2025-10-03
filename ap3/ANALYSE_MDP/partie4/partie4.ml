(*VADE GRELET Lucas
  SIBE Adam*)

#use "././outils/tools.ml";;

(* hache french password top20000*)
let hach_db_mdp(mdpdb)=
  let rec aux(res,lst:'a list*'a list):'a list=
    if lst=[]
    then res
    else aux(hash_password(List.hd lst) :: res ,List.tl lst)
  in
  rev(aux([],mdpdb))
;;

(*cherche un mdp dans les mdp clair hach�*)
let search_in_hashes(mdp,hash_mdp_clair)=
  let rec aux (mdp, found, index, list) =
    if found || list = []
    then (found, index)
    else aux (mdp, (mdp = List.hd list), (index + 1), List.tl list)
  in
  aux (mdp, false, -1, hash_mdp_clair)
;;

(*fonction d'au dessus mais la on cherche directement avec le login et le mdp*)
let check_login_hash(loginmdp,hash_mdp_clair,s_where)=
  (*s_where = le nom de la db*)
  let login,mdp = loginmdp in
  (login,search_in_hashes(mdp,hash_mdp_clair),s_where)
;;

(*on cherche a qu'elle indice il est*)
let check_db_hash(t_where,hash_mdp_clair,s_where)=
  let rec aux(res,db,index)=
    if db = []
    then res
    else aux(
             (index, check_login_hash(List.hd db,hash_mdp_clair,s_where)) :: res ,
             List.tl db,index+1)
  in
  rev(aux([],t_where,0))
;;


(* on enleve les resultats faux*)
let filter(res)=
  let rec aux(acc,res)=
    if res = []
    then acc
    else
      let _,(_,(y,_),_) = List.hd res in
      if y = false
      then aux(acc,List.tl res)
      else aux(List.hd res::acc, List.tl res)
  in
  rev(aux([],res))
;;


(* on transforme le tuple donner dans la fonction filter pour un truc plus lisible *)
let transform_one_tuple(tuple,mdp_clair)=
  let l,(m,(n,o),p) = tuple in
  (m,List.nth mdp_clair o,p)
;;


(* la fonction d'au dessus pour tout les type*)
let transform_all_tuple(alltuple,mdp_clair)=
  let rec aux(res,list)=
    if list = []
    then res
    else aux( transform_one_tuple(List.hd list,mdp_clair)::res,List.tl list)
  in
  aux([],alltuple)
;;

let init_decode_password(hash_mdp_clair,mdp_clair)=
  let a = check_db_hash(depensetouthache,hash_mdp_clair,"depensetout") in
  let b = check_db_hash(slogram,hash_mdp_clair,"slogram") in
  let c = check_db_hash(tetedamis,hash_mdp_clair,"tetedamis") in

  let filta = filter(a) in
  let filtb = filter(b) in
  let filtc = filter(c) in
  
  let list_mdp_clair_login_depensetout = transform_all_tuple(filta,mdp_clair) in
  let list_mdp_clair_login_slogram = transform_all_tuple(filtb,mdp_clair) in
  let list_mdp_clair_login_tetedamis = transform_all_tuple(filtc,mdp_clair) in

  (list_mdp_clair_login_depensetout,
   list_mdp_clair_login_slogram,
   list_mdp_clair_login_tetedamis)
;;


let format_mdp_decoded (triplet : string * string * string) : string =
  let login, name, category = triplet in
  Printf.sprintf "(%s, %s, %s)" login name category
;;

let write_all_decoded_mdp()=
  write_list_to_file_generic("outputP4/mdp_clair_depensetout.txt",
                             list_mdp_clair_login_depensetout,
                             format_mdp_decoded
    );
  write_list_to_file_generic("outputP4/mdp_clair_slogram.txt",
                             list_mdp_clair_login_slogram,
                             format_mdp_decoded
    );

  write_list_to_file_generic("outputP4/mdp_clair_tetedamis.txt",
                             list_mdp_clair_login_tetedamis,
                             format_mdp_decoded
    )
;;
