Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C544E67D
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393131; cv=none; b=LCJuphWe6JF1JDwPRm+d0j6vuH7TK3QubT97rj2MEIaoIwI2i7ueploFc4ThE/W6XDIYl1L+EjLZz4uGC2/2kQY6PtvcJNAiAek/vNKmYwow75HrtYnSq7jauedRpXOnEKefJWtrrp70iy8N8fTdQbJRyuvscFa04LuHex/Jp24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393131; c=relaxed/simple;
	bh=Zb+FJklcmr78D01rFQoiKCDVf0PUI2luCy8JiJq3ur0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=s9OnHR7+zJ9OmUmg/qdpQhW7uSIo63oCRg7eqVH1DeZa+SrkYEfqXOnRVEj1ZJYyLWZQrmYcXoaTcjVVVDRIPLzyfazLiVlFJT2K9hWIZD3MxrS9F6D4ohhZuXwgC1s894Z5NXYIOcPbQ5BI2lgQLcnrzaS7c8UIsiWFTTqmQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogMA/RRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogMA/RRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E51F000C4;
	Mon, 19 Oct 2026 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393130;
	bh=aJlqgxp41eAYYigFtpNAqy8U/Byaa9W5YO4I3+RNMyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ogMA/RRijFq2qd3pavq5UwIVnN9FHzMkCa6FNXL18Ov8QEIwg1SMOQ3kjCPWGOu2C
	 WEZhy+uHqhFSfQeKXsRoASsHXR4bSQeZF2VzGFqY+5nMBQEeAhUmE6oYdoeJrniwXS
	 Z6zR8oYlR5M/i4z8zsydovatS5TGjAUMHe8eoshN7Los1G3EzPJL//Dp1KyG8wPxCn
	 jJEHYrCksZTMH+bqK73FWGDWb0KaYcd0WvITihAp7xy1hSpuoneFop9tlbUdqSazGV
	 xMFQbx5c+R7q4KBuQXHmW2eRS1YGULWfpwJi/RNsTIIRGIaAU0eAE+G90ae29pv1es
	 EZF9A3f+JhcIw==
Message-ID: <sashiko-outbox-176727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 bpf-next 4/5] sched: add BPF-based per-cgroup
 NUMA balancing mode selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, david@kernel.org, gourry@gourry.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, zhao1.liu@intel.com, tim.c.chen@linux.intel.com, lizhe.67@bytedance.com
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261019064157.29885-5-laoar.shao@gmail.com>
References: <20261019064157.29885-1-laoar.shao@gmail.com>
 <20261019064157.29885-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:58:48 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] mm: use-after-free on source folio in migrate_misplaced_folio()
--

commit 5de3ed8c82d3030544f5f025b8ae47dd8339bfeb
Author: Yafang Shao <laoar.shao@gmail.com>

sched: add BPF-based per-cgroup NUMA balancing mode selection

This commit introduces per-cgroup NUMA balancing mode selection managed via
the bpf_numab_set_mode() and bpf_numab_get_mode() kfuncs. Hot paths combine
requests along the task or folio's memcg cgroup hierarchy behind the
numab_cgroup_mode_set static key to override the global sysctl setting.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 211c29bd2a283..c0692c7b27467 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c

[ ... ]

> @@ -2770,7 +2770,7 @@ int migrate_misplaced_folio(struct folio *folio, in=
t node)
>  	if (nr_succeeded) {
>  		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
>  		count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
> -		if ((numab_in_tiering_mode())
> +		if (folio_numab_in_tiering_mode(folio)
>  		    && !node_is_toptier(folio_nid(folio))
>  		    && node_is_toptier(node))
>  			mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS, nr_succeeded);

[Severity: Critical]
Has the source folio already been uncharged and freed by the time
migrate_misplaced_folio() calls folio_numab_in_tiering_mode(folio) here?

Before calling migrate_pages(), migrate_misplaced_folio() snapshots the
folio's memcg because migration transfers the charge and releases the
isolation reference on the source folio:

migrate_misplaced_folio()
  memcg =3D get_mem_cgroup_from_folio(folio);
  migrate_pages()
    migrate_pages_batch()
      migrate_folios_move()
        migrate_folio_move()
          move_to_new_folio()
            folio_migrate_flags()
              mem_cgroup_migrate()
                old->memcg_data =3D 0;
          migrate_folio_done()
            folio_put(src);

When nr_succeeded is non-zero, calling folio_numab_in_tiering_mode(folio) ->
folio_numab_mode(folio) -> folio_memcg(folio) -> folio_objcg(folio) reads
folio->memcg_data on the freed source folio:

static inline struct obj_cgroup *folio_objcg(const struct folio *folio)
{
	unsigned long memcg_data =3D folio->memcg_data;

	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);

	return (struct obj_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
}

If the freed page has not been reallocated yet, folio->memcg_data is 0, so
folio_memcg(folio) returns NULL and folio_numab_mode(folio) falls back to
NUMAB_FOLLOW_SYSTEM rather than using the owner cgroup's tiering mode for
PGPROMOTE_SUCCESS accounting.

If another CPU reallocates the freed page before this check runs (for examp=
le
as a slab page setting PG_slab and MEMCG_DATA_OBJEXTS, or as a compound tail
page), can folio_objcg(folio) trigger VM_BUG_ON_FOLIO() or dereference a
slabobj_ext pointer as a struct obj_cgroup *?

Would it make sense to evaluate folio_numab_in_tiering_mode(folio) before
migrate_pages(), or derive the mode from the already-pinned memcg pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019064157.2988=
5-1-laoar.shao@gmail.com?part=3D4
