Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477037C107;
	Tue, 24 Mar 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367427; cv=none; b=eydVxNznpwjGLxOL/Inu/mxD7CwS074BNmgK3haUw6RGG9cEWLa3i7Ns09kH35Zeld3ysfKok6AkbBuWcDjYfoi5IntcB0DImrM2BxlkbBuny5cCT/ZuxlNQEf+mX+GqVPElRpH18buOu6QgBjBqTFVau9vv0w0V7Rr128xrVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367427; c=relaxed/simple;
	bh=lUzpgOaZSUB8/OjHlDFH7uXL5wuh44/GpRoR8BJ2VOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VczeXVwITfEPMYQ5FCQP2rOXC+zRyesAYXLOvLGBzx0NJPSPj/T7GA5lJW/AZ/tt43U0XyIVCEQvyPU1nEuuxCgt2wx9fsg04PuQnqPtEbHVf5wB0qUp4xv3oi6nj70DbH2a+BBb/CYXoA45NFLxkHCTDMpZlHNOSWLhd30SdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta++6kia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta++6kia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25610C2BCB3;
	Tue, 24 Mar 2026 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367427;
	bh=lUzpgOaZSUB8/OjHlDFH7uXL5wuh44/GpRoR8BJ2VOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ta++6kiaTtoL6bH9lfVxskE3axSC9qMCYiu/jZT4bPK0YscvuivxPN4ygUwvappRf
	 x+rA0LXgybwV/HPfuTYWqpYXVIwUKfo1xshEfq16+tWsx0xdKP08tAMnpKPrywnjrk
	 DfuSc4IKIDHp3V70kN3D1Di8VMqFSNRMWN/Bc/YBwPfLI0RJHEQ1ytHEFK7Nq/4b4Z
	 IiHQ0wpc1OOHgFbRLROtRLLnyGGS3S6/+ISFp64pMeC1ce68xyBHX+wpTwq36bp+ad
	 UauhP1EbHjxCo0Hmtf7FLdnlENMn9ithYFUCdFqZRuV6xq6mSDZU0Z0a70rP1PVSWj
	 oOGsxTSDq6RKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCB53808203;
	Tue, 24 Mar 2026 15:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436741504.1084685.17277728254539064211.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 15:50:15 +0000
References: <20260323225250.1623542-1-martin.lau@linux.dev>
In-Reply-To: <20260323225250.1623542-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, kuba@kernel.org,
 fmancera@suse.de

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Mar 2026 15:52:50 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
> BPF_PROG_TYPE_LWT_XMIT test runs.
> 
> It currently checks ipv6_bpf_stub before using ip6_null_entry.
> ipv6_bpf_stub will be removed by the CONFIG_IPV6=m support removal
> series posted at [1], so switch this check to ipv6_mod_enabled()
> instead.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
    https://git.kernel.org/bpf/bpf-next/c/280de43e88c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


