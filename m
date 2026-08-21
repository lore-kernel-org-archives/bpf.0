Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B733FD129
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341116; cv=none; b=qHtd9LcOkHz5aTmAPynJOnsX3dWXMt7biB0NMI57LGUdugLylDzliXpYl7dXbUowXgU9CNvMpP2PuqDJb9cn3WSGhvOb2t8+crDD9XwBKN1AdsSbf2DfpapMCCYdG6pU2gckgugxrmpVS5AlR02LiB+DH2J/icgSimaYJjh0W8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341116; c=relaxed/simple;
	bh=5exMekd6cq7ZbEYRVdULv/pnWTFOFgtQahn1mksCL5Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hRKA3b+UV2TOGpDd5hzq1emBrOMUlbQded9GcaHd5EhRzz03jrzVcHgzpt5OMWsHPOwgHw8EZPay6vWqFP4VG3VfTkVkBLI4e0p8r4+gVjf9bId5f2Gp/aK40yqJneUevtepQ5V0O8pIIwzLekl7OhdPdyHlO11JXf+nYtJ1060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2fxHWZr; arc=none smtp.client-ip=74.125.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2fxHWZr"
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c219353e5bbso87122166b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787341113; x=1787945913; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xA4Ufzhn7RgFBDdlpRY4ipCaqygjEyBt0gBKZ9kn2Z4=;
        b=F2fxHWZr0NXb/LCo5DdM+HzzUkbJvYaeRck9v5p0v2IKJDpaLjfjtYuIQurTnyJArS
         1MfMZmqnpbTVdGXQDBTwRgmiRaqc3riaqXmzeW9IWTsKuSV0TSXFVEXNioC0AJ+jTGfm
         RyUvT/YUgRnNeWVqqIvB8pRFs619P6KZ2rvvZx1XVHndI9Uuw+dGbXgqsA42JM7+Wlaj
         cj7Rs4nNBuOXFPu3q+o+qxvF5Ux/R9p9akAYWzCsyn1jTL0YsX11OTIi6hTKCoyvg/kN
         qzLTVMJglA/j+bnVcQhdJmHs8c4CNmwKguo+Ygy8AJYupvMwuH34yFM9AD6dPGjDiVrq
         h/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341113; x=1787945913;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xA4Ufzhn7RgFBDdlpRY4ipCaqygjEyBt0gBKZ9kn2Z4=;
        b=dggiOPmbZokLnxBt43CqZlP031+0zBjjzmN5ZAKv4Gb3SSG9aZnCxNkzN1pPtMFQkp
         jZUPI3dFxVkkf9uDagOzD0sDy72XbKvFFinr4Dhq8CpeFk4CSgtbjN1Feymz8KuU/H7V
         X5iBk+ErNPhfyOiwej8K2g9uRPfHfzILweedRdazEis6JsOG4LPNbmziRs1AfHjVzcLK
         Ci9gRbbYYYUzdOJ6jUZlfcp24GTMvi/pHLPyJPoQ8kh4kdOEGRZRqts+uUwsR9Xr7o7G
         /G5Fkjq9xMMNsO75FvZiXaM6P1h2cvZM3YZERa+OJhiCMzZ97OpRGz15ruXXBGYGfsjG
         jR7A==
X-Forwarded-Encrypted: i=1; AHgh+RqBrrMyp+UkdJHcIA2nbTH1e67ERrFa3otKCLk/VY7Z+hMecs+rUBX4iSdvTrdL4/ob/ns=@vger.kernel.org
X-Gm-Message-State: AFuF++ndlL/NSXV1rWZc6x5STqSPlMieMEKS/10EbZyq4rQadz55iAch
	mXCSX7eFSAhGFAuS2tTPe5AcQL+aYRiKVX5P7TxJ73ZR+ZKkIuJUndbO
