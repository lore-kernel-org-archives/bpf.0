Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10872BDC32
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236871; cv=none; b=rx1CSzEhUp2gIv5tg0Hba8Tg8chJwNOi0B9oqqQcsdvBuVaD6F5rGXOOh/C4m/YfdMdYEaTzpjFsg+wxQ5TsxMnWTQiWs+/BzIORdplqcYk1r3B70dL+547BU7dD2QTceWX5aGZacyhmW8+kOix1u72RpgkUAMYVJ8Ec29WwRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236871; c=relaxed/simple;
	bh=njxMbmVoDcvZBkFjRNffq8xJpHc4+bqfTGqLdUGsJHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OSytAtF5tQULVg5TInJXNdT23FwyAp6QOJSKkvUl/mOaDOBCeJtybqUCYMlJLtRYkhJ1F+U+b8KR74AkBnTHrVYBH29xtEzkMMQOwK+l30rI12uk+KL0clkp9JGT5QtNBdRX4qAm5cQlL4vQRafW3Ooiy+dtjjToZ4WiVYN13RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeKVxjGQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeKVxjGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB8FC2BCAF;
	Sun, 26 Apr 2026 20:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236871;
	bh=njxMbmVoDcvZBkFjRNffq8xJpHc4+bqfTGqLdUGsJHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oeKVxjGQ6Cf8e73RfWTGdEwFfEpeyF53yBscffc8TzK5F06/UScoQEbSS+X3XkMcc
	 6KbZAcAFJb3RnZqrroToZr6jWnu6IZ6APbycsgddLLViNP7BFNVR+5ukJKyoflB3q9
	 CzRJu8SoRA5AvUeKBljvdpdlrVmRoUoMnKr2OJhoQHrrA/qyezi+baCBUIyxBs3dcw
	 b0AMY3ZAIesMMrLOvdnYpfRZ93aIUAL2VcDITA6MhYKow2iIQjFoD9Fef8bp6AxOZa
	 +/Xtrni/4aYOHdU2uH0EOt/agJ+sM9Xx7UwBbaaM6hVeneEczW6ELfRMhAm+PFBDRS
	 5FDdbXf+91A9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 6/8] selftests/bpf: Add buddy allocator for
 libarena
Reply-To: sashiko@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260426190338.4615-7-emil@etsalapatis.com>
References: <20260426190338.4615-7-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 20:54:30 +0000
Message-Id: <20260426205431.7FB8FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Permanent memory leaks of newly allocated chunks and freed blocks =
when allocator lock acquisition fails.
- [Medium] Unnecessary global lock contention during thread-local chunk ini=
tialization.
- [Medium] Missing rollback of virtual address space reservation on initial=
ization failure.
- [Low] Accidental inclusion of default.profraw binary file.
--

commit d3559de018f16408b8163bc0362e7b5fdd94366e
Author: Emil Tsalapatis <emil@etsalapatis.com>
selftests/bpf: Add buddy allocator for libarena

Add a byte-oriented buddy allocator for libarena. The buddy allocator
provides an alloc/free interface for small arena allocations ranging
from 16 bytes to 512 KiB.

> diff --git a/tools/testing/selftests/bpf/default.profraw b/tools/testing/=
selftests/bpf/default.profraw
> new file mode 100644
> index 000000000000..e865e87829f8
> Binary files /dev/null and b/tools/testing/selftests/bpf/default.profraw =
differ

This isn't a bug, but it looks like a binary LLVM profile data file was
accidentally included in the patch.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> new file mode 100644
> index 000000000000..865e00803daa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
[ ... ]
> +static buddy_chunk_t *buddy_chunk_get(buddy_t *buddy)
> +{
[ ... ]
> +	chunk =3D bpf_arena_alloc_pages(&arena, (void __arena *)vaddr,
> +				      BUDDY_CHUNK_PAGES, NUMA_NO_NODE, 0);
> +	if (!chunk) {
> +		arena_stderr("[ALLOC FAILED]");
> +		return NULL;
> +	}
> +
> +	if (buddy_lock(buddy)) {
> +		/*
> +		 * We cannot reclaim the vaddr space, but that is ok - this
> +		 * operation should always succeed. The error path is to catch
> +		 * accidental deadlocks that will cause -ENOMEMs to the program as
> +		 * the allocator fails to refill itself, in which case vaddr usage
> +		 * is the least of our worries.
> +		 */
> +		bpf_arena_free_pages(&arena, (void __arena *)vaddr, BUDDY_CHUNK_PAGES);
> +		return NULL;
> +	}
> +
> +	asan_poison(chunk, BUDDY_POISONED, BUDDY_CHUNK_PAGES * __PAGE_SIZE);
> +
> +	/* Unpoison the chunk itself. */
> +	asan_unpoison(chunk, sizeof(*chunk));
> +
> +	/* Mark all freelists as empty. */
> +	for (ord =3D zero; ord < BUDDY_CHUNK_NUM_ORDERS && can_loop; ord++)
> +		chunk->freelists[ord] =3D BUDDY_CHUNK_ITEMS;

Does holding the global allocator lock here create unnecessary contention?

Since this newly allocated chunk is not yet linked to the global allocator
state (which happens later in buddy_alloc_from_new_chunk()), could the
memory poisoning, unpoisoning, and freelist initialization loop be done
before acquiring the global lock?

[ ... ]
> +__weak int buddy_init(buddy_t __arg_arena *buddy)
> +{
> +	buddy_chunk_t *chunk;
> +	int ret;
> +
> +	if (!asan_ready())
> +		return -EINVAL;
> +
> +	/* Reserve enough address space to ensure allocations are aligned. */
> +	ret =3D buddy_reserve_arena_vaddr(buddy);
> +	if (ret)
> +		return ret;
> +
> +	_Static_assert(BUDDY_CHUNK_PAGES > 0,
> +		       "chunk must use one or more pages");
> +
> +	chunk =3D buddy_chunk_get(buddy);
> +
> +	if (buddy_lock(buddy)) {
> +		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
> +		return -EINVAL;
> +	}

If buddy_chunk_get() or buddy_lock() fails, does this permanently leak the
virtual address space reserved earlier?

It looks like buddy_unreserve_arena_vaddr() should be called in these
error paths to prevent exhaustion of the reserved range.

[ ... ]
> +static u64 buddy_alloc_from_new_chunk(buddy_t *buddy, buddy_chunk_t *chu=
nk, int order)
> +{
> +	u64 address;
> +
> +	if (buddy_lock(buddy))
> +		return (u64)NULL;

If the allocator lock cannot be acquired, does this drop the newly allocated
chunk without linking it or freeing it?

Since bpf_arena_free_pages() isn't called on the chunk, it appears this
could permanently leak physical and virtual arena memory.

[ ... ]
> +__weak int buddy_free_internal(buddy_t __arg_arena *buddy, u64 addr)
> +{
> +	int ret;
> +
> +	if (!buddy)
> +		return -EINVAL;
> +
> +	/* Freeing NULL is a valid no-op. */
> +	if (!addr)
> +		return 0;
> +
> +	ret =3D buddy_lock(buddy);
> +	if (ret)
> +		return ret;

If lock acquisition fails here, does the block get permanently leaked?

Since the user-facing free() wrapper returns void, the caller has no way
of knowing the free failed, resulting in silently swallowed errors and
lost memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426190338.4615=
-1-emil@etsalapatis.com?part=3D6
