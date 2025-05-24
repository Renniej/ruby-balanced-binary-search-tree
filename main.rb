require_relative "tree"

def main
   arr = Array.new(15) { rand(1..100) }
   tree = Tree.new(arr)
   tree.pretty_print
   puts "Balanced? #{(tree.balanced?) ? "Balanced" : "Not Balanced"}"

end

main()