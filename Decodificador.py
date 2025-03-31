import tkinter as tk
from tkinter import filedialog, messagebox, ttk

# Codificación de operaciones (basado en tu ejemplo)
OPCODES = {
    "ADD": "0011",
    "SUB": "0100",
    "SLT": "0101",
    "SW": "0111"
}

class DecodificadorApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Decodificador Ensamblador → Binario (19 bits)")
        
        # Frame superior para entrada de archivo
        frame_superior = tk.Frame(root)
        frame_superior.pack(pady=10)
        
        self.label_archivo = tk.Label(frame_superior, text="Archivo seleccionado: Ninguno")
        self.label_archivo.pack(side=tk.LEFT, padx=5)
        
        self.boton_explorar = tk.Button(frame_superior, text="Explorar", command=self.seleccionar_archivo)
        self.boton_explorar.pack(side=tk.LEFT, padx=5)
        
        self.boton_convertir = tk.Button(frame_superior, text="Convertir", command=self.convertir_archivo, state=tk.DISABLED)
        self.boton_convertir.pack(side=tk.LEFT, padx=5)
        
        # Texto para resultados
        self.texto_resultado = tk.Text(root, height=15, width=80, wrap=tk.NONE)
        self.scroll_y = ttk.Scrollbar(root, orient=tk.VERTICAL, command=self.texto_resultado.yview)
        self.scroll_x = ttk.Scrollbar(root, orient=tk.HORIZONTAL, command=self.texto_resultado.xview)
        self.texto_resultado.configure(yscrollcommand=self.scroll_y.set, xscrollcommand=self.scroll_x.set)
        
        self.scroll_x.pack(side=tk.BOTTOM, fill=tk.X)
        self.scroll_y.pack(side=tk.RIGHT, fill=tk.Y)
        self.texto_resultado.pack(fill=tk.BOTH, expand=True)
        
        self.archivo_actual = None
    
    def seleccionar_archivo(self):
        filepath = filedialog.askopenfilename(filetypes=[("Archivos de texto", "*.txt")])
        if filepath:
            self.archivo_actual = filepath
            self.label_archivo.config(text=f"Archivo seleccionado: {filepath}")
            self.boton_convertir.config(state=tk.NORMAL)
    
    def convertir_archivo(self):
        if not self.archivo_actual:
            return
        
        try:
            with open(self.archivo_actual, 'r') as file:
                lineas = file.readlines()
            
            self.texto_resultado.delete(1.0, tk.END)
            resultados = []
            
            for linea in lineas:
                linea = linea.strip()
                if linea:
                    # Procesar instrucción
                    partes = linea.split()
                    op = partes[0].upper()
                    
                    if op not in OPCODES:
                        binario = f"// Instrucción no reconocida: {linea}"
                    else:
                        # Formatear según el tipo de instrucción
                        if op == "SW":
                            reg_dest = partes[1].replace("$", "")
                            reg_src = partes[2].replace("$", "")
                            binario = f"19'b{OPCODES[op]}_00000_{reg_dest.zfill(5)}_{reg_src.zfill(5)}"
                        else:
                            reg_dest = partes[1].replace("$", "")
                            reg_src1 = partes[2].replace("$", "")
                            reg_src2 = partes[3].replace("$", "")
                            binario = f"19'b{OPCODES[op]}_{reg_dest.zfill(5)}_{reg_src1.zfill(5)}_{reg_src2.zfill(5)}"
                    
                    # Mostrar instrucción ensamblador y binario en la interfaz
                    self.texto_resultado.insert(tk.END, f"Instrucción: {linea} --> {binario}\n")
                    resultados.append(binario)  # Solo guardar el binario para el archivo de salida
            
            # Guardar solo los resultados binarios en el archivo de salida
            with open("salida_binario2.txt", "w") as f:
                f.write("\n".join(resultados))
            
            messagebox.showinfo("Éxito", "Conversión completada. Resultados guardados en 'salida_binario.txt'")
        
        except Exception as e:
            messagebox.showerror("Error", f"Ocurrió un error: {str(e)}")

if __name__ == "__main__":
    root = tk.Tk()
    app = DecodificadorApp(root)
    root.mainloop()
