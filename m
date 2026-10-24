Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807429;
	b=kRuUSz6KcdZggAtye1m8DvDfMWgI3K+lBCRpZ/X/HPgc8M6W7jsuBpYLRRrqneKGVEdS
	 dGE8cxgfhIZqEJynTKnu9dJVsNmtiCoEklHBIEEPMVWfxKYAFZnXcIyK0hDjyYAEWzxvS
	 /fbBFqYHei98k9yb//hhYK/L8+IC8Ssr+lX8LUjVx3H/2wV3YaiSB7WpIbeN4mowbPTkI
	 ONoDai6l7OiKKCLNWq9p8vbuFbIQf7WyWDG346bP9GvaoRayP44/KKJQtmXDvaKmehmge
	 qEx6Nhd1ZgdZMPGA/YdWzaBW5ceDVZ1lOFVo87VZ0mD5TLmj8f0dJCx42NX5NsfP32Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sdFICaZ8J7EHHigJYcTlAAkH6ih5kLObMfVCJVlIcjM=;
	b=0t4jRoAIPwwQjKb7uqa0u8eM1T4815XQG6PoPVQlLru9JVqZTVcriD1I0E4okY9AfRgx
	 7C7oaagwNn3nIbrJn6TYAsL8XhMyerELGpBpb6x79W0Mr25U4WibnjMc1fZGVR9fe46OM
	 U7bwmAN6veRZbnw0RaUl4vAFmure7wDNlavNSkq2YVnvEPXBNu7F+4AdPGQXXKtl8G1a5
	 lnKMuQvtdyE9ybidaQimXCXaViPONV0sGncFZXEfGseOnmyBpBXW9KZSdcguoy/bstDW5
	 0RLtzkC8zmNdrTC+fYNU70eGit4Tv8tRJvI3TpxuPMyHKgslncHXkduOcH0+vIK/8SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2JbrehE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8B606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2JbrehE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD77F1F01825;
	Sat, 24 Oct 2026 02:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792807428;
	bh=sdFICaZ8J7EHHigJYcTlAAkH6ih5kLObMfVCJVlIcjM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n2JbrehE8+zLTzt+G2g2HEGBujt75uYIYNdGl4NUYViHw++pIaqk7IpO2rgMbHkko
	 nzLvwnYLfpvzpKk3aFvXL5q4I46YWLz4aYyIDV/T+2f2YeiJ57mB/1LndDO9DwR3Bt
	 KLCTjOpWcq60r5vizHDWRSwa4O80lr0OgEG18RC0z8aVvWon7jOfMOiN4rx8RsDk27
	 sCBna1KnTFZccQnjtsq56KoSf1UCFCr9iA5C/fkShbv0y8UlsCkACg3TtpcnZ4Y8Ny
	 gIT8LJY/f/m0gmt22+nrer+QonwakOs1s7E/fZaAgT6edUCsKPWoOppSzTgfQrKf2F
	 7Yb2kavj8hJBA==
Message-ID: <sashiko-outbox-183505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 3/7] libbpf: BPF programs manual loading and
 attaching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org
In-Reply-To: <20261024014514.2959514-4-andrey.grodzovsky@crowdstrike.com>
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
 <20261024014514.2959514-4-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 02:03:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] libbpf: bpf_object__free_relocs() frees reloc_desc for manual pr=
ogs
- [Medium] libbpf: bpf_program__load() reload fails for jump and func_ptr m=
aps
- [Medium] libbpf: bpf_program__load() allows loading after failed prepare/=
load
- [Medium] libbpf: bpf_map__init_kern_struct_ops() clobbers manual load str=
ategy
--

commit 2dd11a6f941c4fbe6a6982f6a14ae6a049d19390
Author: Slava Imameev <slava.imameev@crowdstrike.com>

libbpf: BPF programs manual loading and attaching

