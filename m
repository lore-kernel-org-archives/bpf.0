Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175748;
	b=ir3r1BKfry2+MfM4eV4gmFoPd1YjwNiiJaiqMD2cCFMOy8ZdLy7Wpyw7a/O/gjQPExwc
	 03bn/jV0OKxvhtQX/HfiDPo1+IymyABYzLX8n+/1/1FwrhgBYQRRC7kBcD1j8yc6ez9Xs
	 xmJQS4Mab7H6LkJpOlqXA8PznKoj6t2u12mhsoliL/iPRUhgmf27P6TGBALhFUy0pHyAm
	 clTr9qoAs+T6HR+XZvBwEH6xIptnP1RK6C7s/P0bajVK5ImSFBAfZsS71guxf62gTwq3o
	 xf3MmAMGja+9n/buxsc7lcXMsqDRNgZKYBQT2/HU6EFGqVtv1AvxMH6k2GayT4IDvyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175748;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=BP5+WlvxrTKU6hiKqjIOOi3MvZWKHudxGdgdPv5XEGg=;
	b=pBFdupoqlpkoc6Ts0eB2SkZ8+bBKFrFLVSl+yaUMN3oBHPcTzSOXJ0xr4ZKUs2lPc7TP
	 i2tjsa0rdPjCqhT0t7ViLCxSQgTAIp1BnWLHkF6kbxQQJYzHRKCJn19xE213ABDo1sMjC
	 iXPaAAs5Bs/VsZ2csl4mI52K7LoLno6iBjfOPZKIm7jJfpf18lNTlPKNTKN3ipAqViXou
	 Fq9nDWlzLBXUZIehcddwasNRvoyeKwIxJm8LkS31aNyR2qKFXwR1GrZ1OrvFIcJfpxgVH
	 ZG5AplXsupnHWBvs67c6yBkzjr2vmestzaRdD3WEN00SCm1tqqGq2wDWu/a0J3LLAYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1nnDf39;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15541606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1nnDf39
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432451F01825;
	Wed, 28 Oct 2026 08:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793175747;
	bh=BP5+WlvxrTKU6hiKqjIOOi3MvZWKHudxGdgdPv5XEGg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c1nnDf39p/j0L36zUvNEzqNEOHjx+9k4i17LYj6cKBVJzAlvs4AZpLi62E4Gg0sVg
	 H5BgkvcIv6hvNe4SnK2ilvI8hDrzyRthavodASmXbhbGFmokLOagHWAFxqUdMu/ACn
	 GdYO7AWrwCTXvlJI2pUf8sYv4/lZG/s90AtHLNW7rIxYuu0q6CAF+Blvx0PaQ1Y3oI
	 rMzXqUWnyW/rcw+cCg9vRuodxo/6J9tsh+goKBqt9GLWVYrAQpWYLQjB6mTfwhc4SC
	 xBxzcBAr1VtupHQw3mlUFv3NJn8vPPSFZRJ5On9njX4A286xoPSiAEkjPcYKmSdkc2
	 R3VYq1NgG4WHw==
Content-Type: multipart/mixed; boundary="===============0969989892149286352=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <07845356d60195f2f1895ebd0e49cb3c62aabbac22189229e0f1a99ff77fe122@mail.kernel.org>
In-Reply-To: <20261028073525.1035605-3-luyun_611@163.com>
References: <20261028073525.1035605-3-luyun_611@163.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check task work scheduling on
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,bpf@vger.kernel.org
Cc: luyun@kylinos.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,yatsenko@meta.com,shuah@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 08:22:27 +0000 (UTC)

--===============0969989892149286352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Check task work scheduling on

TL;DR: Commit message only: the subject line "selftests/bpf: Check task work
scheduling on" seems truncated, ending on a preposition; a word like "retired
map elements" may be missing.

>     selftests/bpf: Check task work scheduling on
>
>     Keep a map value pointer across deletion or non-preallocated HASH
>     replacement in a syscall program, then require scheduling through the old
>     pointer to return -ENOENT. Run both TWA_RESUME and TWA_SIGNAL cases for
>     HASH deletion, RHASH deletion and HASH replacement.
>
>     [ ... ]
>
>     Signed-off-by: Yun Lu <luyun@kylinos.cn>

This isn't a bug, but the subject line ends on a preposition: "Check task
work scheduling on".  Is a word missing at the end?

The body begins a new paragraph right after it, so the object of "on" seems
to have been dropped.  Could the subject be completed, for example:

  selftests/bpf: Check task work scheduling on retired map elements


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40653588750
--===============0969989892149286352==--
