Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0738945A
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769896827; cv=none; b=BimDLfhr3pMFvkCpwm34wmPgF9Xi3tokOkmZ0o1ALFWB326mQncLdUwXiFSxmsFsR1fnSeOokwdpXiBYoLeZKs+nAdo857+DkA1s3JgPuOZxINHWpnZ8vTK/xiNkAuhpJFb+cpA9XtN5nThZNKXi1ogbBYgOi+iWDvM/v2whXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769896827; c=relaxed/simple;
	bh=d/ndxDHvefbNjg4f0dNw461Zkjgx4lXor87k/TTDsMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sfMb0Gwvl+0/CQkxy/MPhIWIrRAmeZUvbSy3AxNuTKTF/7Db9H0/1GhQaxTMWY/5io965iokcI2usa4QB8MYVx0dM6R3diHbPmphuPjibJySQ85CbkOxtHD9GiEjdQ9/mRovVtAOqALAeCF8TI91cpb/Gu99AubXx3kVWyp6kYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOrUXkYv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOrUXkYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9A2C116D0;
	Sat, 31 Jan 2026 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769896826;
	bh=d/ndxDHvefbNjg4f0dNw461Zkjgx4lXor87k/TTDsMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dOrUXkYv8i3cgZ9uYkXqJSambjSyYNzTeP0RwKHWpvfDZJciTGoIW64k+PeZygsU/
	 49K+IxUj8IdNYqKmuEzcoxExOoeqFubO1jbZkX0hKJNrWr0p1Ar6RIIDfKy42aCuwS
	 u7kmKJUBwtPbK/4TJsIdxciLIaMQLx0HO5sPcdACSGzZhtIBHY/8oukUoyg6m2XkC5
	 tmu6Fyre3xYI5fUX8CGTsi6x063lcaIiXAGpNjtCTfDiOI+ZRFuTG+SsPV8Nae+Ltz
	 VUkfiEzZ0pIjT2W5nyHN3SR8O/+CpDmXVc2qgsMP4p636SHiL4Nf2f0XnFoLVc9B9d
	 PtTU7VD/h7XiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CB9380DBD4;
	Sat, 31 Jan 2026 22:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix bpf_xdp_store_bytes proto for read-only
 arg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176989681861.6968.12122182187118384455.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 22:00:18 +0000
References: 
 <9fa3c9f72d806e82541071c4df88b8cba28ad6a9.1769875479.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <9fa3c9f72d806e82541071c4df88b8cba28ad6a9.1769875479.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, lorenzo@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 31 Jan 2026 17:08:37 +0100 you wrote:
> While making some maps in Cilium read-only from the BPF side, we noticed
> that the bpf_xdp_store_bytes proto is incorrect. In particular, the
> verifier was throwing the following error:
> 
>   ; ret = ctx_store_bytes(ctx, l3_off + offsetof(struct iphdr, saddr),
>                           &nat->address, 4, 0);
>   635: (79) r1 = *(u64 *)(r10 -144)     ; R1=ctx() R10=fp0 fp-144=ctx()
>   636: (b4) w2 = 26                     ; R2=26
>   637: (b4) w4 = 4                      ; R4=4
>   638: (b4) w5 = 0                      ; R5=0
>   639: (85) call bpf_xdp_store_bytes#190
>   write into map forbidden, value_size=6 off=0 size=4
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix bpf_xdp_store_bytes proto for read-only arg
    https://git.kernel.org/bpf/bpf-next/c/6557f1565d77
  - [bpf,2/2] selftests/bpf: Test access from RO map from xdp_store_bytes
    https://git.kernel.org/bpf/bpf-next/c/f0b5b3d6b56f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


