Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988053845A2
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352940; cv=none; b=PHXbk+tYq+GkgcfY+dgEfMdw0mFocmNbHd9JAgn233fsn1+kkapSg7Vld7jFkaQPosqIv6GpX5l9vrz6sfqnjcv1buc7nmcFsWkJ1iy83MO9m0WruP2UtDpj18bTW4+8cketyNcIZc2XHVoYIFfmmQpK/3d7lXBxozHWHPzfU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352940; c=relaxed/simple;
	bh=SZAyjbQUHEpfHcxw7Z+J1UgDvjf0G4HO3g3mlJLPg48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uneb5ucvg5ilcwPaz+8Wy0yUQXuYKiwamCO7FecRx8Ka3ToKXbfciFtwH/3EU8WRBCY/HNCFFYRu6az00sXE62pjbF3AoNTrALjvPod2pRZRDwWCqZ8WXfACzi6+AT5n/OG0ST5VQmk60ie0PSsODIKuDZkbsQh4pBOdQ5gr380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8Q6Qzme; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8Q6Qzme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAB11F00893;
	Mon,  1 Jun 2026 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780352938;
	bh=Me4yldI1FcUQG5/rlEbJDx0//G38ZQJisJ9PtneWGik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8Q6QzmeEUDCXKxpYrA5dxq6irOBIXC6zGO3zbv0rd8PL0wCqeICZGp0szRwIlw2L
	 G0/KEQepZF8JQVHpMoN+XXkiFLF4AM6ge4jJLz0Eh76tcHBQvKLH4M6RpGXXQEmphe
	 zFQzvAY3GT9V/+wGOWRj77u9TwhbSVCjKiPVYZvU7X5EDvn+pwsC/9v7JPhRMsGMlQ
	 9GX1n7pZOnZ0yWUFZBk48BJOVYVrYwFrTfKwaVaibxeDpPe0dLIWrY3S2Lw4wScPr9
	 MHtuQ6d0sY+h6P81dYHMw0NgqaREUNAkzOzxdDYCDOBJ1PSVP/Ha1cDnJWSHHZWxeC
	 PZCY2/2Iau/Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 05/14] resolve_btfids: Index BTF ID symbols
 by address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601221805.821394-6-ihor.solodrai@linux.dev>
References: <20260601221805.821394-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 22:28:57 +0000
Message-Id: <20260601222857.DFAB11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] A maliciously crafted or empty symbol size can cause an integer =
underflow, leading to a 4-billion iteration loop.
- [Low] Calling qsort and bsearch with a NULL base pointer when the array i=
s empty is Undefined Behavior.
--

commit e05f36e9d7ac18c038a5933609937a41496ecf8f
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

resolve_btfids: Index BTF ID symbols by address

This commit introduces an address-sorted index for parsed .BTF_ids symbols.
It uses this index in find_kfunc_flags() to scan BTF_SET8_KFUNCS entries
directly and match each entry back to the requested kfunc.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -480,6 +489,49 @@ static int elf_collect(struct object *obj)
> +static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr)
> +{
> +	struct addr_sym key =3D { .addr =3D addr };
> +	struct addr_sym *res;
> +
> +	res =3D bsearch(&key, obj->addr_syms, obj->nr_addr_syms,
> +		      sizeof(*obj->addr_syms), cmp_addr_sym);

[Severity: Low]
Could this call trigger Undefined Behavior if there are no BTF ID symbols?

If the ELF file lacks these symbols, obj->addr_syms remains NULL and
obj->nr_addr_syms is 0. Calling bsearch with a NULL base pointer is
Undefined Behavior under the C standard, which can cause issues with UBSan
builds.

> +	return res ? res->name : NULL;
> +}

[ ... ]

> @@ -573,8 +625,14 @@ static int symbols_collect(struct object *obj)
>  			return -1;
>  		}
>  		id->addr[id->addr_cnt++] =3D sym.st_value;
> +
> +		if (push_addr_sym(obj, sym.st_value, id->name))
> +			return -1;
>  	}
> =20
> +	qsort(obj->addr_syms, obj->nr_addr_syms, sizeof(*obj->addr_syms),
> +	      cmp_addr_sym);

[Severity: Low]
Does this have the same NULL pointer issue as the bsearch call?

If the array is empty and obj->addr_syms is NULL, calling qsort here
triggers the same Undefined Behavior as described above.

> +
>  	return 0;
>  }

[ ... ]

> @@ -946,43 +1004,41 @@ static int collect_decl_tags(struct btf2btf_contex=
t *ctx)
>  static u32 find_kfunc_flags(struct object *obj, struct btf_id *kfunc_id)
>  {
>  	const u32 *elf_data_ptr =3D obj->efile.idlist->d_buf;
>  	struct btf_id *set_id;
>  	struct rb_node *next;
>  	u64 idx, set_addr;
>  	u32 set_flags;
> =20
>  	for (next =3D rb_first(&obj->sets); next; next =3D rb_next(next)) {
>  		set_id =3D rb_entry(next, struct btf_id, rb_node);
>  		if (set_id->kind !=3D BTF_ID_KIND_SET8 || set_id->addr_cnt !=3D 1)
>  			continue;
> =20
>  		set_addr =3D set_id->addr[0];
>  		idx =3D (set_addr - obj->efile.idlist_addr) / sizeof(u32) + 1;
>  		set_flags =3D elf_data_ptr[idx];
>  		if (!(set_flags & BTF_SET8_KFUNCS))
>  			continue;
> =20
> -		for (u32 i =3D 0; i < kfunc_id->addr_cnt; i++) {
> -			addr =3D kfunc_id->addr[i];
> +		for (u32 i =3D 0; i < set_id->cnt; i++) {

[Severity: Medium]
Could this loop iterate billions of times if a symbol size is unexpectedly
small?

When parsing SET8 symbols, the count is calculated as:

id->cnt =3D sym.st_size / sizeof(uint64_t) - 1;

If sym.st_size is less than 8, id->cnt (which is a signed int) becomes -1.

Because the loop index 'i' is an unsigned 32-bit integer, the comparison
promotes the signed -1 to 0xFFFFFFFF. Will this cause the tool to hang
spinning through 4 billion iterations if it processes a corrupted or crafted
ELF object?

> +			Elf64_Addr addr =3D set_addr + sizeof(u64) * (i + 1);
> +			const char *name =3D find_name_by_addr(obj, addr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601221805.8213=
94-1-ihor.solodrai@linux.dev?part=3D5
