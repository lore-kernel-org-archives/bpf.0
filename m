Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CD3AA1AE
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142792; cv=pass; b=P7K0ryIXFdTtWo8HGu+nBzMMR6SfBJi3rQsEXWjJJ1YB0GNGGPI4pwPr0bYijFzVqqniDbRxj4XnAn1JOxM6C1RxFV7Vet6cW5XF+gHITzIi7snUFCQPSIp94lq4u6a5pNfsYHbp1zzQnjofwYMKAjA0PsAvqnx//ldpFlHR65k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142792; c=relaxed/simple;
	bh=0rFxGN85if+etJ0rZPHxF5re19ffMZ9EsoIzf8Q7dXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoLrLMa8yhyRMhvHF3b+RGVX0ApDqlJwWKE02a8+ceM661zWpNTln4n8mlaNZDNvmptB2sw2qF5U1XCFs/yOR6D1FKfD6WWynKDFkdo3zalNZ3VsRD2EaWTznmB+kzpM/8xkFFLQpriMABYnRLgg/G/PB/dGWXQyk9gFxVHYvhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaINVVIS; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaINVVIS"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb61bbeb25so1312322a34.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789142788; cv=none;
        d=google.com; s=arc-20260327;
        b=iFv/BR21LNVn9y1C+gYlonyQK2gjHHDZZxQKN5Z8fE1FVy76JwP/6NyKHlwhU4V4sx
         r3nGKSGRfVsb2I8frJWyA5c+AHB4iCMOKw4Zz1wi80x0SnTyX+yZpry2YlPR973dSO+J
         8vKm8o7QxIBaAelDZbQ7laAj5KMoneP2y/N2wwEID3sRhxaiRJ2OQ/5J6lL6H0iqrajG
         S/kekz29RtUiJx/CxWzqbgbvZ8b8fDjgLY2XDPDL0cF0XN9VUrWaAzF4iK8oc/TSd6fh
         6Ua62D4ys2WHpo3GtShvBdnZ954baXkF5oWcz2FHy8biLJkx6Sd9rbMOeU/kwxHgX2gx
         jYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SzLODM57m3w3inYL6DTLJ3StbqdECnhPUQ+AZ+E6/OU=;
        fh=FL7fnSH9E4sKqTnmNUUWDcupURyMSPb8tAIceZ68Sd4=;
        b=SGsCGrCXVxsqIWhmNrA4mA/o3NOPZROSQyuDo1qysqFqeDAT45md+cGfOvXUEonI/2
         0Vmd+v5gHCIYJaO6zhX6+aUIATFjugZVNCiCYNRgz1syBnyBq6RWF24ueVe0Im+38L1R
         EVx0KoCadCyHbDc/hwi0pc8dPlUF73oo92qiH/sGxPpXhfdYeS9NeJ9AaXx3AA7CytsZ
         8GGx9lUdk+OIZ5DYTD3RWKJiPlLphKssL2g2TbxDuSWOEBCsW4O4Y5WwYXdU3Bkjc1Ip
         +5FSyIWjVpN5xlyK7Pdt5I0HYMrBzmEavympRtG1cBvhc/JHN/NLSm1F9MpovhdNwa15
         VWyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789142788; x=1789747588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzLODM57m3w3inYL6DTLJ3StbqdECnhPUQ+AZ+E6/OU=;
        b=qaINVVISeZGxKCkRFx+firAPL4e6FVIooNU+cT+VtZkxIHB4zwpFVVSXExamA8TLhM
         kXWcMxqguvdIIIenMGrnkRHbrMFb2G8zilBF8IqE+iBM0Q4RvNbGVHoXB93eRen4ZMCu
         +IelXP5xPECbebgg5HEhmf43JyEyzzkFEcAVxKufw6r5zqBkXcxRWFlnzUiIH5mfgvGB
         XM43rIc5ru3IR0j/dFRpSFsGAMeJRy1FMBcOq2R4rOraJ2QvfUKchiyMmxlZdcSQLKTJ
         ZIpYRqRFMlutfu8TIJI3h0nxSE2PY77p2+ccc9wSJU8ooqoBHArKNmQbEPm2qNOVtrtC
         FRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142788; x=1789747588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzLODM57m3w3inYL6DTLJ3StbqdECnhPUQ+AZ+E6/OU=;
        b=IIpHali54wraGMrZYMtH5eOp42y+t26E6/AktuwHwVWLbMao1HKr6TNnYhwyB0bg7b
         I+qL8YHsOr7FPwb6VLZCoLozqD/ABQO15Fs7kfTTCh4nirWzg3DmJhvQEXfz3YRnbFmZ
         ISnxdrVSegIpOIx1BlTIp+p8ZIP6HvIXFSBDVhU+QBB7K0unY8Z1PelnrJRI2lVffPV7
         79zdRjZBO+WufWRyjf1ovohMaR5H3g4awrUcRFZKSTZAaH+R57VYNWf2iJ00EgramVbz
         B85MpcjSUceGWQU8B3za9ienjL+gX1/nDe9kPtybVt+VlwFVuK1unZnlSPtryXxaLSqk
         m7Uw==
