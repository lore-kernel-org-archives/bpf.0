Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316234402A
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395671; cv=pass; b=GPX58/j4GaU5CTj0BUCBn/mrcfCfmGaMg2XS8nIYlPt2UXEUv0jQ/e8LvLuxQESdbepMNfKsOdkq26ei8CsclzfitMEuFCrPvY0YGmsY5Pxjt4EQOoWATD015OPhlXOwSaXTZGE3oBUwq4CrUGhQ0VvBssaXd0ngqjQh8nf1tls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395671; c=relaxed/simple;
	bh=jPqPx4WIvZCwXAxSt7/GckqZUZbeRwYWXgGLl4PYDUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyGs+LZCEoLbhJ6MaZ7x/i73+SPT7JkDgUIsZXPPt+LprgTW9Y2HyIC3u9t0FlOPXnsFFtaBW8LESMyPgng0XGYdRKJh/0n8w9UhhUPkLwd1MkbKYdWDACnkNXtaAy75l862w14m749ybqQTORpKeUxnUj7kaORkoW+X8GIcP9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stj+Pqak; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stj+Pqak"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6767d92cde6so1791771d50.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 00:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792395669; cv=none;
        d=google.com; s=arc-20260327;
        b=NgmIsTDjjE30KlteA7Hw84WfOGJdMGTgeALnUWm5tBxhidR/ChwXNSMEtHBXI7Oik8
         bojFSPsbbIv5VgSD7uEiDc8n3jlrQ4jmdxsAVqc7K2d1Q5LD2Vyztfek3qtXkhhM/Fs7
         Xp9V2T89PMh/T5xYBPhmR3OehI5/jwA9UpbgmAel5kKF02MWFmcQW642v4TRjClHPcvi
         269nvVH4oucSoKy6F+rthLBbpcpDJ/hVO95U412LW/fpuln8VSt/YNDp49PPv6/zy+ec
         MELtayPLBp9G3s7IxshQxxn+nkh6YDdYdJdJiyJ0RlYH2cC8L2jcuxhU/9nMpcg02mGq
         wbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KpPZjaMDJls8EZkE/6oJfht+hbPc5JiwcvTAxpT7o3k=;
        fh=68XgUMEiNz1cPFdRyhq8eSNGUkRCrVWVM72BKwfZYWg=;
        b=An0WIlhXKfVCzE+O1sIPKSD1V0oDZFOgsFwrZ6jF9/kEwSc7N5wYL6o2aOeCHlFnOu
         Gofsnb6nPGxZHf6QGJumWAxviPTTRVGYpcl6Q0urXNFhUngtTR6Ilo2yuYX9qWzQoXxM
         LDM2yyQGFi5NtY689db6Ad5+MNEPWopYU7GlwttE1EEP8wXWeAmbFKKuvN0fpPujO/TQ
         j5lE37y4daDnyGXWycLuytYN/kzB0PncXFSeEgPaNTUKPcQRdcphscIi4+NbMm2zr8Y1
         Bay8He2YSggYLJ9oeO5LYAk4UPQPg+YJvlhKFjfKxZEqCHvXHM/Kghw/nstwRDGYxNmQ
         hGjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792395669; x=1793000469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KpPZjaMDJls8EZkE/6oJfht+hbPc5JiwcvTAxpT7o3k=;
        b=stj+PqakSpfB9TgMBuG3ew92Dxs8Jpin0cIq86kR4EmmUUYSeCG5u+C5Fscbml1Fp8
         d84f0CuerA765uEw+KWLF30h9coIaUF4cRdelXJu/N62PpWKPXRMT9QhUIt2NVHDKn0M
         cBwQLTtfCnIeHUtsUMK9eJBUqfO1PJYPJq/bPK3SJ57/Vq2NfjE6ZYexHudycwJ0NCju
         lj+No9ujD4yYFc8Don+rCejq0c5rRI7GqncKINnwdbd6+7yQpOameLmiK11c1PwivLaX
         FyNLIkQpGECKQ9PlAadZZHl9To2efPvwsSCn/zr/9/St5YOk7+RL0m/xfj2Q+RUrkADh
         4JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395669; x=1793000469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpPZjaMDJls8EZkE/6oJfht+hbPc5JiwcvTAxpT7o3k=;
        b=tZ9R9/SBbkugje+S+bSnEJ8VVDvjjSspigr0eWcrtwjsOPsLT5gtf7XgeSQjpFR03D
         YfObPtBtLE5bIpi/+IzDCDRP4zD0hhzf2euiQxZlKJjbb7kSbgFakkI+rccTGVBpWinr
         7zCQ8a0HU7ApCQq9hkLAAoNbS+GnF29D+jUmEESXan7M6O6YksUAXXqSy77aGLpQm3hI
         r08F/0aZv9+n1s/6qtfRdm9xvh3P2qQnIcX55KLPtrCIcQFDU9SbnjAFU2EGJGqKTqLU
         dHOF+xv/GSkzI8BzIdjLubPxcaXnMlEr8YPl0pmSMW0S3Hf4mDagD1HtJtT8ORyx60p8
         X0OA==
