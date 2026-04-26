Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FA375AA1
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777234356; cv=none; b=IWBLjfNDy2SXfxWV/cpXfjERl7GqtkZjSib77sBrGmoCPW7iek6Qk1YadAxukuMqzVeDkFdA8TmjfsKAnMEjeiyRWHiR0oB9LA0iL+ZmWE5Lg/CcZi5XLjLVMtNIbcZqTYZ+RB03pd8AOGeW3oXnrEpJN13u7Stf6+LvJoXwCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777234356; c=relaxed/simple;
	bh=Xuc6uC98UY+vzbsI3kSwB344PXVFlxBIepXFmeMf66k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dGIFC7R+tVcO3D14vVKJzfduRMalSNRHBFsNCeeZOUwEXpHwad2O47ICGodF5woXPzjLUVU8Q34iGokr/ZleAUqKruzM4n7xJhyQvQtQTME+k2P6WHkOGSlmFFGUjLAh4rZMvW8FjGrHpR8ufwqbj2OylZx4pKE23TIZtRpii24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMEGABUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMEGABUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8A7C2BCAF;
	Sun, 26 Apr 2026 20:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777234356;
	bh=Xuc6uC98UY+vzbsI3kSwB344PXVFlxBIepXFmeMf66k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oMEGABUowSP5Ta0GmELQrBInZDpiNko5l/9tELHkaMxZ068HvXwKa8ua/zHb101CC
	 orztKhdSvkg7Rn6uzatRYZ1ForEOq43nb5jVAwEV0MF/I/S5ZV5QJaSP4dyGbVcV61
	 NdGMwfvXWoPO9vFpojIGmUwTe2gAdGbqaq8qXubgkbAEtsZTCUazzVNn58fPgUsZ3w
	 XLIQCuY1NcC35QWUM2zcZVS4cP44dN1utZq/HzC+eYMIiuQ1yfcwnNfSnInJLYpSHr
	 J7Tn9wnfTCE1b09/a8hAOilKuhG8VIjI2lYyaRzEOg3yTApqIXzPJ35tGwR7PsZJu+
	 5GOdunD9gTTDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 4/8] selftests/bpf: Add arena ASAN runtime
 to libarena
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260426190338.4615-5-emil@etsalapatis.com>
References: <20260426190338.4615-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 20:12:35 +0000
Message-Id: <20260426201236.7A8A7C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [Medium] Concurrent `asan_init` calls corrupt global ASAN state
- [Medium] Early loop exit due to `can_loop` causes silent validation bypas=
s and incomplete poisoning
- [Medium] Missing bounds checking in `asan_poison` and `asan_unpoison` all=
ows out-of-bounds writes
- [Medium] Uninitialized ASAN state leads to silent memory corruption
- [Low] Compilation error due to missing argument for `bpf_stream_print_sta=
ck`
- [Low] Compilation and linking errors due to missing ASAN functions and BT=
F anchors
--

commit 378c2bf4d6c7fb041761c5a5045f1680acbb2840
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add arena ASAN runtime to libarena

This commit adds an ASAN runtime to the arena library for BPF selftests.
It implements LLVM sanitization hooks and provides manual poison/unpoison
functions.

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/asan.h=
 b/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
> new file mode 100644
> index 000000000000..eb9fc69d9eb0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/asan.h
[ ... ]
> @@ -0,0 +1,103 @@
[ ... ]
> +/*
> + * Force LLVM to emit BTF information for the stubs,
> + * because the ASAN pass in LLVM by itself doesn't.
> + */
> +#define ASAN_LOAD_STORE_SIZE(size)		\
> +	__asan_store##size,			\
> +	__asan_store##size##_noabort,		\
> +	__asan_load##size,			\
> +	__asan_load##size##_noabort,		\
> +	__asan_report_store##size,		\
> +	__asan_report_store##size##_noabort,	\
> +	__asan_report_load##size,		\
> +	__asan_report_load##size##_noabort
> +
> +__attribute__((used))
> +static void (*__asan_btf_anchors[])(intptr_t) =3D {
> +	ASAN_LOAD_STORE_SIZE(1),
> +	ASAN_LOAD_STORE_SIZE(2),
> +	ASAN_LOAD_STORE_SIZE(4),
> +	ASAN_LOAD_STORE_SIZE(8),
> +};

Does this array need to include variable-sized hooks (like __asan_storeN),
global handlers, and memory intrinsics? Without these in the anchors list,
the compiler might not emit BTF data for them, potentially causing BPF load
failures if LLVM instruments variable-sized accesses.

> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/=
testing/selftests/bpf/libarena/src/asan.bpf.c
> new file mode 100644
> index 000000000000..64c5b990086c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
[ ... ]
> @@ -0,0 +1,553 @@
[ ... ]
> +/*
> + * BPF does not currently support the memset/memcpy/memcmp intrinsics.
> + * For large sequential copies, or assignments of large data structures,
> + * the frontend will generate an intrinsic that causes the BPF backend
> + * to exit due to a missing implementation. Provide a simple implementat=
ion
> + * just for memset to use it for poisoning/unpoisoning the map.
> + */
> +__weak int asan_memset(s8a __arg_arena *dst, s8 val, size_t size)
> +{
> +	size_t i;
> +
> +	for (i =3D zero; i < size && can_loop; i++)
> +		dst[i] =3D val;
> +
> +	return 0;
> +}

