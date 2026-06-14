(*VADE GRELET Lucas
  SIBE Adam*)

(*--- partie1 ---*)
#use "./partie1/partie1.ml";;
(* init tout les fuites de donn�e *) (*20sec environ*)
let ( depensetout,slogram,tetedamis,depensetouthache ) = init_sheet();;

(List.length depensetout,
List.length slogram,
List.length tetedamis);;
List.length depensetouthache;;

(*ecrire les fuites*)
(write_list_to_file_generic("outputP1/depensetout.txt", depensetout ,format_fuite()),
write_list_to_file_generic("outputP1/slogram.txt", slogram ,format_fuite()),
write_list_to_file_generic("outputP1/tetedamis.txt", tetedamis ,format_fuite()));;

(*--- partie2 ---*)
#use "partie2.ml";;
(*init une liste de tout les logins *) (*30sec environ*)
let ( logindepensetout,
      loginslogram,
      logintetedamis,
      alllogins ) = init_login();;


(* chercher et renvoie tout les logins present dans de multiple fuite, avec leur emplacement dans les fuites de donn�e*)(* 1min30 environ *)
let login_occurence = check_occurence_of_login(alllogins,depensetout,slogram,tetedamis);;

(*ecrire le resultat de login_occurence*)
write_list_to_file_generic("outputP2/login_occurence.txt",login_occurence,format_allogins);;

(* trouve tout les login avec un mot de passe identique dans plusieurs fuite de donn�e *)(*15sec environ*)
let login_and_mdp_in_different_db = find_login_pwd_in_multiple_db();;


write_list_to_file_generic("outputP2/output.txt",login_and_mdp_in_different_db,format_triplet);;



(*--- partie3 ---*)
#use "partie3.ml";;

(*chercher les login qui ont un mot de passe identique a d'autre login dans d'autre fuite de donn�e*) (* 20sec environ*)
let shpim = search_hashed_passwords_in_multiple_dbs();;

(*ecrire le resultat*)
write_list_to_file_generic("outputP3/partie3_result.txt",shpim,format_login);;

(*partie4*)
#use "partie4.ml";;


let mdp_clair = mdp_from_file "./outils/french_passwords_top20000.txt";;
let hash_mdp_clair = hach_db_mdp(mdp_clair);;
write_list_to_file_generic("./outputP4/hash_mdp_clair.txt",hash_mdp_clair,(fun s -> s));;

let ( depensetout_password_decode,
      slogram_password_decode,
      tetedamis_password_decode ) = init_decode_password(hash_mdp_clair,mdp_clair);;

(*ecrire le resultat*)
write_all_decoded_mdp();;

(*fin*)

(* test *)
#use "testpartie1.ml";;
#use "testpartie2.ml";;
#use "testpartie3.ml";;
#use "testpartie4.ml";;
