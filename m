Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8930EF6C
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101970; cv=none; b=o8jLYT/FhMJoTtj1qX7i5BvN6/KaKxOmZGIDJiTljuXRv6F7aHle6cCMMbNGU6PulyjbvxOqVWZLGAGcqHOyb+UOkiIy2PY2kvlJGT9Xu74bBNr10CyRehA+211hZ6FP/TngHEcMSbe793r9r+UNC/VWswyOnUwTB93WqgeokEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101970; c=relaxed/simple;
	bh=2GaSI1ZarfWZAgJYchxVyiLuqUkxepqHbUHJa6Ki0CM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rgDyTgxoJ4Svvx7Nj8/jeZELajOz59B0j65oVK/VUh0wBFRHbUXyXDoKsyim0kL5pHMpwqunxEpunYszPgTH6uO/birLmWDUqKOSRm2HVYMmf7BOgFgqEbAitdZtXh2obynAWGZpw00192x3K2fIXoSvMedgvmui0/chAqN0VB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW1jG8sr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW1jG8sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB88C116C6;
	Thu, 22 Jan 2026 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101969;
	bh=2GaSI1ZarfWZAgJYchxVyiLuqUkxepqHbUHJa6Ki0CM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BW1jG8srzebJUtzUPYTZTYbBFxuinxdonwXyjeHS70wPwL/AaZpJ81Q/SR+Jeihju
	 HpyCGyU81xsvHiQrBQNrggfYa4gb5W+UDPf6n14XBdnUaKEqw3V2gCLp3R12hJjOnV
	 Ss5CMT9be0ZZF29iPuatb0tfwPY7UdpAW9Bqrv+G2r5YwEHb9h7Vm4No1niEe/4H1p
	 8/yGf8KYtP6tdL08qduzs7GlXFr8G4i3XYtAJUWbEw8er+c/HYJQKzwKlidKPA2Bwk
	 yrEvlR5m9XvTLvpvoYEHmR17cfuPB1fTIUDzXD5ML04PgzlpT9VJHLiIAsyR9R53fW
	 A2LZwyFH5VlIw==
Content-Type: multipart/mixed; boundary="===============6516459673309868924=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3079ef68368b1d573cd997363987554e24d444405c0d9765f073df1827d6eb32@mail.kernel.org>
In-Reply-To: <20260122160131.2238331-11-etsal@meta.com>
References: <20260122160131.2238331-11-etsal@meta.com>
Subject: Re: [PATCH 10/13] selftest: bpf: Add libarena stack allocator
From: bot+bpf-ci@kernel.org
To: etsal@meta.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,daniel@iogearbox.net,memxor@gmail.com,puranjay@kernel.org,song@kernel.org,etsal@meta.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 17:12:49 +0000 (UTC)

--===============6516459673309868924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/src/stack.bpf.c b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c
> new file mode 100644
> index 000000000000..37f8ce43e0f8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c

[ ... ]

> +static int stk_fill_new_elems(struct stk *stack)
> +{
> +	stk_seg_t *data_seg, *stk_seg;
> +	bool need_stk_seg;
> +	__u64 nr_pages;
> +	size_t nelems;
> +	int ret, i;
> +	u64 mem;
> +
> +	nr_pages = stack->nr_pages_per_alloc;
> +	nelems = (nr_pages * __PAGE_SIZE) / stack->data_size;
> +	if (nelems > STK_SEG_MAX) {
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * If we have more than two empty segments available,
> +	 * try to repurpose one of them into an allocation.
> +	 */
> +	ret = stk_seg_to_data(stack, nelems);
> +	if (!ret)
> +		return 0;
> +
> +	need_stk_seg = !stack->capacity;
                       ^^^^^^^^^^^^^^^^

Can the data_seg memory be leaked when capacity is non-zero but less than
nelems? The check here only allocates a new stack segment when capacity
is exactly zero. If, for example, capacity is 5 but nelems is 16, the
loop below will fail partway through stk_push() with -ENOSPC after
pushing only 5 elements. The remaining chunks from data_seg would never
be tracked.

Consider this scenario:
  1. Stack has one segment with capacity=5 (few free slots)
  2. stk_seg_to_data() fails since only one segment exists
  3. need_stk_seg = false since capacity > 0
  4. stk_get_arena_memory() allocates only data_seg (no stk_seg)
  5. Loop tries to push nelems (say 16) chunks
  6. After 5 pushes, stk_push() returns -ENOSPC
  7. Remaining 11 chunks from data_seg are lost

Should this be checking capacity < nelems instead of !capacity?

> +
> +	/* Get memory for a new data segment, and possibly a stack segment if necessary. */
> +	ret = stk_get_arena_memory(stack, nr_pages, &data_seg, need_stk_seg ? &stk_seg : NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (need_stk_seg)
> +		stk_extend(stack, stk_seg);
> +
> +	mem = (u64)data_seg;
> +	for (i = zero; i < nelems && can_loop; i++) {
> +		ret = stk_push(stack, (void __arena *)mem);
> +		if (ret)
> +			return ret;
> +		mem += stack->data_size;
> +	}
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21256973563

--===============6516459673309868924==--
