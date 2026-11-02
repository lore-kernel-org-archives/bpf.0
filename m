Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658609;
	b=BaHCOTBbd2kMmk62XODJNj6/vkbYU4vf8eAsFxW3SyCF55y5KwyHWBn6joYsFOc2obiH
	 FqxYWW7e81Vp22z61NwBu/CUTIIOg8rG6U5FSe3UZO36rzSz4Ss3IPo9Ww2Fmjn28ggqT
	 sx9QnSi9fHDDTocnS7WQaoduKNQbGUouSxKbavK6Ka6umYl1LYtcwPTzh2K8jeKpfkcGY
	 sh3cF8RvBCg6DBEM1w9uMI3hcoEDYao1nhyf9JJXlDq2vayEcO/+3CfEn2nsmbSD+PT2c
	 3jvQtCJtuk/jD6W0h4Rw4eweNK0mHDATOvUCBshh7s74p7rUlhldUKAJqQPPHRJGIpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rs6qEtPItRTMHZX9exXJZ0Mx0TZWRTUeJUcsB2lFl1g=;
	b=AQ3xtfrPYzab4J6G6kIaFQvzM07wb5ZILeS0ufQCb1tEQog9S0/IDNbJ2gI8fWwVmEIx
	 98eBB+MJHzgmNuS8+GXUpUYeh2aPE+HZX9D5S4VGsX4SLEPPb8azUlr3Vh7vCj5p8lwXE
	 q9o9BLzd9eJfAtR0iFhKUS7+kLSXWhEpjwrM+T9R2HmO/IzidFBVxkJuZN4OO0AZRVPa/
	 567KKeLZWGixcJ7jC+uhoEF8TbXwekmykVA2pC8KDFWLSw2dyE53OOXUO0Aljh0+jiarx
	 dHPuTUYfFoq2LMTAl3nL4wYIwHW3VgCh6UR0msOt7+WzdyHqKOUtqVqfukVGoM59thA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkrsvoVu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D8606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkrsvoVu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD601F00A16;
	Mon,  2 Nov 2026 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658609;
	bh=rs6qEtPItRTMHZX9exXJZ0Mx0TZWRTUeJUcsB2lFl1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UkrsvoVu1xKSdnxNwIE6RvxrqPCfjwWfMGHV7Jhw/MoOC65eHGwF/vQvnLpZd/7Z1
	 6TXJEc7jjTGWNw1j2xeEYHpii2cH6WPqTXf8IyL9n+/STStxdULPYSG7nEppVzdD6j
	 Qd3zY0P7yRLH9LotDsQkalKSIhFyCDLppt6/KBNwJcpwPw3iuCQ/57FdOVBjm4CgLU
	 QnGw1j0nQT+bs0u8PzTpP7S7kmewB35Viqic9nKhB2ZksM+e13LpSabseAZfDgVj8E
	 xV4YuQy9RwpBa30jQJvm8jTo3JsNcJxPV571lrJM3hJ4HPi5Penc8rhPmvnOud6umU
	 ZkuSb71Jf7DaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0318D380821F;
	Mon,  2 Nov 2026 22:30:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf v2 0/9] bpf: One may_goto time slice per prog
 invocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179365860780.698908.5907895296789824296.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:30:07 +0000
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 31 Oct 2026 21:55:34 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> may_goto stops a loop that the verifier cannot bound: after 250 ms the loop
> must exit. The count and the timestamp are in the stack frame of the
> function that contains the loop. So the limit is for one call of a subprog,
> not for one invocation of a prog. Loops that nest across calls multiply it,
> and 9 insns lock up a cpu:
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/9] bpf: Emit timed may_goto for JITed progs only
    https://git.kernel.org/bpf/bpf/c/1ddffb57b362
  - [bpf,v2,2/9] selftests/bpf: Don't cast a pointer to .bss in arena_htab_asm
    https://git.kernel.org/bpf/bpf/c/fcda8096dc5d
  - [bpf,v2,3/9] selftests/bpf: Give the first loop of cond_break5 an end
    https://git.kernel.org/bpf/bpf/c/40a3a2e686f8
  - [bpf,v2,4/9] selftests/bpf: End the loop of parallel_test_bitmap after 50 ms
    https://git.kernel.org/bpf/bpf/c/5eced83779fd
  - [bpf,v2,5/9] s390/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
    https://git.kernel.org/bpf/bpf/c/85b6a11252ba
  - [bpf,v2,6/9] bpf: Pass a pointer to arch_bpf_timed_may_goto()
    https://git.kernel.org/bpf/bpf/c/78821f4d8d18
  - [bpf,v2,7/9] bpf: One may_goto time slice per prog invocation
    https://git.kernel.org/bpf/bpf/c/ec274bb4665c
  - [bpf,v2,8/9] bpf: End bpf_loop() when the time of may_goto is up
    https://git.kernel.org/bpf/bpf/c/c16c6c4683cc
  - [bpf,v2,9/9] selftests/bpf: Test one may_goto time slice per prog invocation
    https://git.kernel.org/bpf/bpf/c/9d8affd7b6f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


