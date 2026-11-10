Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273712;
	b=GGMIx2baEslu5fG8+XoeG/xQJSCNBihtl9nPCfQHdaZM5wHtXc67RSiMeMWyNafwGjiD
	 DCthbfs/u9kpOpvvKYWoJQCtZPmSHuyAHn/RNi/9ieABgMPbZaKOmqlh5sSEvpHTUGIK7
	 Ws6QVfn2CmiMsG7MqqpWzgk4u3WoyXix/MibGtiTTqGqfOi4MTajlOhHYmYXtf7Vxjfgc
	 eD+b8G1Mvv8BbQzDVh3t7wj0UCbjSXJBA1RJN5pVb+F+LPoMAoIHnx4gVOcIuXo77U+i8
	 nMADcYxt/+22UL3y/vpCLGOlYwFZc06dSckZ2cEDdFo34KSQnKBpauuhUDIqrRMP1aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bOLsr69StUMLKe1OQqNNZ/nK95girRlORD6o1C/Hjmw=;
	b=N3sFmgKDyTQ0W9MLphPBImf+vkQ4G9KzO5uNdro5UaT0idzkbn+3rtR3LgC0TpER3eWN
	 cBLyz3rU36cbp5nqsmjj4Qlc8XvTUrTeUMSdwCnUC0T/8c9hSJ89AZs9b27Y9E4XJFL+X
	 zkBZKYVWQ+362FgTc++rzZXtuEHlJ7yN8xrtA98CE5GFTcKoOJuhQ9d+kDtulZDIs0Mzn
	 RcpSUcmomIbrjtmLNg64X80/MO/LNv7tftc/iy4rOnwCC0C74KXcX4Z6m9jWL+KlJa/ZI
	 5AgC4vmE53Rn82Bkd+duP6e2TtqVyuxJ+oRpNwrrXRpxySvzP9090BAbTtAYdqyqzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3GYfoKL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433760A2628
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3GYfoKL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C541F008A2;
	Tue, 10 Nov 2026 01:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273712;
	bh=bOLsr69StUMLKe1OQqNNZ/nK95girRlORD6o1C/Hjmw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=I3GYfoKLy/unqOYJrG8Q7Izl1dOUPWC39BfQqu0cVHuQbBEB5QzF6Dj2WXtN4YGiX
	 uQh3lZ2bxErHbts9TkoTLiOX8J5wUxmi3BGw563w60C3K3HJtNVgsylqmfMXyuB9u/
	 zwp4FGNTXodmbxSyZWmhQatCc78yFMTMkEiqUdyj5S4TnydxOLC5Mfh5GmPHP48rsk
	 UcgEW4vTVD2o/5QIwe0yf6jjlw73zGGmuCpobWxchf0nd5JHjr63yPmHbRRXXcCju9
	 sPiuR5rNPQvGFvMz6Y318Nlfeqk9XXybQBtI8zHtKvZKDta18xQksxhlzJvmcJwYjU
	 r8YvcLhZnS/dA==
Message-ID: <sashiko-outbox-205955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 08/20] bpf: Register bpf_task_park() for
 syscall programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <32ccc244a112dffbd5ad415cc1b2a652eb344c24.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
 <32ccc244a112dffbd5ad415cc1b2a652eb344c24.1794269506.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:21:51 +0000
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
- [High] bpf: bpf_ringbuf_reserve() pointer survives bpf_task_park() in
  syscall progs
--

commit c4eaca6570d5d9a8cfe67e1f147cbdfe38386018
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Register bpf_task_park() for syscall programs

This commit registers bpf_task_park() as a sleepable kfunc for
BPF_PROG_TYPE_SYSCALL programs and documents in bpf_prog_run_pin_on_cpu()
that syscall programs may migrate across a sleep in bpf_task_park().

> diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
> index 5043ccdfc0b8d..0e3d7f3ec597e 100644
> --- a/kernel/bpf/task_park.c
> +++ b/kernel/bpf/task_park.c
> @@ -276,3 +276,18 @@ __bpf_kfunc int bpf_task_wake(struct task_struct *ta=
sk, u64 flags)
>  }
> =20
>  __bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_task_park_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_task_park, KF_SLEEPABLE)
> +BTF_KFUNCS_END(bpf_task_park_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_task_park_kfunc_set =3D {
> +	.owner =3D THIS_MODULE,
> +	.set =3D &bpf_task_park_kfunc_ids,
> +};
> +
> +static int __init bpf_task_park_kfunc_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_=
kfunc_set);
> +}
> +late_initcall(bpf_task_park_kfunc_init);

[Severity: High]
Can a BPF_PROG_TYPE_SYSCALL program hold a bpf_ringbuf_reserve() reservation
across bpf_task_park() and trigger a use-after-free when the ringbuf is an
inner map?

While check_park_stack_objects() rejects live STACK_DYNPTR slots (such as a
reservation from bpf_ringbuf_reserve_dynptr()), bpf_ringbuf_reserve() retur=
ns
a PTR_TO_MEM | MEM_RINGBUF register with a reference state ID tracked in
env->cur_state->refs.  invalidate_regs_across_park() keeps any pointer back=
ed
by a reference state:

kernel/bpf/verifier.c:invalidate_regs_across_park() {
	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, 1 << ST=
ACK_SPILL, ({
		...
		if ((reg->id && find_reference_state(env->cur_state, reg->id)) ||
		    (reg->parent_id && find_reference_state(env->cur_state, reg->parent_i=
d)))
			continue;
}

However, bpf_ringbuf_reserve() only sets BPF_RINGBUF_BUSY_BIT on the record
header and does not take a reference on the underlying bpf_ringbuf_map.  Wh=
en
the reservation comes from an inner BPF_MAP_TYPE_RINGBUF map looked up from=
 a
map-in-map container, only the Tasks Trace RCU read-side critical section
keeps the inner map alive.  When bpf_task_park() drops rcu_read_unlock_trac=
e()
and sleeps, the inner map can be deleted from the outer map and freed via
bpf_ringbuf_free() -> vunmap() once the grace period completes.  After
bpf_task_park() returns, the program still holds the valid MEM_RINGBUF
pointer and must pass it to bpf_ringbuf_submit() or bpf_ringbuf_discard(),
touching unmapped memory.  Even on a direct ringbuf map, parking with an
uncommitted reservation leaves BPF_RINGBUF_BUSY_BIT set across an unbounded
sleep, stalling ringbuf consumers.

Should the verifier refuse bpf_task_park() when any MEM_RINGBUF reservation
is live, just as it does for STACK_DYNPTR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794269506.gi=
t.memxor@gmail.com?part=3D8
