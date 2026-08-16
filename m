Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72717D6
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786847459; cv=none; b=B0QeOemFmmRF9DuwUjX7zkCOsRzE355K+Yy6Oe96SC5eD7PRZ2VupZwInfFYCnijh1OsCXdll78E0S5g2B9udLu6b6Lhgqwzxf+joetN+izLaatWX7LwToRhxpPdm0MmMbrGIoK3ast+aTTiHucWtiNrH7BhRA99WcACNJQND/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786847459; c=relaxed/simple;
	bh=SI34KR7SYAklraOFaRjI2292sZFsjlzav3BfTV/dHwE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KVqE29czkGZnO/OYGmIyyOPo/LHL+07BuFHwdK7IB1PstUGmGsKGW1NmlYv6euKSCVTDM83ruSS8O6q7rMEpMQAwFfLText/dboHMRv+7MZNGXTt0GxBc2qVigrEBYzXMAwwvaOkPC7x3hIhf1dmmjl1TsCVDJ1+NvNEJ7T81jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAxT3lFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAxT3lFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B61F00A3A;
	Sun, 16 Aug 2026 02:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786847458;
	bh=xF87YuTxKU8uqsKvGLnKBj4Vgoc7MnZeNm24N9ov7T4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TAxT3lFq/ciExGPtrqoH8CPS+KsOGQHF+W63bXwLtvGNdbw0FCKnkOTtstikmnisF
	 SNKtqSuFGDusuob1KrQSlrB9WMiRRIkyhfz2BTqepy8J9q7QE8fQ/5OwamH9usGWNB
	 BYcMgT/5PQ6FW6/dorYhe9guee9InP0v1fx5/48qUDavVKmukOmAjfjlj7mzWxN/Mo
	 OiWNQkEyw5GPe5zleAwSRhth3q9s1/1lRM4/75kFJRUXMayX7vjEx8Ma1zqE9/WwWX
	 7L6e34jmOevnY26UocWb7vlO4LUNFjwIrkEgWcUUA4Qe5nZJW9mMyJCo2lLJAhqdkt
	 bNqBK34/8MZVQ==
Content-Type: multipart/mixed; boundary="===============4067643280196944416=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <493acfdba3a5a27d389a07afde84d0a1cb0a153c1e9a5b7e34f1da4f945f2d42@mail.kernel.org>
In-Reply-To: <20260816015746.2632990-9-memxor@gmail.com>
References: <20260816015746.2632990-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/14] bpf: Report non-sleepable kfunc programs accurately
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 02:30:57 +0000 (UTC)

--===============4067643280196944416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 2c475174a640..df9259fa0ea7 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -1083,7 +1083,9 @@ void bpf_diag_ctx_forbidden(struct bpf_verifier_env *env, u32 insn_idx,
>  	const char *constraint, *context;
>  	u32 depth;
>
> -	if (env->cur_state->active_rcu_locks)
> +	if (!env->cur_state->in_sleepable)
> +		ctx_kind = BPF_DIAG_CONTEXT_NONE;
> +	else if (env->cur_state->active_rcu_locks)
>  		ctx_kind = BPF_DIAG_CONTEXT_RCU;
>  	else if (env->cur_state->active_preempt_locks)
>  		ctx_kind = BPF_DIAG_CONTEXT_PREEMPT;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index da2ec0655b17..3de9e4f617b6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10731,6 +10731,8 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
>
>  static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
>  {
> +	if (!in_sleepable(env))
> +		return "non-sleepable prog";
>  	if (env->cur_state->active_rcu_locks)
>  		return "rcu_read_lock region";
>  	if (env->cur_state->active_preempt_locks)
> @@ -10739,7 +10741,7 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
>  		return "IRQ-disabled region";
>  	if (env->cur_state->active_locks)
>  		return "lock region";
> -	return "non-sleepable prog";
> +	return "non-sleepable context";

This isn't a bug, but with the new !in_sleepable(env) early return, the
final return "non-sleepable context"; looks unreachable given all three
callers guard on !in_sleepable_context(env) - is the fallback still
needed, or could it be dropped (or kept as the single non-sleepable case)?

[ ... ]

> @@ -10835,7 +10837,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		operation = bpf_diag_fmt(env, "sleepable helper %s#%d",
>  					 func_id_name(func_id), func_id);
>  		bpf_diag_ctx_forbidden(env, insn_idx, operation,
> -			"Move the helper call outside the critical section, or use a non-sleepable helper.");
> +			"Call the helper from a sleepable program outside any critical section, or use a non-sleepable helper.");
>  		return -EINVAL;
>  	}

[ ... ]

> @@ -13760,11 +13762,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	}
>
>  	sleepable = bpf_is_kfunc_sleepable(&meta);
> -	if (sleepable && !in_sleepable(env)) {
> -		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
> +	if (sleepable && !in_sleepable_context(env)) {
> +		const char *suggestion;
> +
> +		if (in_sleepable(env)) {
> +			verbose(env, "kernel func %s is sleepable within %s\n",
> +				func_name, non_sleepable_context_description(env));
> +			suggestion = "Move the kfunc call outside the critical section, or use a non-sleepable kfunc.";
> +		} else {
> +			verbose(env, "program must be sleepable to call sleepable kfunc %s\n",
> +				func_name);
> +			suggestion = "Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.";
> +		}
>  		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
> -		bpf_diag_ctx_forbidden(env, insn_idx, operation,
> -			"Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
> +		bpf_diag_ctx_forbidden(env, insn_idx, operation, suggestion);
>  		return -EACCES;
>  	}

This isn't a bug, but check_kfunc_call() now picks the suggestion per
cause - would it read better for the helper and global-function sites to
do the same instead of merging both causes into one sentence, since "from
a sleepable program" does not apply when the program is already sleepable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31921026518
--===============4067643280196944416==--
