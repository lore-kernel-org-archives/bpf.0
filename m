Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939638D3F8;
	Thu, 20 Aug 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248256; cv=none; b=LspN/Prpm/lr4D3JpKTvcdsoaZiv061wtTHNFWMh4WjuChUp7b5sH9kwbZErv4eydhUtcoMTlM4i/Sps3Js5UB/ukCEe+EXXfFP4EytWzgA8szpID6TIT3vENB5BdhJeqjVZH4Nmszj78TaC2UWorGS/1FhJ2ETwaE/KTaUT3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248256; c=relaxed/simple;
	bh=8vpswHGtjiLF4kK1ZAALpwzSdQTfKRO3W9ZWvlefv6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RZAAXI2zdk8k0tfiU62eQDfzYeSVU+Mw4/T931Fhb3xPxqa0/HpvNxms3bkmXok4kuiW2v0Mapi1gmNKA2xKPcuF0RszPTuIneDLudFEB/KtrgSnGctZVCu3jrHds9KA/VC0vFBoJROAPCVr2cKh5/0eDi6j7DCqqPr9n2arMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1jEyztT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1jEyztT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583A91F00A3A;
	Thu, 20 Aug 2026 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787248255;
	bh=HYslVfzV7RW5oVRODKYYfs6n1yrZNOyNaXDZsRd5Mfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d1jEyztThaNoYc2dIrsNE025uG7xQBWbqJU4CjdPnpfCvz9ezJpBdmQVwaJE5jZnT
	 AkZe82mHuuKVopJO5qDvNnaZ/JyDxUSrS1xxv/zUL+hBG6ACtVyfDPxTkNtnCXY90s
	 xN7YUolOaYWwY7/QL1OzCoFUR/kLGsyr5LyihMdL5D9T44u5gFj8gNHoojJye/VW2I
	 cTwut7EKn93Cf6+xqM021Ns70qKP7FDGRmK1odNkZ1jbFXuOCd9nU+wRzCYtLM3tMi
	 ssy30plQiJ7uL4ZFOb4kGptCsSqahY8AytItGKQX7brLHzpuNUSH+JLCgUA+AP/hKv
	 IX3PDU2SJPRwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AE03822D56;
	Thu, 20 Aug 2026 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: sched_ext: Mark ops argument container
 pointer fields as trusted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178724820540.396558.13439570619675241228.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 17:50:05 +0000
References: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
In-Reply-To: <95d7ccc17681aa3a4a2eeb1b073f00f7@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 bpf@vger.kernel.org, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, emil@etsalapatis.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 19 Aug 2026 19:20:21 -1000 you wrote:
> Walking an unannotated pointer field of a trusted struct yields a bare
> PTR_TO_BTF_ID in non-sleepable programs, which kfuncs and helpers accept,
> but PTR_UNTRUSTED in sleepable programs, which they reject. This gets in the
> way of making ops.init_task() sleepable, which schedulers want for
> allocations. For example, passing args->cgroup into bpf_cgrp_storage_get()
> then fails verification and the only recourse is round-tripping through the
> cgroup ID with bpf_cgroup_from_id().
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: sched_ext: Mark ops argument container pointer fields as trusted
    https://git.kernel.org/bpf/bpf-next/c/aed1bf1a352a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


