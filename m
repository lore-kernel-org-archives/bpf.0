Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED1199FAB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 04:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191256; cv=none; b=EZB/diaq9+b7+hEQ0u4wmBvaWYAhUWsVduk/c8ZOKg/C5Zc9mp72RhbtxLzYwHYvPEWWLmC9rNvqFVFn+3kjFmH4QToLHJrI5KkgDd6k5mMUpf5sQ8Ii43tOYhXloVE6+Ov41pyPPUHjlnVEIaZ+T/vIULtAxM6DBqsdU6EIQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191256; c=relaxed/simple;
	bh=MWVaqdKSZI3PZK3blWLS8vJ/Ie1P9FCj/HBD30OdcRE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tAO1E/GnjqwT6g+1+Z5/o71evmNzokudkX4S9KGxr4E+DdQso14olpipDEVau3el9zRtRIxzaeX8UIBA9sXE0pw2nKUZz7FIwZf+a93D5ib1chcIrKyw8NN8/TZmmh7aIooIfcZdUNro3++93At+37PqSBIyNFPFntGHIcw9iWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qan+CP56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qan+CP56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0344C4CEF7;
	Fri,  3 Apr 2026 04:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775191256;
	bh=MWVaqdKSZI3PZK3blWLS8vJ/Ie1P9FCj/HBD30OdcRE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Qan+CP56Nkyq7bvzs9hPnWezPwK0LCmRTBtsds9vJZA8REfYZLy0TTl0El1UdAhVK
	 LAlipXHK+MVmzeq/IZ/eHCA35DHI7umrN4Z6vwnLRL61sisgjieUXCeRK4XOICTQa6
	 BRa6witsRH7UknAC2twsGt6wGAMTqo+m/mmYUVxQyZ6TdsHfOJ5Ck1T4ns8uO0zR67
	 vUBVduhpmI9xcrw2T2xZP8ixYwXCs3WQQfQAt/8us/TZ1rvoCWoyAc91HQZSeGw4Cb
	 4a39A/dOZ8uCS9gXW/QkeIPaLR8yUnsUamDbprBZpgVVBb1MYp4N5IIRz9sNBhH7M3
	 mKfYhBqEb4yiw==
Content-Type: multipart/mixed; boundary="===============8732789530563756030=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c68e4e03b1be652ba9a5a76bc628ad03fec9269bd610c87414c40897528a8235@mail.kernel.org>
In-Reply-To: <20260403024422.87231-7-alexei.starovoitov@gmail.com>
References: <20260403024422.87231-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v5 bpf-next 6/6] bpf: Add helper and kfunc stack access size resolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 04:40:55 +0000 (UTC)

--===============8732789530563756030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 02b103118625..f43914cc5660 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +	case ARG_PTR_TO_MEM:

[ ... ]

> +			/*
> +			 * Size arg is const on each path but differs across merged
> +			 * paths. MAX_BPF_STACK is a safe upper bound for reads.
> +			 */
> +			if (at & MEM_UNINIT)
> +				return 0;
> +			return MAX_BPF_STACK;

[ ... ]

> +s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
> +				 int arg, int insn_idx)
> +{

[ ... ]

> +	/* ptr + __sz/__szk pair: size is in the next register */
> +	if (arg + 1 < nargs &&
> +	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
> +	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
> +		int size_reg = BPF_REG_1 + arg + 1;
> +
> +		if (aux->const_reg_mask & BIT(size_reg)) {
> +			size = (s64)aux->const_reg_vals[size_reg];
> +			goto out;
> +		}
> +		return MAX_BPF_STACK;
> +	}

Should this also check is_kfunc_arg_uninit() before returning
MAX_BPF_STACK, similar to how the helper function checks MEM_UNINIT?

When the size register is a known constant, the code takes goto out
where is_kfunc_arg_uninit() is checked and the sign is flipped for
write-only args.  But this fallback path bypasses that check entirely.

For a kfunc with a non-dynptr __uninit pointer paired with __sz,
where the size is not a compile-time constant, this would return
+MAX_BPF_STACK (read) instead of a negative value (write).  The
liveness analysis would then incorrectly treat a write-only buffer
as a read, potentially requiring stack slots to be initialized when
the kfunc is actually initializing them.

No current kfunc combines __uninit with __sz (existing __uninit
kfuncs are all dynptrs, handled earlier), so this is not triggerable
today.  Something like the following would match the helper's
handling:

	if (is_kfunc_arg_uninit(btf, &args[arg]))
		return 0;
	return MAX_BPF_STACK;

> +
> +	/* fixed-size pointed-to type: resolve via BTF */

[ ... ]

> +out:
> +	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
> +	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
> +		return -size;
> +	if (is_kfunc_arg_uninit(btf, &args[arg]))
> +		return -size;
> +	return size;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23931698891
--===============8732789530563756030==--
