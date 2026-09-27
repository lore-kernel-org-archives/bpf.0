Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653237BE6C
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541766; cv=none; b=m8snYF9o9bAuBD1Ckl3BLQg9BgM1/5N/4iYl5rV7JZlgnQN/+UbRXj9fW5ueEBEFAv3xvX0IESGUKxAy+gy0EXXEdfy0MxLmBao8SQH5P7DfjOvj3esM9UgFs0fJ1p6aA9aMWUWmB0Zt3giBGmpysdakMAxRqdChAij9GtnXKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541766; c=relaxed/simple;
	bh=NOkGwIenjNjk30UzlXE1oLqr71Ngk7ioNe7ayXECHxs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FGkjhopCKWQ5kTZWjg4PeVZnFBDXhULLhc24II2p7j2iaBlRPXWeRo4rnGPGkzP83CbuI4jT8e3qlWsxw3M24ctg8m/pWU9pu17HgoUvw50iE9aMkDmdNiXoYaxWrk7infvEUWBehwK/oqPNbxTqq3uABJiteNPqjCzO3Q2QFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLou+W+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLou+W+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAF01F000FF;
	Sun, 27 Sep 2026 20:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541765;
	bh=6YSd3HkaTH7eevBNlkrPRy28trxcu8k8mnqmIpPmDvo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iLou+W+FWgd1fvvIxo59Io6h2XL+dvPWKP3Ejbt/QeJWLh1mEftlqsqTB63oJbJjW
	 3qICNYxCX6Z9LhnsyCAX+VCT9iokX0bYmoMwKeb9I08h7g5KhTquAJ8R09flnPI/fk
	 l0kcc6WpYPjnGeGXhWP8LuzSVRpVUIQ8UkWJL3EYMS0hqxT/kNxyIJM+fdJ92rwLmU
	 zFzR7ahqgtftXmz4El8J5YzN1LrbzHRukHTwGE8no7fliy1g6bIKTj2isypz94VFNl
	 x/nZzswXbCcM7rJ9mjuTHISvrGjVXiUFLSNbKFBN7/Acv29KCXmOyx/Cpcr+0g1rEE
	 mzhQTQk9jo5jA==
Content-Type: multipart/mixed; boundary="===============3413850216712457221=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fbc569e51e53b47e086068dd5ede783b671becfa03da2a0b8f6ef0946286040b@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-18-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-18-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 18/36] bpf: compute immediate dominators
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:44 +0000 (UTC)

--===============3413850216712457221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 6a8157e607ee..5e6fa41a1353 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index c1f9b0d3468d..6210601eb40b 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile

