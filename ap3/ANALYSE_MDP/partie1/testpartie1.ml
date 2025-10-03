(*VADE GRELET Lucas
  SIBE Adam*)

#use "partie1.ml";;

let test_db_isempty():bool=
  db_isempty([])=true
;;
let test_is_element_in_db():bool=
  let liste = [1;2;3] in
  let element_in = 2 in
  let element_not_in = 5 in
  
  ((is_element_in_db(element_in,liste) = true) &&
    (is_element_in_db(element_not_in,liste)=false))=true
;;

let test_unique_list():bool=
  let liste = [1;2;3;3] in
  (unique_list(liste)=[1;2;3])=true
;;

let test_merge():bool=
  let listeA = [1;2;3] in
  let listeB = [4;5;6] in
  (merge(listeA,listeB)=[6;5;4;1;2;3])=true
;;

let test_merge_two_list_no_duplicates():bool=
  let listeA = [1;2;3;3] in
  let listeB = [4;5;5;6;6;7] in
  (merge_two_list_no_duplicates(listeA,listeB)=[7;6;5;4;1;2;3])=true
;;

let alltestpartie1()=
  (test_db_isempty() &&
     test_is_element_in_db() &&
       test_unique_list() &&
         test_merge() &&
           test_merge_two_list_no_duplicates())=true
;;


alltestpartie1();;
