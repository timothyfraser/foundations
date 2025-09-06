# Course Setup Guide 

Welcome to the course setup guide! This comprehensive documentation will walk you through everything you need to get your development environment ready for this lab class. Follow these steps carefully to ensure you have all the necessary tools and configurations.

## 🎯 What This Setup Accomplishes

By the end of this setup, you will have:
- A complete development environment for both Python and R programming
- Git version control for tracking your code changes
- An AI-powered code editor (Cursor) with helpful extensions
- Local language model capabilities for offline AI assistance
- All necessary dependencies and packages installed

## Your Complete Setup Checklist

### Step 1: Install Git (Version Control)
- **Download and install [Git](https://git-scm.com/downloads)**
  - **What is Git?** Git is a version control system that tracks changes in your code files. It's essential for collaborating, backing up your work, and managing different versions of your projects.
  - **What you get:** Git Bash (command line interface) and Git GUI
  - **Why you need it:** You'll use Git to clone course repositories, submit assignments, and track your code changes

### Step 2: Install LM Studio (Local AI Assistant)
- **Download and install [LM Studio](https://lmstudio.ai/download)**
  - **What is LM Studio?** A desktop application that allows you to run large language models locally on your computer
  - **Why you need it:** Provides AI assistance even when you're offline, helps with code explanations, and offers privacy for your code
  - **How it helps:** You can ask questions about your code, get debugging help, and learn programming concepts

### Step 3: Install Programming Languages
- **Install [Python](https://www.python.org/downloads/)**
  - **What is Python?** A versatile programming language widely used in data science, web development, and automation
  - **Installation tip:** Make sure to check "Add Python to PATH" during installation
  - **Verify installation:** Open terminal/command prompt and type `python --version`

- **Install [R](https://cran.r-project.org/bin/windows/base/)**
  - **What is R?** A statistical programming language designed for data analysis and visualization
  - **Note:** If you installed RStudio, R is automatically included
  - **Verify installation:** Open RStudio or type `R --version` in terminal

### Step 4: Choose and Install Your IDE (Code Editor)
- **Install your preferred IDE:**
  - **[VS Code](https://code.visualstudio.com/download)** - Free, lightweight, and highly customizable
  - **[Cursor](https://cursor.com/)** - AI-powered editor with built-in AI assistance (1 year free for students)
  - **[RStudio](https://posit.co/download/rstudio-desktop/)** - Specialized for R development with excellent data science features

**💡 Recommendation:** We highly recommend **Cursor** for this course as it provides AI assistance that can help you learn and debug code more effectively.

### Step 5: (In your Code Editior, e.g.Cursor) Configure Your Shell Environment
- **Update your `.bashrc` file**
  - **What is .bashrc?** A configuration file that runs commands every time you open a new terminal session
  - **Why update it?** Ensures your development tools are properly configured and accessible

- **Open Git Bash terminal and load settings**
  - Run: `source .bashrc`
  - **What this does:** Applies your configuration changes to the current terminal session

### Step 6: Install Course Dependencies
- **Run the dependency installation script**
  - Execute: `source setup/dependencies.sh`
  - **What this does:** Installs all required Python packages and R libraries for the course
  - **Expected time:** 5-15 minutes depending on your internet connection

### Step 7: Install Recommended Extensions (Cursor Users)
- **Install the extensions listed in the section below**
  - **Why extensions?** They enhance your coding experience with features like syntax highlighting, debugging tools, and language support

### Step 8: Test Your Setup
- **Create a test file and run it**
  - Try creating a simple Python script or R script
  - Verify that you can run code without errors
  - **Success indicator:** No error messages when running basic code

## 🚀 Ready to Code!
Once you've completed all steps, you're ready to start coding! Your development environment is now fully configured for this course.

## 🔧 Installing Cursor Extensions

If you're using Cursor as your IDE, these extensions will significantly enhance your development experience. Each extension serves a specific purpose to make coding more efficient and enjoyable.

### How to Install Extensions in Cursor:

**Method 1: Extensions Panel (Recommended)**
1. Open Cursor
2. Press `Cmd+Shift+X` (macOS) or `Ctrl+Shift+X` (Windows/Linux) to open the Extensions panel
3. Search for each extension by name and click "Install"
4. Wait for installation to complete

**Method 2: Command Palette**
1. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
2. Type "Extensions: Install Extensions"
3. Search and install each extension

### Recommended Extensions by Category:

#### **🔧 Essential Extensions (Install These First):**
- **Bracket Pair Colorizer 2**
  - **Purpose:** Colorizes matching brackets, parentheses, and braces
  - **Why you need it:** Makes nested code structures much easier to read and debug
  - **Example:** Helps you quickly spot unmatched brackets in complex code

- **Code Runner**
  - **Purpose:** Run code snippets or entire files with a single click
  - **Why you need it:** Quick testing and debugging without switching to terminal
  - **How to use:** Right-click in your code file and select "Run Code"

- **GitHub Pull Requests**
  - **Purpose:** Review and manage GitHub pull requests directly in Cursor
  - **Why you need it:** Streamlines collaboration and code review processes
  - **Features:** View diffs, leave comments, merge requests without leaving your editor

#### **Python Development Extensions:**
- **Python** (by Microsoft)
  - **Purpose:** Complete Python language support
  - **Features:** IntelliSense, linting, debugging, formatting, refactoring
  - **Why essential:** Provides autocomplete, error detection, and debugging capabilities
  - **Installation note:** This is the most important extension for Python development

- **Python Debugger**
  - **Purpose:** Enhanced debugging support for Python applications
  - **Features:** Breakpoints, variable inspection, step-through debugging
  - **When to use:** Essential for troubleshooting complex Python code

#### **R Development Extensions:**
- **R** (by Yuki Ueda)
  - **Purpose:** R language support with syntax highlighting and IntelliSense
  - **Features:** Code completion, syntax highlighting, error detection
  - **Why important:** Makes R development much more efficient in Cursor

- **R Syntax**
  - **Purpose:** Enhanced R syntax highlighting and language features
  - **Features:** Better color coding for R-specific functions and data types
  - **Benefit:** Improves code readability and reduces syntax errors

- **Shiny**
  - **Purpose:** Support for R Shiny web applications
  - **When to use:** If you plan to create interactive web applications with R
  - **Features:** Syntax highlighting for Shiny-specific functions

### 🚀 Quick Setup Commands:

After installing extensions, reload your terminal configuration:
```bash
source .bashrc
```

## 🆘 Troubleshooting Common Issues

### Problem: "Command not found" errors
**Solution:** 
1. Make sure you've added Python/R to your system PATH
2. Restart your terminal after installation
3. Run `source .bashrc` to reload configurations

### Problem: Extensions not installing
**Solution:**
1. Check your internet connection
2. Restart Cursor and try again
3. Make sure you have the latest version of Cursor

### Problem: Dependencies script fails
**Solution:**
1. Ensure you have Python and/or R properly installed
2. Check that you have internet access
3. Try running the script with administrator/sudo privileges if needed

### Problem: Git not recognized
**Solution:**
1. Restart your computer after Git installation
2. Open a new terminal window
3. Verify installation with `git --version`

### Problem: Python installation issues
**Solution:**
1. Make sure to check "Add Python to PATH" during installation
2. Try installing Python from the Microsoft Store (Windows) or using Homebrew (Mac)
3. Verify installation with `python --version` or `python3 --version`
4. If multiple Python versions exist, use `python3` instead of `python`

### Problem: R installation not working
**Solution:**
1. Download R from the official CRAN website, not third-party sources
2. On Windows, make sure to run the installer as administrator
3. On Mac, you might need to allow the installation in System Preferences > Security & Privacy
4. Try installing RStudio first, as it includes R automatically

### Problem: LM Studio not starting or crashing
**Solution:**
1. Make sure your computer meets the minimum system requirements (If you're using MAC+Intel, you can use Ollama instead: https://ollama.com/)
2. Update your graphics drivers
3. Try running LM Studio as administrator
4. Check if your antivirus is blocking the application
5. Restart your computer and try again

### Problem: Cursor extensions not working properly
**Solution:**
1. Reload the window: `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows), then type "Developer: Reload Window"
2. Check if the extension is enabled in the Extensions panel
3. Try disabling and re-enabling the extension
4. Make sure you have the correct file type open (e.g., .py for Python extensions)

### Problem: Terminal/Command Prompt issues
**Solution:**
1. Try using a different terminal (Git Bash, PowerShell, or Command Prompt)
2. Check if your PATH environment variable is set correctly
3. Restart your computer to ensure all environment variables are loaded
4. On Windows, try running commands in Command Prompt as administrator

### Problem: Permission denied errors
**Solution:**
1. On Mac/Linux, try using `sudo` before the command
2. On Windows, run Command Prompt as administrator
3. Check if the file or directory has the correct permissions
4. Make sure you're in the correct directory

### Problem: Internet connection issues during installation
**Solution:**
1. Check your internet connection and try again
2. If using a corporate/school network, check if certain websites are blocked
3. Try using a different network (mobile hotspot, different WiFi)
4. Some installations can be done offline - check if offline installers are available

### Problem: Antivirus blocking installations
**Solution:**
1. Temporarily disable your antivirus during installation
2. Add the installation directories to your antivirus whitelist
3. Check your antivirus quarantine for any blocked files
4. Try installing from official sources only

### Problem: Disk space issues
**Solution:**
1. Free up disk space by deleting unnecessary files
2. Clear your Downloads folder and browser cache
3. Uninstall unused programs
4. Use disk cleanup tools (Windows) or Storage Management (Mac)

### Problem: Multiple versions of Python/R causing conflicts
**Solution:**
1. Use virtual environments for Python projects
2. Specify the full path to the version you want to use
3. Consider using version managers like pyenv (Python) or renv (R)
4. Uninstall old versions if they're not needed

### Problem: File path issues on Windows
**Solution:**
1. Use forward slashes (/) instead of backslashes (\) in file paths
2. Avoid spaces in folder names
3. Use quotes around file paths with spaces: `"C:\Program Files\Python"`
4. Consider using Git Bash instead of Command Prompt for better path handling

## 📚 Additional Resources

### Learning Git:
- [Git Tutorial for Beginners](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)
- [GitHub Learning Lab](https://lab.github.com/)

### Python Resources:
- [Python.org Tutorial](https://docs.python.org/3/tutorial/)
- [Real Python](https://realpython.com/)

### R Resources:
- [R for Data Science](https://r4ds.had.co.nz/)
- [RStudio Education](https://education.rstudio.com/)

## 🎉 You're All Set!

Congratulations! You now have a fully configured development environment. If you encounter any issues during setup, don't hesitate to reach out to your course assistant or check the troubleshooting section above.

**Next Steps:**
1. Complete the setup checklist above
2. Test your installation with a simple "Hello World" program
3. Explore the course materials and start coding!

Happy coding! 

