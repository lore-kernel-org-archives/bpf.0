Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464975;
	b=Mk4QGOsU7PJVT5OYZJUlRXdEBpFo0yjtL2TV7e6MRSG4g3c5dK0OxUj5Ayl4bMZJMBKs
	 s69Pu0vSWX3u9R39oF8T+crt15hDIaXm0y/k676+KCabydvlfDOQs3VhHbhL10hrcR9dF
	 8hcgdKgz3SFB0kGnXdCQovaqM9AvzYYvSERMQecuwzkbbnPU+2BgT4EsFeK56896SECfY
	 Orw/U+Pzf9T8TEzeEQHRMfwhk8ECsM9s9UsfYQUxUdqjUgKIKoLYemoEF64wnggdL5GJO
	 8uMbIrNIdzmxRprNl8fJe/6yx8xVXikHXwq08r/P30MVWJMPqfuWyAueaazPcV+8Ckw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I1yUW1Wdar1v9zc4Tu2W3fkRElwEYTVSqvrOmTSUADc=;
	b=33hwMW+61GrDL7lkqEVhaNVOO22NdGlztVLn19uP+l/G4k4G3zTwgir/+SYZmKvu+Jfc
	 ohbDx+alVKL+b1SWobKtJibgTYimRTw+YTkmCNEvm9G01uszteEc2VsWadS0nCmGgozug
	 L28xrrNpwY5tRQwBewsKD4s2lCcPqmNWHiaA1KQC8v/Vp7LDhORtReQroSRx4GEvCuVal
	 zSzWHqAxGWSFOaDWkjUiQ6AgcDS6XFjw+ifL1wGguLiTW6CyGNjmrrnNsN1HPxFTKeU2G
	 lvwp44NvQlLTomSICOtyuPFjAlrKTy6kZwjgZipxGAO3g9GU03by9Qpz5X7fnEOFrsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bpdsaq5q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E51606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bpdsaq5q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA371F000C4;
	Mon, 23 Nov 2026 20:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464974;
	bh=I1yUW1Wdar1v9zc4Tu2W3fkRElwEYTVSqvrOmTSUADc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Bpdsaq5qir2DWeHNMr+b26njsifwWpk2jcnbvxm+lmXuJgTHORjNfqu53aRJ3umZh
	 WGebSrYF2EEKKljaRVGBaUL5+riN55jCT191lHG3HrPUjwjTsV9Mv0cJqimgonTkAs
	 rE4WkNRvlEXMuEg6Fq0R25T0Ryy+owx160Z3a/N0klpZOvcp5lLdVKIUSt0rYbrTns
	 GLfqol4IPrE3vOQHQInQRbpNsXt5rSFQqlcXzt4f7a4l+R6FnGZN5voHKrHV5ZRmhB
	 EwDP7LM77UPYizWy3+gJQuTVdfOiZ0I3sGGiykyaKdYg+OumwVh9OfeJ/P041UO5pH
	 1I4zzuJtnLKdA==
Message-ID: <sashiko-outbox-229982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: net_sched: Let bpf_kfree_skb() run with
 irqs off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <a2d4276cbf11b1254aa7997874a6539d20f296cf.1795463894.git.memxor@gmail.com>
References: <a2d4276cbf11b1254aa7997874a6539d20f296cf.1795463894.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 20:16:14 +0000
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
- [Medium] bpf: net_sched: bpf_kfree_skb() calls kfree_skb_reason() when
  non-preemptible
--

commit b478044d031a8f9f97373bdfc829434fc4dd56c2
Author: Alexei Starovoitov <ast@kernel.org>

bpf: net_sched: Let bpf_kfree_skb() run with irqs off

This commit switches bpf_kfree_skb() from kfree_skb() to
dev_kfree_skb_any() so that skb kptr destructors can run when interrupts
are disabled.

> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index 5691c13781a8b..e041383a848f2 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -196,10 +196,13 @@ __bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *sk=
b)
> =20
>  /* bpf_kfree_skb - Release an skb's reference and drop it immediately.
>   * @skb: The skb whose reference to be released and dropped.
> + *
> + * Also the destructor of an skb kptr, which runs wherever an object or =
a map
> + * value with such a field is freed: under a bpf_spin_lock too, with irq=
s off.
>   */
>  __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
>  {
> -	kfree_skb(skb);
> +	dev_kfree_skb_any(skb);
>  }

[Severity: Medium]
Can bpf_kfree_skb() still call kfree_skb_reason() while preemption is
disabled with interrupts enabled?

dev_kfree_skb_any_reason() only defers freeing when in_hardirq() ||
irqs_disabled().  A BPF list or rbtree can be protected by
bpf_res_spin_lock, which disables preemption and acquires a raw
rqspinlock_t without disabling interrupts (unlike bpf_spin_lock or
bpf_res_spin_lock_irqsave).  If bpf_list_add() fails while holding
bpf_res_spin_lock, __bpf_list_add() drops the node and invokes
bpf_kfree_skb_dtor() -> bpf_kfree_skb() with preemption disabled and IRQs
enabled (or a program can call bpf_kfree_skb() inside a
bpf_preempt_disable() section).

dev_kfree_skb_any() then takes the synchronous kfree_skb_reason() path,
which on PREEMPT_RT can acquire sleeping locks (spinlock_t or local_lock)
inside the skb destructor or allocator while non-preemptible and holding
a raw spinlock.  On non-PREEMPT_RT, if bpf_res_spin_lock() is taken in
process context, an skb destructor doing local_bh_enable() can also run
pending softirqs under the raw rqspinlock_t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a2d4276cbf11b1254aa=
7997874a6539d20f296cf.1795463894.git.memxor@gmail.com?part=3D1
