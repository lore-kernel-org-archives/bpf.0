Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504845;
	b=uctNfaIHjEVTeiab6o5hwH1VlkH3CpKvntRcdMouMM7iehKopbnSir9s6h6j8kxM/REB
	 UPZvDJXpnhDcHsiI8ZjIF8fLOVT4vgHNkB3iklXQ7mMVEnDoYFG9oIHOKXebDHlJxgTFJ
	 iSLMHFLhDB4qg1hCrWcvr8lfcinhzui68uCCWtGAI3LIaOmF7CZwNKGzxN6OO22q9pZe2
	 T50r9LEtLZe80Df1BPY80D9TF81LkTqVcg5o7M50oZBze12fCtk5wXk3AWAKNrXYo7p2H
	 ly/l0JO8p4/3VLJXpDYQOQJD1aa/qGiyMoYYQOWcquZY+sHOi1u14H2KhxJUxJCzIvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504845;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hqdIqNFuRseo5/W0ymTuUioOKujljNuJAkUi803qNZs=;
	b=SM42oip+9SOYe3/0jNzkEhcz2cbD84liP0oFcC3vOnHj2GAdLpHYvJjdc8oKKsI7H6HA
	 WMHuYWlQZtMOE9C/Gl0I08qhZhbZPBXik3qAjWT8tjQpdC7b5ghKEWNlXRBSXugPSIyEg
	 vVszF8gyiGxNsSegI30lYhJNCd3SQ1BBZ6I8Cz5GLIG5Nmz3XaA+1c4dTl7Z16JO6j84I
	 Bp+/woM7t3tdcgdnA/O0QWF4wp34r8tDdxCrxbzfCq/kRdpgeKs2wyPuzT1HYsUyCkvaH
	 wL6WoOxL2VXvz/vnownlFRRM8qk7r8IselZqfDiDtyNwmhGQDPl8EmIA3TgaOV+MSeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3bmvTtz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6E60A261F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3bmvTtz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EFB1F000C7;
	Tue, 20 Oct 2026 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504845;
	bh=hqdIqNFuRseo5/W0ymTuUioOKujljNuJAkUi803qNZs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z3bmvTtzH81bgc5DfcS8VXI9J/e7sDPoqYCwTd/2BwK4z58S63v7lqo7RjCMVZf5E
	 ShSG/rUOxqcwfjB3seFls5hYMBZ2bJ6gkHBImB/Gb9g29BAa82jAY54hgis4mI4UVD
	 FD4TXwjDBbBZh+4+cGfrwJKvis4kQZcUp6RSEcNv3HC5Txq+tlXD/Chf55LkAyYYg7
	 UsSzDu5h0PM4fLiwGoh+nu497AHlNanmJ0TElLB1vTIyTpzQezxZHrVYV4elFi1L3N
	 Osx5+Qs7gJ2/40hhwLpMVU6kWiGda/VyafRJN8Bq31J2HY/vnD+aYnh0xOODU1SuyY
	 efppIZXEvzWUw==
Message-ID: <sashiko-outbox-179074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 12/16] libbpf: Introduce arena percpu helpers
 for user space
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <d56952f063f90acb07c0a37c96a83851bea227d8.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <d56952f063f90acb07c0a37c96a83851bea227d8.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:00:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] libbpf: missing errno on error paths in bpf_map__arena_percpu_ba=
se()
- [Low] libbpf: 32-bit pointer cast warnings in bpf_map__arena_percpu_ptr()
- [Low] libbpf: inaccurate @return doc comment for bpf_map__arena_percpu_pt=
r()
--

commit e49cfa2af43e08885b5b19954e2551d5cbd7f6e2
Author: Xu Kuohai <xukuohai@huawei.com>

libbpf: Introduce arena percpu helpers for user space

