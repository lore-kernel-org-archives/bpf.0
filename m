Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC02561A7
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473562; cv=none; b=sEjRxYnJmRKoMFZth/iaEbU3DPKAiVV2scuTa9bt3y80kqLV28ohemgqIrXzABwH1KmzwT+KuD6f6fiCyi0EacNS+VNBACyzCtc/YfmXw6Emawepjyq3toydWNYzMjQ1tqpYlvQVnHIUwD4H4iizeC6IdOBhDZ8HRnEafr9zQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473562; c=relaxed/simple;
	bh=7wtCK72DzAcfJp/fRqJRphtGAeU9QAjTjlCqypQQb/4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JvGHkIPF72dnKIh9FOa7/I3E2gsUvf7x4437u+zl+WXz7V/SKqUQuNQ72kJCYNxoCIdJ5Hzj7H+Xzxmi9C4kgRB1ljzoe4992VDHbBYQr3RnGmse/n65FKQIXKluZoQ3jhQfd3XkubssgTnOxhcc69bV96H78pDCEhIWb1UNjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUIR+peH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUIR+peH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A54C19425;
	Sat, 18 Apr 2026 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776473561;
	bh=7wtCK72DzAcfJp/fRqJRphtGAeU9QAjTjlCqypQQb/4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hUIR+peHhJy9e2KxoU0HK/7b8KtgHuHUiDncb7LCj2MpB25QhyFx9F4oKqwU9M8N3
	 w4W2veSzD1OyIM3TmQqY/jV/z9mLG50nbfah2osLLRvteAu6zNzgYGLp2ELbqvUGHT
	 5Qti3JDuh49BK8OmxpspQCG3r1uau4Lz+aW1KOsWluQl2VPI4+ECigvgmZ3hXbFttS
	 F+7FPnqn9Skp08AVzCPUV1rAfAg4aYXp4E2tDcY6hOTB8IC2oAI1NG5OF6ksVvR7M/
	 gEtHheJS5nMOu3pgj9qRF3NQDBEZRMCd/IdlR81sZFa/ctwaC3dQlLt10TIpX/23Nl
	 f/krUMQEguQCQ==
Content-Type: multipart/mixed; boundary="===============1198302043114410360=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3bc734dfbeffc1c45e1c640be67af1824500aa1b8e04aee814e1942c1064cc96@mail.kernel.org>
In-Reply-To: <20260417034734.2629722-1-yonghong.song@linux.dev>
References: <20260417034734.2629722-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 07/16] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 00:52:41 +0000 (UTC)

--===============1198302043114410360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1151,6 +1151,10 @@ struct bpf_prog_offload {
>
> -/* The longest tracepoint has 12 args.
> +/* The longest tracepoint has 12 args.

This isn't a bug, but the multi-line comment opening doesn't follow BPF
subsystem style. Per bpf.md: 'Multi-line comments MUST have the opening
/* on its own line'. The rule applies even if surrounding code uses the
old style.

Should this be reformatted as:

/*
 * The longest tracepoint has 12 args.
 * See include/trace/bpf_probe.h
 *
 * Also reuse this macro for maximum number of arguments a BPF function
 * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
 * stack arg slots.
 */

>  * See include/trace/bpf_probe.h
> + *
> + * Also reuse this macro for maximum number of arguments a BPF function
> + * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via

Should this say "kfuncs" instead of "kfunc's"? The context is plural
(referring to multiple functions), not possessive.

Additionally, bot+bpf-ci@kernel.org raised a concern in v5 about the
calling convention description. The comment states "Args 1-5 are passed
in registers, args 6-12 via stack arg slots," but argument 6 is actually
passed in the R9 register, not on the stack.

Looking at arch/x86/net/bpf_jit_comp.c, the existing comment states:
"x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6 are passed
through regs, the remains are through stack."

The follow-up commit 0ef907c3ec2c in this patch series documents the
actual calling convention as: "Follow x86-64 calling convention for both
BPF-to-BPF and kfunc calls: - Arg 6 is passed in the R9 register - Args
7+ are passed on the stack at [rsp]"

Should the comment say "Args 1-5 are passed in registers, arg 6 in R9
register, args 7-12 via stack arg slots" instead?

Reference: https://lore.kernel.org/bpf/d23db60b9c7e22d8ab443688b4f2da8d5594d6c07698cdc282faccaade757430@mail.kernel.org/

> + * stack arg slots.
>  */
>  #define MAX_BPF_FUNC_ARGS 12
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============1198302043114410360==--
