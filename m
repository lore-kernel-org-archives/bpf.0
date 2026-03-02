Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABA3D7D78
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470691; cv=none; b=SB5jZgJ22B0OdrU9eOd1JHjXtD7LEGoMzPsoJ78dNDknSuSgnQ/eYnQjr2O9gMxilI8n3XdAo1Xj8oZaowQ2FivdJ+bBceFZJsN+nlGDZvFv0dmYUYX0VDopbeqQRf3U+hUEf8lwvCqyll65N127ZusT/t8kUqEoTI1S/0Y6Q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470691; c=relaxed/simple;
	bh=74Kt8af8X17nNDiwZ+RL40z3PYF6hu5yzHkaiHYfSr4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qjrZ/rmyYiEjPq/ArhluXr3UoN+CgZN/VwCzQyuIvhLl42ww3mYIlafuKQ6D6NIK+6Ut2MERhhjkRqzYzvOyOLioUHJcwFa6eugwiI6Xb7jxOHyV7h+rT1IfHiLEbLNRrGeqG9b6IhtiPmoGwiIs+v3hgnbrNKbV4lBV+h/GrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g02XlDBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g02XlDBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278DAC2BC9E;
	Mon,  2 Mar 2026 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772470691;
	bh=74Kt8af8X17nNDiwZ+RL40z3PYF6hu5yzHkaiHYfSr4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=g02XlDBLxL4bOTOCDiTOq+X3yPJjmrP7I4sdik5L6ursHv5P4p1CFkstf0ey0Mf8e
	 x4eGyz239mPJYD9Hpyt/T2gxNkCVlXD1FQn/HK2I8JHt2NI3IjG522wusvXWDjUAPd
	 e2GqXHtCCB062oNZu5dh+DSP/SsWskJRbhO1vUrSf22NaufHjHlb12mW03gsXL0Nqd
	 hrQ0q6Jj3k1m9FKfrjYgUQcyVfmp7MhjBDQkWMxvdUZYnj2Epw+h8bpID+R3wxNyyu
	 EbLsWn/fr1alWW/sK0LUdrtmx5UGvF3e6Jl7T4bPwuk9qKgIyf3gz6i54SAKtjeWZW
	 VoQqXkWhHbS8A==
Content-Type: multipart/mixed; boundary="===============3476856939668152110=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd5639328f651882b04bafb0686962d8d4d1981ec080279618e814423fc4f6db@mail.kernel.org>
In-Reply-To: <20260302161736.156685-2-cupertino.miranda@oracle.com>
References: <20260302161736.156685-2-cupertino.miranda@oracle.com>
Subject: Re: [PATCH 1/2] bpf: detect non null pointer with register operand in JEQ/JNE.
From: bot+bpf-ci@kernel.org
To: cupertino.miranda@oracle.com,bpf@vger.kernel.org
Cc: cupertino.miranda@oracle.com,david.faust@oracle.com,jose.marchesi@oracle.com,elena.zannoni@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 16:58:11 +0000 (UTC)

--===============3476856939668152110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: detect non null pointer with register operand in JEQ/JNE.
>
> This patch adds support to validate a pointer as not null when its
> value is compared to a register which the verifiers knows to be null.

"verifiers" looks like a typo for "verifier", and "which the verifier
knows" should probably be "whose value the verifier knows".

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fc4ccd1de569..6e3fcdfa3643 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17608,12 +17608,15 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  	}
>
>  	/* detect if R == 0 where R is returned from bpf_map_lookup_elem().
> +         * Also does the same detection for a register which the value is
> +         * known to be 0.

These two comment lines are indented with spaces instead of a tab.
Same "which the value" grammar as the commit message -- should this
be "whose value"?

> -	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_K &&
> -	    insn->imm == 0 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
> -	    type_may_be_null(dst_reg->type)) {
> +        if (!is_jmp32 && (opcode == BPF_JEQ || opcode == BPF_JNE) &&
> +            type_may_be_null(dst_reg->type) &&
> +	    ((BPF_SRC(insn->code) == BPF_K && insn->imm == 0) ||
> +             (BPF_SRC(insn->code) == BPF_X && register_is_null (src_reg)))) {

The if-statement and its continuation lines use a mix of spaces and
tabs for indentation.  Are tabs intended throughout, matching the
rest of check_cond_jmp_op()?

Also, there is a space between register_is_null and the opening
parenthesis.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22585365823

AI-authorship-score: low
AI-authorship-explanation: Grammar errors and mixed indentation are consistent with manual editing by a non-native English speaker, not AI generation.
issues-found: 3
issue-severity-score: low
issue-severity-explanation: All issues are coding style violations (mixed tabs/spaces, space before function call parenthesis) and comment/commit-message grammar errors; no functional or security regressions.

--===============3476856939668152110==--
