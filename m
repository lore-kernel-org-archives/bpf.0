Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CD12FF60
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381421; cv=none; b=YP1/UMi0TWiXSJiRHX/Yr7F2p6u0WIfv8hrTcQCJhM3jhrH5KFxIFkqJksYWz2iPwJ+bzBTi9G6ir9TdqbJ3JIpd1KFu1/FWuL66l15iG1+92stj3UpzDkktARujRKs+yoiZv5qL+SChpVMCK4njoJnMJTtz0NZILpwZmIPP/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381421; c=relaxed/simple;
	bh=+iL6dafZ1RHcWLwMAhUPgfm295Njk/XFyXhGZNNjsf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PTqViweSlZuApBR4A+nhsJV8fgv4VW8tRb252RsXS/kczFPCMXuw3b5wqPALKvLgZwJn96LruOZ2rN2qSSErhOPQwaNfxD36eKwQGkIIxfdYu9iuFFv8Z1Yb/RZLpGjvnzXiE03T04p4J9c9mo2NpXgkkrRLdI3lIfXWP6xCCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB0dMK04; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB0dMK04"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1F91C43394;
	Mon, 25 Mar 2024 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711381420;
	bh=+iL6dafZ1RHcWLwMAhUPgfm295Njk/XFyXhGZNNjsf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LB0dMK04zVT7d1M3TyRM4/2QviS4G+CkBiuK719uAezjyaSW3+7uGiNPmCdOWbT/+
	 GTENim3qF7qVUJXuttjF+5X6cpd1VYc7LbXdR2PgxWAjB4+3Iokh1CCInQ90P2eZus
	 PQhg3pICj356KZwlznIntOw5E6hnv1rkSMBq8UDEMQ3Vure95bOqTzPk8srN/lwOOq
	 xlTdBaaTHHDyj88cEv13FiG2uycR5ppLcT+dbcvE42S83AwXwxHEP/Hty4invlaIXP
	 a15IvnQZcAXJ3B+84irdmYRdUX9DdlgyrN1U/C7cyM6uRMwf6P/1Z1BICOZWED+xiP
	 iYsHGVYZ3VAwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEF67D2D0EE;
	Mon, 25 Mar 2024 15:43:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Sync uapi bpf.h to tools directory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171138142071.29845.10217990847012696074.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 15:43:40 +0000
References: <20240325033842.1693553-1-yonghong.song@linux.dev>
In-Reply-To: <20240325033842.1693553-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 24 Mar 2024 20:38:42 -0700 you wrote:
> There is a difference between kernel uapi bpf.h and tools
> uapi bpf.h. There is no functionality difference, but let
> us sync properly to make it easy for later bpf.h update.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/include/uapi/linux/bpf.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Sync uapi bpf.h to tools directory
    https://git.kernel.org/bpf/bpf-next/c/476a5e929119

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


