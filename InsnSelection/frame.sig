signature FRAME =
sig
  type frame
  type access
  val FP : Temp.temp
  val RV : Temp.temp (*as seen by callee*)
  val wordsize : int

  val newFrame : {name: Temp.label, formals: bool list} -> frame
  val name : frame -> Temp.label
  val formals : frame -> access list
  val allocLocal : frame -> bool -> access
  
  val exp : access -> Tree.exp -> Tree.exp
  
  val externalCall : string * Tree.exp * Tree.exp -> Tree.exp
  
  val procEntryExit1 : frame * Tree.stm -> Tree.stm
  val procEntryExit2 : frame * Assem.instr list -> Assem.instr list
  val procEntryExit3 : frame * Assem.instr list -> {prolog: string, body: Assem.instr list, epilog: string}
  datatype frag = PROC of {body: Tree.stm, frame: frame}
                | STRING of Temp.label * string
                
  val tempMap: register Temp.Table.table
end