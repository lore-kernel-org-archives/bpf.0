Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374BF39A076
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885748; cv=none; b=twKihinRoyPfPO4krORJDXZMRB9fghSaEqorsY0yfGnFcnfpNtLC5tG/g6OZsjyvyYaZakUh0mQkVg+VsFtHjVIbQy0zMs2iFwnguoHT3gIyI2FnYOarF5re+Sl4EIsfJJ17XGk5yck2VcqymDj70Ce3NjwnYB/b3eGsW14Qj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885748; c=relaxed/simple;
	bh=t3OLxi3ZO7+RPqMvTCxgW/gBWGsLJdteOITV2RW5ZNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lYxbslJj4sxBXbPDQSWpg1hDMv5n8cVs6laH/10QADda7idkh7qE8xBaGP7AI832tugH2B+DjxMY2xhxa2XqQLRfI4CF2yTrz85+z8U78qgyXvTv19Qg/zf7IrX/88f+VCR673Ox4mxNo3Z/dwMfy/kzOT3t17eUHMvsU+Y7cMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oNE4PKj9; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oNE4PKj9"
Message-ID: <71e09ab5-c1ed-4ff6-9d90-deaac3ab9e5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778885744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24xzeSyBnkgnU2gOWhEeqUqEnxlcZndFwVzCDtNxBd4=;
	b=oNE4PKj9C4U9CG3e0FX1jzYuApsEo34TfgTeuZ8frfSdCfAScjeo0h5I4suZWkizod4Mf0
	JCquhAEiA85N6SAwBxnmBRtaehI8O1EW3NUCPpi3KHjBxDcd0F1steSs+EdJgYB01/SbRW
	D7HBIS9vmdaJl+JSVFitsTMPHfdnqXI=
Date: Fri, 15 May 2026 15:55:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Validate outgoing stack args when
 btf_prepare_func_args fails
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260515014958.1186132-1-yonghong.song@linux.dev>
In-Reply-To: <20260515014958.1186132-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 3:49 AM, Yonghong Song wrote:
> btf_prepare_func_args() sets sub->arg_cnt before validating arg types.
> If validation fails (e.g. unsupported pointer type in a static subprog),
> check_outgoing_stack_args() is skipped because btf_check_func_arg_match()
> returns early. For static subprogs, check_func_call() ignores non-EFAULT
> errors and proceeds with the call.
>
> This causes the callee to read stack arg slots that the caller never
> stored or not initialized, potentially dereferencing NULL caller->stack_arg_regs
> or getting no-initialized value.
>
> To fix the issue, when btf_prepare_func_args() fails and the subprog expects
> stack args, call check_outgoing_stack_args() to verify the caller initialized
> the slots. Return -EFAULT on failure so the error is not ignored.
>
> Fixes: 3ab5bd317ee2 ("bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   kernel/bpf/verifier.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> Changelogs:
>    v1 -> v2:
>      - v1: https://lore.kernel.org/bpf/20260514184827.1619863-1-yonghong.song@linux.dev/
>      - Remove Reported-by (Sashiko) and add Fixes tag.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 76a07f09ab64..8dd79b735a69 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9118,11 +9118,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>   	struct bpf_func_state *caller = cur_func(env);
>   	struct bpf_verifier_log *log = &env->log;
>   	u32 i;
> -	int ret;
> +	int ret, err;
>   
>   	ret = btf_prepare_func_args(env, subprog);
> -	if (ret)
> +	if (ret) {
> +		if (bpf_in_stack_arg_cnt(sub) > 0) {
> +			err = check_outgoing_stack_args(env, caller, sub->arg_cnt);
> +			if (err)
> +				return err;
> +		}
>   		return ret;
> +	}
>   
>   	ret = check_outgoing_stack_args(env, caller, sub->arg_cnt);
>   	if (ret)

Please ignore this patch set. There are more issues related to stack arguments.
I have consolidated them into v3:
     https://lore.kernel.org/bpf/20260515225035.821178-1-yonghong.song@linux.dev/

