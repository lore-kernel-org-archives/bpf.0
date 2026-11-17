Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892806;
	b=PjOuTAeUUmUqOc4P9ijAW7bdYGK5lyhU/Lsnj8QJjtUTMa9fdTJRnriop0Ce6xKpGz98
	 myFjd7kmpOV++aBz+GcsX/O4q8T95uyT/aTmoCSliDR7zu21IneehcaSk5nOjGIHWa6ly
	 gjd2OnwO7sLdETBEG30+HjNX3Yg/QSemPp5MzeMWd8l2xPOdwAKF0auWyQYetlpP94QXp
	 VooxmnsUn73F/A+w9TE+RGcgplUzmL9/8T+TYeM6eNZMxle4S29xN3H+n/+y1MrtwiB1E
	 UyBA5IlBhogB6KtCewm27nY4FeKuxw3CyXHcJxC39USINOEZdv2btjYO5evQj+Uo53g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=REM6XAdVSd2jJOGB/USkHLFX9WT28Z7jzirrmA3Crog=;
	b=D0X8A5fBrEe1D586yrfiERiehdEUqUN8b1mhWYATNpvbjwrh1+rsNnVmRznkEAbJZwWS
	 C/YH29kVyn3xYdrfwwc4NGL5CqoKvUBn/oyaXK3cp75byyxFKeKTP0LieHYVQikxNK2iq
	 P9kMFYxfMDCmWr/W4jRKYmkfaWSGjiD2qfTilGaQfHizUHZszWm76A3TgqSCf94HCp2NY
	 y6EQr/LYEQoWWLybMJvVonAcyRHHR5NEJKdxAtNfCLyRyu5x3twGaE+q9YvAnLoR9ax3U
	 uITZ/Hre3XrxIk5QH6a+8MGHVAn3r8wJvyTAQF5Wmsd3pc8W2/q+1Gz44eSjBz6sPcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZDovAhL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8B606A31C;
	Tue, 17 Nov 2026 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZDovAhL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832631F000C4;
	Tue, 17 Nov 2026 05:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794892805;
	bh=REM6XAdVSd2jJOGB/USkHLFX9WT28Z7jzirrmA3Crog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CZDovAhLn9jejBbKRXHYEvlP6xi5R87KlfzPAgz7QvXz6ruxFLuSaaoqg5waNKc8l
	 /pSRnp1acLqq7aOsWt7Hb7Ho2ej3iNGYJsL2zM2fH4PqKfoBgxpI6isNwSuGFUfoy6
	 jRyg7QWqfXGCLLO7imKTsstXTp6cF20j4jSQCrEv0ER4HFaP/hXa1pgoV2ZcLmSWTE
	 gO3cz/f/nPZArqHcurqCJErjfmU3JBKoAHYjB79f+SU2kEml+VMc9wwo/RnQre3yDY
	 rlNoRo5zaM6E5VS9ei2kpi9BO2OVWLBTKRrUScFSkYq5Dnl5sj1MGIIwXho0KUW52j
	 nR4ndyMAi6YxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772F6391B160;
	Tue, 17 Nov 2026 05:20:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3] bpf,
 mprog: Defer RCU synchronization until peer reuse
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179489280438.347631.11158166869237958390.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 05:20:04 +0000
References: <20261116145318.34084-1-shijing.wuqi@linux.alibaba.com>
In-Reply-To: <20261116145318.34084-1-shijing.wuqi@linux.alibaba.com>
To: Qi Wu <shijing.wuqi@linux.alibaba.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 razor@blackwall.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 16 Nov 2026 22:53:18 +0800 you wrote:
> bpf_mprog_attach() swaps the active entry and the caller then waits
> for a grace period (tcx_entry_sync() / netkit_entry_sync()) before
> returning. But attach releases nothing: the old entry only has to
> stay intact until the next attach or detach overwrites it as the
> peer. The unconditional wait buys nothing on the attach path, yet it
> runs inside rtnl_lock() and serializes the whole machine's network
> control plane. Creating containers in bulk pays 2N grace periods for
> N devices, one first attach per direction.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf, mprog: Defer RCU synchronization until peer reuse
    https://git.kernel.org/bpf/bpf-next/c/32b66b94c86f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


