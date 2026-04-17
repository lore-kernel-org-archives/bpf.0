Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BD35DA5D
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400208; cv=none; b=JJHK8SGssS2vRvhp18ir1V8W33UAjBiqRcxCtFs4L6xK0PMZIpXYByV3dCNuXqRXi1s1jcOJFLw6Oj6Qdd8ApRKTtAzvyir+L7vTvR7HpEsXXrpGR2Ixyg4N9ifPmwzgwKngtCSDqZbJBaFvnwkpUCI61Q01hlqZLUcD3VyQOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400208; c=relaxed/simple;
	bh=ULkMXHc3SpZory/ylQO3xu5UWJviHMZNvUQfqZxuPek=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=liv6747Yaz7xQgy6HOZvmPI0/mktv9zjb7nkjpvdusYPi5MQnZuR4nojfA7Kn5MQTEmB2pHWE4jRn9mI900CiMGKqFCUqqAZRniRjVhLT6DOOkWzFgMY3NICFdSUdpiW5SUQ5KDZup7GFViZ9dFqEkNNMyaiRjPW62C+m6eV80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ3kRGHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ3kRGHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CEEC19425;
	Fri, 17 Apr 2026 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400207;
	bh=ULkMXHc3SpZory/ylQO3xu5UWJviHMZNvUQfqZxuPek=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PQ3kRGHTQy1ifSxXXWwlwKft8D3dGmJKJ39WQE0ZjB6Gocy4VdgILr79jP3BRAIVC
	 K1PuT1T/GgDMGmMzOLPh6xGJ5ZcrR1xFYD7jG6Lj3CTvCWUm8lVLNYZCu3GApwjei2
	 ZydeQgornV75S1/OwFhxQy4R4w/FbkIXyh4jgtETMBv7n6BMEJp2V3K9mMdxhE2HBm
	 vrf/6gCZKyNiJkW2WTSPjtn8psSUcu1ozdBUnTz10B57MUXpehcgGV8VuEdSmVqyAb
	 b0AWKuROn0aB7OFdbpDfGNhEM/A2W2b3W8l4WugFE668e8J8jI4/lmMo0jjmgn45eM
	 LSfEcfZcG7a1A==
Content-Type: multipart/mixed; boundary="===============4191636061976073536=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d23db60b9c7e22d8ab443688b4f2da8d5594d6c07698cdc282faccaade757430@mail.kernel.org>
In-Reply-To: <20260417034734.2629722-1-yonghong.song@linux.dev>
References: <20260417034734.2629722-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 07/16] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 04:30:07 +0000 (UTC)

--===============4191636061976073536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1151,6 +1151,10 @@ struct bpf_prog_offload {
>
>  /* The longest tracepoint has 12 args.
>   * See include/trace/bpf_probe.h
> + *
> + * Also reuse this macro for maximum number of arguments a BPF function
> + * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
> + * stack arg slots.

Is this description of the calling convention accurate? The comment states
"Args 1-5 are passed in registers, args 6-12 via stack arg slots," but
doesn't argument 6 get passed in the R9 register rather than on the stack?

Looking at arch/x86/net/bpf_jit_comp.c, the existing comment states: "x86-64
supports up to MAX_BPF_FUNC_ARGS arguments. 1-6 are passed through regs, the
remains are through stack."

The follow-up commit 0ef907c3ec2c in this patch series ("bpf,x86: Implement
JIT support for stack arguments") documents the actual calling convention as:
"Follow x86-64 calling convention for both BPF-to-BPF and kfunc calls: - Arg
6 is passed in the R9 register - Args 7+ are passed on the stack at [rsp]"

Should the comment say "Args 1-5 are passed in registers, arg 6 in R9
register, args 7-12 via stack arg slots" instead?

>   */
>  #define MAX_BPF_FUNC_ARGS 12


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054
--===============4191636061976073536==--
