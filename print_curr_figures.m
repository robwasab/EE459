function print_curr_figures(prefix)

   handles = findobj('Type', 'Figure');
   
   index = 0;
   
   for handle = 1:length(handles)
      filename = strcat(prefix, '_', num2str(handle));
      
      print(handle,'-djpeg', filename);
   end

end