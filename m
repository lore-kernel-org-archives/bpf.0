Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75A33FE27
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611237; cv=none; b=dDXGkiEZc5Y0cT/vsZ8uBmWKDLRgEESRFG94sh3JCucjxSkEYAhxnFeJYKmYbcDGLaWSyBA4IzOU6uaqbfffmz6LyxFabV8blhfrzQZgSDZAcDMoTz2KAMx3ZfvUY5qYkzpOUytIzquL66UFeJ6w4yvHNRslBI1YVZpjSHgS/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611237; c=relaxed/simple;
	bh=8PcxPRGue/5XmcxIUi1DIF4T33ItC07W48boScMINLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u7nYe+18Xhhx8/wFhcUyifZU6+fi/MDE+cPJ5/HVfWRH3vxZtKhjPQyMBtnN/qlYhqK0ArZ64zRbsKeZzjPhFKB2gkQhLQwi5ZUSEOU2Hc83YrOgkZuvLHWZuGFPsOxq7jiImquHoDGeCwYTuXGl9vcdswbIN2JyxaFo08loA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7PPdEN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7PPdEN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B0CC116C6;
	Wed,  8 Apr 2026 01:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775611237;
	bh=8PcxPRGue/5XmcxIUi1DIF4T33ItC07W48boScMINLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X7PPdEN86FwU2vJM5vbY21vgxnZPcKTotTb3KPV6kxREIIiGQEv7qq8ODT5fWtKgN
	 voNOfOymeLm54Z3e61Ni56jx+28xzDvVUM1E1SOPbFvZrC4doZCjcfMo9O5dlC4p3R
	 cK2Go6sscyNVsAjXk3+52OkOe61PmWdgDz8bLhitM8MdgQ/IbLV8pCtYhGBxpiLMiP
	 NmBCUJz8dl50uQOQVlB0WYEcN4udQh3jsfUaVoL6cdzdosMaA0VimdjNyuId097PkI
	 kj7DLe7BWrFUg/HA1G8wbIMLD59Beyfj7Dmt+bhCdGLbWT8j5843P7QRZYkFrMmT4r
	 FJA34GOQwO+zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FB713809A3D;
	Wed,  8 Apr 2026 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/4] bpf: Fix linked reg delta tracking when
 src_reg
 == dst_reg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561121504.25865.1223761626895962170.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 01:20:15 +0000
References: <20260407192421.508817-1-daniel@iogearbox.net>
In-Reply-To: <20260407192421.508817-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, puranjay@kernel.org, info@starlabs.sg

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  7 Apr 2026 21:24:18 +0200 you wrote:
> Consider the case of rX += rX where src_reg and dst_reg are pointers to
> the same bpf_reg_state in adjust_reg_min_max_vals(). The latter first
> modifies the dst_reg in-place, and later in the delta tracking, the
> subsequent is_reg_const(src_reg)/reg_const_value(src_reg) reads the
> post-{add,sub} value instead of the original source.
> 
> This is problematic since it sets an incorrect delta, which sync_linked_regs()
> then propagates to linked registers, thus creating a verifier-vs-runtime
> mismatch. Fix it by just skipping this corner case.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] bpf: Fix linked reg delta tracking when src_reg == dst_reg
    https://git.kernel.org/bpf/bpf-next/c/d7f14173c0d5
  - [bpf-next,2/4] bpf: Clear delta when clearing reg id for non-{add,sub} ops
    https://git.kernel.org/bpf/bpf-next/c/1b327732c846
  - [bpf-next,3/4] selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
    https://git.kernel.org/bpf/bpf-next/c/ed2eecdc0c66
  - [bpf-next,4/4] selftests/bpf: Add tests for stale delta leaking through id reassignment
    https://git.kernel.org/bpf/bpf-next/c/cac16ce1e378

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


