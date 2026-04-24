Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09773E717C
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053640; cv=none; b=fR5HEd8cvsioGUpzRn3j6cz6FTirY9k8U97Omu30EJrB6eoEFsk+dy5byST+TZZAvmgVgaVHc//HU3y4viXGApuuw8MXP6W9auBXzjIalL7anX+R/b4BwJEyz1ojHFN1VX7nRVyRG0EIks11K4QhQU5QD1qj5Fi8RsAX03x73CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053640; c=relaxed/simple;
	bh=OiIMs6ikhWyoKP/sPVc7vWgwpMJlPsRVX+3Y9FIDuRQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZA7DzZChnbDp8j2d2eGLRiZfZA315tyxtiG1RCr+zDD8/1M3aakaki3DbZqSjTXGUSP+NvCnooJz12lA1anU4w7szjNoFo69hUEVgV0PQ5qoSMNu3uJQLwSeY1S8yJ2RxATbz2SH8n+eh9zIX/gsbaiLKP2ovo++Rvc0PrbUZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A59khWSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A59khWSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB5DC19425;
	Fri, 24 Apr 2026 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053640;
	bh=OiIMs6ikhWyoKP/sPVc7vWgwpMJlPsRVX+3Y9FIDuRQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=A59khWSgk1Tg/eB6az1hUapb18oC0vaVRMwucISJ9gh4up5xekcbidOJEHL6cBBcE
	 WaAxL688jlrMGr98YCnGYIzw+QaKtBIoMJKTJwydncgFJ00+l4eFbMQwK49FlQq679
	 ZK/wjME6b5VMvJsPpKP8IREpNP++IgjuhGchxgDMUJc+yfo4uSAI62ZC9oC6V/aLAd
	 8VihgVA2c0cOfvXIbNTRi87FW8BWkSiSUbNUgVMVtwSGlYh0OnRXiM56FbN9OngnhP
	 GaT9F3edzO6iMs0XL73bJU2HkLWQn3RwMlBygG98yrCgMcxCOkHVAhH92gwAZGqqKg
	 F0yyVaVp2R/Hg==
Content-Type: multipart/mixed; boundary="===============8334193108733703911=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <623062b9f2f97ecc1146e935d3522ed7c42d32a5251111fae771ea8ad796ab98@mail.kernel.org>
In-Reply-To: <20260424171514.2041929-1-yonghong.song@linux.dev>
References: <20260424171514.2041929-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 08/18] bpf: Support stack arguments for kfunc calls
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 18:00:40 +0000 (UTC)

--===============8334193108733703911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6994536b4e04..43aeb04f488a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12304,7 +12314,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  					reg_arg_name(env, argno));
>  				return -EINVAL;
>  			}
> -			ret = mark_chain_precision(env, regno);
> +			if (regno >= 0)
> +				ret = mark_chain_precision(env, regno);
> +			else
> +				ret = mark_stack_arg_precision(env, i);
>  			if (ret < 0)
>  				return ret;
>  			meta->arg_constant.found = true;

[ ... ]

> @@ -12329,7 +12342,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			}
>
>  			meta->r0_size = reg->var_off.value;
> -			ret = mark_chain_precision(env, regno);
> +			if (regno >= 0)
> +				ret = mark_chain_precision(env, regno);
> +			else
> +				ret = mark_stack_arg_precision(env, i);
>  			if (ret)
>  				return ret;
>  		}

In the v6 review, Sashiko AI pointed out that setting reg->precise = true
without calling mark_chain_precision() breaks data-flow backtracking. The
concern was that if only the current state's flag is set, parent states and
source registers that populated the stack argument won't be marked precise,
potentially allowing incorrect state pruning when execution paths merge before
the stack store.

The author acknowledged this issue in the v6 discussion with "You are right.
Let me think how to resolve this." However, the current v7 code still calls
mark_stack_arg_precision() for stack arguments in check_kfunc_args().

Does mark_stack_arg_precision() properly handle backtracking through parent
states? Looking at the two locations where stack argument precision is tracked:

check_kfunc_args() for is_kfunc_arg_const_mem_size():
    if (regno >= 0)
        ret = mark_chain_precision(env, regno);
    else
        ret = mark_stack_arg_precision(env, i);

check_kfunc_args() for KF_ARG_PTR_TO_ALLOC_BTF_ID with is_ret_buf_sz:
    if (regno >= 0)
        ret = mark_chain_precision(env, regno);
    else
        ret = mark_stack_arg_precision(env, i);

Is mark_stack_arg_precision() correctly marking parent states and the source
registers that stored values into the stack argument slots, or does it only
mark the current state as the v6 review suggested?



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============8334193108733703911==--
