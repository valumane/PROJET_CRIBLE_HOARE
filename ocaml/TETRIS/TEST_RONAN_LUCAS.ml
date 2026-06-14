(* __  __        __  ___  o   __        __    _   __   ___ __  __ ___ *)
(*|__ /  \ |\ | /     |   |  /  \ |\ | (__   | \ |__    | |_  (_   |  *)
(*|   \__/ | \| \__   |   |  \__/ | \|  __)  |_/ |__    | |__ __)  |  *)


(* toute les fonctions de tests on etait realisé par Lucas Vadé grelet *)
(* pour pouvoir exectuer les tests il faut mettre en commentaire la ligne 787 du fichier jeuCP2.ml *)

(* les fonctions de test de valeuyrs incoherente sont effectué en tout en bas du fichier *)

#use "JEU__Ronan__Lucas.ml";;

   
   

(*-----------------------*)
(*test valid matrix point*)
(*-----------------------*)
   
(*test valeur vraie*)
let test_is_valid_matrix_point(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status,"valid_matrix_point_in") in
  let test_result : bool t_test_result = test_exec(test_step, valid_matrix_point,( {x=50; y=70}, init_param()))  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, " in_dimension", test_get(test_result), true  )
    else test_error(test_step) ;
    test_end(test_step)
    )
;;

(*test valeur fausse*)
let test_isnt_valid_matrix_point(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status,"valid_matrix_point_out") in
  let test_result : bool t_test_result = test_exec(test_step, valid_matrix_point,( {x=50; y=70}, init_param()))  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, " out_dimension", test_get(test_result), true  )
    else test_error(test_step) ;
    test_end(test_step)
    )
;;


(*--------------------*)
(*test valid cur shape*)
(*--------------------*)
let test_valid_cur_shape_choice(status : t_test_status) : unit =

  let fakecolorarray : t_color t_array = {len = 1;value = [|255|]} and
      fakeinitshapes : t_shape t_array = {len = 1;value =
  [|{shape = [{x = 0; y = 0}; {x = 1; y = 0}; {x = 2; y = 0}; {x = 3; y = 0}];
     x_len = 4; y_len = 1; rot_rgt_base = {x = 1; y = 1}; rot_rgt_shape = 1;
     rot_lft_base = {x = 2; y = 1}; rot_lft_shape = 1}|]} in
  
  
  let test_step : t_test_step = test_start(status,"cur_shape_choice_valid") in
  let test_result : t_cur_shape t_test_result = test_exec(test_step, cur_shape_choice,(fakeinitshapes,4,5,fakecolorarray,green))  in
    (
    if test_is_success(test_result)
    then
      (
        assert_equals(test_step, "valid_shape", test_get(test_result),
                      {base = {contents = {x = 0; y = 4}};
                       shape = {contents = 0};
                       color = {contents = 255}});
      )      
    else test_error(test_step) ;
    test_end(test_step)
    )
;;

let fakecolorarray : t_color t_array = {len = 1;value = [|255|]} ;;
let fakeinitshapes : t_shape t_array = {len = 1;value =
  [|{shape = [{x = 0; y = 0}; {x = 1; y = 0}; {x = 2; y = 0}; {x = 3; y = 0}];
     x_len = 4; y_len = 1; rot_rgt_base = {x = 1; y = 1}; rot_rgt_shape = 1;
     rot_lft_base = {x = 2; y = 1}; rot_lft_shape = 1}|]} ;;

cur_shape_choice(fakeinitshapes,4,5,fakecolorarray,green);;
    

(*-----------*)
(*test insert*)
(*-----------*)
(*test valeur vraie*)
let test_is_insertable(status : t_test_status) : unit =

  let fakecolorarray : t_color t_array = {len = 1;value = [|255|]} and
      fakeinitshapes : t_shape t_array = {len = 1;value =
  [|{shape = [{x = 0; y = 0}; {x = 1; y = 0}; {x = 2; y = 0}; {x = 3; y = 0}];
     x_len = 4; y_len = 1; rot_rgt_base = {x = 1; y = 1}; rot_rgt_shape = 1;
     rot_lft_base = {x = 2; y = 1}; rot_lft_shape = 1}|]} in
  

  let shape : t_cur_shape = cur_shape_choice(fakeinitshapes,5,5,fakecolorarray,green) in
  let pointlist : t_point list = (init_sh112()).shape in
  let p : t_param = init_param() in
  let colormat : t_color matrix = mat_make((init_param()).mat_szx,
                                         (init_param()).mat_szy,
                                         color_of_rgb(255,255,255)) in

                                           
    let test_step : t_test_step = test_start(status,"valid_matrix_point_in") in
    let test_result :
          bool t_test_result =
      test_exec(test_step,insert,(shape,pointlist,p,colormat)) in
   (

    if test_is_success(test_result)
    then assert_equals(test_step, " insertable", test_get(test_result), true  )
    else test_error(test_step) ;
    test_end(test_step)
)
;;


