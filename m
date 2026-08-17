Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C72236E8
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998357; cv=none; b=FNv/WbX8aPMQyYawgIofDE/+aOp60j/4wjk8RMBJrj9umipLvVupBRXLlzlz74SVK/JSXrsYfSqiTmlu3+mEJigxTvjT9v+2HdseP/Cu4XMYlnrKR+H7bnR7DOZTc6O/cvTaEAO8J9Dr0DxPUcqiRBHrWvfVL6C0oim1F0ZguaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998357; c=relaxed/simple;
	bh=IYIwzCCeBnPdmldMTKxZPmMV5awiHAhmV3fvaBxGh0s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bLGkjxsxd4e9NG3nOBfftA3u3Hol2M6DluQwgqorCHqfwYh/7dFCJ6sGyyNUxfQ7h7I8rNaZOzBeUY6G6KgVVnmirjWtd1+NQDR35toibb8jbrf1eaDMt6dabGeEw4cjWQh7tcOsIzY5KG7VG7pFD+PIAGNxvFyjosUzkhEe0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIGJrhy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIGJrhy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE71E1F000E9;
	Mon, 17 Aug 2026 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998355;
	bh=RZi3yzy+zH+WoS/Eb1xoipIKKhDjdIZnxIqHPXR3tCI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oIGJrhy/mBv9570OkH/gr8XWclCEPPySbO5D7hLDsj3NVKlyr1UOPpDp9mwj00L2K
	 AAeM7EDSq2Jp2eQZ6fGFzlJyXX+lN1dMfDhdmCK+tW2K4sLZd4g8xQ6NfR/86L6X6p
	 pGuL0tpS0wd1WYJsTwBZHp1kuMogm6RejbEWJ/y58eSW6gyLDlIYgCGU1SP5zjzhJE
	 fO+yQ6m2qNLrZQjMfQPTjV99V90ulhL9ocHI7bnh4EtDKHeUNYRTjhEKxU5F2c7+IM
	 hql4eo7xWTA7seygsmmiCzSsMcLdNXr6hOqb0fE5O0huYeWikqsJhmgrzVAWYLDDcv
	 eZnEO644L6hxA==
Content-Type: multipart/mixed; boundary="===============2992625964022838910=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f4c9c4af30aca1bc17eaf2de4815c4446b541ec391ea434ec0b9a48c3faf6020@mail.kernel.org>
In-Reply-To: <20260817191616.11071-7-emil@etsalapatis.com>
References: <20260817191616.11071-7-emil@etsalapatis.com>
Subject: Re: [PATCH 6/6] selftests/bpf: libarena: Optimize and make public arena_memset
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 20:25:54 +0000 (UTC)

--===============2992625964022838910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/Makefile b/tools/testing/selftests/bpf/libarena/Makefile
> index 6d62eda34920..91164d43bd61 100644
> --- a/tools/testing/selftests/bpf/libarena/Makefile
> +++ b/tools/testing/selftests/bpf/libarena/Makefile
> @@ -60,6 +60,7 @@ override BPF_CFLAGS += -O2 -g
>  override BPF_CFLAGS += -Wno-incompatible-pointer-types-discards-qualifiers
>  # Required for suppressing harmless vmlinux.h-related warnings.
>  override BPF_CFLAGS += -Wno-missing-declarations
> +override BPF_CFLAGS += -fno-strict-aliasing
>  override BPF_CFLAGS += $(INCLUDES)

