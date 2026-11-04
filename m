Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758370;
	b=j+ckiBr1ZCy2lLCLYDnv/TVGtDXcdeW6nW6k7P+P8KP4EMpjwEJ6x50QviY9yJTwOPNc
	 r5VsxkMFNV4shihrf7Tea4zHYfQaIy2ty8QkdQnN3O36mOYcReumDr7OMuGFI8RTloUwu
	 oQO9AGO8E3j8U42hpiyFrzCy0WSZiv+up9UCJvhBXg8LJCg4ahX4UVhFSss+XAn/KcLHz
	 ZNbz25u/X8f5IFIfTWUHDaaIoVXAZ/CRasTa8qRbGy+E1XLsPWrNgrv44XAPD2DHQRoKM
	 PToe4RnedV9IkA5DL33eOodxPvG5clPQDYrIPVYbIxWj+zCH3wDYjcqvC79iT2qDl5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758370;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=sSMkGs+FM31LQn6NU9vxaAtCTdBlQc1g2P1KFfFuEwA=;
	b=fhH4ygs6GZDdiIKmgrIgP8UlNRBO4FBsgNupdMtn8QBilStAzWMFmHWtVpgS5BFfVTTO
	 fBN2qiP/Peca16UXxVH585kOa43m//LUhxOgTe53IPwoT2Ou4UPC/p3GxgbULnTakbrr/
	 ybaVbtzJAPwQUhKwrcRJBc6Mn/LZO4DF2fYZPVgXZLQmDkesZ9QbcgW6TTj4mWfgZdTW8
	 oNuibtbEhKFZnzVxi8dDtcqDb8JRkloqg0u9ZJH3PXxXUJjLM47WZDhLMYU12Ve46+9SB
	 FOEUIu2KXLiA5plSuOxnZURcfdj3RwmfsUxHTMu4BguUsAdAUFIorWcp87ZnGXCzOWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifqHLmH+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D272606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifqHLmH+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952851F000C1;
	Wed,  4 Nov 2026 02:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758369;
	bh=sSMkGs+FM31LQn6NU9vxaAtCTdBlQc1g2P1KFfFuEwA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ifqHLmH+nH6VjoeXeyknC3g7rxNoiEAj7cyjZkCCD6b7SQWx1438LTerVao2Ajudy
	 yRBJ8B06DjvtEGuFg7RqJbivPZG2jqKdSu8+RmZ/n+zLbBe+UYqSYUj1b9ZuXG8pGX
	 HF+U8+uXdFsEUmE2gLLtFa7K7HdmY636P5P5hQyODhLPjxJr/fl9P6UpI1nFth+TNk
	 54PcNCmn5VJoFEKqAW8jhgfnfdjmvEW/95uKurw/PvQLa9EYoauKsPo8BBcOdccmNs
	 m6ter9dQGZVEJ1PEzzybpMVPmAhOJny7HFnNmACpNBcIKL1UVyXtRQh/jhWROuimDJ
	 kuht7H4i/OwXQ==
Content-Type: multipart/mixed; boundary="===============4312699437886039344=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <80c599809cfc3fbcfa077d05c36283e64225f6340c30ecb08407210c74e438ae@mail.kernel.org>
In-Reply-To: <20261104012401.1354861-15-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-15-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 14/14] selftests/bpf: Add tests for BPF_REG_ARENA_SP
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 02:12:49 +0000 (UTC)

--===============4312699437886039344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for BPF_REG_ARENA_SP

TL;DR: Nit in selftests: the r12 instruction macros (ADJ, LDX, ST) are
duplicated across several arena_stack test files, some hand-encoded. Suggests
moving them to one shared header.

> diff --git a/tools/testing/selftests/bpf/progs/arena_stack_grow.c b/tools/testing/selftests/bpf/progs/arena_stack_grow.c
> new file mode 100644
> index 000000000000..be64296431c3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/arena_stack_grow.c

[ ... ]

> +/* Compilers don't know r12 yet */
> +#define R12 12
> +#define ADJ(n)		BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, R12, 0, 0, n)
> +#define LDX(dst, off)	BPF_RAW_INSN(BPF_LDX | BPF_MEM | BPF_DW, dst, R12, off, 0)
> +#define ST(off, imm)	BPF_RAW_INSN(BPF_ST | BPF_MEM | BPF_DW, R12, 0, off, imm)

This isn't a bug, but this block of r12 insn macros (R12, ADJ, LDX, ST) is
the same as the one in arena_stack.c, while arena_stack_loop.c and
arena_stack_nomem.c write the same encodings out by hand, e.g.
__imm_insn(adj, BPF_RAW_INSN(BPF_ALU64 | BPF_ADD | BPF_K, 12, 0, 0, 16))
with a "r12 += 16" comment.  verifier_arena_stack.c defines a third,
size-taking variant.

Could these macros live in one shared place, for example bpf_misc.h or a
small arena-stack header, so that arena_stack_loop.c and arena_stack_nomem.c
can use ADJ(16) like their neighbours, and the encodings can be dropped in
one spot once compilers emit r12?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41755299448
--===============4312699437886039344==--
