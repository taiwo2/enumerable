def my_map(arr)
    #     new=[]
    #   arr.each {|ele| new << prc.call(ele) }
    #   new
    #     new=[]
    #     i=0
    #     while i < arr.length
    #         new << prc.call(arr[i])
    
    #         i +=1
    #     end
    #     new
        
        new=[]
        i=0
        while i < arr.length
            new << yield(arr[i])
    
            i +=1
        end
        new
    end
    
    def my_select(arr,&prc)
        selected=[]
    #   arr.each do |ele| 
    #     if prc.call(ele) == true
    #         selected << ele
    #     end
    #   end
    #    selected
    
         i =0
         while i < arr.length
            if prc.call(arr[i]) == true
                selected << arr[i]
            end
            i +=1
        end
        selected
    end
    
    def my_count(arr,&prc)
        count =0
        arr.each do |ele| 
            if prc.call(ele) 
                count +=1
            end
        end
        count
    end
    
    def my_any?(arr,&prc)
        # i =0
        # while i < arr.length
        #     if  prc.call(arr[i]) == true
        #         return true     
        #     end
        #     i +=1
        # end
        #   false
    
        arr.each do |ele|
            if  prc.call(ele) == true
                return true     
            end
        end
          return false
    end
    
    def my_all?(arr,&prc)
         arr.each do |ele|
            if  prc.call(ele) == false
                return false    
            end
         end
            true
    end
    
    def my_none?(arr,&prc)
        arr.each do |ele|
            if  prc.call(ele) == true
                return false  
            end
         end
            true  
    end