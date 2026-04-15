Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C71296BBC
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268839; cv=none; b=TeR80x/wStlBV7vHTc0+6z1DdaQKYlMYM2gFjETrFH6rFceoQaeC0pE2vZf2Xz9d9pZFgvUFGMG9HxfPmN7Cj33ioAcnoUY1qFp5zauekhahzAvlKCvJYaw5g1GGAwe0MOfQ569PU2Y88HkAilpVQKJM/BgKoP2ka3mG/3WEV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268839; c=relaxed/simple;
	bh=j2Zex0yFiLClGPp1b6qxDDEemXWgbbUHnNmYWrdJv6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kmLZ5IrujGKhDytMOY6EnZCPyapBMiFHiAX5+YGz7t4FjpVPpdjRrZWPsChBYKT3Drv4+FkVXTWkNrv3gF/SEtxppcOQH2mpeJecYUOA9EX7VReXJKWwTYBJE7bKuHL2UComZrcXlBQA6NKKd9KaJZU+Bp7J9mGG/K9rVXZv91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVkRNNvT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVkRNNvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE9DC19424;
	Wed, 15 Apr 2026 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776268839;
	bh=j2Zex0yFiLClGPp1b6qxDDEemXWgbbUHnNmYWrdJv6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tVkRNNvTI7jzNRqUtsVEhu8oI5zZwBQp+aQZ84o5mKqIsPaUmabJ1Y1GWetuGmYC/
	 WYLdJv3tahvTZcv7xrPl7qx2+6ePeKLsvNGLB0UGcvdSeQAO5bMXcGKLsG4WztlA0i
	 ffr3q8YUS2h3GMnyd1WINsvM4Mhx8tws4qjpQUmnT0eptQxMP7ivIuwOb9pxFj/VE9
	 41cxkrf3Ep2r0k5/gRiB2lzKsBny2BB74CeRe5Q74YbfZHKBrKb/L/uscxPWx8LP8u
	 59G1iYLCjun6pUkJSMtyyNyTRlp7XBguEywRrpNvmV0NdeUlh1rlZPM89/9khbtm6X
	 LYiwdWml2/AZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1C380A963;
	Wed, 15 Apr 2026 16:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: arg tracking for
 imprecise/multi-offset
 BPF_ST/STX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177626880880.2296878.5804575995371797981.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 16:00:08 +0000
References: <20260413-stacklive-fixes-v2-0-398e126e5cf3@gmail.com>
In-Reply-To: <20260413-stacklive-fixes-v2-0-398e126e5cf3@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Apr 2026 16:30:51 -0700 you wrote:
> When the static arg tracking analysis encounters a store through a
> pointer with imprecise or multi-offset destination, it must use weak
> updates (join) instead of strong updates (overwrite) for the affected
> at_stack slots. At runtime only one slot is actually written; the
> others retain their old values.
> 
> Two cases are addressed:
> - BPF_STX, handled by spill_to_stack(). It was gated on
>   `dst_is_local_fp = (frame == depth)`, which missed ARG_IMPRECISE
>   pointers entirely.
> - BPF_ST, handled by clear_stack_for_all_offs(). It delegates to
>   clear_overlapping_stack_slots() which unconditionally set
>   `at_stack[i] = none`. Change to `at_stack[i] = join(old, none)`
>   when multiple candidate slots exist (cnt != 1), so that untouched
>   slots preserve their tracked values.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: fix arg tracking for imprecise/multi-offset BPF_ST/STX
    https://git.kernel.org/bpf/bpf/c/ecdd4fd8a54c
  - [bpf-next,v2,2/2] selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
    https://git.kernel.org/bpf/bpf/c/d97cc8fc997c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


