Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DD36493A
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776968; cv=none; b=tc/ttntLHV/apFPyqrtbmHOZBVA487f+N/6CaTMCvXLE+mCGJYORDC3bqDNS9cAaw5l0FhMgHOUYOx0dJLDfRBWEAZ6Cbf3jJj8wmWBUuend6v9hc/qfNjoPTEnAlRjgsc2FG23n8F+hWq09SNiRqmfPLLdo6K3Ev3wUvwwpvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776968; c=relaxed/simple;
	bh=gS/F9N+q7+v+jApkF/Pnkenfg0skhB0rXIRLGDum6qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kr1HLjsN4K3ohXOJ7gqVoucNbXeewAuvdndL/ndUtCdy0dSbrB8Q6n/gdm3W4lyKJLhqfehXZSizIelJeW8s901oFJ0+57JKEhapkSWulSsbxdUusIHfflR3lMBHDRHekwxaxCgyvalsaprJX2TRXG6jI6gu6cz6zXJJkdWviKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=auIXw9p5; arc=none smtp.client-ip=91.218.175.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="auIXw9p5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gS/F9N+q7+v+jApkF/Pnkenfg0skhB0rXIRLGDum6qo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787776963; v=1; x=1788381763;
 b=auIXw9p5cozHxuMKFNOpbpts6clARIVFestaoRGwynARVbyw4Nz1CCVx5eTfa7yjIQ7VkO+/
 lIqBGtcqsNh2zXpuBdS12/ETwJbw1QNZvgTbYIbHRjgCe6hGmFmbdpTR0mKBKm4aoy6+J5SDEgD
 hp6V3IDpNc4sS8GHO7HFDveQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21c1::1576] (2620:10d:c090:400::5:7641)
	by smtp.migadu.com with ESMTPS id d08fcf0a3b9b932d;
	Wed, 26 Aug 2026 20:42:33 +0000
X-Mizu-Trace-ID: d08fcf0a3b9b932d
X-Migadu-Flow: FLOW_OUT
Message-ID: <49226345-d2e4-4618-8c9d-9dd1d9b0ff4b@linux.dev>
Date: Wed, 26 Aug 2026 13:42:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument flags
 with suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com,
 kernel-team@meta.com
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-12-memxor@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260821233516.3426127-12-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-08-21 4:35 p.m., Kumar Kartikeya Dwivedi wrote:
> The arena allocation kfuncs still identify pointer arguments with
> KF_ARENA_ARG2. These flags cover only the first two parameters and
> duplicate the __arena suffix mechanism used by other kfuncs.

This is a little petty, but the paragraph mischaracterizes what
happened :) It's not like the flags duplicate an existing mechanism
for an unknown/dumb reason. There was no __arena and it was the only
mechanism until very recently.

Rephrase please?

> 
> Annotate the optional allocation address with __arena__nullable. Mark the
> free and reserve addresses with __arena so a valid address whose low 32
> bits are zero is rebased unconditionally instead of becoming NULL.
> 
> The JIT now passes kernel arena addresses to these kfuncs. Translate them
> back to the lower-32-bit user addresses expected by the existing arena
> helpers by subtracting kern_vm_start. This preserves allocation-anywhere,
> freeing the first page of a 4 GiB arena, and reservation at address zero.
> 
> Drop KF_ARENA_ARG1 and KF_ARENA_ARG2 from the kernel interface and remove
> the flags from the arena kfunc sets. KF_ARENA_RET remains responsible for
> annotating the allocation return value.
> 
> Keep the affected selftests synchronized with the conversion. Associate
> an arena before the iterator map-pointer failures so they still reach the
> intended diagnostics, account for the extra nullable branch in JIT labels,
> and treat 1ULL << 32 as the same allocation-anywhere request as NULL after
> the required 32-bit truncation.

It's been brought to my attention a few times [1], that we (the linux
contributors) would strongly prefer the commit messages to explain
*why* the change is being made, instead of *what*.

