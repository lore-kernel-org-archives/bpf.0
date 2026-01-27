Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A47277C81
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539139; cv=none; b=Mp7KJBBLUeyEQmulw1tkvcxe8ACfrGIA8a/Xsf38nDb0yYZ1uWw0f9LfojnMKqvXgSOif/LrbHC5F9ELs03AoJP9/Ri9txitKVOT//hB6C6DS2RJU0FyKrRr5+P+D5QmM02Rd7raIcT2za6AmmvfRhODdKTeem21rcc/sndPFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539139; c=relaxed/simple;
	bh=A8saq+qTS3XqvJiKMxzzOa4CU3JNgtgeX0K9MufCMcI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FOpjQhRK4HvRnRCloVv9VDPhg68cagt7GRev9SkGWbtFTDEYtHCjDAXB8cKLdIiahqUNrnxabcB9489S12sCFuhbaXI0j3U3MnkmWODjWRxl+3ppK3jFstm3XPizHyGfDjVnAokBqF3jQvRBfNL6NAKl7gBact6f2C5JNvajDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdT4yCSi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdT4yCSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B54C116C6;
	Tue, 27 Jan 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539138;
	bh=A8saq+qTS3XqvJiKMxzzOa4CU3JNgtgeX0K9MufCMcI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kdT4yCSiB8iii9B6y/BK4DVw4MQnLfp68mm5/nYVNF44fZCISk+G/oh9jRlIbWyDK
	 wJM0rGFuXpPzQvuZqRTOjB92zRWOq9E+0UMFHoRqwYH00yZfxEcDYD41HYwAIRnIES
	 Gk5VyoHvROHX1HBB61uTEhOt4PK4mDeoc1ge/xKXvSfVlrVS610GnDBtOZd+jaKUgw
	 HYaSWWYO6fOct7Ld3ryOEcHz4pb0VVSDhl3bVOEHD+qOX+BoBwBlUfd09WZ7AvzGax
	 T4r4tholVqduIXluJjzUNyN/MlZx7KxEvVWqmEbvvqi32avZyFaNdOGPtDjlpbZqQ1
	 9NET552+L/P/Q==
Content-Type: multipart/mixed; boundary="===============3767765222571552542=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73d1daf10438f3031eadce9f0552088b5856662c62eea00f180b5396c43585e4@mail.kernel.org>
In-Reply-To: <20260127181610.86376-14-emil@etsalapatis.com>
References: <20260127181610.86376-14-emil@etsalapatis.com>
Subject: Re: [PATCH v2 13/13] selftests: bpf: Add selftests for the libarena buddy allocator
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,etsal@meta.com,ihor.solodrai@linux.dev,martin.lau@kernel.org,memxor@gmail.com,puranjay@kernel.org,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 18:38:58 +0000 (UTC)

--===============3767765222571552542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
> new file mode 100644
> index 000000000000..256d9a865647
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c

[ ... ]

> +static int buddy_selftest_alloc_multiple()
> +{
> +	int ret, j;
> +	u32 i, idx;
> +	u8 __arena *mem;
> +	size_t sz;
> +	u8 poison;
> +
> +	ret = buddy_init(&st_buddy,
> +			     (arena_spinlock_t __arena *)&st_buddy_lock);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Cycle through each size, allocating an entry in the
> +	 * segarr. Continue for SEGARRLEN iterations. For every
> +	 * allocation write down the size, use the current index
> +	 * as a poison value, and log it with the pointer in the
> +	 * segarr entry. Use the poison value to poison the entire
> +	 * allocated memory according to the size given.
> +	 */
> +	idx = 0;
> +	bpf_for(i, 0, SEGARRLEN) {
> +		sz = alloc_multiple_sizes[idx % 9];
                                       ^^^

The comment says "Cycle through each size" but idx is initialized to 0
and never incremented in this loop. This means sz will always be
alloc_multiple_sizes[0] (which is 3) for all 512 allocations. Should
idx be i here to cycle through the different sizes in the array?

> +		poison = (u8)i;
> +
> +		mem = buddy_alloc(&st_buddy, sz);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21409286496

AI-authorship-score: low
AI-authorship-explanation: The code follows existing selftest patterns and the idx variable bug is a typical human copy-paste error that AI would be less likely to make.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The idx variable bug causes all allocations to use the same size (3 bytes) instead of cycling through different sizes, reducing test coverage but not causing system instability.

--===============3767765222571552542==--
