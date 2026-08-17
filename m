Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31C3624A8
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994633; cv=none; b=jJ1b7uoq8pBILNl8qvjcoakciLuIMhPwewTHrdEtTj+PNW+AQokorQ9398a2nxZpURC9WNkoFsS5dy08QxnVxqc9bUMZC56nNSHOSZ/YmMGK8WbkIH+awxjHGmkDUiIPoNe4TaXuVUQm6XYiSiFmfClfqHbdreciR3YU5PVXJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994633; c=relaxed/simple;
	bh=fOlbUl3JTqGyabrc0v/wr4zE1qz7zCb5CEkPqq7CdSg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImVAymZAXKpWqYWToBAJLx8utJWUi75jdJZAzqyrlke1Lvh0l0pUW6n2Bz/GfXH7LISG2rRmAX8Z8DWvmQe519nTaQ10GJBGAnHa6+bF+EoRQND1PSXlnmYYTWw7AkzRq0WuGsdf5KnE0rpTn9q+3Xp72rAR6MKxy3EYfFUGAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/W0R8/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/W0R8/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5C81F000E9;
	Mon, 17 Aug 2026 19:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786994631;
	bh=cdVz++lwPerCNHG9oWLVZflxKchzeSoadzujpLPZ53k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/W0R8/S+QU0D7Lk9ryMn88IE9O2yjq5+mjSjlc5Jw4sZZ7EnwQJQCqiFQkKrZqNz
	 8ysSGAGMqYgTNZBH6zVtwTX9mib33OZIDLNP+kOjAtaqAQhoWXFKsmM0Abf6Qgl0Gs
	 itJIqkbju3/JRQLhixso70pZH3yjG6Nyw8pu3Gztej7UAybwWPx3dukEMFWPTGKh4i
	 swvXI7VJa2L5LZVTl5AXmgwQXuorUL3Mhrk26yaYyDfHHWZMjWOtvTYJwXxhFnmgsq
	 NZnuG9NRUesg2XJF73axJZORrTJMvSz6WNgYzRTcHc+LHwv57YwMtM8w2wChyuEmMd
	 +t0+pStooX4pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] selftests/bpf: libarena: Add calloc() call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817191616.11071-5-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
 <20260817191616.11071-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:23:51 +0000
Message-Id: <20260817192351.8E5C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arena_calloc() can silently return partially uninitialized memor=
y for large allocations due to early termination of arena_memset().
--

--- Patch [4]: [PATCH 4/6] selftests/bpf: libarena: Add calloc() call ---
commit 6f83c4438650c93f36d2b3ed9f3991f97c46a580
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add calloc() call

This commit adds a calloc() operation to the arena memory allocator. It
provides zero-initialization for the allocated memory using a naive
memset implementation.

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
> @@ -61,6 +62,23 @@ void arena_free(void __arena *ptr);
>   */
>  #define arena_subprog_init() do { asm volatile ("" :: "r"(&arena)); } wh=
ile (0)
> =20
> +/*
> + * BPF does not currently support the memset intrinsics. for large
> + * sequential copies, or assignments of large data structures,
> + * the frontend will generate an intrinsic that causes the BPF
> + * backend to exit due to a missing implementation. Provide
> + * implementations for the intrinsic.
> + */
> +static inline int arena_memset(s8 __arena *dst, s8 val, size_t size)
> +{
> +	size_t i;
> +
> +	for (i =3D zero; i < size && can_loop; i++)
> +		dst[i] =3D val;
> +
> +	return 0;
> +}

[Severity: Medium]
If the loop terminates early because the instruction limit is reached when
can_loop evaluates to false, will this function return 0 without indicating
to the caller that the memory was only partially written?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/common.bpf.c
> --- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c

[ ... ]

> +__weak void __arena *arena_calloc(size_t ncount, size_t size)
> +{
> +	void __arena *mem;
> +	size_t total;
> +
> +	/*
> +	 * Ideally we'd be using __builtin_mul_overflow here,
> +	 * but the BPF compiler backend doesn't implement __multi3.
> +	 * There are ways to optimize the division away from the
> +	 * overflow check, but any costs are dwarfed by the
> +	 * buddy_alloc() call. Keep it simple for now.
> +	 */
> +	if (unlikely(ncount && size >=3D ULLONG_MAX / ncount))
> +		return NULL;
> +
> +	total =3D ncount * size;
> +
> +	mem =3D buddy_alloc(&buddy, total);
> +	if (likely(mem))
> +		arena_memset(mem, 0, total);
> +
> +	return mem;
> +}

[Severity: Medium]
Because arena_memset() always returns 0 even on early termination, could
arena_calloc() silently return a partially uninitialized buffer for large
allocations where the loop budget is exhausted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817191616.1107=
1-1-emil@etsalapatis.com?part=3D4