This commit adds BPF_PROG_LOAD_STRATEGY_MANUAL and bpf_program__load() so
that designated BPF programs can be skipped during bpf_object__load() and
loaded, unloaded, and reloaded on demand afterwards.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e4cdbc2f467db..1d5d59b95c4e8 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -882,12 +883,30 @@ void bpf_program__unload(struct bpf_program *prog)
>  	zfree(&prog->subprogs);
>  }
> =20
> +void bpf_program__unload(struct bpf_program *prog)
> +{
> +	if (!prog)
> +		return;
> +
> +	/*
> +	 * MANUAL programs retain their data here so bpf_program__load()
> +	 * can reload them later; object teardown paths call
> +	 * bpf_program_unload_full() instead to always release it fully.
> +	 */
> +	if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> +		zclose(prog->fd);
> +		return;
> +	}

[Severity: Medium]
What happens when a BPF_PROG_LOAD_STRATEGY_MANUAL program that uses jump
tables or indirect function call tables in read-only data is unloaded here
and then reloaded via bpf_program__load()?

During bpf_object_prepare() -> bpf_object__relocate() ->
bpf_object__relocate_data(), libbpf creates per-program frozen internal
maps once via create_jt_map() (for RELO_INSN_ARRAY) and
create_func_ptr_map() (when map->autocreate && map->func_ptr_cnt &&
prog->has_callx), patching their file descriptors directly into
prog->insns:

tools/lib/bpf/libbpf.c:bpf_object__relocate_data() {
    ...
    if (map->autocreate && map->func_ptr_cnt && prog->has_callx) {
        int map_fd;

        /* the program gets its own map with pointers to its functions */
        map_fd =3D create_func_ptr_map(obj, prog, relo->map_idx);
        ...
        insn[0].imm =3D map_fd;
    }
    ...
}

On the first bpf_program__load() call, the kernel verifier claims these
maps permanently:

1. For jump table maps, bpf_insn_array_init() sets insn_array->used to 1 via
   atomic_xchg(&insn_array->used, 1), which is only released on verifier
   failure and never cleared when a loaded program is later freed.

2. For function pointer maps, resolve_func_ptrs() sets BPF_MAP_USER_PATCHED
   on map->user and overwrites the subprogram byte offsets in the frozen
   map in-place with JITed kernel addresses; __bpf_free_used_maps() does
   not clear BPF_MAP_USER_PATCHED or restore the offsets when the program
   is closed.

When bpf_program__unload() closes prog->fd and bpf_program__load() is
called again, prog->insns still references those same map file descriptors.
Won't the kernel verifier reject the reload with -EBUSY in
bpf_insn_array_init() or bpf_map_claim()?

[ ... ]

> @@ -1228,6 +1247,14 @@ static int bpf_object_adjust_struct_ops_autoload(s=
truct bpf_object *obj)
>  		if (prog->type !=3D BPF_PROG_TYPE_STRUCT_OPS)
>  			continue;
> =20
> +		/*
> +		 * If the user set the load strategy to MANUAL, don't guess it
> +		 * from map autocreate: a MANUAL program is loaded explicitly
> +		 * with bpf_program__load(), which rejects any other strategy.
> +		 */
> +		if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL)
> +			continue;

[Severity: Medium]
Can bpf_map__init_kern_struct_ops() overwrite prog->load_strategy before
bpf_object_adjust_struct_ops_autoload() reaches this check?

In bpf_object_prepare(), bpf_object__init_kern_struct_ops_maps() ->
bpf_map__init_kern_struct_ops() runs immediately before
bpf_object_adjust_struct_ops_autoload(). Inside
bpf_map__init_kern_struct_ops(), if a struct_ops member is absent in the
running kernel's BTF and zeroed in shadow data, or if the slot was cleared
or replaced in shadow data, it unconditionally resets load_strategy to
BPF_PROG_LOAD_STRATEGY_DISABLED:

