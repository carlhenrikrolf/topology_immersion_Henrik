def ripser_to_dict(file,thr):
    data = dict()
    data['file'] = file
    

    with open(file, 'r') as f:
        
        # first line
        line = f.readline()
        word = line.split(' ')
        data['nb_neuron'] = int(word[3])
        
        # second line
        line = f.readline()
        word = line.split(' ')
        data['range'] = 'not implemented' #[float(w) for w in word[2][1:-2].split]

        # parse until the end of the line
        for line in f:
            if 'persistence' in line:
                key = int(line[29:-2])
                data[key] = []
            else:
                word = line.split(',')
                if not len(word) == 2:
                    print('Unexpected number of word: ',word)
                    break
                if ' ' in word[1]:
                    word_2 = thr
                else:
                    word_2 = float(word[1][:-2])
                data[key].append([float(word[0][2:]),word_2])
            
    # post processing
    temp = []
    for k,v in data.items():
        if v == []:
            temp.append(k)
        elif type(k) == int:
            data[k] = np.array(v)
            
        for k in temp:
            data.pop(k)
        
        return data