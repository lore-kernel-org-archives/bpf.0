Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522602;
	b=b7UgOOUViuIVqDAvwd2nYTVN7bPcUqtT09zHaKytoy9FIr9aVMLds0GF4RvmQJoiqxhG
	 WEAiht9CQH03tkNpv2S/wjd6oN97ey+Lw8PlXorKbNID9ahaPpM20Mno63paekS3r2fi7
	 uVIBzf07Vqcv4BfBKdJB9g1gSYDauo5A8oZPE0a09seRg9LV4EJwxJgjUQ7XOspR94DGf
	 qpwP5jSSU56KNbvtBamJgDB3YPItSMxVry2pQd+3mGYgRsPFi5WIFiQD/Yaka3BUpNfEq
	 agOxNqBgEZ4sMtAZLh+dITbZdieV7RFidwEPXNsnavsCGUHzP8v5o9eNF75TOtqz8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522602;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=MhKdPw+XmhisQpjiDbGQC393+rAdMDyNDIdH00vhLMY=;
	b=sR732RE3kje9K+yfhBfiM8YXgQ1bIUQcg6310/G1DSUzvlO+raO5HmJUUg8ako6G8idZ
	 l0LMm8TAqy4hnCtdhVNg/mAPQkuQgzeZvtVSpSCTiBn5+ia2rzYufPssuXODErviU603R
	 bjUOjjTiL7ezhFCbnIObKxepI855VOoY5HCtTMDv6DIB93WlMom54Dbk1+tMz8vG4V+sf
	 2Nn6ZSVzIzPoTGyUg1jIjguPlROGbD3ZNkzb+S8QQKiwgsYS6doSxyGVJfVrX8ZVHCxa+
	 Ki9BeH5nH69TTwi9lDUYobNg2GoO2qjCL3ZVNVb98HMaFy+cgWzcDm8yoQTYnqlYodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9XQAhWe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB362606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9XQAhWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB0A1F000C9;
	Tue, 20 Oct 2026 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522601;
	bh=MhKdPw+XmhisQpjiDbGQC393+rAdMDyNDIdH00vhLMY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y9XQAhWetpKaWLCSloGSJZ3fjOIAGU8CxHvz4ZQQT0GUAwlRtVNVueevTiBfpVXld
	 DsqXbIGDslrEbco4zn+11XxaPCXfZRPu6A7sXrdPkxjmiCmHoO2ulaoar8Z7W+KoKV
	 Elzg0ayu+kURA8+kifthuY3Xi/iMYdDJqzH7t4ryQ6r07OCXzt++UGgQ48mNP7w5cv
	 +iUzGIc3AKkomzYKmwHntFkna0HOkjYXC5ZR4Bw1hpYVe1HTPyAyCvbiG2eK0JX3TU
	 93XJGeYRY/yqNAaTD82PSx16G5zNo59onFTUzukOzkBduYy8QppbT7bC3F8G44vy8L
	 fOeKBYNdZgO+w==
Content-Type: multipart/mixed; boundary="===============8253444152336116371=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <afdab4818768eea5e8c37f1dcd78feb65f08c9f5f85234c59267f17fe5224d9b@mail.kernel.org>
In-Reply-To: <20261020181900.6755-5-emil@etsalapatis.com>
References: <20261020181900.6755-5-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 4/7] selftests/bpf: libarena: Handle NMI reentrancy
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 18:56:41 +0000 (UTC)

--===============8253444152336116371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Handle NMI reentrancy

TL;DR: Nits only: buddy_deferred_free_start() and
buddy_deferred_free_start_bulk() repeat the same cmpxchg push loop and
comment, which could share a helper; one comment is misplaced.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index ce05e3e58eba..85d670b8762b 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -1084,6 +1136,98 @@ static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
> [ ... ]
> +static void buddy_deferred_free_start(struct buddy __arena *buddy, void __arena *addr)
> +{
> +	void __arena *head;
> +	void __arena * __arena *new;
> +
> +	/*
> +	 * Make a linked list by chaining the allocations into a linked list.
> +	 * Possible because allocations are 16 bytes minimum and so fit a pointer.
> +	 */
> +	new = (void __arena * __arena *)addr;
> +	asan_unpoison(addr, sizeof(void *));
> +	do  {
> +		head = buddy->deferred_free;
> +		*new = head;
> +	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
> +			 head, (void __arena *)new) != head && can_loop);
> +}
> +
> +static void buddy_deferred_free_start_bulk(struct buddy __arena *buddy,
> +		 void __arena * __arena *addrs, size_t naddrs)
> +{
> +	void __arena *head, *first, *last, *addr;
> [ ... ]
> +	/*
> +	 * Make a linked list by chaining the allocations into a linked list.
> +	 * Possible because allocations are 16 bytes minimum and so fit a pointer.
> +	 */
> +	do  {
> +		head = buddy->deferred_free;
> +		*(void __arena * __arena *)last = head;
> +	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
> +			 head, first) != head && can_loop);
> +}

this isn't a bug, but could buddy_deferred_free_start() and
buddy_deferred_free_start_bulk() share a small helper that pushes a
pre-linked [first, last] segment onto buddy->deferred_free?

The cmpxchg push loop and the block comment above it are repeated word for
word in both functions, and buddy_deferred_free_start() is the bulk push with
first == last == addr.

In the bulk version, the comment "Make a linked list by chaining the
allocations into a linked list" also sits above the push onto
buddy->deferred_free, while the local list is actually built earlier under
"Create a linked list locally."


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39476260714
--===============8253444152336116371==--
