Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CD360EE9
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138939; cv=pass; b=pMZ0ZeVYL8hKTh0kItF2oU4uQoP9fkHpk82a1Uplu+IwxeVbsXwa2B0bA/bkJk/I+fa3f6mHJ+m4dpJxHq7a/5H3z2/VmszlB+PGAPolp5TxnZFL6Mm1I3m+heJpKaX0Zo0EvFmXILatlGF4Pp7w3LZLRpWHYSCiSa7f6T48Jdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138939; c=relaxed/simple;
	bh=MEK4dbBi9LNZrS9iA83f6kPpj1AAyFV6B8wsJfIBBnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXHjGfklbsgX/DMWbh2Sp7vcMQkMurzZaL3DrcPmRbwZw6egpdoeHYIkLncc9KHYuHwxBFPDjijoJyjiyxqROVo0IFMO4d9fQTtoeFpTQP0xmgmMho8BR3zSHBSfcukYMX71TxH1zmK/exoRAZD4mcDcOEbnT8a0V9fObH2BGtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx09fyDd; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx09fyDd"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b0496f4bbcso849353eaf.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789138937; cv=none;
        d=google.com; s=arc-20260327;
        b=tAbd3ZTkq5pxE/M+/eUBm13I+UhtGewreTmFuEHsY3G0fOqdhRJhWbr6NBxOrRG6ws
         yDfJhSWy/LUpYy/WjaWLRk4EJ/nFopubmynkW2t0p4AyGSmGzeRBv0CJbxbdOBKI7QM9
         NmHwZjuk9ulXidO9K076RgfQJcvMfrYR5ayficwZ2G4yOqHfr3kWkIcichDUqlGukOTA
         gei4tIiP1xV6auTaQvwpopc/WIB9o+sAt2m3Dp2QntBjrlR25QoRG51in9HdtBkMbp4A
         +2aakLtU+qqZ5biV3hxC2G80DcdnU5aEfqvKHoHaUH0sIWb1ahxuyGX5g15Ce7JI4ZIG
         kFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kU1J2grm08AKqhf4AWc7f7svoWRauSaP42vGmuFpDJ4=;
        fh=FL7fnSH9E4sKqTnmNUUWDcupURyMSPb8tAIceZ68Sd4=;
        b=dMq3DqIie3qtOVY8LtWvURp0H+whR70BFWL6lzGmB/a3NpEsfh7fQOsfjVbxkc5dSP
         Y9bj4IqXDY2J2AId98wM60OpNyosk38ieUyjC6+ez8FUvyYUA0RHM/j49xUfvBqDGg4K
         Cgul5armUonk4Fn8rn3wiukIqH6U/Z1/FV3FPcyjTxmQX4ApAWub/fe2F2QUqzYHNVTG
         yRdiqrzSr0AZJF1n995z/4sZ0O5GAaHkI2LuhkILqqRSMNe6tTXA82WX/zG2f9sWF97+
         20s2MbD5SmQNUGei8AlvzlugpofdX+/wdbXoPcYT0T/HI32uRf27jiDlExJ13WjbeF2l
         a/7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138937; x=1789743737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kU1J2grm08AKqhf4AWc7f7svoWRauSaP42vGmuFpDJ4=;
        b=Zx09fyDdX0p/uj3KpPE8hB4arr2LzoFILq2moeshSY+kFnRYq8yVbAYpWmPBYSyAdA
         8IrBWYJIHRNW0khF8xdm0lp7zEFmbmTBeuHcUU08q5/wB65lHZTYCuNLr8UM0I9dfK6i
         VVEqglzlqY4jYI8dFBMnC3gwvQuOlGsf72KtqG/UcuEPwaNFONMY4V+IGj2Cm7ddoJa4
         2Kv6jbt1jSFoDqwLtYJuZRXtn4MQJEQyVsW/MsZ0XSk+8iS5jW47zCEjaiG4SApEgoa3
         rpw3letwtrvQqG6ELGrkaA1DIld9xW6JhwymxKnmjI/UyiedjGrLclLzo8TffwMRRBj1
         fLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138937; x=1789743737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kU1J2grm08AKqhf4AWc7f7svoWRauSaP42vGmuFpDJ4=;
        b=MQCtxGiC9/W2faKktpJPHzw9YAPi/hqTKCth0h5tihikCEEU0QU1Kg+KrMhJbt19Ic
         vLGTzW+lln+72xu1tD3iJIuE3wxYmzp8d10lUIIZlDPjtH1xIfdGoA96O0t3/vw1b7cR
         HL4vsMq3axVcdh1/k2ED4X74LZa5/hEzY+LHJTXRl2ke3z/50EAD9WYXePQsUlI457hu
         0RlPQFipCmijA8/VeWf9tuoyLXbH4jyCkh5kVg6duA5R/+FmFN5xTTOHzGxBYwBMFxjM
         R3cXeA8KkMHWjr0M4yngv/JbczzGnIFOeYMJDNe9DbbuNFONJvh9U6uAzO8YTFuJx5Z/
         jiYA==