X-Gm-Gg: AR+sD10xiNLgA+Dbm6Djfi54OwKf0uHc6jnCVHZJgEABl2MwVIKnHE4bIbqx63wZjtG
	BrsTP232GS8x1z8Wkl3oTXSYSdPh0aMhu6HaJdtjblyJjBKdPHlqDMDdloehulFdCiNJK6spK5j
	Vz/nPTQ5BdiFj5YRnR22Gj6ANr+ofuCjJIGCkedc3b7a7fa03bBtYcE5XHT5Y0LpxAlIDTtJynJ
	AKmRLWI9kobBK38qvkHc3fi4h9n7M1AKRYHdxveXiVvZCQvypge3KJ8SYDiV77ipv7nmvA4blih
	pi+AiuESgarYHP3SVezRHCEF/feUNI8cCHBrrYUjc2sSABbjBE8eOUZrkTyO+2U0fJclK0ZncxN
	QKc8TaALOvo1lopKEqFKsBP+8oH1Qw5sMJVZh3kkYhRiI3Zawh8oCKaVCMcKnFoPbbdAED38rbl
	3NX9S3wPBZgVgWN8QG0KxcY+8lyImcRE2y9xa7ZP1P1FaCSN+qYcsSs56q6Hcjwr5oxUr1Ym/1Q
	TGma3fdsXQJ2Q64PTWci3LfDf6FY+19LBn/NzqLiTB8oZv8055eo9to8a6biODJ7Gwy8THKoaFW
	Pqmvx62gRAkPS/UIl/YEVdCRINc=
X-Received: by 2002:a17:907:930a:b0:c24:680b:3944 with SMTP id a640c23a62f3a-c24925e416dmr54569566b.13.1787341112895;
        Fri, 21 Aug 2026 12:38:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c245919888dsm586894466b.29.2026.08.21.12.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 12:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 21:38:31 +0200
Message-Id: <DKUVJN7NQMAI.2JXLSBOGJTI1W@gmail.com>
Cc: "Roman Gushchin" <roman.gushchin@linux.dev>, "JP Kobryn"
 <inwardvessel@gmail.com>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>, "Barry
 Song" <baohua@kernel.org>, "Geliang Tang" <geliang@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, "Hui Zhu"
 <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v4 1/2] mm/bpf: Add bpf_proactive_reclaim
 kfuncs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Hui Zhu"
 <hui.zhu@linux.dev>
X-Mailer: aerc 0.21.0
References: <cover.1787205002.git.zhuhui@kylinos.cn>
 <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
 <CAEf4Bza0KYB+OHpa89K16+ptUQuQDJKyxxNCyDPcgQaO1mtxjg@mail.gmail.com>
In-Reply-To: <CAEf4Bza0KYB+OHpa89K16+ptUQuQDJKyxxNCyDPcgQaO1mtxjg@mail.gmail.com>

On Fri Aug 21, 2026 at 9:12 PM CEST, Andrii Nakryiko wrote:
> On Wed, Aug 19, 2026 at 11:12=E2=80=AFPM Hui Zhu <hui.zhu@linux.dev> wrot=
e:
>>
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> Expose memcg proactive reclaim to sleepable BPF programs:
>> unsigned long bpf_proactive_reclaim(memcg, size);
>> unsigned long bpf_proactive_reclaim_swappiness(memcg, size, swappiness);
>>
>> They perform one reclaim pass on @memcg, like a write to memory.reclaim:
>> swap is allowed, and the anon/file balance follows the cgroup's
>> swappiness or an explicit override in [MIN_SWAPPINESS, MAX_SWAPPINESS]
>> plus SWAPPINESS_ANON_ONLY. Both go through a shared helper,
>> bpf_proactive_reclaim_pages(), which guards against reclaim recursion
>> and calls try_to_free_mem_cgroup_pages() with GFP_KERNEL and
>> MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE, the same parameters
>> user_proactive_reclaim() uses, and unlike memory.reclaim they do not
>> retry until @size is reached.
>>
>> Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
>> current->reclaim_state on entry and NULLs it on exit, so a nested call
>> from an in-flight reclaim would corrupt the outer reclaim state (e.g.
>> MGLRU dereferences current->reclaim_state->mm_walk). Both kfuncs
>> therefore refuse to reclaim when PF_MEMALLOC is set or
>> current->reclaim_state is non-NULL. The latter check also closes the
>> window in try_to_free_mem_cgroup_pages() where reclaim_state is already
>> installed but PF_MEMALLOC is not: only a tracepoint call sits in
>> between, and while a sleepable BPF program cannot attach to the
>> tracepoint itself, it can attach to the generated trace iterator
>> function (__traceiter_mm_vmscan_memcg_reclaim_begin) via fentry.
>>
>> The kfuncs take @size in bytes; the return value is normalized to bytes
>> as well, matching the byte-based unit of bpf_mem_cgroup_usage() and
>> bpf_mem_cgroup_page_state(), so callers can mix them without manual
>> page/byte conversions.
>>
>> An out-of-range @swappiness is reported with (unsigned long)-1 instead
>> of 0, following the convention of bpf_mem_cgroup_vm_events() and
>> bpf_mem_cgroup_page_state(), as 0 cannot be told apart from a
>> successful pass that reclaimed nothing.
>>
>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>> ---
>>  mm/bpf_memcontrol.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 118 insertions(+)
>>
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index 716df49d7647..dc51868b3acf 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -6,6 +6,7 @@
>>   */
>>
>>  #include <linux/memcontrol.h>
>> +#include <linux/swap.h>
>>  #include <linux/bpf.h>
>>
>>  __bpf_kfunc_start_defs();
>> @@ -159,6 +160,120 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct=
 mem_cgroup *memcg)
