Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659811;
	b=5dLWaIQDpHf6n1fs7rIi8qmoe8CgwC+t1DFJfLiPD9f+DCil7SdWcjTGZ+Rje0rT4E+2
	 e+3dkYTPaSHiyfDSSNgHtksbkzMpp2eayCPZcfr32HL5+ikZcYXJR+Dnb4xiZg7zVxzQI
	 ElCaQUsgbCfhEqYQ67PF0lWbLqk7q3pA3DXf+QW7m7I4Hp8CspOn6dVfD461BpQWwuGU8
	 Gd401kb8Tvf64BPNL+oWbhnyt7h29ta9Pyur9cnqkf9LkaeBFfxm00oF9XcdPgS8459D4
	 7a4jh2UfOPHu0kifssHi9tS/fOwYSeunTGrtaUOxO2bQd1ftbr17vvkoT/fBMfEQFnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bkrC1vX3Q/F8xQZHFrrdCGxeK4ABajnh5ftoN3v5Ca0=;
	b=dc2EZx3MsP9aWvRh+Iy4uIBfq9qxepQaZhqkcVJFJoBkp1FhKDzDqCbOlCSlPWHpYSZe
	 Xkm5kKsxh05Zr05QlIW8iRcJ+U/k6ctsKewChcKK/a89OYKz7M8pDZEnT8htQ4VsEuR4p
	 NuoSD5IB9/BWELs6rOVwUeMYowXlkGHmPXYtjaahEIGdS+7BO9ethwnHr3a9rQG/Uh2NR
	 +3eXABseaSP1PZWHbB6VHUvMgS5tyuRElPKHuHW0kKIKdnKspSm4+MuDv0KnOUPqTOLZ0
	 dv3Bck7xAiLF37YkvsCyBwSvN664X5mOYZebnnIleSOZZpnlyIEMYv5QHi2WMnyth6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aS+a+Z/W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC1606A330
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aS+a+Z/W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A6F1F00A16;
	Mon,  2 Nov 2026 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659810;
	bh=bkrC1vX3Q/F8xQZHFrrdCGxeK4ABajnh5ftoN3v5Ca0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aS+a+Z/Wq+rIerA/NoCTF1nT2JLj+0bSpoabCa/6pN+odP0aL/7FuL/QwHIRPMqPq
	 vb3SSwUdmrhqEh1WWx/AdXYw0Auni20JUo8gbSdpKGh4jPAma6uYx3EfBqRNvqfJfH
	 KDy8KwNZgjHAooCUmZIP+60YTkjdoK/IEgObdi6d/ohN9SXHI3UncH25zUQZvNOOtf
	 yAdFddODuBOlLYnrx+Qv501puZSZccbt2z7c81awKiFAziQQS2wivTBygBAZKB9i8z
	 /9EPiWi84qHzInPd9siGxoBN+LPEVakS4gru6R4S71SdWCDk1UB49EJMfycjsQqVmu
	 8xWYaFHPPMd7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA137380821F;
	Mon,  2 Nov 2026 22:50:10 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix callback recursion test with
 noipa global func
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179365980929.707305.3741619428978168468.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:50:09 +0000
References: <20261102192727.762933-1-yonghong.song@linux.dev>
In-Reply-To: <20261102192727.762933-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 11:27:27 -0800 you wrote:
> With llvm24 after commit 28b4a2032f97 ("[BPF] Mark global functions
> noipa"), the test recursion_via_global_func_and_callback fails:
> 
>   13: (85) call bpf_loop#181 4: frame1: R1=scalar() R10=fp0 cb
>   ; return static_calls_global(i); @ verifier_global_subprogs.c:548
>   4: (85) call pc+1
>   ...
>   ; return global_calls_loop(x); @ verifier_global_subprogs.c:543
>   6: (85) call pc+1
>   Func#3 ('global_calls_loop') is global and assumed valid.
>   7: frame2: R0=scalar()
>   7: (95) exit
>   ...
>   ; return static_calls_global(i); @ verifier_global_subprogs.c:548
>   5: (95) exit
>   At callback return the register R0 has unknown scalar value should have been in [0, 1]
>   =============
>   EXPECTED   SUBSTR: 'recursive call from global_calls_loop() to loop_cb_calls_static()'
>    #669/9   verifier_global_subprogs/recursion_via_global_func_and_callback:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix callback recursion test with noipa global func
    https://git.kernel.org/bpf/bpf/c/fdda033f7fb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


