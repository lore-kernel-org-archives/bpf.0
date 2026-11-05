Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917808;
	b=wnUADY8LG/MNqneOnu2Lt3WiwOWyvjFqLVgnqC/lXn2JVTWuevU8OOzq7WW6C8fpU1VJ
	 QQSI5oha+EGcjISRzWKuRmWPJz+mvuyR81UCBC8dsiSTcBXmDWKpkwyFDCucdoBYxPMAX
	 vB5QI6VA8gbqx/EjrExNqQMQF2T8FYlH9Nph14RDmIzxcw9NbDcil0q9u8cwn7NHRTCyG
	 DNU8yI75UyfhEt64RH2nW6x2LbI5vWLtTRw7bwGohDVL3gr3+PRvVVBE8AgWpH3oFPgWd
	 w3CU+D0Ubx4UTwRUuLq4OtDwyuTUMr9UqinhVsm/4Rg0qspyx/Y3+aIZKRcYw97J9aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dBtcOostV3uPBYjv/zeV6hIdaCtC1lbxPJ87+oh36S4=;
	b=OCmtWZ8dDbCgnU7MkfZ251KFlOx43AfvXWxwXwRCaZGHJP5SMBes1u7hrWrUZoDe2cPV
	 iZsexYLEaNPS9HDCW0WW0fxfykUm+3ARn0g+1jP8/6zQbmgX1NRmKiV6lwdDKUp9M/Mh5
	 ZFVlKzuCDECOJwR1qg1e6ISKNLPNn4z7UEODrEbrkydeIf2EHrdULuAmb/5qOQE9D0F2m
	 aouvny1d2B8+XMxyzczDDIbY+XMsBl2lX75TVvU/KIcgM7wcT6ZZmQjB5UdxJcO5APnfs
	 Jc2W/+LCGq/3ai6oJTlWllVS1vnQ2WP7aU2ikvcbMdErLF3cf8qzRb7aYsktGoPYwXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKppOViO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272D606A334
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKppOViO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58931F008AB;
	Thu,  5 Nov 2026 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793917807;
	bh=dBtcOostV3uPBYjv/zeV6hIdaCtC1lbxPJ87+oh36S4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eKppOViOrOHxeh3HP0tjVKsi/Vu36Q7tihxPqPgyZzNVwAEAoCbis7gik0kWBboj9
	 KZ3Jd9HvQ2hw+laxU8pWSwVJcXkCrznY5AkSY2g1sN4xHlJWQjU3l14PN91yDaPPC1
	 tXnTzTnFnmBxuH271uXLOKsJ2bf8UHClPblZspxOLfYS6vbErlDCAZUF2yh4qU3QoP
	 PLvSLKNXbQIH6fGsdgwZKO+GDEuJRO+LpgxYlVwokr6oP56YPem0WC9AZrl209Ce9g
	 NHkjtD/V734d/IfBn8ObWEDhFjQeDxB4IAUmp/wZ25y8+9gvBOPnw6vWAGXnSeJHEs
	 iwPDaEOF6IDvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81A4391B16E;
	Thu,  5 Nov 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] libbpf: Follow-ups to BPF program manual
 loading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179391780667.214836.9423309288974758993.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 22:30:06 +0000
References: <20261101195453.3859308-1-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20261101195453.3859308-1-andrey.grodzovsky@crowdstrike.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com,
 slava.imameev@crowdstrike.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 1 Nov 2026 14:54:50 -0500 you wrote:
> This is a follow-up to the libbpf BPF program manual loading series [1].
> It addresses a few review comments made in that series.
> 
>   - Patches 1-2: Split the veristat conversion work into two separate
>     patches, one for the actual conversion and another for the arena
>     selftest update.
>   - Patch 3: Small libbpf cleanups in the manual loading code, and
>     documentation of when bpf_program__set_autoload() and
>     bpf_program__set_load_strategy() fail.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
    https://git.kernel.org/bpf/bpf-next/c/594389488d70
  - [bpf-next,2/3] selftests/bpf: Test arena autobind with BPF_PROG_LOAD_STRATEGY_MANUAL
    https://git.kernel.org/bpf/bpf-next/c/cc22c1bc89b9
  - [bpf-next,3/3] libbpf: Clean up BPF program manual loading
    https://git.kernel.org/bpf/bpf-next/c/87ace1169ed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


