Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5F433050
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356737; cv=none; b=TvPany1zJ0HWh6NNcFf4moSGV6feEZ3Ga0YfUG+N5NCiL/HuXcpzl3Y4BsRXMqeTX6QQZhpF6w4HQqUiqDB5rUUhy3X1ZowcM2pzF3mcqgZGnAvCU/UstUm/4uirYQNPjYSigl7cKn11rNLm7guSGjQQ0ZR3BwSY42vu76qBgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356737; c=relaxed/simple;
	bh=xS+Y5KT/3cTVUW4X+yX26MaKtkMBf43Ao/UVCkcQ2RI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oB+VCNbWXQ2dSBKouIgvS1dM5H8fL9gpJM89uO0Am+HrwL51CXl1p+IUowEY71YXshb8hlSFtjCRU+udvP1BrV9wubJFwwzooa52eWo+sOi840vxIN+jFTbkF0hYwfm9JnRYGDLkC1aB+gIWo21Qo0hVVHLF6i3ELFi7fFZOjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI0WdDdU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI0WdDdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE161F00A3A;
	Fri, 21 Aug 2026 23:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787356735;
	bh=SaW0EgZSp29CniIJMmoqN2h8US81Rslj5VXqPioaU54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KI0WdDdUmwq514UHEezw2CYitnxGI/9ndLaquijaftTamHyejpg2lH3mzwLvEOQkb
	 9xzzJcB1tqCA6Ej446SxecmvM0iJJPGXlkWx6dd/9B2Zd2i7RdtKbeP+57gYRi5HAR
	 EveNtFH2YsVe7ZxdosqF+l5tDGswn3OdgC1kTIkumWqOuSpp03CbaLoBeAKOo1Pod5
	 S7MFyWyhiqf1iH/tgaLC7UORD2tYcVan3B4r2mshBK9FRE9uAPdSdqMUDNdym3Xmvj
	 8flJQGi0QHxGRX3sk6eQJwdgEEWT/ekwAONUvbwuxTmldOxURNFtkz7DLAujS2T1aB
	 qZhae7GlpyU2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument
 flags with suffixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821233516.3426127-12-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-12-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 23:58:55 +0000
Message-Id: <20260821235855.8AE161F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing address translation in non-sleepable arena kfuncs leads to=
 arena memory corruption.
--

--- Patch [11]: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument=
 flags with suffixes ---
commit a7446937b514c39a83585718956aa0b543092b07
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Replace arena kfunc argument flags with suffixes

This commit replaces the KF_ARENA_ARG1 and KF_ARENA_ARG2 flags with
__arena and __arena__nullable BTF suffixes for arena kfuncs. It also
updates the main kfuncs to translate JIT-provided kernel addresses back to
user addresses using arena_kaddr_to_uaddr().

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..6c34a0d34b3f9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
[ ... ]
> @@ -1044,18 +1044,28 @@ static void arena_free_irq(struct irq_work *iw)
>  	schedule_work(&arena->free_work);
>  }
> =20
> +static long arena_kaddr_to_uaddr(struct bpf_arena *arena, const void *ad=
dr)
> +{
> +	if (!addr)
> +		return 0;
> +
> +	return (long)addr - bpf_arena_get_kern_vm_start(arena);
> +}
> +
>  __bpf_kfunc_start_defs();
> =20
> -__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u=
32 page_cnt,
> -					int node_id, u64 flags)
> +__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__arena_=
_nullable,
> +					u32 page_cnt, int node_id, u64 flags)
>  {
>  	struct bpf_map *map =3D p__map;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +	long addr;
> =20
>  	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || flags || !page_cnt)
>  		return NULL;
> =20
> -	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, true);
> +	addr =3D arena_kaddr_to_uaddr(arena, addr__arena__nullable);
> +	return (void *)arena_alloc_pages(arena, addr, page_cnt, node_id, true);
>  }
> =20
>  void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign,=
 u32 page_cnt,

[Severity: High]
Does this code miss address translation when the verifier dynamically repla=
ces
the kfunc with its non-sleepable or sleepable variants?

When a BPF program calls bpf_arena_alloc_pages() from within a non-sleepable
context, the verifier replaces the call with bpf_arena_alloc_pages_non_slee=
pable().

Since the BPF JIT adds kern_vm_start to the pointer argument based on the
__arena__nullable annotation on the main kfunc, won't bpf_arena_alloc_pages=
_non_sleepable()
receive a kernel address in addr__ign?

Because bpf_arena_alloc_pages_non_sleepable() just casts addr__ign without =
calling
arena_kaddr_to_uaddr(), it appears this will pass a kernel address directly=
 to
arena_alloc_pages(), potentially causing arena memory corruption or silent
allocation failures.

[ ... ]
> @@ -1082,14 +1092,20 @@ void *bpf_arena_alloc_pages_sleepable(void *p__ma=
p, void *addr__ign, u32 page_cn
>  	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node=
_id, true);
>  }
> =20
> -__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 =
page_cnt)
> +/*
> + * A valid arena address can have zero low 32 bits, so ptr must be rebas=
ed
> + * unconditionally instead of being treated as nullable.
> + */
> +__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__arena, u3=
2 page_cnt)
>  {
>  	struct bpf_map *map =3D p__map;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +	long ptr;
> =20
> -	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
> +	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt)
>  		return;
> -	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
> +	ptr =3D arena_kaddr_to_uaddr(arena, ptr__arena);
> +	arena_free_pages(arena, ptr, page_cnt, true);
>  }
> =20
>  void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u3=
2 page_cnt)

[Severity: High]
Does this have the same issue with the non-sleepable variant of free?

When bpf_arena_free_pages_non_sleepable() is substituted by the verifier, i=
t will
receive a JIT-rebased kernel address but will pass ptr__ign directly to
arena_free_pages() without address translation.

Will this cause the wrong pages inside the arena to be freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821233516.3426=
127-1-memxor@gmail.com?part=3D11
