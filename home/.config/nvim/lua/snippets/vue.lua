local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local fmt = require('luasnip.extras.fmt').fmt

local vue_scripts = {
    s("vProp", fmt("{name}:{{type:{typ},default:{def}}}", {
        name = i(1, 'name'),
        typ = i(2, 'String'),
        def = i(3, '""'),
    })),
    s("vBase", fmt([[
    <script setup {setupLang}></script>

    <template>
      {tpl}
    </template>

    <style scoped {styleLang}></style>
    ]], {
        setupLang = i(1, 'lang="ts"'),
        styleLang = i(2, 'lang="scss"'),
        tpl = i(3),
    })),
    s("vi18n", fmt([[
    import {{ useI18n }} from 'vue-i18n';
    const {{ t }} = useI18n();
    ]], {})),
    s("vRef", fmt("const {name} = ref({val})", {
        name = i(1, 'name'),
        val = i(2),
    })),
    s("vReactive", fmt("const {name} = reactive({{{val}}})", {
        name = i(1, 'name'),
        val = i(2),
    })),
    s("vComputed", fmt([[
    const {name} = computed(() => {{
      {body}
    }})
    ]], {
        name = i(1, 'name'),
        body = i(2, '// content'),
    })),
    s("vComputed2", fmt([[
    {const}{name} = computed({{
      get () {{
        return {ret}
      }},
      set (val) {{
        emit('update:{key}', {val})
      }}
    }})
    ]], {
        const = i(1, 'const '),
        name = i(2, 'name'),
        ret = i(3, '// return'),
        key = i(4, 'val'),
        val = i(5, 'val'),
    })),
    s("vDefineModel", fmt([[
    const {name} = defineModel({{
      type: {typ},
      default: {def}
    }})
    ]], {
        name = i(1, 'name'),
        typ = i(2, 'String'),
        def = i(3, '""'),
    })),
    s("vbasets", fmt([[
    <script setup lang="ts">
    </script>

    <template>
      <div></div>
    </template>

    {style}
    ]], {
        style = i(1, '<style scoped></style>'),
    })),
    s('vWatch', fmt([[
    watch({name}, ({newVal}, {oldVal}) => {{
      {body}
    }})
    ]], {
        name = i(1, 'name'),
        newVal = i(2, 'newValue'),
        oldVal = i(3, 'oldValue'),
        body = i(4),
    })),
    s('vWatchEffect', fmt([[
    watchEffect(() => {{
      {body}
    }})
    ]], {
        body = i(1),
    })),
    s('vProvide', fmt('provide({key}, {val})', {
        key = i(1, 'key'),
        val = i(2, 'value'),
    })),
    s('vInject', fmt('const {var} = inject({key}, {def})', {
        var = i(1, 'var'),
        key = i(2, 'injectionKey'),
        def = i(3, 'defaultValue'),
    })),
    s('vHook', fmt([[
    {hook}(() => {{
      {body}
    }})
    ]], {
        hook = c(1, {
            t('onMounted'),
            t('onUnmounted'),
            t('onBeforeMount'),
        }),
        body = i(2),
    })),
}

return vue_scripts
