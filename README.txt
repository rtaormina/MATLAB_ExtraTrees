"Update August, 2015: The toolbox can now implement Extra-Trees for classification problems as well as regression problems"

The MATLAB_ExtraTrees package is a MATLAB implementation of the Extremely Randomized Trees (Extra-Trees)
proposed by Geurts et al. in 

 		Geurts, P., D. Ernst, and L. Wehenkel (2006), Extremely randomized trees, Mach. Learn., 63(1), 3–42

The user is referred to the original publication for details regarding the algorithm. 

Further details can be found in 

		Galelli, S., and A. Castelletti (2013), Assessing the predictive capability of randomized tree-based ensembles 
 		in streamflow modelling, Hydrol. Earth Syst. Sci., 17, 2669–2684.

The algorithm also provides the scores (relative variance reduction) associated with each candidate input. 
These scores can be used to implement the Iterative Input variable Selection (IIS) algorithm of Galelli and Castelletti proposed in

 		Galelli, S., and A. Castelletti (2013), Tree-based iterative input variable selection for hydrological modeling, 
 		Wate Resour. Res., 49(7), 4295–4310.
		
A MATLAB toolbox that uses MATLAB_ExtraTrees to implement the IIS technique can be found at https://github.com/stefano-galelli/MATLAB_IterativeInputSelection


!!! This software requires the MATLAB Statistical Toolbox. Soon it will be changed so that only the core MATLAB module will be   
    needed for the execution !!!  

Copyright 2015 Ahmad Alsahaf 
Research fellow, Politecnico di Milano 
ahmadalsahaf@gmail.com 

Copyright 2014 Riccardo Taormina 
Ph.D. Student, Hong Kong Polytechnic University  
riccardo.taormina@gmail.com 

Acknowledgements to Dr. Stefano Galelli, Singapore University of Technology and Design

This software is under the GNU General Public License. 
Please read the text version of the license included with the package (gpl.txt).
