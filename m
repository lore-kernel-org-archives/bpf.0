Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024891;
	b=IgoT3G/Jq/QiVSw3t8PmEt2gdJoTp4jYc7hYxSJ0cVcsqaG+zLaAKzt5RVJHql3sDIFc
	 2S78zRVetPZEUkuac2n34n2zmLvsnEKFmaNeGFZBeXLIioguLGnJyAB+5SEmcmN8qiKwU
	 3PRCRD1mQ1yt7BGlN5G5EfMUqvP1tWavO3ZcUMvB9t6qbnmseX/0PgXiyKtB/JU5DXWcJ
	 3DYP3qpWb4C8i2iOIMSYKa0QZm65tWt6zZqMYdZ6c7PioGB6GUParBQW6H6d1Bedn/OkH
	 O5EqNDcb1kKlzO3vZdLNhslUuu4W+d0eOJwAEU+WxwsdVhoSAJVw/WBJLVQuVHp+lwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024891;
	h=Received:DKIM-Signature:From:To:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yoRAL1VdHDtmhri9kcaJF90SjTo1inDYchp3J27MFt0=;
	b=G9tjxdwu7uduGOq6SkYttZJ7T+XvV1fKpbCK7PZTLF5MlvKzkYptR0w5pUeIxNhoFNAN
	 Fkv9xdet/+vSPG1ymVvM9WtsUv3uTk+tQxOkLpu+Tb5dQG0KtZyPekKwPld6vmjvLfd2c
	 A9Lda+5IrU+/OHDOjva/g3m+zWhHvVcvD+W2kVCDeEQx1NQW27JSoVnAWL3xKrRsJl40G
	 gB3cpzvs5wPRTGsZNtnJC5hjOOGJOCkSNwickHDfzjupwnbRzWw2Om3nutBSNQWUJYazj
	 Qxh4qhIHDxC5Y3dJsUIxFtt7GAujVOWX/z3SEp4Qfe9wDodA7XfhT8NcYbmwPmY7L4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex7BSezQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07480606A31F;
	Mon, 26 Oct 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex7BSezQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6DC1F01825;
	Mon, 26 Oct 2026 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793024890;
	bh=yoRAL1VdHDtmhri9kcaJF90SjTo1inDYchp3J27MFt0=;
	h=From:To:Subject:In-Reply-To:References:Date;
	b=Ex7BSezQNQd93RpzBcXQvGnDsZfYKCJ9dp3U54YKrnpfmbeK8135MGYTVMEJSDLeg
	 SfMVX61hThT/NN1pjgIpI+6UC30yAcPGhvWa2BMH0CPqK/1xax6R6b5inwt54mc2o9
	 17v5U40rdAYLzgTxl589AlgVbh0DO1koBG5dFqU8LUgZCdzKpbpIJxnPD9mqdre6b5
	 IDlrSZpSR1jCLexjrEXUweKtj4h1MVY9zAEysZUZUSrPJPFfTfUMvvqfgQ1jzZz0Yx
	 ztn/4Ma7QcJgrc1az/XrB1ePZDzdcqRycqQw3pkVKswhZt8qGZIYpL8m3YXlkiVSVW
	 E9hz4BG+y6g0g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: sashiko-reviews@lists.linux.dev, Zhiling Zou <zhilinz@nebusec.ai>,
 bpf@vger.kernel.org
Subject: Re: [PATCH net 1/1] xsk: validate consumer ring producer index
In-Reply-To: <sashiko-outbox-182466@kernel.org>
References: <cover.1792654486.git.zhilinz@nebusec.ai>
 <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
 <sashiko-outbox-182466@kernel.org>
Date: Mon, 26 Oct 2026 15:28:07 +0100
Message-ID: <87y0bk5yfc.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] xsk: unbounded re-peek loop in __xp_alloc() despite __xskq_cons_=
peek() check
> --
>
> commit b1eb51f9c983fb773e7eaf99ed508d1895d9b804
> Author: Zhiling Zou <zhilinz@nebusec.ai>
>
> xsk: validate consumer ring producer index
>
> This commit adds a bounds check in __xskq_cons_peek() to clamp q->cached_=
prod
> to q->cached_cons when the producer-consumer distance exceeds q->nentries,
> aiming to bound the consumer loop in __xp_alloc() to the ring size.
>
> Link: https://bugtracker.nebusec.ai/f/13760
>
>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>> index 1bc42c8902f4b..315b656534749 100644
>> --- a/net/xdp/xsk_queue.h
>> +++ b/net/xdp/xsk_queue.h
>> @@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue=
 *q)
