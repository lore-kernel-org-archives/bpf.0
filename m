Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E7301471
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453040; cv=none; b=KW1OB+ns34VfmDs3aECjiXuaC36vpm4PrB8olFXF+OwM0oZwArKf4/xoCcFei55MHQploaVv2GOY4l8MUKlrPSFhnCaoJ5oc7GyOr2xyoJOnYRmlkpKpWcqMjnmgWA+3ckSxWnUqmhtff8tzBudBWCcZS3HgcDNm6yaxWM74xCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453040; c=relaxed/simple;
	bh=hT3nHMS9BmQbAC/+1/zXcKuzWvbdejzAcm6FMHtJqbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nOypwCFiGhkA87/OtgEEuSrbOhBMwLr3ywfdB4XJ5KZ5JZnsQiOVvmn94GWuGrPId6RhoeNhrgzlDA72F0hqhaIsmDjoXla+NYNhLx9MJmBdjSXonYQC5hrZhGLHEegCTWdoWo9BTwcGuCahQZ9UmjT4Io+iUInhiPwVi7EQej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT1N/JIh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT1N/JIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A307CC19425;
	Fri, 17 Apr 2026 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453039;
	bh=hT3nHMS9BmQbAC/+1/zXcKuzWvbdejzAcm6FMHtJqbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QT1N/JIhJyj30yvXb/Vp9UxtVdSx2qgotoztM//ipKRVPEvVWXM9mj8LgdZd9rtfT
	 2P02s4XChDBKywtqSV9Zclr4Tru4W++5Sf3+tTlum4qTMOIwMgX++tKdM+rPdx8+VE
	 G/2KF8zuqGbKeGqrdIfP/hhlYN95lKMTVKoWwarGq73rmyyypSAP6Fs8U9Zm/XxmLM
	 lRb4SmA59vFNShO8gpVpGXUJ4tMyrlooPOj7mTdyZhdSYU+l0i65hKRbGbfpHT/4Rk
	 fiInr9dmyQ7n+RnbZuXYvBs1qxj7kKdHnDX9c2m657+dnFJfwGuR6Is7m/3guidIMl
	 eSDbUocdLnhsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD6F380CEE7;
	Fri, 17 Apr 2026 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] arm32,
 bpf: Reject BPF-to-BPF calls and callbacks in the JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177645300705.123271.2913681268096807075.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 19:10:07 +0000
References: <20260417143353.838911-1-puranjay@kernel.org>
In-Reply-To: <20260417143353.838911-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jre@pengutronix.de, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 linux@armlinux.org.uk, kernel@pengutronix.de

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Apr 2026 07:33:52 -0700 you wrote:
> The ARM32 BPF JIT does not support BPF-to-BPF function calls
> (BPF_PSEUDO_CALL) or callbacks (BPF_PSEUDO_FUNC), but it does
> not reject them either.
> 
> When a program with subprograms is loaded (e.g. libxdp's XDP
> dispatcher uses __noinline__ subprograms, or any program using
> callbacks like bpf_loop or bpf_for_each_map_elem), the verifier
> invokes bpf_jit_subprogs() which calls bpf_int_jit_compile()
> for each subprogram.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] arm32, bpf: Reject BPF-to-BPF calls and callbacks in the JIT
    https://git.kernel.org/bpf/bpf/c/e1d486445af3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


