<script>
    import { createEventDispatcher, onMount } from 'svelte';
    import {browser} from '$app/environment';
    import { Table, TableBody, TableBodyCell, TableBodyRow, TableHead, TableHeadCell } from 'flowbite-svelte';
    let backendRoute = 'http://localhost:8080';
    let selected;
    let fields = [];

    function updateScore(id, key, value) {
        scores = scores.map(score => {
            if (score.id === id) {
                return {...score, [key]: value };
            }
            return score;
        })
    }

    function addRow() {
        const newId = scores.length > 0 ? scores[scores.length - 1].id + 1 : 1;
        const newHole = scores.length > 0 ? scores[scores.length - 1].hole + 1 : 1;
        const newRow = { id: newId, hole: newHole, throws: 0 };
        scores = [...scores, newRow];
    }

    //sækir velli
    onMount(async function getFields(){
        const res = await fetch(
            backendRoute + '/field/fields',
            {method: 'GET',
            headers: {"Content-Type": "application/json",
            "Authorization": "Bearer "+window.sessionStorage.getItem('authenticatorTocen')}

            }
        )
        const json = await res.json();
        if (json.success) {
            //console.log("her eru fields")
            console.log(json)
            fields = json.data;
        }
    });

    //vistar upplýsingar úr töflunni sem nýjan leik
    async function saveGame(){
        const res = await fetch(
            backendRoute + '/game/',
            {method: 'POST',
                headers: {"Content-Type": "application/json", 
                "Authorization": "Bearer " + window.sessionStorage.getItem('authenticatorTocen')},
                body: JSON.stringify({
                    scores
                })
            }
        )
    }


    //$: console.log('Changed selected:', selected)

</script>

<h1>new game</h1>

<select bind:value={selected}>
    {#each fields as option}<option value={option.id}>{option.name}</option>{/each}
</select>

{#if selected != null}
    <p>heyhó</p>
{/if}


<button on:click={saveGame}>Save Data</button>