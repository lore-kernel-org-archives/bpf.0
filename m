Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB783B7760
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075169; cv=none; b=awed1/1uZpVJeGNEd0yC9yHaYQR7F+hTsjwLt/cH5JnSIOQls5yd9aHcndsxZ55pMLvoNgCX4Ey6czdy603suXLtthj//mEBqUstGKcijp1JZxA1axQHgVh8A3UqPNVD+hdRfuLvvHWSSg9vqNaHHAyBVT5JhbIKaMWBRWPfpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075169; c=relaxed/simple;
	bh=v2shKDtstmBcJL5GwbEIXrSThH2cazTsgaEc+auQxWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwSkt/fjcKP3UjSE/qxPRfqywvV+hiKtO5jfHndMcRP0k77xPfbkkmAAg1B7MB9kExLWwRnDd3quvgQXizBGeMud81Iq84exyRUIQtDW27SQuj3aYet7yU/gjFpZnOcYFuNTMWhWP5XUDK87xr/vHAw3NfofpsAZnd7/EGv3qOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy8kaOPC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy8kaOPC"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f0fc82c76so1046959b3a.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776075168; x=1776679968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nWXvz8rZo3Khkxx1y+wE0yFMhUTBnpnArPai1qfvgmc=;
        b=Uy8kaOPCRbhjLW1jpOmIgem63dy02J36erqarI5gAgPWpE56jGAKcGNYHp9a6nLJC2
         yN0GUvsx5Ldc8g8IjvHT8+WAK5eAcyd0m9VxIZNdRiS4KnkIywFTWoV/dgQ1R4Pr9c5J
         TAIESbOFfinH2XrwdKAUIIyRvCiHTbTBmrFwubuu0c9s1tQOfdE/BRkErPjpAT+fDMKI
         G4fYLESbsCIwa7ttOG5rxd22VMh0X7PbS9RNxl+Bq3WDErL4NAd9B5YOVG4hqAMxxaCH
         S6zUVFwUdWYaDYlv8OFdjaFwMIowUOh624lWeAptAsUxqiauvUiXOpWZl5+vczU7mlh8
         9m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776075168; x=1776679968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWXvz8rZo3Khkxx1y+wE0yFMhUTBnpnArPai1qfvgmc=;
        b=QEgJKGz+UcbfpLVxialV2dOWY8bAmPGnAuqGReCzth7SCK1efkPim3ma/ylg64tg82
         bAmMTXP76hFtqa+OiegJ9jKcKo/RAcF8c4rGL+qbdt4HEQxVZ7xkmpgwGelQ5/P7Z9z7
         5YjabuEE0LFbttpcyJ3fXKvCOfZ5QnRjuYDVeIPvDrZW98eXCFam/zy1vVJ6ldkHPMH8
         XBttRpYYCJAp77Cl8RC+dHgJkoz2pjthrHfRbSG1dNEhvjGO5WnLP4/7ddarf5pS39by
         +JIC9dOWB6NHooER3moZDv+7lqDcjPELV+nZ3ywPEptF9nfclDH/sxcCX4HUu2HYk2tH
         2nFw==
X-Forwarded-Encrypted: i=1; AFNElJ8ayzY9eR/YAiVbmaNPGm1515d1U0btDU59RlqDLrQoCrn4CyDy5Dfo42vN7Y0J38XS9FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OY6zIAU4dxTogFmXPqizRB5QwU71cEfx4dF1ksVcBysM/quy
	65RZYK66Ny7kk/nqCpQfcCIYA/NeGeT/8pu/HKh4N0l/w+tAufdHl8+b
X-Gm-Gg: AeBDiet75q2h1eHRCubj5ktcfjaiqGmhx7Sg006HK51dgksH14Zcv20PNBwJD+21SHA
	5qSfQ4Z8Ry9tz6mpm+A9nX+dkXTM9dcknlMxRcOEv5QI6UVInHZ1usCg8ogCeYoGEVfzUB2IjzJ
	H3BQxEiox0UszKXNPdfXzycZEuxKMm3SBEaYewT6V+cXWmG6CwnH8OzzDcfMzncALKWZXdoDqEp
	Asc9IU735VTbVTfVf0BUjR7CpbNo+RasRXe45ZPk5CGi9OQxIUxX8LCw8fcjlde48bxBcdybCvh
	JaVsyGd1ZNbSVPyhcyzjb1mfUZ/sanByYuuiUtn7T+qGZYIhz7eoeJVROKyNWSfOCBmrHFCgssg
	lCIcPY8hQWatm4EraAKhRdE5FeIaKJRgf3iciYfTnWW0iQtJ8VLQcKqQuCPPm9wBibIL/14/BVJ
	a5ZoWNW6q9tbObYKq1YCZZuQTqwzyovADsVNxxOhZggkaZVCHBQ5G/UZUI7/eLK1SW+EcH41Y=
