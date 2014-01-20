function str = print_difference_equation(Ak, Bk)
   
   if length(Ak) ~= length(Bk)
      return 
   end
   
   x = '';
   y = '';
   
   for n = 1:length(Ak)
       coefficientA = num2str(abs(Ak(n)));
       
       if coefficientA == '1'
          coefficientA = '';
       end
       
       coefficientB = num2str(abs(Bk(n)));
       
       if coefficientB == '1'
          coefficientB = '';
       end

       
       if n == 1
          x = strcat(x, coefficientA, 'x[n]'); 
          y = strcat(y, coefficientB, 'y[n]');
       else
          if Ak(n) ~= 0 
             sign = '+';
             if Ak(n) < 0
                sign = ' - ';
             end
             y = strcat(y, sign, coefficientA, 'y[n - ' ,num2str(n-1), ']');
          end
          
          if Bk(n) ~= 0 
             sign = '+';
             if Bk(n) < 0
                sign = ' - ';
             end

              x = strcat(x, sign, coefficientB, 'x[n - ' ,num2str(n-1), ']');
          end
       end   
   end
   
   fprintf('%s = %s\n', y, x)
   str = strcat(y, ' = ', x);

end