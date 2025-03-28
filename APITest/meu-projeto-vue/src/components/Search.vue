<template>
  <div>
    <input v-model="busca" @input="pesquisar" placeholder="Buscar operadora" />
    <ul>
      <li v-for="operadora in operadoras" :key="operadora.id">
        {{ operadora.nome_fantasia }}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      busca: "",
      operadoras: [],
    };
  },
  methods: {
    async pesquisar() {
      if (this.busca.length < 2) {
        this.operadoras = [];
        return;
      }
      try {
        const response = await axios.get(`http://127.0.0.1:8000/buscar-operadoras?q=${this.busca}`);
        this.operadoras = response.data;
      } catch (error) {
        console.error("Erro ao buscar operadoras:", error);
      }
    },
  },
};
</script>
