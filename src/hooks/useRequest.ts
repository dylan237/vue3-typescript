import axios from 'axios'
import { Ref, ref } from 'vue'

/* api 固定傳入參數 */
interface IParams<T> {
  readonly apiUrl: string
  params?: T
}

/* api 固定回傳格式 */
interface IResponse<T> {
  loading: Ref<boolean>
  data: Ref<T | null[]>
  readonly errorMsg: Ref<string>
}

/* 
  Request -> 請求參數
  ResponseMain -> response body 內的主要 data
*/
export default async function useRequest<Request, ResponseMain>({
  apiUrl,
  params,
}: IParams<Request>): Promise<IResponse<ResponseMain>> {
  const loading = ref(true)
  const data = ref([])
  const errorMsg = ref('')

  try {
    const response = await axios.get(apiUrl, params)
    loading.value = false
    data.value = response.data
  } catch (error) {
    loading.value = false
    errorMsg.value = error.message || 'unknown error'
  }

  return {
    loading,
    data,
    errorMsg,
  }
}
