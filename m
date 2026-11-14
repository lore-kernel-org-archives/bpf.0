Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681009;
	b=dQ/aXWMoiQ8OOUwvEAp6SYs3J2YHMYpFBvGM4N5o5fYd5oSCTRvU6/7uDTsysHUy5GA7
	 KiraUGx0u5bYfKPwAnc2C1lpyLaBciXP6xTNuMzzxhzvHsM8/BgCFO0teiGf09AIqYLCx
	 H5/8xyrda57KMEG53ZJ5+ml+QNgF4w5kUuHlLIdOITbdEVDgthJ+jUdkmG08TyxJYg3CH
	 GsUxqoW2N9hJ1blYE7RhA9K5Dr9dg3BHS3J/Skzt0FuzskewRuT+q2T7rLuYCEasmheWY
	 Hd+0NMbHd5pEMNVsqChxkFGwN7iN6ddpvqr420IAkf7auD0OtRqcyF1DcCUaXfs3hKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nD7jaSQc6u2zYS8nJk6qbTtKehMkmzLMEAExI8eLFk4=;
	b=Y4S1nx9WFLWNhoylh+t/fHyTMJgbBGoMHyplqzPV88llyhcc69VZBFwjb0zc+hAUfrex
	 wul/VFIDEn2vGLxcAbNldx4UWDXKkZwmJljaEWlnKIuGsRR0nWQRUsIsIP8nCeyYhoDYF
	 tRapFmIc55wfVnJgmKdS0mwtxvZE/JYASl1A2P8jCH22gHhaPAqSI9Pv1gp/wQybXz4vW
	 jVkl3xbewrNHmNZE+h5+fmVp0KWDQUPbAAkspU7I3S5ZjJiymnCV42ESi5cUvQ0zRY0cH
	 aTTSEm5Or/++DVZNYFr7IPeZo69o/408flgtZkw31nNS1MEzleaBnhLwZaFgOe1hjtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbYjOLSY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7571B606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbYjOLSY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090711F000C4;
	Sat, 14 Nov 2026 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681009;
	bh=nD7jaSQc6u2zYS8nJk6qbTtKehMkmzLMEAExI8eLFk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bbYjOLSYa/l2sm/xIRp8mCpeuvUPacTyRZcK1LHBzXCfL7SgYoXOwJncsrOmwUbh0
	 pipjQ4b+H4gUktmpLFzeEdFc/gS1pObX8/77a0MzIGAIB5V2vWPpiP+oI4U4MltVcF
	 lAdBCtsA6BVWlfap5+G+S5DaMZbu95vIIAxyAwpdCAUkmrBNIYsumB7RVqaGXQ0eU3
	 8wrxdipbTrSan4zOdzog+qWf8/5ff0QZV1CkOu4ndmhPE82EEey3h71yix2WbmFIXj
	 xBEzJ3PohsCcsnj397IsO14jXkLqLL29DLHlXlzyk9eOjn+YCKzRhsh4qlVqLbvfg3
	 MzmFTPR9eY47g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15CD380821F;
	Sat, 14 Nov 2026 18:30:08 +0000 (UTC)
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
Subject: Re: [PATCH v3 bpf-next 00/11] bpf: fmod_ret for each function that
 returns errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179468100783.2330384.13747727141754933715.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 18:30:07 +0000
References: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261114051805.683966-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, a.s.protopopov@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 14 Nov 2026 05:17:54 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> In short: with CONFIG_BPF_FMODRET_SCAN=y the build tags the functions that
> return errors, 12096 of them. A program with CAP_BPF and CAP_PERFMON can
> attach to one, skip a call and return one of its errors. No file of net, fs
> or mm changes. Test: one skipped call per function, 4401 functions of net,
> fs, mm. With this set 1 function in 180 then damages the kernel. A deny
> list by name can take those out.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,01/11] selftests/bpf: Don't depend on the width of a BTF id in verifier_live_stack
    https://git.kernel.org/bpf/bpf-next/c/b44ccfb0c4fb
  - [v3,bpf-next,02/11] resolve_btfids: Read the code of an ELF file by address
    https://git.kernel.org/bpf/bpf-next/c/c7c875e1d0b6
  - [v3,bpf-next,03/11] resolve_btfids: Describe machine instructions with LLVM's MC layer
    https://git.kernel.org/bpf/bpf-next/c/59f3c4a33bb7
  - [v3,bpf-next,04/11] resolve_btfids: Find the definitions that reach the return value
    https://git.kernel.org/bpf/bpf-next/c/a9feed88f7bb
  - [v3,bpf-next,05/11] resolve_btfids: Tag the functions that return errors
    https://git.kernel.org/bpf/bpf-next/c/4dd950adacad
  - [v3,bpf-next,06/11] resolve_btfids: Fold the constants of a select without a branch
    https://git.kernel.org/bpf/bpf-next/c/6a2f944d0cde
  - [v3,bpf-next,07/11] resolve_btfids: Say which registers an instruction reads
    https://git.kernel.org/bpf/bpf-next/c/0ea8d17b993f
  - [v3,bpf-next,08/11] resolve_btfids: Don't list an error that follows work on an argument
    https://git.kernel.org/bpf/bpf-next/c/bfaa56d69ff6
  - [v3,bpf-next,09/11] bpf: Allow fmod_ret on tagged functions and check the return value
    https://git.kernel.org/bpf/bpf-next/c/bc45414d1690
  - [v3,bpf-next,10/11] bpf: Require the JIT for fmod_ret programs on tagged 64-bit targets
    https://git.kernel.org/bpf/bpf-next/c/3c5d146f9c69
  - [v3,bpf-next,11/11] selftests/bpf: Test fmod_ret on tagged functions
    https://git.kernel.org/bpf/bpf-next/c/e93e5df855f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


