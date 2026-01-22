Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EE305048
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101093; cv=none; b=u7OaoUgvG57sltZSmNdVtIW7YBL4gh438mEZ0XCik3t6+yWGmlVHLh36jD5CJg1XAsikbAz+fg03mYYGAsX164HfDriChdk0aNM824k1V64YtZ2/bMNnJbTd8e2RrGNOfIP6I+7LC5wFgVWuIlB7P/41FEaZQ4Q/v2YZyLkeOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101093; c=relaxed/simple;
	bh=irP+VLEYMusdUOcXsAc5mVlNt/QuIwMzzfloIZcwBJE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r/LP2fQFjqD99zrXEUhU0DZLFWuoN9HN8AGZdi/jz8Q9RK789PqWI5DbUvlh+F3Te2FFQocxKSgNknrhpWH+Em9CQ3TVVYnp5LCp6aGOVIH5Tm7xhEDAThnXPap0RNlDmHp6qdl3l0UfV2p8g0GfbBaoWznq/iMMNrR/stZForI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/B2KY5N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/B2KY5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE538C2BC9E;
	Thu, 22 Jan 2026 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101092;
	bh=irP+VLEYMusdUOcXsAc5mVlNt/QuIwMzzfloIZcwBJE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=O/B2KY5NzCky+PG/vdJC4ckxWrnDVxPe+LILTf1CRYIxo8Q66oVP+LrtxGLPkoqdy
	 4GtFOl48SoGJFd3APShuSLAxaqrnzqwXFBGi/usJgHKIGT78Il/oK4xETU3ZNxsr82
	 PNM5Xn6gIJizaz8FFvlVK4ysv1jpCV6xRsstbBz2oCPY9H/zf5yH+Hbyzl7cyg7njX
	 bwh1q7YZOLk3ctk8Xi6NelY2wgobhdWe/lSOBdeBmKAJzp0Lp/ryVBOZn/vFtwDUgo
	 eTkVhgScDFyaE9VehOoZl+/hodSgo6p3o3Kv/z8x042hYAgkte+xN2KBK1ScfVSIip
	 4RLI+MDzmmJdw==
Content-Type: multipart/mixed; boundary="===============6424286292187611119=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aae3bad1567ae22ff12276f74cf960129c7aea8186be32a22f5ee465f99efc49@mail.kernel.org>
In-Reply-To: <20260122160131.2238331-10-etsal@meta.com>
References: <20260122160131.2238331-10-etsal@meta.com>
Subject: Re: [PATCH 09/13] selftests: bpf: Add libarena selftests for the bump allocator
From: bot+bpf-ci@kernel.org
To: etsal@meta.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,daniel@iogearbox.net,memxor@gmail.com,puranjay@kernel.org,song@kernel.org,etsal@meta.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 16:58:11 +0000 (UTC)

--===============6424286292187611119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
> new file mode 100644
> index 000000000000..a8f0e6e01e4b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c

[ ... ]

> +int asan_test_bump_blob_one(void)
> +{
> +	volatile struct blob __arena *blob;
> +	const size_t alignment = 1;
> +
> +	blob = bump_alloc(sizeof(blob) - 1, alignment);
                         ^^^^^^^^^^^^

Is sizeof(blob) intended here? Since blob is declared as a pointer
(volatile struct blob __arena *blob), sizeof(blob) returns the size of
the pointer (8 bytes on 64-bit) rather than sizeof(struct blob) which
is 60 bytes.

This means the allocation is only 7 bytes, but the test later accesses
blob->oob at offset 59. Should this be sizeof(*blob) - 1 instead?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
> new file mode 100644
> index 000000000000..99caae452343
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c

[ ... ]

> +#define ST_MAX_PAGES 8
> +#define ST_MAX_BYTES (ST_MAX_PAGES * __PAGE_SIZE)

[ ... ]

> +static int bump_selftest_alloc_multiple(u64 bytes, u64 alignment)
> +{
> +	void __arena *mem1, *mem2;
> +	int ret;
> +
> +	/* Initialize the allocator */
> +	ret = bump_init(ST_MAX_PAGES);
> +	if (ret) {
> +		bpf_printk("bump_init failed with %d", ret);
> +		return ret;
> +	}
> +
> +	mem1 = ALLOC_OR_FAIL(bytes, alignment);
> +	st_memset(mem1, ST_PATTERN1, bytes);
> +
> +	mem2 = ALLOC_OR_FAIL(bytes, alignment);
> +	st_memset(mem2, ST_PATTERN1, ST_PATTERN2);
                        ^^^^^^^^^^^  ^^^^^^^^^^^

The st_memset signature is st_memset(mem, byte, size). This call passes
ST_PATTERN1 (0xAA) as the byte pattern and ST_PATTERN2 (0x55 = 85) as
the size, but later CHECK_OR_FAIL(mem2, ST_PATTERN2, bytes) expects mem2
to contain ST_PATTERN2.

Should this be st_memset(mem2, ST_PATTERN2, bytes)?

Note: This code is currently unreachable due to the loop condition issue
described below.

[ ... ]

> +SEC("syscall")
> +int bump_selftest(void)
> +{
> +	u64 bytes = 128;
> +	u64 alignment = 1;
> +
> +	for (bytes = __PAGE_SIZE; bytes <= ST_MAX_PAGES && can_loop;
                                  ^^^^^^^^^^^^^^^^^^^^^^^

The loop condition compares bytes (in bytes, initialized to __PAGE_SIZE
which is typically 4096) against ST_MAX_PAGES (8, a page count). Since
4096 > 8 is always true, the condition bytes <= ST_MAX_PAGES is always
false and this loop never executes.

Should this compare against ST_MAX_BYTES instead?

> +	     bytes <<= 1) {
> +		for (alignment = 1; alignment <= ST_MAX_ALIGNMENT && can_loop;
> +		     alignment <<= 1) {
> +			/* Each test manages its own allocator lifecycle */
> +			BUMP_ALLOC_SELFTEST(alloc_single, bytes, alignment);
> +			BUMP_ALLOC_SELFTEST(alloc_multiple, bytes, alignment);
> +		}
> +	}
> +
> +	BUMP_ALLOC_SELFTEST(alloc_aligned);
> +
> +	for (alignment = __PAGE_SIZE; bytes <= ST_MAX_PAGES && can_loop;
            ^^^^^^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^
> +	     bytes <<= 1)

This loop initializes alignment but tests and advances bytes. The
condition bytes <= ST_MAX_PAGES is false (bytes retains its value from
the previous loop), so this loop also never executes.

Was the intent to iterate over different alignment values? If so, both
the condition and the increment should use alignment.

> +		BUMP_ALLOC_SELFTEST(alloc_exhaustion,
> +				    ST_MAX_PAGES * __PAGE_SIZE, alignment);
> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21256973563

--===============6424286292187611119==--
