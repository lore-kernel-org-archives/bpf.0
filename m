Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7E49E12A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146377; cv=pass; b=sH5bRMAP0EYthB3FJFcMptCWE8r8C67aLis8QS3hCHDI6wg0r4QcCgJI7n+6VFHS0yHL6DSLF9hUnUQjdEbaAWONdkguAGbBHpW7notPjfXdkrA/SzoggJ6fz2PxOcikHGi9yFIA4cwE2rgWQds52iBAZKLw2fm0eipo1YF+YsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146377; c=relaxed/simple;
	bh=x1V3fY/lIWkkBiM8gc5vqoQ2P7rsbl7ymjJGJstqNrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAHnhYE1ggpTWNJNWnRjsmhKib094ylSS5R8onKTL4mapk6LQD4csJq/7uuWalL2FX0mVWgJ+RmGEsz4oBNg7G/KFyrz1lgqcaq771FTjkby6oeI2ZnKTg99omYQpuMtbttxfZvOcdqLkfL+7fszV1BovIZ5YSOFRP3iVn3cSS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnvU08lz; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnvU08lz"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6c20a9c464fso73830eaf.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789146372; cv=none;
        d=google.com; s=arc-20260327;
        b=HCK2psOGYlYRqCuNTuy6jLS4Ix7sjD01qkSJSi6graVM4cjukxT9WeCjmS4twI2ghC
         ZzsChs0TQ8L/EuVSNa3ATPaCLKrEYXj7NtvExfwIJZaF6NidpJyOTiA4TSlYpRHTuoMz
         t+FIBwv6ayRdBxu0MT13c/QV/HtHJibv5eq69uSieabWbUxA7nB0K3WCi9UCKYpye9/R
         40MsVFqks1WOoTRqjWmhracDIE4fW9VtHs6usIDc6JvEj95hvgRGlkHs+W57XBZIqGKS
         lyhqV10ylJRpL4M6izaI+2S32uq04g8r6yl2LnXzajBlYtGJWrw7Ztgdp6oNXku0psll
         FPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4UZ/ObYeDbXWjAqiG8g4A5F6usmhmu9cRUmKgLmY//A=;
        fh=FL7fnSH9E4sKqTnmNUUWDcupURyMSPb8tAIceZ68Sd4=;
        b=IQorDl3qRNQZuE7wi/knYr9xPF3q3ZN3cTJqixwseJNF5yT7UK5qetvMUIMa9bfBV0
         3wBehpIMEVTyeleszL3ZK1wjC7jl89w1kHQ6QNraoz5u21Qers6ecMeZi5arDse+3L3w
         tnBcYM0ioLxn22+hhgQ4hAxMDSQ4wh3odVk3ydXSLPSbv0IaYNByQfH3RDkU6BD6CjM+
         pfvHzah07Dj0vW+lubOM9tHCCxtGgZNI+DiurCY5Fp5lsaZy33xVIrMrlp1TFRZOrL+4
         00DqCk4jQ1sCKbpWP3cQQAgez0mPlWyYxfXSGIznLR7hEFgGVZY+JNDuROqfXLl29E3G
         WZOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789146372; x=1789751172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4UZ/ObYeDbXWjAqiG8g4A5F6usmhmu9cRUmKgLmY//A=;
        b=EnvU08lzw0oSPhe5YHSFbrPd2U57N8e/R0Q5A0J+RUzgoSd+AzRDbo830s4PaA2jL+
         L1zLNVl0P7ShFjoOeGx88xXIkOkUFe/czsFzcJRhLVysMf6Vm4b9oqE8H218XLthP7BO
         FTNNku2J2PHCn2HsuHVd9jwSAgxp56AdWeFc0+84DFh6kHahFk35hrbEPMDcTvF0cydR
         g8wE+DIggX3L50PMs3wUF//iB37JP+TcvKauzZYa2x5+jybc/v9OndrTSKVAXMWK2d+J
         zqp62xLN+I/pXi/KscRd4QbjPtHxjduna4UZgWLmd+fZ2VO9YS+oBokIvH1w0qTKGgsP
         ayhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789146372; x=1789751172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UZ/ObYeDbXWjAqiG8g4A5F6usmhmu9cRUmKgLmY//A=;
        b=aijyhi/BfsoS7jPoGYBtdxnQ0FwO3kP3lYbUsENOQ3XClQ5TxkCErfgf5Qo1Vgl2yd
         0D9he+V+BWhZUvjR/EI40jDG09D6u742wezxQz1NWrEJ7UzsBe/tZD8y/mwyEyQloNL9
         dCjO4JxYJ3K6VxA5I6LWTLeAWUTHye5IhDhfB6Sqcovd/jL2SRRxx6cJ9XJo6pke9Hhr
         gma/i3MLBDBI0Pe1CkStsSfyaX+j4P8YVEU07XwP/yeo7L1fvMctPrWqYtHzqQddqjKQ
         7GCSh6oE3chJ9n6/YSIZw5X5UYh+Ig8NOhqMFQebhr2fw0myvvQEkiA+H1ih0tDDfCyR
         ZPdQ==
