Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33C44780F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241197; cv=none; b=F9ezUOumD1ZA6pZ2fx3v9dzqGga+Xeepy9II609V8uOgI+DyK/EwatrTxY9vP+kdXXuEAp1W5tWvz5PTRUC/KlmLshOWLVY2P2Ad0tVIdgMloJFr1U9BW858bOzyrwIeL+KDjuYtuC/nJFNUz/OCfZpSb6wZ+Y4yCbKNdGrt4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241197; c=relaxed/simple;
	bh=k/k/I6utFPO0qRSryhpLJYfFiN8TW3m0G/bWkrRCB2o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Id9R4OeKCyHHbMhyRXPEaQwyUhLzCpDWVJVJCiwWlZCUCTKRizZM5+Oku7rsAKBS/4PF+lPfXwJnb3RQb9AyiwahC1qmjEQ7+10091y4dVwVl/65H5u/wVCs1kG17WgjYDjcxdvAYBOSjvz6MQPPH6BPpjCuaIyX7Fefl2cZSH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb3mfLtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb3mfLtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4760A1F000FF;
	Thu, 24 Sep 2026 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241196;
	bh=VbA8gVJVcjvl7wAytwWb0OcCJnn8/0a21f2VZnyMsjE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Xb3mfLtcXOLzeIKWA6uyWmcyanYvIAi2Zy56/ivq7It14eWJZ4uSGo3IRVMHm3He9
	 3i9Rx56QzM3rp2gUG4mMHkXRkAXwO7C74w8vGA5p9WlMyL4s/X0NuxJlLuP8srSDkW
	 NazjS1JNxAo6hxa8pdKItXatq/X0g7TVUN+JAQKjl9tvCqZwM2vnm1PisXwEy5c8k2
	 fH2e/qxIa96I1QID5VxhLSI+YCJcGUp526ZDmlM9vHk8tOLbkCcmkq2YU9wcoVaSp7
	 uNKXRikpv1IAiDLYfWAnthVa+tJNvPEv7HaHKIW95V3Z66OcGnwGE2fJ07onsEyvxJ
	 apbNkWZJ4/wiQ==
Content-Type: multipart/mixed; boundary="===============1513684530648994538=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56e4ad0131706000fe1c09e8212e0fe834f91653a1090a9cf04011b2187c8e10@mail.kernel.org>
In-Reply-To: <20260924082607.2695649-13-memxor@gmail.com>
References: <20260924082607.2695649-13-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/18] bpf: Size the per-frame verifier structures for a 2 KiB stack
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 09:13:14 +0000 (UTC)

--===============1513684530648994538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 3ff1d4f753d3..f7964410f330 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -243,12 +244,13 @@ enum bpf_stack_slot_type {
>  #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
>
>  /*
> - * Largest number of BPF_REG_SIZE stack slots a single frame can have. A frame
> - * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth()
> - * enforces the bound on the combined depth of frames sharing the kernel stack
> - * and on each frame using a private stack.
> + * Largest number of BPF_REG_SIZE stack slots a single frame can have, sized
> + * for the largest stack budget any JIT supports. A frame may use any part of
> + * its program's budget; check_max_stack_depth() enforces the budget on the
> + * combined depth of frames sharing the kernel stack and on each frame using
> + * a private stack.
>   */
> -#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
> +#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK_JIT / BPF_REG_SIZE)

Can raising MAX_BPF_STACK_SLOTS to 256 cause an allocation overflow in
the arg tracker?

This change affects subprog_spill_slots() in kernel/bpf/liveness.c, which
sizes the per-instruction stack tracking:

kernel/bpf/liveness.c:subprog_spill_slots() {
    return clamp_t(u32, DIV_ROUND_UP(deepest, 8),
                   MAX_BPF_STACK / BPF_REG_SIZE, MAX_BPF_STACK_SLOTS);
}

Before this patch that was clamp(x, 64, 64), always returning 64. Now any
BPF_DW instruction with base R10 and a negative offset can push nslots up
to 256. The value feeds compute_subprog_args():

kernel/bpf/liveness.c:compute_subprog_args() {
    at_stack_in = kvmalloc_objs(*at_stack_in, (size_t)len * nslots,
                                 GFP_KERNEL_ACCOUNT);
}

with sizeof(struct arg_track) == 10.

This runs from bpf_compute_live_registers() before do_check_main().
The instruction checks in check_and_resolve_insns() and check_insn_fields()
do not validate R10 offsets, so an instruction such as
'*(u64 *)(r10 - 2048) = 0' in a program the main pass would later reject
still reaches this allocation with nslots == 256.

A bpf_capable loader may submit up to BPF_COMPLEXITY_LIMIT_INSNS
(1,000,000) instructions. For a single subprog with len >= 838,861 and
nslots == 256, or len == 1,000,000 and offset <= -1713 (nslots >= 215),
the size becomes len * nslots * 10 > INT_MAX.

The kvmalloc path checks this:

mm/util.c:__kvmalloc_node_noprof() {
    if (unlikely(size > INT_MAX)) {
        WARN_ON_ONCE(!(flags & __GFP_NOWARN));
        return NULL;
    }
}

GFP_KERNEL_ACCOUNT has no __GFP_NOWARN, so userspace can trigger a kernel
WARN (a panic with panic_on_warn). The load then fails with -ENOMEM instead
of the expected -EACCES or -EINVAL. The old worst case was
1,000,000 * 64 * 10 = 640 MB, below INT_MAX.

Even below the WARN threshold, the arg tracker now allocates and iterates
up to 4x more stack state (up to about 2 GB) for programs that will be
rejected at the 512-byte budget anyway.

Could the clamp bound nslots by the program's stack budget instead of
MAX_BPF_STACK_SLOTS, to match what the main pass will eventually allow?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35976322553
--===============1513684530648994538==--
