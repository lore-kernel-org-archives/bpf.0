Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742385;
	b=4iMWIEK9jbsGMo9dcy95aD4S74A2e3vGK3ppGEKxNHBL6jcyl2lpYMMxmTrpJnhawMT3
	 5IMe92OVWMdYle03dYyzMTIcYMO4QqO1uJWSjj2cBuCvMJ7VJMQyVqJM5H6kF1FkWQCYo
	 Bu6bjQhEcsbNvW5GU9GWdN+cDiMKBlZs8MJhwwJNSkLX/ZhmIcA88aqzCRp6x+e+QntbM
	 wQAN8OVuI6+Zqz4jKkXeqBDZBsBFemljiWF5tbbm5tgH2cK5S8Mt+W0phcgTONHArLc/C
	 smZfdtEr92j7cGQynoArjYylNmkADsvTKAfF6n9LdcqswjkyXdX0i4FROhpRiTyxNCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nmAzxYc0aaIxZbSoaldSWYoepC0sg2bgfVwNICekNC8=;
	b=vDRYhKM+O7CPJsfQVvUDbYj4u708iZoPeqvu+RfSA2Y4KJk6uZ3/ZHT3/QQXscIcrR2/
	 XTcMtAqkEjm8vB1CI96Dw9KZ7VHAhSxas310HBNag5jmiK/tEJSp+2O7glDhixRGZXuVK
	 VZ2T2/omUP1ho34s7uo457DDkYbYoEl/n7JAgz1P/J22yStN80He5PnT3QjEA2IM5bVTx
	 EmoHZTMk1+wWR1szZGzehCebASHybN0v7KQhk+l9bEUybS1Ud9pV8FViJgKP1q9PaJbUx
	 6gWeDrV0WNYezCNB3rNgAaltOVH9OgPT4G/0GbotyWBlVe3y7t4cx4pInP61/DFqVvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzYE3I2t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B9606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzYE3I2t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3FD1F01825;
	Fri, 23 Oct 2026 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742385;
	bh=nmAzxYc0aaIxZbSoaldSWYoepC0sg2bgfVwNICekNC8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LzYE3I2tlbr0PsTV2SttuHoboumFrIxJaDb/eQNeidDYgATWz8gAIfES1Sx8ApOSv
	 mSDsl2EsWpRHh3gkVDghjdlKQX7tSyVkjM2b5DYfDSeDCjJvhnM9vTzlf9LbZLFkO6
	 32v7eLjXMP+Q8ThyLKdxRft6igIrYvzOnl6PP8jzRQcjGXH58cLMP/dnJMY64NI0HB
	 oDwDak9iqRLFiKAUiCM1MItU/XneCA2/M0KLoXDLF2bSxtVFpAhEUXzDktbpfUHziq
	 6kY07P0O3L8jpDxUaVpZV00zpJaaIPAdjaQ1rRGcRUaBfGOJUrgRY6KEDEctlQlFC9
	 cEOH72U8yl71Q==
Message-ID: <sashiko-outbox-182466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] xsk: validate consumer ring producer index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
References: <cover.1792654486.git.zhilinz@nebusec.ai>
 <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:59:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] xsk: unbounded re-peek loop in __xp_alloc() despite __xskq_cons_pe=
ek() check
--

commit b1eb51f9c983fb773e7eaf99ed508d1895d9b804
Author: Zhiling Zou <zhilinz@nebusec.ai>

xsk: validate consumer ring producer index

This commit adds a bounds check in __xskq_cons_peek() to clamp q->cached_pr=
od
to q->cached_cons when the producer-consumer distance exceeds q->nentries,
aiming to bound the consumer loop in __xp_alloc() to the ring size.

Link: https://bugtracker.nebusec.ai/f/13760

> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1bc42c8902f4b..315b656534749 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue =
*q)
>  {
>  	/* Refresh the local pointer */
>  	q->cached_prod =3D smp_load_acquire(&q->ring->producer);  /* C, matches=
 B */
> +	/* A malformed producer must not make us consume beyond the ring. */
> +	if (q->cached_prod - q->cached_cons > q->nentries)
> +		q->cached_prod =3D q->cached_cons;
>  }
> =20
>  static inline void xskq_cons_get_entries(struct xsk_queue *q)

[Severity: High]
Does this check in __xskq_cons_peek() actually bound the loop in __xp_alloc=
()
to at most q->nentries descriptors?

In net/xdp/xsk_buff_pool.c:__xp_alloc(), invalid fill descriptors are consu=
med
in an unbounded loop that calls xskq_cons_peek_addr_unchecked() on every
iteration:

net/xdp/xsk_buff_pool.c:__xp_alloc() {
	for (;;) {
		if (!xskq_cons_peek_addr_unchecked(pool->fq, &addr)) {
			pool->fq->queue_empty_descs++;
			return NULL;
		}

		ok =3D pool->unaligned ? xp_check_unaligned(pool, &addr) :
		     xp_check_aligned(pool, &addr);
		if (!ok) {
			pool->fq->invalid_descs++;
			xskq_cons_release(pool->fq);
			continue;
		}
		break;
	}
}

Whenever pool->fq->cached_cons catches up to pool->fq->cached_prod after
consuming a batch of invalid descriptors, the next iteration of the loop do=
es
not terminate. Instead, xskq_cons_peek_addr_unchecked() in
net/xdp/xsk_queue.h calls xskq_cons_get_entries():

net/xdp/xsk_queue.h:xskq_cons_peek_addr_unchecked() {
	if (q->cached_prod =3D=3D q->cached_cons)
		xskq_cons_get_entries(q);
	return xskq_cons_read_addr_unchecked(q, addr);
}

xskq_cons_get_entries() then calls __xskq_cons_release() to publish the new=
ly
advanced q->cached_cons to the user-mapped q->ring->consumer, followed by
__xskq_cons_peek() to reload q->cached_prod from q->ring->producer and
validate it against the updated q->cached_cons.

Because __xskq_cons_peek() re-evaluates q->cached_prod - q->cached_cons >
q->nentries relative to the newly advanced q->cached_cons on each reload, t=
wo
cases can still exceed q->nentries in a single __xp_alloc() call:

1. On a one-entry ring (q->nentries =3D=3D 1) containing an invalid descrip=
tor
address, a concurrent userspace thread updating q->ring->producer in the
mmap'd fill ring as q->ring->consumer advances (for example keeping
q->ring->producer equal to q->ring->consumer + 1) satisfies
q->cached_prod - q->cached_cons <=3D q->nentries on every re-peek in
xskq_cons_get_entries(), keeping the kernel in the __xp_alloc() loop
indefinitely in receive context.

2. Even without concurrent updates during __xp_alloc(), if k > 0 entries are
already cached on entry to __xp_alloc() (q->cached_prod - q->cached_cons =
=3D=3D k)
and userspace has written q->ring->producer =3D q->ring->consumer + k +
q->nentries, __xp_alloc() first consumes the k cached invalid descriptors
until q->cached_cons reaches q->cached_prod. Then xskq_cons_get_entries()
advances q->ring->consumer by k and reloads q->ring->producer, where the
remaining distance is now q->nentries <=3D q->nentries, causing __xp_alloc(=
) to
consume an additional q->nentries descriptors.

Should __xp_alloc() also bound the number of iterations or avoid re-fetching
new batches via xskq_cons_get_entries() once the initial batch of descripto=
rs
has been exhausted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792654486.gi=
t.zhilinz@nebusec.ai?part=3D1
