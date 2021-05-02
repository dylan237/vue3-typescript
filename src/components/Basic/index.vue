<template>
  <h4>================ Basic API (ref, reactive, computed, watch, life cycles) ================</h4>
  <h4>ref：</h4>
  <div>
    value: <input type="text" v-model.number="value" ref="inputRef" />
    <button @click="value++">value increase</button>
  </div>
  <hr />
  <h4>reactvie / computed / watch：</h4>
  <div>obj.name (reactvie): <input type="text" v-model="obj.name" /></div>
  <div>obj.age (reactvie): <input type="text" v-model="obj.age" /></div>
  <div>computed: <input type="text" v-model="computeVar" /></div>
  <div>
    <button @click="obj.age++">age increase</button>
  </div>
</template>

<script lang="ts">
import {
  defineComponent,
  ref,
  reactive,
  computed,
  watch,
  watchEffect,
  onBeforeMount,
  onMounted,
  onBeforeUnmount,
  onUnmounted,
  onBeforeUpdate,
  onUpdated,
} from 'vue'

export default defineComponent({
  name: 'Basic',
  setup(props, { attrs, slots, emit }) {
    console.log('props--', props)
    console.log('attrs--', attrs)
    console.log('slots--', slots)
    console.log('emit--', emit)

    const inputRef = ref<HTMLElement | null>()
    const obj = reactive({
      name: 'Dylan',
      age: 27,
      deposit: 100000000,
    })
    const value = ref(0)

    const computeVar = computed({
      get: () => obj.name + '_' + obj.age,
      set(val: string) {
        console.log(val)
        const [, age] = val.split('_')
        obj.age = Number(age) + 1
      },
    })

    watch(
      () => obj.age,
      (val: number) => {
        console.log(val)
      }
    )

    watch(
      value,
      (val: number) => {
        console.log(val)
      },
      {
        immediate: true,
      }
    )

    onMounted(() => {
      inputRef.value && (inputRef.value as HTMLElement).focus()
    })

    onBeforeMount(() => {
      console.log('--onBeforeMount')
    })

    onBeforeUnmount(() => {
      console.log('--onBeforeUnmount')
    })

    onUnmounted(() => {
      console.log('--onUnmounted')
    })

    onBeforeUpdate(() => {
      console.log()
    })

    onUpdated(() => {
      console.log()
    })
    return {
      obj,
      value,
      computeVar,
      inputRef,
    }
  },
})
</script>

<style scoped lang="scss"></style>
