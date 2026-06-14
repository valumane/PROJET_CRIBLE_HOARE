(*VADE GRELET Lucas
  SIBE Adam*)

#use "partie2.ml";;
let test_extract_login():bool=
  let liste = [(1,2);(3,4);(5,6)] in
  (extract_logins(liste)=[1;2;3])=true
;;
extract_logins([(1,2);(3,4);(5,6)]);;

let test_merge_three_list_no_duplicates():bool=
  let listeA = [1;2] in
  let listeB = [3;4] in
  let listeC = [5;6] in
  (merge_three_list_no_duplicates(listeA,listeB,listeC) = [1;2;3;4;5;6]) = true
;;
test_merge_three_list_no_duplicates();;

let test_check_occurence_of_login_in_db():bool=
  let liste = [("1","2");("3","4");("1","6")] in
  (check_occurence_of_login_in_db("1",liste)=[0;2])=true
;;
test_check_occurence_of_login_in_db();;

let test_generate_login_tuple():bool=
  let listeA = [("1","2");("3","4");("1","6")] in
  let listeB = [("3","2");("3","4");("1","6")] in
  let listeC = [("1","2");("4","4");("4","6")] in
  let res_function = ("1", "depensetout", [0; 2], "slogram", [2], "tetedamis", [0]) in
  (generate_login_tuple("1",listeA,listeB,listeC)=res_function)=true
;;
test_generate_login_tuple();;

let test_check_occurence_of_login():bool=
  let liste_to_test = ["1";"2";"3"] in
  let listeA = [("1","2");("3","4");("1","6")] in
  let listeB = [("3","2");("2","4");("1","6")] in
  let listeC = [("1","2");("4","4");("4","6")] in
  let res_function = [("3", "depensetout", [1], "slogram", [0], "tetedamis", []);
                      ("2", "depensetout", [], "slogram", [1], "tetedamis", []);
                      ("1", "depensetout", [0; 2], "slogram", [2], "tetedamis", [0])] in
  (check_occurence_of_login(liste_to_test,listeA,listeB,listeC)=res_function)=true
;;
test_check_occurence_of_login();;

let test_search_by_how_many_occurence():bool=
  let login_occurence_to_check =[("3", "depensetout", [1], "slogram", [0], "tetedamis", []);
                                 ("2", "depensetout", [], "slogram", [1], "tetedamis", []);
                                 ("1", "depensetout", [0; 2], "slogram", [2], "tetedamis", [0])]
  in
  let res_function = [("1", "depensetout", [0; 2], "slogram", [2], "tetedamis", [0])] in
  (search_by_how_many_occurence(login_occurence_to_check)=res_function)=true    
;;
test_search_by_how_many_occurence();;


let test_is_login_pwd_in_db():bool=
  let liste = [("1","2");("3","4");("1","6")] in
  let loginpwd_to_test = ("1","6") in
  (is_login_pwd_in_db(loginpwd_to_test,liste)=true)=true
;;
test_is_login_pwd_in_db();;

let test_all_possible_combinations():bool=
  let to_test = [("1", "depensetout", [0; 2], "slogram", [0; 2], "tetedamis", [0; 2])] in
  let listeA = [("1","2");("3","4");("1","6")] in
  let listeB = [("1","2");("3","4");("1","6")] in
  let listeC = [("1","2");("3","4");("1","6")] in
  let res_function =
    ("1",
     [("s", 2, "t", 2, true); ("d", 2, "t", 2, true); ("s", 2, "t", 0, false);
      ("d", 2, "t", 0, false); ("d", 2, "s", 2, true); ("s", 0, "t", 2, false);
      ("d", 2, "t", 2, true); ("s", 0, "t", 0, true); ("d", 2, "t", 0, false);
      ("d", 2, "s", 0, false); ("s", 2, "t", 2, true); ("d", 0, "t", 2, false);
      ("s", 2, "t", 0, false); ("d", 0, "t", 0, true); ("d", 0, "s", 2, false);
      ("s", 0, "t", 2, false); ("d", 0, "t", 2, false); ("s", 0, "t", 0, true);
      ("d", 0, "t", 0, true); ("d", 0, "s", 0, true)])
  in

  (all_possible_combinations(0,listeA,listeB,listeC,to_test)=res_function)=true

