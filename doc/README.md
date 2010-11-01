`wip` README
============================================================================

  > NOTE: `wip` is WIP

`wip` is a concept I'm playing with for streamlining the process of
coding for and documenting client and personal software projects.

While this document (specifically) and the idea (generally) are
"work-in-progress", I've got a good sense of where I want to go with this
and will, in fact, be using the techniques described herein for this project
itself.


`wip` *works* (in theory)
----------------------------------------------------------------------------

A *work* is made up of:

  * Notes
  * Code
  * ...?

The goal is to create an experience in which working on a given client or
personal project is:

  * easy to initialize
  * easy to customize per the project needs
  * has notes which are (optionally) maintained outside of the project's
    codebase, yet are:
      * version-controlled
      * easily accessible from multiple desktops, web browsers, and mobile
        devices
      * authored in such a way as to be sensible in those environments
  * has a workspace which is easily customizable to the needs of the
    specific project in question and in which:
      * work-in-progress changes are automatically version-controlled,
        allowing for the tracking (and recovery of) any effort made, while
        leaving it up to the developer(s) to determine when there is a
        meaningful chunk of effort to commit the the project "proper".
      * exportable/shareable... the project's setup may be shared with the
        team-at-large, while allowing for "local" preferences as well.


`wip` *works* (NOW)
----------------------------------------------------------------------------

`wip`, currently, is a rubygem that installs an executable and a bash
function (`wip`, as it turns out) which together assist with navigating to
and "activating" a given *work* (project workspace, for now).

The following is an example shell session, using `wip` as it exists now:

    # given `wip` is installed .............................................


    # `wip index` ... list "works"
    # ......................................................................
    corey@computer ~  $ wip index .

    corey@computer ~  $ echo "echo 'working on wip...'" > \
                        Workspace/com.github/coreyti/wip/.wiprc

    corey@computer ~  $ wip index .
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip

    corey@computer ~  $ echo "echo 'working on help...'" > \
                        Workspace/help/.wiprc

    corey@computer ~  $ wip index .
      * help
        /Users/corey/Workspace/help
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip



    # `wip index` ... narrowing the scope & speeding things up
    # ......................................................................
    corey@computer ~  $ wip index .
      * help
        /Users/corey/Workspace/help
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip

    corey@computer ~  $ wip index ~/Workspace/com.github
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip



    # `wip index` ... defaults
    # ......................................................................
    corey@computer ~  $ wip index                   # no arg to `wip index`
      * help
        /Users/corey/Workspace/help
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip

    corey@computer ~  $ wip                         # no arg to `wip`
      * help
        /Users/corey/Workspace/help
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip



    # `wip show` ... activate a "work"
    # ......................................................................
    corey@computer ~  $ pwd
    /Users/corey

    corey@computer ~  $ wip show wip
    -------------------------------------------------------------------------------
     work : /Users/corey/Workspace/com.github/coreyti/wip
    -------------------------------------------------------------------------------
    working on wip...

    corey@computer wip (git::master) $ wip            # scoped `wip index`
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip

    corey@computer wip (git::master) $ pwd
    /Users/corey/Workspace/com.github/coreyti/wip



    # `wip show` ... default: `wip ARG` to `wip show ARG`
    # ......................................................................
    corey@computer wip (git::master) $ cd ~

    corey@computer ~  $ wip .

    corey@computer ~  $ wip wip
    ------------------------------------------------------------------------
     work : /Users/corey/Workspace/com.github/coreyti/wip
    ------------------------------------------------------------------------
    working on wip...

    corey@computer wip (git::master) $ wip .
    ------------------------------------------------------------------------
     work : /Users/corey/Workspace/com.github/coreyti/wip
    ------------------------------------------------------------------------
    working on wip...

    corey@computer wip (git::master) $ pwd
    /Users/corey/Workspace/com.github/coreyti/wip



    # `wip show` ... with a path
    # ......................................................................
    corey@computer wip (git::master) $ cd ~

    corey@computer ~  $ wip foo

    corey@computer ~  $ wip show foo

    corey@computer ~  $ wip show ~/Workspace/com.github/

    corey@computer ~  $ wip show ~/Workspace/com.github/coreyti/wip
    ------------------------------------------------------------------------
     work : /Users/corey/Workspace/com.github/coreyti/wip
    ------------------------------------------------------------------------
    working on wip...

    corey@computer wip (git::master) $ pwd
    /Users/corey/Workspace/com.github/coreyti/wip



    # `wip help`
    # ......................................................................
    corey@computer wip (git::master) $ cd ~

    corey@computer ~  $ wip index .
      * help
        /Users/corey/Workspace/help
      * wip
        /Users/corey/Workspace/com.github/coreyti/wip

    corey@computer ~  $ wip help
    Tasks:
      wip-ruby back         # Move to and activate most recent 'work'
      wip-ruby help [TASK]  # Describe available tasks or one specific task
      wip-ruby index        # List all indexed 'works'
      wip-ruby show         # Move to and activate a 'work'

    corey@computer ~  $ wip show help
    ------------------------------------------------------------------------
     work : /Users/corey/Workspace/help
    ------------------------------------------------------------------------
    working on help...

    corey@computer help  $ pwd
    /Users/corey/Workspace/help



    # `wip back`
    # ......................................................................
    corey@computer help  $ cd ~

    corey@computer ~  $ wip show wip
    ------------------------------------------------------------------------
     work : /Users/corey/Workspace/com.github/coreyti/wip
    ------------------------------------------------------------------------
    working on wip...

    corey@computer wip (git::master) $ cd ~/Documents/

    corey@computer Documents  $ wip back
    ------------------------------------------------------------------------
     work : /Users/corey/Workspace/com.github/coreyti/wip
    ------------------------------------------------------------------------
    working on wip...

    corey@computer wip (git::master) $ pwd
    /Users/corey/Workspace/com.github/coreyti/wip


Assumptions & Intentional Limitations
----------------------------------------------------------------------------

  > Most of the following are irrelevant for now. Once `wip` does more
  > though...

  1. I develop with:
     * an Apple computer
     * an iPhone
     * a :)
  2. I strongly prefer TextMate to RubyMine (etc.), so no effort has been
     made to adjust these concepts and tools for other editors/IDEs.
  3. I hope to never again have to use CVS, Perforce, SourceSafe, ClearCase,
     SVN (in chronological order of my use) etc. over Git. So, as with
     editor-specific points, these recommendations assume the use of Git as
     the version control tool in place.


On "Notes"
----------------------------------------------------------------------------

  > Most of the following are irrelevant for now. Once `wip` does more
  > though...

  * backed by DropBox
  * on-the-fly versioned, with git-wip
  * in Markdown syntax
  * authored to be viewable/editable within Textforce on the iPhone


On "Code"
----------------------------------------------------------------------------

TODO


Scratch Pad
----------------------------------------------------------------------------

  * Here is an edit of this file, as navigated to within the git project.
    Note that the `README` at the project's root is a symlink to this file.
    As such, **DO NOT** edit that file (which Textmate allows).
  * Here is an edit of this file, as navigated to through the Dropbox path
    (which symlinks to the `doc` folder).
  * Here is an edit of this file, as loaded in Textforce on my iPhone and
    auto-sync'd back to my MacBook by way of Dropbox.


