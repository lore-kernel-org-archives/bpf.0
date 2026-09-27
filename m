Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91F3BCD2E
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540817; cv=none; b=JWjBqMHhLSMDfp1FPzBensYkQ/12jKh8i50CaEpTfkCC7DuAlxQAyDj5xId7SB0OYk65j+wLoteqefW1GeHzbEUmIbI+1DT7kjUWUWMaVq9fFDAY6/UD2Oh99Gp7uU3xkZfDdEek2aFjxg2fPLPcVrJVITSWSsSCcAXmvgD3hSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540817; c=relaxed/simple;
	bh=IicgNVp2enNBDvZF3ynOP8idue6mxhOOI62/+ugFqYc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YA4XoaL9C8HxnoTVkkdpjqoThWt1XaxsoPdVAkPsGM1QuqwtPYf/AyvOnjpchQV+DEHWCyggRMNhQcZOQwV8/4PbogmcucnbHI+ae/v3X6jcGCvnOWdwnDXKib0Rmo2iUm9k4jpS7pqx7rEyeOSUy9B0oaurqqWkmEj/Wtc6IXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWJhM/Gl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWJhM/Gl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346E1F00898;
	Sun, 27 Sep 2026 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540816;
	bh=Aic2dyQgNA2Xm/s3RxGF5YHMIyHgvZ0A0EVU538+msk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NWJhM/Glh2grwvtb8V8pDOikadZPYBGVBEjVIELmoL4GD1X5UjQM00PGoHwIIWWw+
	 vW6OydZmCfPpRB3ybGgbz+VM63gj+KtXZWlZexowNGmPGEQs6cYqUSVK3Sev7GoXft
	 BKQjf9+9R+ZtelJMkODz6vOcNw1D++1aHD42LWIdz4XxfexXC8RtVBUKwvw9gbCxmf
	 hKSLrm5WfvoYdIlzzTM79KhjfPU9EuXH2DhqjBiiep5z6iXi8TSTxfQ7zhWXYx2hux
	 E7w6ma8dnmr1aQ2nkmA+M6t3Ms3Y50Sq6bkDmUOeHYhlwbPNNxccQQZGdUDNU4Fy/0
	 FFa+J0OQH8pZw==
Content-Type: multipart/mixed; boundary="===============4041373185506289612=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63c2e3ef04c1bc001f0c64c4dc4a495812ffeceabb2e5e4b18d781a52ab1da76@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-20-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-20-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 20/36] bpf: add a min-heap for ordered analysis worklists
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ezingerman@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:26:55 +0000 (UTC)

--===============4041373185506289612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d8142f1b2347..f2497236542c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1916,4 +1916,21 @@ int bpf_compute_loops(struct bpf_verifier_env *env);
>  int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
>  bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
>
> +/*
> + * Simple binary heap implementation as described by
> + * https://en.wikipedia.org/wiki/Binary_heap
> + */
> +struct bpf_min_heap {
> +	int (*compare)(int, int, void *); /* ordering function for @elements */
> +	int *elements; /* min-heap ordered by @compare */
> +	void *arg; /* 3rd argument passed to @compare */
> +	int capacity;
> +	int count;
> +};
> +
> +void bpf_min_heap_init(struct bpf_min_heap *heap, int (*compare)(int, int, void *), void *arg);
> +void bpf_min_heap_free(struct bpf_min_heap *heap);
> +int bpf_min_heap_push(struct bpf_min_heap *heap, int elt);
> +bool bpf_min_heap_pop(struct bpf_min_heap *heap, int *elt);
> +
>  #endif /* _LINUX_BPF_VERIFIER_H */

[ ... ]

> diff --git a/kernel/bpf/heap.c b/kernel/bpf/heap.c
> new file mode 100644
> index 000000000000..029f9217b872
> --- /dev/null
> +++ b/kernel/bpf/heap.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf_verifier.h>
> +
> +/* Indexes for binary tree encoded as an array */
> +static inline int left_child(int i) { return 2 * i + 1; }
> +static inline int right_child(int i) { return 2 * i + 2; }
> +static inline int parent(int i) { return (i - 1) / 2; }
> +
> +static inline int greater(struct bpf_min_heap *heap, int a, int b)
> +{
> +	return heap->compare(a, b, heap->arg) > 0;
> +}
> +
> +void bpf_min_heap_init(struct bpf_min_heap *heap, int (*compare)(int, int, void *), void *arg)
> +{
> +	memset(heap, 0, sizeof(*heap));
> +	heap->compare = compare;
> +	heap->arg = arg;
> +}
> +
> +void bpf_min_heap_free(struct bpf_min_heap *heap)
> +{
> +	kfree(heap->elements);
> +	heap->elements = NULL;
> +	heap->capacity = 0;
> +	heap->count = 0;
> +}
> +
> +int bpf_min_heap_push(struct bpf_min_heap *heap, int elt)
> +{
> +	int new_capacity, i;
> +	int *elements;
> +	void *tmp;
> +
> +	if (heap->count == heap->capacity) {
> +		new_capacity = heap->capacity ? heap->capacity * 2 : 16;
> +		tmp = krealloc(heap->elements,
> +			       sizeof(*heap->elements) * new_capacity,
> +			       GFP_KERNEL_ACCOUNT);

This isn't a bug, but could the SCEV worklist use the existing
include/linux/min_heap.h helpers instead? The worklist is capped at
env->prog->len entries and min_heap's less() callback already takes a
context pointer. If there is a reason it doesn't fit, could the changelog
say what it is?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============4041373185506289612==--
