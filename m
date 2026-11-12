Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513612;
	b=zw1hOIiGJQNt77mVWBMiZG5M/8HEW3CZ47Jvto54frfvu+lQ6Hw5Ic8Lep9yv69fHBIc
	 MyyLuwrBsNKtPWU6hO6fU+4nAnf5DAel3Hwo/F7XxN42cOSNVwZjwUFwwNR/2doNRh3WQ
	 MPPK1RNyixZWcHAYV75j/GdqtmSAllcJ5zj1TZfcKVcASI737YHc34A7jDZfC9sCSRdwv
	 ZU4SEEofdbTdL/UT1nTZuWbJSdiNGWOFc8XF80Gt7bzonRT+hBt+aq1DXB+2f5yZS58la
	 MClRDHdhP5xqBOli1ijZ/aszUnqIBIpzlMzGGFKHD6L8+5Mjw/IIYYjYPsI1vijQGDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513612;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=n4MC9s0JPx1x95yLvQtF8ufPOoJkl4bF8ZLFbA+VQos=;
	b=ocVJN0JWqJfdvPIFyGm5RtQ43i+BCizfbEqe3rP+gjkdELq62uX/qkFSAfM7LU/s0ET/
	 kZgCUihNBn/maBVfjRL1IV1ILX/6OcIt6NfQNJEFgRU0n0sU0CmVogL97CvOMlynZGpos
	 K37N6iVLL/1naw46+2JV7vfPKEBUZLM4/BS+ZHrtnNMnQSPSGa17S2AV82nwgHFRpfkpB
	 XwBgQ3qBUVXbsEb9R4gtP2Nbdr4lTh/Da5TTped/jJDrhWsqcsFFuVnkuf9yu1QaigVtF
	 YZbV8yYwPqwgKQ16TJ7G5Z73UFnXk8GdVy7FPkLaY+3MzGb7HTtZoWqszDf6+FIrjlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD5trvWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5F606A331
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD5trvWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464901F000C5;
	Thu, 12 Nov 2026 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513612;
	bh=n4MC9s0JPx1x95yLvQtF8ufPOoJkl4bF8ZLFbA+VQos=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BD5trvWZie5CDlwbekUJyN5ITKrTlpja6d52Jia8DRrmVrbNGa0jMF3AmSwXP90pI
	 vTGdGFcc3sWTKVX0i/vZttb4wE3ecHPLNZnvAPJLDwSCztAlVUsgTfSTDCl6zSwb/+
	 PeujMSoU9JrzplDBpEbYZcB1pjMMsa4WQPRy899YTkDcqOhAOOrNnQr703aMj3X01Q
	 zHW7mJrNkwQ+RKdb7dlv7qFhie+joUG2w6mC4IeKmlVU7MV1rjvuCyQ/CFaH4eUKdQ
	 LHEM5LamBgTeme2ASgSZnZYR5cAApGweehhBAKPSTced7dTosJ6nDMv8r87Am517LW
	 sdKcvLf80Ro/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3B13926259;
	Thu, 12 Nov 2026 20:00:12 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 00/12] bpf: Evaluate scalar evolution expressions
 in
 the state after a jump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451361077.621483.12305180133260861545.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 20:00:10 +0000
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Nov 2026 15:53:25 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Falco and Tracee (patches 1 - 2) give a helper a pointer to the stack whose
> offset stack liveness loses. The whole frame is live, and spilled pointers
> that no insn loads again keep states apart. Insns: recvmsg_x of Falco
> 13267 -> 1954, trace_security_file_mprotect of Tracee 17872 -> 8515.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/12] bpf: Don't keep a spilled pointer for a read that sees only bytes
    https://git.kernel.org/bpf/bpf-next/c/f880df374985
  - [bpf-next,02/12] selftests/bpf: Test spilled pointers that only bytewise reads can reach
    https://git.kernel.org/bpf/bpf-next/c/344941c4cf61
  - [bpf-next,03/12] bpf: Don't leave map_ptr in the address of an arena variable
    https://git.kernel.org/bpf/bpf-next/c/e2ae90016b97
  - [bpf-next,04/12] bpf: Make the operations on a scalar take struct scalar
    https://git.kernel.org/bpf/bpf-next/c/9ee4bcac2c62
  - [bpf-next,05/12] bpf: Split scalar_alu() out of adjust_scalar_min_max_vals()
    https://git.kernel.org/bpf/bpf-next/c/dee63e11642e
  - [bpf-next,06/12] selftests/bpf: Test a jump that compares two pointers
    https://git.kernel.org/bpf/bpf-next/c/68134af648e8
  - [bpf-next,07/12] bpf: Take the outermost common base of two linked expressions
    https://git.kernel.org/bpf/bpf-next/c/8a6465550004
  - [bpf-next,08/12] bpf: Treat 'r1 &= 0xff' as a zero extension in scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/28f6709dd84c
  - [bpf-next,09/12] bpf: Add scalar_intersect()
    https://git.kernel.org/bpf/bpf-next/c/191571e6e69c
  - [bpf-next,10/12] bpf: Evaluate expressions by the transfer functions of the main pass
    https://git.kernel.org/bpf/bpf-next/c/f54e144a6936
  - [bpf-next,11/12] bpf: Evaluate the expression of a linked register
    https://git.kernel.org/bpf/bpf-next/c/1ef7c36bd9eb
  - [bpf-next,12/12] selftests/bpf: Test the evaluation of linked expressions
    https://git.kernel.org/bpf/bpf-next/c/c9a18e1488b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


