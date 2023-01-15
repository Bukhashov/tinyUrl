<template>
    <div class="index">
        <div class="io_section">
            <div class="input">
                <input type="text" v-model="inputLink" name="" id="input_link">
            </div>
            <div class="btn">
                <button v-on:click="short" id="btn_short">short</button>
            </div>
        </div>
        <div class="io_section">
            <div class="input">
                <input  v-model="outputLink" type="text" name="" id="output_link">
            </div>
            <div class="btn">
                <button v-on:click="copy" id="btn_copy">copy</button>
            </div>
        </div>
    </div>
</template>


<script>  
export default {
    name: 'MainPage',
    
    data() {
        return {
            inputLink: '',
            outputLink: '',
        }
    },
    methods: {
        short: async function() {
            const res = await fetch("http://localhost:8000/", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ link: this.inputLink })
            }).then(response => response.json())
            
            this.outputLink = res.link
        },
        copy: async function() {
            navigator.clipboard.writeText(this.outputLink)
        }
    }
}
</script>


<style>
.index{
    display: grid;
    justify-content: center;
}
.io_section {
    display: flex;
    align-items: center;
    padding: 5px 0;
}
.input {

}
.input > input {
    width: 250px;
    height: 32px;
}
button {
    padding: 5px;
    font-size: 16px;
    margin-left: 5px;
    margin-right: 5px;
}
</style>