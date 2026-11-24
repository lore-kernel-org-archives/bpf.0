Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502447;
	b=O6dAubE4fv9vnwmBiV9yebLoRKNmnf4yxB62xqBx9M1kqv6iCT854LumhvjJtkCYqKx6
	 KA0/mVoq9/k/ZzLoNa5DrrJjNKcotnXerMTzOh6s6tXULtR+2+04hpzFj/HNNo5OcyTtb
	 rWTk3NlJPQtxXKjSguLcZRkE+/bnl3ABwyF1zHU6SXC2JIuwBjnjbRbOTMfYYsUmaeXtR
	 AInecCoeyySCht66IddMXcAxKt5ADGlLMDvuAKuSG+dziUqRz5UbHSa6HsCWdEGq5HVMo
	 WYl5b2WqCnpP0gX3nQWZvhd6kmn1Gw+6JxkY/k2tzldHBsrf2aNKVXWtTEUn4BjHZfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502447;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ix10EPurMP9nTUTWxPxsWj9Pt6bfZAmxBCz9Chwa4IA=;
	b=HjdSuOJuHP0BUAGzGQjsEE4C1KRU6+N4+COFkycoDmYoEBYatcC0Al8fXTcubKpu5vna
	 H+Vkzxk2J2muADKgtI6ig+u4RBej8StGl7Li26CxYx2qOY3tbjpb4fOJfWqPh9h96405A
	 /XMt8Gl1toQmyZXXXLHh4TPz+4hXyuM2Rg1EHcIqz5p9KZ/7e8383HpZ5r/LoeO0uMTKP
	 DMu6VVq5nZpKpJeP0BFLeR9xPnXJiars/4+u+IW9pFmUagMLUIko3VI7JSO3lKeMFNRv7
	 ILG0VIo6jgiqSRwzwxqEiwXShsOU78p1r5qwpsNMSFKuQYLKj0DZ74l7iNKbThsQVQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYyX2SIN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04628606A32C
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYyX2SIN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2341F000C6;
	Tue, 24 Nov 2026 06:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795502446;
	bh=ix10EPurMP9nTUTWxPxsWj9Pt6bfZAmxBCz9Chwa4IA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BYyX2SINveEgQLl0E08yaqQ+rECqExJrGrMXg0SYFGh4V+DSASUt0QzF5f/PSqq9f
	 y4v8HryIwUAgGrUzpKQQa+BxJNdgIlUNiOrK4IVIc9S921E+oj3zPuwnpdV5BEeZRW
	 HQB8jcolX3ei+htu9WSn5dxicGSQbojyL+Hquq6SnOBjJZhRudLe2yy9RlXlqT4j8e
	 Nfz1PnACHN3Ag0UqltGBq5B9M5QDQMPWFH7fGJWDiV9b43C64tYV3dPzI42wkcexLg
	 XYMqy+b50TEMnls6yKJzOuk5OyjtfysxMQKSRN0NJc5Y9piAeE7DVBVhs+k743FmDT
	 aniKdsGLzpGJA==
Content-Type: multipart/mixed; boundary="===============4855473302756357577=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2a5c47baff2a0980ba271807cf9b4ba773c09a093f62aaf39cfd17cdd434a630@mail.kernel.org>
In-Reply-To: <20261124060357.11700-4-emil@etsalapatis.com>
References: <20261124060357.11700-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Add sleepable local storage
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 06:40:44 +0000 (UTC)

--===============4855473302756357577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add sleepable local storage

TL;DR: The new sleepable GFP_KERNEL | __GFP_RETRY_MAYFAIL local storage
allocation lacks __GFP_NOWARN, so under memory pressure it may print allocator
warnings and stack dumps on handled failures. Intentional?

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -69,6 +69,10 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
>  static void *bpf_local_storage_alloc_mem(struct bpf_local_storage_map *smap,
>  					size_t size, bool sleepable)
>  {
> +	if (sleepable)
> +		return bpf_map_kzalloc(&smap->map, size,
> +				       GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +

Should this mask also include __GFP_NOWARN?

A failure here is already handled: __bpf_selem_alloc() uncharges and
returns NULL, and bpf_*_storage_get() returns NULL to the program.
Without __GFP_NOWARN, a program creating local storage under memory
pressure can make the allocator print warnings (slab_out_of_memory()
and warn_alloc() with a stack dump).

The previous path did not warn, since bpf_map_kmalloc_maylock() ends up
using GFP_NOWAIT or kmalloc_nolock(), both of which imply __GFP_NOWARN.
The GFP_KERNEL path local storage had before 5063e7758899 ("bpf: Use
kmalloc_nolock() universally in local storage") passed
"gfp_flags | __GFP_NOWARN", and other GFP_KERNEL | __GFP_RETRY_MAYFAIL
allocations in kernel/bpf (arena.c, bpf_ringbuf_area_alloc(),
__bpf_map_area_alloc()) also add __GFP_NOWARN.

A sleepable program calling bpf_task_storage_get() with
BPF_LOCAL_STORAGE_GET_F_CREATE reaches this via
bpf_local_storage_update()->__bpf_selem_alloc()->
bpf_local_storage_alloc_mem().  Is the omission intentional?

>  	return bpf_map_kmalloc_maylock(&smap->map, size, __GFP_ZERO);
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45338923700
--===============4855473302756357577==--
