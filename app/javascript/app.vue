<template>
  <input
          type="text"
          :value="value"
          @input="sanitizeAndEmit($event.target.value)"
  >
</template>

<script>
  export default {
    name: 'IntegerStringOnlyInput',
    props: {
      value: {
        type: String,
        required: true,
        default: '',
      },
    },
    watch: {
      // 親からの値変更の時もサニタイズするためにwatch
      value(newValue) {
        this.sanitizeAndEmit(newValue);
      },
    },
    mounted() {
      this.sanitizeAndEmit(this.value);
    },
    methods: {
      sanitizeAndEmit(val) {
        // 数字以外を消す & 全角数字を半角数字へ変換
        this.$emit(
                'input',
                val.replace(/[^0-9０-９]/g, '').replace(/[０-９]/g, (s) => String.fromCharCode(s.charCodeAt(0) - 0xFEE0)),
        );
        // サニタイズされた値は直前の値と変わらないので再描画されない 強制的に再描画しないと、表示と実際の値がずれる
        this.$forceUpdate();
      },
    },
  };
</script>