[ ... ]

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> new file mode 100644
> index 000000000000..e7ff02e9ab3a
> --- /dev/null
> +++ b/kernel/bpf/loops.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/slab.h>
> +#include <linux/bpf_verifier.h>
> +
> +static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
> +{
> +	struct bpf_iarray *succ, *preds, **result;
> +	struct bpf_prog *prog = env->prog;
> +	u32 *num_preds, i, s, sz, len = prog->len;
> +	struct bpf_insn *insn;
> +	void *tmp;
> +
> +	num_preds = kvcalloc(prog->len, sizeof(u32), GFP_KERNEL_ACCOUNT);
> +	if (!num_preds)
> +		return NULL;
> +
> +	/*
> +	 * 'result' layout:
> +	 *  - array of pointers (struct bpf_iarray *)[len]
> +	 *  - struct bpf_iarray one after another
> +	 */
> +	sz = sizeof(struct bpf_iarray) * len;
> +	sz += sizeof(struct bpf_iarray *) * len;
> +	for (i = 0; i < len; i++) {
> +		insn = env->prog->insnsi + i;
> +		succ = bpf_insn_successors(env, i);
> +		sz += sizeof(u32) * succ->cnt;
                     ^^^^

Can sz overflow here?  It is a u32 with no overflow check, but for
programs with many gotox instructions the sum of edges can exceed
prog->len.  bpf_insn_successors() returns the whole shared jump table
for gotox (up to one entry per instruction in the subprogram), and
every gotox in that subprog adds that full count again.

For large privileged programs (prog->len up to BPF_COMPLEXITY_LIMIT_INSNS),
(number of gotox) * (jump table size) can make 4 * that product exceed
U32_MAX.

If sz wraps, kvzalloc(sz) returns a buffer smaller than what the next
loops write:

    result[0..len-1] pointers
    per-insn bpf_iarray headers
    preds->items[preds->cnt++] = i

and those writes run past the end of the allocation.

Even if sz does not wrap but exceeds INT_MAX, kvmalloc() WARNs and
returns NULL.

> +		iarray_for_each(s, succ) {
> +			num_preds[s]++;
> +		}
> +		if (bpf_is_ldimm64(insn))
> +			i++;
> +	}
> +
> +	result = kvzalloc(sz, GFP_KERNEL_ACCOUNT);
> +	if (!result) {
> +		kvfree(num_preds);
> +		return NULL;
> +	}

[ ... ]

> +static int idoms_intersect(struct bpf_verifier_env *env, int a, int b)
> +{
> +	int *postorder_nums = env->cfg.postorder_nums;
> +	int *idoms = env->idoms;
> +
> +	while (a != b) {
> +		while (postorder_nums[a] < postorder_nums[b]) {
> +			a = idoms[a];
> +		}
> +		while (postorder_nums[b] < postorder_nums[a]) {
> +			b = idoms[b];
> +		}
> +	}
> +	return a;
> +}

A review comment from v1 raised a performance concern here.  This walks
the idom chain one instruction at a time, and for a program with many
predecessors (for example, error handling with many "if (err) goto out;"
statements), the k-th call to compute_subprog_idoms() for an instruction
with N predecessors walks back over k branches.  That is N^2/2 steps,
and the outer loop runs at least twice, all before do_check() and for
every program regardless of whether it has loops.

The suggestion was to compute dominators only for instructions inside
loops (scc != 0) since SCEV only needs dominators inside loops, and
possibly to add a bound for large loop bodies.

Has this been addressed?

> +
> +/* See "A Simple, Fast Dominance Algorithm" by Cooper et al. for details. */
> +static void compute_subprog_idoms(struct bpf_verifier_env *env, struct bpf_iarray **preds, int subprog_idx)
> +{
> +	struct bpf_subprog_info *subprog = &env->subprog_info[subprog_idx];
> +	int start = subprog->start;
> +	int po_first = subprog->postorder_start;
> +	int po_last = (subprog + 1)->postorder_start - 1;
> +	int *idoms = env->idoms;
> +	int po_num, pred;
> +	bool changed;
> +
> +	idoms[start] = 0;
> +	changed = true;
> +	do {
> +		changed = false;
> +		/* iterate in reverse postorder */
> +		for (po_num = po_last; po_num >= po_first; po_num--) {
> +			int idx = env->cfg.insn_postorder[po_num];
> +			int new_idom = -1;
> +
> +			iarray_for_each(pred, preds[idx]) {
> +				if (idoms[pred] == -1)
> +					continue;
> +				if (new_idom == -1)
> +					new_idom = pred;
> +				else
> +					new_idom = idoms_intersect(env, pred, new_idom);
> +			}
> +			if (new_idom != -1 && idoms[idx] != new_idom) {
> +				idoms[idx] = new_idom;
> +				changed = true;
> +			}
> +		}
> +	} while (changed);
> +	idoms[start] = -1;
> +}

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 474caf8696fd..93100541475a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22815,6 +22816,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
>
> +	ret = bpf_compute_idoms(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +

bpf_compute_idoms() now runs on every program load before do_check(),
so none of the verifier's complexity limits apply yet.  The pass has a
quadratic worst case and nothing in it calls cond_resched() or checks
signal_pending().

The dominator tree is built per instruction, not per basic block, so a
node's depth in the tree is roughly the number of instructions before
it.  compute_subprog_idoms() folds every predecessor into new_idom
using idoms_intersect(), and the cost of each call is the tree distance
from pred up to new_idom.

For a program made of k instructions "if rX == 0 goto E" (fallthrough
to the next), followed by "E: exit", then idom(C_i) = C_{i-1} and
preds[E] = {C_0, C_1, ..., C_{k-1}}.  The call idoms_intersect(C_i, C_0)
walks i steps, so E alone costs about k^2/2 steps per pass.  The do/while
loop always makes at least one extra pass to confirm nothing changed, so
the total is about k^2.

With CAP_BPF, insn_cnt can be up to BPF_COMPLEXITY_LIMIT_INSNS (1M).
That gives about 1e12 pointer-chasing steps inside a single syscall.
The task cannot be killed during this time, and non-preemptible kernels
will report soft lockups.

The shape is not only adversarial: large programs where many checks jump
to one shared return block cost roughly (number of such jumps) x
(program length / 2) per pass.  For example, 50K checks in a 500K-
instruction program is about 1e10 steps per pass.  Unprivileged programs
are capped at BPF_MAXINSNS (4096), where the cost is small.

Other long-running verifier stages guard themselves.  do_check() checks
signal_pending() and calls cond_resched().  Liveness analysis has a
10000-call limit plus cond_resched().  The next commit in this series
adds "if (signal_pending(current)) return -EAGAIN; cond_resched();" to
compute_loops_in_subprog() "to guard against pathological inputs."

Should bpf_compute_idoms() have a similar guard?  Or could the tree be
built over basic blocks instead of instructions so the tree depth stays
small?

>  	ret = bpf_compute_live_registers(env);
>  	if (ret < 0)
>  		goto skip_full_check;

[ ... ]

> @@ -22978,6 +22983,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	kvfree(env->callx_edges);
>  	kvfree(env->func_ptrs);
>  	bpf_diag_free(env);
> +	kvfree(env->idoms);
>  	kvfree(env);
>  	return ret;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============3413850216712457221==--
