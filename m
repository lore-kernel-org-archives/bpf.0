Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194225;
	b=Dg950wX6ciflQnEPap5RazD9GKaZ90ncxrx1q3dHX8DI6/xf4TDRD3loJgerNPhmvlB/
	 bqP1KgVVY0RtdzZS4YSoL2kQwXqrJivTLqXMdN28GaOCIX/xjH4glnmotGIky2v0Miqoa
	 GhREeA0bQIxDg+3vH5vArQ1eQrHsMHFloRC0WXMNuhtqfr85lBtTFh1/slUMv0xNls8I9
	 O4YeMMQ48CY+288fK/X4+MemgF7l87uP071F1RZV4lT6vvtMytxg76azSxsC+Q7XSHh6v
	 Kg6uEmXEcANBL0+QrhDqGzWK/6xDFeISKzcmRrflrwKmDDVDQ8ucvpT9FdTYWVm1NVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DgTEEIFLY7nWLKEAMoc3pzJDvyvQPGfrshFyaeQXNwA=;
	b=vbVBEdNLPNsYEC9B1oZFvLKIXGCSO+snslpLeSnlxKemnSknT4RFX7FwowetnDGeoTTt
	 zhFE7gnMqcH+bn/bicUy2qah+ceYUQAj/6pCxLflJZM0luzrA/eBjqLs/Hs8TPictM/Q2
	 vILroomdpq6w3hd5jyVsNNreUHAvK6716Hqm4Hny0/wHV2Q5O2L74Gn5fetcMmOEpWXHC
	 G77PjCXraeuYVeViq/lvH32bPYBkwFLbfEwt6JuGjqQ+mTTHnMD89wk7zL65B6UsuPAQJ
	 9rINKulECIjXUEjR5qxlY79Y6lmSd/FouYPKfq72uGw95ZZSmarBjM5I/mVq3y9MHuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqKkD11j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2E606A320
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqKkD11j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDB01F008A2;
	Mon,  9 Nov 2026 03:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794194225;
	bh=DgTEEIFLY7nWLKEAMoc3pzJDvyvQPGfrshFyaeQXNwA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nqKkD11j+o8Lh3gIiClz6Mq44CzgTeLNNgddhjc2BBOkNMZ8LiYphlBxL1dcUE6iw
	 Zo4YKpGbMHHFagXGH8w78s7dHfZGA6yRAjyMlY+PUoKATrPKVrBPQK0cb6JF1PCecQ
	 h6siV2S2H/uzBnSGGQdhDtZ6TpGVk1zHuduaMGIoXlIela/53g3UnxtuN67k4lXgZg
	 XDiTOvtrzmHj1gu7iGiIqQlbu6o8riV4g2CB4+5T5xuneOfOWOfqEgG/+fDZ4LRx90
	 vh9kSf1hmf4d17CMbmZo6Iq3VSPrZY4y2aFiszOEiX4jjLdaXWvTyjfPKMGybRCNE6
	 WYG4cqguA8ezQ==
Message-ID: <sashiko-outbox-204366@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Reject user ringbuf backlogs larger than
 total ring size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <ecf1a73cac8881d58b0b5957fb72caaeaa055339.1793951856.git.rakukuip@gmail.com>
References: <cover.1793951856.git.rakukuip@gmail.com>
 <ecf1a73cac8881d58b0b5957fb72caaeaa055339.1793951856.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:17:04 +0000
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
- [Medium] bpf: early backlog check in __bpf_user_ringbuf_peek() breaks
  -E2BIG return
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] bpf: compat mode ring buffer hang in __bpf_user_ringbuf_peek()
  [1]
--

commit c14bce3c5f895ee2ea691c51e1942bac34af6108
Author: Luxiao Xu <rakukuip@gmail.com>

bpf: Reject user ringbuf backlogs larger than total ring size

This commit rejects user ring buffer drain operations with -EINVAL when
the unread window between producer_pos and consumer_pos exceeds the total
data size of the ring buffer.

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 447863ece26a3..cfd4fe4e85ee6 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -761,6 +761,9 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf=
 *rb, void **sample, u32 *s
>  	if (cons_pos >=3D prod_pos)
>  		return -ENODATA;

[Severity: High]
This problem wasn't introduced by this patch, but can cons_pos >=3D prod_pos
permanently stall sample processing for a 32-bit compat user-space
producer on a 64-bit kernel [1]?

A 32-bit compat application updates rb->producer_pos with a 32-bit store
that wraps to zero at 4 GB, while the 64-bit kernel increments
rb->consumer_pos past 4 GB using 64-bit arithmetic.  Once producer_pos
wraps, cons_pos >=3D prod_pos evaluates to true and __bpf_user_ringbuf_peek=
()
returns -ENODATA on every subsequent drain.

> =20
> +	if (prod_pos - cons_pos > ringbuf_total_data_sz(rb))
> +		return -EINVAL;

[Severity: Medium]
Does checking prod_pos - cons_pos > ringbuf_total_data_sz(rb) here break
the -E2BIG return for a single oversized sample?

Later in __bpf_user_ringbuf_peek(), total_len is checked against both
prod_pos - cons_pos and ringbuf_total_data_sz(rb):

kernel/bpf/ringbuf.c:__bpf_user_ringbuf_peek() {
	...
	/* The sample must fit within the region advertised by the producer positi=
on. */
	if (total_len > prod_pos - cons_pos)
		return -EINVAL;

	/* The sample must fit within the data region of the ring buffer. */
	if (total_len > ringbuf_total_data_sz(rb))
		return -E2BIG;
	...
}

Because prod_pos - cons_pos <=3D ringbuf_total_data_sz(rb) and
total_len <=3D prod_pos - cons_pos are already enforced before reaching
total_len > ringbuf_total_data_sz(rb), the -E2BIG branch becomes
unreachable.  When user space publishes a single sample larger than the
ring buffer (setting producer_pos to at least ringbuf_total_data_sz(rb) +
BPF_RINGBUF_HDR_SZ), bpf_user_ringbuf_drain() now returns -EINVAL instead
of the -E2BIG documented in include/uapi/linux/bpf.h and expected by
test_user_ringbuf_post_larger_than_ringbuf_sz() in
tools/testing/selftests/bpf/prog_tests/user_ringbuf.c.

[1] https://sashiko.dev/#/bug/linux-262d24f9-bac4-4511-aaed-6698163eb6f5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793951856.gi=
t.rakukuip@gmail.com?part=3D1
