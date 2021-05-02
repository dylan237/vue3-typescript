<template>
  <h4>================ Coustom hook1 (useClientCoordinate) ================</h4>
  <div>x: {{ x }}, y: {{ y }}</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import useClientCoordinate from '@/hooks/useClientCoordinate.ts'

export default defineComponent({
  name: 'Coordinate',
  setup() {
    const { x, y } = useClientCoordinate()
    return {
      x,
      y,
    }
  },
})
</script>
