Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CFE43F085
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123870; cv=none; b=sYmLGQfv/4yN8bNTApYpsDA8mt/QgLSibuFTxN25MQwuG76KbXHoxhSWLX6pt8IThT7DhFSPK0lq1qUCJjQkCMrbMcwr0V+48vMBCbPLJsX6k02OeQMlgdIYnYtBmHP27Mg3k/Vstz6MMDgGX+TrsNq+nvekQ0yrp6S65PEgm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123870; c=relaxed/simple;
	bh=E3JaCONRN4GG49rm29CiGOvD5g5AO4f+iKFibrREdn0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pKO+Njc0abLN/cC7HwOUakgR1FW6Ic/zLFzcR2ugkO1CavdO+DajEKF0cjwv9tMvbeivMnTyZzWlPAIG0HDNrA9OTyncliK3KSm2p2o1LbneGsVOeW3VCKF2p8Il3gMJbf0iBOY9zJycxFI6/sutbG+mAPsJF4i4Wf6y6t3vf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbedvmfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbedvmfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D211F000FF;
	Sun,  4 Oct 2026 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123868;
	bh=loCkghCTiLqekAZ3yzRQCz/pNW9XmOXQ+dNzi5TdA2A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IbedvmfJ8gYi0zofJV10R2P+jun5p4ypobBOe9H7yJk95U8SNAZXnAmxf52oLnq+k
	 aHFKddhvdb6g7ku08snu85K9mZ/yTlv/5sQwmPU+scLnSIZPjnAIWDSGQapb2vDYV5
	 o59AjA103r+hu5AUXPX8ZiNSrMpbhMEEwYVvXPwwx1jCdCWmddjZoZnhtqYHhvBkV1
	 XRNeZhtfrOYRlCz6BWShv3hv+LiYc0ACYbqp5BK6x4gEUaYJdDGwF01/2Iy2qb0/Gv
	 fa0+0t3D49W6uhyd4xMDv8nmrRc40rthyiUEB76+MLy8W+gsuPWn31kpXfXlvnCjbT
	 ZIc+NiEw7QykQ==
Content-Type: multipart/mixed; boundary="===============4624827774729853883=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <55dc0307337c95f1c09b72c32e06f69684f98ff91f2361413fde90d124a545dd@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-12-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-12-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/43] bpf: expose comparison opcode transformations
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:27 +0000 (UTC)

--===============4624827774729853883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: expose comparison opcode transformations

TL;DR: Nit only: bpf_flip_opcode() is exported but nothing outside verifier.c
appears to use it, so it could stay static and the commit message be adjusted.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 79ca8b28a83a..4371fb3405ac 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1872,4 +1872,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env);
>  int bpf_do_misc_fixups(struct bpf_verifier_env *env);
>  int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
>
> +int bpf_flip_opcode(u32 opcode);
> +u8 bpf_rev_opcode(u8 opcode);
> +
>  #endif /* _LINUX_BPF_VERIFIER_H */

[ ... ]

> @@ -17427,7 +17425,7 @@ static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_s
>  	return simulate_both_branches_taken(env, opcode, is_jmp32);
>  }
>
> -static int flip_opcode(u32 opcode)
> +int bpf_flip_opcode(u32 opcode)
>  {
>  	/* How can we transform "a <op> b" into "b <op> a"? */
>  	static const u8 opcode_flip[16] = {

This isn't a bug, but is there a user of bpf_flip_opcode() outside of
verifier.c?

Nothing else in the series (3ece537e8490..2c96fb13421f) calls it.  The only
external user added later is match_linear_latch() in kernel/bpf/scev.c, and
it calls just bpf_rev_opcode():

    op = bpf_rev_opcode(op);

The commit message says "The helpers are used by SCEV logic while analyzing
loop conditions", which appears to be true only of bpf_rev_opcode().

Could bpf_flip_opcode() stay static, with only bpf_rev_opcode() exported and
the commit message adjusted accordingly?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============4624827774729853883==--
