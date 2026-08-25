Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE99339393
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695188; cv=none; b=JauUT/DYiQAKfpOYz7eoxQ9d/Pq7yYE1+Eb/5VXDib/CjoW5O2x+VZQ6Sk8hoCrg6QlWkXpQN5ce7Wsyr2+GqXBOnCx7W9jp+j4RaXnn74wbUETZN2CV+CJLdo/QbLIkjQi57WgaNeIoirSCZMQ2+66SUWTEdnl+a2S2ty262Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695188; c=relaxed/simple;
	bh=d9egCYHrYpl/emwEhccTU2csw5pRcALKffUSumau76c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MZaxhAqy5ehsC1RfegR4oy1xOU1Hya5u1lOiQ2VD4hHrETdJ46EGxbh8hUFGuJOzbsOwsKJZ5ygJGW+wew5BeOhFWNroWfGrudev9Z0yCOTSRD0etlEXwNmtHQL52pvf97dJSZgLCTTUr5WDnjvsNgm6ti4cQMEIbMi1BwH2CbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTz9lawF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTz9lawF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF07A1F000E9;
	Tue, 25 Aug 2026 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695186;
	bh=GSkkfA7oDhJkop6JSmDwecxIwzhRcu4ajBOQA4cr7zw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mTz9lawFtJF88TT8OUi5iE9yJuScaPXnONjILslfHiZEiwRc8iW9sbvLSqkoF6pSm
	 uxUmp5lbYjNoO+uU9wk0zqqJDmSWn1q6ngUjIYrABgYXUAAKpG5xXXlMtMNWFYk9lI
	 73i12WnXNSpAWUvpUdRevR793z47tTEPm04NRUkQ/JIIJnQ4AzwxWxAFWi5MnYSwsE
	 rrIqGZ3TvYX2gmNv/MIAtPQ3YBzTONPD09X+gaU2kDOn3BCgIrzcuV/k89LySR7l48
	 LirUyu8cuyVaEZohg3CcDUTlX5Ac8sA9hMEO2jERtCL7D+jieqobhBDJ1YAIDZTpN5
	 jJl0D0Xd7k7Yg==
Content-Type: multipart/mixed; boundary="===============1692180680157483172=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0406cb29c1419b2bdf8ab69ca7c14ffe6a5dacde23a387b9b43071e6017cf423@mail.kernel.org>
In-Reply-To: <20260825205417.1320403-1-yonghong.song@linux.dev>
References: <20260825205417.1320403-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 01/10] bpf: Record each half of a paired return value in verifier diagnostics
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 21:59:46 +0000 (UTC)

--===============1692180680157483172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e036ae20bf6b9..9aa29c3670087 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10403,10 +10403,14 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  		 * return to the caller whatever the callee had in the
>  		 * return register(s)
>  		 */
> -		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRITE);
> -		for (i = 0; i < nregs; i++)
> -			caller->regs[ret_regs[i]] = callee->regs[ret_regs[i]];
> -		bpf_diag_mod_end(env);
> +		for (i = 0; i < nregs; i++) {
> +			u32 regno = ret_regs[i];
> +
> +			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
> +					   BPF_DIAG_MOD_WRITE);
> +			caller->regs[regno] = callee->regs[regno];
> +			bpf_diag_mod_end(env);
> +		}
>  	}
>
>  	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,

This fix looks correct for prepare_func_exit(). Should check_func_call()
and check_kfunc_call() get the same per-return-register diagnostic scope,
or is R2 intentionally left out there?

Commit 0630ad00d96d introduced the same pattern in three places, and this
patch addresses only prepare_func_exit().

In check_func_call(), the global-subprog path has:

    bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
    ...
    nregs = bpf_ret_reg_pair(env, subprog) ? 2 : 1;
    for (i = 0; i < nregs; i++)
            mark_reg_unknown(env, caller->regs, ret_regs[i]);
    bpf_diag_mod_end(env);

When nregs is 2, mark_reg_unknown() writes into caller->regs[BPF_REG_2],
but the scope target is caller->regs[BPF_REG_0], so the write emits no
BPF_DIAG_HISTORY_MOD event.

Similarly in check_kfunc_call():

    bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
    ...
    mark_kfunc_ret_regs(env, regs, t->size);   /* writes R0 and, for 8 < size <= 16, R2 */
    ...
    bpf_diag_mod_end(env);

When t->size is between 8 and 16 bytes, mark_kfunc_ret_regs() writes the
second half into R2, but again with no MOD event.

In both cases R2 does get a BPF_DIAG_MOD_CALLER_SAVED scrub record, so
the history shows R2 as clobbered by the call but never shows it being
written with the second half of the return value.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405
--===============1692180680157483172==--
