Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C273238C3B
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771100415; cv=none; b=MLcgDS0rK+rT/TQQSwhF/WdFlkM3lrnFW2MmpITw8qtxfKSD1SjbxVzYZ5Kk2Y/nIOpi481ZyrewVdFlIcEjI6rxX07JkkRIG7R7B1kFlku7Z8NKfB18DzHWiipvgaworTmSZ0C/7nTFiYv7aoIiTDMt0crguSsuHQzrGUys5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771100415; c=relaxed/simple;
	bh=di9avxp4Xf73AaPz063PE+8L+oxPCKL8+JhydPSr8GE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cfHejXLtDrwYLl+lsE0QHX1FEza8cIfAMj4ekBC/xWp0LbaPIgsZSFA4BI3olVI/sSVg/lo+cy7/NxGLHmP9roWmhHTEsDHNvacx7xo9DBI8Qy91+SnhrO/V3+EiO00NMIQJltut1IWeror+qug5MYSiTuCdfoFRBwzZ+R90Ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4MMr7pK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4MMr7pK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FE1C16AAE;
	Sat, 14 Feb 2026 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771100415;
	bh=di9avxp4Xf73AaPz063PE+8L+oxPCKL8+JhydPSr8GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U4MMr7pKY2sBPVKNXYEbsytd1pOcXBJ47VmnlW+VizOKn9qDdyJkCvWjb96XM/8U9
	 4PHFa8sYs3DMOxz7r4MC2peXCgVAelBO2Fz/u+Om2retHa/hZs/bYBsCztcWrLGDjF
	 hdSDSa6WvvtyFoVmQQFPbfWOX34YATzndf68iadkDZaykXnso7lmWIw1dZzJtLUAn2
	 XJu/9kW7WB+9V7vd/aWV+ozkzIrCsASt+2Yke2jya1noo9aDXv6YtrouYFhRz+HkOK
	 twHG0oBKL4rwRNeFfWJQEjVHIgkvC+MzpZ0eKTKVLVuLviLkrVKmslbgYsXODU1SDd
	 oQnslp7vR6nOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852443806668;
	Sat, 14 Feb 2026 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] libbpf: Fix perm errors for
 LDIMM_64_FULL_RANGE_OFF
 use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177110040832.2887638.10770311086642120216.git-patchwork-notify@kernel.org>
Date: Sat, 14 Feb 2026 20:20:08 +0000
References: <20260214021014.15670-1-emil@etsalapatis.com>
In-Reply-To: <20260214021014.15670-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 13 Feb 2026 21:10:11 -0500 you wrote:
> Commit 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
> adds a feature flag for testing whether the running kernel supports LDIMM64
> instructions with large direct offsets. Fix two edge cases that can
> cause unexpected -EPERM errors in two ways:
> 
> 1) The probe program used for the feature has type TRACEPOINT, but it's
> possible the caller does not have permission to load it, even if it is
> able to do so for generic BPF programs. Use the SOCKET_FILTER type
> instead that requires fewer permissions. This does not affect the check
> itself, which will always fail verification anyway.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
    https://git.kernel.org/bpf/bpf/c/623e7b898a0b
  - [bpf,v2,2/2] libbpf: Delay feature gate check until object prepare time
    https://git.kernel.org/bpf/bpf/c/9e07e5f57d93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


