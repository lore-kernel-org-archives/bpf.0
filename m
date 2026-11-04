Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756697;
	b=kDU1eq6ycBsJra7v6reqCqKBHwJD76tAEUsB5vp0dzGTK3AfWnbEzpPSp0DWDC9of0+3
	 BLQNK4181/N4ezn6iEQS+XEsWBhp8VNBTvNWWu/6ueweDlXOAI4iZsLfmpx6KoUpTN3FA
	 2rX/TBNBsXEF4FqORWPLPl5G7qiFYSBmt0iR8qcIWa8nj2K1As8uICjOi/sxVSb9HRdCp
	 r33D0qVtvX2UUXY26CHktiSDbXtlpMr0Yh5HECpqWh8cB6tqkLN2ZG3e39IOMch7mQiKR
	 kEIswfXmz7/mDkUKCOjzSOV+43HThdxBB2CeyeFgLP5GfhAGjbz+93MWFNImSH+GpIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mziydOo6BG2gBYgrbnUM8zXxBDG1UHmhKN6owqY7sp4=;
	b=R2B9GYSn0Qmxj3zqsMyQGTHeixJe/FZrl+psd/8V7wNMQ5WcoZqMa3IKJRuQlt8fEuNf
	 Q6xB3/WLMEFlpSjNtwtiY1/ZhEBtodyEkgzfRSZAob6q08iRQGO/udNWiwkyY59WsvSjD
	 lE3Jj/Ve+lmObFjlwnCNQWa+aawVFfQR4369tOhZV9gitOWgXs8xaYZ6CxDmAd9Ly4HVq
	 BjU+It72H8FFRp3RWXKwuVlCHYw74dWVfxKY4Sq36r5RE1aFRnnNeYnSJJnqDCT/QsPmU
	 Jc9AQ7AerN/eMsDxiCaXZzTLrG59MrTqrSZQDQTsJoKRNvxq2eLDXM+K6NSDUFO22ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOvetmGO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45421606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOvetmGO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2271F000C1;
	Wed,  4 Nov 2026 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793756696;
	bh=mziydOo6BG2gBYgrbnUM8zXxBDG1UHmhKN6owqY7sp4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BOvetmGOAG9VMgCzAnpncapv1LNrLh7QYFlP6080f0vhaUMZYAtkdo8ax9V9zbNIK
	 nHW+9JHpKGRaPSoRtJSvRwf8m6QmddTKxybsN4GLxI4QrBt9q8ZhdXUQZEgAj6BF/D
	 RCsPqwgqLHw/KnF7FfWn4E3pCCvnRQ5T2A6d8XW1hnG2zUHq/wNEWHLcN9TuXhxYwi
	 eq4ECO3R1U5NpBMId/8cODGUk9FPOq4L2OqS5+DbZWsJ54dc8myYbOS9E99/i8wp/g
	 61EwqFtsMCGVCez8oq1UTY0DGSzfBIRiv4AO99eS2c1CNKTFgpAuwYUbgFBbrhDuk8
	 W8ibK7QyKGOPw==
Message-ID: <sashiko-outbox-196376@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 06/14] libbpf: Relocate pointers that are
 stored in arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261104012401.1354861-7-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
 <20261104012401.1354861-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:44:56 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] libbpf: memory leak and OOB access in bpf_object__collect_arena_=
relos()
--

commit 146cf79dea60b56b79e9a35a046106f0fa3e6d27
Author: Alexei Starovoitov <ast@kernel.org>

libbpf: Relocate pointers that are stored in arena

This commit teaches libbpf and the BPF static linker to relocate R_BPF_64_A=
BS64
pointers stored in arena data sections that reference other arena variables=
. At
open time, libbpf records the relocation offsets, and at load time, it adds=
 the
