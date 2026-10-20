Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530016;
	b=neLKYCINHO0s2IKKJQ+l5bk5vETGtf2Q+FoxK23fyk5frapxFOvrAblm3Bdl/GfOg7VG
	 jZZtXsRP8jKpSVYPUr5i46hy4ruiUMOqAwkUwl3BQdEvxleS/Vu+tnzCwNgXuht/ZyI6E
	 BzOo7bxjPVOw84tIP0vox32zOO/pSOJpDdIWQV+WN5Vf7R0cWBvA36+xdAv4mrs5WI44a
	 TifTxZyffXKneXmNa6iljTevlmRJOVAQaRuGuyhUKBHmgj9aHXJ67eE/6EHotTmqFToji
	 7RTk1moi7PvR/d4fLOvs+oa7+nyhCqMh+1rnxhRMWGyr95+yyvO8m0z4GCAdKlAY2iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530016;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eVWXenJP8fap294tptxFVS6EvRGngFHT7W/iH4BOY84=;
	b=mkSJXMXV2u0nnyaKh2hn6/Uv6LotcvXCcDmRdM1Lf7S5bP+zPgC4OZTBn09jNLvOMu7x
	 B5V02GQk5RryurVWJn41EgLwNDMhjGPKn0ay4s8qHtf7wmjeHhMyhGTJHtvowfnErUK0G
	 gSLwbOwmYdKViQ3Hh1mU8+T4nv1H4CIM/zziKBjBdGo3rPQxpDWmIabASAuxFfGD8+/0R
	 +fZd4zVQOR3kgy5l5Pqc/NyvybIn9P6R/oYkxWpq/k9V73Msxg+hipE07RwH1TNf8HE8C
	 9KNuvk6PYFlOx4cdEhhDHNOJ17ikKKAJUTrhTcfHrFN6/IU6pmYb2ubZDm2c4WBKkxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cE0aKMg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B65606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cE0aKMg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB671F000C9;
	Tue, 20 Oct 2026 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792530015;
	bh=eVWXenJP8fap294tptxFVS6EvRGngFHT7W/iH4BOY84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cE0aKMg16fy2Xwl7TlFFd0GEYRc3cGpD/TE5yYTP5PphuEDvBd8xMqg/scSUvQwEZ
	 X3FRGil77V09uc4CR3Z3DssYg7dO509otXALxP2LeVnD7RZJN6rF9ByKZJRPjl9Sjx
	 LGta1mw+R7511NlCC10dKR43HAy4U/aJzw/liuv5rgll0cunTVpNK1dUjAsHsRBc28
	 24GSy+sBEIdHNRk858eaKLJRR7cUb8HjA5VV+D9Qwi/FOOFFrNq9ztCJ1gjFD6mK0b
	 1skX9HdHZZUAGmYkUwS1lnakV5fQyztINyBdJL+AcCO5L4J66V7Bn82rJzPBwvnAS4
	 tt2UIIqcHRChg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44803809A09;
	Tue, 20 Oct 2026 21:00:15 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/2] bpf: support 32-bit linear scalar evolution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253001434.208021.2217021664665592126.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:00:14 +0000
References: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
In-Reply-To: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Oct 2026 04:06:25 -0700 you wrote:
> Support scalar evolution widening for loops like:
> 
>      w0 = 0;
>   l: w0 += 1;
>      if w0 != 3 goto l;
>      exit;
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: support 32-bit linear scalar evolution
    https://git.kernel.org/bpf/bpf-next/c/df4761bd441c
  - [bpf-next,2/2] selftests/bpf: tests for 32-bit scalar evolution bounds computation
    https://git.kernel.org/bpf/bpf-next/c/d4394fc6a1ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


