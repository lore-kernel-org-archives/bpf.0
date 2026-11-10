Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286273;
	b=BbBG9nCmMfEdXPOMR0ZziL5u37Gtjp+bjY2v+PHnEjwNgdcs4BSMRg6bz3asBQ/f416L
	 B/d1dwkSeT9TGzc03AL8B5e3lM89oKA1pUGysbCTDLOu0JK1zCioOWINx0eDMQ0pSHyJf
	 g6jZtBFvChsJ4y9Ye7/eQB9PONUygeqFEuJbyOaX/3g3tOX5Qwzq112KuNf1oIsjocJJg
	 ubiGmT01OsY18Gae55wW02SZM/+XiSiQW4QyP9pASS7ogwNVbwFv/r7o23S/f3GqPCHvm
	 qsqWPPOgMumWZJsrgdtQPLHvI083+ub67GtDJZyFvLN1ewwti00s+i2cD3A78F0npPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286273;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qbTSDQArvOD3jGjg04T2wFGTvQcaHANFC2X8ZHcjKuE=;
	b=hSES6fJEMLIwsS3d+Tu4K5qgChbii0/Moyqhs33c0GUGVynTOo4zUrdPo1BCHmqtkIy2
	 r034gLE8MsmTHWd7jwIeVdJpsHqmxUQ0Ms1PAqfFBC6A1/iTyUOOBY+qlodY9EXRjvkLB
	 OSVC4IUXpOPDt2VQrmpNDiszahDfSSVAYqk8aB6FnUhkYmQBS0mZQ3OtwM3rXnXWHt5uV
	 LC0Ek3BfEvkMA6Z/vSmeHUnD6tJjrNjwiAzQ8jNG54FZbNMV8gkw6wfE3QhHMaPnnFtlS
	 H8Qt5KLxlUY5paJgd/koPJWu/wtPzvpiooykgzLl5C3jI03T62geYUVvWXpZ7HboSEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJ265U8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A2D606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJ265U8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B2C1F0089F;
	Tue, 10 Nov 2026 04:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286273;
	bh=qbTSDQArvOD3jGjg04T2wFGTvQcaHANFC2X8ZHcjKuE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nJ265U8IJy0a0l+jT63eGTKMM9Th9JPUC17685QMOud1MBaGQfIKHuZq01om1C+r6
	 6yI8xQt7FhZQlAd4szhklUTE4ccverPmM8erqj1LKQThwK8WJ/BP6+b3uatI/UOryL
	 024QQAc7p4MD2w10NQFmEMMsGIhN25djzK5i5+k0ZADSixUzs+HIBHEEO/7ZPBVseL
	 Mfami/UBxyCtYBeyGGEyk4+2naG5ML+11kYLkPZjvvSTnF+iKDisIjOvWP+lSFS5tD
	 24cEDb2IVCf+HcN7NVRsrZ0vpl+b07bWlawezGUP0yOU0ceiJjpoJtpdszgJxOvyqj
	 vwEu5Qp8t7McA==
Content-Type: multipart/mixed; boundary="===============6173208538127033609=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cb445da2a17f6123fc8e8b29c5cb8030424d521611d7ee6fbed73a90709c7eb7@mail.kernel.org>
In-Reply-To: <20261110003838.8739-3-emil@etsalapatis.com>
References: <20261110003838.8739-3-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 2/9] selftests/bpf: Add a parallel buddy allocator benchmark
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 10 Nov 2026 04:51:12 +0000 (UTC)

--===============6173208538127033609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add a parallel buddy allocator benchmark

TL;DR: Nit only: the cross-CPU benchmark's cmpxchg() retry loop could be a
single atomic exchange, and its "free our own list" fallback comment seems
wrong, since can_loop expiry would skip the free.

> diff --git a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
> --- a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c

[ ... ]

> +	/*
> +	 * Publish this list and take the one left by the previous invocation,
> +	 * usually allocated by a worker on another CPU. If the exchange does
> +	 * not complete, free our own list instead.
> +	 */
> +	old = READ_ONCE(bench_xfree_head);
> +	while (can_loop) {
> +		cur = cmpxchg(&bench_xfree_head, old, head);
> +		if (cur == old) {
> +			head = old;
> +			break;
> +		}
> +		old = cur;
> +	}
> +
> +	for (i = zero; head && can_loop; i++) {

This isn't a bug, but could this cmpxchg() retry loop be a single atomic
exchange, for example:

    head = __atomic_exchange_n(&bench_xfree_head, head, __ATOMIC_SEQ_CST);

The new value of bench_xfree_head does not depend on the old one, so the
loop always ends up storing head.

That would also drop the fallback path.  The comment says "free our own list
instead" if the exchange does not complete, but the loop only exits without
swapping once can_loop has expired.  At that point the following free loop,
"head && can_loop", is already false on its first check, so the list would
not be freed anyway.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42755638928
--===============6173208538127033609==--
