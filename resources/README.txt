MTIDS Resource path

Contains informations about the project and its source code.

Documentation of m-functions can be generated using m2html, which creates webbased pages. Unzip the m2html.zip folder and place MTIDS directory as a child folder. This in necessary due to m2thml. Make shure, the m2html-directory is added to MATLABs search path. If MTIDS is located in the first subfolder of m2html, then run the following command:
m2html('mfiles','mtids','htmldir','doc','recursive','on','global','on','graph','on')
[ Short explanation: 'mtids' - folder of your mtids checkout, 'doc' - name of the created directory, in which the documentation will be placed, 'recursive on' - searchs in all child folders for m-files, 'global on' - shows dependencies between functions, 'graph on' - creates a dependency graph ]
More information with the help function "help m2html" in MATLAB or at the m2html webpage: http://www.artefact.tk/software/matlab/m2html/.
