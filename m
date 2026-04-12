Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1736404F
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775965414; cv=none; b=Nu7FwZwhCXVmreI7RkKxMnDCcgc1UR+RWnGreh/KL5C6GM3sc6R1RuxBgAGIgmeGuSD9UfAGxenVh1fzIChE8KRrEypdt+i5mpQvOp+g3LBvskPie8rYl566XFROvYoI2Fd6yeGllyhrTrIa0n15/wDY0oTqZxuW3ShKqEM6sT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775965414; c=relaxed/simple;
	bh=6Z4nzhvmBWHI+rGl996YGtyFS5RDh7vkobljT3IDHw0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iWlSDZpG0NGt6lkPwzKz0mcoYYuri8zrOAXv1BIb2bgNEZAqtYUb5z+n4Sq8qsJLZrLEgnhDGFYoqbZXK9HGD3AfQQEeUfyPnqlxD+nxSxqYym51UebCjdTOG6w/7ArHfLSmVK5OahXbB5vukB5F5s/ahuXSdLI1OQeRIwii45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7ddE1cs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7ddE1cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D510EC19424;
	Sun, 12 Apr 2026 03:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775965414;
	bh=6Z4nzhvmBWHI+rGl996YGtyFS5RDh7vkobljT3IDHw0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=e7ddE1csVC5FyvkHsNw0KyZQ6mzophHqfzwwpMPZv9r/YbmkYZGyDofZ64/NKFHjy
	 Vuwpk+MwDz+jWZOWut5a+PSr19QYxK1HQFIIsGqAUHdMB+b8StKb0jQVkfimGzlAmZ
	 sCp4XBL1eFIe7MjUvAzQaoUXYMSdqK6QCAaaml6d3AdQGUxi/Sav74irydW6SxAL1e
	 d3apbE45OMLwu2tdvwL7l2gWzQqOVguPnx0w6/QtsePwyXOMuzv/EuzlUalwTNC+3/
	 eH2DcPeQQB+nUSAYL047AbzkHRqpfLvnbZtFsY1nxElKA3wW5Vf1zaVXJVDY/kzXlO
	 f/yR0nVgX/tcA==
Content-Type: multipart/mixed; boundary="===============8969052368686364737=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b9c4dea6cad92d46d23e299c8e46fc27d73751e3f3229143515ff1897cf10f3@mail.kernel.org>
In-Reply-To: <20260412031139.41248-4-alexei.starovoitov@gmail.com>
References: <20260412031139.41248-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: Move check_cfg() into cfg.c
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 03:43:33 +0000 (UTC)

--===============8969052368686364737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> verifier.c is huge. Move check_cfg(), compute_postorder(),
> compute_scc() into cfg.c
>
> Mechanical move. No functional changes.

The commit message says "Mechanical move" but bpf_compute_scc() in
cfg.c has had roughly 89 lines of comments stripped compared to
the original compute_scc() in verifier.c.  The code logic itself
is unchanged, but the following documentation was removed during
the move:

- Variable documentation explaining what stack, pre, low, and dfs
  represent
- Academic references to Tarjan [1] and Pearce [2]
- The algorithm invariant explanation and full recursive pseudocode
  (~73 lines)
- Inline annotations on the assign_scc logic:
  /* two or more elements? */, /* self reference? */,
  /* implicit loop? */
- The "Preserve the invariant" and "Pop component elements from
  stack" comments

For reference, the original had comments like:

    /*
     * References:
     * [1] R. Tarjan "Depth-First Search and Linear Graph Algorithms"
     * [2] D. J. Pearce "A Space-Efficient Algorithm for ..."
     *
     * The algorithm maintains the following invariant:
     * ...
     * Below implementation replaces explicit recursion with
     * array 'dfs'.
     */

The moved version in cfg.c retains only the function header comment
and a single "Visit 'w' successors" line.

Was this comment removal intentional, or were the comments
accidentally lost during the move?  This is a non-recursive
adaptation of Tarjan's algorithm using goto-based DFS emulation,
and the inline documentation was the primary explanation of the
algorithm's invariants and design decisions.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/bpf/cfg.c

[ ... ]

> +int bpf_compute_scc(struct bpf_verifier_env *env)
> +{
> +	const u32 NOT_ON_STACK = U32_MAX;

[ ... ]

> +	next_preorder_num = 1;
> +	next_scc_id = 1;
> +	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);

The variable documentation comment (what stack, pre, low, dfs each
represent) that was present in compute_scc() is missing here.

> +	for (i = 0; i < insn_cnt; i++) {

The ~73-line algorithm reference and invariant comment that appeared
before this loop in compute_scc() is missing here.

> +		if (low[w] < pre[w]) {
> +			dfs_sz--;
> +			goto dfs_continue;
> +		}

The "Preserve the invariant" comment is missing.

> +		assign_scc = stack[stack_sz - 1] != w;
> +		for (j = 0; j < succ->cnt; ++j) {

The "Assign SCC number only if component has two or more elements,
or if component has a self reference, or if instruction is a
callback calling function (implicit loop)" comment is missing,
along with the inline annotations /* two or more elements? */ and
/* self reference? */ that previously appeared on these lines.

> +		if (bpf_calls_callback(env, w))
> +			assign_scc = true;
> +		do {
> +			t = stack[--stack_sz];

The /* implicit loop? */ and /* Pop component elements from stack */
comments are missing.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24297693732
--===============8969052368686364737==--