X-Gm-Message-State: AFuF++lN/nFu25Ua++UruPaWYo/trHEs7p5OTg9vrImvOMn6F7VPYiZH
	8xh9g9H/brmjGyninSSaezYeKx6V6Gh+ta8OLIxh+qTM5vmhb0DCPLDKVAQz53nWOh8t/6iNTWY
	ovQt31B7lVZTT67g05vrYv/X1pknZX0U=
X-Gm-Gg: AYBFou1Us974nGIi3MlA8FNTuZHNlcU50DWfLV6EOOLBd5iU4TRnHhr9HW4SqU9qRgm
	F6GQSIGGLzg0BxaSkLN4sZH3lbmhN8RH2FUg+0In29XaXsN3IOURvpM4lmTYuMvFzGTJDlNEiz8
	UePORiXRaJo6FUlmrqzur5qFDndDtEXwQ5NReuOPgUSBEq/cV6uVHKz2KCZ0NPWGTaBoRq6rbp+
	ybT+zBBsbFiiZQ64X/csPRy8ctoZS7qS+p8VLULYFf2YNJa0g7+L1rkH9ZHMod13Dzmg7Pur7Nf
	gdjK4lZQ4ACslhZwOldQTr4ncNZFO4akPFySNlXiQ6sYAc14uyzz6WqIQOJzxumvkj4F8X3Avpt
	LVq8KVhFz+HE=
X-Received: by 2002:a05:6820:570b:20b0:6be:2c0f:e41a with SMTP id
 006d021491bc7-6c0bab11e27mr2335373eaf.23.1789138936398; Fri, 11 Sep 2026
 08:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxQDVrOwfhz8B_ijEzTqFj7CG7TLQacALd1Odv2Tyc3x21Z-g@mail.gmail.com>
 <1ccc1901-f171-e44b-835f-1e9482956183@huaweicloud.com>
In-Reply-To: <1ccc1901-f171-e44b-835f-1e9482956183@huaweicloud.com>
From: musthaq ahamed <amusthaq56@gmail.com>
Date: Fri, 11 Sep 2026 20:32:05 +0530
X-Gm-Features: AcwNN1WBVaSA_u5n-IsrOXaLLRxnUJ1_iWENmjorJPKRAoDYtqImikcylvSgYg8
Message-ID: <CADxQDVrzs7+Jy+Jvf+f43cF2juCJzVxfVpheeYV6McGGrLKHsg@mail.gmail.com>
Subject: Re: bpf: BPF_MAP_UPDATE_BATCH into a fresh NO_PREALLOC LPM trie /
 hash map returns -ENOMEM at element 2 on AWS Graviton5 (bpf_mem_alloc refill
 IPI races the syscall)
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hou,

Thanks for looking at this and for the patch.

> Do you know why is the IPI asynchronous ? Will it be fixed ?

