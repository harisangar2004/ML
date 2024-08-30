for i in range(len(best_set)):                                                                                                                                                         
        t = best_set[i][1]                                                                                                                                                                 
        if t >= it and t <= (it + 1*ti):                                                                                                                                                   
            best_set[i][1] = str(it) + "-" + str(it + 1*ti)                                                                                                                                
        elif t >= (it + 1*ti) and t <= (it + 2*ti):                                                                                                                                        
            best_set[i][1] = str(it + 1*ti) + "-" + str(it + 2*ti)                                                                                                                         
        elif t >= (it + 2*ti) and t <= (it + 3*ti):                                                                                                                                        
            best_set[i][1] = str(it + 2*ti) + "-" + str(it + 3*ti)                                                                                                                         
        elif t >= (it + 3*ti) and t <= (it + 4*ti):                                                                                                                                        
            best_set[i][1] = str(it + 3*ti) + "-" + str(it + 4*ti)                                                                                                                         
        elif t >= (it + 4*ti) and t <= (it + 5*ti):                                                                                                                                        
            best_set[i][1] = str(it + 4*ti) + "-" + str(it + 5*ti)                                                                                                                         
    for i in range(len(best_set)):                                                                                                                                                         
        h = best_set[i][2]                                                                                                                                                                 
        if h >= ih and h <= (ih + 1*hi):                                                                                                                                                   
            best_set[i][2] = str(ih) + "-" + str(ih + 1*hi)                                                                                                                                
        elif h >= (ih + 1*hi) and h <= (ih + 2*hi):                                                                                                                                        
            best_set[i][2] = str(ih + 1*hi) + "-" + str(ih + 2*hi)                                                                                                                         
        elif h >= (ih + 2*hi) and h <= (ih + 3*hi):                                                                                                                                        
            best_set[i][2] = str(ih + 2*hi) + "-" + str(ih + 3*hi)                                                                                                                         
        elif h >= (ih + 3*hi) and h <= (ih + 4*hi):                                                                                                                                        
            best_set[i][2] = str(ih + 3*hi) + "-" + str(ih + 4*hi)                                                                                                                         
        elif h >= (ih + 4*hi) and h <= (ih + 5*hi):                                                                                                                                        
            best_set[i][2] = str(ih + 4*hi) + "-" + str(ih + 5*hi)                                                                                                                         
    print("{} -> \n{}".format(1, best_set))                                                                                                                                                
    print("\n{} ->".format(2))                                                                                                                                                             
    print(best_set[2])                                                                                                                                                                     
    print(best_set[3])                                                                                                                                                                     
    find_s(best_set)                                                                                                                                                                       

    instances(best_set)                                                                                                                                                                    
discritize(test_set)
