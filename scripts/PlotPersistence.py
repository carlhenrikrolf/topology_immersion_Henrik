import matplotlib.pyplot as plt
import numpy as np

def plot_persistence(data,params):
    dim = params['dim']
    thr = params['max_persistence']
    fig = plt.figure(figsize = (8,8))
    ax = fig.add_subplot(1,1,1)
    ax.plot([0,thr],[0,thr],'k')
    for d in range(dim+1):
        data_array = np.array(data[d])
        ax.plot(data_array[:,0],data_array[:,1],'x',label='dimension '+str(d))
        data_array = []
    ax.legend(loc=4)
    ax.set_xlabel('birth')
    ax.set_ylabel('death')
    ax.axis([0,thr,0,thr])
    title = params.copy()
    del title['dim']
    del title['max_persistence']
    ax.set_title('persistence diagram with parameters:\n' + str(title))
    return fig
    