And the llms tend to do the exact opposite.

This applies to other patches in the series as well, particularly the
cover letter.

[1] 
https://lore.kernel.org/bpf/20260730212613.GJamvBdRJ5H98hTWS8@fat_crate.local/

> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   include/linux/btf.h                           |  2 -
>   kernel/bpf/arena.c                            | 40 ++++++++++++++-----
>   .../selftests/bpf/progs/arena_kfunc_jit.c     | 16 ++++----
>   .../selftests/bpf/progs/verifier_arena.c      |  6 +++
>   .../bpf/progs/verifier_arena_large.c          |  4 +-
>   5 files changed, 46 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 89d5a5c4f117..65e5f11dc27e 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -76,8 +76,6 @@
>   #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
>   #define KF_FASTCALL     (1 << 12) /* kfunc supports bpf_fastcall protocol */
>   #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
> -#define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
> -#define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>   #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
>   #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
>   
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..6c34a0d34b3f 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -1044,18 +1044,28 @@ static void arena_free_irq(struct irq_work *iw)
>   	schedule_work(&arena->free_work);
>   }
>   
> +static long arena_kaddr_to_uaddr(struct bpf_arena *arena, const void *addr)
> +{
> +	if (!addr)
> +		return 0;
> +
> +	return (long)addr - bpf_arena_get_kern_vm_start(arena);
> +}
> +
>   __bpf_kfunc_start_defs();
>   
> -__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
> -					int node_id, u64 flags)
> +__bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__arena__nullable,
> +					u32 page_cnt, int node_id, u64 flags)
>   {
>   	struct bpf_map *map = p__map;
>   	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	long addr;
>   
>   	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
>   		return NULL;
>   
> -	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
> +	addr = arena_kaddr_to_uaddr(arena, addr__arena__nullable);
> +	return (void *)arena_alloc_pages(arena, addr, page_cnt, node_id, true);
>   }
>   
>   void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
> @@ -1082,14 +1092,20 @@ void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32 page_cn
>   	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
>   }
>   
> -__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
> +/*
> + * A valid arena address can have zero low 32 bits, so ptr must be rebased
> + * unconditionally instead of being treated as nullable.
> + */
> +__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__arena, u32 page_cnt)
>   {
>   	struct bpf_map *map = p__map;
>   	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	long ptr;
>   
> -	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
> +	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt)
>   		return;
> -	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
> +	ptr = arena_kaddr_to_uaddr(arena, ptr__arena);
> +	arena_free_pages(arena, ptr, page_cnt, true);
>   }
>   
>   void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
> @@ -1102,10 +1118,11 @@ void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_c
>   	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
>   }
>   
> -__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
> +__bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__arena, u32 page_cnt)
>   {
>   	struct bpf_map *map = p__map;
>   	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	long ptr;
>   
>   	if (map->map_type != BPF_MAP_TYPE_ARENA)
>   		return -EINVAL;
> @@ -1113,14 +1130,15 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
>   	if (!page_cnt)
>   		return 0;
>   
> -	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
> +	ptr = arena_kaddr_to_uaddr(arena, ptr__arena);
> +	return arena_reserve_pages(arena, ptr, page_cnt);

This patch does a couple unrelated things clumped together.

There is a kfunc arena arg identification mechanism change: flag to
suffix. And there is behavioral change: rebasing the pointer etc.

I think it'd be easier to review and would lead to a cleaner git
history if these were separated. In particular, I'd expect the flag
deprecation itself to not require any changes in the jit tests.

>   }
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(arena_kfuncs)
> -BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
> -BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
> -BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
> +BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_SPINLOCK_SAFE)
> +BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_SPINLOCK_SAFE)
> +BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_SPINLOCK_SAFE)
>   BTF_KFUNCS_END(arena_kfuncs)
>   
>   static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> index b5a01cbc33a7..c9af35c683b3 100644
> --- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> @@ -49,15 +49,15 @@ __arch_x86_64
>   __jited("...")
>   __jited("	movl	%edi, %edi")
>   __jited("	testl	%edi, %edi")
> -__jited("	je	L0")
> +__jited("	je	L1")
>   __jited("	addq	%r12, %rdi")
> -__jited("L0:	callq	{{.*}}")
> +__jited("L1:	callq	{{.*}}")
>   __arch_arm64
>   __jited("...")
>   __jited("	mov	w0, w0")
> -__jited("	cbz	w0, L0")
> +__jited("	cbz	w0, L1")
>   __jited("	add	x0, x28, w0, uxtw")
> -__jited("L0:	{{.*}}")
> +__jited("L1:	{{.*}}")
>   __success
>   int arena_arg_jit_nullable(void *ctx)
>   {
> @@ -79,9 +79,9 @@ __jited("	movl	%ecx, %ecx")
>   __jited("	addq	%r12, %rcx")
>   __jited("	movl	%r8d, %r8d")
>   __jited("	testl	%r8d, %r8d")
> -__jited("	je	L0")
> +__jited("	je	L1")
>   __jited("	addq	%r12, %r8")
> -__jited("L0:	callq	{{.*}}")
> +__jited("L1:	callq	{{.*}}")
>   __arch_arm64
>   __jited("...")
>   __jited("	add	x0, x28, w0, uxtw")
> @@ -89,9 +89,9 @@ __jited("	add	x1, x28, w1, uxtw")
>   __jited("	add	x2, x28, w2, uxtw")
>   __jited("	add	x3, x28, w3, uxtw")
>   __jited("	mov	w4, w4")
> -__jited("	cbz	w4, L0")
> +__jited("	cbz	w4, L1")
>   __jited("	add	x4, x28, w4, uxtw")
> -__jited("L0:	{{.*}}")
> +__jited("L1:	{{.*}}")
>   __success
>   int arena_arg_jit_args5(void *ctx)
>   {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> index 815f342eb4b0..d76490e059f9 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -445,6 +445,8 @@ int iter_maps1(struct bpf_iter__bpf_map *ctx)
>   
>   	if (!map)
>   		return 0;
> +	/* Associate an arena before testing the generic map-pointer path. */
> +	bpf_arena_reserve_pages(&arena, NULL, 0);
>   	bpf_arena_alloc_pages(map, NULL, map->max_entries, 0, 0);
>   	return 0;
>   }
> @@ -455,6 +457,8 @@ int iter_maps2(struct bpf_iter__bpf_map *ctx)
>   {
>   	struct seq_file *seq = ctx->meta->seq;
>   
> +	/* Associate an arena before testing the generic map-pointer path. */
> +	bpf_arena_reserve_pages(&arena, NULL, 0);
>   	bpf_arena_alloc_pages((void *)seq, NULL, 1, 0, 0);
>   	return 0;
>   }
> @@ -467,6 +471,8 @@ int iter_maps3(struct bpf_iter__bpf_map *ctx)
>   
>   	if (!map)
>   		return 0;
> +	/* Associate an arena before testing the generic map-pointer path. */
> +	bpf_arena_reserve_pages(&arena, NULL, 0);
>   	bpf_arena_alloc_pages(map->inner_map_meta, NULL, map->max_entries, 0, 0);
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> index 6ab8730d4878..f6515e0e9b17 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -49,8 +49,10 @@ int big_alloc1(void *ctx)
>   
>   	no_page = bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_SIZE,
>   					1, NUMA_NO_NODE, 0);
> -	if (no_page)
> +	/* Only the low 32 bits contribute, so this is equivalent to NULL. */
> +	if (!no_page)
>   		return 3;
> +	bpf_arena_free_pages(&arena, (void __arena *)no_page, 1);
>   	if (*page1 != 1)
>   		return 4;
>   	if (*page2 != 2)

