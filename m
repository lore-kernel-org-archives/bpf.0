Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496008;
	b=MxVzj9riRP5FRSRIyucC7QdbTtI+kk75MHdrGpkuZ1sjVmvF9vN+bdHIQZ0pIUCqhAiV
	 dPJ31XTHReJk3VRUNYFVnyYjo3Gbk1BxE+STTmeLc6oBCi4+ZAyTtbiCSkVwVHXn2WJZC
	 G4wISgoba58DnIx4WY96Wltz1UPbHoYBUDULM1bE79ZW3WSOJjXJm50SyS1DM5Zs1SHdl
	 m7+dXUIKnXU/z8LAUEOZgNKEp2zajOw+YmmthxBKPNRNFnhEAwZdGJ1smVWnX/9ECCC5S
	 PoYXHpahvuvA+3z76EZvhEjL2aTLDLoDda2jRrWfHJMy3Db++YGqAkejdHDxflANwYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dvpzB0yzQjGhBjkYwzzjz5S+INhesgIz56ILGUC/Uy4=;
	b=yRm4T2UtHgtD4M5VQ+jbmgE8YYYwaLzAzFc8xQKI3YmRTiwfsh3SvWXHOfItPtHGJ3XN
	 Y4QA9pIGkc6jO3g2ZB1gPctvXyoWe0TlBjNkSl1F1DVuy6ZI1NO+jEfxncdV5qNO5i9Jy
	 WFtFD0VCUghETWNzamJqB7leFFjpYR0Aet3JTv9EuPhtyJskhvvxxhNym6+bIxMQCV4bl
	 gU0YE7XMfPeO4SDBslPHg+yP3P4fri0JSnWWOZ0c5pKBHMzJOoomGiw+OWd/d9qzzhiRO
	 FgjX++tsz2Y4ZyQE2neplggN6MkBHQSBx3kwVtRO/gsQdar2CaSzKEF0Jhz0YJSkf4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LESISDDS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F530606A31A;
	Sun,  1 Nov 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LESISDDS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6001F000C1;
	Sun,  1 Nov 2026 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793496007;
	bh=dvpzB0yzQjGhBjkYwzzjz5S+INhesgIz56ILGUC/Uy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LESISDDSC7vHVwr+zYQA5bfOZdfj+K0LuvUPw2XPtC4ZKO+xjGLB2m30qRh3d/qnR
	 M7YjHUqKRfy47QAI7YzBzZwDaick0/rW6L+I6r0vtXDocZqYnLn1tqA+TtNJacOv0b
	 7fuB7sJHATwYrqVYdyFXUs5zWBu6pMTlvFtH4ctaNWW70yo8f0Aibu/UwnYT22MIQr
	 kRK7JEej1/XcYfXtCAbJoxeZpMCwikECA7VI9nq80OBxpIGceqXWroU6riq6qtahwy
	 FPfXfAMVhHjjQ+PLmzIfimHbUpDf+gP5eUc7U4hqWctAKmFRHraB7Rn6VlkPl/9Yrk
	 ky2KA+PEDcq0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0321F38003EB;
	Sun,  1 Nov 2026 01:20:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf v2 0/2] bpf: Fix overlapping copies in
 bpf_dynptr_copy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179349600580.2297828.9362269929771966458.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 01:20:05 +0000
References: <20261026162810.12862-1-ayushmanrout27@gmail.com>
In-Reply-To: <20261026162810.12862-1-ayushmanrout27@gmail.com>
To: Ayushman Rout <ayushmanrout27@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 26 Oct 2026 21:58:07 +0530 you wrote:
> bpf_dynptr_copy() can corrupt data when both ranges are in the same xdp
> packet and overlap: a slice of one range is used as the buffer for
> __bpf_dynptr_read() or __bpf_dynptr_write(), and the chunk loop always
> copies forward.
> 
> Patch 1 does not use a slice as the buffer for a copy within one packet
> and copies from the end when the destination is above the source.
> Patch 2 adds selftests. They pass with the fix.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
    https://git.kernel.org/bpf/bpf/c/696f0954e3b6
  - [bpf,v2,2/2] selftests/bpf: Test overlapping dynptr copies on xdp frags
    https://git.kernel.org/bpf/bpf/c/8f92b56d228d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