X-Forwarded-Encrypted: i=1; AKwUvBzzHGtYlWi9is7YO0fdwrj923yTkrKpqys1Yf6LfgKTajECokgNHciHQDmISx4LdbXaMOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTJTLR2ONyGPmRqI4BfVSEQp04b4m5wxFGCTyngHCd04ToHd4/
	9gr+XBmd4M/4qHWNPeHRGigSlJLp2rNMH0kR9+JEJNhhBjWKp9E9gLQFb16thRO0ndPfsyxJf+e
	CVRaxDsMerpyi6LEUa67KtmyV8JWzgow=
X-Gm-Gg: AYBFou0cdA486fpuciLEXXZCLBv5KA70IUSrjhCHc+6sZ6VMQ5QsN2AlvGZEm3YYpFZ
	Vnqkc9ydfxaLC/TMRuXUcoACFKhNcbzYmUzN91yeVhNIRWJGErS3HZTakcu9Fuc3ivauUCVO5za
	cY0MlLEtvc5FB0k9126MsY5VIlOPtyTsxKm0uvQ6zFTwoMIz/Q5P/+0t6rz0j/DYDU/eJPDQX+K
	ZslypqmrXYOL4y+QUNf6CbU5YAczkeucmzdwukPG8Z6hKag5g9VemrxXYCWrD6BYRnKRmrbgROe
	Bnsi1ogcDem8Z88WFbfk9wTCr9ge1DwH/I5YXkgAzWz4SgZM8YaI5VfoRk3EtsKdvyZNVIycwMT
	vJLdMKhrJdg==
X-Received: by 2002:a05:690e:4181:b0:679:938d:a5e1 with SMTP id
 956f58d0204a3-679ca9152camr1672832d50.106.1792395668941; Mon, 19 Oct 2026
 00:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261019064157.29885-1-laoar.shao@gmail.com> <20261019064157.29885-5-laoar.shao@gmail.com>
 <sashiko-outbox-176727@kernel.org>
In-Reply-To: <sashiko-outbox-176727@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 19 Oct 2026 15:40:28 +0800
X-Gm-Features: AclHuK87RnG2er9Q0sMuCWVVDHgxTVssGIXLDngoxhqch9KZMv8DKOFsSe8QrYs
Message-ID: <CALOAHbA9XCM=5AKz=MMCRcx79_E44rBNUZQi_c68tZQ1iYoxhA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 bpf-next 4/5] sched: add BPF-based per-cgroup NUMA
 balancing mode selection
To: sashiko-reviews@lists.linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, gourry@gourry.net, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yu.c.chen@intel.com, zhao1.liu@intel.com, tim.c.chen@linux.intel.com, 
	lizhe.67@bytedance.com, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] mm: use-after-free on source folio in migrate_misplaced_foli=
o()
> --
>
> commit 5de3ed8c82d3030544f5f025b8ae47dd8339bfeb
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> sched: add BPF-based per-cgroup NUMA balancing mode selection
>
> This commit introduces per-cgroup NUMA balancing mode selection managed v=
ia
> the bpf_numab_set_mode() and bpf_numab_get_mode() kfuncs. Hot paths combi=
ne
> requests along the task or folio's memcg cgroup hierarchy behind the
> numab_cgroup_mode_set static key to override the global sysctl setting.
>
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 211c29bd2a283..c0692c7b27467 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
>
> [ ... ]
>
> > @@ -2770,7 +2770,7 @@ int migrate_misplaced_folio(struct folio *folio, =
int node)
> >       if (nr_succeeded) {
> >               count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> >               count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded=
);
> > -             if ((numab_in_tiering_mode())
> > +             if (folio_numab_in_tiering_mode(folio)
> >                   && !node_is_toptier(folio_nid(folio))
> >                   && node_is_toptier(node))
> >                       mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS, nr_su=
cceeded);
>
> [Severity: Critical]
> Has the source folio already been uncharged and freed by the time
> migrate_misplaced_folio() calls folio_numab_in_tiering_mode(folio) here?
>
> Before calling migrate_pages(), migrate_misplaced_folio() snapshots the
> folio's memcg because migration transfers the charge and releases the
> isolation reference on the source folio:
>
> migrate_misplaced_folio()
>   memcg =3D get_mem_cgroup_from_folio(folio);
>   migrate_pages()
>     migrate_pages_batch()
>       migrate_folios_move()
>         migrate_folio_move()
>           move_to_new_folio()
>             folio_migrate_flags()
>               mem_cgroup_migrate()
>                 old->memcg_data =3D 0;
>           migrate_folio_done()
>             folio_put(src);
>
> When nr_succeeded is non-zero, calling folio_numab_in_tiering_mode(folio)=
 ->
