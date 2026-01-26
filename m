Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E32EAB82
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463611; cv=none; b=I05BLwT8iSJbgetsELNeT/f85cOz8mWmpHgvwb0QHe1TsWNGWUwNc6U7jeZ0G8XCrUlrwcihSoMIE50yqBG8+QvACpiHZoLVuRK0EtrwO2F/b5pgtyt94S1seq2w2vVdxwxIpX8gnCw3YKereIcvruBGghglkOgTWK6t6JCwUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463611; c=relaxed/simple;
	bh=NarfnaDmdHKzw9Hb4hERGd7t1PHKRNMgm73Sb3pm8gs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MDuZn+pzD2toGUbDQQA0Jl8By9/IBCvWCG4D7ThfSJB90bu+yqOx9gd4+tePvS/k7nR3ZV8rpUbbwGMeJnJoUmSpHR/Ba0mQzzpixKtfmBO99yVpWZhmW45AvoAugYEtCgEpZbcJbHWrEBI9SgNBKpuE46sCSnJA6kk57CGPALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8D8JDLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8D8JDLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362B9C116C6;
	Mon, 26 Jan 2026 21:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769463611;
	bh=NarfnaDmdHKzw9Hb4hERGd7t1PHKRNMgm73Sb3pm8gs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b8D8JDLkqwLMIn8foAs0EHRYDH6T/9gn6DWmovVwMszzDQ8WPH05ZAmbTwF6ANPIy
	 Lu//DmFO4lll9iepa/vuIPrQ/IF9jFuzYCZJz3U3EQ6AZsLtKatH4TqxkiBwf3cOtK
	 H6vh1k8bOfx/OeF0jldtRz/2yu34Oyo5Mo/IshoQOWJiHBFDAYmbqnetdfqGkO4KKM
	 8DBlpKi86C1EshP0AbK1NutxVWNeyB1c+/10zXQ0NFKBAALdGL+vfwUaRRs2D08ZTV
	 Xn6/IdPwlOK92tyRCBrFDv/xUdO8XYcrf75jbS/HcBvVuvnJV0hlv9WEgxNn9Jb+rg
	 jukEeESxDv93g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8AC4380A958;
	Mon, 26 Jan 2026 21:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD isn't
 given
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176946360561.187826.15424323975447947241.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 21:40:05 +0000
References: <20260126173431.19825-1-ggonnet.linux@gmail.com>
In-Reply-To: <20260126173431.19825-1-ggonnet.linux@gmail.com>
To: Guillaume GONNET <ggonnet.linux@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org,
 john.fastabend@gmail.com, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 26 Jan 2026 18:34:31 +0100 you wrote:
> This commit fixes a security issue where BPF_PROG_DETACH on TCX or netkit
> devices could be executed by any user when no program FD was provided,
> bypassing permission checks. The fix adds a capability check for
> CAP_NET_ADMIN or CAP_SYS_ADMIN in this case.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Signed-off-by: Guillaume GONNET <ggonnet.linux@gmail.com>
> 
> [...]

Here is the summary with links:
  - bpf: fix TCX/netkit detach permissions when prog FD isn't given
    https://git.kernel.org/bpf/bpf-next/c/95ffdbda5eec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


