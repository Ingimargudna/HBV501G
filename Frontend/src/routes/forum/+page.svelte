<script>
    import {goto,} from '$app/navigation';
    import {page} from '$app/stores';
    import {onMount} from 'svelte';
    import {browser} from '$app/environment';
    import PostForm from '../../components/PostForm.svelte';
	import DisplayPost from '../../components/DisplayPost.svelte';
	import Header from '../../components/Header.svelte';
    
    let props = {ppid:"0"};
    let loggedIn = false;
    let backendRoute = 'https://hbv501g-backend.onrender.com/forum/top';
    
    async function fetchPosts(){
        const urlParams = new URLSearchParams($page.url.search);
        const res = await fetch(
            backendRoute,
            {
                method: 'GET',
                headers: {"Content-Type": "application/json",
                'Authorization': "Bearer "+window.sessionStorage.getItem('authenticatorTocen')}
            }
        )
        const json = await res.json();
        console.log(json);
        return json;
    }
    
    async function loadUser(){
            console.log(backendRoute + "/user/user/?username="+window.sessionStorage.getItem('Username'))
            const res = await fetch(
                backendRoute + '/user/user/?username='+window.sessionStorage.getItem('Username'),
                {method: 'GET',
                headers: {"Content-Type": "application/json",
                "Authorization": "Bearer " + window.sessionStorage.getItem('authenticatorTocen')}}
            )
            //console.log('her er res');
            //console.log(res);
            const data = await res.json();
            console.log('her er data');
            console.log(data);
            if (res.ok) {
                return data;
            }
            return null;
        }

</script>
<Header/>
<h1>FORUM: ALL THREADS</h1>
{#await fetchPosts()}
    <h2>Fetching threads</h2>
{:then dispPost}
    <ul>
    {#each dispPost.data as post}
    <li>
         <svelte:component this={DisplayPost} {...post}/>
    </li>
    {/each}
    </ul>
    {#await loadUser}
        <p>Checking user validity</p>
    {:then user}
        {#if user != null} 
        <svelte:component this={PostForm} {...props}/>
        {/if}
    {/await}
{/await}