X-Received: by 2002:a05:6a00:4b0b:b0:82c:9c90:58c9 with SMTP id d2e1a72fcca58-82f0c12f435mr12263295b3a.4.1776075167826;
        Mon, 13 Apr 2026 03:12:47 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30e3f8sm11098391b3a.8.2026.04.13.03.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:12:47 -0700 (PDT)
Date: Mon, 13 Apr 2026 18:12:40 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Barret Rhoden <brho@google.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix use-after-free of arena VMA on fork
Message-ID: <adzBmOuXCZ0vHnbg@SLSGDTSWING002>
References: <20260412022714.1955495-2-bestswngs@gmail.com>
 <20260412022714.1955495-3-bestswngs@gmail.com>
 <DHRD7K4Q4R0E.2HT85NT44DKZI@etsalapatis.com>
 <CAADnVQLhnnt8uGoZk=38zH1jh_9Uy8ah=NdcoBE71qGkuH2O5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLhnnt8uGoZk=38zH1jh_9Uy8ah=NdcoBE71qGkuH2O5g@mail.gmail.com>

On 26-04-12 14:30, Alexei Starovoitov wrote:
> On Sun, Apr 12, 2026 at 10:50 AM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> >
> > On Sat Apr 11, 2026 at 10:27 PM EDT, Weiming Shi wrote:
> > > arena_vm_open() only increments a refcount on the shared vma_list entry
> > > but never registers the new VMA or updates the stored vma pointer. When
> > > the original VMA is unmapped while a forked copy still exists,
> > > arena_vm_close() drops the refcount without freeing the vma_list entry.
> > > The entry's vma pointer now refers to a freed vm_area_struct. A
> > > subsequent bpf_arena_free_pages() call iterates vma_list and passes
> > > the dangling pointer to zap_page_range_single(), causing a
> > > use-after-free.
> > >
> > > The bug is reachable by any process with CAP_BPF and CAP_PERFMON that
> > > can create a BPF_MAP_TYPE_ARENA, mmap it, and fork. It triggers
> > > deterministically -- no race condition is involved.
> > >
> > >  BUG: KASAN: slab-use-after-free in zap_page_range_single (mm/memory.c:2234)
> > >  Call Trace:
> > >   <TASK>
> > >   zap_page_range_single+0x101/0x110   mm/memory.c:2234
> > >   zap_pages+0x80/0xf0                 kernel/bpf/arena.c:658
> > >   arena_free_pages+0x67a/0x860        kernel/bpf/arena.c:712
> > >   bpf_prog_test_run_syscall+0x3da     net/bpf/test_run.c:1640
> > >   __sys_bpf+0x1662/0x50b0             kernel/bpf/syscall.c:6267
> > >   __x64_sys_bpf+0x73/0xb0             kernel/bpf/syscall.c:6360
> > >   do_syscall_64+0xf1/0x530            arch/x86/entry/syscall_64.c:63
> > >   entry_SYSCALL_64_after_hwframe+0x77  arch/x86/entry/entry_64.S:130
> > >   </TASK>
> > >
> > > Fix this by tracking each child VMA separately. arena_vm_open() now
> > > clears the inherited vm_private_data and calls remember_vma() to
> > > register a fresh vma_list entry for the new VMA. If remember_vma()
> > > fails due to OOM, vm_private_data stays NULL and arena_vm_close()
> > > skips the cleanup for that VMA. The shared refcount is no longer
> > > needed and is removed.
> > >
> > > Also add arena_vm_may_split() returning -EINVAL to prevent VMA
> > > splitting, so that arena_vm_open() only needs to handle fork and the
> > > vma_list tracking stays simple.
> > >
> > > Fixes: b90d77e5fd78 ("bpf: Fix remap of arena.")
> > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > > ---
> > >  kernel/bpf/arena.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > > index f355cf1c1a16..3462c4463617 100644
> > > --- a/kernel/bpf/arena.c
> > > +++ b/kernel/bpf/arena.c
> > > @@ -317,7 +317,6 @@ static u64 arena_map_mem_usage(const struct bpf_map *map)
> > >  struct vma_list {
> > >       struct vm_area_struct *vma;
> > >       struct list_head head;
> > > -     refcount_t mmap_count;
> > >  };
> > >
> > >  static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
> > > @@ -327,7 +326,6 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
> > >       vml = kmalloc_obj(*vml);
> > >       if (!vml)
> > >               return -ENOMEM;
> > > -     refcount_set(&vml->mmap_count, 1);
> > >       vma->vm_private_data = vml;
> > >       vml->vma = vma;
> > >       list_add(&vml->head, &arena->vma_list);
> > > @@ -336,9 +334,17 @@ static int remember_vma(struct bpf_arena *arena, struct vm_area_struct *vma)
> > >
> > >  static void arena_vm_open(struct vm_area_struct *vma)
> > >  {
> > > -     struct vma_list *vml = vma->vm_private_data;
> > > +     struct bpf_map *map = vma->vm_file->private_data;
> > > +     struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> > >
> > > -     refcount_inc(&vml->mmap_count);
> > > +     /*
> > > +      * vm_private_data points to the parent's vma_list entry after fork.
> > > +      * Clear it and register this VMA separately.
> > > +      */
> > > +     vma->vm_private_data = NULL;
> > > +     guard(mutex)(&arena->lock);
> > > +     /* OOM is silently ignored; arena_vm_close() handles NULL. */
> >
> > I don't see any way this approach gonna work, and frankly makes no sense
> > to me. This patch doesn't take into account how the vma_list is actually
> > used. It frankly makes no sense, Please think through this: If we could
> > silently just not allocate the vml, why do we need it in the first place?
> 
> +1
> 
> Weiming,
> 
> you should stop trusting AI so blindly.
> First, analyze the root cause (the first paragraph of the commit log).
> Is this really the case?
> 
> Second, I copy pasted it to claude and got the same "fix" back,
> but implemented without your bug:
> +       vml = kmalloc_obj(*vml);
> +       if (!vml) {
> +               vma->vm_private_data = NULL;
> +               return;
> +       }
> +       vml->vma = vma;
> +       vma->vm_private_data = vml;
> +       guard(mutex)(&arena->lock);
> +       list_add(&vml->head, &arena->vma_list);
> 
> at least this part is kinda makes sense...
> 
> and, of course, this part too:
> 
> -       if (!refcount_dec_and_test(&vml->mmap_count))
> +       if (!vml)
>                 return;
> 
> when you look at it you MUST ask AI back:
> "Is this buggy?"
> 
> and it will reply:
> "
> Right — silently dropping the VMA from the list means zap_pages()
> won't unmap pages from it, which is a correctness problem, not just
> degraded behavior. Since vm_open can't fail, the allocation should use
> __GFP_NOFAIL. The struct is tiny so that's fine.
> "
> 
> and it proceeded adding __GFP_NOFAIL.
> 
> which is wrong too.
> 
> So please don't just throw broken patches at maintainers.
> Do your homework. Fixing one maybe-bug and introducing
> more real bugs is not a step forward.
> 
> pw-bot: cr

Thanks for the detailed review, really appreciate it.

I traced through it with GDB + KASAN in QEMU. Here's what happens:

  1. mmap → remember_vma()
     vml->vma = 0xffff88800abfe700, mmap_count  = 1
     now Parent VMA = 0xffff88800abfe700
  2. fork → arena_vm_open(child_vma)
     vml->vma = 0xffff88800abfe700 (unchanged), mmap_count  = 2

  3. parent munmap → arena_vm_close(parent_vma)
     mmap_count  = 1
     vml->vma is now dangling

  4. child bpf_arena_free_pages → zap_pages()
     reads vml->vma = 0xffff88800abfe700 → UAF

The core issue is that arena_vm_open() never registers the child
VMA -- it only bumps the mmap_count . So vml->vma always points at
the parent, and dangles once the parent unmaps.

What approach would you suggest for fixing this?
