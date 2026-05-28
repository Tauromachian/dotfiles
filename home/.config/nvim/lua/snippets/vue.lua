local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

local vue_scripts = {
    s("vProp", {
        i(1, 'name'),
        t(":"),
        t("{"),
        t("type:"),
        i(2, 'String'),
        t(","),
        t("default:"),
        i(3, '""'),
        t("}"),
    }),
    s("vBase", {
        t("<script setup "),
        i(1, 'lang="ts"'),
        t("></script>"),
        t({ '', '', '' }),
        t("<template>"),
        i(3, ""),
        t("</template>"),
        t({ '', '', '' }),
        t("<style scoped "),
        i(2, 'lang="scss"'),
        t("></style>")
    }),
    s("vi18n", { t({ "import { useI18n } from 'vue-i18n';", '' }), t('const { t } = useI18n();') }),
    s("vRef", {
        t('const '),
        i(1, 'name'),
        t("= ref("),
        i(2, ""),
        t(")")
    }),
    s("vComputed", {
        t('const '),
        i(1, 'name'),
        t({ "= computed(() => {", '' }),
        i(2, '// content'),
        t({ '', "})" }),
    }),
    s("vComputed2", {
        i(1, 'const '),
        i(2, 'name'),
        t({ "= computed({", "get () {", "return " }),
        i(3, '// return'),
        t({ '', "},", "set (val) {", "emit('update:" }),
        i(4, "val"),
        t("',"),
        i(5, "val"),
        t(")"),
        t({ "}", "})" }),
    }),
    s("vDefineModel", {
        t('const '),
        i(1, 'name'),
        t({ "= defineModel({", "type:" }),
        i(2, 'String'),
        t({ "", ",", "default:" }),
        i(3, '""'),
        t({ "", "})" }),
    }),
    s("vbasets", {
        t({ '<script setup lang="ts">', '' }),
        t({ '</script>', '' }),
        t({ '', '' }),
        t({ '<template>', '' }),
        t({ '  <div></div>', '' }),
        t({ '</template>', '' }),
        t({ '', '' }),
        i(1, '<style scoped></style>')
    }),
    s('vWatch', {
        t('watch('),
        i(1, 'name'),
        t(', ('),
        i(2, 'newValue'),
        t(', '),
        i(3, 'oldValue'),
        t({ ') => {', '' }),
        t('  '),
        i(4),
        t({ '', '})' }),
    }),
    s('vWatchEffect', {
        t({ 'watchEffect(() => {', '' }),
        t('  '),
        i(1),
        t({ '', '})' }),
    }),
    s('vProvide', {
        t('provide('),
        i(1, 'key'),
        t(', '),
        i(2, 'value'),
        t(')')
    }),
    s('vInject', {
        t('const '),
        i(1, 'var'),
        t(' = inject('),
        i(2, 'injectionKey'),
        t(', '),
        i(3, 'defaultValue'),
        t(")")
    }),
    s('vHook', {
        c(1, {
            t('onMounted'),
            t('onUnmounted'),
            t('onBeforeMount')
        }),
        t({ '(() => {', '' }),
        t('  '),
        i(2),
        t('})')
    }),
}

return vue_scripts