X-Gm-Message-State: AFuF++keJd79vglGx6J0fV/yK4RAl/4xVmKmhhTQjW8kYY/tJDeBuiRn
	ixnjd8NK10iBPRxYuZXSRP7daAGzzwre4p7PND/KViUMbaORQ85F+/41b3cOPYGSktp9TGuGbdp
	uU0/mBoap6T0qH8afkRTvWHbRpvJ/y5E=
X-Gm-Gg: AYBFou26uZ4pthzodOwLMdcTuXBpCuR6fBMhdRAhcKOkv28sHkTfk9e2j9yjNWKFhhK
	zU3z4HYZOAY1ThY30Po46Y2eZYE3vmFKt8WOtLLtRb6kJ67muiT2nQjYTBJ3/mXNUvVz1BjrHoG
	U5iuU+h6f2PrUInsR689PTJ+NURcM9BxHKNLf129/JQ5xlk0IQI+RP48CYmGRM1ThiCEAA2sRNR
	4v5Y1/LWf3gtP1ErehCHlYQeyPoktHbN+sONTyFC/UlwHeTlKqokteJaFjMWLIo2zhR3BvtJ+ez
	4OGgrpr2xxvOg6YRZ3rKXuJsKiJlFdw8N0mWQmUltqt0fXqCdSGW7vRDWOnaTfn3dYSYI/m3tHg
	W+TYziL7i07w=
X-Received: by 2002:a05:6820:290a:b0:6c0:31a9:eb10 with SMTP id
 006d021491bc7-6c0ba146a71mr3396179eaf.15.1789142786954; Fri, 11 Sep 2026
 09:06:26 -0700 (PDT)
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
Date: Fri, 11 Sep 2026 21:36:15 +0530
X-Gm-Features: AcwNN1XmwpcFoKfW6ND_YTpIMnmn0OSUajckkQO0bx78knCurWOkzwV17u5MrNw
Message-ID: <CADxQDVogx32UNPVqtOoifMK+z59Xvv97mt14yoASrrM076Sxpg@mail.gmail.com>
Subject: Re: bpf: BPF_MAP_UPDATE_BATCH into a fresh NO_PREALLOC LPM trie /
 hash map returns -ENOMEM at element 2 on AWS Graviton5 (bpf_mem_alloc refill
 IPI races the syscall)
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hou,

I tested the patch on the affected hardware today. Short version: on
Graviton5 it hangs the machine at the first batch update, so it is not
usable as posted.

Setup
-----
EC2 m9g.8xlarge (Neoverse-V3, MIDR part 0xd84, 32 vCPU), Amazon Linux
2023 kernel 6.18.41-94.142.amzn2023.aarch64 (the EKS 1.36 AMI). Your
diff applied cleanly to Amazon's patched 6.18.41 tree (I had to
reconstruct it from the mail: the client had mangled the leading
whitespace, so if anyone else tests, take it from a git tree rather
than the archive). Built with the shipped config, LOCALVERSION=3D-hou,
same reproducer as in the report (fresh map per iteration, batch of 7,
one CPU pinned per loop, 50 iterations x 32 CPUs).

Before (stock 6.18.41)
----------------------
  LPM_TRIE key 260 batch x7           1582/1600 ENOMEM, batch.count=3D1
  HASH key 260 NO_PREALLOC batch x7   1565/1600
  LPM agent-shaped keys batch x7      1600/1600
  7 x UPDATE_ELEM / batch x1 / hash key 8   0/1600 each

After (6.18.41-hou)
-------------------
The first run (LPM variant, pinned to CPU 0) never returned. Within
seconds the console showed:

  rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
  rcu:   0-...0: (1 ticks this GP) idle=3Def1c/1/0x4000000000000000 ...
  rcu:   (detected by 31, t=3D5902 jiffies, g=3D1229, q=3D3329 ncpus=3D32)
  Sending NMI from CPU 31 to CPUs 0:

with no backtrace printed for CPU 0 (it did not respond to the NMI
either), then hung-task reports for writeback kworkers and repeated
RCU stall reports every ~3 minutes until I terminated the instance.
Not tainted, nothing else in dmesg before the stall. I could not
retrieve partial results from the box.

Reading
-------
I think this is the case your FIXME anticipated. irq_work_wait() spins
until the refill irq_work has run, but unit_alloc()/unit_free() restore
the caller's IRQ state before waiting, and several callers allocate
with IRQs disabled: the LPM trie's intermediate node under
raw_res_spin_lock_irqsave(&trie->lock) (lpm_trie.c, second allocation
in trie_update_elem), and every hash element under the bucket lock
(alloc_htab_elem() from htab_map_update_elem()). A raise followed by
the wait in that context can never see the IPI delivered, so the CPU
spins forever with interrupts masked. The leaf allocation (IRQs on)
would have been fine, which fits the reproducer failing on element 2's
path rather than element 1's.

If the approach is kept, the wait would need to be skipped when the
pre-call flags had IRQs disabled (and in interrupt context), and
probably bounded. That leaves the under-lock allocations exposed on
this hardware, which is why I ended up reserving before taking the map
lock in the RFC; the kmalloc_nolock direction you mention would remove
the problem at the root.

I can re-test a revised patch on the same instance type; turnaround is
about an hour including the build.

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
