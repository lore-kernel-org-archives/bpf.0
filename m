Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1225CC40
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380018; cv=none; b=mHStzE1ovvafSOtFbQX8GoIJW4LcaN2E4ncqsNIqKPxxeAACAVpJROGTod0Ns6dxgsT9iOdHd3esnv0PZWg0TWjgFgFgRwxUtNzF+tDOepn/l0962t/rU6JoULAmLs1CGMjw0XW3MSAAmkB+Vhdm+hCWri/jbBlaCBhFraxpO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380018; c=relaxed/simple;
	bh=kZrEtQ8j4iFkLU0XeBSoJaAI4MMmH2fs14plvOf51Fw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RK06jaYLey3qAxNxS5cMmORaoeFF42OsheCeC8HNo/tc5pOrGzmQGnpjdqFVLioKcy/rFMRBC1cnAZuGKkm891NQIIUdyhc02IuLDrklbCepXU0kMmp9oowkwCB+etIrqtlGSJjZ7xWmo/w5tCT7UymPfLnbSxHDqXIZ7wzyWNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwO1SEye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwO1SEye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466F0C19424;
	Tue, 24 Mar 2026 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774380018;
	bh=kZrEtQ8j4iFkLU0XeBSoJaAI4MMmH2fs14plvOf51Fw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RwO1SEyewvG0UjG+FHedzd2lIZrTx+1naXx0IKsgpRgroQL/DBK4JVnSw9ZSa2VF1
	 B7Sy/icG1Gpy4nvglUfbwpLyhgZ8cTofvThgoPiKstqgu/qZGv5myu5gylA4U8Uoc7
	 3Hr3p8Jj16VWK51Mob5r1yzjhy+E24p8Zy9EvApVNoHgFhURMwbkrvL0aND1o9m1eY
	 JMVULdNB0o40v8FRWqcPx1/yMohVpmUhyd+U9qtARDZMMGWYucuY9qG78nimK1HKsZ
	 QFIxxPxbypJAIfEHMh9zSgmltsUcAPm+2NnyBJl9OCnM5JHZJB9g8FbH7FZCDmTggW
	 BZ5lJQNyCT3qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD93808203;
	Tue, 24 Mar 2026 19:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support 32-bit scalar spills in
 stacksafe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177438000606.1267409.11002807307004903374.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 19:20:06 +0000
References: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 22 Mar 2026 19:24:09 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v1->v2: updated comments
> v1: https://lore.kernel.org/bpf/20260322225124.14005-1-alexei.starovoitov@gmail.com/
> 
> The commit 6efbde200bf3 ("bpf: Handle scalar spill vs all MISC in stacksafe()")
> in stacksafe() only recognized full 64-bit scalar spills when
> comparing stack states for equivalence during state pruning and
> missed 32-bit scalar spill. When 32-bit scalar is spilled the
> check_stack_write_fixed_off() -> save_register_state() calls
> mark_stack_slot_misc() for slot[0-3], which preserves STACK_INVALID
> and STACK_ZERO (on a fresh stack slot[0-3] remain STACK_INVALID),
> sets slot[4-7] = STACK_SPILL, and updates spilled_ptr.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Support 32-bit scalar spills in stacksafe()
    https://git.kernel.org/bpf/bpf-next/c/596bef1d718d
  - [v2,bpf-next,2/2] selftests/bpf: Test 32-bit scalar spill pruning in stacksafe()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


