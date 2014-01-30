ret
===

CLI Storable store editor

Do you use Perl's Storable a lot? I do. And sometimes I need a way to quickly view or edit the store files.

This s a little tool I threw together to enable that.

To view the contents of a store file:

    perl ret.pl mystore.store

To edit that same file:

    perl ret.pl -e mystore.store

Hope you are familiar with Vim...

Finally, if you do the following:

    cp ret.pl /usr/local/bin/ret && chmod +x /usr/local/bin/ret
    
...then you can use `ret` from anywhere