Is can_loop defined anywhere? This looks like it might cause an undeclared
identifier compilation error.

Also, if can_loop causes the loop to exit early due to instruction limits,
does this result in incomplete poisoning? asan_memset would return 0, leavi=
ng
the rest of the shadow memory uninitialized.

[ ... ]
> +static __always_inline u64 first_nonzero_byte(u64 addr, size_t size)
> +{
> +	while (size && can_loop) {
> +		if (unlikely(*(s8a *)addr))
> +			return addr;
> +		addr +=3D 1;
> +		size -=3D 1;
> +	}
> +
> +	return SHADOW_ALL_ZEROES;
> +}

Similarly, if can_loop terminates this loop early, could this falsely valid=
ate
the remaining memory and allow large out-of-bounds accesses to bypass ASAN
validation?

[ ... ]
> +__weak int asan_report(s8a __arg_arena *addr, size_t sz, u32 flags)
> +{
> +	u32 reported =3D __sync_val_compare_and_swap(&asan_reported, false, tru=
e);
> +
> +	/* Only report the first ASAN violation. */
> +	if (reported && asan_report_once)
> +		return 0;
> +
> +	asan_violated =3D (u64)addr;
> +
> +	arena_stderr("Memory violation for address %p (0x%lx) for %s of size %l=
d\n",
> +			addr, (u64)addr,
> +			(flags & ASAN_WRITE) ? "write" : "read",
> +			sz);
> +	bpf_stream_print_stack(BPF_STDERR);

Is this missing an argument? The kernel definition of this kfunc is
bpf_stream_print_stack(int stream_id, struct bpf_prog_aux *aux). Compiling
this with vmlinux.h could result in a compilation error.

[ ... ]
> +__hidden __noasan int asan_poison(void __arena *addr, s8 val, size_t siz=
e)
> +{
> +	s8a *shadow;
> +	size_t len;
[ ... ]
> +	shadow =3D mem_to_shadow(addr);
> +	len =3D size >> ASAN_SHADOW_SHIFT;
> +
> +	asan_memset(shadow, val, len);
> +
> +	return 0;
> +}

Does this code verify that asan_init() has been called before executing?
If __asan_shadow_memory_dynamic_address is 0, mem_to_shadow() could resolve
to the beginning of the user arena, causing asan_memset() to overwrite valid
application data.

Additionally, is there a bounds check missing to ensure addr + size falls
entirely within the valid user region? If size extends beyond the user
boundaries, could this write past the shadow map and corrupt the arena's
global variables?

[ ... ]
> +__hidden __noasan int asan_unpoison(void __arena *addr, size_t size)
> +{
> +	size_t partial =3D size & ASAN_GRANULE_MASK;
> +	s8a *shadow;
> +	size_t len;
[ ... ]
> +	shadow =3D mem_to_shadow(addr);
> +	len =3D size >> ASAN_SHADOW_SHIFT;
> +
> +	asan_memset(shadow, 0, len);

Does this unpoisoning function have the same uninitialized state and bounds
checking concerns as asan_poison()?

[ ... ]
> +SEC("syscall")
> +__weak __noasan int asan_init(struct asan_init_args *args)
> +{
> +	u64 globals_pages =3D args->arena_globals_pages;
> +	u64 all_pages =3D args->arena_all_pages;
> +	u64 shadow_map, shadow_pgoff;
> +	u64 shadow_pages;
> +
> +	if (asan_inited)
> +		return 0;
[ ... ]
> +	shadow_pgoff =3D all_pages - shadow_pages - globals_pages;
> +	__asan_shadow_memory_dynamic_address =3D shadow_pgoff * __PAGE_SIZE;
> +
> +	/*
> +	 * Allocate the last (1/ASAN_SHADOW_SCALE)th of an arena's pages for th=
e map
> +	 * We find the offset and size from the arena map.
> +	 *
> +	 * The allocated map pages are zeroed out, meaning all memory is marked=
 as valid
> +	 * even if it's not allocated already. This is expected: Since the actu=
al memory
> +	 * pages are not allocated, accesses to it will trigger page faults and=
 will be
> +	 * reported through BPF streams. Any pages allocated through bpf_arena_=
alloc_pages
> +	 * should be poisoned by the allocator right after the call succeeds.
> +	 */
> +	shadow_map =3D (u64)bpf_arena_alloc_pages(
> +		&arena, (void __arena *)__asan_shadow_memory_dynamic_address,
> +		shadow_pages, NUMA_NO_NODE, 0);
> +	if (!shadow_map) {
> +		arena_stderr("Could not allocate shadow map\n");
> +
> +		__asan_shadow_memory_dynamic_address =3D 0;
> +
> +		return -ENOMEM;
> +	}
> +
> +	asan_inited =3D true;
> +
> +	return 0;
> +}

Can this code corrupt the global shadow memory base if invoked concurrently?

If two threads bypass the lockless asan_inited check, thread 1 could
successfully allocate memory and set asan_inited =3D true. Thread 2 might
then fail its allocation (since the pages are already mapped) and execute
the error path, setting __asan_shadow_memory_dynamic_address =3D 0.

Would this permanently corrupt the global ASAN state for all subsequent che=
cks
in the arena?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426190338.4615=
-1-emil@etsalapatis.com?part=3D4
