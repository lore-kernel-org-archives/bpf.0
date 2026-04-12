Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C244C6D
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969274; cv=none; b=ElWfcJRowP0Y92A0rqUTvpOOybpdS6qqxcNK0vcAWdcN5ML5BAbTOZDDGCQnmrEvVmx7Z+7IGPNNql4iFkdZFqih/l5i5rsjdt/KaxeZB4OiN/15QjgzA2zSmnzTwn9S/QS4p2U+ONCk3+6gKv6eFHRRtoEF5pd4uJYUjkQAAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969274; c=relaxed/simple;
	bh=IomUSxZUiXBqcQzGcb9XZ01M4NN0S4HgjEhQCpnvUkw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kUTiyr3MmzLj1/g0qelqZyH3rYilHthScTqwG1/rBenVHLMPOjDWF1M+8DfBSsvvr8BLXvUvGQkDAxesI6C81lXQu9eyOR4icCw5+SXYlF02uL3xn6eT1C9ro/Dt1XQxT7MAa/DNxno6VWw8MM810g6RtIqYKh9bCprwIZaM3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVwfhpnj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVwfhpnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D82CC19424;
	Sun, 12 Apr 2026 04:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775969273;
	bh=IomUSxZUiXBqcQzGcb9XZ01M4NN0S4HgjEhQCpnvUkw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aVwfhpnjBtYJ2kvsCnmW/pIji4QZLyM1VMrSCasUvURzQVqu9/BVct31uKEWn0+N0
	 Voq1+C4py9RKrgopFngb6gf22vEsMcwLxb8boaUDUurCcEZGQNLH2HPTnaZkaI7T2h
	 5QhKmGvE7sS96akQsUrBaUlFaUy/IXEE02LAT1NyjCYtmEoKq4z10Z+E088GDX7Zy6
	 PwQme2omJpsN0Ngc3ZQK26IdhSzz0ng8/HAtlIuFpu0WmeZnrIgOHrS8pgwATpzz/a
	 Z9P5dp+LC5Tt7rIYQrwqDonxGKWvC0Ip1HM1bMGYn9lVUEQ30w664ff+7wIBK4Ps1E
	 RLLBkD25tWzcA==
Content-Type: multipart/mixed; boundary="===============2827765975791998502=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2ff758e4ce8ee3924f231e2ca37a08b833b3b95160344e01c623e71c35a3e0db@mail.kernel.org>
In-Reply-To: <20260412035945.46916-4-alexei.starovoitov@gmail.com>
References: <20260412035945.46916-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Move check_cfg() into cfg.c
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 04:47:53 +0000 (UTC)

--===============2827765975791998502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> --- /dev/null
> +++ b/kernel/bpf/cfg.c

[ ... ]

> +/*
> + * Compute strongly connected components (SCCs) on the CFG.
> + * Assign an SCC number to each instruction, recorded in env->insn_aux[*].scc.
> + * If instruction is a sole member of its SCC and there are no self edges,
> + * assign it SCC number of zero.
> + * Uses a non-recursive adaptation of Tarjan's algorithm for SCC computation.
> + */
> +int bpf_compute_scc(struct bpf_verifier_env *env)
> +{
> +	const u32 NOT_ON_STACK = U32_MAX;
> +
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	const u32 insn_cnt = env->prog->len;
> +	int stack_sz, dfs_sz, err = 0;
> +	u32 *stack, *pre, *low, *dfs;

[ ... ]

> +	next_preorder_num = 1;
> +	next_scc_id = 1;
> +	stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	pre = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	low = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	dfs = kvcalloc(insn_cnt, sizeof(*dfs), GFP_KERNEL_ACCOUNT);

The commit message says "Mechanical move. No functional changes." but
the original compute_scc() in verifier.c had extensive algorithmic
documentation between these allocations and the main loop that was
not carried over. The removed comments included:

- The variable purpose descriptions for stack, pre, low, and dfs
- References to Tarjan [1] and Pearce [2] papers
- The algorithm invariant explanation
- A full recursive pseudo-code (~35 lines) showing the readable
  version of this goto-based iterative adaptation
- A note that this implementation replaces explicit recursion with
  the dfs array

Were these comments intentionally removed, or were they lost during
the move?

> +	for (i = 0; i < insn_cnt; i++) {

[ ... ]

> +		while (dfs_sz) {

[ ... ]

> +			if (low[w] < pre[w]) {
> +				dfs_sz--;
> +				goto dfs_continue;
> +			}
> +			assign_scc = stack[stack_sz - 1] != w;
> +			for (j = 0; j < succ->cnt; ++j) {
> +				if (succ->items[j] == w) {
> +					assign_scc = true;
> +					break;
> +				}
> +			}
> +			if (bpf_calls_callback(env, w))
> +				assign_scc = true;
> +			do {
> +				t = stack[--stack_sz];
> +				low[t] = NOT_ON_STACK;
> +				if (assign_scc)
> +					aux[t].scc = next_scc_id;
> +			} while (t != w);

Similarly, the inline comments that were present in the original
compute_scc() are missing here. The original had:

  /* Preserve the invariant: ... */    before the low[w] < pre[w] check
  /* Assign SCC number only if ... */  before the assign_scc logic
  /* two or more elements? */          after assign_scc = stack[...] != w
  /* self reference? */                after the for loop over successors
  /* implicit loop? */                 after the bpf_calls_callback check
  /* Pop component elements ... */     before the do/while loop

This is a non-recursive adaptation of Tarjan's algorithm using goto
for simulated recursion, and the inline annotations helped explain
what each code block corresponds to in the standard algorithm.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24298494828
--===============2827765975791998502==--
