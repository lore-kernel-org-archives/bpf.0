Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411008;
	b=sukgrQK8KLNDdotGMsE2FmKLQr+waH5LVANqHhRfhiuloOShbrO3IKL703HgSppn95PV
	 iVKVrpCd9l4ouqlr4bLn8AKIpXh2EyGh6xlm8OsAJcbM9XNjZliVofVEqwuIDuRlU7/cJ
	 ouY8sY1L35AAdmn4VaLcSlbUc34q7X1M2Y/PESVKXP1ZmxRHG6TV7MSJSZPlWejHJWQAk
	 MskdKpMvBnQcV2xcS+rOTGg2u2O5PSFggch109ZOm05N8cglhZxlnLoNDcgQWLR1m3j1f
	 Ax5JAy06/xsINpN/jZf5ymq6sTRE0lMAb26dxWy3di6cYh/3kPheb+/2ndzoCduvGHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v2iF4eIIgFhNwGjef6kaSNZwlndj5tyzzHo3WQIwyok=;
	b=o1jT1dyray/L8jJyGEU90Auww07oUzOrYEJh4zZd1sBOuBKrSCF4g0NgYx61kpCwCIdB
	 u+M9RaS11+7Ef3yjXBI2E3T2qYglA21Z9OuwyzRLKuaAFFqEL1/p+3m5EWWZWP8MiyvEL
	 npf2c8SWHjWVyqqWOW7lcEr/m2GaV5Llcefy4oy5g/xbi0GqkIzy5gFvTF43ZPBIFBvef
	 /51qng/9S2SkrUS/WqWsLK9+umkf+TGdbM+QTb73dd77UdejDTkowV+/asafl0rKf7oVx
	 1L88fWTZsLsyJfJvs+vjLn4m7QUmYpuSrzUmX2vTLMzPOzmNsP8LuTUOCRErHGzGyew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZOinNzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC3606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZOinNzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48341F00A05;
	Wed, 11 Nov 2026 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411007;
	bh=v2iF4eIIgFhNwGjef6kaSNZwlndj5tyzzHo3WQIwyok=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IZOinNzKzBuhLDuAQYkmQHxfLpCzeV9YjGeJNCCxdDzyrBuNirvVTqdJfqTl7xrri
	 0rAJZpWGGLpg0YZy8aeM1quy+b38YJOYIQ66IzKEGVV2kWzqdlRlpC6pbIHG4efy7B
	 7ElEeHMvwlcx0er5Dm+WH8ayt8vGF0IExBa5ZN2MzchK4qYrsvIXRU7kjDqwzHw7rY
	 n3smfEKsH88piXXSqSDwkV22lQGvrE8aDZ7MTO+dZ8pkWGXGj0T962KUZYU8GwdedW
	 nrGpBTa0VJDjnFV/nWqDc3wSbQwdFf+hQeJ62QVsTeZBqNW962PIBRfu7tQfa0YISK
	 4oZtLCq+nk4WQ==
Message-ID: <sashiko-outbox-209223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 12/29] bpf: Release resources in hidden
 slots on bpf_throw()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <06579bd381e516e66f97d7b0c00e55d019011a7e.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <06579bd381e516e66f97d7b0c00e55d019011a7e.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 15:30:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: broken IRQ state restoration for spinlocks in
  bpf_unwind_release_frame()
--

commit bc130ef20556bd747c8015574438bb24ed4f95b8
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Release resources in hidden slots on bpf_throw()

This commit adds runtime support in bpf_throw() to walk discarded BPF
stack frames and release held locks, IRQ flags, sections, and referenced
objects recorded in frame descriptors.

[ ... ]

> diff --git a/kernel/bpf/unwind.c b/kernel/bpf/unwind.c
> new file mode 100644
> index 0000000000000..3b488a4bd7592
> --- /dev/null
> +++ b/kernel/bpf/unwind.c

[ ... ]

> +static void bpf_unwind_release_frame(struct bpf_unwind_ctx *ctx, const s=
truct bpf_prog *prog, u64 bp)
> +{
> +	const struct bpf_prog_aux *fn =3D bpf_prog_frame_aux(prog);
> +	const struct bpf_frame_desc_pool *pool =3D fn->frame_desc_pool;
> +	int passes =3D ctx->phase =3D=3D BPF_UNWIND_PHASE_LOCKS ? 2 : 1, pass, =
s;
> +	const struct bpf_frame_desc *d;
> +	bool late;
> +	u64 fp;
> +	u32 i;
> +
> +	if (!fn->frame_desc)
> +		return;
> +	d =3D pool->desc[fn->frame_desc - 1];
> +	fp =3D bpf_unwind_fp(fn, bp);
> +	for (pass =3D 0; pass < passes; pass++) {
> +		for (i =3D 0; i < d->nent; i++) {
> +			const struct bpf_frame_desc_entry *ent =3D &d->ent[i];
> +			const struct bpf_resource *res =3D &pool->resources[ent->res];
> +			u64 *slot =3D (u64 *)(long)(fp + ent->off);
> +			void *handle =3D (void *)(long)*slot;
> +
> +			if (ent->flags & BPF_FRAME_ENT_COUNTER) {
> +				if (ctx->phase !=3D BPF_UNWIND_PHASE_LOCKS || pass)
> +					continue;
> +				s =3D section_index(res->kind);
> +				ctx->section[s] =3D res;
> +				ctx->nr_sections[s] +=3D (s64)*slot;
> +				continue;
> +			}
> +			if (!handle || release_phase(res) !=3D ctx->phase)
> +				continue;
> +			late =3D res->kind =3D=3D BPF_RESOURCE_IRQ_FLAG &&
> +			       !arch_irqs_disabled_flags(*(unsigned long *)handle);
> +			if (passes =3D=3D 2 && late !=3D (pass =3D=3D 1))
> +				continue;
> +			bpf_unwind_release(res, handle);
> +		}
> +	}
> +}

[Severity: High]
Does releasing BPF_RESOURCE_SPIN_LOCK in pass 0 corrupt the CPU interrupt
state when a frame holds both a bpf_spin_lock and a nested
bpf_res_spin_lock_irqsave()?

bpf_spin_lock() saves interrupt flags in per-CPU irqsave_flags and
disables local interrupts, and bpf_spin_unlock() restores irqsave_flags:

kernel/bpf/helpers.c:__bpf_spin_unlock_irqrestore() {
	unsigned long flags;

	flags =3D __this_cpu_read(irqsave_flags);
	__bpf_spin_unlock(lock);
	local_irq_restore(flags);
}

bpf_res_spin_lock() and bpf_res_spin_lock_irqsave() are marked
KF_SPINLOCK_SAFE and can be acquired while a bpf_spin_lock is held.  When
a frame acquires bpf_spin_lock() with interrupts enabled and then calls
bpf_res_spin_lock_irqsave(), irqsave_flags holds the enabled state while
the stack slot for BPF_RESOURCE_IRQ_FLAG records interrupts as disabled.

Because only BPF_RESOURCE_IRQ_FLAG is checked for late, pass 0 runs
bpf_spin_unlock() first, re-enabling interrupts while the resilient
spinlock is still held, and then runs bpf_local_irq_restore() on the
BPF_RESOURCE_IRQ_FLAG slot, leaving local interrupts permanently disabled
through sleeping destructors in BPF_UNWIND_PHASE_OBJS and after the BPF
program returns.  In addition, releasing BPF_RESOURCE_RES_LOCK in pass 0
calls preempt_enable() in bpf_res_spin_unlock() before pass 1 restores
the interrupt state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D12
