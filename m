Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328F448A2BC
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017012; cv=none; b=NJCbf/AVydoDWhWuO4XaN4Mb0Pr6JKuluZn4+g3NYuIkWJ6EcXhW2LIbmXkYqQEoV6HGa37xwRpYUpCI4mj8chI79thqRrk/i+dYTY6W/4nTWg5yjtiOEx7SLhrbatESxzUfCT1shUCGEugZu2UNU07o+2Tun278LXhXq7B+6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017012; c=relaxed/simple;
	bh=Af4osD9lea/K9BJDivjTtWATcL+kMH4ySc+1tBKWIeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pfyBBxAlVETXOcDnJvFS3FVK1SC67Ao4KgANR8oDBDrglwLmmGu+LLHC1iKaguGL4+CmM/Pk1FibXq7X1GM+Y1EOzYIEhUwDerMQCjG3wPSqYk26VqSVF6MmKNgIhdlvUtDWkKHRMW96NWs50cqaULWTY3TWFsHY910IaJujVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekEpyH43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekEpyH43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087F31F000C4;
	Wed, 14 Oct 2026 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792017008;
	bh=/e/Wjvy77x6+EvSiKL7s61a7Rqinwa5zWP3pOGXz8Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ekEpyH43xbZaU1S2UsvlGN/xKRD0kk8xnACoDXGKrp/ly+LZ/aPEAQOHp+Iu1Xb6g
	 Y/CHYM2AvDWm/NV2/3GYStFZ+hCsd0P5qGAxExlX7Wb+WFOjaZz7qiSFySf4GSLgHk
	 9w0tR4iLH7xvrrRpuSOfgPwZbZLvNN/oNzddMhZ0Malui7DDbLq3hjfM0FCFxpIykG
	 JNAnal67utTr9cFthLnDNATUJn4jJftDs3B8V9MvWJ1g5Zg5QGUjs4GR9OJtHSAbOh
	 +c2XY1FXL+adZWFuVV+tlBuEjgRYgvZ7alE4gDuzGPr+vFL7YJMRzK9sy3m4z4XM7g
	 /jIsky2nXOlFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14E83803318;
	Wed, 14 Oct 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] bpf: follow-up for scalar evolution
 series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179201700677.3065620.12309731207702632706.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 22:30:06 +0000
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 13 Oct 2026 23:24:35 -0700 you wrote:
> Assorted follow-ups for the series [1]:
> - Handle ARG_SCALAR and ARG_PTR_TO_DYNPTR in
>   bpf_global_subprog_stack_access_bytes().
> - Fixes for other nits reported by bots for the series.
> 
> Changelog v1 -> v2:
> - dropped patch #1,
>   "bpf: static subprogram arguments liveness should use BTF type info",
>   see the v1 lore link for explanation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: more precise stack liveness effects for global func params
    https://git.kernel.org/bpf/bpf-next/c/e980770b431a
  - [bpf-next,v2,2/7] bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM
    https://git.kernel.org/bpf/bpf-next/c/06e0e41e6223
  - [bpf-next,v2,3/7] bpf: reg_bounds_sync() comment fixup
    https://git.kernel.org/bpf/bpf-next/c/4d274f1ef049
  - [bpf-next,v2,4/7] selftests/bpf: stack effects of scalar/dynptr global subprog params
    https://git.kernel.org/bpf/bpf-next/c/ff9e7261e0ce
  - [bpf-next,v2,5/7] selftests/bpf: harden __msg pattern for global_callee_btf_arg
    https://git.kernel.org/bpf/bpf-next/c/3f3137ef1c9e
  - [bpf-next,v2,6/7] selftests/bpf: harden __msg patterns for step_movsx_bounds_on_line
    https://git.kernel.org/bpf/bpf-next/c/1bb030a11fa6
  - [bpf-next,v2,7/7] selftests/bpf: BPF_F_ANY_ALIGNMENT for byte_array_size_spanning()
    https://git.kernel.org/bpf/bpf-next/c/75fc921e7f80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


