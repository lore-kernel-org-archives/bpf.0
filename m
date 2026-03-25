Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7804A35
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397418; cv=none; b=H8wjck4f+6HA66GnEzEp6tKPHTcRmziJALiNXJwa7/SWOeiL5zUlGrWTrlKmSoK99AirvxfYnAxXH35L/I2L5V2gIEvb7aFvlguGp4NcmeXP4aoVVuMRs3YGl084srOxxkl6jnuuIxkwOL2bkpGVMU15m6A4J3yjybr/cLyKnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397418; c=relaxed/simple;
	bh=d1yNEY1mzLx/fKsV0RADA26ef1jhbFvhkcIiJ04lcXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GIH2Js0BXK3qrS6AB61NTQCvG6NzWMukWUIfEiZMO9CiSbcqbXSSM7CvGf/svykCWJIHBmjH9k2p5/H1qmIDsQaHjDnodHkTq4E62hBn/UYzonWTMRxuM5zcf0zbXYOoYulI2QvOENwfMrsuFrZxwxOI0qx/T8BoNgYT4xOtx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfjHruVV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfjHruVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6909BC19424;
	Wed, 25 Mar 2026 00:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774397418;
	bh=d1yNEY1mzLx/fKsV0RADA26ef1jhbFvhkcIiJ04lcXo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EfjHruVV8aKfSmgKIpBttP1Lt5Cu5k5M0J8fdMrGQ9JHDATLvjEPPNNMiVMupWmL+
	 ZGwPCrVDSJzIOxjkRRJMHmr5lGYLWuLg1BxZpsv5ZpZyKfPEfYGm+UYrgfOPHqCEe9
	 qVGU05eyO/DBJ3BuTFqeqvMsbMnBeEqUmhPaBFmILfPl+BZOEOxJS28naD+dAbIkU5
	 2XyPNokT/wIwxIlzhK2GjyOLUhVjg1aic0hNv+7nZBTq7pmePaPTb6Ewv8Rh9pZYS0
	 auioX2jRhGPdKAp6S3HVh7CL2AfhNDH/xWrBpKSutKDSjd+LGh3ztGB3Nj1YPfWv2T
	 9ntlVGhDkrH8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCB3808203;
	Wed, 25 Mar 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix variable length stack write over
 spilled pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177439740605.1356948.11934708021646491730.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 00:10:06 +0000
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Mar 2026 14:59:36 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Scrub slots if variable-offset stack write goes over spilled pointers.
> Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
> and valid program is rejected by check_stack_read_fixed_off()
> with obscure "invalid size of register fill" message.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next,1/2] bpf: Fix variable length stack write over spilled pointers
    https://git.kernel.org/bpf/bpf-next/c/4639eb9e30ab
  - [v2,bpf-next,2/2] selftests/bpf: Test variable length stack write
    https://git.kernel.org/bpf/bpf-next/c/9f7d8fa6817e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


