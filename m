Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF92D060D
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480394; cv=none; b=sEY0M1+9DPzydnjt4vzpGrRfVRRjodp7Z9Zj0vPW0nSiLjpnt7EiJuxj3RsgPWlbWLPdk8+8cnQHxRnJX28xLLwCOIjLRwGdw4EXXWSvm/oFmP+Fv6Scqj/D3X+lOGSx7IF9YizWx2qPatDiDdwu3r+8nNofPjSPEYuKVuj+2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480394; c=relaxed/simple;
	bh=66UE/9H2DOf2ZnPQntP6Tl1WLq4rHhy7S+JtHwHorEk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NcrQpDCfMyMeKe4j88xRGR/Cbxv2PKMNf000xlAT6fRG1rhfxqM3XDHcliT4iL2jSz52ifeiuI/WpD6gkun7gYmFk8JkN5eF+URjoPWVKOkbeDspJhYAbnV+c5uKRdBBerealJPzezTnJP2ecFgOh7R/wLUJ243AGnvlWKLMZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtZNgZSm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtZNgZSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC8CC2BCB0;
	Mon, 11 May 2026 06:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778480394;
	bh=66UE/9H2DOf2ZnPQntP6Tl1WLq4rHhy7S+JtHwHorEk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jtZNgZSmKuWgfFtwQqd0GGmh7g8+XpMerW/lzB0BSHbKnL2863Zfz+3XRMyc12kAU
	 P0dt3m+tJ8vFZ5t1Z5BhVFDCtYmREcuB2QJnm9HgSz2t9AwBMxANFQJOwJz2Xa2num
	 by5W6molBvQUzxPmINOydqtb0jFq2TDJW67RFF56aWiP2zOgrsitw8NOWJGAk9oBqI
	 vUgt4CNudp+lDIYOv/68PWrQQOAT1SZ8JGDMEDJnavrIGYFTYLozIQnTAG/mV97tvK
	 f4kclGEnlojQoAClBXmlPHFwPRXT4RpY/1RzQYB2edmKC4Usv2IRQz+s88zPJHsNom
	 T5Q8XJagpNjcw==
Content-Type: multipart/mixed; boundary="===============2093001373181871531=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a38eef1ada649253e764e4dab338620553a332ef32440feacf0541d443ba8fed@mail.kernel.org>
In-Reply-To: <20260511053348.1885300-1-yonghong.song@linux.dev>
References: <20260511053348.1885300-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 09/24] bpf: Extend liveness analysis to track stack argument slots
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 06:19:54 +0000 (UTC)

--===============2093001373181871531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -58,6 +58,14 @@ struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
>  	u8 opcode = BPF_OP(insn->code) | BPF_SRC(insn->code);
>  	int r;
>
> +	/* Stack arg stores (r11-based) are outside the tracked register set. */
> +	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn))
> +		return;
> +	if (is_stack_arg_ldx(insn)) {
> +		ci_out[insn->dst_reg] = unknown;
> +		return;
> +	}
> +
>  	switch (class) {
>  	case BPF_ALU:
>  	case BPF_ALU64:
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -1576,19 +1651,19 @@ struct arg_track none = { .frame = ARG_NONE };
>  		goto err_free;
>
>  	for (i = 0; i < len; i++) {
> -		for (r = 0; r < MAX_BPF_REG; r++)
> +		for (r = 0; r < MAX_AT_TRACK_REGS; r++)
>  			at_in[i][r] = unvisited;
>  		for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
>  			at_stack_in[i][r] = unvisited;
>  	}
>
> -	for (r = 0; r < MAX_BPF_REG; r++)
> +	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
>  		at_in[0][r] = none;
>
>  	/* Entry: R10 is always precisely the current frame's FP */
>  	at_in[0][BPF_REG_FP] = arg_single(depth, 0);
>
> -	/* R1-R5: from caller or ARG_NONE for main */
> +	/* R1-R5 and outgoing stack args: from caller or ARG_NONE for main */
>  	if (callee_entry) {
>  		for (r = BPF_REG_1; r <= BPF_REG_5; r++)
>  			at_in[0][r] = callee_entry[r];

The comment says "R1-R5 and outgoing stack args" but the following code
only copies R1-R5 from callee_entry to at_in[0]. The outgoing stack arg
slots at at_in[0][MAX_BPF_REG..MAX_AT_TRACK_REGS-1] remain at ARG_NONE
(set by the earlier loop).

Looking further down in the function, the incoming stack args from the
caller are actually placed in the separate at_stack_arg_entry[] array:

	/* Entry: incoming stack args from caller, or ARG_NONE for main */
	for (r = 0; r < MAX_STACK_ARG_SLOTS; r++)
		at_stack_arg_entry[r] = callee_entry ? callee_entry[MAX_BPF_REG + r] : none;

The comment conflates the outgoing stack arg state carried in
at_in[0][MAX_BPF_REG + r] (which always starts at ARG_NONE and gets
updated later by arg_track_xfer when the subprog performs stack-arg
stores) with the incoming stack arg state (stored in
at_stack_arg_entry[], read back via stack-arg ldx).

Should the comment be revised to only mention R1-R5, since the incoming
stack args are handled separately below?

> @@ -1598,6 +1673,10 @@ struct arg_track none = { .frame = ARG_NONE };
>  	for (r = 0; r < MAX_ARG_SPILL_SLOTS; r++)
>  		at_stack_in[0][r] = none;
>
> +	/* Entry: incoming stack args from caller, or ARG_NONE for main */
> +	for (r = 0; r < MAX_STACK_ARG_SLOTS; r++)
> +		at_stack_arg_entry[r] = callee_entry ? callee_entry[MAX_BPF_REG + r] : none;
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893
--===============2093001373181871531==--