>>         mem_cgroup_flush_stats(memcg);
>>  }
>>
>> +/*
>> + * Reclaim must not recurse. try_to_free_mem_cgroup_pages() uncondition=
ally
>> + * overwrites current->reclaim_state on entry and resets it to NULL on =
exit.
>> + * So invoking it from an in-flight reclaim would clobber the outer rec=
laim
>> + * state and corrupt its accounting.
>> + *
>> + * The guards are PF_MEMALLOC and current->reclaim_state. Every reclaim
>> + * entry point marks the current task with PF_MEMALLOC for the whole
>> + * reclaim window: try_to_free_mem_cgroup_pages() and __perform_reclaim=
()
>> + * do so via memalloc_noreclaim_save(), and kswapd keeps it set for its
>> + * entire lifetime. A hook inside the reclaim path (shrink_node,
>> + * shrink_slab, ...) executes in the context of the reclaiming task, wh=
ere
>> + * current->flags already carries the flag. The page allocator, the mem=
cg
>> + * charging path and node_reclaim() rely on the same flag to avoid recl=
aim
>> + * recursion.
>> + *
>> + * reclaim_state is checked in addition because it is set slightly befo=
re
>> + * PF_MEMALLOC in try_to_free_mem_cgroup_pages(), with only a tracepoin=
t
>> + * call in between. A sleepable BPF program cannot attach to the tracep=
oint
>> + * itself, but it can attach to the generated trace iterator function
>> + * (__traceiter_mm_vmscan_memcg_reclaim_begin) via fentry, so PF_MEMALL=
OC
>> + * alone would leave that window open.
>> + *
>> + * Also, PF_MEMALLOC is set in some non-reclaim contexts (e.g. direct c=
ompaction
>> + * and vmalloc), where the kfunc conservatively refuses to reclaim as w=
ell.
>> + */
>> +static bool bpf_in_reclaim_context(void)
>> +{
>> +       return (current->flags & PF_MEMALLOC) || current->reclaim_state;
>> +}
>> +
>> +/*
>> + * Shared implementation of the proactive reclaim kfuncs: performs one
>> + * reclaim pass on @memcg with @nr_pages as the goal, allowing swap, an=
d
>> + * @swappiness as the anon/file balance override (NULL to follow the
>> + * cgroup's own swappiness setting). Returns the reclaimed amount in
>> + * bytes, keeping the byte-based unit of the kfuncs' @size argument.
>> + */
>> +static unsigned long
>> +bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_=
pages,
>> +                           int *swappiness)
>> +{
>> +       unsigned long nr_reclaimed;
>> +
>> +       if (!nr_pages || unlikely(bpf_in_reclaim_context()))
>> +               return 0;
>> +
>> +       nr_reclaimed =3D try_to_free_mem_cgroup_pages(memcg, nr_pages, G=
FP_KERNEL,
>> +                                                   MEMCG_RECLAIM_MAY_SW=
AP |
>> +                                                   MEMCG_RECLAIM_PROACT=
IVE,
>> +                                                   swappiness);
>> +
>> +       return nr_reclaimed * PAGE_SIZE;
>> +}
>> +
>> +/**
>> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
>> + *                         cgroup
>> + * @memcg: the target memory cgroup to reclaim from
>> + * @size:  the amount of memory to reclaim, in bytes
>> + *
>> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
>> + * the memory.reclaim cgroup file: pages are reclaimed according to the
>> + * cgroup's own swappiness setting and swap is allowed. Note that,
>> + * unlike memory.reclaim, this does not retry until @size is reached;
>> + * callers can invoke it again if needed.
>> + *
>> + * The reclaim runs with GFP_KERNEL, so this function must not be calle=
d
>> + * from a context that holds a filesystem lock (e.g. an LSM hook invoke=
d
>> + * with inode_lock held): the reclaim path may enter filesystem shrinke=
rs
>> + * and deadlock trying to reacquire the lock. Contexts that set
>> + * PF_MEMALLOC_NOFS/NOIO are handled by the gfp context inheritance.
>> + *
>> + * Return:
>> + *   The amount of memory actually reclaimed, in bytes (rounded to full
>> + *   pages), or 0 if @size is smaller than a page or the calling task i=
s
>> + *   already in a reclaim/freeing context (PF_MEMALLOC).
>> + */
>> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memc=
g,
>> +                                               unsigned long size)
>> +{
>> +       return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE, NULL=
);
>> +}
>> +
>> +/**
>> + * bpf_proactive_reclaim_swappiness - proactively reclaim memory from a
>> + *                                    memory cgroup with an explicit
>> + *                                    swappiness
>> + * @memcg:      the target memory cgroup to reclaim from
>> + * @size:       the amount of memory to reclaim, in bytes
>> + * @swappiness: swappiness override for this reclaim pass
>> + *
>> + * Same as bpf_proactive_reclaim(), except that the anon/file reclaim
>> + * balance is controlled by @swappiness instead of the cgroup's
>> + * swappiness setting. Valid values are [MIN_SWAPPINESS, MAX_SWAPPINESS=
]
>> + * and SWAPPINESS_ANON_ONLY, which restricts reclaim to anon folios.
>> + *
>> + * Return:
>> + *   The amount of memory actually reclaimed, in bytes (rounded to full
>> + *   pages), (unsigned long)-1 if @swappiness is out of range, or 0 if
>> + *   @size is smaller than a page or the calling task is already in a
>> + *   reclaim/freeing context (PF_MEMALLOC).
>> + */
>> +__bpf_kfunc unsigned long
>> +bpf_proactive_reclaim_swappiness(struct mem_cgroup *memcg, unsigned lon=
g size,
>> +                                int swappiness)
>> +{
>> +       if (swappiness < MIN_SWAPPINESS || swappiness > SWAPPINESS_ANON_=
ONLY)
>> +               return (unsigned long)-1;
>> +
>> +       return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE,
>> +                                          &swappiness);
>> +}
>
> I haven't followed previous discussion, so I apologize if this was
> discussed, but if not, isn't it a bit an overkill to have second
> variant just to provide optional swappiness? Valid range of swappinees
> seems to be non-negative [0, 200], that special ANON is 201, so why
> can't we defined that <0 swappiness just means no swappiness was
> provided and get away with just one kfunc?
>

I think my understanding of Shakeel's suggestion was that we only add one
bpf_proactive_reclaim() for now, if swappiness parameter is necessary we ca=
n
introduce the second API later. But given it seems Hui wants to add both, I
think it would make sense to do what Andrii said and just introduce one kfu=
nc
with the swappiness parameter now.

But Hui, please wait for Shakeel to comment before respinning again.

>> +
>>  __bpf_kfunc_end_defs();
>>
>>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
>> @@ -172,6 +287,9 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
>>
>> +BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_proactive_reclaim_swappiness, KF_SLEEPABLE)
>> +
>>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
>>
>>  static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set =3D {
>> --
>> 2.53.0
>>

