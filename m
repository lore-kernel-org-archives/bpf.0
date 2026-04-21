Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EA38838C
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793945; cv=none; b=GksFfRyShHBzP3nYnyuZ/FyGNxDStKPJ0Z4lwS++QSiN3hQPQK6Z65HQGBN78duCReHkfA2MfZ0TyMY6LLnV5PcLBTHffee77NaIyXAcllfA2irKzV4lCf5m2w8ZHmcVUYTyW9kvihZtT8tsdLeXBaPfArP+4AjOpgt3TMUdDNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793945; c=relaxed/simple;
	bh=UwLw2cIwrNRVunxazq9mLzSzN6cP19wYpgeEnS3GHV4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Zn8qtYFSqI4nN8cclrbEUQ7nGsxjZF4zcKZZviNNKGaJXDKC/QQPMvLl33bnZec67vBL0AcztxaVmvIDRnjS9KpXhMAV+CnUMMV3F7bT6Op6onzKqI46YEARYQxqbYW5QG09zjwqJfiejtlX8HRupjujIbyGso3okazySeKsDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzu0mz0x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzu0mz0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B039C2BCB0;
	Tue, 21 Apr 2026 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776793945;
	bh=UwLw2cIwrNRVunxazq9mLzSzN6cP19wYpgeEnS3GHV4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Tzu0mz0xoPwECc3lxoqYPKIkMBt9h9WDdc+RyrEfGXpWTXr1c6+GvdpQecPX64IFf
	 x5VJxOtAaUpw7v+mNu7kfX59CmIvw3m2sQspt8WSKGctckvd3nxLkymn6/jkshvHJP
	 HJr6qp++bu09Uy82FFr+wS6vVvoE/0w28+czgO/d/OZUicR4uEz8N6iXNuIus6b9F1
	 22mpf2xFQ3/c+ExrmZDW7xY6FcQ4CYVtchwP4QoeuQHsMvrq3kw+nDNK9sBC6NeLof
	 UWrhzTV/ynImkxmn/5nGdUrk6Z86Hd9EraukF1QuYJSOJ/skUILaursTPW6w4+ep7y
	 EiqmF1hLRSJsA==
Content-Type: multipart/mixed; boundary="===============7777337497304200523=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2be692742d7024e051bd75dfb94e189d4182870c68eee8f005d097a5bdf7913f@mail.kernel.org>
In-Reply-To: <20260421172013.3512808-1-yonghong.song@linux.dev>
References: <20260421172013.3512808-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 9/9] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 17:52:25 +0000 (UTC)

--===============7777337497304200523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3cb6b9e70080..c8e387b0ce46 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1151,6 +1151,11 @@ struct bpf_prog_offload {
>
> +/* The longest tracepoint has 12 args.
>   * See include/trace/bpf_probe.h

This isn't a bug, but the multi-line comment opening doesn't follow BPF
subsystem style. Per bpf.md, multi-line comments must have the opening
/* on its own line. The rule applies even if surrounding code uses the
old style.

This was raised by bot+bpf-ci@kernel.org at
https://lore.kernel.org/bpf/3bc734dfbeffc1c45e1c640be67af1824500aa1b8e04aee814e1942c1064cc96@mail.kernel.org/

> + *
> + * Also reuse this macro for maximum number of arguments a BPF function
> + * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via

Should this say 'kfuncs' instead of 'kfunc's'? The context is plural
(referring to multiple functions), not possessive. The same issue
appears twice in the commit message.

This was raised by bot+bpf-ci@kernel.org at
https://lore.kernel.org/bpf/3bc734dfbeffc1c45e1c640be67af1824500aa1b8e04aee814e1942c1064cc96@mail.kernel.org/

> + * stack arg slots. The JIT may map some stack arg slots to registers based
> + * on the native calling convention (e.g., arg 6 to R9 on x86-64).
>   */
>  #define MAX_BPF_FUNC_ARGS 12


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24736686700
--===============7777337497304200523==--
