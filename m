Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304653;
	b=OMaG8FNF1+ojnXh+Mhq7dlVufm13Xy2tCgAafM0FZbMxXfo6uhc9daRbEelmQAeaME6H
	 AshE4P7nxFFYFw2suCNWnenyl5wikFe+mLYnaqY8DlphPAlrd3PY7wyLNj13HP+fr80KF
	 ydptYPi+Osn0ONjMLL2R6dSL7O/O9msTzBkzC2z3sSSAfOxYGHzWhqxj2z5bwvAhLKljE
	 Nxy95EYUAVXuQhM0k2meca051Dqk7eiFTTRyn3hXJC+7lo65EQfyIs2pFJXXti0gnfzOo
	 dPx5DWjUvVMfDnoAibeuRY76YsYMHL7r6yRpuQBOV+YNqTMsyc9oPc2wojKR86/kSBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304653;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mfkICO0MXiDwellQolxxBpxbA4SB7fd5gqVvP39+Ymw=;
	b=GNHxZBpvrMObNhAk3WGLvkmvB4thYJOJRQobvMwA21FelAb3jXglfFZXNAddkTN+84mB
	 jGZTVBEksyHJCN4tooljVGQL8F/QyYjwzlL4wANCJ5QMmO0RGV+CYrQZlETkis4ibRMYx
	 MO2ZufdVl/60ax8vwa9MrTWWrFVdVWFMu17l8V9GoMakPieh19CwVclYTCJdXuullahi/
	 svSp2xubX+5u+O2cYTnNtFeSkEEIht0LAuba/rmHLm7DI0wtaSNQIXbCxF7kDZbh3W7Mz
	 bJi88jchSFbIrHS3SaVzHI1U36nOTambiimklFgqd600zzyzSOetWLs1u1g7xAdEaOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJBZMB8v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C723606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJBZMB8v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E861F000CA;
	Sat, 21 Nov 2026 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304653;
	bh=mfkICO0MXiDwellQolxxBpxbA4SB7fd5gqVvP39+Ymw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iJBZMB8vrbHn4f4i6PQqvRWg6TmfVWAafvxScfRG8o5rQfln79YE7groqJXez4+aI
	 fCLKxd8NPU18BLTQ6WsXO1ipmQbb9GdBSmizANee2kyZf4o5wDppqS+PnjF6emRjrB
	 xrqDwBpWTKERu1RYyF0qeppoTMhBmHd4soFtRPD9fWll7F2U3RZ6nmAlsfLSmO6Mm2
	 vQJ5Cnsr8jfuoG99fgSoCUriKg2ZEi4wV3VbK7IoNpNVZwWcVjb1dn+3CzuO8w24hF
	 a03F0r9SL1nlnHxvE7Sro6NUeI3LnpR9p9FFcXDPuoNAYd9PBLRR6TMuyDBI//y/Sz
	 hV2LJFsiOUf/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F153C391B08F;
	Sat, 21 Nov 2026 23:44:12 +0000 (UTC)
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
Subject: Re: [GIT PULL] BPF fixes for 7.4-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179530465153.1212208.2125559697856602215.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 23:44:11 +0000
References: <20261120200948.532961-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261120200948.532961-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 20 Nov 2026 20:09:48 +0000 you wrote:
> Hi Linus,
> 
> The following changes since commit 05441d697f7f9a927264f4058cbbc6a03dfcac9d:
> 
>   Merge tag 'cocci-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2026-11-03 08:36:32 -0800)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] BPF fixes for 7.4-rc4
    https://git.kernel.org/bpf/bpf/c/84afebd85343

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


