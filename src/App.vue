<script setup>
import { ref } from 'vue'
import Button from 'primevue/button'
import InputText from 'primevue/inputtext'
import Select from 'primevue/select'
import Checkbox from 'primevue/checkbox'
import Textarea from 'primevue/textarea'
import DataTable from 'primevue/datatable'
import Column from 'primevue/column'
import Card from 'primevue/card'
import Tag from 'primevue/tag'
import Badge from 'primevue/badge'
import Message from 'primevue/message'

const text = ref('')
const selected = ref(null)
const checked = ref(false)

const options = [
  { label: 'Option A', value: 'a' },
  { label: 'Option B', value: 'b' },
  { label: 'Option C', value: 'c' }
]

const tableData = [
  { name: 'Alice Chen', role: 'Admin', status: 'Active' },
  { name: 'Ben Marsh', role: 'Learner', status: 'Inactive' },
  { name: 'Carla Wu', role: 'Manager', status: 'Active' }
]
</script>

<template>
  <div class="playground">
    <header class="pg-header">
      <h1>WTA component playground</h1>
      <p>PrimeVue v4 · Aura theme</p>
    </header>

    <section>
      <h2 class="section-label">Buttons</h2>
      <div class="row">
        <Button label="Primary" />
        <Button label="Secondary" severity="secondary" />
        <Button label="Success" severity="success" />
        <Button label="Warning" severity="warn" />
        <Button label="Danger" severity="danger" />
        <Button label="Outlined" outlined />
        <Button label="Text" text />
        <Button icon="pi pi-check" rounded aria-label="Done" />
        <Button label="Loading" loading />
      </div>
    </section>

    <section>
      <h2 class="section-label">Form fields</h2>
      <div class="col">
        <InputText v-model="text" placeholder="Text input" />
        <Select
          v-model="selected"
          :options="options"
          optionLabel="label"
          placeholder="Select an option"
        />
        <div class="row">
          <Checkbox v-model="checked" inputId="check1" :binary="true" />
          <label for="check1">Checkbox label</label>
        </div>
        <Textarea rows="3" placeholder="Multiline text" />
      </div>
    </section>

    <section>
      <h2 class="section-label">Card</h2>
      <div class="row">
        <Card style="width: 22rem">
          <template #title>Course title</template>
          <template #subtitle>Category · 4 modules</template>
          <template #content>
            A short description of what this course covers and what the student will learn by the end.
          </template>
          <template #footer>
            <div class="row">
              <Button label="Enrol" size="small" />
              <Button label="View details" size="small" severity="secondary" />
            </div>
          </template>
        </Card>
      </div>
    </section>

    <section>
      <h2 class="section-label">Tags and badges</h2>
      <div class="row">
        <Tag value="Default" />
        <Tag value="Success" severity="success" />
        <Tag value="Warning" severity="warn" />
        <Tag value="Danger" severity="danger" />
        <Tag value="Secondary" severity="secondary" />
        <Badge value="4" />
        <Badge value="99+" severity="danger" />
        <Badge value="!" severity="warn" />
      </div>
    </section>

    <section>
      <h2 class="section-label">Messages</h2>
      <div class="col" style="max-width: 600px">
        <Message severity="info">Informational message</Message>
        <Message severity="success">Action completed successfully.</Message>
        <Message severity="warn">Review before continuing.</Message>
        <Message severity="error">Something went wrong. Try again.</Message>
      </div>
    </section>

    <section>
      <h2 class="section-label">Table</h2>
      <DataTable :value="tableData" stripedRows style="max-width: 600px">
        <Column field="name" header="Name" />
        <Column field="role" header="Role" />
        <Column field="status" header="Status">
          <template #body="{ data }">
            <Tag
              :value="data.status"
              :severity="data.status === 'Active' ? 'success' : 'secondary'"
            />
          </template>
        </Column>
        <Column header="">
          <template #body>
            <Button label="Edit" size="small" text />
          </template>
        </Column>
      </DataTable>
    </section>
  </div>
</template>

<style>
*, *::before, *::after {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: 'DM Sans', system-ui, sans-serif;
  background: var(--p-surface-ground);
  color: var(--p-text-color);
}

.playground {
  max-width: 960px;
  margin: 0 auto;
  padding: 2.5rem 2rem;
}

.pg-header {
  margin-bottom: 3rem;
}

.pg-header h1 {
  font-size: 1.75rem;
  margin: 0 0 0.25rem;
  font-weight: 600;
}

.pg-header p {
  color: var(--p-text-muted-color);
  margin: 0;
  font-size: 0.9rem;
}

section {
  margin-bottom: 3rem;
}

.section-label {
  font-size: 0.7rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--p-text-muted-color);
  margin: 0 0 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 1px solid var(--p-surface-border);
}

.row {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  align-items: center;
}

.col {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  max-width: 420px;
}
</style>
