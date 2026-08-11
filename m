Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA613290AF
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410594; cv=none; b=Q4RJO4hW1f2RQu7vLnLifcqSqb9UIxdchFTqe5HOMmpNjpIDrGGK3pkv6gmpKRnJ95Doil85qObE2avFEYskm7dH1xoRTLLBvBfhaqH6vrI3P5Wn+HH695hjjMmztOFX/KFypVMRITss5tP1SUd6CspWowfSwoyAA6ULDH+9xLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410594; c=relaxed/simple;
	bh=Woz8GOxgK0LLueC5sti8TzGB0kHp+4NHz3GS0K9zc3A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HIAsgklbhuyBQ6nuaCG7zArV+ntyDgiUCs0KJdcKhvBSIBUTHpLWfaatG8grTQQ/MJU22RYg/WvDoBR8N1WT/ynr4dmg9ns+cxAwyVrgXi8LpqitCSXmTXPCyX12zqT4qvaolgk8gbIcF+JcebWERb8ptlUXnLWGPwBoqm56z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye0tiQEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye0tiQEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843181F000E9;
	Tue, 11 Aug 2026 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786410593;
	bh=FCxxv1x9fHP1UZeXMQ7kgUhOGpKPpvGX54ayQyAhteQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ye0tiQEeFIWIErA5l4fvg0WmrgCn5KrkJRSrNmDx7k6/+dI3z6TLaDA+OOvk8yFRc
	 YT1eykNs+tZ/vmBTr/PZqvK2CSZqXHfZMIN39sCQAAB8twPwWQeZTiaYSoCCkyxLXV
	 qKO3//+CSO8bBZPyyllRCpZHmcG1cnf7qOIGa+hnSZwo+/q9dSV4W6hRnK4A3gC8GR
	 Glv20+3HDT/Loe/Evdjj+m4NWOpzgTaktMaJtPAg2Up7+YtzkEmmqa2FOUD/hNnSjJ
	 WSnTeUJ/bKrip4WohJt/MMrIVvI42Uv2q+LBYEpIlyKMjfkxxz4WyJl+4SMUO8LHuh
	 Za1ZwHzjVHCgA==
Content-Type: multipart/mixed; boundary="===============2445339976328568983=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73f764590b71831acdfe184bdc7d06c9d0da1403745ac24c4dea486385fce48a@mail.kernel.org>
In-Reply-To: <20260811000937.2381528-1-yonghong.song@linux.dev>
References: <20260811000937.2381528-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 05/13] bpf: Account R2 of register-pair returns in live register analysis
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 01:09:52 +0000 (UTC)

--===============2445339976328568983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
> struct/union or an __int128) reads R2 as well as R0, since the second half
> of the return value is passed back in R2. compute_insn_live_regs() only
> marked R0 used at exit, so a callee's R2 could be considered dead and
> cleaned from checkpointed states, which would allow unsound state pruning.
>
> Mark R2 as read at the BPF_EXIT of a subprogram that does return a register
> pair. bpf_compute_live_registers() walks the instructions in order and
> env->subprog_info[] is sorted by subprogram start, so the containing
> subprogram is tracked with a running index and its return convention is
> queried once per subprogram through bpf_ret_reg_pair().

This isn't a bug, but the description talks about tracking the containing
subprogram with a running index while walking instructions in order. The
code that landed uses a plain nested loop iterating over subprog_info[]
directly:

	for (subprog = 0; subprog < env->subprog_cnt; subprog++) {
		start = env->subprog_info[subprog].start;
		end = env->subprog_info[subprog + 1].start;
		ret_reg_pair = bpf_ret_reg_pair(env, subprog);

		for (i = start; i < end; ++i)
			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
	}

This nested form gets its [start, end) ranges straight from subprog_info[]
(the same idiom mark_fastcall_patterns() uses), so neither "walks the
instructions in order" nor the sortedness reasoning is what makes the loop
correct. Would it be worth adjusting that paragraph to describe the nested
loop form that landed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762
--===============2445339976328568983==--
