import matplotlib.pyplot as plt
import numpy as np

def plot_persistence(data,params):
    
    """Arguments in are (0) a dictionary and (1) parameters"""
    
    # Extract parameters
    dim = params['dim']
    thr = params['max_persistence']
    
    # Plot figure
    fig = plt.figure(figsize = (8,8))
    ax = fig.add_subplot(1,1,1)
    ax.plot([0,thr],[0,thr],'k')
    for d in range(dim+1):
        data_array = np.array(data[d])
        ax.plot(data_array[:,0],data_array[:,1],'x',label='dim = '+str(d),clip_on=False)
        data_array = []
    ax.set_xlabel('birth')
    ax.set_ylabel('death')
    ax.axis([0,thr,0,thr])
    ax.legend(numpoints=1,loc=4)
    
    # Create title with parameter info
    title = params.copy()
    del title['dim']
    del title['max_persistence']
    string = 'persistence diagram with the following parameters:\n'
    j = 1
    k = 1
    for i in sorted(title):
        string += str(i) + ' = ' + str(title[i])
        if k < len(title):
            string += ','
            if j > 3:
                j = 1
                string += '\n'
            else:
                j += 1
                string += ' '
        k += 1
    ax.set_title(string)
    
    return fig
    