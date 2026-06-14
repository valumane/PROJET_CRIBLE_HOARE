(*VADE GRELET Lucas
  SIBE Adam*)

#use "partie4.ml";;

let test_search_in_hashes():bool=
  let liste = ["a";"b";"c"] in
  let to_test = "a" in
  (search_in_hashes(to_test,liste)=(true,0))=true
;;

let test_check_db_hash():bool=
  let listeFrom = ["a";"b";"c"] in
  let listeWhere = [("a","b");("a","c");("b","d")] in
  let res_function = [(0, ("a", (true, 1), "liste"));
                      (1, ("a", (true, 2), "liste"));
                      (2, ("b", (false, 2), "liste"))] in
  (check_db_hash(listeWhere,listeFrom,"liste")=res_function)=true
;;

let test_filter():bool=
  let listeToTest = [(0, ("a", (true, 1), "liste"));
                     (1, ("a", (true, 2), "liste"));
                     (2, ("b", (false, 2), "liste"))] in
  let res_function = [(0, ("a", (true, 1), "liste"));
                      (1, ("a", (true, 2), "liste"))] in
  (filter(listeToTest)=res_function)=true
;;

let test_transform_one_tuple():bool=
  let to_test = (0,("a",(true,0),"liste")) in
  let liste = ["a","b","c"] in
  (transform_one_tuple( to_test, liste )=("a", ("a", "b", "c"), "liste"))=true
;;


let alltestpartie4():bool=
  test_search_in_hashes() &&
    test_check_db_hash() &&
      test_filter() &&
        test_transform_one_tuple()
;;
alltestpartie4();;