tools/lib/bpf/libbpf.c:bpf_map__init_kern_struct_ops() {
    ...
    if (!kern_member) {
        ...
        if (st_ops->progs[i]) {
            st_ops->progs[i]->load_strategy =3D BPF_PROG_LOAD_STRATEGY_DISA=
BLED;
            st_ops->progs[i] =3D NULL;
        }
        ...
    }
    ...
    if (btf_is_ptr(mtype)) {
        prog =3D *(void **)mdata;
        if (st_ops->progs[i] && st_ops->progs[i] !=3D prog)
            st_ops->progs[i]->load_strategy =3D BPF_PROG_LOAD_STRATEGY_DISA=
BLED;
    ...
}

If the user explicitly set BPF_PROG_LOAD_STRATEGY_MANUAL on that program via
bpf_program__set_load_strategy(), won't bpf_map__init_kern_struct_ops()
clobber it to BPF_PROG_LOAD_STRATEGY_DISABLED (or cause
bpf_object_adjust_struct_ops_autoload() to set it to
BPF_PROG_LOAD_STRATEGY_AUTO if referenced by another autocreated map)?

[ ... ]

> @@ -16298,3 +16430,32 @@ enum bpf_prog_load_strategy bpf_program__load_st=
rategy(const struct bpf_program
>  {
>  	return prog->load_strategy;
>  }
> +
> +int
> +bpf_program__load(struct bpf_program *prog)
> +{
> +	int err;
> +	struct bpf_object *obj =3D prog->obj;
> +
> +	/*
> +	 * This function cannot be called before OBJ_PREPARED -
> +	 * Program's data is initialized on object prepare.
> +	 */
> +	if (obj->state < OBJ_PREPARED)
> +		return libbpf_err(-EINVAL);

[Severity: Medium]
Is checking obj->state < OBJ_PREPARED sufficient if bpf_object_prepare() or
bpf_object_load() previously failed?

When bpf_object_prepare() or bpf_object_load() fails, it tears down the
object via bpf_object_unload(obj) and sets obj->state =3D OBJ_LOADED:

tools/lib/bpf/libbpf.c:bpf_object_prepare() {
    ...
    if (err) {
        bpf_object_unpin(obj);
        bpf_object_unload(obj);
        obj->state =3D OBJ_LOADED;
        return err;
    }
}

Because OBJ_LOADED is greater than OBJ_PREPARED, a subsequent call to
bpf_program__load() passes this state check and attempts to load the
program after bpf_object_unload() has already closed all map file
descriptors and called bpf_program_unload_full() (freeing prog->func_info,
prog->line_info, and prog->subprogs to NULL while leaving their counts
non-zero, or before prog->insns was relocated and sanitized).

> +
> +	if (prog_is_subprog(obj, prog) || prog->load_strategy !=3D BPF_PROG_LOA=
D_STRATEGY_MANUAL)
> +		return libbpf_err(-EINVAL);
> +
> +	if (prog->fd >=3D 0)
> +		return libbpf_err(-EBUSY);
> +
> +	err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
> +				   obj->license, obj->kern_version, &prog->fd);
> +	if (err) {
> +		pr_warn("prog '%s': failed to load: %s\n", prog->name, errstr(err));
> +		return libbpf_err(err);
> +	}

[Severity: Medium]
Could CO-RE relocation failure diagnostics in the verifier log be lost here
when bpf_program__load() is called after bpf_object__load()?

During bpf_object_prepare() -> bpf_object__relocate() ->
bpf_object__relocate_core(), CO-RE relocations are recorded in
prog->reloc_desc for all non-disabled programs, and unguarded failing CO-RE
instructions are poisoned with call 195896080.

However, at the end of bpf_object__load_progs(), libbpf calls
bpf_object__free_relocs(obj), which frees prog->reloc_desc and zeroes
prog->nr_reloc for all programs in the object, including
BPF_PROG_LOAD_STRATEGY_MANUAL programs that were skipped during the
autoload loop:

tools/lib/bpf/libbpf.c:bpf_object__free_relocs() {
    ...
    for (i =3D 0; i < obj->nr_programs; i++) {
        prog =3D &obj->programs[i];
        zfree(&prog->reloc_desc);
        prog->nr_reloc =3D 0;
    }
}

When bpf_program__load() later calls bpf_object_load_prog() and
verification fails on a poisoned CO-RE relocation, fixup_verifier_log() ->
fixup_log_failed_core_relo() -> find_relo_core() searches prog->reloc_desc
up to prog->nr_reloc, finds nothing, and leaves the raw poisoned call error
in the verifier log instead of reporting the failed CO-RE relocation
details.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024014514.2959=
514-1-andrey.grodzovsky@crowdstrike.com?part=3D3
