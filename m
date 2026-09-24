Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551222A80D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210026; cv=none; b=MXRS14WwnNUvM+pFp/fpx4lki9uKi85rALjZskWL9ufr0XZd2IMK/0uf6KEMiWwgGVj5Vo1iaz+SFF2kmrfkrClN7LHtXARWiJPE11v1RyeKPT9ZHcViVH1WxW1REEio/FGYL4W42GYkLEWaroktGIgP8JWQ+ffxXOWBuNesFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210026; c=relaxed/simple;
	bh=/5KdHFN5XNFwwH/j8JBNRlEAyBu9n4eGq86qRb7R/c8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tVLLTyHa8oMbzvVrrE2TlORKG9JvyYX/D2JlndoPVKF02Zf6mD1ccpQDLN0SFfd+g8BSdKaYUBPwm1+Pf+VSzAec2QSGaOLqQJPbzLg72hIcuYMCJ5hbKmeLU+LOcD5JMKbxguFG1KktZf5KiZ+CEZN2nXYPg9miIhxIXJ5Y2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1GV5XKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1GV5XKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDF01F000FF;
	Thu, 24 Sep 2026 00:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790210024;
	bh=RXeBTTEsvZ2E3To2M6GqKDwvfk9LkAk2HaRoMhrjoXk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V1GV5XKadRaTXuwceezQdjiJ/EcUB26J74m9zmDQqgwXWUVx+Bs4V2PqTquxzQ8EW
	 HpIoHD2Z0AQ/2QcYGmfEjy8l4Ri5C6wyzcwkcO+qO5JveCnPlnhi+g0Fc/jYT6oaWA
	 3vBTNxGDB9NBaym1ozOgvGNozDX2jNgE8NodV071JO3DhhbZ6K5kzMgBnDCSX4gVit
	 xsGUiWD9glbB/AnAO3oK1KdwTqgigAu1kSrfe8Q7A+fFu57bAwqIcYKCxmZnp3T6Yb
	 TjQRTQiedmTeg3n7AXl2ArfHpORDD6nE3AvaFk3h9IjErvCFgWA53yHGj9w2eGtYwH
	 Af7Vjc8xgODzA==
Content-Type: multipart/mixed; boundary="===============4372679374321826094=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c292100880a6fff41fde6ff71c9538f82d1c3af90f5c478989768a14074a32a7@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-13-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-13-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 12/17] libbpf: Resolve pointers to functions in read-only data
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:33:43 +0000 (UTC)

--===============4372679374321826094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cd1ea1bb53cb..9538a21f0db4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -6471,6 +6514,137 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
>  	return err;
>  }
>
> +/*
> + * The kernel recognizes a pointer to a function in a frozen read-only map by
> + * its value: the offset in bytes of the function in the program. It makes
> + * callx work for tables of functions, structures of operations and vtables,
> + * where pointers are mixed with other data. Functions have different offsets
> + * in different programs, so create a copy of the map for the program.
> + * The kernel replaces the offsets with the addresses of the functions when it
> + * loads the program, which has to be the only user of the map.
> + */
> +static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog, int map_idx)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_RDONLY_PROG);
> +	struct bpf_map *map = &obj->maps[map_idx];
> +	__u32 value_size = map->def.value_size;
> +	size_t i, j, cnt, sec_insn_off;
> +	struct func_ptr *ptrs;
> +	int map_fd, err, zero = 0;
> +	__u64 val;
> +	void *data, *tmp;
> +
> +	for (i = 0; i < obj->func_ptr_map_cnt; i++)
> +		if (obj->func_ptr_maps[i].prog == prog &&
> +		    obj->func_ptr_maps[i].map_idx == map_idx)
> +			return obj->func_ptr_maps[i].fd;
> +
> +	if (obj->gen_loader) {
> +		pr_warn("prog '%s': map '%s': pointers to functions in data are not supported by light skeleton\n",
> +			prog->name, map->name);
> +		return -ENOTSUP;
> +	}
> +
> +	data = malloc(value_size);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* the content of the map is final, it's frozen already */
> +	if (map->mmaped) {
> +		memcpy(data, map->mmaped, value_size);
> +	} else if (bpf_map_lookup_elem(map->fd, &zero, data)) {
> +		err = -errno;
> +		pr_warn("prog '%s': map '%s': failed to read the content: %s\n",
> +			prog->name, map->name, errstr(err));
> +		goto err_free;
> +	}

Is this comment accurate about the map being frozen?

Looking at bpf_object_prepare(), create_func_ptr_map() runs during
bpf_object__relocate():

    err = err ? : bpf_object__relocate(obj, ...);
    err = err ? : bpf_object__sanitize_and_load_btf(obj);
    err = err ? : bpf_object__create_maps(obj);

At this point the .rodata map has not been created, populated or frozen,
and map->fd is still the placeholder fd from create_placeholder_fd().

The data is correct because it comes from map->mmaped (the anonymous mmap
allocated at open time in bpf_object__init_internal_map()), but the
comment's claim and the bpf_map_lookup_elem(map->fd, ...) fallback don't
match the actual call order.

> +
> +	ptrs = map->func_ptrs;
> +	cnt = map->func_ptr_cnt;

[ ... ]

> +
> +	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, map->name, sizeof(int), value_size, 1, &opts);
> +	if (map_fd < 0) {
> +		err = map_fd;
> +		goto err_free;
> +	}

