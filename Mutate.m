function y = Mutate(x,mu) %x : input chromosome || mu : mutation rate || y : mutated version

         flag = rand( size( x ) < mu );
         
         y = x;
         
         y( flag ) = 1 - x( flag );
end