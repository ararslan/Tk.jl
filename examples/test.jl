## Example of widgets put into container with change handler assigned

using TkExtras

w = Toplevel("Test window", false)
## pack in ttk frame for themed widgets
f = Frame(w)
tk_configure(f, {:padding => [3,3,2,2], :relief=>"groove"})
pack(f, {:expand => true, :fill => "both"})

## widgets
b  = Button(f, "one")
cb = Checkbutton(f, "checkbutton")
rg = Radio(f, ["one", "two", "trhee"], true)
sc = Scale(f, 1:10)
sl = Spinbox(f, 1:10)
e  = Entry(f, "starting text")
widgets = (b, cb, rg, sc, sl, e)

## oops, typo!
set_items(rg[3], "three")

## packing
pack_style = ["pack", "grid", "formlayout"][3]

if pack_style == "pack"
    map(pack, widgets)
    map(u -> pack_configure(u, {:anchor => "w"}), widgets)
elseif pack_style == "grid"
    for i in 1:length(widgets)
        grid(widgets[i], i, 1)
        grid_configure(widgets[i], {:sticky => "we"})
    end
else
    map(u -> TkExtras.formlayout(u, "label"), widgets)
end

## bind a callback to each widget
change_handler(path,xs...) = println(map(get_value, widgets))
map(u -> callback_add(u, change_handler), widgets)

set_visible(w, true)
    
