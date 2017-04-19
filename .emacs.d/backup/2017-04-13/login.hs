login = do putStr "Enter user name: "
           user <- getLine
           putStr "Enter password: "
           pass <- getLine
           if is_user user pass
               then putStrLn $ user ++ " has logged in"
               else putStrLn "Permission denied."
 where is_user "Taro" "baseball" = True
       is_user "Hanako" "swimming" = True
       is_user _ _                 = False
