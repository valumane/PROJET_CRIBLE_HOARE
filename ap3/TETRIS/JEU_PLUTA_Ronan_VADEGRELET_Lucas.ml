(*      ___ _____ _ ___ __      *)
(*       | |_  | |_) | (_       *)
(*       | |__ | | \_|___)      *)


(* LANGAGE : OCAML
 * VERSION : 22W17C
 * GROUPE : Radiateur
 * ELEVES : Ronan PLUTA | Lucas VADE-GRELET
 * Complement de programmation : Partie 2
 * ANNEE : 2022 *)


(*        POUR JOUER ?      *) 
(* Pour demarrer le jeu : 
Sur emacs : Faite la manipulation suivante : ctrl + c + b puis Entree *)


(*       LES COMMANDES      *)
(* Droite               : Q
 * Gauche               : D
 * Rotation droite      : Z
 * Rotation gauche      : S
 * Le plus bas possible : A 
 * 
 * Envie de changer les touches ? 
 * Aller a la fonction "move" et modifier seulement les lettres correspondantes. 
 *
 * Envie de changer la couleur du fond ? 
 * Aller a la fonction "init_param" et modifier l'attribut background_color*)


(*         EXTENSION        *)
(* SCORE : 1 ligne valide = 10 points
 * COULEUR DU FOND : Change la couleur du fond et retire cette meme couleur pour les formes. *)

#use "CPinter.ml";;

(* Ouverture de la fenettre graphique *) 
open_graph(425,700);;

(* -------------------------- *)
(* -------------------------- *)
(*    fonctions utilitaires   *)
(* -------------------------- *)
(* -------------------------- *)

let mywait(x : float) : unit =
  let y : float ref = ref (Sys.time()) in
  while (Sys.time() -. !y) < x
  do ()
  done
;;

(* --------------------------------- *)
(* --------------------------------- *)
(*   Types et fonctions graphique    *)
(* --------------------------------- *)
(* --------------------------------- *)

type t_point = {x : int ; y : int} ;;

(* --------------------------------- *)
(*            absolute               *)
(* --------------------------------- *)

(* Fonction realisee en binome *)
(*draw_absolute_pt dessine un rectangle en fonction de l'origine base_draw, et sa taille est definit par le parametre p*)
let draw_absolute_pt(p, base_draw, dilat, col : t_point * t_point * int * t_color) : unit =
  ( set_color(col);
    draw_rect( base_draw.x + p.x*dilat, base_draw.y + p.y* dilat,dilat,dilat)
  )
;;
(* Test *)
(* draw_absolute_pt({x=0;y=0},{x=0;y=0},20,blue);; *)

(* Fonction realisee en binome *)
(*fill_absolute_pt remplis un rectangle en fonction de l'origine base_draw, et sa taille est definit par le parametre p, avec une couleur notï¿½ col en parametre*)
let fill_absolute_pt(p,base_draw,dilat,col:t_point*t_point*int*t_color):unit=
  (set_color(col);
   fill_rect(base_draw.x + p.x  *dilat, base_draw.y + p.y * dilat,dilat,dilat)
  )
;;
(* Test *)
(* fill_absolute_pt({x=0;y=0},{x=0;y=0},20,red);; *)

(* Fonction realisee en binome *)
(*drawfill_absolute_pt combine les fonctions fill_absolute_pt et draw_absolute_pt*)
let drawfill_absolute_pt(p,base_draw,dilat,col:t_point*t_point*int*t_color):unit=
  fill_absolute_pt(p,base_draw,dilat,col);
  draw_absolute_pt(p,base_draw,dilat,grey)
;;
(* Test *)
(* drawfill_absolute_pt({x=0;y=0},{x=0;y=0},20,black);; *)

(* --------------------------------- *)
(*              relative             *)
(* --------------------------------- *)

(* Fonction realisee en binome *)
(*draw_relative_pt dessine un rectangle comme la fonction draw_absolute_pt, mais son origine est mouvante*)
let draw_relative_pt(p,base_point,base_draw,dilat,col:t_point*t_point*t_point*int*t_color):unit=
  draw_absolute_pt({ x=(p.x + base_point.x); y= (p.y + base_point.y) },base_draw,dilat,col)
;;


(* Fonction realisee en binome *)
(*fill_relative_pt remmplis un rectangle comme la fonction fill_absolute_pt, mais son origine est mouvante*)
let fill_relative_pt(p,base_point,base_draw,dilat,col:t_point*t_point*t_point*int*t_color):unit=
  fill_absolute_pt({ x=(p.x + base_point.x); y= (p.y + base_point.y) },base_draw,dilat,col)
;;


(* Fonction realisee en binome *)
(*drawfill_relative_pt combine les fonctions fill_relative_pt et draw_relative_pt*)
let drawfill_relative_pt(p,base_point,base_draw,dilat,col:t_point*t_point*t_point*int*t_color):unit=
fill_relative_pt(p, base_point, base_draw,dilat,col);
draw_relative_pt(p, base_point, base_draw,dilat,col)
;;
(* Test *)
(* drawfill_relative_pt({x=0;y=0},{x=0;y=0},{x=0;y=0},20,blue);; *)

(* --------------------------------- *)
(*             pt list               *)
(* --------------------------------- *)

(* Fonction realisee en binome *)
(*draw_pt_list dessine plusieurs rectangle en fonction d'une liste de point*)
let draw_pt_list(l,base_pt,base_draw,dilat,col:t_point list*t_point*t_point*int*t_color):unit=
  for i = 0 to len(l)-1
  do
    draw_relative_pt( nth(l,i) , base_pt , base_draw ,  dilat,col )
  done
;;

(* Fonction realisee en binome *)
(*fill_pt_list remplis plusieurs rectangle en fonction d'une liste de point*)
let fill_pt_list(l,base_pt,base_draw,dilat,col:t_point list*t_point*t_point*int*t_color):unit=
  for i = 0 to len(l)-1
  do
    fill_relative_pt( nth(l,i) , base_pt , base_draw ,  dilat,col )
  done
;;

(* Fonction realisee en binome *)
(*drawfill_pt_list combine les fonctions fill_pt_list et draw_pt_list*)
let drawfill_pt_list(l,base_pt,base_draw,dilat,col:t_point list*t_point*t_point*int*t_color):unit=
  draw_pt_list(l,base_pt,base_draw,dilat,grey);
  fill_pt_list(l,base_pt,base_draw,dilat,col)
;;

(* --------------------------------- *)
(*        zone de travaille          *)
(* --------------------------------- *)

(* Fonction realisee en binome *)
(* Modifiee par Ronan PLUTA pour une extension *)
(*draw_grid dessine une grille de rectangle *)
let draw_grid(base_draw,size_x,size_y,dilat, background_color : t_point * int * int * int * t_color) : unit =
  for w = 0 to size_y-1
  do
  for i = 0 to size_x-1
  do
    fill_relative_pt({x=i; y=w}, {x=0; y=0}, base_draw, dilat, background_color);
    draw_relative_pt({x=i; y=w}, {x=0; y=0}, base_draw, dilat, grey);
  done
  done
;;

(* Fonction realisee en binome *)
(*draw_frame dessine le contour de la zone de dessin*)
let draw_frame(base_draw, size_x, size_y, dilat : t_point * int * int * int) : unit =
  (
    set_color(black);
    let width : int = size_x * dilat and
        heigth : int = size_y * dilat in
    fill_rect(base_draw.x - dilat, base_draw.y - dilat, width + dilat * 2 , dilat);
    fill_rect(base_draw.x - dilat, base_draw.y - dilat, dilat, heigth + dilat);
    fill_rect(base_draw.x + width, base_draw.y - dilat, dilat, heigth + dilat);
  )
;;

(* ------------------------------------------------- *)
(* ------------------------------------------------- *)
(*    Types, formes, parametrage et initialisation   *)
(* ------------------------------------------------- *)
(* ------------------------------------------------- *)

(* Types *)

type 'a t_array = {len : int ;
                   value : 'a array} ;;

type t_shape = {shape : t_point list ;
                x_len : int ;
                y_len : int ; 
                rot_rgt_base : t_point ;
                rot_rgt_shape : int ; 
                rot_lft_base : t_point ;
                rot_lft_shape : int} ;;

type t_cur_shape = {base : t_point ref ;
                    shape : int ref ;
                    color : t_color ref} ;;

type t_param_time = {init : float ;
                     extent : float ;
                     ratio : float} ;;

(* Modifiee par Ronan PLUTA pour une extension *)
type t_param_graphics = {base : t_point ;
                         dilat : int ;
                         color_arr : t_color t_array ;
                         background_color : t_color} ;;
type t_param = 
  {time : t_param_time ; 
   mat_szx : int ;
   mat_szy : int ;
   graphics : t_param_graphics ; 
   shapes : t_shape t_array
  } ;;
type t_play = {par : t_param ;
               cur_shape : t_cur_shape ;
               mat : t_color matrix ;
               score : int ref
  } ;;


(* ----------------------------------- *)
(*                get                  *)
(* ----------------------------------- *)

(* les get realisee en binome *)
(* type 'a t_array  *)

let getlen(p : 'a t_array) int = p.len ;;
let getvalue(p : 'a t_array) int = p.value ;;

(* type t_shape  *)

let getshape(p : t_shape) t_point list = p.shape ;;
let getx_len(p : t_shape) int = p.x_len ;;
let gety_len(p : t_shape) int = p.y_len ;;
let getrot_rgt_base(p : t_shape) t_point = p.rot_rgt_base ;;
let getrot_rgt_shape(p : t_shape) int = p.rot_rgt_base ;;
let getrot_lft_base(p : t_shape) t_point = p.rot_lft_base ;;
let getrot_lft_shape(p : t_shape) t_point = p.rot_lft_shape ;;

(* type t_cur_shape  *)

let getbaseref(p : t_cur_shape) : t_point ref = p.base ;;
let getcur_shape(p : t_cur_shape) : int ref = p.shape ;;
let getcolor(p : t_cur_shape) : t_color ref = p.color ;;

(* type t_param_time  *)

let getinit(p : t_param_time) : float = p.init ;;
let getextent(p : t_param_time) : float = p.extent ;;
let getratio(p : t_param_time) : float = p.ratio ;;

(* type t_param_graphics  *)

let getbase(p : t_param_graphics) : t_point = p.base ;;
let getdilat(p : t_param_graphics) : int = p.dilat ;;
let getcolor_arr(p : t_param_graphics) : t_color t_array = p.color_arr ;;

(* type t_param  *)

let gettime(p : t_param) : t_param_time = p.time ;;
let getmat_szx(p : t_param) : int = p.mat_szx ;;
let getmat_szy(p : t_param) : int = p.mat_szy ;;
let getgraphics(p : t_param) : t_param_graphics = p.graphics ;;
let getshapes(p : t_param) : t_shape t_array = p.shapes ;;

(* type t_param  *)

let getpar(p : t_play) : t_param = p.par ;;
let getcur_shape(p : t_play) : t_cur_shape = p.cur_shape ;;
let getmat(p : t_play) : t_color matrix = p.mat ;;


let addpoint(p,q:t_point*t_point):t_point=
  {x=p.x+q.x;y=p.y+q.y};;

(* Initialisation de quelques formes et des parametres *)

(* Forme : Barre x4 horizontale *)
let init_sh011() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 1 ; y = 0} ; {x = 2 ; y = 0} ; {x = 3 ; y = 0}] ; 
  x_len = 4 ; y_len = 1 ; 
  rot_rgt_base = {x = 1 ;  y = 1} ; rot_rgt_shape = 1 ; 
  rot_lft_base = {x = 2 ; y = 1} ; rot_lft_shape = 1} 
;;

(* Forme : Barre x4 verticale *)
let init_sh112() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = 0 ; y = -2} ; {x = 0 ; y = -3}] ; 
  x_len = 1 ; y_len = 4 ; 
  rot_rgt_base = {x = -2 ;  y = -1} ; rot_rgt_shape = 0 ; 
  rot_lft_base = {x = -1 ; y = -1} ; rot_lft_shape = 0} 
;;

(* Forme : Carre *)
let init_sh211() : t_shape = 
  {shape = [{x = 0 ; y = 0} ; {x = 0 ; y = -1} ; {x = 1 ; y = 0} ; {x = 1 ; y = -1}] ; 
  x_len = 2 ; y_len = 2 ; 
  rot_rgt_base = {x = 0 ;  y = 0} ; rot_rgt_shape = 2 ; 
  rot_lft_base = {x = 0 ;  y = 0} ; rot_lft_shape = 2} 
;;

(* Appel des formes *)
let init_shapes() : t_shape t_array = 
  {len = 3 ; value = [| init_sh011() ; init_sh112() ; init_sh211() |]} 
;;

(* Initialiation des couleurs pour les formes *)
let init_color() : t_color t_array = 
  {len = 8 ; value = [|blue ; red ; green ; yellow ; cyan ; magenta ; grey; white|]} ;;

(* Parametre du jeu *)
(* Modifiee par Ronan PLUTA pour une extension *)
let init_param() : t_param = 
    {
    time = {init = 1.0 ; extent = 10.0 ; ratio = 0.8} ; 
    mat_szx = 15 ; mat_szy = 28 ;
    graphics = {base = {x = 50 ; y = 50} ; dilat = 20 ; color_arr = init_color() ; background_color = white} ; 
    shapes = init_shapes()
    }
;;

let init_param_graphics(param : t_param): t_param_graphics =
  param.graphics
;;
(* Fonction realisee par Ronan PLUTA *)
let time_init(param : t_param) : float =
  param.time.init
;;
(* Fonction realisee par Ronan PLUTA *)
let time_extent(param : t_param) : float =
  param.time.extent
;;
(* Fonction realisee par Ronan PLUTA *)
let time_ratio(param : t_param) : float =
  param.time.ratio
;;

(*-----------------*)
(*   question 6    *)
(*-----------------*)

(* Fonction realisee en binome *)
(* Modifiee par Ronan PLUTA pour une extension *)
(*la fonction color_choice, choisit une couleur aleatoire en fonction d'un tableau de couleur rentre en parametre*)
let color_choice(t, background_color : t_color t_array * t_color) : t_color =  
  let random_color : t_color ref = ref t.value.(rand_int(0,t.len-1)) in
  while !random_color = background_color 
  do
    random_color := t.value.(rand_int(0,t.len-1));
  done;
  !random_color;
;;

(* Fonction realisee en binome *)
(* Modifiee par Ronan PLUTA pour une extension *)
let cur_shape_choice(shapes, mat_szx, mat_szy, color_arr, background_color : t_shape t_array * int * int * t_color t_array * t_color):t_cur_shape=
  let sh : int = rand_int(0,shapes.len-1) and
      col : t_color = color_choice(color_arr, background_color) in
  let bas : t_point = { x = rand_int(0,mat_szx-(shapes.value.(sh)).x_len);
                        y = mat_szy-1 } in
  let cur : t_cur_shape = { base = ref bas;
                             shape = ref sh;
                             color = ref col } in
  cur
;;

(* Fonction realisee en binome *)
(* Modifiee par Ronan PLUTA pour une extension *)
(*insert cur param.shapes.(cur.shape) param mymat*)
let rec insert(cur, shape, param, mymat : t_cur_shape * t_point list * t_param * t_color matrix ) : bool =
  if isempty(shape) then true
  else
    let head :t_point =  fst(shape) in
    let  reste : t_point list = rem_fst(shape) in
    let p :t_point = {x=head.x + !(cur.base).x ; y = head.y + !(cur.base).y} in

    if mymat.(p.x).(p.y) <> param.graphics.background_color
    then false
    else (
      fill_absolute_pt(p,(init_param()).graphics.base,(init_param()).graphics.dilat,!(cur.color));
      draw_absolute_pt(p,(init_param()).graphics.base,(init_param()).graphics.dilat,grey);
      
      (* Test *)
      (*Printf.printf "%i\n" !(cur.color);*)
      insert(cur,reste,param,mymat)
    )
;;

(* Fonction realisee en binome *)
(* Modifiee par Ronan PLUTA pour une extension *)
(* Initialisation du jeu *)
let init_play() : t_play =

  let listshapes : t_shape t_array = init_shapes() in
  
  let p : t_param = init_param() in
  
  let cur : t_cur_shape = cur_shape_choice(listshapes, p.mat_szx, p.mat_szy, init_color(), p.graphics.background_color) in 
  
  let matcol : t_color matrix = mat_make(p.mat_szx, p.mat_szy, p.graphics.background_color) in

  draw_grid(p.graphics.base, p.mat_szx, p.mat_szy, p.graphics.dilat, p.graphics.background_color);
  draw_frame(p.graphics.base, p.mat_szx, p.mat_szy, p.graphics.dilat);
  if insert(cur, listshapes.value.(!(cur.shape)).shape, p, matcol)
  then(
    let init : t_play = { par = p ;
                        cur_shape = cur ;
                        mat = matcol ;
                        score = ref 0} in
    init)
  else failwith("Cannot insert")
;;

(* ----------------------------------------------- *)
(* ----------------------------------------------- *)
(*    Deplacements et controle des deplacements    *)
(* ----------------------------------------------- *)
(* ----------------------------------------------- *)

(* Fonction realisee en binome *)
(*test si un point p est valide en fonction des dimensions de l'espace de travail*)
let valid_matrix_point(p , param :t_point * t_param) : bool=
  
  (* Test *)
  (* Printf.printf "Valid - Point p: x: %i y: %i\n" (p.x) (p.y); *)
  (* Printf.printf "Valid - Base: x: %i y: %i\n" (param.graphics.base.x) (param.graphics.base.y);
   * Printf.printf "Valid - Limites: x: %i y: %i\n" (param.graphics.base.x + param.mat_szx*param.graphics.dilat) (param.graphics.base.y + param.mat_szy*param.graphics.dilat); *)
  
   param.graphics.base.x <= p.x && p.x <= param.graphics.base.x + (param.mat_szx-1)*param.graphics.dilat
     && param.graphics.base.y <= p.y && p.y <= param.graphics.base.y + (param.mat_szy-1)*param.graphics.dilat

;;

(* Test *)
(* valid_matrix_point({x=50; y=70}, init_param() );; *)

(* Fonction realisee en binome *)
(* Modifiee par Ronan PLUTA pour une extension + correction *)
(*test si la forme est en colision avec une forme anterieur*)
let is_free_move(p,shape,mymat,param :t_point * t_point list * t_color matrix * t_param) : bool =
  (* Test *)
  (* Printf.printf "Free - Point p : x %i y %i\n" (p.x) (p.y); *)
  let free : bool ref = ref true in
  for i=0 to len(shape) - 1
  do
    let cur_point : t_point = nth(shape, len(shape) - 1 - i) in
    let line : int = p.x + cur_point.x and
        column : int = p.y + cur_point.y in
    let p_absolute : t_point = {x = line*param.graphics.dilat + param.graphics.base.x ; y = column*param.graphics.dilat + param.graphics.base.y} in
    if valid_matrix_point(p_absolute, param)
    then(
       if !free && mymat.(line).(column) <> param.graphics.background_color
       then
         free := false;
    )
    else
      free := false;
  done;
  !free 
;;

(*----------------*)
(*    mouvement   *)
(*----------------*)

(* Fonction realisee par Ronan PLUTA | aide de Lucas VADE-GRELET *)
(* Mouvement forme vers la gauche *)
let move_left(pl:t_play):unit=
  let cur : t_cur_shape = pl.cur_shape and
      shapes : t_shape array = (init_shapes()).value in
  let shape : t_point list = shapes.(!(cur.shape)).shape  and
      p : t_point = {x = !(cur.base).x - 1 ; y = !(cur.base).y} in
  let p_absolute : t_point = {x = p.x*pl.par.graphics.dilat + pl.par.graphics.base.x ; y = p.y*pl.par.graphics.dilat + pl.par.graphics.base.y} in
  let free : bool = is_free_move(p,shape,pl.mat,pl.par) and
      valid : bool = valid_matrix_point(p_absolute, pl.par) in 
  if free && valid
  then (
    (* Effacer l'ancienne forme *)
    fill_pt_list(shape, !(cur.base),getbase(pl.par.graphics), getdilat(pl.par.graphics), pl.par.graphics.background_color);
    draw_pt_list(shape, !(cur.base),getbase(pl.par.graphics), getdilat(pl.par.graphics), grey);
    pl.cur_shape.base := p;
    fill_pt_list(shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics), !(cur.color));
    draw_pt_list(shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics),grey);
  )
  else (
    (* Test *)
    (* Printf.printf "Free: %B\n" free;
       Printf.printf "Valid: %B\n" valid;
       Printf.printf "P: \nx: %i\ny: %i\n" p.x p.y;
       Printf.printf "P_absolute: \nx: %i\ny: %i\n" p_absolute.x p_absolute.y; *)
  )
;;

(* Fonction realisee par Ronan PLUTA | aide de Lucas VADE-GRELET *)
(* Mouvement forme vers la droite *)
let move_right(pl:t_play):unit=
  let cur : t_cur_shape = pl.cur_shape in
  let shapes : t_shape array = (init_shapes()).value in
  let shape : t_point list = shapes.(!(cur.shape)).shape  in
  let p : t_point = {x = !(cur.base).x + 1 ; y = !(cur.base).y} in
  let p_absolute : t_point = {x = p.x*pl.par.graphics.dilat + pl.par.graphics.base.x ; y = p.y*pl.par.graphics.dilat + pl.par.graphics.base.y} in
  let free : bool = is_free_move(p,shape,pl.mat,pl.par) and
      valid : bool = valid_matrix_point(p_absolute, pl.par) in 
  if free && valid
  then (
    (* Effacer l'ancienne forme *)
    fill_pt_list(shape, !(cur.base),getbase(pl.par.graphics), getdilat(pl.par.graphics), pl.par.graphics.background_color);
    draw_pt_list(shape, !(cur.base),getbase(pl.par.graphics), getdilat(pl.par.graphics), grey);
    pl.cur_shape.base := p;
    fill_pt_list(shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics),!(cur.color));
    draw_pt_list(shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics),grey);

  )
  else (
    (* Test *)
    (* Printf.printf "Free: %B\n" free;
       Printf.printf "Valid: %B\n" valid;
       Printf.printf "P: \nx: %i\ny: %i\n" p.x p.y;
       Printf.printf "P_absolute: \nx: %i\ny: %i\n" p_absolute.x p_absolute.y; *)
  )
;;

(* Fonction realisee par Ronan PLUTA | aide de Lucas VADE-GRELET *)
(* Mouvement vers le bas (si c'est possible) *)
let move_down(pl:t_play):bool=
  let cur : t_cur_shape = pl.cur_shape in
  let shapes : t_shape array = (init_shapes()).value in
  let shape : t_point list = shapes.(!(cur.shape)).shape  in
  let p : t_point = {x = !(cur.base).x ; y = !(cur.base).y - 1} in
  let p_absolute : t_point = {x = p.x*pl.par.graphics.dilat + pl.par.graphics.base.x ; y = p.y*pl.par.graphics.dilat + pl.par.graphics.base.y} in
  let free : bool = is_free_move(p,shape,pl.mat,pl.par) and
      valid : bool = valid_matrix_point(p_absolute, pl.par) in 
  if free && valid
  then (
    (* Effacer l'ancienne forme *)
    fill_pt_list(shape, !(cur.base),getbase(pl.par.graphics), getdilat(pl.par.graphics), pl.par.graphics.background_color);
    draw_pt_list(shape, !(cur.base),getbase(pl.par.graphics), getdilat(pl.par.graphics), grey);
    pl.cur_shape.base := p;
    fill_pt_list(shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics), !(cur.color));
    draw_pt_list(shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics), grey);
    true
  )
  else (
    (* Test *)
    (* Printf.printf "Free: %B\n" free;
       Printf.printf "Valid: %B\n" valid;
       Printf.printf "P: \nx: %i\ny: %i\n" p.x p.y;
       Printf.printf "P_absolute: \nx: %i\ny: %i\n" p_absolute.x p_absolute.y; *)
    false
  )
;;

(* Fonction realisee par Ronan PLUTA *)
(* Rotation de la forme vers la droite *)
let rotate_right(pl : t_play ) : unit =
  let cur : t_cur_shape = pl.cur_shape in
  let shapes : t_shape array = (init_shapes()).value in
  let shape : t_point list = shapes.(!(cur.shape)).shape in
  let rot_base : t_point = shapes.(!(cur.shape)).rot_rgt_base in
  let rot_shape_num : int = shapes.(!(cur.shape)).rot_rgt_shape in
  let rot_shape : t_point list = shapes.(rot_shape_num).shape in
  let p : t_point = {x= !(cur.base).x + rot_base.x ;y= !(cur.base).y - rot_base.y } in
  let p_absolute : t_point = {x = p.x*pl.par.graphics.dilat + pl.par.graphics.base.x ; y = p.y*pl.par.graphics.dilat + pl.par.graphics.base.y} in
  let free : bool = is_free_move(p,rot_shape,pl.mat,pl.par) and
      valid : bool = valid_matrix_point(p_absolute, pl.par) in 
  let b : bool =  free && valid  in
  if b
  then
    (
      (* Effacer l'ancienne forme *)
      fill_pt_list(shape, !(cur.base), getbase(pl.par.graphics),getdilat(pl.par.graphics), pl.par.graphics.background_color);
      draw_pt_list(shape, !(cur.base), getbase(pl.par.graphics),getdilat(pl.par.graphics),grey);
      pl.cur_shape.base := p;
      pl.cur_shape.shape := rot_shape_num;

      fill_pt_list(rot_shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics), !(cur.color)) ;
      draw_pt_list(rot_shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics),grey);
    ) 
;;

(* Fonction realisee par Ronan PLUTA *)
(* Rotation de la forme vers la gauche *)
let rotate_left(pl : t_play ) : unit=
  let cur : t_cur_shape = pl.cur_shape in
  let shapes : t_shape array = (init_shapes()).value in
  let shape : t_point list = shapes.(!(cur.shape)).shape in
  let rot_base : t_point = shapes.(!(cur.shape)).rot_lft_base in
  let rot_shape_num : int = shapes.(!(cur.shape)).rot_lft_shape in
  let rot_shape : t_point list = shapes.(rot_shape_num).shape in
  let p : t_point = {x= !(cur.base).x + rot_base.x ;y= !(cur.base).y - rot_base.y } in
  let p_absolute : t_point = {x = p.x*pl.par.graphics.dilat + pl.par.graphics.base.x ; y = p.y*pl.par.graphics.dilat + pl.par.graphics.base.y} in
  let free : bool = is_free_move(p,rot_shape,pl.mat,pl.par) and
      valid : bool = valid_matrix_point(p_absolute, pl.par) in 
  let b : bool =  free && valid  in
  if b
  then
    (
      (* Effacer l'ancienne forme *)
      fill_pt_list(shape, !(cur.base), getbase(pl.par.graphics),getdilat(pl.par.graphics), pl.par.graphics.background_color);
      draw_pt_list(shape, !(cur.base), getbase(pl.par.graphics),getdilat(pl.par.graphics),grey);
      pl.cur_shape.base := p;
      pl.cur_shape.shape := rot_shape_num;
      fill_pt_list(rot_shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics), !(cur.color)) ;
      draw_pt_list(rot_shape,p,getbase(pl.par.graphics),getdilat(pl.par.graphics),grey);
    )
;;

(* Fonction realisee par Ronan PLUTA *)
(* Descendre la forme le plus bas possible *)
let move_at_bottom(pl : t_play) : unit =
  let check : bool ref = ref (move_down(pl)) in
  while !check
  do
    check := move_down(pl);
  done;
;;
                  
(* choix des deplacements suivant le caractere saisi *)
let move(pl, dir : t_play * char) : bool = 
  (
  if dir = 'z'
    then rotate_right(pl)
    else
      if dir = 's'
      then rotate_left(pl)
      else
        if dir = 'q'
        then move_left(pl)
        else
          if dir = 'd'
          then move_right(pl)
          else () ;  
  (dir = 'a')
  )
;;

(* ----------------------------------- *)
(* ----------------------------------- *)
(*    Suppression des lignes pleines   *)
(* ----------------------------------- *)
(* ----------------------------------- *)

(* Fonction realisee par Ronan PLUTA *)
(* Test si une ou plusieurs colonnes sont pleines *)
let is_column_full(mymat, y , mat_szx, par : t_color matrix * int * int * t_param) : bool =
  let full : bool ref = ref true in   
  for x=0 to mat_szx-1
  do
    if !full && mymat.(x).(y)=par.graphics.background_color
    then
      full := false;
  done;
  !full
;;

(* Fonction realisee par Ronan PLUTA *)
(* Effectue un decalage des colonnes vers le bas *)
let decal(mymat, y, szx, szy, par : t_color matrix * int * int * int * t_param) : unit =
  for line=y+1 to szy-1
  do
    for column=0 to szx-1
    do
      let cur_color : t_color = mymat.(column).(line) in
      fill_absolute_pt({x= column; y= line - 1},par.graphics.base,par.graphics.dilat,cur_color);
      draw_absolute_pt({x= column; y= line - 1},par.graphics.base,par.graphics.dilat, grey);

      fill_absolute_pt({x= column; y= line},par.graphics.base,par.graphics.dilat, par.graphics.background_color);
      draw_absolute_pt({x= column; y= line},par.graphics.base,par.graphics.dilat, grey);

      mymat.(column).(line - 1 ) <- cur_color;
      mymat.(column).(line) <- par.graphics.background_color;
    done;
  done;
;;

(* Fonction realisee par Ronan PLUTA *)
(* Fonction qui "nettoie" l'espace de travail des lignes pleines *)
let clear_play(pl : t_play ) : unit =
  for line=0 to pl.par.mat_szy - 1
  do
    while is_column_full(pl.mat, line, pl.par.mat_szx, pl.par)
    do
      pl.score := !(pl.score) + 10;
      decal(pl.mat, line, pl.par.mat_szx, pl.par.mat_szy, pl.par);
    done;
  done;
;;

(* Fonction realisee par Ronan PLUTA *)
(* Fonction qui "fige" la forme courante, c'est a dire, la forme est inseree dans la matrice *)
let final_insert(cur, shape, mymat : t_cur_shape * t_point list * t_color matrix) : unit =
  for i = 0 to len(shape)-1
  do
    let cur_point : t_point = nth(shape,len(shape) - 1 - i) and
        cur_base : t_point = !(cur.base) in
    let line : int = cur_base.y + cur_point.y  and
        column : int = cur_base.x + cur_point.x  in
    mymat.(column).(line) <- !(cur.color);
  done;
;;

(* Fonction realisee par Ronan PLUTA *)
let final_newstep(pl : t_play) : bool =
  let cur : t_cur_shape = pl.cur_shape in
  let moving_shape : t_point list = (pl.par.shapes).value.(!(cur.shape)).shape in
  let free : bool = is_free_move({x= (!(cur.base)).x; y= (!(cur.base)).y -1}, moving_shape, pl.mat, pl.par) in
  if free
  then
    (false)
  else (
    final_insert(cur, moving_shape, pl.mat);
    clear_play(pl);
    let next_shape : t_cur_shape = cur_shape_choice(pl.par.shapes, pl.par.mat_szx, pl.par.mat_szy, pl.par.graphics.color_arr, pl.par.graphics.background_color) in
    pl.cur_shape.base := !(next_shape.base);
    pl.cur_shape.shape := !(next_shape.shape);
    pl.cur_shape.color := !(next_shape.color);
    let shape_pt : t_point list = (pl.par.shapes).value.(!(pl.cur_shape.shape)).shape in
    not(insert(pl.cur_shape, shape_pt, pl.par, pl.mat))
  )
;;

(* --------------------- *)
(* --------------------- *)
(*   Une etape de jeu    *)
(* --------------------- *)
(* --------------------- *)

let newstep(pl, new_t, t, dt : t_play * float ref * float * float) : bool = 
  let the_end : bool ref = ref (!new_t -. t > dt) and dec : bool ref = ref false in
  let dir : char ref = ref 'x' and notmove : bool ref = ref false in
    (
    while not(!the_end)
    do 
      if key_pressed()
      then dir := read_key()
      else () ;
      dec := move(pl, !dir) ;
      dir := 'x' ; 
      new_t := Sys.time() ;
      the_end := !dec || (!new_t -. t > dt) ;
    done ; 
    if !dec 
    then (move_at_bottom(pl) ; notmove := true)
    else notmove := not(move_down(pl)) ;
    if !notmove
    then the_end := final_newstep(pl)
    else the_end := false;
    !the_end;
    )
;;

(* ------------------------ *)
(* ------------------------ *)
(*    Fonction principale   *)
(* ------------------------ *)
(* ------------------------ *)

let jeuCP2() : unit =
  let pl : t_play = init_play() in
  let t : float ref = ref (Sys.time()) and new_t : float ref = ref (Sys.time()) in
  let dt : float ref = ref (time_init(pl.par)) and t_acc : float ref = ref (Sys.time()) in
  let the_end : bool ref = ref false in
    while not(!the_end)
    do
      the_end := newstep(pl, new_t, !t, !dt) ; 
      if ((!new_t -. !t_acc) > time_extent(pl.par))
      then 
        (
        dt := !dt *. time_ratio(pl.par) ; 
        t_acc := !new_t
        ) 
      else () ;
      t := !new_t
    done;
    Printf.printf "You won %i points\n"  !(pl.score);
;;

clear_graph();;
jeuCP2();;
