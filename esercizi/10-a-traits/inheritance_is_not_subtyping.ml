class point (a : int) (b : int) =
 object(_ : 'self)
   val x = a
   val y = b
   method get_x = x
   method copy_x (o : 'self) = {< x = o#get_x >}
 end

class colored_point a b (c : string) =
 object
  inherit point a b
  val color = c 
  method copy_x (o : 'self) = {< x = o#get_x ; color = o#get_color >}
  method get_color = color
  method set_color x = {< color = x >}
 end

class colored_point' (a : int) (b : int) (c : string) =
 object(_ : 'self)
   val x = a
   val y = b
   val color = c 
   method get_x = x
   method copy_x (o : 'self) = {< x = o#get_x ; color = o#get_color >}
   method get_color = color
   method set_color x = {< color = x >}
 end

class java_colored_point (a : int) (b : int) (c : string) =
 object(_ : 'self)
   val x = a
   val y = b
   val color = c 
   method get_x = x
   method copy_x (o : point) = {< x = o#get_x >}
   method copy_x' (o : 'self) = {< x = o#get_x ; color = o#get_color >}
   method get_color = color
   method set_color x = {< color = x >}
 end

let f (x : java_colored_point) = (x :> point)
(* Bad! *)
let f (x : colored_point) = (x :> point)
