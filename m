Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AB3CF963
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673250; cv=none; b=jR1y9xuWzXRM1IeallvrZnYHZx6BaoIFoZew0Lb/uX6xKlLaQf98zq8EB2tiQMDkPDx9We+MGISL0NQp0WIqrbuWNf6arfd5Go867/aK+XUtpzAge8AyfvhdL+laV+/Us7RwRkGnxEQX0ki8ybXQAyNHJB5T5Ud15jhp3GyEHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673250; c=relaxed/simple;
	bh=AWxUVweQ/ujapXjCAPFmRwZvWT8pa6VItSdXPvBrlgA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=W7dUe6zKqSt4wN/n1bJpKPj0by2wk3BnYZJYhL4d2ZXAT01a2YBa8rqDZtn4te1q2WBsZlMy9Wq55XAVqlkyUf6nj3odxgEGbG4UAqPWR1Xk30G+0p11hXfrDC9Hu6s9ZgIKeH8U2X2yG/9Qn2/G5hnxoKZpty3yJuCkumFG0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/UNE13L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/UNE13L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0721A1F000FF;
	Sat, 10 Oct 2026 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791673242;
	bh=oZVdC3jLdlTYhiGabKwA95L8N9LAw0LR2b0d2P/olMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/UNE13LhQU8junLCT60zH4hSFrrmUC7gkjxR+uDYzhGUr6fu7qbUfDSvxMTQC0JX
	 9DJ/HwaFeKn0Y30S7qMtHSQ98+BHrpXHSXYt6GDIdWetbG5SIX3bOyZ7xcR8TmPzWy
	 I3l+LmBqgwLBoUg7FqiVCqWmemp//0NII6rpxO2I1C9MPVIJlA1DYWKM5OyB+ZYAzs
	 X7OkhMSeEXRUrEOXuqritl3z5qSdG52mKTqwFOnFhSDInhVajRLr8hXdddMChobGed
	 2dsSLRhjT+iWU8sKz1Jkw9Zs9N5Aj/1avtF9xdrFRoJOsDxudhtWMEeUgoRucdOuSC
	 8CLFOIEiaJDKw==
Message-ID: <sashiko-outbox-166916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] bpf: Add an arena flag to retain allocated pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010224902.1232178-2-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
 <20261010224902.1232178-2-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 23:00:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: BPF_F_ARENA_NO_FREE breaks virtual address unreservation and =
kernel error rollbacks
--

commit 9eb2222524999c1d26f887b5ad559236c846afe7
Author: Andrea Righi <arighi@nvidia.com>

bpf: Add an arena flag to retain allocated pages

This commit adds BPF_F_ARENA_NO_FREE to retain arena pages until the map is
destroyed. It modifies BPF page-free operations to be no-ops in both sleepa=
ble
and non-sleepable programs when the flag is set.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 0ff707707da04..343e84139ec29 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
[ ... ]
> @@ -1134,7 +1135,8 @@ __bpf_kfunc void bpf_arena_free_pages(void *p__map,=
 void *ptr__ign, u32 page_cnt
>  	struct bpf_map *map =3D p__map;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> =20
> -	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
> +	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign ||
> +	    (map->map_flags & BPF_F_ARENA_NO_FREE))
>  		return;

[Severity: High]
Does unconditionally skipping arena_free_pages() prevent virtual address
unreservation?

When bpf_arena_free_pages() returns early, it skips range_tree_set().

This leaves the virtual addresses perpetually locked in the range tree as
"allocated", causing subsequent bpf_arena_alloc_pages() calls on that
address to fail with -EBUSY.

>  	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
>  }
> @@ -1144,7 +1146,8 @@ void bpf_arena_free_pages_non_sleepable(void *p__ma=
p, void *ptr__ign, u32 page_c
>  	struct bpf_map *map =3D p__map;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> =20
> -	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
> +	if (map->map_type !=3D BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign ||
> +	    (map->map_flags & BPF_F_ARENA_NO_FREE))
>  		return;

[Severity: High]
Does unconditionally skipping arena_free_pages() here break external kernel
callers that rely on this function for error rollbacks?

For example, subsystems like sched_ext use bpf_arena_free_pages_non_sleepab=
le()
to roll back partial allocations:

kernel/sched/ext/arena.c:scx_arena_grow() {
    ...
	ret =3D gen_pool_add(sch->arena_pool, ...);
	if (ret) {
		bpf_arena_free_pages_non_sleepable(sch->arena_map, p, page_cnt);
		return ret;
	}
    ...
}

In this kernel error path, if gen_pool_add() fails, the rollback becomes a
silent no-op.

The physical pages and virtual address range remain allocated in the arena,
but the pointer is dropped, permanently leaking capacity within the arena.

>  	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010224902.1232=
178-1-arighi@nvidia.com?part=3D1