I can only describe what is observable from the guest. On Graviton5
the ICC_SGI1R_EL1 write in arch_irq_work_raise() returns in ~170 ns
and the IRQ-work interrupt is delivered ~700 ns later; on Graviton3
(m7g) the same write takes ~1.5 us and the interrupt is already
pending when the guest resumes, so the refill runs inside
unit_alloc()'s local_irq_restore(). Whether the write traps cannot be
decided from inside the guest; Graviton5 runs AWS's newer hypervisor
stack, so the cheap asynchronous self-IPI is most likely a property of
that platform rather than something a guest kernel can change. There
is also host-to-host variation: one m9gd host in ~8 delivers the IPI
~250 ns sooner and fails only on a subset of CPUs. AWS is following
the report at
https://github.com/amazonlinux/amazon-linux-2023/issues/1129; I have
pointed them at your question.

> it only handles the syscall path. Why if the bpf update helper is
> invoked from a bpf program ?

Agreed, the RFC covered the syscall path only, deliberately, since a
program-context caller cannot safely enter slab. Your approach of
waiting for the raised irq_work covers both and fits the measurements:
the wait would be ~700 ns on Graviton5 and effectively zero on
Graviton3.

On testing: we do not build or run custom kernels here, so I cannot
test the patch myself. Amazon Linux has said they will look at the
reproducer and the issue above; they would be the natural place to try
your patch on the affected hardware, and I have asked them to. The
reproducer in the report gives a quick before/after (99-100 % failure
today; the same hardware on 6.12 passes 0/6400).

Thanks,
Musthaq Ahamed

