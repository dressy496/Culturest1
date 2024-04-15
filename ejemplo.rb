
require 'tk'
require 'csv'
require 'json'
require 'nokogiri'


root = TkRoot.new { title "Registro de Eventos Culturest" }


entrada = TkEntry.new(root)
entrada.pack


texto = TkText.new(root)
texto.pack


etiqueta = TkLabel.new(root)
etiqueta.pack

def generar_csv(contenido)
  CSV.open('participantes.csv', 'w') do |csv|
    contenido.split("\n").each do |linea|
      csv << [linea, "a#{linea}@unison.mx"]
    end
  end
end

def generar_json(contenido)
  asistentes = contenido.split("\n").map do |linea|
    { 'expediente' => linea, 'correo' => "a#{linea}@unison.mx" }
  end
  File.write('participantes.json', JSON.pretty_generate(asistentes))
end

def generar_sql(contenido)
  sql = "CREATE DATABASE IF NOT EXISTS evento;\nUSE evento;\nCREATE TABLE IF NOT EXISTS asistentes(expediente INT NOT NULL, correo VARCHAR(255) NOT NULL);\nINSERT INTO asistentes (expediente, correo) VALUES\n"
  contenido.split("\n").each do |linea|
    sql += "('#{linea}', 'a#{linea}@unison.mx'),\n"
  end
  sql = sql[0..-3] + ";"
  File.write('participantes.sql', sql)
end

def generar_xml(contenido)
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.asistentes do
      contenido.split("\n").each do |linea|
        xml.asistente do
          xml.expediente linea
          xml.correo "a#{linea}@unison.mx"
        end
      end
    end
  end
  File.write('participantes.xml', builder.to_xml)
end


entrada.bind("Return") do

  etiqueta.text = entrada.get + " se ha inscrito al evento Hackathon 2025"


    File.open('evento.txt', 'a') { |f| f.write(entrada.get + "\n") }
  entrada.delete(0, 'end')
end


boton_carga = TkButton.new(root, 'text' => 'Cargar Archivo') do
  command proc {
    archivo = Tk.getOpenFile
    if archivo != ""
      contenido = File.read(archivo)
      texto.delete('1.0', 'end')
      texto.insert('end', contenido)
    end
  }
  pack
end


boton_csv = TkButton.new(root, 'text' => 'CSV', 'command' => proc { generar_csv(texto.get('1.0', 'end')) })
boton_csv.pack
boton_json = TkButton.new(root, 'text' => 'JSON', 'command' => proc { generar_json(texto.get('1.0', 'end')) })
boton_json.pack
boton_sql = TkButton.new(root, 'text' => 'SQL', 'command' => proc { generar_sql(texto.get('1.0', 'end')) })
boton_sql.pack
boton_xml = TkButton.new(root, 'text' => 'XML', 'command' => proc { generar_xml(texto.get('1.0', 'end')) })
boton_xml.pack

Tk.mainloop


require 'tk'

# Crear la ventana principal
root = TkRoot.new { title "Registro de Eventos Culturest" }
root['bg'] = 'white'

# Centrar la ventana
root.geometry("#{root.winfo_screenwidth / 2}x#{root.winfo_screenheight / 2}+#{root.winfo_screenwidth / 4}+#{root.winfo_screenheight / 4}")

# Crear el widget del título
TkLabel.new(root, 'text' => 'Registro de Eventos Culturest', 'font' => 'Helvetica 16 bold').pack


# Crear el widget del evento
TkLabel.new(root, 'text' => 'Eventos', 'font' => 'Helvetica 14').pack
TkLabel.new(root, 'text' => 'Hackaton 2025', 'font' => 'Helvetica 14').pack

# Crear el widget del expediente del alumno
TkLabel.new(root, 'text' => 'Expediente del alumno', 'font' => 'Helvetica 14').pack
entrada = TkEntry.new(root)
entrada.pack

# Crear el widget de etiqueta
etiqueta = TkLabel.new(root)
etiqueta.pack