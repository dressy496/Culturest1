require 'tk'

root = TkRoot.new { title "Registro de Eventos Culturest" }
root['bg'] = 'white'

root.geometry("#{root.winfo_screenwidth / 2}x#{root.winfo_screenheight / 2}+#{root.winfo_screenwidth / 4}+#{root.winfo_screenheight / 4}")

TkLabel.new(root, 'text' => 'Registro de Eventos Culturest', 'font' => 'Helvetica 16 bold').pack

TkLabel.new(root, 'text' => 'Eventos', 'font' => 'Helvetica 14').pack
TkLabel.new(root, 'text' => 'Hackaton 2025', 'font' => 'Helvetica 14').pack
TkLabel.new(root, 'text' => 'Expediente del alumno', 'font' => 'Helvetica 14').pack
entrada = TkEntry.new(root)
entrada.pack

etiqueta = TkLabel.new(root)
etiqueta.pack
expediente = ""

entrada.bind("Key") do |e|
  expediente += e.char

  if e.keysym == "Return"
    etiqueta.text = expediente + " se ha inscrito al evento Hackathon 2025"
    agregar_linea(expediente)
    expediente = ""
    entrada.delete(0, 'end')
  end
end

def agregar_linea(expediente)
  File.open('eventos.txt', 'a') { |f| f.puts(expediente) }
end

Tk.mainloop