>>  {
>>  	/* Refresh the local pointer */
>>  	q->cached_prod =3D smp_load_acquire(&q->ring->producer);  /* C, matche=
s B */
>> +	/* A malformed producer must not make us consume beyond the ring. */
>> +	if (q->cached_prod - q->cached_cons > q->nentries)
>> +		q->cached_prod =3D q->cached_cons;
>>  }
>>=20=20
>>  static inline void xskq_cons_get_entries(struct xsk_queue *q)
>
> [Severity: High]
> Does this check in __xskq_cons_peek() actually bound the loop in __xp_all=
oc()
> to at most q->nentries descriptors?
>
> In net/xdp/xsk_buff_pool.c:__xp_alloc(), invalid fill descriptors are con=
sumed
> in an unbounded loop that calls xskq_cons_peek_addr_unchecked() on every
> iteration:
>
> net/xdp/xsk_buff_pool.c:__xp_alloc() {
> 	for (;;) {
> 		if (!xskq_cons_peek_addr_unchecked(pool->fq, &addr)) {
> 			pool->fq->queue_empty_descs++;
> 			return NULL;
> 		}
>
> 		ok =3D pool->unaligned ? xp_check_unaligned(pool, &addr) :
> 		     xp_check_aligned(pool, &addr);
> 		if (!ok) {
> 			pool->fq->invalid_descs++;
> 			xskq_cons_release(pool->fq);
> 			continue;
> 		}
> 		break;
> 	}
> }
>
> Whenever pool->fq->cached_cons catches up to pool->fq->cached_prod after
> consuming a batch of invalid descriptors, the next iteration of the loop =
does
> not terminate. Instead, xskq_cons_peek_addr_unchecked() in
> net/xdp/xsk_queue.h calls xskq_cons_get_entries():
>
> net/xdp/xsk_queue.h:xskq_cons_peek_addr_unchecked() {
> 	if (q->cached_prod =3D=3D q->cached_cons)
> 		xskq_cons_get_entries(q);
> 	return xskq_cons_read_addr_unchecked(q, addr);
> }
>
> xskq_cons_get_entries() then calls __xskq_cons_release() to publish the n=
ewly
> advanced q->cached_cons to the user-mapped q->ring->consumer, followed by
> __xskq_cons_peek() to reload q->cached_prod from q->ring->producer and
> validate it against the updated q->cached_cons.
>
> Because __xskq_cons_peek() re-evaluates q->cached_prod - q->cached_cons >
> q->nentries relative to the newly advanced q->cached_cons on each reload,=
 two
> cases can still exceed q->nentries in a single __xp_alloc() call:
>
> 1. On a one-entry ring (q->nentries =3D=3D 1) containing an invalid descr=
iptor
> address, a concurrent userspace thread updating q->ring->producer in the
> mmap'd fill ring as q->ring->consumer advances (for example keeping
> q->ring->producer equal to q->ring->consumer + 1) satisfies
> q->cached_prod - q->cached_cons <=3D q->nentries on every re-peek in
> xskq_cons_get_entries(), keeping the kernel in the __xp_alloc() loop
> indefinitely in receive context.
>
> 2. Even without concurrent updates during __xp_alloc(), if k > 0 entries =
are
> already cached on entry to __xp_alloc() (q->cached_prod - q->cached_cons =
=3D=3D k)
> and userspace has written q->ring->producer =3D q->ring->consumer + k +
> q->nentries, __xp_alloc() first consumes the k cached invalid descriptors
> until q->cached_cons reaches q->cached_prod. Then xskq_cons_get_entries()
> advances q->ring->consumer by k and reloads q->ring->producer, where the
> remaining distance is now q->nentries <=3D q->nentries, causing __xp_allo=
c() to
> consume an additional q->nentries descriptors.
>
> Should __xp_alloc() also bound the number of iterations or avoid re-fetch=
ing
> new batches via xskq_cons_get_entries() once the initial batch of descrip=
tors
> has been exhausted?

Sashiko has a point IMO (let's wait for the netdev-bot tho).

The simplest fix I can see, is changing "continue" in:

  |             if (!ok) {
  |                     pool->fq->invalid_descs++;
  |                     xskq_cons_release(pool->fq);
  |                     continue;
  |             }

to: "return NULL".


Bj=C3=B6rn
