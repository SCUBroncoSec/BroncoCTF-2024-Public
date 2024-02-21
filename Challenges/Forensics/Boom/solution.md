# Solution

This challenge has two main methods of solving. 

The key realization comes from finding out that mbf file format is for Minesweeper. 

If you extract hex data from the mbf file, you can input it on a site like https://www.mzrg.com/js/mine/make_board.html and get the board pre-solved, which shows the flag. 

Another avenue is importing it to a Minesweeper program and playing the game, though it is near impossible to win due to the setup, so people are encouraged to figure out that they can take the content of the files. 
