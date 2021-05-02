import { reactive, toRefs, onMounted, onUnmounted, ToRefs } from 'vue'

interface ICoordinate {
  x: number
  y: number
}

export default function useClientCoordinate(): ToRefs<ICoordinate> {
  const coordinate = reactive({
    x: -1,
    y: -1,
  })
  const eventFn = (event: MouseEvent) => {
    coordinate.x = event.clientX
    coordinate.y = event.clientY
  }
  onMounted(() => {
    window.addEventListener('mousemove', eventFn)
  })
  onUnmounted(() => {
    window.removeEventListener('mousemove', eventFn)
  })

  return {
    ...toRefs(coordinate),
  }
}
