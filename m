Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855613;
	b=GRa1Ilt1dAiurqQSE7/YnztXtynt85EfWO07RpiZ4IXkjlOcUwpd5030awPTO74pYIWm
	 Ad8sLt/+aRnuAKFXGo+4YR+uwPtTsEJ39ms7jG2/5pCh0DP29vLcxuOBJ9W1d7NAND0qJ
	 Nh9+56BaNj0MSaHn+lFWSyozFWPe1o21nJDm8lCJE4TTF5wDseMuo6wGNc2+QCKv679Zz
	 d/L09vB4IfnNze81NoA0ZKys+YlGHOoB6gJTHLd3wRf27f8fPb7DBghf87j4L70Y88laN
	 hc4m52524/zTIAzNV996CutSKO24d+QbX3StJ0r+cKm7dNDPwIrkHKydjLDndT6zGTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855613;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=i9/TGxirHRCjsl1xJ5Ez8tjtLACNRpvLp6gGq4W1DSU=;
	b=LJppIJ/5cmFWc5JWkWofK7xtXzL0X8c3+e/nfgb79CK3w1zSU3bv9aWbRdeSKsbIVJWf
	 TBCVhj8Hdw6Pb3ooH2kjhNCRmXQK1CrA3uZc0ax29fteN3InsUYJ6+cwWlDSh/F1agWtE
	 iCX3DK3fMtP3lfqkL1p2lNiqc9h1997iXajYmtuiqPgG6SexJDRPsGjtynuqJSMClp69v
	 xKWgXXNF21h276bgVDbmHz5X+ktUpDEqTi2I+EU7nupGOjU8+MNravL2bCflmCk8tkKr7
	 Cn4FkD5wVLJOUIivnv2SIFZ53lyssRoG0WK2e6LrLMmn/jwgabbROJXM8adC5gIhNHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nKnUhTVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF1606A333
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nKnUhTVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485CA1F000C4;
	Mon, 16 Nov 2026 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855613;
	bh=i9/TGxirHRCjsl1xJ5Ez8tjtLACNRpvLp6gGq4W1DSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nKnUhTVXaQhBPtLM5fF532V4uLTLF+q6P1T0BChIBxU0Xc7jwbBs3lIq5mqUoimxw
	 /XSbu2Ke2IHzyAhTGcj5/9dpvEteU1JzLmDaJ0PkTxgpjnfacCvSUAzRZVsx7UYCuw
	 xAXw0HcCLLc5d7BhB6hD65BgDqUuH4lLOIl+2xTQRtAZd9S93L5RAbr7NPvmCuxCbQ
	 E8iz/BlTxe9FPnjYzCjiPrTDyXa+pEWb5mxTj0BXat03O2zeS8X8Htf4qPCqzZPW/C
	 gi9QgFxbvbX4mM9wrIMZL3VOf2vRKPp/WmT1lkJZlKU73moa0H9qxXKws3c5OV22i7
	 /Vp1jkK+AkP7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A447391AFC8;
	Mon, 16 Nov 2026 19:00:13 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 00/21] bpf: Remove the limits on maps, kfuncs,
 subprogs and special fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179485561177.3833796.13936973783069246360.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 19:00:11 +0000
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 16 Nov 2026 15:26:05 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> In short: the verifier keeps the maps, kfuncs, subprogs and special fields
> of a program in arrays of a fixed size. A safe program that needs one more
> entry is rejected. With this series the arrays grow with the program. What
> was quadratic or worse below a limit is linear or n log n now. Outside of
> tools/ the kernel loses 300 lines.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/21] bpf: Stop a load only when the loader is killed or has to freeze
    https://git.kernel.org/bpf/bpf-next/c/3a05f3d3c0bc
  - [bpf-next,v2,02/21] bpf: Fail the load when there is no memory
    https://git.kernel.org/bpf/bpf-next/c/4599bf12bb4f
  - [bpf-next,v2,03/21] bpf: Give a syscall program the largest context when it does tail calls
    https://git.kernel.org/bpf/bpf-next/c/08c987904970
  - [bpf-next,v2,04/21] bpf: Do not inline bpf_loop() when its callback is dead code
    https://git.kernel.org/bpf/bpf-next/c/55bb28777e3a
  - [bpf-next,v2,05/21] bpf: Dump programs that have more than 524288 insns
    https://git.kernel.org/bpf/bpf-next/c/97d3a5d19de6
  - [bpf-next,v2,06/21] bpf: Resolve BTF structs and arrays first
    https://git.kernel.org/bpf/bpf-next/c/9867cc99fb19
  - [bpf-next,v2,07/21] bpf: Remove the limits on maps, BTFs and fd_array of a program
    https://git.kernel.org/bpf/bpf-next/c/1ec779c99e72
  - [bpf-next,v2,08/21] bpf: Do not scan all maps for each insn and each subprog
    https://git.kernel.org/bpf/bpf-next/c/8aeba721ce8c
  - [bpf-next,v2,09/21] bpf: Remove the limits on kfuncs of a program
    https://git.kernel.org/bpf/bpf-next/c/dba6e823dc9a
  - [bpf-next,v2,10/21] bpf: Remove the limits on tables of functions
    https://git.kernel.org/bpf/bpf-next/c/66b31f31139e
  - [bpf-next,v2,11/21] libbpf: Size the tables of the loader program from the object
    https://git.kernel.org/bpf/bpf-next/c/cf46f59c622f
  - [bpf-next,v2,12/21] bpf: Relax jumps that patches push out of range
    https://git.kernel.org/bpf/bpf-next/c/80ab9d3a5e45
  - [bpf-next,v2,13/21] bpf: Keep the call graph in lists of edges
    https://git.kernel.org/bpf/bpf-next/c/0073adc796bd
  - [bpf-next,v2,14/21] bpf: Find the effects of callees on the call graph
    https://git.kernel.org/bpf/bpf-next/c/8a7567b57874
  - [bpf-next,v2,15/21] bpf: Link the decl tags of a type
    https://git.kernel.org/bpf/bpf-next/c/d01bec4218c7
  - [bpf-next,v2,16/21] bpf: Remove BPF_MAX_SUBPROGS
    https://git.kernel.org/bpf/bpf-next/c/f7e93aa4a34f
  - [bpf-next,v2,17/21] bpf: Walk each type once when looking for special fields
    https://git.kernel.org/bpf/bpf-next/c/ca4395aade31
  - [bpf-next,v2,18/21] bpf: Raise the limit on the length of BTF names
    https://git.kernel.org/bpf/bpf-next/c/00b7fccc41c7
  - [bpf-next,v2,19/21] bpf: Find dominators in O(n log n)
    https://git.kernel.org/bpf/bpf-next/c/c424815cd9a1
  - [bpf-next,v2,20/21] selftests/bpf: Test programs above the old limits
    https://git.kernel.org/bpf/bpf-next/c/eda0d4a09944
  - [bpf-next,v2,21/21] selftests/bpf: Test limits of the load with raw programs
    https://git.kernel.org/bpf/bpf-next/c/633c547b1dab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


