answer = ask('Do you really wanna install this yes/no?', :bold)
fail if answer == 'n'
