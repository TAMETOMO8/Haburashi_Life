import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="index-search"
export default class extends Controller {
  // コントローラーに紐づく要素（=フォーム）をsubmitするアクション
  submit() {
    // セットされているTimeoutをクリアする
    clearTimeout(this.timeout)

    // Timeoutをセットする
    // 200ms後にリクエストを実行する
    // 連続で実行されるとTimeoutはクリアされるため、最後の処理だけしか実行されない
    this.timeout = setTimeout( ()=> {
      this.element.requestSubmit()
    }, 200)
  }
}