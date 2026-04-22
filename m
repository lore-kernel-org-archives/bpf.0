Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD52DB798
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838336; cv=none; b=J3eCEK+WoJU3wohrWXe3sXFEtvsRzLrKrCLMW/Wj6ILOtRQOEib+4kFnCVfKTMmGHFe/OSTtEipOuGQNSvXuYL3kp19lYbFHTQZAzbmik2ctIpdR9AAqmL/+YeWRx3ZZR5ncXRFZeF2fgd04tqxKqFKNQDs+akGGR2hCnFPLnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838336; c=relaxed/simple;
	bh=pL3KVSj/FblluwhkqotKDs5yFMalLDMhCKressLex40=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B553pSDBtbCWaj9Q4pIj2Kvyioca1lAiAys63bwswwPlTyvBQek7IChmSjQi/+xpfG/ZLqKMT+bskvwkJ81xOPFyS31u9TToR3m6keE3UtJDsWIDEt6NX6brPu2yev2mYp5VI1bKYnALYJimbiolGSgRDLZ7Upy4HnJLKhTflFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFkGfn0p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFkGfn0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F4CC19425;
	Wed, 22 Apr 2026 06:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776838335;
	bh=pL3KVSj/FblluwhkqotKDs5yFMalLDMhCKressLex40=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iFkGfn0pUSJPoILyJhqacdJnF5B2XRrOlixFkI7/qnRt9+9CbzRr04VENOVOtCyqs
	 3Y3W8pq1U9tmlSY/DqshQv8MwtXVeAebkG0jL9Yv5iT1sZPkNbsDAYHXjeWI+h4lue
	 aXwp5vCyAyycCrxeDeYPolwTHjxsqmdLF4yu86mfHILpHOqglyt1dlTUxpbT0SHfNm
	 jBedNZwfycXzLGhejJkXkvgr6/xDQDyvYNzj2Bh8K1i+GhB8z1TT+RRR0mJrVj1Z0N
	 EZv0gYQefasKuu/5RShXRltnNS+2rW32H2yMFLtmI5I0LOKb+lQL1F7ftAI2DyCaX9
	 A/HhSkyyHTcZg==
Content-Type: multipart/mixed; boundary="===============4587512413275808134=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e163c423195778ca9674250e7f0f8898b7f8c342c4551408c378c41658fcbbb1@mail.kernel.org>
In-Reply-To: <20260422054235.3129028-1-yonghong.song@linux.dev>
References: <20260422054235.3129028-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 9/9] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 22 Apr 2026 06:12:15 +0000 (UTC)

--===============4587512413275808134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3cb6b9e70080..c8e387b0ce46 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1151,6 +1151,11 @@ struct bpf_prog_offload {
>
>  /* The longest tracepoint has 12 args.
>   * See include/trace/bpf_probe.h
> + *
> + * Also reuse this macro for maximum number of arguments a BPF function
> + * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
> + * stack arg slots. The JIT may map some stack arg slots to registers based
> + * on the native calling convention (e.g., arg 6 to R9 on x86-64).
>   */
>  #define MAX_BPF_FUNC_ARGS 12

This isn't a bug, but the comment style doesn't match BPF subsystem
requirements. According to Documentation/process/maintainer-bpf.rst,
multi-line comments must have the opening /* on its own line, even when
surrounding code uses the old style. Should the comment be reformatted as:

/*
 * The longest tracepoint has 12 args.
 * See include/trace/bpf_probe.h
 *
 * Also reuse this macro for maximum number of arguments a BPF function
 * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
 * stack arg slots. The JIT may map some stack arg slots to registers based
 * on the native calling convention (e.g., arg 6 to R9 on x86-64).
 */

This style concern was raised by bot+bpf-ci@kernel.org in multiple patch
versions (v5, v6, v7, v8) but remains unaddressed:
https://lore.kernel.org/bpf/3bc734dfbeffc1c45e1c640be67af1824500aa1b8e04aee814e1942c1064cc96@mail.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24762480405
--===============4587512413275808134==--
