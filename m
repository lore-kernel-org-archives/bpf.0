Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F93624C5
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280848; cv=none; b=oxjtJNyuVa18Xpv+h4WHZd28AKwN+SDYC/s3YQrg/p2z+ccEUj+iVZYeBQwu1Ctz/xVHIrKKGjigC71Cd+xvXai8aMNmURMJv2/twQXUyJkS01HOYBgVCN+Tp4RAU/c7NbrOIGLEoYj9JjIBB9nxSbwoaKHyvYIOOeQun4RL/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280848; c=relaxed/simple;
	bh=i5bfYUf8ATPfwkWDkGgZcU65NagqeheqqmT79Qvitok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B33xfvtsUU2y+yyD8RolrdedGFRQCzao2EWSJgAYxpGPlmpYYhNc3HWtfULAWXaONDhMY7FVwn1dcovkvArdpmeARjRTQ2zZYJ8MWpqTJrvnq1SPFUIUnGpdkYBWac8IKOLGtpX0Riu7ZkulnblrRVZdEwT7qu8pj4IZcWWiqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW4LkGWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW4LkGWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26618C19424;
	Wed, 15 Apr 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776280848;
	bh=i5bfYUf8ATPfwkWDkGgZcU65NagqeheqqmT79Qvitok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TW4LkGWhfoEvuAUeOnC0VlmA0Kso4iWkw1okGq+iTm2oGsxBoFKq8/yIbWLgsquTK
	 VmYAiZQqNCxoWcnnkxoGbZAFHyRoQRnxp+iDqRv/81IJM1I5M2NL7Y6tbbV5uXsqAi
	 Xrd+RkBT7d0MP64BwFtF6QULfy+uJqJXQMkDuSidX9VNCxkQSTZ13aqUpo7Mna9NzK
	 n9zt3/xpNPHeUqss8H35yL+67QMF3RLt6KvZ56t8VIqiIR8ecS3LOdidftK/fvmMt1
	 NCCvufeRZ8O+urtNJ3wLsA2QByJYgsqIAdsjpXSbJBdgQiBNeRYn4+VIPNR+C5zZh4
	 PsFQnHCW/VIGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E52380A963;
	Wed, 15 Apr 2026 19:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix use-after-free in arena_vm_close on
 fork
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177628081756.2402333.11319934110573071839.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 19:20:17 +0000
References: <20260413194245.21449-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260413194245.21449-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Apr 2026 12:42:45 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> arena_vm_open() only bumps vml->mmap_count but never registers the
> child VMA in arena->vma_list. The vml->vma always points at the
> parent VMA, so after parent munmap the pointer dangles. If the child
> then calls bpf_arena_free_pages(), zap_pages() reads the stale
> vml->vma triggering use-after-free.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix use-after-free in arena_vm_close on fork
    https://git.kernel.org/bpf/bpf/c/4fddde2a732d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


