Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733391;
	b=dSE80+zCPOOADrZ8Mp40l5GcSKQeIs/j+GWE+DlUCrQ0u5Dag36uf0DQhwNXO7Itv11e
	 PNSKNzH8G+kjmsK5ASfyjnicX6IzYDdBwuWPSJCPdKOnhY/UBho941DLmTGutSV1mx0AM
	 TAshHZmI1nLwdJIe3G25Y1hHOSk2KpmNcAcxAAlx42dpyHeI/e7eDIbYleXM6TmI6YzMk
	 nqsBI1sG5icpTlABEUhJtq2FGjTz8eYK4i7NVlz1RR2bMMIpe5WmFYAMqdWmXcdTBiwAC
	 uXcjN7TtS8vlyAgijsgw1m1Usa/aA4Nhummrk/zlkimIcqzx+9tncI/zzJazZ+dzRGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733391;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ez3LREjVqWbtuu0R1Tu+Hqdkn2audXMfzoID2IZR4xo=;
	b=nbfiFn7wpRQH0FrvZtf4WdqXhyHfz2Ib7vrXlk5m0A3pEDxa9I7vUQLUpeHgBDjs6YLp
	 SRDEjNoqReVACnnG60a5A1y9pKXJu3FacgCT1XSjJmeQK7Ro1ayHMADXFwuhAEIJ24uL6
	 vmSm8nyewyUj5rD3S0wzUqddr2DXIBh5vwYtUAnV4GgMGXr9EiKyyqKrS+lB+sgVUz0Af
	 sOT05XaAR4xdUjXGfnXB+BChMdUrMNbszDo8NCWV6BeORxkoTy3BVvnoZkPDIqVaPi7Ec
	 CZh3tA//cUCBu1Y1LXe6kAVvvtS8DbB6xoTMXOhOfBt71UWAiNYf5aXQ9iyEcK1nwbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCnHBREx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C1606A31B;
	Tue,  3 Nov 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCnHBREx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31ED1F000C1;
	Tue,  3 Nov 2026 19:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793733391;
	bh=ez3LREjVqWbtuu0R1Tu+Hqdkn2audXMfzoID2IZR4xo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UCnHBREx6K51wmLNE6LB68w9g2tOgu+8lMJxiApS+OIZGKlCnPJzV16a++Less2II
	 CTIhoKRhFsGr1Dzb+Fj+AM6cjPRmJCTQsYu5vft8+QFApkgRbnHIaYLwmL7bD2IlJs
	 52ClxnLnnioj1FgZ/syAEGOZn65k8XuJRSuD8miOv3npiGCtRbUsarTO3zs0IqZ56r
	 lh6Vkj5VcbzpMbCxHac2srtMI5U3ycI0Qq0VNueWC8R7ODVo6xdNWygvHHtocgahTj
	 wWagnV6Nj9lHDsjum8bsGQSJwLFIVuLuUsIekn2HCD8yP2+m2R62Cq7DLAwJUALTCT
	 fvJVHxr8ecTng==
Content-Type: multipart/mixed; boundary="===============2571936981127289922=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <228df6014515374d68917ecb8bf5d831f40843809ac3d93162aa7fd14b416744@mail.kernel.org>
In-Reply-To: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
References: <20261103-bpf-rhtab-irqs-disabled-v1-1-9874d96a088c@columbia.edu>
Subject: Re: [PATCH bpf] bpf: Fail rhtab inserts and deletes with IRQs disabled
From: bot+bpf-ci@kernel.org
To: mt4022@columbia.edu,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,yatsenko@meta.com
Cc: eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,tz2294@columbia.edu,mt4022@columbia.edu,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 19:16:30 +0000 (UTC)

--===============2571936981127289922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fail rhtab inserts and deletes with IRQs disabled

TL;DR: The irqs_disabled() check in rhtab delete and insert may return -EBUSY
for every IRQs-off caller, such as sched_switch or perf programs, not just
re-entry, breaking previously working users; the commit message's claim about
other hash maps is also questioned.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3144,11 +3144,14 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
>  	int err;
>  
>  	/*
> -	 * disable_instrumentation() mitigates the deadlock for programs running in NMI context.
> -	 * rhashtable locks bucket with local_irq_save(). Only NMI programs may reenter
> -	 * rhashtable code, bpf_disable_instrumentation() disables programs running in NMI, except
> -	 * raw tracepoints, which we don't have in rhashtable.
> +	 * rhashtable takes its bucket bit locks with IRQs disabled and can't
> +	 * detect re-entry. With IRQs already disabled this CPU may already
> +	 * hold one, e.g., in NMI or in a program attached inside the resize
> +	 * worker's locked section.
>  	 */
> +	if (irqs_disabled())
> +		return -EBUSY;
> +
>  	bpf_disable_instrumentation();

Does this irqs_disabled() check detect re-entry, or does it reject every
delete made from any context that runs with IRQs off?

Most of those contexts do not hold a bucket lock.  For example, a tp_btf
program on sched_switch runs after __schedule() has called
local_irq_disable() and taken the rq lock:

  __schedule()
    trace_sched_switch()
      bpf program
        bpf_map_delete_elem()
          rhtab_map_delete_elem()
            rhtab_delete_elem()
              irqs_disabled() -> -EBUSY

The same applies to sched_wakeup and irq_handler_entry tracepoints,
perf_event programs (which run from the PMU NMI or hrtimer hardirq),
fentry/kprobe on functions that run with IRQs off, sched_ext callbacks
under the rq lock, and code between bpf_local_irq_save() and
bpf_local_irq_restore().

The verifier has no program type restriction for BPF_MAP_TYPE_RHASH, and
these calls succeeded before this patch.  Would a guard that fires only on
actual re-entry, such as a per-CPU or per-map marker set around the
rhashtable locked sections, or a bounded trylock on the bucket lock, avoid
the deadlock without breaking these users?

The commit message says -EBUSY is returned "like the other hash maps do on
re-entry".  Is that accurate?  htab_lock_bucket() uses
raw_res_spin_lock_irqsave() and fails with -EDEADLK or -ETIMEDOUT only when
rqspinlock detects a deadlock or timeout, not merely because IRQs are
disabled.

Also, 46730ee6e884 ("rhashtable: Use irq work for shrinking") moved the
shrink kick to irq_work so that it may be called in NMI context.  With this
check, __rhashtable_remove_fast_one() can no longer reach that
irq_work_queue() call from NMI or with IRQs disabled via this map.

[ ... ]

> @@ -3261,6 +3264,10 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>  	if (atomic_read(&rhtab->ht.nelems) >= map->max_entries)
>  		return -E2BIG;
>  
> +	/* see rhtab_delete_elem() */
> +	if (irqs_disabled())
> +		return -EBUSY;
> +

The same question applies here: this makes every insert of a new key fail
with -EBUSY from any IRQs-off context, whether or not a bucket lock is held
by the current CPU.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41698986159
--===============2571936981127289922==--
