<template>
  <h4>================ Coustom hook (useRequest) & Suspense (async component) ================</h4>
  <div v-if="errorMsg">資料載入錯誤</div>
  <div v-if="loading">資料載入中...</div>
  <div v-else>
    <div v-for="(producet, idx) in data" :key="idx">
      <p>title: {{ producet.title }}</p>
      <p>price: {{ producet.price }}</p>
      <hr />
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import useRequest from '@/hooks/useRequest.ts'
import { IParams, IProduct } from './interface'

export default defineComponent({
  name: 'Producets',
  async setup() {
    const { loading, data, errorMsg } = await useRequest<IParams, IProduct>({
      apiUrl: '/mock/apiData.json',
    })
    return {
      loading,
      data,
      errorMsg,
    }
  },
})
</script>
