Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D032E73E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794783; cv=none; b=CnMTGzit+pEQuH5haRxSUs1WTM5UZcu7hHC66OL5jjXP+f2VQSx/JOrYX+UMQzMTwSypu8UXxvUD3URpQJzvJXE0DnOjIpwui1oGGS6Fullq+NPgLo4cA1swwGtFR678DY7zEgL6UuqYnSRixnfHG9HgYRWYeKqdOjkirR02OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794783; c=relaxed/simple;
	bh=HqAtiZPI/pzAHo9M+1GIq+zdMBo+VBRFzEMgITCPL20=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mIT0HQCIX1POUyklu58YzsiNJtAmYkfCefe4EXMqaelVZjI7YVoc60BlWPIDP2sJ7jkkXbT+pQygkMs/FCoOtx/t3R/2kKKhAXZn0fOKf3C0U+19S808l1/X3LthVmo23k6I6KWBXCllM3kEa5u7OUvvDpQwdmLYs3nsmxzaKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBaU12kA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBaU12kA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E421C2BCB0;
	Tue, 21 Apr 2026 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776794783;
	bh=HqAtiZPI/pzAHo9M+1GIq+zdMBo+VBRFzEMgITCPL20=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nBaU12kAO3ozDm1Q3GCz48sUs/I+ydqMvSt1dk1W97vx55VrI/+ZHkqv0OxZlO9/T
	 D8FdT7mMr5X63IVbC1UjdOInBT467ZvW36bv849NyRM5N2Y8HTuz4LW56g+4a5guJf
	 CdlDD7922zNhofrMURgN8UlHfOB+1G2UH6dnSltvSPwZGVzQF3wWa/pfT3NeUFW4Qa
	 KFIlJUF51qYxMVcZT/oJR60JaExGs6RBltT6IzMhmqCLSJarRdXuxcyEEPnA1llJw4
	 34NJiTDpr2ZLEKpEXiO5Z5FV7wOoQ+Ry144NfPZzgOHa3I587ec7ZOcFqDyh/X/uH2
	 rjsa5txURA4vQ==
Content-Type: multipart/mixed; boundary="===============1204703355270807966=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fd1c661bd948fcade6a1cf9b56a01d050386738c21134f351ad48d432819355c@mail.kernel.org>
In-Reply-To: <20260421-sleepable_tracepoints-v11-6-d8ff138d6f05@meta.com>
References: <20260421-sleepable_tracepoints-v11-6-d8ff138d6f05@meta.com>
Subject: Re: [PATCH bpf-next v11 6/6] selftests/bpf: Add tests for sleepable tracepoint programs
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,peterz@infradead.org,rostedt@goodmis.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 18:06:23 +0000 (UTC)

--===============1204703355270807966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
> index c2b7f5ebf168..6dabc5522945 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -76,7 +76,20 @@
>  	.runs = -1,
>  },
>  {
> -	"sleepable raw tracepoint reject",
> +	"sleepable raw tracepoint accept",
> +	.insns = {
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.prog_type = BPF_PROG_TYPE_TRACING,
> +	.expected_attach_type = BPF_TRACE_RAW_TP,
> +	.kfunc = "sys_enter",
> +	.result = ACCEPT,
> +	.flags = BPF_F_SLEEPABLE,
> +	.runs = -1,
> +},
> +{
> +	"sleepable raw tracepoint reject non-faultable",
>  	.insns = {
>  	BPF_MOV64_IMM(BPF_REG_0, 0),
>  	BPF_EXIT_INSN(),
> @@ -85,7 +98,7 @@
>  	.expected_attach_type = BPF_TRACE_RAW_TP,
>  	.kfunc = "sched_switch",
>  	.result = REJECT,
> -	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
> +	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
>  	.flags = BPF_F_SLEEPABLE,
>  	.runs = -1,
>  },

Should this commit include a Fixes: tag? The verifier test expectations
are being updated to reflect the correct behavior for sleepable tracepoint
programs. The previous commit 815090b2b600 added support for sleepable
tracepoints but left the test expecting sleepable raw tracepoints to be
rejected entirely, when they should now be accepted on faultable tracepoints
like sys_enter.

Suggested: Fixes: 815090b2b600 ("bpf: Verifier support for sleepable
tracepoint programs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24736611787
--===============1204703355270807966==--
