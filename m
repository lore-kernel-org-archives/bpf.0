Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A451BA34
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815048; cv=none; b=BFYLrd48e17ecIBWZhPBKIDe7cNeqnh04/EFQrgIT1MSYul6H+5MgwcABEWWVHtmvhyoEE3Cq+moii1SRQ7j2P6hVutXDs4eUByc3Q0vSUUX7ryZVuJ0RntYYy0KPYT2YZiSLSqmBeibsvcvzvVtb1pHvwntN7HvwSa8t0kYiBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815048; c=relaxed/simple;
	bh=uVLdXQHwwdWiBAz28ayPkIx3n4yyX8EziSbNz0KjnlA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=flkiM8zO3z3WqJE9k/hdoFYx09W8VEJ7zRp6Symf8q0Os1Q71x+VVd9vRr6VMZoU27dz2MMHsTSMxzMJxlRPceXPiiPB8w2REF2GtdXEhQJDelJQmLdkIDh+ezzxtUwBdLCF0mYD8BUvTGdOlUaEuxKgaw4/azmTuH4tjlXY8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN24v70S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN24v70S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077921F000E9;
	Thu, 27 Aug 2026 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787815047;
	bh=nLPoeEnYeyuPbpF24iGq/eC9awauKXPa1+sDqor/qpM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PN24v70SrvWDuq3YCYc4E2OWi9zgp8BOm2FBSHmcUvhgxVHQi4c47P9TvB6oMvU9T
	 xFlYa0/QKWO+/1yVbKsNxJ7guUrXTPMruTwwpgiaEcsz/uiLfVgNZtEIXF198dhFtO
	 sL5rBG6qN7XIVwvP8EImRqtIf11sriqAaOfq0HGQUmjiodLsWUU22x/hSlHf7RjdC/
	 dX1/urOJiNLRZo3aMW/Jo2ajEKZx6646cbCkw3pgXmBnzt0RpUAtMDeYyefrr0vIB4
	 1agdnXUGZjqQC/htUOSlbSn5sj6vvePZcFCwXjF0cp0nK4ByLuEvIYa6bAptKyLyOA
	 4J9jNTyh/rQ2A==
Content-Type: multipart/mixed; boundary="===============3730331125176712387=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <465f8ac0b4ab71a0d3939e6bded8e52a1a1e54e7c6d57ef7447b1dad571ce9ae@mail.kernel.org>
In-Reply-To: <20260827061206.2520351-1-yonghong.song@linux.dev>
References: <20260827061206.2520351-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 10/11] selftests/bpf: Test kfuncs returning arena pointers by value
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 07:17:27 +0000 (UTC)

--===============3730331125176712387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
> new file mode 100644
> index 0000000000000..94c35e1b547cd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc_arena.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf_arena_common.h>
> +#include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +#if defined(__clang_major__) && __clang_major__ >= 23
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 2);
> +} arena SEC(".maps");
> +
> +/*
> + * A returned member carries the arena type tag but not the address space
> + * qualifier, so the program casts it into the arena address space itself
> + * rather than the compiler doing it.
> + */
> +#define arena_ptr(p) ((u32 volatile __arena *)(p))

This isn't a bug, but could the cast be spelled out at each use site, or
the macro named after the type it produces (e.g. arena_u32p())? The name
arena_ptr() reads as a generic address-space cast, but it hardcodes 'u32
volatile', which matters for the load/store widths the test checks. Other
arena selftest programs write the cast inline with the type visible at the
use site (for example '(char __arena *)ptr' in progs/arena_mem_usage.c).

> +
> +SEC("syscall")
> +__arch_x86_64 __arch_arm64
> +__load_if_JITed()
> +__success __retval(0)
> +int aggregate_ret_kfunc_arena(void *ctx)
> +{
> +	u32 volatile __arena *page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
> +	u32 volatile __arena *a, *b;
> +	struct prog_test_ret_arena r;
> +
> +	if (!page)
> +		return 1;
> +
> +	/* Both halves come back in R0:R2, pointing at page and page + 4. */
> +	r = bpf_kfunc_call_test_ret_arena((u64)page);
> +	if (!r.a || !r.b)
> +		return 2;
> +
> +	a = arena_ptr(r.a);
> +	b = arena_ptr(r.b);
> +	*a = 1;
> +	*b = 2;
> +	if (*a != 1)
> +		return 3;
> +	if (*b != 2)
> +		return 4;
> +
> +	/* The halves are the first two slots of the page the program allocated. */
> +	page[0] = 7;
> +	if (*a != 7)
> +		return 5;
> +	page[1] = 9;
> +	if (*b != 9)
> +		return 6;
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525
--===============3730331125176712387==--