Should this flag have a comment explaining why it's needed? The new
arena_memset stores u64 values through an s8 __arena * pointer, which
violates strict aliasing rules at -O2. The flag directly above has a
"# Required for..." comment, but this one doesn't, so a reader has to
connect the two changes themselves.

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> index d32a51ff5e7f..a6220355a697 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> @@ -71,10 +71,63 @@ void arena_free(void __arena *ptr);
>   */
>  static inline int arena_memset(s8 __arena *dst, s8 val, size_t size)
>  {
> +	size_t headalign;
> +	size_t tailalign;
> +	u8 uval = (u8)val;
> +	size_t val64;
>  	size_t i;
>
> -	for (i = zero; i < size && can_loop; i++)
> -		dst[i] = val;
> +	/*
> +	 * Calculate how many bytes to the next word-aligned one.
> +	 * We get this by truncating the 2s complement of the
> +	 * pointer to the last 3 bits. Intuitively, since
> +	 *
> +	 * The N LSBs of dst and -dst add to 1 << N, which
> +	 * is why dst + (-dst) = 0x0ULL through overflow. So the
> +	 * last N = 3 bits of the negative are the number of
> +	 * bytes to align dst on the last 3 bits.
> +	 *
> +	 */
> +	headalign = -(u64)dst & (sizeof(u64) - 1);
> +	if (!headalign || size < headalign)
> +		goto ptraligned;
> +
> +	for (i = zero; i < headalign && can_loop; i++)
> +		dst[i] = uval;
> +
> +	dst += headalign;
> +	size -= headalign;
> +
> +ptraligned:
> +
> +	/*
> +	 * Make a word with all bytes equal to the byte we are setting.
> +	 * Since 1 byte -> 2 hex digits.
> +	 *
> +	 * Shifting the value by a 0 bytes is equal to multiplication by 0x01
> +	 * Shifting by 1 bytes is equal to multiplication by 0x01 << 8,
> +	 * ...
> +	 * Shifting by 7 bytes is equal to multiplication by 0x01 << 56.
> +	 *
> +	 * End operation to replicate the byte into all the bytes of a word
> +	 * is (since a | b = a + b when a & b == 0):
> +	 *
> +	 * val + val * (1UL << 8) + val * (1UL << 16) + .. + val * (1UL << 56)
> +	 * = val * (1UL << 56 + 1UL << 48 + ... + 1UL << 0)
> +	 * = val * (0x01UL << 56 | 0x01UL << 48 + ... + 1UL << 0)
> +	 * = val * 0x0101 0101 0101 0101
> +	 */
> +	val64 = (u8)val * 0x0101010101010101ULL;
> +
> +	/* Pointer is now aligned, use word-aligned assignments. */
> +	for (i = zero; i < size / sizeof(u64) && can_loop; i++)
> +		((u64 __arena *)dst)[i] = val64;

Is the "Pointer is now aligned" comment accurate on both paths to
ptraligned? When size < headalign at line 92, the function jumps here
with dst still unaligned. That path is safe because headalign <= 7
forces size <= 6, so size / sizeof(u64) is 0 and this loop never runs,
but nothing in the code or comment states that implication.

The issue is that someone widening the word size or relaxing the guard
could silently start issuing unaligned u64 stores, since the comment
tells them the pointer is aligned when it may not be. Other libarena
code handles this differently - asan_poison() and asan_unpoison() in
asan.bpf.c explicitly reject unaligned inputs at the top rather than
relying on an unstated size check.

> +	/* Go back to byte-aligned for the tail. */
> +	tailalign = size % sizeof(u64);
> +	dst += size - tailalign;
> +	for (i = zero; i < tailalign && can_loop; i++)
> +		dst[i] = uval;
>
>  	return 0;
>  }

Looking at the commit message:

>     selftests/bpf: libarena: Optimize and make public arena_memset
>
>     Clang currently provides no __builtin_{memset, memcpy, memcmp}
>     for its BPF backend. This is especially an issue for arena code
>     that is more likely to do these operations on buffers with user-provided
>     bounds. One example is the arena ASAN implementation that uses
>     memset to update the shadow bitmap. Arena ASAN actually already
>     has a naive implementation of this operation. Another user would
>     be a calloc() call that has to zero the memory it returns.
>
>     Introduce a more optimized version of the memset() operation for
>     arena memory and make it public to all libarena users. The operation
>     uses word-sized assignments to speed up the function for larger sizes.
>     We expose the function through common.h to allow for inlining from
>     the callers.

Does the description match what this commit actually changes? The diff
only modifies the function body - the `static inline int arena_memset`
declaration line is context, not an addition.

Looking at the commit history:

- Base commit 530113d7299d has no arena_memset in common.h; the naive
  implementation was in libarena/src/asan.bpf.c as __weak asan_memset
- The previous commit d29667cc7e20 ("selftests/bpf: libarena: Add
  calloc() call") already moved it to common.h as static inline and
  added arena_calloc() calling it, with changelog saying "Reuse naive
  memset implementation already present in the arena ASAN code for now.
  Subsequent patches will optimize the function."

So arena_memset was already public (static inline in
include/libarena/common.h) before this patch. The subject says "Optimize
and make public" but only the optimize part is this commit's work. The
message also says "Arena ASAN actually already has a naive
implementation" (present tense) but as of d29667cc7e20 asan_memset was
deleted and the ASAN code now calls the shared arena_memset. Similarly
"Another user would be a calloc() call" uses conditional tense, but
arena_calloc() already exists at common.bpf.c:60 and already calls
arena_memset(mem, 0, total) at line 79.

Could the message focus on what this specific patch does - replacing the
byte loop with an aligned word-store loop?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32062809860
--===============2992625964022838910==--