On Fri, 11 Sept 2026 at 12:24, Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 9/8/2026 6:59 PM, musthaq ahamed wrote:
> > Hi,
> >
> > Bug report with a reproducer and an untested RFC patch. Amazon Linux
> > asked me to raise it here
> > (https://github.com/amazonlinux/amazon-linux-2023/issues/1129).
> >
> > Symptom
> > -------
> > On AWS EC2 generation-9 instances (Graviton5, Neoverse-V3: m9g, m9gd,
> > c9g) running Amazon Linux 2023 kernel 6.18.41 (arm64, PREEMPT_NONE,
> > HZ=3D100), a single bpf(BPF_MAP_UPDATE_BATCH) of 7 elements into a fres=
hly
> > created BPF_MAP_TYPE_LPM_TRIE (key_size 260, value_size 8, max_entries
> > 128, BPF_F_NO_PREALLOC) returns -1/ENOMEM with batch.count written back
> > as 1. The node has >100 GB free, memcg limits are unset, nothing in
> > dmesg. It fails on 99-100 % of attempts on every CPU of every such
> > instance we launched (8 instances, spot and on-demand, 3 AZs), and one
> > host in ~8 fails only on a subset of CPUs.
> >
> > The same call passes 100 % on Graviton3/4 (m7g, m8g, c7g, c8g) with the
> > same kernel image, and 100 % on Graviton5 with kernel 6.12.100. A
> > BPF_MAP_TYPE_HASH with the same key/value/flags fails identically on
> > Graviton5 on BOTH 6.18.41 and 6.12.100 and passes on Graviton3. Seven
> > single BPF_MAP_UPDATE_ELEM calls, a batch of 1, or elements <=3D 256 by=
tes
> > never fail.
> >
> > Analysis
> > --------
> > kernel/bpf/memalloc.c: for unit_size > 256 prefill_mem_cache() seeds ON=
E
> > object per CPU; the per-CPU free list is refilled only from
> > bpf_mem_refill() in an irq_work raised through a self-IPI when
> > unit_alloc() sees the list below its low watermark. unit_alloc() has no
> > fallback: an empty list returns NULL and trie_update_elem() /
> > alloc_htab_elem() return -ENOMEM. generic_map_update_batch() stops at t=
he
> > first error and writes back the count.
> >
> > Since 3d8dc43eb2a3 ("bpf: Switch to bpf mem allocator for LPM trie") th=
e
> > trie leaf (296 bytes for a 260-byte key) comes from this allocator.
> > Element 1 of the batch consumes the prefilled object and raises the
> > IPI; element 2 runs a few hundred ns later in the same syscall.
> >
> > bpftrace on the failing hosts: arch_irq_work_raise() takes ~170 ns on
> > Graviton5 and the IRQ-work interrupt lands ~715 ns after the raise,
> > after element 2 has already failed; bpf_mem_refill() then runs exactly
> > once per failed batch. On Graviton3 the same raise takes ~1.5 us (the
> > SGI write exits to the hypervisor) and the interrupt is pending when
> > the guest resumes, so the refill runs inside element 1's
> > local_irq_restore() and element 2 succeeds. IRQ-work IPI counters
> > advance on both, so no IPI is lost; the refill is late, not missing.
>
> Thanks for the analysis. To summarize the problem: on Graviton5 the
> raise of irq_worker is fast, but the running of irq worker is slow due
> to async IPI. Do you know why is the IPI asynchronous ? Will it be fixed
> ?  The similar refill problem also exists for PREEMPT_RT, because the
> irq_work is running in a per-cpu kthread. In my understanding, bpf mem
> will be replaced by kmalloc no_lock variants and the problem will be
> solved eventually although I don't know the exact time.
> > Interrupts are enabled for almost the whole path between the two
> > inserts (bpf_map_update_value() uses migrate_disable(), not IRQ-off), s=
o
> > this is a latency race the batch loses on a platform with a cheap
> > asynchronous self-IPI. Kernel 6.12 is immune for LPM tries only because
> > its trie still uses bpf_map_kmalloc_node() directly; NO_PREALLOC hash
> > maps have taken >256-byte elements from bpf_mem_alloc since 6.1 and
> > fail there too.
> >
> > I believe this is the same class as the Feb-2025 thread "bpf: Add a
> > retry after refilling the free list when unit_alloc() fails".
> >
> > Reproducer
> > ----------
> > Raw bpf(2) via Python ctypes, fresh map per iteration, one CPU pinned
> > per loop; inline in the GitHub issue above. Results (100 iterations x
> > 32 CPUs):
> >
> >   variant                                  m9gd 6.18.41  m7g 6.18.41
> > m9gd 6.12.100
> >   LPM key260 batch x7                      3192/3200     0/3200       0=
/3200
> >   HASH key260 NO_PREALLOC batch x7         3117/3200     0/3200       3=
183/3200
> >   LPM 7 x UPDATE_ELEM                      0/3200        0/3200       0=
/3200
> >   LPM batch x1                             0/3200        0/3200       0=
/3200
> >   HASH key8 batch x7                       0/3200        0/3200       0=
/3200
> >
> > RFC patch (untested)
> > --------------------
> > Attached to the GitHub issue: on the bpf(2) syscall path,
> > bpf_map_update_value() pushes a run context so map implementations can
> > recognise "syscall, no program running"; trie_update_elem() and
> > htab_map_update_elem() then call a new bpf_mem_cache_reserve(ma, cnt)
> > BEFORE taking the map lock, which tops up this CPU's free list with
> > GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT objects charged to the map's
> > memcg (the same allocation the irq_work refill does). Nothing changes
> > for BPF programs and nothing allocates under trie->lock or a bucket
> > lock. I have not built or booted it; I am reporting rather than
> > submitting. Happy to test a fix on the affected hardware.
>
> Have checked the patch in github link and paste it below:
>
> > >From 99356e7bc9b90770fb0eeb1d216a47aa71f029fa Mon Sep 17 00:00:00 2001
> > From: Musthaq Ahamed <redacted>
> > Date: Mon, 7 Sep 2026 18:15:34 +0530
> > Subject: [PATCH 1/2] bpf: Refill bpf_mem_alloc synchronously for map up=
dates
> >  from syscall
> >
> > A BPF_MAP_UPDATE_BATCH of 7 elements into a fresh BPF_F_NO_PREALLOC LPM
> > trie (key_size 260, value_size 8, max_entries 128) fails with -ENOMEM a=
t
> > the second element on AWS Graviton5 instances, with more than 100 GB of
> > memory free:
> >
> >   bpf(BPF_MAP_UPDATE_BATCH, {batch=3D{keys=3D..., values=3D..., count=
=3D7,
> >       map_fd=3D3, elem_flags=3DBPF_ANY}}, 56) =3D -1 ENOMEM
> >   batch.count written back =3D 1, one element in the map
> >
> >
> > +
> > +/* True while the current task updates a map on behalf of the bpf(2)
> > syscall
> > + * and no BPF program is running: task context, and the innermost run
> > context
> > + * is the one pushed by bpf_map_update_value(). A program nested insid=
e the
> > + * syscall (fentry, raw tracepoint) pushes its own run context, and
> > interrupt
> > + * or NMI context fails in_task().
> > + */
> > +static inline bool bpf_map_update_from_syscall(void)
> > +{
> > +    return in_task() && current->bpf_ctx =3D=3D &bpf_map_update_run_ct=
x;
> > +}
> > +
> SNIP
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 7f8e029..014f72e 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1134,6 +1134,9 @@ static long htab_map_update_elem(struct bpf_map
> > *map, void *key, void *value,
> >           */
> >      }
> >
> > +    if (!htab_is_prealloc(htab) && bpf_map_update_from_syscall())
> > +        bpf_mem_cache_reserve(&htab->ma, 1);
> > +
> >      ret =3D htab_lock_bucket(b, &flags);
> >      if (ret)
> >          return ret;
> > @@ -1287,6 +1290,12 @@ static long htab_map_update_elem_in_place(struct
> > bpf_map *map, void *key,
> >      b =3D __select_bucket(htab, hash);
> >      head =3D &b->head;
> >
> > +    if (!htab_is_prealloc(htab) && bpf_map_update_from_syscall()) {
> > +        bpf_mem_cache_reserve(&htab->ma, 1);
> > +        if (percpu)
> > +            bpf_mem_cache_reserve(&htab->pcpu_ma, 1);
> > +    }
> > +
> >      ret =3D htab_lock_bucket(b, &flags);
> >      if (ret)
> >          return ret;
> > diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> > index b051806..fdd5b08 100644
> > --- a/kernel/bpf/lpm_trie.c
> > +++ b/kernel/bpf/lpm_trie.c
> > @@ -338,6 +338,10 @@ static long trie_update_elem(struct bpf_map *map,
> >      if (key->prefixlen > trie->max_prefixlen)
> >          return -EINVAL;
> >
> > +    /* The update may need a leaf and an intermediate node */
> > +    if (bpf_map_update_from_syscall())
> > +        bpf_mem_cache_reserve(&trie->ma, 2);
> > +
>
> You ensure __alloc() is invoked under syscall to prevent the possible
> dead-lock caused by locks in mm subsystem, but it only handles the
> syscall path. Why if the bpf update helper is invoked from a bpf program =
?
>
> How about invoking irq_work_sync() when an irq_work has been queued ? so
> when unit_alloc returns the refill must have been done.
>
> =EF=BB=BFFrom 179bf9721f26842630ed9ef5a38c914b0dde79ca Mon Sep 17 00:00:0=
0 2001
> From: Hou Tao <houtao1@huawei.com>
> Date: Fri, 11 Sep 2026 14:47:40 +0800
> Subject: [PATCH] bpf: Wait for asynchrous IPI
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/memalloc.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index bc9b4b3d9c3a..44cc8ec0a338 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -446,9 +446,20 @@ static void bpf_mem_refill(struct irq_work *work)
>      check_free_by_rcu(c);
>  }
>
> -static void notrace irq_work_raise(struct bpf_mem_cache *c)
> +static bool notrace irq_work_raise(struct bpf_mem_cache *c)
>  {
> -    irq_work_queue(&c->refill_work);
> +    return irq_work_queue(&c->refill_work);
> +}
> +
> +static void notrace irq_work_wait(struct bpf_mem_cache *c)
> +{
> +    /* FIXME: the wait might sleep */
> +    if (IS_ENABLED(CONFIG_PREEMPT_RT) || !arch_irq_work_has_interrupt())
> +        return;
> +
> +    /* Wait for asynchronous IPI if any */
> +    while (irq_work_is_busy(&c->refill_work))
> +        cpu_relax();
>  }
>
>  /* For typical bpf map case that uses bpf_mem_cache_alloc and single buc=
ket
> @@ -795,6 +806,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache =
*c)
>  {
>      struct llist_node *llnode =3D NULL;
>      unsigned long flags;
> +    bool wait =3D false;
>      int cnt =3D 0;
>
>      /* Disable irqs to prevent the following race for majority of prog
> types:
> @@ -820,13 +832,17 @@ static void notrace *unit_alloc(struct
> bpf_mem_cache *c)
>      WARN_ON(cnt < 0);
>
>      if (cnt < c->low_watermark)
> -        irq_work_raise(c);
> +        wait =3D irq_work_raise(c);
> +
>      /* Enable IRQ after the enqueue of irq work completes, so irq work
>       * will run after IRQ is enabled and free_llist may be refilled by
>       * irq work before other task preempts current task.
>       */
>      local_irq_restore(flags);
>
> +    if (wait)
> +        irq_work_wait(c);
> +
>      return llnode;
>  }
>
> @@ -838,6 +854,7 @@ static void notrace unit_free(struct bpf_mem_cache
> *c, void *ptr)
>  {
>      struct llist_node *llnode =3D ptr - LLIST_NODE_SZ;
>      unsigned long flags;
> +    bool wait =3D false;
>      int cnt =3D 0;
>
>      BUILD_BUG_ON(LLIST_NODE_SZ > 8);
> @@ -865,19 +882,23 @@ static void notrace unit_free(struct bpf_mem_cache
> *c, void *ptr)
>
>      if (cnt > c->high_watermark)
>          /* free few objects from current cpu into global kmalloc pool */
> -        irq_work_raise(c);
> +        wait =3D irq_work_raise(c);
>      /* Enable IRQ after irq_work_raise() completes, otherwise when curre=
nt
>       * task is preempted by task which does unit_alloc(), unit_alloc() m=
ay
>       * return NULL unexpectedly because irq work is already pending but =
can
>       * not been triggered and free_llist can not be refilled timely.
>       */
>      local_irq_restore(flags);
> +
> +    if (wait)
> +        irq_work_wait(c);
>  }
>
>  static void notrace unit_free_rcu(struct bpf_mem_cache *c, void *ptr)
>  {
>      struct llist_node *llnode =3D ptr - LLIST_NODE_SZ;
>      unsigned long flags;
> +    bool wait =3D false;
>
>      c->tgt =3D *(struct bpf_mem_cache **)llnode;
>
> @@ -891,8 +912,11 @@ static void notrace unit_free_rcu(struct
> bpf_mem_cache *c, void *ptr)
>      local_dec(&c->active);
>
>      if (!atomic_read(&c->call_rcu_in_progress))
> -        irq_work_raise(c);
> +        wait =3D irq_work_raise(c);
>      local_irq_restore(flags);
> +
> +    if (wait)
> +        irq_work_wait(c);
>  }
>
>  /* Called from BPF program or from sys_bpf syscall.
> --
> 2.29.2
>
>
> >      /* Allocate and fill a new node */
> >      new_node =3D lpm_trie_node_alloc(trie, value);
> >      if (!new_node)
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index bd45dda..8e48c9a 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -1005,6 +1005,45 @@ void notrace *bpf_mem_cache_alloc_flags(struct
> > bpf_mem_alloc *ma, gfp_t flags)
> >      return !ret ? NULL : ret + LLIST_NODE_SZ;
> >  }
> >
> > +/* Make sure the free list of this CPU holds at least @cnt objects.
> > + *
> > + * The refill done by unit_alloc() is an irq_work raised through a sel=
f-IPI
> > + * and is asynchronous. A batch of map updates from user space can fin=
d the
> > + * free list still empty at its second element and fail with -ENOMEM.
> > + *
> > + * Only for the bpf(2) syscall map update path: task context, IRQs ena=
bled,
> > + * no map lock held, so a non-sleeping slab allocation is safe.
> > + */
> > +void bpf_mem_cache_reserve(struct bpf_mem_alloc *ma, int cnt)
> > +{
> > +    struct bpf_mem_cache *c =3D this_cpu_ptr(ma->cache);
> > +    struct mem_cgroup *memcg, *old_memcg;
> > +    void *obj;
> > +    int i;
> > +
> > +    if (WARN_ON_ONCE(!bpf_map_update_from_syscall()))
> > +        return;
> > +    lockdep_assert_irqs_enabled();
> > +
> > +    /* Racy read like in bpf_mem_refill(), it doesn't need to be
> > accurate */
> > +    i =3D READ_ONCE(c->free_cnt);
> > +    if (i >=3D cnt)
> > +        return;
> > +
> > +    memcg =3D get_memcg(c);
> > +    old_memcg =3D set_active_memcg(memcg);
> > +    for (; i < cnt; i++) {
> > +        obj =3D __alloc(c, NUMA_NO_NODE, GFP_NOWAIT | __GFP_NOWARN |
> > __GFP_ACCOUNT);
> > +        if (!obj)
> > +            break;
> > +        /* unit_free() reads the owning cache from the object header *=
/
> > +        *(struct bpf_mem_cache **)obj =3D c;
> > +        unit_free(c, obj + LLIST_NODE_SZ);
> > +    }
> > +    set_active_memcg(old_memcg);
> > +    mem_cgroup_put(memcg);
> > +}
> > +
> >  int bpf_mem_alloc_check_size(bool percpu, size_t size)
> >  {
> >      /* The size of percpu allocation doesn't have LLIST_NODE_SZ overhe=
ad */
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index e92fd2b..c20e5de 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -56,6 +56,8 @@
> >  #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
> >
> >  DEFINE_PER_CPU(int, bpf_prog_active);
> > +/* Marks map updates done on behalf of the syscall, only its address i=
s
> > used */
> > +struct bpf_run_ctx bpf_map_update_run_ctx;
> >  DEFINE_COOKIE(bpf_map_cookie);
> >  static DEFINE_IDR(prog_idr);
> >  static DEFINE_SPINLOCK(prog_idr_lock);
> > @@ -247,6 +249,7 @@ unpin_all:
> >  static int bpf_map_update_value(struct bpf_map *map, struct file *map_=
file,
> >                  void *key, void *value, __u64 flags)
> >  {
> > +    struct bpf_run_ctx *old_run_ctx;
> >      int err;
> >
> >      /* Need to create a kthread, thus must support schedule */
> > @@ -265,6 +268,7 @@ static int bpf_map_update_value(struct bpf_map *map=
,
> > struct file *map_file,
> >      }
> >
> >      bpf_disable_instrumentation();
> > +    old_run_ctx =3D bpf_set_run_ctx(&bpf_map_update_run_ctx);
> >      if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> >          map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH) {
> >          err =3D bpf_percpu_hash_update(map, key, value, flags);
> > @@ -297,6 +301,7 @@ static int bpf_map_update_value(struct bpf_map *map=
,
> > struct file *map_file,
> >                  bpf_obj_unpin_uptrs(map->record, value);
> >          }
> >      }
> > +    bpf_reset_run_ctx(old_run_ctx);
> >      bpf_enable_instrumentation();
> >
> >      return err;
> >
> > Real-world impact: an eBPF egress agent for CI runners makes exactly
> > this call per pod; on these hosts every pod loses DNS.
> >
> > Thanks,
> > Musthaq Ahamed
> > .
>
