# Course Setup Guide

Welcome to the course setup guide! 🎉  
This documentation will walk you through everything you need to get your computer ready for this lab class. Follow each step carefully to ensure your environment is fully configured.

---

## 🎯 What This Setup Accomplishes

By the end of this setup, you will have:
- Git version control for tracking and submitting code
- A local AI-powered assistant (LM Studio)
- Python and/or R installed and ready
- An IDE (Cursor, VS Code, or RStudio) with recommended extensions
- Your environment configured with all required dependencies
- A test-verified setup so you can start coding right away

---

## ✅ Your Complete Setup Checklist

### Step 1: Install Git (Version Control)
- **Download and install [Git](https://git-scm.com/downloads)**  
  - **What is Git?** A version control system to track code changes, collaborate, and manage assignments  
  - **What you get:** Git Bash (command line) and Git GUI  
  - **Verify installation:** Run `git --version` in your terminal  

---

### Step 2: Install LM Studio (Local AI Assistant)
- **Download and install [LM Studio](https://lmstudio.ai/download)**  
  - **What is LM Studio?** A desktop app for running large language models locally  
  - **Why you need it:** Provides AI coding help, even offline  
  - **Alternative:** On Intel-based Macs, you can use [Ollama](https://ollama.com/)  

---

### Step 3: Install Programming Languages
You’ll need at least one programming language for this course:

- **Python**  
  - [Download Python](https://www.python.org/downloads/)  
  - ✅ Check "Add Python to PATH" during installation  
  - Verify with: `python --version` or `python3 --version`

- **R**  
  - [Download R](https://cran.r-project.org/bin/windows/base/)  
  - If you installed **RStudio**, R is already included  
  - Verify with: `R --version`

---

### Step 4: Choose and Install Your IDE (Code Editor)
Pick one IDE for coding (you may install more if you’d like):
- [Cursor](https://cursor.com/) – AI-powered editor (recommended, free 1 year for students)  
- [VS Code](https://code.visualstudio.com/download) – Popular, lightweight, customizable  
- [RStudio](https://posit.co/download/rstudio-desktop/) – Best choice if focusing on R  

💡 **Recommendation:** Use Cursor — it integrates AI help directly into your editor.

---

### Step 5: Configure Your Shell Environment
1. Open **Cursor** (or your IDE).  
2. Update your **`.bashrc`** file (your terminal configuration).  
3. Open a **Git Bash** terminal and run:  
   ```bash
   source .bashrc


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
