Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792716599;
	b=BTVKp0CE8NFmXlfBqcJg0N4kGwyAtBBBX/mpWVNglOvgqGMbRUVVaH83ulvvfYnXz7pK
	 3h7wqtAhf9U1N+VoEOulZohoUXVoBymvQX1rQP7aRjzEAvBY0pX7Zf6mTi5/e9m2BrTD6
	 r2iMxINYQeJ/3FT8X7qYpaLydVUXCNcuuuRGm38spP/NsjBqWO9f/qYXw14BomFh/yQYU
	 fPrC1cK4Q6o6RSJi+zjIrPg+XWe4akRIwmlwmc7oppcNzNFKmMX67LVqHsdvcn+W0mMsz
	 CthEnSrn/F/kN6pQOiVycyKBjF0SvaQzrD4Hc2NR6JyVOmb4irbGyB7QhoDgoBglrjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792716599;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=OyPGXxQTK07leUUTEWv3FtUahk/j3VlM8EsNrAReYdc=;
	b=3/P9tbOexelaHAOkUSTjosGLZOL7IqkNkWcqX1PKRD45PsxCyIKifLg6R5I+xIypBalb
	 IdGvVB1i2jx5uNrT5fso2WlMpg5/v21dBk2akN/lt0DkmE2bF1ZDUR5NKggEI/14O0P/M
	 h48/TiR2eayg4JHUqwtmdGfJO5C8MsSAtGgL4S5S+pSD2mBYQaKnFuEXNmCbGcphU1FZc
	 9QIvhSDS/dEu6l58BXN8yvmW9p8G3wNxyR53W6ZHT8YRhi/goxcfEkhBSBzchMmIw4+0e
	 maP6qARoJNPPWj88dfczoWxGnqlum34hIeCa3E87KxlAYkH1K/aKZkGdONT7Q5iT7Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROk51pOy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E96606A319
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROk51pOy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BED1F01825;
	Fri, 23 Oct 2026 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792716599;
	bh=OyPGXxQTK07leUUTEWv3FtUahk/j3VlM8EsNrAReYdc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ROk51pOyh48ATgwpQnPGZCG6jeFNliMXf+ilPlF9C3efvXKGd4BHb3/Glh2aPb/rs
	 zH+gY9OnhFReeEp20Wxp5fjsvTIWF0U0byXf89KaD1nC29W5B5G9B1BqzdXttsodsP
	 D6DiyJi7pG2w3KGG3dp/29NLv2DK6aThcD3ozdN1kOU8iSaw6H0ufrP9uaYuV1F9Zp
	 gAUpxIc84kgEFFq1dDK/xn4MDC4bjU4WDXsRqQaPrbLVtxLXNE98Ve2QvZ22slTKX0
	 ljbaHrVYV2p2vEETDTc2MIvlyWwZXtF5ZYXuG1e4hRjhGQ66go7zECgJK98Usm9Z1O
	 JT2tRincKGifg==
Content-Type: multipart/mixed; boundary="===============5913348298292286630=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2505885ae9008dd9434da09a77cffdd2b84698c012a82c92018e5f0240390c04@mail.kernel.org>
In-Reply-To: <20261023002056.6647-4-emil@etsalapatis.com>
References: <20261023002056.6647-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 3/7] selftests/bpf: libarena: Add buddy per-CPU caches
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 23 Oct 2026 00:49:58 +0000 (UTC)

--===============5913348298292286630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Add buddy per-CPU caches

TL;DR: Commit message only: the claimed 1.5 KiB per-CPU cache bound seems to
cover just the metadata; cached objects could hold about 64 KiB per CPU
(roughly 64 MiB at 1024 CPUs), so the changelog should state that.

>     selftests/bpf: libarena: Add buddy per-CPU caches
>
>     Every small allocation currently reaches the central buddy allocator and
>     takes its lock. This serializes otherwise independent callers and touches
>     the buddy metadata on every allocation and free.
>
>     Add a fixed-size LIFO array for each cached order and CPU. Keep the
>     per-CPU cache pointers in struct buddy and allocate each CPU's packed
>     cache from the buddy during initialization. Cache the eight smallest
>     allocation orders, up to 2 KiB. Each array holds 16 objects, bounding each
>     CPU's cache to about 1.5 KiB.
>
>     Allocations pop from the local array and frees push onto it without taking
>     the buddy lock. Empty and full arrays fall through to the central buddy
>     allocator. Packed arrays keep the fast path to a bounds check and a single
>     slot access.
>
>     BPF programs only disable migration, so another task can preempt a cache
>     operation and run on the same CPU, and an IRQ or NMI program can interrupt
>     one. Claim the CPU with a cmpxchg on a per-CPU flag before touching its
>     arrays, following the model used by the main BPF memory allocator. An
>     operation that finds the CPU already claimed falls through to the central
>     buddy allocator.
>
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

The changelog says "Each array holds 16 objects, bounding each CPU's cache to
about 1.5 KiB."  Is that the bound on what a CPU's cache can hold, or only the
size of the slot arrays?

The 1.5 KiB figure matches the cache container.  struct buddy_cache_order is
136 bytes padded to 192 by __attribute__((aligned(64))), so
sizeof(struct buddy_cache) is 64 + 8 * 192 = 1600 bytes, and
buddy_cache_init() allocates it from the buddy as an order-7 (2 KiB) block per
CPU.

The objects held in the cache are bounded separately, by BUDDY_CACHE_CAPACITY
for each of the BUDDY_CACHE_NUM_ORDERS cached orders:

    elems = READ_ONCE(slots->elems);
    if (elems >= BUDDY_CACHE_CAPACITY)
        return -ENOMEM;

    WRITE_ONCE(slots->objects[elems], obj);

That allows up to 16 * (16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048) = 65280
bytes (about 64 KiB) of cached objects per CPU, plus the 2 KiB cache block,
which is roughly 40 times the figure in the changelog.  Cached objects stay
marked allocated in the chunk metadata, so they cannot be coalesced or handed
out to other CPUs.

With BUDDY_CACHE_MAX_CPUS = 1024 that is about 64 MiB of arena memory that can
sit in the per-CPU caches, plus 2 MiB of cache structures allocated up front
in buddy_init().  The comment on BUDDY_CACHE_NUM_ORDERS in buddy.h ("avoid
excessive memory consumption from the per-cpu lists") suggests retained memory
is the quantity being limited.  The later patches in this series leave
BUDDY_CACHE_CAPACITY at 16.

Could the changelog state the real bound on cached memory, or say that 1.5 KiB
is only the per-CPU metadata size?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39878206535
--===============5913348298292286630==--