(*---------------*)
(*is_collumn_full*)
(*---------------*)
(* test valeur vraie *)
let test_is_column_full(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status,"full_column") in
  let test_result : bool t_test_result = test_exec(test_step,is_column_full,((init_play()).mat,20,10,init_param()))  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "full_column", test_get(test_result), false  )
    else test_error(test_step) ;
    test_end(test_step)
    )
;;

(*-------------*)
(*test new_step*)
(*-------------*)
let test_can_new_step(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status,"can_new_step?") in
  let test_result : bool t_test_result = test_exec(test_step,newstep,(init_play(),ref 1.,1.,1.))  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "can_new_step?", test_get(test_result), false)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;
(*-----------------*)
(*test color choice*)
(*-----------------*)
let test_color_choice(status : t_test_status) : unit =
  
  let fakecolorarray : t_color t_array = {len = 1;value = [|255|]}in
  
  let test_step : t_test_step = test_start(status,"color_is_good") in
  let test_result : t_color t_test_result = test_exec(test_step,color_choice,(fakecolorarray,green))  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "color_is_good", test_get(test_result), 255)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;
(*-----------------*)
(*test is free move*)
(*-----------------*)
let test_is_free_move(status : t_test_status) : unit =
  
  
let prm = init_param() in 
let pts = {x=1;y=5} in
let shap = (init_shapes()).value.(0).shape in
let matcol : t_color matrix = mat_make(prm.mat_szx, prm.mat_szy, color_of_rgb(255,255,255)) in

  
  let test_step : t_test_step = test_start(status,"point is good") in
      let test_result : bool t_test_result =
        test_exec(test_step,
                  is_free_move,(pts,shap,matcol,prm))  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "free move", test_get(test_result), true)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;

let test_is_not_free_move(status : t_test_status) : unit =
  
  
let prm = init_param() in 
let pts = {x=1;y=50} in
let shap = (init_shapes()).value.(0).shape in
let matcol : t_color matrix = mat_make(prm.mat_szx, prm.mat_szy, color_of_rgb(255,255,255)) in

  
  let test_step : t_test_step = test_start(status,"point is bad") in
      let test_result : bool t_test_result =
        test_exec(test_step,
                  is_free_move,(pts,shap,matcol,prm))  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "not free move", test_get(test_result), false)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;

let test_can_move_down(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status,"point can down") in
      let test_result : bool t_test_result =
        test_exec(test_step,
                  move_down,init_play())  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "move down", test_get(test_result), true)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;

let test_is_final_newstep(status : t_test_status) : unit =
 

  
  let test_step : t_test_step = test_start(status,"final ?") in
      let test_result : bool t_test_result =
        test_exec(test_step,
                 final_newstep,init_play())  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "final_newstep", test_get(test_result), false)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;
(* ------------------------------ *)
(* fonction de test question 11.2 *)
(* ------------------------------ *)

(* test si le dilat est superieur a 0 *)
(* si le dilat est inferieur ou egal a 0, c'est une valeur incoherente *)

let is_dilat_supp():bool=
  (init_param()).graphics.dilat>0
;;

let test_is_dilat_supp(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status,"dilat supp 0 ?") in
      let test_result : bool t_test_result =
        test_exec(test_step,
                 is_dilat_supp,())  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "is_dilat_supp0", test_get(test_result), true)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;

(* test si mat_szx > mat_szy *)
(* si la taille x de la matrice est superieur a la taille y de la matrice *)
(* alors la zone de jeux est horizontale, ce qui nous paraissait  *)
(* ce qui nous parraissait etre une valeur incoherente *)

let is_x_supp_y():bool=
  (init_param()).mat_szx > (init_param()).mat_szy
;;
let test_is_matDIM_incorrect(status : t_test_status) : unit =
  let test_step : t_test_step = test_start(status,"x supp y ?") in
      let test_result : bool t_test_result =
        test_exec(test_step,
                 is_x_supp_y,())  in
    (
    if test_is_success(test_result)
    then assert_equals(test_step, "is X supp Y", test_get(test_result), false)
    else test_error(test_step) ;
    test_end(test_step)
    )
;;


                   

(*-----------------------*)
(* test de tout les test *)
(*-----------------------*)
let test_run() : unit = 
  let alltests : t_test_status = create_test_status() in
  (

    (* test fonction de jeux *)
    test_is_valid_matrix_point(alltests);
    test_isnt_valid_matrix_point(alltests);

    test_valid_cur_shape_choice(alltests);
   
    test_is_insertable(alltests);

    test_is_column_full(alltests);

    test_can_new_step(alltests);

    test_color_choice(alltests);

    test_is_free_move(alltests);
    test_is_not_free_move(alltests);

    test_can_move_down(alltests);

    test_is_final_newstep(alltests);
    
    (* fonction de test de valeur incoherente , question 11.2 *)
    test_is_dilat_supp(alltests);
    test_is_matDIM_incorrect(alltests);
    
    (* Print test status at the end *)
    print_test_report(alltests)
    )
;;
test_run();;