> folio_numab_mode(folio) -> folio_memcg(folio) -> folio_objcg(folio) reads
> folio->memcg_data on the freed source folio:
>
> static inline struct obj_cgroup *folio_objcg(const struct folio *folio)
> {
>         unsigned long memcg_data =3D folio->memcg_data;
>
>         VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
>         VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
>
>         return (struct obj_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
> }
>
> If the freed page has not been reallocated yet, folio->memcg_data is 0, s=
o
> folio_memcg(folio) returns NULL and folio_numab_mode(folio) falls back to
> NUMAB_FOLLOW_SYSTEM rather than using the owner cgroup's tiering mode for
> PGPROMOTE_SUCCESS accounting.
>
> If another CPU reallocates the freed page before this check runs (for exa=
mple
> as a slab page setting PG_slab and MEMCG_DATA_OBJEXTS, or as a compound t=
ail
> page), can folio_objcg(folio) trigger VM_BUG_ON_FOLIO() or dereference a
> slabobj_ext pointer as a struct obj_cgroup *?
>
> Would it make sense to evaluate folio_numab_in_tiering_mode(folio) before
> migrate_pages(), or derive the mode from the already-pinned memcg pointer=
?

Nice catch. The check has to run before migrate_pages().

diff --git a/mm/migrate.c b/mm/migrate.c
index 4b87d465c5fd..84f224c42ab2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2761,6 +2761,7 @@ int migrate_misplaced_folio(struct folio *folio, int =
node)
        LIST_HEAD(migratepages);
        struct mem_cgroup *memcg =3D get_mem_cgroup_from_folio(folio);
        struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+       bool folio_tiering =3D folio_numab_in_tiering_mode(folio);

        list_add(&folio->lru, &migratepages);
        nr_remaining =3D migrate_pages(&migratepages, alloc_misplaced_dst_f=
olio,
@@ -2771,7 +2772,7 @@ int migrate_misplaced_folio(struct folio *folio, int =
node)
        if (nr_succeeded) {
                count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
                count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
-               if (folio_numab_in_tiering_mode(folio)
+               if (folio_tiering
                    && !node_is_toptier(folio_nid(folio))
                    && node_is_toptier(node))
                        mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS,
nr_succeeded);


BTW, the folio_nid(folio) next to it has the same problem: after a
successful migration the source folio is uncharged and its isolation
reference dropped, so it may already be back in the allocator, and
a reallocated page's flags give a wrong nid. That one predates this
series (it goes back to e39bb6be9f2b), so I will fix it separately:

diff --git a/mm/migrate.c b/mm/migrate.c
index 15b45832bcfa..685c06a472ea 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2760,6 +2760,7 @@ int migrate_misplaced_folio(struct folio *folio, int =
node)
        LIST_HEAD(migratepages);
        struct mem_cgroup *memcg =3D get_mem_cgroup_from_folio(folio);
        struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+       int src_nid =3D folio_nid(folio);

        list_add(&folio->lru, &migratepages);
        nr_remaining =3D migrate_pages(&migratepages, alloc_misplaced_dst_f=
olio,
@@ -2771,7 +2772,7 @@ int migrate_misplaced_folio(struct folio *folio, int =
node)
                count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
                count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
                if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIE=
RING)
-                   && !node_is_toptier(folio_nid(folio))
+                   && !node_is_toptier(src_node))
                    && node_is_toptier(node))
                        mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS,
nr_succeeded);
        }

Pls correct me if I'm wrong.

--=20
Regards
Yafang
