import matplotlib.pyplot as plt
import numpy as np

def plot_persistence(data,params,**kwargs):
    
    """Arguments in are (0) a dictionary and (1) parameters"""
    
    # Extract parameters
    dim = params['ripser']['dim']
    thr = params['ripser']['max_persistence']
    
    # Plot figure
    fig = plt.figure(figsize = (8,8))
    ax = fig.add_subplot(1,1,1)
    ax.plot([0,thr],[0,thr],'k')
    for d in range(dim+1):
        if d in data:
            data_array = np.array(data[d])
            ax.plot(data_array[:,0],data_array[:,1],'x',label='dim = '+str(d),clip_on=False)
            data_array = []
    ax.set_xlabel('birth')
    ax.set_ylabel('death')
    ax.axis([0,thr,0,thr])
    ax.legend(numpoints=1,loc=4)
    
    # Create title with parameter info
    if 'title' in kwargs:
        ax.set_title(kwargs['title'])
    
    return fig
    