X-Gm-Message-State: AFuF++kzMKVMkxIcFi9IHHGGZsC59no1g3HSN9tlvWdcKNw6RkRHC/0R
	Gx+Bg/sB83pKiRnF+fbYSmjRXoKIKcGkxGd7WPyxYhCr15Ysjj6hhhFtlSgbuOgJlydYxg/YZLq
	B1ggyF8uiWuCELwjJ5GKwaofsBlfHwV8=
X-Gm-Gg: AYBFou3RoCImgelQ+6lYKhJc+FBExMpK9kCoJ+Z99MuM/pb04y1bmVYTD+kuRceaGl3
	UrppIBOM4eBEbpgEBMpZptkl+kGxUCr0frYxfdZ9xj9REVKabzQkke5KxXmdKb29Y3kLU67fTL4
	pBftBmkiao4/m8Y6NqE1cduLJ6wES/A+BiBESaf12BWwnqsrC/r12H/Sgcd9KQYz9hpSIw57Yl2
	op9XIYtmVGE75xxiOFmNmuorhc7qcykHoB0uAuML2uq0M1bgRNcyx771P/y2LvGf2LecOnLb50y
	07luPfmfqMcEQqut/EqjawlIxSTptQj+yqswuTIQSjCP70rc493FjIviRD5/xZO/wCSSYX5untc
	KY8GFIVtGhAo=
X-Received: by 2002:a05:6820:7083:10b0:6b7:83c5:fe00 with SMTP id
 006d021491bc7-6c0bceaabe2mr3089405eaf.65.1789146371851; Fri, 11 Sep 2026
 10:06:11 -0700 (PDT)
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
Date: Fri, 11 Sep 2026 22:35:59 +0530
X-Gm-Features: AcwNN1XiLw0XPGUWtp-mpl_jOJBSCUSEU4j1wkx7_0Al1-XbcOHgKfE4V1uhn-g
Message-ID: <CADxQDVouw3oZQMWMm0V1OcFJD9w4H34WNc=TNiNO9+Ry0_SEwg@mail.gmail.com>
Subject: Re: bpf: BPF_MAP_UPDATE_BATCH into a fresh NO_PREALLOC LPM trie /
 hash map returns -ENOMEM at element 2 on AWS Graviton5 (bpf_mem_alloc refill
 IPI races the syscall)
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hou,

A correction to my previous mail, after re-testing more carefully.

I rebuilt the same tree twice on a fresh instance of the same type
(m9gd.8xlarge, 32 vCPU, 6.18.41): once unpatched as a control, once
with your patch plus two debugging changes in irq_work_wait(): a
pr_warn_once() + dump_stack() if it is entered with IRQs disabled, and
a bound on the spin (2^24 iterations, then warn + dump_stack + return).
Both booted with irqchip.gicv3_pseudo_nmi=3D1 and sat idle for several
minutes before anything was run.

Results, 30 iterations x 32 CPUs =3D 960 fresh (map, cpu) pairs per case,
failures counted:

  case                                              control   patched
  LPM_TRIE key 260 NO_PREALLOC, 7-key batch         927/960   0/960
    (same, 100 iterations)                              -      0/3200
  LPM_TRIE key 260 NO_PREALLOC, 7 agent-shaped keys 940/960   0/960
  HASH key 260 NO_PREALLOC, 7-key batch             927/960   0/960

Control failures are all ENOMEM on the second element, as before. So
your patch does fix the LPM trie case, and it never warned there: the
only raise on that path is the leaf-node allocation with IRQs enabled,
the IPI lands, and the refill covers the rest of the batch.

The HASH case is where the problem is. On the first element the wait is
entered with IRQs disabled:

  bpf_mem_alloc: irq_work_wait entered with IRQs disabled
(in_interrupt=3D0 preempt_count=3D0)
  irq_work_wait
  unit_alloc
  bpf_mem_cache_alloc
  alloc_htab_elem
  htab_map_update_elem
  bpf_map_update_value
  generic_map_update_batch
  bpf_map_do_batch
  __sys_bpf

alloc_htab_elem() runs under htab_lock_bucket(), i.e.
raw_res_spin_lock_irqsave(), so local_irq_restore(flags) in unit_alloc()
leaves IRQs masked and the self-IPI cannot be delivered. In the bounded
build all 960 hash waits spun the full 2^24 iterations (~30 ms each) and
gave up; the allocation then succeeded only because the bucket lock was
released afterwards and the IPI got in. With the patch as posted that
spin never ends. With the bound in place there were no RCU stalls and
no hung tasks.

Two statements in my previous mail were wrong and I retract them. The
machine did hang with the patch as posted, but our command log shows
the reproducer had not started when the stall began (the command was
never acknowledged), so I cannot attribute that hang to the LPM batch,
and the LPM variant does not hang. I do not know what triggered the
first hang; possibly some other NO_PREALLOC hash user on the box hit
the same path. Sorry for the noise.

So: the wait needs to be skipped or bounded when the caller's saved
flags had IRQs disabled (or in hardirq/NMI), and the under-lock
allocation sites (hash elements, LPM intermediate nodes) still need
something else, such as reserving before taking the lock.

Happy to test a v2.

Thanks,
Musthaq

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