;;
test_all_possible_combinations();;
  

let test_filter_combinations():bool=
  let to_filter =
    ("1",
     [("s", 2, "t", 2, true); ("d", 2, "t", 2, true); ("s", 2, "t", 0, false);
      ("d", 2, "t", 0, false); ("d", 2, "s", 2, true); ("s", 0, "t", 2, false);
      ("d", 2, "t", 2, true); ("s", 0, "t", 0, true); ("d", 2, "t", 0, false);
      ("d", 2, "s", 0, false); ("s", 2, "t", 2, true); ("d", 0, "t", 2, false);
      ("s", 2, "t", 0, false); ("d", 0, "t", 0, true); ("d", 0, "s", 2, false);
      ("s", 0, "t", 2, false); ("d", 0, "t", 2, false); ("s", 0, "t", 0, true);
      ("d", 0, "t", 0, true); ("d", 0, "s", 0, true)])
  in
  let res_function =
    ("1",
     [("d", 0, "s", 0, true); ("d", 0, "t", 0, true); ("s", 0, "t", 0, true);
      ("d", 0, "t", 0, true); ("s", 2, "t", 2, true); ("s", 0, "t", 0, true);
      ("d", 2, "t", 2, true); ("d", 2, "s", 2, true); ("d", 2, "t", 2, true);
      ("s", 2, "t", 2, true)])
  in
  (filter_combinations(to_filter)=res_function)=true
;;
test_filter_combinations();;

let test_get_valid_combinations():bool=
  let listeA = [("1","2");("3","4");("1","6")] in
  let listeB = [("1","2");("3","4");("1","6")] in
  let listeC = [("1","2");("3","4");("1","6")] in
  let to_test = [("1", "depensetout", [0; 2], "slogram", [0; 2], "tetedamis", [0; 2])] in
  let res_function =
    ("1",
     [("d", 0, "s", 0, true); ("d", 0, "t", 0, true); ("s", 0, "t", 0, true);
      ("d", 0, "t", 0, true); ("s", 2, "t", 2, true); ("s", 0, "t", 0, true);
      ("d", 2, "t", 2, true); ("d", 2, "s", 2, true); ("d", 2, "t", 2, true);
      ("s", 2, "t", 2, true)])
  in
  
  
  (get_valid_combinations(0,listeA,listeB,listeC,to_test)=res_function)=true
;;
test_get_valid_combinations();;        

let test_convert_indices_to_passwords():bool=
  let listeA = [("1","2");("3","4");("1","6")] in
  let listeB = [("1","2");("3","4");("1","6")] in
  let listeC = [("1","2");("3","4");("1","6")] in
  let to_test =
    ("1",
     [("d", 0, "s", 0, true); ("d", 0, "t", 0, true); ("s", 0, "t", 0, true);
      ("d", 0, "t", 0, true); ("s", 2, "t", 2, true); ("s", 0, "t", 0, true);
      ("d", 2, "t", 2, true); ("d", 2, "s", 2, true); ("d", 2, "t", 2, true);
      ("s", 2, "t", 2, true)])
  in
  let res_function =
    ("1",
     [("s", "6", "t", "6"); ("d", "6", "t", "6"); ("d", "6", "s", "6");
      ("d", "6", "t", "6"); ("s", "2", "t", "2"); ("s", "6", "t", "6");
      ("d", "2", "t", "2"); ("s", "2", "t", "2"); ("d", "2", "t", "2");
      ("d", "2", "s", "2")])
  in
  (convert_indices_to_passwords(to_test,listeA,listeB,listeC)=res_function)=true
;;
test_convert_indices_to_passwords();;

let test_delete_void_element():bool=
  let liste = [("a","",[]);("n","bidule",["s"])] in
  (delete_void_element(liste)=[("n", "bidule", ["s"])])=true
;;
test_delete_void_element();;
