Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522600;
	b=u0jC0YYPF5IpGV6KD+m5BDwoXYIPCVm+Hinz2zQJ/Wl1YWu7JPFrWePuIDCYOyCB48tY
	 QjiSZgP/uG+zVgajsWy8YraQ2WgjTKwm4sygrH2z+XW5Btj81UeNEUDphos7OB9olftuV
	 WwyVURwjWuA60Llzim6gGJ8PExr3DrwGgBZRDbikSWay/kU7yRq5vhh1Eph4wySWLDXF8
	 v2Jif8AGDQzVfBvOnb7h6OhMVU7xQ3+VDf/KrxTY6O5V53s2UxyvcOl+/prdzs5gntuHM
	 yQY/1NvSaBAUe71NH9jRZnCBpDydKe/XKkXEH5lxXOhJHsuHpq3fI7qu/oq2DQ/QzDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522600;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=rnJwXZHb+gmTI9YLKOyGDV0gOC+ofF/NfHSmza4n6oc=;
	b=Kjf3fEr3c+Jjv+4qZf5Nmd2EXQ107F5bmLuK6oc2wYhodKr7uf/JiA6Ofs3PolTKstcQ
	 Ohgq45RLxKr8l+Ls3Yp944jzEr7gAuJK2c6jmgYGTy0iJLdYgBy1iK8eM0VWH95zbQ8Zg
	 pmxk59X27dRr8X2WeWODryoX80gNAq/ljdG93sggkkIUqgT+xXYsiWXlPqxeT4i/iInp7
	 dLYGFQnzkefKaKbbm8xfngzXL74fzsC4df1icai92XJYvaHOXcYFvcRVdusNY3jvoi8p+
	 5RMo1f0RTz4fE+CpLYCtrjLSnVqBY3wlMZXGCIJ+1DYQIVItDcxeOXcPZ0thoeFzg8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TV64sEDX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79216606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TV64sEDX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E761F000C9;
	Tue, 20 Oct 2026 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522600;
	bh=rnJwXZHb+gmTI9YLKOyGDV0gOC+ofF/NfHSmza4n6oc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TV64sEDXDy9FYZiWB2KHq94Qhg9b6i8YUiRBaKYRyvzoFZ9CWJnlP5QKA1nE0MMQg
	 lFZX3CfK8Y3XmNIGzJodbcYagwkakRan0MOrLlIP49L20t31+4J7pKEsuapQ5+nF7T
	 6Y7aSnb8iY39SH1E3E/Eu/zNduwboYVboEFLsVaj+4xAdUYxcI1m6Xt5rKkwfgcql7
	 w2s0FCTLPks15FdhRZfPOzVhnBw7EQVFj7elt3ll5DCW06pQUDqceuyBdvVoA47PjN
	 bjGN4pSbcHBp6dBnvRrNm4K6WRRIvjISg1dnWKPaaVg/0vNdE9nfqMNDt0uZzbb5S3
	 h4n67bOy5Gj0g==
Content-Type: multipart/mixed; boundary="===============4403528820858146149=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f0eee2adccaec9225578e20e2d5c821533aa49962e721a2607f1f1cd31b56be5@mail.kernel.org>
In-Reply-To: <20261020181900.6755-4-emil@etsalapatis.com>
References: <20261020181900.6755-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 3/7] selftests/bpf: libarena: Add buddy per-CPU caches
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 18:56:39 +0000 (UTC)

--===============4403528820858146149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Add buddy per-CPU caches

TL;DR:
- Per-CPU cache pop/push may race under preemption or IRQ, handing one object
  to two callers (fixed later in series)
- Changelog mentions nonexistent replaced magazines
- Macro with hidden return is a nit

>     selftests/bpf: libarena: Add buddy per-CPU caches
>
>     Every small allocation currently reaches the central buddy allocator and
>     takes its lock. This serializes otherwise independent callers and touches
>     the buddy metadata on every allocation and free.
>
>     Add a fixed-size LIFO array for each cached order and CPU. Embed the cache
>     state in struct buddy and allocate each CPU's packed cache from the buddy
>     during initialization. Cache the eight smallest allocation orders and
>     retain the aggregate capacity of the two magazines this replaces.
>
>     Allocations pop from the local array and frees push onto it without taking
>     the buddy lock. Empty and full arrays fall through to the central buddy
>     allocator. Packed arrays avoid linked-list traversal and separately
>     allocated magazine containers on the fast path.
>
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

The changelog says the new arrays "retain the aggregate capacity of the two
magazines this replaces" and avoid "separately allocated magazine
containers".  Is that wording accurate?

The parent tree has no magazine-based cache.  Looking at the parent's
tools/testing/selftests/bpf/libarena/src/buddy.bpf.c, there is no cache code
at all, and "git log -S magazine -- tools/testing/selftests/bpf/libarena"
finds no commits.  "git grep -i magazine" on HEAD~1, HEAD and 871a40830e46
also returns nothing.

This commit adds the first per-CPU cache rather than replacing anything, so
the sentence has nothing to refer to in git history.  Is it left over from an
earlier revision of the series?

