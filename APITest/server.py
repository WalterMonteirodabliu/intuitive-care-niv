from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd

app = FastAPI()

# Configurar CORS para permitir requisições do Vue.js
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permitir todas as origens (troque pelo domínio específico se necessário)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Carregar o CSV
csv_path = r"C:\Users\Walter Felipe\Desktop\Teste Nivelamento - intuitive care\APITest\Relatorio_cadop.csv"
df = pd.read_csv(csv_path, encoding="latin1", sep=";")  # Ajuste o encoding conforme necessário

@app.get("/buscar-operadoras")
def buscar_operadoras(q: str = Query(..., min_length=2)):
    """Busca operadoras pelo nome ou parte do nome"""
    resultados = df[df["nome_fantasia"].str.contains(q, case=False, na=False)]
    return resultados.head(10).to_dict(orient="records")

# Rodar o servidor
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
