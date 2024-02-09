class Gtkxsilly < Formula
  desc "GUI toolkit"
  homepage "https://gtk.org/"
  url "https://download.gnome.org/sources/gtk+/2.24/gtk+-2.24.33.tar.xz"
  sha256 "ac2ac757f5942d318a311a54b0c80b5ef295f299c2a73c632f6bfb1ff49cc6da"
  license "LGPL-2.0-or-later"
  revision 1
  conflicts_with "gtk+", because: "this is basically just my shitty modification of it"

  # From https://blog.gtk.org/2020/12/16/gtk-4-0/:
  # "It does mean, however, that GTK 2 has reached the end of its life.
  # We will do one final 2.x release in the coming days, and we encourage
  # everybody to port their GTK 2 applications to GTK 3 or 4."
  #
  # TODO: Deprecate and remove livecheck once `gtk+` has no active dependents
  livecheck do
    skip "GTK 2 was declared end of life in 2020-12"
  end

  depends_on "gobject-introspection" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "atk"
  depends_on "gdk-pixbuf"
  depends_on "hicolor-icon-theme"
  depends_on "pango"

  on_linux do
    depends_on "cairo"
    depends_on "libxcomposite"
    depends_on "libxcursor"
    depends_on "libxdamage"
    depends_on "libxfixes"
    depends_on "libxinerama"
    depends_on "libxrandr"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/03cf8088210822aa2c1ab544ed58ea04c897d9c4/libtool/configure-big_sur.diff"
    sha256 "35acd6aebc19843f1a2b3a63e880baceb0f5278ab1ace661e57a502d9d78c93c"
  end

  # patch :DATA

  # Patch to allow Eiffel Studio to run in Cocoa / non-X11 mode, as well as Freeciv's freeciv-gtk2 client
  # See:
  # - https://gitlab.gnome.org/GNOME/gtk/-/issues/580
  # referenced from
  # - https://bugzilla.gnome.org/show_bug.cgi?id=757187
  # referenced from
  # - https://bugzilla.gnome.org/show_bug.cgi?id=557780
  # - Homebrew/homebrew-games#278
  patch do
    url "https://gitlab.gnome.org/GNOME/gtk/uploads/2a194d81de8e8346a81816870264b3bf/gdkimage.patch"
    sha256 "ce5adf1a019ac7ed2a999efb65cfadeae50f5de8663638c7f765f8764aa7d931"
  end


  patch do
    url "https://raw.githubusercontent.com/MalleeFoul/homebrew-etc/main/patches/gtk%2Bskullfaceemoji.diff"
    sha256 "34b2497f4d2322f883a6a28f5a3ef3e5e09e948ca6e9cc8340bec8158a14d510"
  end
  
  def backend
    backend = "quartz"
    on_linux do
      backend = "x11"
    end
    backend
  end

  def install
    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--enable-static",
                          "--disable-glibtest",
                          # "--enable-relocation",
                          "--enable-introspection=yes",
                          "--with-gdktarget=#{backend}",
                          "--disable-visibility"
    system "make", "install"

    inreplace bin/"gtk-builder-convert", %r{^#!/usr/bin/env python$}, "#!/usr/bin/python"

    # Prevent a conflict between this and `gtk+3`
    libexec.install bin/"gtk-update-icon-cache"
    bin.install_symlink libexec/"gtk-update-icon-cache" => "gtk2-update-icon-cache"
  end

  def caveats
    <<~EOS
      To avoid a conflict with `gtk+3` formula, `gtk-update-icon-cache` is installed at
        #{opt_libexec}/gtk-update-icon-cache
      A versioned symlink `gtk2-update-icon-cache` is linked for convenience.
    EOS
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gtk/gtk.h>

      int main(int argc, char *argv[]) {
        GtkWidget *label = gtk_label_new("Hello World!");
        return 0;
      }
    EOS
    flags = shell_output("pkg-config --cflags --libs gtk+-2.0").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end

# __END__
# diff --git a/gdk/quartz/GdkQuartzWindow.c b/gdk/quartz/GdkQuartzWindow.c
# index dabf051..5963660 100644
# --- a/gdk/quartz/GdkQuartzWindow.c
# +++ b/gdk/quartz/GdkQuartzWindow.c
# @@ -617,7 +617,6 @@ update_context_from_dragging_info (id <NSDraggingInfo> sender)
#  - (void)draggedImage:(NSImage *)anImage endedAt:(NSPoint)aPoint operation:(NSDragOperation)operation
#  {
#    GdkEvent event;
# -  GdkScreen *screen;
 
#    g_assert (_gdk_quartz_drag_source_context != NULL);
 
# @@ -626,7 +625,7 @@ update_context_from_dragging_info (id <NSDraggingInfo> sender)
#    event.dnd.send_event = FALSE;
#    event.dnd.context = _gdk_quartz_drag_source_context;
 
# -  screen = gdk_window_get_screen (event.dnd.window);
# +  GdkScreen* screen = gdk_window_get_screen (event.dnd.window);
 
#    if (screen)
#      {
# @@ -649,6 +648,7 @@ update_context_from_dragging_info (id <NSDraggingInfo> sender)
#            wh = gdk_window_get_height (win);
 
#            if (gx > wx && gy > wy && gx <= wx + ww && gy <= wy + wh)
# +		  /* found a toplevel GdkWindow at the drop position */
#              event.dnd.context->dest_window = win;
#          }
#      }
# diff --git a/gtk/gtkdnd-quartz.c b/gtk/gtkdnd-quartz.c
# index 62b8570..74bdbc7 100644
# --- a/gtk/gtkdnd-quartz.c
# +++ b/gtk/gtkdnd-quartz.c
# @@ -1926,7 +1926,11 @@ gtk_drag_source_info_destroy (GtkDragSourceInfo *info)
#  }
 
#  static gboolean
# -drag_drop_finished_idle_cb (gpointer data)
# +    GtkDragSourceInfo* info = (GtkDragSourceInfo*) data;
# +    if (info->success) 
# +      {
# +         gtk_drag_source_info_destroy (data);
# +      }
#  {
#    GtkDragSourceInfo* info = (GtkDragSourceInfo*) data;
 
