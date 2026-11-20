Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163098;
	b=BC7lH/4IR2Vm+5S3pQc6fQn1ZT7OJC9rGQ8JLHA+wk5i3rAx5VcyK0Avp8BobszUhPGo
	 sVtFfqtulqAs9wXIQxcUPxjphfEBruYFTO8cfqlg/4GRFZF4a+0L1P28o7fidcjXc/nLm
	 HzzcsjsL1VzgLSOszVL6ruKQCx1ScnDxGXC8Zphu80CLcCmfxcZrnzxbHNhQEFLR2IWba
	 UwzRPZijZ3tS8o94oVL1L7kMG+Y2hJjfOuOLvTPIPqd3/qPX+9rJxaAnSw2GjaMXvZjjy
	 8eTZL6M2i9bL6asjG1PqrDebKsz5/S2KZBCXf16IyvUoFEjVmBWlTRxYCFgzm2NoyVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163098;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=YU9ylf/kCZSb2VHQGmh+SUwMwe2nRmCdyAmJfmnPD9Y=;
	b=xHeqBWeXf5nibPL2K6M94l2Kj1A2lCGD8uLzLct0BUZrzhZPlr8h84mILJdcwDm6bS88
	 SnPX9DZ0mNLRHYUeqXus+NB4g23cnpWWcn6HaldXYq3vG2i5AgEIH6m6JIH8EIasq4BXc
	 doUPFXZE6mbE+S/1Zd7OKHTf0mKX0BnsX6E+KDafoYNadiQT5UdaASR3g6wxn5v3hOXm8
	 iz1rUJ6eH7aPDBHfzbTYPBF2qX64xHTeDnE5DB+HQAypec03UCcKcL2MdVkK1aNmiI/zh
	 5DqLVFGaeGFxtkoUfIVwiMqdfWJFQJPbAN6xzzULGJarNgyHd1KPE1my9Z/NXCaJpmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFnBEzcO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4E606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFnBEzcO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37451F000C6;
	Fri, 20 Nov 2026 08:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163097;
	bh=YU9ylf/kCZSb2VHQGmh+SUwMwe2nRmCdyAmJfmnPD9Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CFnBEzcOr/ghxqqhuYlQUjzulSbcF2wGRHCzxMKyfBDBghvaLlmTQTp1Ls7n+6o/T
	 ARc96Ma2LEPnCcfAtwSjjVgM7rADTXRXa3SFrbP9a4IEwx9JpvGrz5s78noDqzBEOm
	 8omZ/UQMbsdaRVuf1QLdy2yby3FZGSwunynw4b21RKo0BYFWMsB7IBc5PyHx+wxcL8
	 6WQavRnt13DLcsptbROO0PJHYZMf0libLP520k+NIEatK6RQzyrnZjZYfDwgRMzGVl
	 NAOTOAB/5Qem/mL7tzFJd5m0rOSe6Ue5dIQeGNdh6r826F3jvm+t0STc17g7Om/u4d
	 DLU7HzWUGFOtA==
Content-Type: multipart/mixed; boundary="===============1464693895278082949=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <42838758481927a54998a9e89f7178df75046ab58e5b696140608fe1b4ee3ab0@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-3-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 02/49] bpf: Make stack liveness faster
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:24:56 +0000 (UTC)

--===============1464693895278082949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Make stack liveness faster

TL;DR: arg_track_join_all() appears not to compile: 'same', bpf_add_cost() and
BPF_COST_* are undeclared until a later patch, breaking bisection; cost
accounting is also missing from the commit message.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -1103,9 +1111,18 @@ static bool arg_track_join_all(struct bpf_verifier_env *env, int idx, int target
>  	bool changed = false;
>  	int r;
>
> +	if (!arg_is_visited(&in[BPF_REG_FP])) {
> +		memcpy(in, out, MAX_AT_TRACK_REGS * sizeof(*in));
> +		memcpy(stack_in, stack_out, nslots * sizeof(*stack_in));
> +		return true;
> +	}
>  	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
>  		changed |= arg_track_join(env, idx, target, r, &in[r], out[r]);
> -	for (r = 0; r < nslots; r++)
> +	same = !memcmp(stack_in, stack_out, nslots * sizeof(*stack_in));
> +	/* a change pays for the next visit of @target too */
> +	bpf_add_cost(env, MAX_AT_TRACK_REGS + nslots,
> +		     same && !changed ? BPF_COST_COPY : BPF_COST_XREG);
> +	for (r = 0; r < nslots && !same; r++)
>  		changed |= arg_track_join(env, idx, target, -r - 1, &stack_in[r], stack_out[r]);
>  	return changed;
>  }

Does this compile?  arg_track_join_all() assigns and reads 'same', but the
only locals declared are 'bool changed = false;' and 'int r;'.

bpf_add_cost(), BPF_COST_COPY and BPF_COST_XREG also don't appear to be
defined anywhere in the tree at this commit.  A grep for bpf_add_cost and
BPF_COST_ only finds these two lines in kernel/bpf/liveness.c.

Since liveness.o is built whenever CONFIG_BPF_SYSCALL=y, this looks like it
would fail with "'same' undeclared", an implicit declaration of
bpf_add_cost(), and "'BPF_COST_COPY' undeclared".  The cost accounting and
the comment "a change pays for the next visit of @target too" aren't
mentioned in the commit message either.

This breaks bisection from this commit until a later patch in the series,
ecbd98bcc45a ("bpf: Limit the cost and the memory of a load"), changes the
declaration to 'bool changed = false, same;' and adds
BPF_COST_SCAN/COPY/XREG/INSN/STATE and bpf_add_cost() to
include/linux/bpf_verifier.h.

Could 'bool same' be declared here and the bpf_add_cost() call moved into
ecbd98bcc45a so that each patch builds?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============1464693895278082949==--
