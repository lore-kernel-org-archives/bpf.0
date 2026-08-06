Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F8384243
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035478; cv=none; b=OP1tUBIs9K584zBugTBET/l4HB4BOybkydviqX6aUFAyKZTq70wKE42uYVz9LaIKO/G9ZyvHwVdf+qjWijx/T3+eFMm+Teg6i/62yWQy6UR0gxCsvWOlS3/Wv1XY01Na7HDtEEPeDbPM9gz9SO7X2TkFuA4KI33tv0dRe8onM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035478; c=relaxed/simple;
	bh=X0OZ5+UsgnylP5Z/eMROihWOGnfqKm5fyWRP0SeSvm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRRANsbIfLhhC4/saxjRKBbcbyEhu50Z13+xkEJJ3W7RVH3VZrAnjxpJKA/hGIjCoVzlJU2kyKCHT0ZOpDXPwybkN8YoezXzvnxVtgaHsWqagZv5EAPEu7cK5TLNtbGnVfppAGKe+wu76eO+kRO0I4n6Jb+1qPRpKu+RKtwPqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHK40B1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHK40B1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77971F000E9;
	Thu,  6 Aug 2026 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035474;
	bh=PrNv3OcZbYlwHVJ9IZec1C0bilosJO9UCIFni5CpJPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cHK40B1iNsxDnncT4IFABtQFOWlDf0MDWrrFDcNWQmrVcgUdG136P0/MEwaNqP4lv
	 4QFJQ9fupQrx6wH4tiGRYJfNzX78mXxC6VGd02lFSrPdyyrPY8nbu2qiTEglQJtACd
	 c1YrCdByvL9FhTirbaVTEBaeYJTx/P8RVN8p4KzvIx0w3GpTrSZwOanpetXzoKYiQu
	 wtDcVKEv2uHf6SMli6c5XoKQsOOvDH7PTeI+qtATMR8KqtyEIXyBqkAkWnvwEgE3/w
	 SzAs8He1Fv3XkG7Nr3lvJYYxiJC5v/MyIRagYwz9Jb5THufBDUStDwKdjLUSjAEGC1
	 t/uJ2IOaLZxcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 05/10] libbpf: Add support for global
 percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806163125.11172-6-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
 <20260806163125.11172-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 16:57:54 +0000
Message-Id: <20260806165754.B77971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Dead code in percpu global data feature check
--

--- Patch [5]: [PATCH bpf-next v11 05/10] libbpf: Add support for global pe=
rcpu data ---
commit ee97f8a8e25b5e9337024df3dd6f3a1aae4f6cdc
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add support for global percpu data

This commit adds support for global percpu data in libbpf by introducing a=
=20
new ".percpu" section. It updates the lightweight skeleton loader to use=20
BPF_F_ALL_CPUS when updating the percpu_array map and marks the mmaped data=
=20
as read-only after population.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa825..9f79a8e850fdb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -5293,18 +5326,26 @@ static int
>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map=
 *map)
>  {
>  	enum libbpf_map_type map_type =3D map->libbpf_type;
> +	bool is_percpu =3D map_type =3D=3D LIBBPF_MAP_PERCPU;
> +	const __u64 update_flags =3D is_percpu ? BPF_F_ALL_CPUS : 0;
>  	int err, zero =3D 0;
>  	size_t mmap_sz;
> =20
> +	if (is_percpu && !obj->gen_loader && !kernel_supports(obj, FEAT_PERCPU_=
DATA)) {
> +		pr_warn("map '%s': kernel does not support percpu data.\n",
> +			bpf_map__name(map));
> +		return -EOPNOTSUPP;
> +	}
> +

[Severity: Low]
Is this check reachable?=20

Looking at bpf_object__create_maps(), if the kernel does not support
FEAT_PERCPU_DATA, map->autocreate is set to false and the map processing
loop continues early:

bpf_object__create_maps() {
    ...
    if (bpf_map__is_internal(map) && bpf_map__type(map) =3D=3D BPF_MAP_TYPE=
_PERCPU_ARRAY &&
        !kernel_supports(obj, FEAT_PERCPU_DATA))
        map->autocreate =3D false;

    if (!map->autocreate) {
        pr_debug("map '%s': skipped auto-creating...\n", map->name);
        continue;
    }
    ...
}

Since bpf_object__populate_internal_map() is called later in this same
loop (after the continue), wouldn't the !kernel_supports() condition
already be filtered out, making this warning dead code?

>  	if (obj->gen_loader) {
>  		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
> -					 map->mmaped, map->def.value_size);
> +					 map->mmaped, map->def.value_size, update_flags);
>  		if (map_type =3D=3D LIBBPF_MAP_RODATA || map_type =3D=3D LIBBPF_MAP_KC=
ONFIG)
>  			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
>  		return 0;
>  	}
> =20
> -	err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
> +	err =3D bpf_map_update_elem(map->fd, &zero, map->mmaped, update_flags);
>  	if (err) {
>  		err =3D -errno;
>  		pr_warn("map '%s': failed to set initial contents: %s\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806163125.1117=
2-1-leon.hwang@linux.dev?part=3D5
