Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37693A1DB
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023446; cv=none; b=f4tnFnAABm4eQmKhYZUoWlDcczN+HPiA2ozXMV97LHb3Z6Gcr4t7TuZwj2L6kCuwf6K4dHyTviGOYevIeLxzmYcJlZ4csmkHQuCk49kxYomaSgu8A6FVkpUqg7c+sU/QG0iA2iwO97gwZgklT80XwQxQ+EZp7kiWm8E52nfplfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023446; c=relaxed/simple;
	bh=K1Hfx1E7YWb3naPjHQ2dgiu30i+TFrU8i55NnOPPdtI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=npTmc4l3SFGv3VWlDo8xZSbFWGCMitMPGy7XuOWt3Z9NI5vLPjMM9kdKr3TVEGgd3MOnlb0Qh6rpefNfmSlD9qAO4A5BBKYP4nZBhULzrnQmJh40lyAzZzYO2CKiLRnkV5nwM3yKZymJsZ3qdWl9QammO0osoG4e6ppSkYYk4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpgFf8Ys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpgFf8Ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7550CC19424;
	Sun, 12 Apr 2026 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776023446;
	bh=K1Hfx1E7YWb3naPjHQ2dgiu30i+TFrU8i55NnOPPdtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MpgFf8Ys5iCJrxHtoW1V7tKRT9Qy9V+4GkpAWW0ckWNbsdDU2B1J5ZcHK84FiSdux
	 NRnEHZIofSWFbcFupqLtRh0bl30Tz5eK2J4FvA5Uip6JA+VsmGdcVo6GiK6AUZ8m9q
	 epeZcKtafiWbV51PkkWp7y5RRny0SHrGCdG/xp6dQXWYpSbVym1Ygu+CNYjpq9Z4Dm
	 acol+XxXwaZLZKvJA8aealk8Z3y9GlE/YheEcXWF6t9u+OQDhVnqJd7ZWacq45hsXJ
	 6rtPMxbAZGhB2nwCR3d+X08k0qelYH2b2M9PpVNd3etvi6N009GP8CRsgNYnsJaC8b
	 g1+ywH7sr3v1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DE13809A8C;
	Sun, 12 Apr 2026 19:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/6] bpf: Split verifier.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602341880.3390867.3076801947752305915.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 19:50:18 +0000
References: <20260412152936.54262-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260412152936.54262-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 12 Apr 2026 08:29:29 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v3->v4: Restore few minor comments and undo few function moves
> v2->v3: Actually restore comments lost in patch 3
> (instead of adding them to patch 4)
> v1->v2: Restore comments lost in patch 3
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/6] bpf: Split fixup/post-processing logic from verifier.c into fixups.c
    https://git.kernel.org/bpf/bpf-next/c/449f08fa59dd
  - [v4,bpf-next,2/6] bpf: Move compute_insn_live_regs() into liveness.c
    https://git.kernel.org/bpf/bpf-next/c/fc150cddeea7
  - [v4,bpf-next,3/6] bpf: Move check_cfg() into cfg.c
    https://git.kernel.org/bpf/bpf-next/c/f8a8faceab99
  - [v4,bpf-next,4/6] bpf: Move state equivalence logic to states.c
    https://git.kernel.org/bpf/bpf-next/c/c82834a5a11f
  - [v4,bpf-next,5/6] bpf: Move backtracking logic to backtrack.c
    https://git.kernel.org/bpf/bpf-next/c/ed0b9710bd2e
  - [v4,bpf-next,6/6] bpf: Move BTF checking logic into check_btf.c
    https://git.kernel.org/bpf/bpf-next/c/99a832a2b5b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