Does this need to pass the object's BPF token?

Every other map creation in libbpf sets the token when present, for
example bpf_object__create_map():

    create_attr.token_fd = obj->token_fd;
    if (obj->token_fd)
        create_attr.map_flags |= BPF_F_TOKEN_FD;

Program load does the same (load_attr.token_fd = obj->token_fd). Without
the token, map_create() in kernel/bpf/syscall.c:1493 returns -EPERM when
sysctl_unprivileged_bpf_disabled is set and the caller relies on a
delegated BPF token (user namespace with obj->token_fd set by
bpf_object_prepare_token()).

In that case, bpf_object__relocate_data() prints "can't create a copy of
map ... with pointers to functions" and the whole object fails to load,
even though the kernel side could grant allow_ptr_leaks through the token
(CAP_PERFMON). This affects any program in the object that references
.rodata with function pointers. The existing create_jt_map() has the same
gap.

[ ... ]

> @@ -6835,6 +7021,51 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
>  	return 0;
>  }
>
> +static int
> +bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
> +		       struct bpf_program *prog);
> +
> +/* Append to the main program all functions that the data of the map points to */
> +static int
> +bpf_object__append_func_ptrs_code(struct bpf_object *obj, struct bpf_program *main_prog,
> +				  const struct bpf_map *map)
> +{
> +	struct bpf_program *subprog;
> +	size_t i, cnt, sec_insn_off;
> +	struct func_ptr *ptrs;
> +	int err;
> +
> +	ptrs = map->func_ptrs;
> +	cnt = map->func_ptr_cnt;
> +	for (i = 0; i < cnt; i++) {
> +		sec_insn_off = ptrs[i].text_off / BPF_INSN_SZ;
> +		subprog = find_prog_by_sec_insn(obj, obj->efile.text_shndx, sec_insn_off);
> +		if (!subprog || subprog->sec_insn_off != sec_insn_off) {
> +			pr_warn("prog '%s': map '%s': no function at .text+%zu for the pointer at offset %zu\n",
> +				main_prog->name, map->name, ptrs[i].text_off, ptrs[i].sec_off);
> +			return -LIBBPF_ERRNO__RELOC;
> +		}
> +
> +		/*
> +		 * callx can't call global functions. Don't add one to the
> +		 * program only because the data points to it.
> +		 */
> +		if (subprog->sym_global)
> +			continue;
> +
> +		/* see the comment in bpf_object__reloc_code() */
> +		if (subprog->sub_insn_off == 0) {
> +			err = bpf_object__append_subprog_code(obj, main_prog, subprog);
> +			if (err)
> +				return err;
> +			err = bpf_object__reloc_code(obj, main_prog, subprog);
> +			if (err)
> +				return err;
> +		}
> +	}
> +	return 0;
> +}

[ ... ]

> @@ -6851,6 +7082,20 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>
>  	for (insn_idx = 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
>  		insn = &main_prog->insns[prog->sub_insn_off + insn_idx];
> +		if (insn_is_func_ptrs_addr(insn)) {
> +			/*
> +			 * The code that loads the address of the data might
> +			 * call any function that the data points to.
> +			 */
> +			relo = find_prog_insn_relo(prog, insn_idx);
> +			if (relo && relo->type == RELO_DATA) {
> +				err = bpf_object__append_func_ptrs_code(obj, main_prog,
> +									&obj->maps[relo->map_idx]);
> +				if (err)
> +					return err;
> +			}
> +			continue;
> +		}
>  		if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
>  			continue;

Does this append functions to programs without callx?

bpf_object__reloc_code() calls bpf_object__append_func_ptrs_code() for
every ld_imm64 of a map with func_ptr_cnt. bpf_object__relocate() marks
any RELO_DATA targeting a map with function pointers:

    if (relo->type == RELO_DATA && obj->maps[relo->map_idx].func_ptr_cnt)
        insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;

Nothing checks whether the program contains a callx instruction. .rodata
is a single shared map for all const and const volatile globals in the
object, so any ld_imm64 that reads .rodata for a config variable pulls in
all static functions that the section points to.

On the kernel side, resolve_func_ptrs() makes those functions reachable
only when the program has callx:

    if (!env->has_callx || !env->allow_ptr_leaks)
        return 0;

When the program has no callx, the appended functions are not reached by
any edge, and check_cfg() in kernel/bpf/cfg.c:729 rejects it with
"unreachable insn %d". e7d77667afdf states this: "A function that is
listed in func_info and not referenced by anything is still rejected by
check_cfg() as unreachable."

For example, with tools/testing/selftests/bpf/progs/callx_rodata.c:

    const volatile int bias = 1;
    static op_fn const ops[] = { add_bias, mul3 };
    SEC("socket") int use_table(void *ctx) { ... }
    SEC("socket") int read_config(void *ctx) { return bias; }

The ld_imm64 for bias in read_config() makes libbpf append add_bias and
mul3 to it. The kernel then rejects read_config as containing unreachable
instructions, and bpf_object__load() fails for the whole object, including
use_table. Before this patch, .rel.rodata was skipped and read_config
loaded fine. The same failure hits a callx program loaded without
CAP_PERFMON (allow_ptr_leaks false).

Should the functions be appended only when the program (or one of its
subprogs) contains BPF_CALL|BPF_X, or should libbpf probe for kernel
callx support before processing func_ptrs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35935998342
--===============4372679374321826094==--
