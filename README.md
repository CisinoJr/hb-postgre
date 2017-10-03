# hb-postgre
This is a simple project example of how to do CRUD operations into PostgreSQL using Harbour/HMG 3.4.3.

<h3>1. How to Build:</h3><br />
<ul>
	<li><b>1.1</b> You will need some .dll files that you can find in your PostgreSQL bin folder. If you compile your software in 32-bit, the .dlls should be 32-bits (you can install a 64-bit version of PostgreSQL and download the 32-bit dll at postgre's web site, i used 32-bits for this example). There is the files name you may need: libiconv-2.dll, libintl-8.dll, libpq.dll. I'll leve with this example a folder with some 32-bits dlls.
  </li>
	<li><b>1.2</b> Change the path to the harbour libs and include files into the hb-postgre.hbc file</li>
	<li><b>1.3</b> Download and install HMG IDE 3.4.3 or later at http://www.hmgforum.com/app.php/page/download</li>
</ul>
  
<blockquote><h4> Note: I do not compile my projects directly by using hbmk2 at the command line. I'd rather use the HMG IDE to compile and make the GUI. But if you have experience with hbmk2 and you was able to compile this way, please send me the instructions, so I can put this build option here as well.</h4></blockquote>
  
<hr>

<h3> 2.0 How to configure postgreSQL credentials.</h3> <br />
<ul>
  <li>
    <b>2.1</b> Just execute the hb-postgre.exe file, it will display a window to you put your credentials. Or search for the config.ini file into the project's folder, open and edit.		
    </li>
</ul>

<hr>
 
<h3>License</h3>
    This software is under the <a href="https://github.com/CisinoJr/hb-postgre/blob/master/LICENSE" target="_blank">GNU General Public License v3.0</a>
