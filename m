Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0E37F315
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487274; cv=none; b=GWh2C6s0ssxtcdPfdBNB1/gt9C9d9yFit5W6Fi9mHFSKUxvSTV/BLhxJM9/BGSrZ8FPFPGHvIsKtuaSts7dpIMpDR1GKPjawIoKABsL9fgoQ8RB5k47rF6dE6ckWZJvfHXzyIwc2LYZNBnG5sBreC7RpPBrquIbWpzxwM5wRjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487274; c=relaxed/simple;
	bh=XVffUFCFOf7hrv+nFhhk3K7k+jxxSNZaJw2+ct2nvA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ne1Rqe15mgw0tPaUt4aRzFN6dcMYwxviklPm0q/AoHHU4ZlDo/vtmqhtZGLuEr2pOanGW8OrDQG0NAOoGM1sTgidGVCCJ3HjJJVANh/BkB6rLraCnJwlcyRnYtyl4O8jem8YhMZgfCs/Dhh+o7s8QG0CnGgMAk76H5znQZ60yJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RroczF3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RroczF3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE321F00A3D;
	Fri,  4 Sep 2026 02:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788487272;
	bh=qgvK3/b+CjjQyNrZOpgY8TpjAfQl3k7q+ADRzjdwcxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RroczF3S7biuLT5L77LOloNjbw0m0WkzFwT02MHLincvn+z4c/Iqo3ppHYrE3dnIM
	 4wlQ6/87X4q1WLnLfqP53MA1whfa6XQgXT1luYuMZosNurnOvqvkCNHX2vadVQxjmI
	 KOHkhAdFxG3il7ZMORgrNeNRisGsdXS5ckHshhitiEOt1XMgS5BeXO1xab4OGSr+FM
	 v1NUUJ05zevm0C2ozGXIuFWgWnTz1IASeCmcBvpSWAp9i733odaFT58D7IBUyYhBqd
	 KQm5qjn1VoGo4ykZ/6N79GNOiV2m2K1pRBl/IWdOjebBXu0q20NkqWFpd/MxwxsHc1
	 3c50blWfKLuOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A938119E3;
	Fri,  4 Sep 2026 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: don't rewrite bpf_fastcall patterns entered
 by a
 jump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848721364.4116251.5509582098405601051.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 02:00:13 +0000
References: <20260903205820.1743087-1-eddyz87@gmail.com>
In-Reply-To: <20260903205820.1743087-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 13:58:19 -0700 you wrote:
> mark_fastcall_pattern_for_call() must ensure that matched
> "spill; call; fill" instruction series is not interrupted by a jump.
> Otherwise the rewrite applied by bpf_remove_fastcall_spills_fills()
> is not sound.
> 
> Record the instructions targeted by jumps in
> insn_aux_data[*].jump_target when the CFG is built and use this flag
> to stop growing a pattern at such an instruction. Jumps to the first
> spill are fine.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: don't rewrite bpf_fastcall patterns entered by a jump
    https://git.kernel.org/bpf/bpf/c/0b1c83dc3c44
  - [bpf,2/2] selftests/bpf: bpf_fastcall patterns entered by a jump
    https://git.kernel.org/bpf/bpf/c/65b1518c995c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


