Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907151;
	b=TBdTxTOM9o6bX8Mn7a3rfPjuz2IpMM/6XLHYmxioUrVaor32uYfFbn74FEgG5bEEmFxs
	 uyMTqqr5QQjdQNEHvTni7HFyAxWi75pc6oevjPbCjrXoRAM1OEfSbMXPaWA2C9qXUpDCk
	 DbBCpmnawCq4ljFwXZ2LxC2AFhI4hgq9sJAQwABoEy3Xjhdxiio4ZngFboC8/G8SD4Wye
	 ewnFQmhwSHbivP31JHoqAUdQgxLrZoHqOP6efTBzipOvaOCs8PzGDkkGg2wRdXTKQ9BFU
	 Lc79uqKGQnqXIE+XrOpF0HI/phxPq3Ct/UsmPPhgkFgdVi0zDJYBfG3Hl9EqZdpGpXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907151;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ok9xK5+RVU2z7z4ZSozse27/W4AiAkS/EO9C5ir25mU=;
	b=wnK5U3hWbwRdevAJGthwGh4HcgarY8ddNp6VFKQJzPv/vXFjuv4uKGL1IuWh4+3w1Ymw
	 3txtgRmFSYSGCwqtAm+qD3iCb3SwDcbs979kLOrsyhNJj9V7T6e4IzimoO/QH3sXWoH0b
	 a71+M8uTpDOjGx9i+DkL2ZNTEjreiNiGtaq8ptUSrMkzfJ6GgE66N466Ww1agLgZj2s4d
	 Hr9hyBlgqPi0ONOGu56DN5/r3CB/+KIvwyalljt0Ng1NtzdFV+mQb+8tKhjwOMODdDaw8
	 XM6ELZapoc7mIyoWpPKUMP6MTrzD9/MJu/IUhYyLglaIH6hmgC48DTnCbvZXDAcY4dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXEpCvgM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D77606A6C4
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JXEpCvgM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FA81F0180A;
	Thu,  5 Nov 2026 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907150;
	bh=ok9xK5+RVU2z7z4ZSozse27/W4AiAkS/EO9C5ir25mU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JXEpCvgMvZTaNGm8wQu4y9NnL3PiXn40dik5btKpjiQjiQ500nJqAUxUmX/xkGPQN
	 7aoOH1KU7q8QpIMjVeTCrAJL0pnDDhDOsMmrhDNdbr3GOSyV4+UNFE/J83HW2iM/QS
	 x40zxJ0PvTQF02Xp6dHZwbJO4sPIf2B8ohaViSQt+RZSby+s0s9KBv/Eh3aaAEG4ep
	 ved22ag41BHnovDpejindOF+sQnFqaEaEZu0ttzhS+yDELcBJALwZQ3Q/rHRxZNcFi
	 EeGCQ+NaFsdNX1ANLt9fq9htAX0t1wW8p5OEuk53nLC3ttymuZEICt5lux7bIU7SMF
	 Fb0ZERC673n7A==
Content-Type: multipart/mixed; boundary="===============3645252185705630894=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9b551f0d5966ca8c834e49751d89d574b949086aff27c8031f8e30c558659b10@mail.kernel.org>
In-Reply-To: <20261105184411.29248-1-emil@etsalapatis.com>
References: <20261105184411.29248-1-emil@etsalapatis.com>
Subject: Re: [PATCH bpf v2] bpf: Use dedicated workqueue for freeing BPF programs
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 19:32:30 +0000 (UTC)

--===============3645252185705630894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use dedicated workqueue for freeing BPF programs

TL;DR: Design question: the new bpf_prog_free workqueue uses max_active=1, so
slow frees (rtnl_lock, cgroup_lock) may block all other BPF frees, delaying
memory release. Would the default or WQ_PERCPU fit better?

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -3143,6 +3144,17 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
>  	kfree(aux->used_btfs);
>  }
>  
> +struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
> +
> +static int __init bpf_prog_free_wq_init(void)
> +{
> +	bpf_prog_free_wq = alloc_workqueue("bpf_prog_free", WQ_UNBOUND, 1);

Is max_active=1 intended here?  With WQ_UNBOUND, max_active is split across
NUMA nodes, with a per-node minimum of 1, so a single-node machine runs
exactly one queued item at a time.

Before this patch these items ran on system_percpu_wq with up to
WQ_DFL_ACTIVE (1024) active items per CPU.  Several of the work functions
sleep on locks unrelated to pack_mutex:

bpf_prog_free_deferred()
  bpf_prog_dev_bound_destroy()
    rtnl_lock()

bpf_prog_free_deferred()
  bpf_cgroup_atype_put()
    cgroup_lock()

__bpf_tramp_image_put_deferred()
  trampoline_lock(tr)

bpf_prog_pack_free()
  __purge_vmap_area_lazy()
    flush_work()

While one of these sleeps, every other queued free waits behind it,
including the cBPF frees done on process exit with a seccomp filter
(seccomp_filter_free() -> bpf_prog_destroy() -> bpf_prog_free()) and
socket/tun/cls_bpf filter frees.  The memory, map/BTF/module references
and JIT charge are only released once the queue drains.

The vmalloc purge helpers are queued with schedule_work_on() on
system_percpu_wq, not on bpf_prog_free_wq, so a default max_active of 0
would also avoid the deadlock.  The cgroup_bpf_destroy_wq in
kernel/bpf/cgroup.c uses alloc_workqueue(..., WQ_PERCPU, 1), which keeps
one active item per CPU rather than one per node.

The commit message doesn't say why system-wide serialization was chosen.
Would 0 (the default) or WQ_PERCPU be a better fit here?

>  	if (!bpf_prog_free_wq)
>  		panic("Failed to allocate BPF program free workqueue\n");
>  	return 0;
>  }
>  early_initcall(bpf_prog_free_wq_init);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42089627629
--===============3645252185705630894==--
