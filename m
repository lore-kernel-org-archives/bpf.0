Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D549550A
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690493; cv=none; b=V14RvehhefR2TUT9LAr7AGoVjoHagEJXkugljn35OLLyT76W7WA71kbdhsfz+HaxERpXU3TO2lhZeo2SnmaofgSTNPRYtyeWyzgD16pv3qNEvys4+lCF/9ShRQU4C406DG2UsHcsICFxMnrRa1mxmL9ejY4qFMad6OCNYEFA7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690493; c=relaxed/simple;
	bh=mmDwlMB3V7gV3dbxmcyv2Gd9qMFoKFoVz+XhmyhfAc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UYzmKYkw4ZGTkMNjb3G1XbQF7pRrjk8gKdh/0pouqPECfOjAS/dswCtLEu0ojPFuc+4FcgujoHaoF7w3nPWIktgmIi9N8FJkGtCAwPpLpDqpn24CBnq3Cfi6GRkF93Y5XW1/mT3pngaZ/2VVnlKUCse7FSdbbrysYLwzE5qLs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXF6arhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXF6arhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F4C2BCB7;
	Wed, 13 May 2026 16:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778690493;
	bh=mmDwlMB3V7gV3dbxmcyv2Gd9qMFoKFoVz+XhmyhfAc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TXF6arhKsC9mRp6f74VyNfuusUdI+YBznSjeuGVyy44AvNPWy0FavINHoHNIai+/p
	 EpkYNGQZEwUF3+Yv4GZZwoLoimUZJTPwuGexrfZIC+U7vD3CB5WU+2Y7zQhJGrcJrS
	 DSzMB0ybor0A7M2koFUkmYY+Ix3ysQCG5h4s5TSwIR8Qbof8HIC6nFVF2QLsQrZwCn
	 /eWWYALrBFcS9bC9vzuLif5oFqygpHiqSHV3cTeTkb586qFBi13N2suFf9UyGu/aTj
	 QoAablgXAQxPX/2sxyEpn9BptJatZaoLuo3b73dGhaIcOtLJzHL51xQ83y++FgvDbw
	 V2+oFulCDUYpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DF3393021B;
	Wed, 13 May 2026 16:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/25] bpf: Support stack arguments for BPF
 functions and kfuncs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177869043880.3729534.11654394350073284356.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 16:40:38 +0000
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jose.marchesi@oracle.com, kernel-team@fb.com,
 martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 May 2026 21:49:49 -0700 you wrote:
> Currently, bpf function calls and kfunc's are limited by 5 reg-level
> parameters. For function calls with more than 5 parameters,
> developers can use always inlining or pass a struct pointer
> after packing more parameters in that struct although it may have
> some inconvenience. But there is no workaround for kfunc if more
> than 5 parameters is needed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/25] bpf: Convert bpf_get_spilled_reg macro to static inline function
    https://git.kernel.org/bpf/bpf-next/c/ede2dc5c6b57
  - [bpf-next,v4,02/25] bpf: Remove copy_register_state wrapper function
    https://git.kernel.org/bpf/bpf-next/c/1cb229a54af1
  - [bpf-next,v4,03/25] bpf: Add helper functions for r11-based stack argument insns
    https://git.kernel.org/bpf/bpf-next/c/78bbe61632f1
  - [bpf-next,v4,04/25] bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()
    https://git.kernel.org/bpf/bpf-next/c/3ab5bd317ee2
  - [bpf-next,v4,05/25] bpf: Support stack arguments for bpf functions
    https://git.kernel.org/bpf/bpf-next/c/0f6bd5e7a804
  - [bpf-next,v4,06/25] bpf: Refactor jmp history to use dedicated spi/frame fields
    https://git.kernel.org/bpf/bpf-next/c/3a656670fd6d
  - [bpf-next,v4,07/25] bpf: Add precision marking and backtracking for stack argument slots
    https://git.kernel.org/bpf/bpf-next/c/0a0fdc64b68c
  - [bpf-next,v4,08/25] bpf: Refactor record_call_access() to extract per-arg logic
    https://git.kernel.org/bpf/bpf-next/c/84dd7df76efe
  - [bpf-next,v4,09/25] bpf: Use arg_is_fp() in has_fp_args()
    https://git.kernel.org/bpf/bpf-next/c/f44e815e65a3
  - [bpf-next,v4,10/25] bpf: Extend liveness analysis to track stack argument slots
    https://git.kernel.org/bpf/bpf-next/c/2af4e792773f
  - [bpf-next,v4,11/25] bpf: Reject stack arguments in non-JITed programs
    https://git.kernel.org/bpf/bpf-next/c/dc8f1cf6787c
  - [bpf-next,v4,12/25] bpf: Prepare architecture JIT support for stack arguments
    https://git.kernel.org/bpf/bpf-next/c/848d624acf66
  - [bpf-next,v4,13/25] bpf: Enable r11 based insns
    https://git.kernel.org/bpf/bpf-next/c/9fae4cba3bfd
  - [bpf-next,v4,14/25] bpf: Support stack arguments for kfunc calls
    https://git.kernel.org/bpf/bpf-next/c/e0b7b91c72db
  - [bpf-next,v4,15/25] bpf: Reject stack arguments if tail call reachable
    https://git.kernel.org/bpf/bpf-next/c/35b78733160c
  - [bpf-next,v4,16/25] bpf: Disable private stack for x86_64 if stack arguments used
    https://git.kernel.org/bpf/bpf-next/c/cb6af5314056
  - [bpf-next,v4,17/25] bpf,x86: Implement JIT support for stack arguments
    https://git.kernel.org/bpf/bpf-next/c/324c3ca6eed6
  - [bpf-next,v4,18/25] selftests/bpf: Add tests for BPF function stack arguments
    https://git.kernel.org/bpf/bpf-next/c/79e7ec00634e
  - [bpf-next,v4,19/25] selftests/bpf: Add tests for stack argument validation
    https://git.kernel.org/bpf/bpf-next/c/9f42204c62d5
  - [bpf-next,v4,20/25] selftests/bpf: Add BTF fixup for __naked subprog parameter names
    https://git.kernel.org/bpf/bpf-next/c/5b31de88920b
  - [bpf-next,v4,21/25] selftests/bpf: Add verifier tests for stack argument validation
    https://git.kernel.org/bpf/bpf-next/c/00c3ac4292a6
  - [bpf-next,v4,22/25] selftests/bpf: Add precision backtracking test for stack arguments
    https://git.kernel.org/bpf/bpf-next/c/6e277efbb19d
  - [bpf-next,v4,23/25] bpf, arm64: Map BPF_REG_0 to x8 instead of x7
    https://git.kernel.org/bpf/bpf-next/c/68e5627579d7
  - [bpf-next,v4,24/25] bpf, arm64: Add JIT support for stack arguments
    https://git.kernel.org/bpf/bpf-next/c/235b2fe772f5
  - [bpf-next,v4,25/25] selftests/bpf: Enable stack argument tests for arm64
    https://git.kernel.org/bpf/bpf-next/c/90e43f1b4753

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


