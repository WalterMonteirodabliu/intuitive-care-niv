<script setup>
import { ref } from "vue";
import axios from "axios";

const termoBusca = ref("");
const operadoras = ref([]);

const buscarOperadoras = async () => {
  if (termoBusca.value.length < 2) return;

  try {
    const response = await axios.get(
      `http://localhost:8000/buscar-operadoras?q=${termoBusca.value}`
    );
    operadoras.value = response.data;
  } catch (error) {
    console.error("Erro ao buscar operadoras:", error);
  }
};
</script>

<template>
  <div>
    <h1>Buscar Operadoras</h1>
    <input
      v-model="termoBusca"
      placeholder="Digite o nome da operadora..."
      @input="buscarOperadoras"
    />
    <ul>
      <li v-for="operadora in operadoras" :key="operadora.registro_ans">
        {{ operadora.nome_fantasia }} - {{ operadora.registro_ans }}
      </li>
    </ul>
  </div>
</template>

<style>
input {
  padding: 8px;
  margin: 10px 0;
}
</style>
