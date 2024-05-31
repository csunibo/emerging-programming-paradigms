module M = (
  struct
   class point =
    object
     val x = 0
     val y = 0
     method area = x * y
     method private set (a,b) = {< x = a ; y = b >}
   end

   class colored_point =
    object(self)
     inherit point
     val color = "black"
     method get_color = color
     method set2 w = self#set w
    end
 end
:
sig
 class point :
  object
   val x : int
   val y : int
   method area : int
  end
end
)

class colored_point =
 object(self)
  inherit M.point
  val color = "black"
  method get_color = color
  method set2 w = self#set w
 end