This commit adds bpf_map__arena_percpu_base() and bpf_map__arena_percpu_ptr=
()
to libbpf so user space and generated skeletons can access arena per-cpu
areas.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index be2ddaf966318..0edce476451c3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12287,6 +12287,55 @@ void *bpf_map__initial_value(const struct bpf_ma=
p *map, size_t *psize)
>  	return map->mmaped;
>  }
> =20
> +void *bpf_map__arena_percpu_ptr(const struct bpf_map *map, void *ptr, un=
signed int cpu)
> +{
> +	struct bpf_object *obj;
> +	uint64_t base;
> +
> +	if (!map || !ptr)
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	obj =3D map->obj;
> +	if (map->def.type !=3D BPF_MAP_TYPE_ARENA || !obj->arena_percpu.present)
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	if (cpu >=3D obj->arena_percpu.nr_chunks)
> +		return libbpf_err_ptr(-ERANGE);
> +
> +	/*
> +	 * obj->arena_percpu.chunk is freed by arena_percpu_populate(), and only
> +	 * then the map is mmaped
> +	 */
> +	if (obj->arena_percpu.chunk)
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	base =3D (uint64_t)map->mmaped + obj->arena_percpu.offset;
> +	if ((uint64_t)ptr < base || (uint64_t)ptr >=3D base + obj->arena_percpu=
.chunk_sz)
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	return (void *)((uint64_t)ptr + (uint64_t)cpu * obj->arena_percpu.chunk=
_sz);
> +}

[Severity: Low]
Will casting map->mmaped and ptr directly to uint64_t and back to void * in
bpf_map__arena_percpu_ptr() fail the build on 32-bit architectures?

Since tools/lib/bpf/Makefile sets -Wall -Werror, casting between a 32-bit
pointer and a 64-bit integer triggers -Wpointer-to-int-cast and
-Wint-to-pointer-cast warnings. Would using uintptr_t or void * pointer
arithmetic with size_t avoid this?

> +
> +void *bpf_map__arena_percpu_base(const struct bpf_map *map)
> +{
> +	struct bpf_object *obj;
> +
> +	if (!map)
> +		return NULL;
> +
> +	obj =3D map->obj;
> +	/*
> +	 * The per-cpu chunks exist once the map is created and populated;
> +	 * obj->arena_percpu.chunk is freed by arena_percpu_populate(), and
> +	 * only then the map is mmaped
> +	 */
> +	if (map->def.type !=3D BPF_MAP_TYPE_ARENA || !obj->arena_percpu.present=
 ||
> +	    obj->arena_percpu.chunk)
> +		return NULL;

[Severity: Medium]
Should the error paths in bpf_map__arena_percpu_base() return
libbpf_err_ptr(-EINVAL) instead of a bare NULL?

Because bpf_map__arena_percpu_base() is exported as a public LIBBPF_API
function in tools/lib/bpf/libbpf.h and tools/lib/bpf/libbpf.map, returning
NULL without setting errno when map is NULL, when map->def.type is not
BPF_MAP_TYPE_ARENA, when !obj->arena_percpu.present, or when
obj->arena_percpu.chunk is still set prevents callers from inspecting errno
or using libbpf_get_error().

> +
> +	return map->mmaped + obj->arena_percpu.offset;
> +}
> +
>  bool bpf_map__is_internal(const struct bpf_map *map)
>  {
>  	return map->libbpf_type !=3D LIBBPF_MAP_UNSPEC;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 3e0b7bc91bef9..31d3982226cc7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1230,6 +1230,32 @@ LIBBPF_API int bpf_map__set_initial_value(struct b=
pf_map *map,
>   */
>  LIBBPF_API void *bpf_map__initial_value(const struct bpf_map *map, size_=
t *psize);
> =20
> +/**
> + * @brief **bpf_map__arena_percpu_ptr()** translates an address within
> + * cpu 0's chunk of the arena's per-cpu area (e.g. the address of an
> + * `__arena_percpu` variable as seen in the skeleton's arena_percpu
> + * section) to the per-cpu chunk of the requested @cpu.
> + * @param map the ARENA map
> + * @param ptr address of an `__arena_percpu` variable (cpu 0's chunk)
> + * @param cpu cpu id to obtain the chunk for
> + * @return pointer to the variable in the chunk of @cpu; error pointer, =
if the
> + * map is not a loaded ARENA map with a per-cpu area, @cpu is out of ran=
ge,
> + * or @ptr is not within cpu 0's chunk
> + */
> +LIBBPF_API void *bpf_map__arena_percpu_ptr(const struct bpf_map *map, vo=
id *ptr,
> +					   unsigned int cpu);

[Severity: Low]
In the @return comment for bpf_map__arena_percpu_ptr() in
tools/lib/bpf/libbpf.h, it states that the function returns an "error
pointer" on failure.

In tools/lib/bpf/libbpf.c, bpf_map__arena_percpu_ptr() returns via
libbpf_err_ptr(), which sets errno and returns NULL rather than an ERR_PTR.
Should the comment state that it returns NULL with errno set instead?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D12