That sentence is also the only stated reason for BUDDY_CACHE_CAPACITY =
BUDDY_CACHE_BATCH_SIZE * 2 in buddy_cache.h.  BUDDY_CACHE_BATCH_SIZE is not
used for any batch transfer until 3d2fe8494239 ("selftests/bpf: libarena:
Refill local caches in batches").

Could the changelog explain the capacity choice directly, and move the
history of earlier revisions below the --- line?

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index 72b9ea3ac7d5..ce05e3e58eba 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -38,18 +42,116 @@
>  * and their allocation state. It also includes the freelist
>  * heads for the allocation itself.
>  */

[ ... ]

> +/*
> + * Per-CPU caching is disabled in ASAN builds because its additional call-chain
> + * stack usage causes instrumented programs to exceed BPF's 512-byte stack limit.
> + */
> +#ifdef BPF_ARENA_ASAN
> +#define DISABLE_CACHE_IF_ASAN(...) do { return (__VA_ARGS__); } while (0)
> +#else
> +#define DISABLE_CACHE_IF_ASAN(...)
> +#endif
> +

This isn't a bug, but DISABLE_CACHE_IF_ASAN() hides a return inside a macro
that looks like a function call.  It is used as:

    DISABLE_CACHE_IF_ASAN(NULL);     in buddy_cache_alloc()
    DISABLE_CACHE_IF_ASAN(-EINVAL);  in buddy_cache_free()
    DISABLE_CACHE_IF_ASAN(0);        in buddy_cache_state_init()

Documentation/process/coding-style.rst (chapter 12, "Things to avoid when
using macros") lists macros that affect control flow first, because they exit
the caller unexpectedly.  Elsewhere in libarena, ASAN-only behaviour uses a
plain "#ifdef BPF_ARENA_ASAN" (asan.h, asan.bpf.c, test_buddy.bpf.c,
test_asan_buddy.bpf.c).

Would an explicit "#ifdef BPF_ARENA_ASAN / return ...; / #endif" at each
site, or a static const bool checked with if, make the early exit visible to
the reader?

> +static __always_inline void __arena *
> +buddy_cache_pop(struct buddy_cache __arena *cache, int order)
> +{
> +	struct buddy_cache_order __arena *slots;
> +	void __arena *addr;
> +	u32 elems;
> +
> +	slots = &cache->orders[order];
> +	elems = READ_ONCE(slots->elems);
> +	if (!elems)
> +		return NULL;
> +
> +	addr = READ_ONCE(slots->objects[elems - 1]);
> +	WRITE_ONCE(slots->elems, elems - 1);
> +
> +	return addr;
> +}
> +
> +static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
> +					    int order, void __arena *obj)
> +{
> +	struct buddy_cache_order __arena *slots;
> +	u32 elems;
> +
> +	slots = &cache->orders[order];
> +	elems = READ_ONCE(slots->elems);
> +	if (elems >= BUDDY_CACHE_CAPACITY)
> +		return -ENOMEM;
> +
> +	WRITE_ONCE(slots->objects[elems], obj);
> +	WRITE_ONCE(slots->elems, elems + 1);
> +
> +	return 0;
> +}
> +
> +void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
> +{

[ ... ]

> +	cpu = bpf_get_smp_processor_id();
> +	cache = state->percpu[cpu];
> +
> +	return buddy_cache_pop(cache, order);
> +}

Can two operations on the same CPU interleave here and hand out the same
object twice?

buddy_cache_alloc() and buddy_cache_free() pick the cache with
bpf_get_smp_processor_id().  buddy_cache_pop() and buddy_cache_push() then do
a separate load of slots->elems, an access to the slot, and a store of the
new count.  Nothing disables preemption or IRQs, and no atomic is used.  The
buddy lock path this bypasses uses arena_spin_lock_irqsave(), which disables
IRQs and preemption.

BPF programs only disable migration.  bpf_prog_test_run_syscall() calls
bpf_prog_run_pin_on_cpu(), which does migrate_disable() and nothing more, and
SEC("syscall") programs are sleepable.  tools/testing/selftests/bpf/
config.x86_64 sets CONFIG_PREEMPT=y.

The parallel benchmark from the previous commit runs

    bench -a -p 8 ... libarena-malloc-free

and bench's next_cpu() returns cpu_set->next_cpu++ % env.nr_cpus.  On a VM
with fewer than 8 CPUs, two producers are therefore pinned to the same CPU
and can preempt each other.  An NMI or IRQ-context BPF program that uses the
same buddy can also interrupt the sequence.

Interleaving on one CPU, starting with elems = 5:

    task A: buddy_cache_pop(): elems = 5, addr = objects[4] = X
            <preempted before WRITE_ONCE(slots->elems, 4)>
    task B: buddy_cache_pop(): elems = 5, addr = objects[4] = X, elems = 4
            returns X
    task A: WRITE_ONCE(slots->elems, 4), returns X

Both tasks now own X.  In bench_malloc_free() both write obj->next into it,
which corrupts their lists and then double-frees X back into the cache.

A push interleaved with a pop has the same effect: the pusher's late store of
elems + 1 re-exposes a slot that was already popped.  Pushes that race each
other lose objects.

This appears to be fixed later in the series by c455eb9bee8a ("selftests/bpf:
libarena: Handle NMI reentrancy"), which adds a per-CPU cmpxchg guard around
the cache operations.  Its message states: "BPF programs also only disable
migration, so another task can preempt a cache operation and run on the same
CPU. Allowing the nested operation to proceed would let it overwrite the
interrupted operation's state."


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39476260714
--===============4403528820858146149==--
