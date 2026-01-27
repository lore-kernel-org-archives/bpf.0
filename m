Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B536654F
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539768; cv=none; b=XxB70tAxF7Y4cDXJxf1JDhycCNBmBof67fvcvUZBjmHbK/UGtqzdsNufzHnwSbIHbgNnCkVslP49aasImMHDJKP71DDCxvlguqtTUwfYJOev5G9+UXpPdGkmO/8pdKxic4ZrH5gEdhOAF9CbqzN5A76iTVsKZPM7qwVSgzXWSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539768; c=relaxed/simple;
	bh=Hekz/XdU0p9dwy4/30AuTcTzkozJ9EeVWajUz+RbwYE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gK4Xe/7UTdEz5glavhz+TZH3j0byDxVXQiQhHPgIx3qNSjWnXqYMWXE4HqSBv2MPkjtH/BTAf/tnti7N4rKODYEo0Dp5dWa8afTeykkAxUuRr51r7mF4DDGwsahKTy9uGtMUJU7Hwpnr/QWGvuc286an/Cy3NnJ7laDuEOBWUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBPssHfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBPssHfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A62C116C6;
	Tue, 27 Jan 2026 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539767;
	bh=Hekz/XdU0p9dwy4/30AuTcTzkozJ9EeVWajUz+RbwYE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mBPssHfOO7ACdI79vh5+nQyLxEQtIEmOBshCWcyLHKdye+9TJbuL3kLpUeLlRO8xO
	 XbF2lPIfkGPHpsBsRD12qj9+8pmTelLIgbHJxIT1fowTzbgTm4YV1L9kDuBTJvDy42
	 FXZx/cE0tp5+XiZei/uk4M47/5X07Q93pY6AZ6omNTlqkU0rTjvVs1AjfuYl21d6oO
	 fR92b22qfmia3H1JWlSa/9vbzT+I8ja2Ooh8qEzmMCz6+8gyM7Z7Ou/7x7yNosXcq7
	 VYlBAG5a6dveuamdtX3maPG7znZ3hDQntT0DV+uM1i9BRK/pZt4ti8wErMt/VHUCoO
	 I0/I7gm0r43Fw==
Content-Type: multipart/mixed; boundary="===============7624522829942336336=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d262b70c3437d0ec81e3487afdf1bf5f242ee597ce3860f57620a1f820e8b5c@mail.kernel.org>
In-Reply-To: <20260127181610.86376-11-emil@etsalapatis.com>
References: <20260127181610.86376-11-emil@etsalapatis.com>
Subject: Re: [PATCH v2 10/13] selftest: bpf: Add libarena stack allocator
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,etsal@meta.com,ihor.solodrai@linux.dev,martin.lau@kernel.org,memxor@gmail.com,puranjay@kernel.org,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 18:49:27 +0000 (UTC)

--===============7624522829942336336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/src/stack.bpf.c b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c
> new file mode 100644
> index 000000000000..068cdd75bffc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c

[ ... ]

> +static int stk_seg_to_data(struct stk *stack, size_t nelems)
> +{
> +	int ret, i;
> +	u64 data;
> +
> +	/* Do we have enough empty segments for the conversion? */
> +	if (!stack->first || stack->first == stack->last)
> +		return -ENOMEM;
> +
> +	data = (u64)stack->last;
> +
> +	stack->last->prev->next = NULL;
> +	stack->last = stack->last->prev;
> +
> +	/* We removed a segment. */
> +	stack->capacity -= STK_SEG_MAX;
> +
> +	for (i = zero; i < nelems && can_loop; i++) {
> +		asan_poison((void __arena *)data, STACK_POISONED,
> +			    sizeof(struct stk_seg));

Should this be using stack->data_size instead of sizeof(struct stk_seg)?

The loop advances data by stack->data_size on each iteration, but poisons
sizeof(struct stk_seg) bytes. If data_size differs from sizeof(struct stk_seg),
the ASAN shadow map will be incorrectly populated. When data_size is smaller,
this over-poisons and can corrupt the shadow map for adjacent elements.

> +
> +		/* This operation should never fail. */
> +		ret = stk_push(stack, (void __arena *)data);
> +		if (ret)
> +			return ret;
> +
> +		data += stack->data_size;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int stk_get_arena_memory(struct stk *stack, __u64 nr_pages, stk_seg_t **data_seg, stk_seg_t **stk_seg)
> +{
> +	size_t nstk_segs;
> +	u64 mem;
> +
> +	_Static_assert(sizeof(struct stk_seg) <= __PAGE_SIZE,
> +		       "segment must fit into a page");

[ ... ]

> +	/* Poison the entire data segment allocated */
> +	*data_seg = (stk_seg_t *)mem;
> +	asan_poison((void __arena *)mem, STACK_POISONED, nr_pages * __PAGE_SIZE);
> +
> +	if (!stk_seg)
> +		return 0;
> +
> +	/* Skip the segment metadata when poisoning. */
> +	*stk_seg = (stk_seg_t *)(mem + nr_pages * __PAGE_SIZE);
> +	asan_poison((void __arena *)(mem + sizeof(**stk_seg)), STACK_POISONED,
> +		nr_pages * __PAGE_SIZE);

Is the base address for this asan_poison call correct? The stack segment is
located at (mem + nr_pages * __PAGE_SIZE), but the poison starts at
(mem + sizeof(**stk_seg)). With nr_pages=4, the stack segment starts at
offset 16384 from mem, but this poisons starting at offset 4096.

The comment says to skip the segment metadata, so the intended poisoning
should start at the stack segment address plus sizeof(**stk_seg), not at
mem plus sizeof(**stk_seg). This appears to poison part of the data segment
and the beginning of the stack segment incorrectly.

> +
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21409286496

AI-authorship-score: low
AI-authorship-explanation: Code shows typical human patterns with domain-specific BPF arena knowledge and standard kernel coding style; bugs found are typical human errors rather than AI-generated patterns
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Two ASAN poisoning issues in selftest code that could cause incorrect shadow map population but do not affect production kernel behavior

--===============7624522829942336336==--
