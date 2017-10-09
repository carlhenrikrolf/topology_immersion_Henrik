# just some text
import numpy as np

def ripser_to_dict(file,params):
    thr = params['max_persistence']
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
        data['range'] = [float(w) for w in word[2][1:-2].split(',')] #'not implemented' 

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
                    if word_2 > thr:
                        print('max_persistence is too small')
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
