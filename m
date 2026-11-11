Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426014;
	b=F4RdYJfH3TIO5h/OWfzg1gpzuI5Pk8M6a+Vkl24LFUDkfTZAjnBjVYOxq6rOArHClUyx
	 YZIFMA/OSFf6Gty+S01z7kB5pV4Q5m2STL25PW20Q+IlWwKk12X4rdnxpL11Y25kejDum
	 hb5U5wjkbHuSOBSXjcqfrjPitVCql70HtbZ12LK+KaUDqzwFbcWmXZFjZX0cWfQuzkZgh
	 LYv0nL5y7QrIrRv2+VJ16WnW5rg/Wnexxg98AIyDxT1qjE+CDKSh48rQabE4oabvBViJr
	 hO/g5wREA941Br+u+x4M/TJCCukEww5Xl3pClkkfnXcKlkT60xFazT4iRSabWSYYBAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426014;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uda8OqhEWsoXdwd7JyZNHXQMITmUMzU+CxRU0ieGb00=;
	b=qXkW/izMxV5ZLCYOo6SxoqdeFKfnOslpe7k0jI7uRQCxLwjxB1n9F+kPOM4raQCTGoHd
	 rhgsr+oSI9J1NeqY2v4QxgIbDtPigfuGLGauz05p0qbytosa6PbCeO7ESXglJF54hVKaA
	 OJI5dCH6yY5OWr/tGxKL76iHUuOXdGb8oU3MxKYeGoTnOzyzSq6Gk/SxgQ0YmwjOkKFPs
	 JiYSuZfzZpknDmcuQX4kl/YL9uMJbnZdapoSwS9aDNURIwt62iJHfxoLsz/T7gZB3L+Bp
	 Jm02J2KWsTdmf1QtpaTrEITJAuWaOyee76rcNRyawvs8eZQwDBoVyEt4Yppy1V/jjvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A29szzZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9954606A33C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A29szzZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A609B1F00A05;
	Wed, 11 Nov 2026 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426014;
	bh=uda8OqhEWsoXdwd7JyZNHXQMITmUMzU+CxRU0ieGb00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A29szzZH+wVbqiewpMumFpR4Rn9ReUPaI3NxznPxzqYG/MGtstyrPSbx0oXYYMKUh
	 N8/DlYN8uIyPjBVo9oNfQaRVT0RJt9wfRb2K+flcNjxcEL05m8refjtXRD73kFWqTG
	 Fu9iU3KPxr2Uov79213WqQ3enkeu2/QjU5gJUKap2+zbCIOeWVFdITZI6vS2H6Zvy1
	 i0jcznHpnjL6c2iDk2FVTa16k1btoGPiWp0z34VP9eQj4VLC5I1k4xfRzuf7vsvpBK
	 Kp5S1l2o1JJ0f1wHGZANhpxKSzz/1ept5QlKYkbjgmzQtphqN0FRBVRom5rA5DVP/q
	 ljFtRefZ3AaIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0C938003BF;
	Wed, 11 Nov 2026 19:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/29] bpf: Find linked registers by scalar
 evolution, remove scalar ids
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179442601343.1604530.11783600567675514275.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 19:40:13 +0000
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Nov 2026 16:45:23 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
>   char *buf = bpf_map_lookup_elem(&map, &key);    /* 128 bytes */
>   ..
>   p = buf + i;                                    /* i is a byte */
>   if (i > 100)
>           return 0;
>   *p = buf[0];
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/29] bpf: Keep the 32-bit range across a no-op sign extension
    https://git.kernel.org/bpf/bpf-next/c/7f2be76f66c1
  - [bpf-next,v3,02/29] bpf: Model 32-bit shifts and divisions exactly in scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/af75e656127c
  - [bpf-next,v3,03/29] bpf: Construct scalar evolution expressions without allocations
    https://git.kernel.org/bpf/bpf-next/c/aba76dc75e35
  - [bpf-next,v3,04/29] bpf: Don't join dead registers in scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/88835c2be483
  - [bpf-next,v3,05/29] bpf: Simplify scalar evolution expressions at construction
    https://git.kernel.org/bpf/bpf-next/c/221d14d4e8f2
  - [bpf-next,v3,06/29] bpf: Give SSA names to the values that scalar evolution does not track
    https://git.kernel.org/bpf/bpf-next/c/cfef7bfa2c2a
  - [bpf-next,v3,07/29] bpf: Compute scalar evolution expressions for whole subprogs
    https://git.kernel.org/bpf/bpf-next/c/490460d3b2ac
  - [bpf-next,v3,08/29] bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
    https://git.kernel.org/bpf/bpf-next/c/ecb02a088761
  - [bpf-next,v3,09/29] bpf: Include older frames in a fill through an imprecise stack pointer
    https://git.kernel.org/bpf/bpf-next/c/616f6f3a0cd0
  - [bpf-next,v3,10/29] bpf: Detect a dead branch when a range and var_off don't overlap
    https://git.kernel.org/bpf/bpf-next/c/84d326943649
  - [bpf-next,v3,11/29] bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big endian
    https://git.kernel.org/bpf/bpf-next/c/c5142859aed4
  - [bpf-next,v3,12/29] bpf: Refine registers linked by scalar evolution at conditional jumps
    https://git.kernel.org/bpf/bpf-next/c/e2f3d29e88d0
  - [bpf-next,v3,13/29] bpf: Value number the phis of scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/527ebfb466f8
  - [bpf-next,v3,14/29] selftests/bpf: Test registers linked by scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/6d679b770373
  - [bpf-next,v3,15/29] selftests/bpf: Test sign extensions of a range and of a linked register
    https://git.kernel.org/bpf/bpf-next/c/8dceb4e1dd54
  - [bpf-next,v3,16/29] bpf: Recompute a pointer after the jump that bounds its index
    https://git.kernel.org/bpf/bpf-next/c/94a5bec008d7
  - [bpf-next,v3,17/29] selftests/bpf: Test a pointer computed before its index is bounded
    https://git.kernel.org/bpf/bpf-next/c/8a52d7c8b3a4
  - [bpf-next,v3,18/29] bpf: Promote memory behind a pointer to SCEV registers
    https://git.kernel.org/bpf/bpf-next/c/fd8e6bf8d240
  - [bpf-next,v3,19/29] selftests/bpf: Test the memory of a caller that a jump tests
    https://git.kernel.org/bpf/bpf-next/c/bb264c399ccb
  - [bpf-next,v3,20/29] bpf: Find a copy of an induction variable without scalar ids
    https://git.kernel.org/bpf/bpf-next/c/1ff08ed619d4
  - [bpf-next,v3,21/29] bpf: Compute scalar evolution expressions in irreducible loops
    https://git.kernel.org/bpf/bpf-next/c/8b81ea69de07
  - [bpf-next,v3,22/29] bpf: Remove sync_linked_regs(), refine by scalar evolution only
    https://git.kernel.org/bpf/bpf-next/c/315a2adc00e2
  - [bpf-next,v3,23/29] bpf: Recognize copies of a scalar by their ranges in flow_join_makes_up()
    https://git.kernel.org/bpf/bpf-next/c/d0a2961adf22
  - [bpf-next,v3,24/29] bpf: Stop assigning ids to scalars
    https://git.kernel.org/bpf/bpf-next/c/5d3a85d3743d
  - [bpf-next,v3,25/29] bpf: Remove scalar ids from regsafe()
    https://git.kernel.org/bpf/bpf-next/c/c9a6eeaf44d1
  - [bpf-next,v3,26/29] bpf: Remove scalar ids from the join of states
    https://git.kernel.org/bpf/bpf-next/c/2efaa4901da0
  - [bpf-next,v3,27/29] bpf: Remove scalar ids from the log and from bpf_verifier.h
    https://git.kernel.org/bpf/bpf-next/c/ba3dfc8f872d
  - [bpf-next,v3,28/29] bpf: Support sign-extended 32-bit linear scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/ab981af5e99c
  - [bpf-next,v3,29/29] selftests/bpf: Test loops with a sign-extended 32-bit induction variable
    https://git.kernel.org/bpf/bpf-next/c/e7a54ec8a3b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


