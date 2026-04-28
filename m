Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216A238D54
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387849; cv=none; b=moGS89dZcOo9j6GAtDEpV7F4EOrNUxFXEzrhmI05uDb/+ax3ZvLkLGBxdc5D8Bt4CG2l6oh2JZ4aMGnLBJ+hOj3zf86YRj8HNJTQvy0XQGuLj75bH7jlVX3BqxbK8wzTtrZnBNfRiqAh/D4LPUtuEcTTJ8vQdBd5CaWSfSXEE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387849; c=relaxed/simple;
	bh=Enu/i1/5HZRAGXKTCk3c0w6EF9HHWlF2Ha4MXO57Q74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b+dGd4S8IUm62klIh5P91N68s4Edzngi0YlpMAv6KWo2Cwb9fUQ9G1ifl56cu1GtAawZ5wAYBCGHOiDpkjLKsWi/Iuicz5u9OiotdVUnaxC05LyR1viUvLfCTlrwgVwK0lV/iENmog6q42upSdiIVI/HpYF/6xygdJfvP73hY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sroh6oJl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sroh6oJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151C7C2BCAF;
	Tue, 28 Apr 2026 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777387849;
	bh=Enu/i1/5HZRAGXKTCk3c0w6EF9HHWlF2Ha4MXO57Q74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sroh6oJlpQOihXdN3yJCNDs+FU76i4aibWiA2VabgFDKu9u2OyRp1GYJq5CreGTIR
	 NGjDlwVJp8RYBKFcD+/a8bJNMan1R1Ocn4q0NTR1IlsDR7Vqzq8MO4PwihsgjwfeOL
	 56qIfadlVBTIglESu+7YL01bUA5l2XVBHeUkVcEDF0LZ8SCgIgsrAFUWbKaVD+2Rl3
	 oRbf5l4WDIF6daRqThqanLgGnAy+8rIEJ3VKbn1uBSfqCzQc6c4B2UN0XXmuFXn67L
	 k/vHs1tnDN229z6ReT6ENBSWbb/QNwsaoaHeZznROF3EMu8i/SmyinnSAijUxV6r7r
	 Upi4UTN9LWt/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D733930211;
	Tue, 28 Apr 2026 14:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Rename libarena malloc/free
 methods
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177738780581.948500.17019817097244411433.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 14:50:05 +0000
References: <20260428134252.2783519-1-etsal@meta.com>
In-Reply-To: <20260428134252.2783519-1-etsal@meta.com>
To: Emil Tsalapatis <etsal@meta.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 28 Apr 2026 06:42:52 -0700 you wrote:
> From: Emil Tsalapatis <emil@etsalapatis.com>
> 
> The s390 architecture uses the token "free" for an enum, conflicting
> with the malloc/free definitions. Rename the calls to arena_malloc and
> arena_free instead to prevent collisions.
> 
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Emil Tsalapatis <etsal@meta.com>
> Fixes: 7c8d208d816d0504aa916138ae097d9cb4ed4e56 ("Introduce arena library and runtime)
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Rename libarena malloc/free methods
    https://git.kernel.org/bpf/bpf-next/c/9f5b3ffc3f1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


