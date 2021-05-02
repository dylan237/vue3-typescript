<template>
  <h1>Vue3 playground</h1>
  <div>
    <button @click="allViewToggler">ALL</button>
  </div>
  <div>
    <button @click="viewToggler('basic')">Basic API</button>
    <button @click="viewToggler('coordinate')">Coustom hook1</button>
    <button @click="viewToggler('products')">Coustom hook2</button>
  </div>
  <basic v-if="viewState.basic" />
  <coordinate v-if="viewState.coordinate" />
  <Suspense v-if="viewState.products">
    <products />
  </Suspense>
</template>

<script lang="ts">
import { defineComponent, reactive } from 'vue'
import Basic from '@/components/Basic/index.vue'
import Coordinate from '@/components/Coordinate/index.vue'
import Products from '@/components/Products/index.vue'

interface IViewState {
  [key: string]: boolean
}

export default defineComponent({
  name: 'App',
  components: { Basic, Coordinate, Products },
  setup() {
    const viewState = reactive<IViewState>({
      basic: true,
      coordinate: false,
      products: false,
    })
    const allViewToggler = ((): (() => void) => {
      let stateCache = false
      return () => {
        stateCache = !stateCache
        for (const key of Object.keys(viewState)) {
          viewState[key] = stateCache
        }
      }
    })()
    const viewToggler = (key: string): void => {
      viewState[key] = !viewState[key]
    }
    return {
      viewState,
      viewToggler,
      allViewToggler,
    }
  },
})
</script>
