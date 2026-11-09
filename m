Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251138;
	b=ni4OsIM/CG1dGrzzf0USJZo8ojHM/yAcXGgIOKsSKCwzjFsY+1+IQ/8tNzR3JRwORubF
	 ZZD4i23wTbQ91/TytMd/wynq0RDOpDbrrdNIPhaOJV4a7fj0W7zJXOv0X6da9pxdL7jTx
	 itTmduSBkVw/qcvGDXdsXTFCAmj9vktu6T6ndm71wKn7D9KtR+IlmCpLspp0wYGgU65M/
	 Xo23GFeXEoaGQn7bUTgh7OAhx6m8CY8NhhdbuMIvS91+eoJvOdpFo1a0vtS+ke9BM3JPw
	 VdF76X0nImkgEZgNL7r7N8qNoA/HHxYhIwf0jbI45vK7BMWqAYwSvt80RA+G3WqMcCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251138;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NGXp0Jv/R75xLXNUhcfASnQ7SVLznWIk6jAR4hAERu0=;
	b=qvlqVcXZ6gNqv7EcRQy3ZpO5nRi0yICY+YRo8Pj9kKhkxjCNKkNWYpLdhdPUWBR7Q166
	 B6we8m0aESPJusMgLrSwcE6pmiO5jEuEdfLJETQEdH07EafF5t0gG8PFVEPZAfRiAVYEE
	 3TFPu1DaniHxDKbrfNOcZYQZ2IfMSLK9RCuLAcGJb7d8NllCLyAsEDDj0mhpq++Iev0WE
	 NDt8HMrssl5px47krKjaUFexTy7ffcsaOQBTuQJmdtsj/FZ3w91ZM/PMB3hnAChq9g/0T
	 ZFNc67xCPRHmfzCme7U/gyZC4fIfoG1w8ryxZKGWIoUgZc+BSo3ftFj3mIBCtRDQf+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id5t1+w+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F960A260D
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id5t1+w+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370241F0089F;
	Mon,  9 Nov 2026 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251138;
	bh=NGXp0Jv/R75xLXNUhcfASnQ7SVLznWIk6jAR4hAERu0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=id5t1+w+UTkQ07tQCloxqGKM7UNUtKcsFoyscsJMTod3HShvcqWx6its4dP135T5g
	 6hRwOhsCiX7c4dmqAztiJwVWWFhDlRQ2cIYLmb0x/gYr9Ci+HAr97upOTU1376rL+s
	 sdOaSSyF++v15I/Pt/HGJgMQb2L9xKvef6ubMKVnoa+m2BmX/B3ziHAQOvkd0CzyHp
	 qCLlmMcecPYAFgqXjbQgcrQpnStHszorJnFlqmFfGcI104CjZoCg8Hi6Fyg8M0pVZF
	 jmkJXSA0RQeILPkYJYx7Pt7jHjiB6IyWvwTjvppBBm2CcW1Abt8QwoSO8YqGHB71+G
	 8jG4zYYwoOyzw==
Content-Type: multipart/mixed; boundary="===============5703234952441941512=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3e1b58f40db74480c81dfd7dad54398d76742185fa68fa9160af5369d1e8785c@mail.kernel.org>
In-Reply-To: <20261109182055.7581-7-emil@etsalapatis.com>
References: <20261109182055.7581-7-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 6/9] selftests/bpf: libarena: Handle NMI reentrancy
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 19:05:38 +0000 (UTC)

--===============5703234952441941512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Handle NMI reentrancy

TL;DR: The prototype fix for buddy_alloc_memory() in this patch appears to
repair a build break introduced by the previous per-CPU caches commit, which
may break bisection; consider folding it into that commit.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -46,10 +47,14 @@ static int idx_is_allocated(struct buddy_chunk __arena *chunk, u64 idx, bool *al
>  static u64 arena_next_pow2(__u64 n);
>  static u64 size_to_order(size_t size);
>  static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
> -					int order, size_t norder);
> +					int order, size_t norder, bool grow);

This isn't a bug in the final tree, but this hunk appears to fix a build
break from the previous commit, b92c329df4ab ("selftests/bpf: libarena:
Add buddy per-CPU caches").  That commit added the forward declaration:

	static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
						int order, size_t norder);

while the definition takes five parameters:

	static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
			int order, size_t norder, bool grow)

Won't b92c329df4ab fail with "conflicting types for buddy_alloc_memory",
which breaks bisection?  The prototype change is unrelated to NMI
reentrancy and the commit message does not mention it.

Could it be folded into b92c329df4ab so that each commit in the series
builds on its own?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42676408513
--===============5703234952441941512==--
