Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5433FB9B
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205626; cv=none; b=WTD0agnyn/NPjfe5FkUV1/qQxvy3ol17QMoCRbrcdbmsu+uyULQvtB/bL+I3u8l27dVKFWxGt1zWbIfwyjoTQZ/XTgKmt4gwfn8n/TprNy9qRy9UZzOLRHT2HkzDV3yW4eVwVaQzyjlINy+6EUMCc7BKxLp7bf+SXGU8VPl4LfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205626; c=relaxed/simple;
	bh=eYGtKwl0SWbwef75qfuAY7GyyV+Xn4Olbl3tcLx7eUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3Z62K/8YZk3HmWX2Kl/XpwBCUriidFVpSOLR0K9gojTtMat8vCrurXNkcUt3zHk7Xah2hA3Te+fEP3JqwSk0X0roddLtoxwb14jxCqWU8BvD+59ZOZrudBC7seCPrsUdSJcpB8q29hUi8rDgjfi9suxojD4wiZ2B3nmMe/lO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY8LXE/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY8LXE/1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69591C433F1;
	Thu,  4 Apr 2024 04:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712205626;
	bh=eYGtKwl0SWbwef75qfuAY7GyyV+Xn4Olbl3tcLx7eUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gY8LXE/1bggW80R8VxpBGZMB5o2JzPngbGRXUysfYW8ISnW9yl3JSxsyQ5JqM6JjO
	 oJjc47VzoBOJPglo7uEhyyXuLz1XGoqIlnkRDqX+yVec5IhQS0Pf1wOV2s85M50eHS
	 qEEf7zsAYRElWb3S7aqEd88OTpLDHCl7l9rrBJybwgPDS75EwjIxaKD2LplWRrWovc
	 PWMkRrWTlS8TB+H1WqCMb9uw/fhrA3F3Duc0FJoLwnMV6YOzexQRUufHJo65ARMLty
	 AlWyJt1TJsJiFsIfVKRbSobCkGj3MjKwh7XDrn1fzszqHDZx6RTOA9T21XsGVW7MnS
	 kBSyqQpXvNBLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A36CD84BA4;
	Thu,  4 Apr 2024 04:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: handle CONFIG_SMP=n configuration in x86 BPF
 JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171220562636.30100.1820390209580459270.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 04:40:26 +0000
References: <20240404034726.2766740-1-andrii@kernel.org>
In-Reply-To: <20240404034726.2766740-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Apr 2024 20:47:26 -0700 you wrote:
> On non-SMP systems, there is no "per-CPU" data, it's just global data.
> So in such case just don't do this_cpu_off-based per-CPU address adjustment.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404040951.d4CUx5S6-lkp@intel.com/
> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: handle CONFIG_SMP=n configuration in x86 BPF JIT
    https://git.kernel.org/bpf/bpf-next/c/1e9e0b85255e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


