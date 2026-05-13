Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B53A5E73
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650402; cv=none; b=jP9AE9ERxuFIZb0+3THEvxSmLhwDojS7tXQIkpoc7v6Eha8wgYpUcNwqhohYQUIyzjqNR6zYQdT1ceF4HkeBuvIAkbprlo4jIWtvjWNSHXPAnIJX/bLEtTZQ58RsGucLSZVlmShapyb2dFULNnfc9E3tjomth1Idrt9gu85qY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650402; c=relaxed/simple;
	bh=Ahad82rB0aJB3f4Q5+M9sq/zFXM+bGCMryp80ymPq4I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aeuUU4CuPO6jdhuzsbmRk0fjcGVVxCHzvtN+g/REom4MMRXoNfE3VY7kd+0233gVEy9N1gYILanCmTa1rp+y7DwTjyqwDbui9oSgc2Z5FuXxUfri0kxBIooOZOHp4S9+N8yyWOKWdYCEC5/xZ9X0uEr9ysCa+ni9G1tiDe8v61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX/2Blsb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX/2Blsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B765C2BCB7;
	Wed, 13 May 2026 05:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778650401;
	bh=Ahad82rB0aJB3f4Q5+M9sq/zFXM+bGCMryp80ymPq4I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NX/2BlsbVG2RH3GTFPCueRMcoEFcqtsZpcF/S9BtXULL+MpZx7IDGwUpHeekvnNwL
	 i5Z+AVcKVH3l1eHMPHOVFocyEQHENWNZr1st0+ggYegTEtJ9DoK6iTm3cnoyDpLnNX
	 pbydu9+AswTtNCLrxG7yFcOPKkjgayk7iKuuJ5njS8KPxEiWH81GXCXJBr1I8kH2Rb
	 q4qOEac549jqT42cEkrPYmgMFBsah6wOS3VGRlHneCObviv9VTO2+2Wczgbri2I1HO
	 UQjaGGil0PmLiGnknYemRgAn3BoC5QXh7US5FEeRStKH9SKUQ2mmx0GehzaRz7c3XW
	 TSL7ip9jGV1lA==
Content-Type: multipart/mixed; boundary="===============6920635220618322342=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9bfedae86bb689da9b57e49faadd66bd2b878483d7576930f3525919d9cf4071@mail.kernel.org>
In-Reply-To: <20260513045054.2390945-1-yonghong.song@linux.dev>
References: <20260513045054.2390945-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 12/25] bpf: Prepare architecture JIT support for stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 05:33:21 +0000 (UTC)

--===============6920635220618322342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 918d9b34eac6..a515a9769078 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4fb8641546b8..17d4ab0a8206 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7870,8 +7870,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  			MAX_BPF_FUNC_ARGS, tname, nargs);
>  		return -EFAULT;
>  	}
> -	if (nargs > MAX_BPF_FUNC_REG_ARGS)
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +		if (!bpf_jit_supports_stack_args()) {
> +			bpf_log(log, "JIT does not support function %s() with %d args\n",
> +				tname, nargs);
> +			return -EFAULT;
> +		}
>  		sub->stack_arg_cnt = nargs - MAX_BPF_FUNC_REG_ARGS;
> +	}
>
>  	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
>  		bpf_log(log, "global function %s has %d > %d args, stack args not supported\n",

Is there an issue with the error code ordering here? Looking at
btf_prepare_func_args(), the code checks JIT stack argument support before
checking if the function is global.

For global functions with more than 5 parameters on architectures without
JIT stack argument support, the code returns -EFAULT at the first check
instead of -EINVAL at the second check.

According to the function's documentation comment, EFAULT means "there is
a verifier bug" while EINVAL means "cannot convert BTF" (invalid program).

Global functions with more than 5 arguments are always invalid regardless
of JIT capabilities, as stated in the second check's error message: "stack
args not supported". This is a user error, not a verifier bug.

Should the global function check come first to ensure it returns -EINVAL?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25779371388
--===============6920635220618322342==--
