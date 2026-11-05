Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842214;
	b=cVExzKP5fFUhuQ0Q5M06PE9FtJ4MLxs7pH/5NZl9RCP/O8ogRefB2WCjBNsClDudkev2
	 2iWya5sb4TQXdd8YJa4BHrSno04+t8Q5qh8Ne9d0NiXab2vYLj4r1iBRUGcRwhUN1zbh1
	 f+07vBp+WoYiUCXNxiKWbYc41RP/fRZcV6P8rWYulVNrAIxOvtTEZMHKLUeDsfif7IzaN
	 ZBXPSvl5wu6yBLUcnCbiakBZ7H+um+nGxNpTqdoyfX5KPKAzjEIY9CjaiOKnsA3P6zqjT
	 XWrNP3MZUwFUjdfmi8o3fYhqnsXhgSVlcvQ4W9etPFT+IIL7JtEXLVuOkQY50YYH5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842214;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=h8Qq6f7QvgbnrG0J0OoBUg4aeaCtKAluQMwQobqJX00=;
	b=dpkI0uSBmz44aG3NIPkGYLHWCD/ihAV6cI1sEZ+6Tv3y7rOA0bOnaEqXhSx+ILCbsIjw
	 Hi3DybdyJIogbZerZyvJrPefYs24thyeJBH0H0iA/XOyTt8M51I3MVQfRUsHLWcoZ1eqk
	 A6XC6R5mI6oPf97LGLvdtg0RkMzovFFL5ba1Xr1lTNQY2dZ3YdzzVk2+rC50zigSqZ7xx
	 7dY1Zgbk4f/Vj14U43ddAysQ3Pjt6r2fw2YBfk38syWEXwpoGHYDCq4bZDjX+CUfSxgPB
	 wCX++t9hr9cQ2vP2joALG+Cm/Q3A4ESEbpWrWtHSi7RXhSyvFRZD9gmfdfxE/By38qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeiAME1L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FAE606A332
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeiAME1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D721F000C1;
	Thu,  5 Nov 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793842213;
	bh=h8Qq6f7QvgbnrG0J0OoBUg4aeaCtKAluQMwQobqJX00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UeiAME1LKV7XCXVL5AXNRaGihIAKwpZvBSWX5fkfRGLPW2OUt0ifJP75XAgDke+Mb
	 +p37TOBItdnil44qesyavi5CiOP+oRtw46U7pg6zhOPHuV8L5jDUDiCfX+egoRhLmq
	 6v8ip1JptpTGmg+Pu96vw0zjPL0cFaDpDBnySJQOeU/yKmdp+2/bgnvMIXhlJCoLHX
	 siLwwdLlJtOtzdDtFIBXB17XesiFyPJbnU113tnYz4Hjn+w+hl8a7QMQyrGIst08Ke
	 X3VulCwrIpOBDquZEtkLrFlrHg+IeG9W3YLBTPjlU8vWi6tg7Ni9BjFyLM3otyuMCO
	 nK2T2G4pmyKEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0E638003F7;
	Thu,  5 Nov 2026 01:30:13 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix bpf_gotox with noipa global
 func
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179384221218.3342012.8649357736417717871.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 01:30:12 +0000
References: <20261104214912.1543558-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261104214912.1543558-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Nov 2026 21:49:12 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> use_nonstatic_global_other_sec() is an fentry prog, so it has to return 0.
> It returns the result of the global function __nonstatic_global(), which
> always returns 0.
> 
> Before llvm commit 28b4a2032f97 ("[BPF] Mark global functions noipa") the
> compiler replaced the result of the call with 0. Now it does not look into
> a global function. The verifier does not either:
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix bpf_gotox with noipa global func
    https://git.kernel.org/bpf/bpf-next/c/327c53dfd6b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


