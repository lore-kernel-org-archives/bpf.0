Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C9634E75A
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797617; cv=none; b=sTWd3akWZIauYUYbKQ+Z7WFvx5amW0cjDb91My4MQrCtC8Tvqht2yWlROJRc92CbadQzjfLVKt0XvcsW091lsApH72GT11HjYzWe83u7ZAy+U6cfkfcfNCtdsx6DBJsteuoeEojirje/t+4hWvafptYHYVRuNgqVYk5B7xb8bmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797617; c=relaxed/simple;
	bh=sXHZzn+JjJJi928Htbnjq0+86tOW40SVkogmDR3DntY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t+OiIEmTKHkVLsDewn73qqw6i5QLD9t5ks+6VzxWmdAIIwZQWcHC+MyvoyGyJPz+Ty4vGNM61soi/+qVP9bCsK7rXAGwqA/h0FaO8X02FzV0QeRCaOwfizZVICiB4ir7kD4/9s1e0NpO24Ce6mo6JrEcyQ3paJNeaAoa3uXsxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBhd615F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBhd615F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865701F000FF;
	Wed, 30 Sep 2026 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797615;
	bh=/aOKH9q/QcNYdejOfaPKhln1NK3PMPKeQAbwXRIyiX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBhd615FFZgyTc+O0A388on6RI3NYf6AQrd6MjrjV227uU739WavrxT5+wYo4r0n1
	 7N8qjwcHMBQwFTTaAgvMmexls0nL8BMkZdnTTLZ+K/VPK4xJ39NAIWVrq9YPrXwVaQ
	 OtqpGI11fT2huzWE4xetJZvLRiM1P4zbJXkkjG/MkOcZYk9ToDUG0mbwqT/cVdraP5
	 zfuZy424J3GKlAYnflHaPzpnEUMEe+wjHnVn3lqFsl80NEXUxfMDk7XlDdxdRupq9w
	 MOZzZfFOQ9EdbdwOsIueB4I+hwV1XGByC4byBqftPXVuHuPoROthLQSV3Ts/r6HQIR
	 ElZIm2icQXQUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 11/14] libbpf: Keep global data in arena when
 the object has .arena.data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930193127.2181684-12-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-12-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 19:46:55 +0000
Message-Id: <20260930194655.865701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] libbpf: integer overflow in bpf_object__collect_data_ptr() allows =
heap corruption
- [Medium] libbpf: ARENA map bypasses pinning and reuse if data pointers ex=
ist
--

commit d23345bdc249c218c8d1f72cbc12d47c5a72bd22
Author: Alexei Starovoitov <ast@kernel.org>

libbpf: Keep global data in arena when the object has .arena.data

This commit introduces support for placing global data within an arena for
objects containing a .arena.data section. It appends .data, .bss, and .roda=
ta
sections after __arena variables, converting relocations against these
sections into relocations against the arena map.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5736,6 +5954,10 @@ bpf_object__create_maps(struct bpf_object *obj)
>  			continue;
>  		}
> =20
> +		/* see bpf_object__relocate_data_ptrs() */
> +		if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA && obj->arena_mapped)
> +			continue;
> +

[Severity: Medium]
Since bpf_object__relocate_data_ptrs() can create the ARENA map early and
set obj->arena_mapped to true, will this skip bypass the pinning and reuse
logic in bpf_object__reuse_map()?

If an application uses both data pointers and pinned ARENA maps, it appears
the map sharing might break because the early creation unconditionally skips
pin_path and reuse evaluations.

>  		err =3D map_set_def_max_entries(map);
>  		if (err)
>  			goto err_out;

[ ... ]

> @@ -8067,12 +8348,84 @@ static int bpf_object__collect_map_relos(struct b=
pf_object *obj,

[ ... ]

> +static int bpf_object__collect_data_ptr(struct bpf_object *obj, const ch=
ar *relo_sec_name,
> +					int relo_idx, size_t sec_idx, const Elf64_Rel *rel,
> +					const Elf64_Sym *sym)
> +{
> +	Elf_Data *scn_data =3D obj->efile.secs[sec_idx].data;
> +	const char *sym_name =3D elf_sym_str(obj, sym->st_name) ?: "<?>";
> +	struct data_ptr *ptrs;
> +
> +	if (ELF64_ST_TYPE(sym->st_info) =3D=3D STT_SECTION && sym->st_shndx < o=
bj->efile.sec_cnt)
> +		sym_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, sym->st_shndx)) ?: =
"<?>";
> +
> +	if (ELF64_R_TYPE(rel->r_info) !=3D R_BPF_64_ABS64 ||
> +	    sym->st_shndx >=3D obj->efile.sec_cnt ||
> +	    (sym->st_shndx !=3D obj->efile.arena_data_shndx &&
> +	     !bpf_object__shndx_is_data(obj, sym->st_shndx)) ||
> +	    rel->r_offset + sizeof(__u64) > scn_data->d_size) {

[Severity: High]
Could this bounds check overflow if rel->r_offset is maliciously large
(e.g., UINT64_MAX - 7)?

Since both operands are unsigned 64-bit integers, the addition might wrap
around to 0, which would incorrectly pass the > scn_data->d_size check.

If this check is bypassed, the overflowed offset is later used in
bpf_object__relocate_data_ptrs():

    memcpy(&val, map->mmaped + p->sec_off, sizeof(val));
    val +=3D addr;
    memcpy(map->mmaped + p->sec_off, &val, sizeof(val));

Can this lead to an out-of-bounds read and write against map->mmaped,
potentially corrupting heap metadata in the process parsing the object?

> +		pr_warn("sec '%s': relo #%d: can't resolve pointer to '%s' at offset %=
zu when data is in arena\n",
> +			relo_sec_name, relo_idx, sym_name, (size_t)rel->r_offset);
> +		return -LIBBPF_ERRNO__RELOC;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930193127.2181=
684-1-alexei.starovoitov@gmail.com?part=3D11
