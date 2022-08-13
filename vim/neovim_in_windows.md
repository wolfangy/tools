1. Install *chocolatey*

2. Install python 2.7

    `choco installl python2`

3. Install python 3.x

    `choco install python3`

* make symbolic link to python both 

    `MKLINK /H C:\Python27\python2.exe C:\Python27\python.exe`
    `MKLINK /H C:\Python39\python3.exe C:\Python39\python.exe`

4. Install ruby & gem

    `choco install ruby`

5. Install lua

    `choco install lua`

6. Install neovim

    `choco install neovim`

7. Install neovim provider
    
    * for python2:
        `python2 -m pip install --user --upgrade pynvim`
        `python2 -m pip install --user --upgrade neovim`

    * for python3:
        `python3 -m pip install --user --upgrade pynvim`
        `python3 -m pip install --user --upgrade neovim`

8. Installl `Hack` font

9. Install Windows Terminal and press `<C-,>` to config the profile

10. Create the nvim configuration file: 
    * for all `~/AppData/Local/nvim/init.vim`
    * for GUI `~/AppData/Local/nvim/ginit.vim`

11. Install Plugs manager

12. Regular settings

13. Keybindings:
    
    * Set `<leader>` key
    * remap the `Esc` key to `;;`
