Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55A365A12
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775972603; cv=none; b=XjrqhYU2HbYBsfZbBzFc2KzJgYrAo0QDffcYRcSp6UbN99CUKgEJOBIsNh5JjDZ8grInLjiiOYHw8kf2GE1f7T2+OBdSsoO+KlgF2x9/YPn1AwwTSFiIv8aSFplRqnhvsbFAwtRQXnV8Vq1llg5tAl6I/8qhNPG84AwdGz1OgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775972603; c=relaxed/simple;
	bh=eBGn3PakxS7O3ycDLfDGchkNpnz2qXL0mfDUPSqO5WQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f5bMdw6S4WW15NmEbqB/n2saXd9AV9YvXrVWY9d5GPX9eU7gX4byrNMD2UU0+C/zOxkAj43DdKrvU2d7Ez8adGE4AuhBiW6JcSIsWtEM6075DrlsLAftlA5ZuZD0GaeOm93IRKp9hGVR7h8juq6IAOWFxLXjAsrU++UU5t+BfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9PsHURI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9PsHURI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC8BC19424;
	Sun, 12 Apr 2026 05:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775972603;
	bh=eBGn3PakxS7O3ycDLfDGchkNpnz2qXL0mfDUPSqO5WQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=t9PsHURIE5FKLT9J3x9MHfKRehgkBTzRlCaquWN80bDQIZfZb3PwTLlI0JUYgz0W0
	 bgbbhb01fj2RhaSGHiwXhiUHa5VDmD2Cte5bRvIGld0j/fENAODmdSaDohm1UGEqAy
	 FTA8lQ3PQDBw8vR7u5MqD2KsnTP15Dov5OBkblAYrim9TG7DadKSmahhgsOV1nl2i+
	 RJhHmrFZMc7QihqjS5Kyhpd5E1bzkV708OiKQQ1ebVUDcnZbcnBoau6u2xkl7cRlM+
	 +3aMnhnEuwlbMgDP8cJTc/G8n9tOpHzHtUiVp+XtKWGP0M5W5k0akjSU5xKWYMmVTa
	 /RPAeyKlmZJAw==
Content-Type: multipart/mixed; boundary="===============7432167278803447010=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bcd1b7033de7f597d73b3991f8fc4d8b502fce451fc288d909ae72a717578a0d@mail.kernel.org>
In-Reply-To: <20260412045955.257613-1-yonghong.song@linux.dev>
References: <20260412045955.257613-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 09/18] bpf: Support stack arguments for bpf functions
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:43:22 +0000 (UTC)

--===============7432167278803447010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01df990f841a..e664d924e8d4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22383,11 +22682,11 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>  		return err;
>
>  	for (i = 0; i < insn_cnt; i++, insn++) {
> -		if (insn->dst_reg >= MAX_BPF_REG) {
> +		if (insn->dst_reg >= MAX_BPF_REG && insn->dst_reg != BPF_REG_STACK_ARG_BASE) {
>  			verbose(env, "R%d is invalid\n", insn->dst_reg);
>  			return -EINVAL;
>  		}
> -		if (insn->src_reg >= MAX_BPF_REG) {
> +		if (insn->src_reg >= MAX_BPF_REG && insn->src_reg != BPF_REG_STACK_ARG_BASE) {
>  			verbose(env, "R%d is invalid\n", insn->src_reg);
>  			return -EINVAL;
>  		}

This allows r12 (BPF_REG_STACK_ARG_BASE) through the register
validation for all instruction classes, but only BPF_LDX, BPF_STX,
and BPF_ST have explicit early-return handling for r12. What happens
if a BPF program uses r12 as src_reg or dst_reg in an ALU or JMP
instruction?

As far as I can tell, the path would be:

  check_alu_op() or check_cond_jmp_op()
    check_reg_arg(env, 12, ...)
      __check_reg_arg(env, regs, 12, ...)
        reg = &regs[12];

The regs array is struct bpf_reg_state regs[MAX_BPF_REG] with
MAX_BPF_REG = 11 (indices 0-10), so regs[12] is an out-of-bounds
access into whatever follows the regs array in bpf_func_state.

Would it make sense to restrict the r12 exemption here to only the
instruction classes that actually handle it (BPF_LDX, BPF_STX,
BPF_ST), rather than allowing it globally?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============7432167278803447010==--
