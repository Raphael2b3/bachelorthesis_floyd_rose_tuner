
if __name__ =="__main__":
    weights = [0.35,0.2,0.3,0.15]
    values = [[3,9.5,3,7],
              [7,7,7,9.5],
              [6.5,6,7,6],
              [8,4.5,9,5]]
    
    for j in range(4):
        sum = 0
        for i in range(4):
            sum += values[j][i]*weights[i]
        print(sum)