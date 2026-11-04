Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817614;
	b=thMWa09exI70UQSKfq2oQXV9O9X8erX+XMLOl8s7c9dfCYQvCOM4AYwNzYhpq0iDuJhy
	 FDUHPzrlLLNkdSdgrBWM+U2rcWNJZPzyxOJM0190oAZc8KujJHusE0JyqosxmD2Dih2Pi
	 ciVJXLhFuRkzMd7ylWj39qkSURtyOkT/QJYpasYSgtIJQrkqYacH+BPCjtquSFP2vMkzy
	 VAt0tIXB6sQNhL3dHe6I27boS1GqI/rHBBXpmVY83TdGyL4Mayh8uKATSs5KHKtHGFt35
	 sE0MmcsE7SX+3e+X92DZjSXvbALd8O+rPZFIOhl0rOESo+Vmor7cMo/Pt5HYjKhz5IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817614;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nRPkXVmhcOMxeOcyT5R5LuX+2eYXylUTRx3d3KHE+OE=;
	b=qF65HO4t4HjW/wGT4M9ajvbBtVkOypF4dXuky7qjU6tyGaAwakYuqVQDX2V+SBTtSvQD
	 PdzMELt2JIBPSk7b7z56nKSZulGEfhLU9vL7kUWoEoO1DFx80PyEYYDsmarIoTw5wbDYU
	 D9V1sux644+n5+aU3h4n0SomwKOQYN8u+bE6D9MUSSVwaMKwfzLzrXngk9uu/1/BTKIOu
	 chyY19i/WTRk8xTCPwI33oNsqLmaWdrlhBp/Mjk8BzhtEIzkwpHBrLJgcp+8Ih9hGEDgX
	 LSIruItu/H7qq4wDEiGV086Ff+Zkzsq4azy6ZAgjK8aDW1JRS7+ZTxaNSVBUYFWMD/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsfQt5Yo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE8606D81D
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsfQt5Yo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC3D1F00919;
	Wed,  4 Nov 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817614;
	bh=nRPkXVmhcOMxeOcyT5R5LuX+2eYXylUTRx3d3KHE+OE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GsfQt5You8z7KcBGhjPUiWlEqMqceOhlZe/UYt+3PnSnjExqqD/ZwTb8rqw1TOzsj
	 eGQ+iO2PT7365s1ycAPi4q0CTOiyamTj/zMNekMFX//HD7mdKCY2/hk1Xv+64roBzE
	 iEVdDEVvc7NY72u4D+CybsGNoV2wgWtWW2M+tLaxjnk4LHcN7jrIChxVCksKagx/SK
	 p14ajFa4ZYli6yCC2CnzsUGqWbB/aMQsxFh1OtwxEKFXD3SkgrIOiNSBrgti34GIdx
	 YpUtCBIvpsLzXSM1ryL4FD+sTIzr76VD+mK6fHW3z2snjeX1t8FfC8rwCsD/xlzJmF
	 mF7DD+fkrSbng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4013C380045C;
	Wed,  4 Nov 2026 18:40:14 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 00/37] bpf: More precision, more counted loops,
 larger limits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179381761305.3037121.5006370449835582185.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 18:40:13 +0000
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 23:40:25 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> This series lets the verifier of today accept more of the code that
> compilers make. The main pass does not change: it follows each path of
> a prog and prunes, as before.
> 
>   precision   A packet pointer keeps its range when the prog adds a scalar
>               that is not negative. A shift, a division and a remainder by
>               a range have bounds.
>   loops       Scalar evolution counts more forms of 'for' and 'while', and
>               it has a formula for more of the registers that a loop
>               changes. The verifier verifies such a loop one time.
>   subprogs    The verifier takes the arguments of a static subprog from
>               its code and not from BTF. A trampoline on such a subprog
>               keeps what the code takes, or the attach is refused.
>   limits      24 arguments of a static subprog, 1024 subprogs.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/37] bpf: Keep the range of a packet pointer when a number >= 0 is added
    https://git.kernel.org/bpf/bpf-next/c/45d59681f3cc
  - [bpf-next,02/37] selftests/bpf: Test range of a packet pointer after a number is added
    https://git.kernel.org/bpf/bpf-next/c/51032aea1bf1
  - [bpf-next,03/37] bpf: Refuse fexit on an unreliable static subprog that returns in R0:R2
    https://git.kernel.org/bpf/bpf-next/c/2eb1eed2e5d1
  - [bpf-next,04/37] bpf: Don't trust BTF of a static subprog that reads more registers
    https://git.kernel.org/bpf/bpf-next/c/2896cd5e4c13
  - [bpf-next,05/37] selftests/bpf: Test trampolines on subprogs that take more than BTF says
    https://git.kernel.org/bpf/bpf-next/c/4a0cd51e286c
  - [bpf-next,06/37] bpf: Count stack arguments of a static subprog from its code
    https://git.kernel.org/bpf/bpf-next/c/046d838506d5
  - [bpf-next,07/37] selftests/bpf: Test static subprogs that don't take what BTF says
    https://git.kernel.org/bpf/bpf-next/c/9886ecdcd7fa
  - [bpf-next,08/37] bpf: Don't treat a partial spill as widened in scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/37f84dfb1659
  - [bpf-next,09/37] selftests/bpf: Test loops that change a partial spill
    https://git.kernel.org/bpf/bpf-next/c/d75ccdaae417
  - [bpf-next,10/37] bpf: Let scalar evolution see loads from read-only maps
    https://git.kernel.org/bpf/bpf-next/c/175e26169525
  - [bpf-next,11/37] selftests/bpf: Test scalar evolution with a loop bound in .rodata
    https://git.kernel.org/bpf/bpf-next/c/0634a3013121
  - [bpf-next,12/37] bpf: Helpers don't write through ARG_ANYTHING
    https://git.kernel.org/bpf/bpf-next/c/17c81e54313a
  - [bpf-next,13/37] selftests/bpf: Test scalar evolution with stack address as ARG_ANYTHING
    https://git.kernel.org/bpf/bpf-next/c/3c2d8f49910b
  - [bpf-next,14/37] bpf: Fold sums of constants and two shifts by 32 in scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/28a373cb0f6a
  - [bpf-next,15/37] selftests/bpf: Test sums of constants and shifts by 32 in scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/9ab0b9bdd6ad
  - [bpf-next,16/37] bpf: Count loops whose first value or bound is a range
    https://git.kernel.org/bpf/bpf-next/c/1e589fdc85a8
  - [bpf-next,17/37] selftests/bpf: Test loops whose first value or bound is a range
    https://git.kernel.org/bpf/bpf-next/c/e3abb964db81
  - [bpf-next,18/37] bpf: Describe more registers of a counted loop
    https://git.kernel.org/bpf/bpf-next/c/09c5008302ed
  - [bpf-next,19/37] selftests/bpf: Test more registers of a counted loop
    https://git.kernel.org/bpf/bpf-next/c/96e163a3ada8
  - [bpf-next,20/37] bpf: Compute scev for a loop that has more than 256 exits
    https://git.kernel.org/bpf/bpf-next/c/445fd137453e
  - [bpf-next,21/37] selftests/bpf: Test a loop with 301 exits
    https://git.kernel.org/bpf/bpf-next/c/b8d40996942a
  - [bpf-next,22/37] bpf: Describe a 32-bit counter that lives on the stack
    https://git.kernel.org/bpf/bpf-next/c/e5872c5e13da
  - [bpf-next,23/37] selftests/bpf: Test a 32-bit counter that lives on the stack
    https://git.kernel.org/bpf/bpf-next/c/11f494a9180b
  - [bpf-next,24/37] bpf: Count a loop with several back edges
    https://git.kernel.org/bpf/bpf-next/c/638524a5a882
  - [bpf-next,25/37] selftests/bpf: Test loops with several back edges
    https://git.kernel.org/bpf/bpf-next/c/e82182c75c5f
  - [bpf-next,26/37] bpf: Compute bounds for a shift, a division and a remainder by a range
    https://git.kernel.org/bpf/bpf-next/c/ec0e0a31f7ad
  - [bpf-next,27/37] selftests/bpf: Test a shift, a division and a remainder by a range
    https://git.kernel.org/bpf/bpf-next/c/1508ee94f9f1
  - [bpf-next,28/37] bpf: Count a loop whose latch is false in the first iteration
    https://git.kernel.org/bpf/bpf-next/c/68c6597b1661
  - [bpf-next,29/37] bpf: Count '!=' across 0 in 32 bits and loops that go down
    https://git.kernel.org/bpf/bpf-next/c/3e2b371a432f
  - [bpf-next,30/37] bpf: Count a loop whose latch tests a flag that a jump sets
    https://git.kernel.org/bpf/bpf-next/c/c385a413be75
  - [bpf-next,31/37] selftests/bpf: Test more latches of counted loops
    https://git.kernel.org/bpf/bpf-next/c/d80f5b119460
  - [bpf-next,32/37] bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of functions
    https://git.kernel.org/bpf/bpf-next/c/3f4f430fa1b2
  - [bpf-next,33/37] bpf: Keep the frame of analyze_subprog() small
    https://git.kernel.org/bpf/bpf-next/c/bd1e73de87fc
  - [bpf-next,34/37] bpf: Allow 24 arguments of static subprogs
    https://git.kernel.org/bpf/bpf-next/c/b19a6aa8487a
  - [bpf-next,35/37] selftests/bpf: Test a static subprog with 24 arguments
    https://git.kernel.org/bpf/bpf-next/c/3c824fe3c78d
  - [bpf-next,36/37] bpf: Bump BPF_MAX_SUBPROGS to 1024
    https://git.kernel.org/bpf/bpf-next/c/70bcb39a7392
  - [bpf-next,37/37] selftests/bpf: Make room in veristat for the stats of 1024 subprogs
    https://git.kernel.org/bpf/bpf-next/c/65a45c702bee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