mapped arena base address and target offsets in place.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a7c53dc5b91df..1172fe7992bf5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -8223,6 +8246,59 @@ static int bpf_object__collect_rodata_relos(struct=
 bpf_object *obj,
>  	return 0;
>  }
> =20
> +/*
> + * Collect pointers that are stored in variables in arena, like
> + *   int __arena * __arena p =3D &var;
> + * They are R_BPF_64_ABS64 relocations. The addend is stored in place.
> + */
> +static int bpf_object__collect_arena_relos(struct bpf_object *obj,
> +					   Elf64_Shdr *shdr, Elf_Data *data)
> +{
> +	int i, nrels =3D shdr->sh_size / shdr->sh_entsize;
> +	struct arena_ptr *ptrs;
> +	const char *sym_name;
> +	size_t sym_idx;
> +	Elf64_Sym *sym;
> +	Elf64_Rel *rel;
> +
> +	ptrs =3D libbpf_reallocarray(NULL, nrels, sizeof(*ptrs));
> +	if (!ptrs)
> +		return -ENOMEM;
> +	obj->arena_ptrs =3D ptrs;
> +
> +	for (i =3D 0; i < nrels; i++, ptrs++) {
> +		rel =3D elf_rel_by_idx(data, i);
> +		if (!rel) {
> +			pr_warn("sec '.rel%s': failed to get relo #%d\n", ARENA_SEC, i);
> +			return -LIBBPF_ERRNO__FORMAT;
> +		}
> +
> +		sym_idx =3D ELF64_R_SYM(rel->r_info);
> +		sym =3D elf_sym_by_idx(obj, sym_idx);
> +		if (!sym) {
> +			pr_warn("sec '.rel%s': symbol #%zu not found for relo #%d\n",
> +				ARENA_SEC, sym_idx, i);
> +			return -LIBBPF_ERRNO__FORMAT;
> +		}
> +
> +		if (ELF64_R_TYPE(rel->r_info) !=3D R_BPF_64_ABS64 ||
> +		    (sym->st_shndx !=3D obj->efile.arena_data_shndx &&
> +		     sym->st_shndx !=3D obj->efile.arena_bss_shndx)) {
> +			sym_name =3D elf_sym_str(obj, sym->st_name) ?: "<?>";
> +			pr_warn("sec '%s': pointer to '%s' at offset %zu: it's not in arena\n=
",
> +				ARENA_SEC, sym_name, (size_t)rel->r_offset);
> +			return -LIBBPF_ERRNO__RELOC;
> +		}
> +
> +		ptrs->off =3D rel->r_offset;
> +		ptrs->targ_off =3D sym->st_value;
> +		if (sym->st_shndx =3D=3D obj->efile.arena_bss_shndx)
> +			ptrs->targ_off +=3D obj->arena_bss_off;
> +		obj->arena_ptr_cnt++;
> +	}
> +	return 0;
> +}

[Severity: Medium]
Can bpf_object__collect_arena_relos() leak obj->arena_ptrs and overflow it
during relocate_arena_ptrs(), or fail with -ENOMEM when nrels is 0?

In bpf_object__elf_collect(), every SHT_REL section matching .rel.addr_spac=
e.1
is marked as SEC_RELO without checking sh_size > 0 or deduplicating target
sections. bpf_object__collect_relos() then calls
bpf_object__collect_arena_relos() for each SEC_RELO section whose sh_info
matches obj->efile.arena_data_shndx.

Because libbpf_reallocarray(NULL, nrels, sizeof(*ptrs)) passes NULL instead=
 of
reallocating obj->arena_ptrs for obj->arena_ptr_cnt + nrels, while the loop
still increments obj->arena_ptr_cnt++ cumulatively, two issues can occur:

1. If multiple SEC_RELO sections target arena_data_shndx, the second call
overwrites obj->arena_ptrs (leaking the prior allocation) and allocates only
nrels entries, while obj->arena_ptr_cnt holds the sum across both calls. Wh=
en
bpf_object__create_maps() -> relocate_arena_ptrs() later runs:

	for (i =3D 0; i < obj->arena_ptr_cnt; i++, p++) {
		memcpy(&val, data + p->off, sizeof(val));
		val +=3D (__u64)(unsigned long)data + p->targ_off;
		memcpy(data + p->off, &val, sizeof(val));
	}

it reads past the end of obj->arena_ptrs and corrupts memory at data + p->o=
ff.

2. If an empty .rel.addr_space.1 section has sh_size =3D=3D 0 (nrels =3D=3D=
 0),
libbpf_reallocarray(NULL, 0, sizeof(*ptrs)) calls realloc(NULL, 0), which m=
ay
return NULL and cause bpf_object__collect_arena_relos() to return -ENOMEM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104012401.1354=
861-1-alexei.starovoitov@gmail.com?part=3D6
