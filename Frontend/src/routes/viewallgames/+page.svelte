<script>
    import {browser} from '$app/environment';
	import DisplayGame from '../../components/DisplayGame.svelte';

    let backendRoute = 'https://hbv501g-backend.onrender.com/game/displaygames/all';

    async function fetchGames(){
    
        const res = await fetch(
            backendRoute,
            {
                method: 'GET',
                headers: {"Content-Type": "application/json",
                "Authorization": "Bearer " + window.sessionStorage.getItem('authenticatorTocen')}
            }
        )
        const json = await res.json();
        console.log(json);
        return json;
    }
</script>
<main>
    {#await fetchGames()}
        <p>loading</p>
    {:then games}
    {#each games.data as game}
    <svelte:component this={DisplayGame} {...game}/>
    {/each}
    {/await}
</main>