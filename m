Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795480207;
	b=tjn0bmj59VkYehCPMtAVFlMpPCktbwLdQzR9HJgHSK8fDhqqB2T8qWmvkPl2770ObTlp
	 niUYnDDgQZehgpZYFsxpj/mzuVTUWhKoYeVS6+54amYHIRFtfKXgWBqfeljVFbYsJ7F5D
	 pwz2J53+hGQ303IrXaAaq6AUmlED5tcEQelDMlG+Rka51b2oZN1DnTBZoLhvs57xs+L67
	 5a4IW8n5tgTKzsRoZyNWFG+FzyVpZWTtgZLUr2On4i+YNV1t0pehjM7htfPK6LicKUTjO
	 TzTQAiBIpK9l4C+49yS7fsOtCuXzKmqNCpXTAP9rMsUZ6xbqMgX4DFG4j1V9W0kP9dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795480207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5303vUd/Ud0BidUlvr3uknOr2zJY0fQD1vKcBNv5e3U=;
	b=NIX2xGPzgXtAZqfMMk2xJ+BknjCXx9qQ9E9tEKfSjOLQyWpRHe7a7ns/OKSKRiJhLC7r
	 rTvDe+eSk3RuttoDljWknAHLAI8Rm+Uqsb5ofJOtZ3iZU1+Qy2lm17rSf/xkhJFOfc1l2
	 QMvoDr+pmOyuc9v5Ca5yLFUYA7LAO8adzkrV3d3n8y46aFrYPwMFoP+5Luzd3WADdal0U
	 +nbTlwguum9ZzfOLVbUKhET5Tj40jgwczQ3LCPlmTM8VZvJKe/IuymVJQzBhBlco8NMf9
	 SeyRL4f8tSa62noj5bkfBvMdWXU1nzObhyOPgl+T+pvoiD0BzcjQdais42V55wFuESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BorkjYcZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F3606A321;
	Tue, 24 Nov 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BorkjYcZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113B71F000CA;
	Tue, 24 Nov 2026 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795480206;
	bh=5303vUd/Ud0BidUlvr3uknOr2zJY0fQD1vKcBNv5e3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BorkjYcZFUDhypgaL+YYT5VZrB0HU4zrZq7sOwktf/IBo3aB7KnYVUMRh5KFUN/Jn
	 /eNNR/ZbWyv9vVFAmGWFt3zMw+OoCG/V4IMYT3CCb4z1f59+uSal1YnkNGAGZvnStR
	 BPbBThIhN3W5aZs2WCWzO8o2zS35Zt6m6CodbOI2wY6TxU+QZ61R8F2YBEkL13a5R5
	 4uSVC1GmBCaK1hrFl4uYN0BGP4xcC+3z755P12waRoVEXO2GwKN7yuByKfA5xQg9AE
	 OmgsQW4M131JDW6HIl9HS0U++9neea9VmAxnvbxIyeLP0KSwK4p6uGeU/KfKf0v8LQ
	 5casHfU5XaVeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15BD3930236;
	Tue, 24 Nov 2026 00:30:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range() return
 void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179548020453.3198552.14787548652121686601.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 00:30:04 +0000
References: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>
In-Reply-To: <20261120-jf-bpf-lsm-retval-range-v1-1-d712e4090907@linux.dev>
To: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Cc: kpsingh@kernel.org, matt@bobrowski.net, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 a.s.protopopov@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Nov 2026 04:28:36 +0000 you wrote:
> With CONFIG_BPF_FMODRET_SCAN=y, fmod_ret programs can attach to tagged
> functions, so a program on bpf_lsm_get_retval_range() can make it fail
> for an LSM hook that returns a value. get_func_retval_range() then
> reports no range, and do_refine_retval_range() and check_helper_call()
> ignore the error and use a range the call did not set.
> 
> The function fails only for a void hook, which every caller but
> get_func_retval_range() already rules out. Check for a void hook there
> and make the function return void, so resolve_btfids no longer tags
> it and no fmod_ret program can attach to it.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, lsm: Make bpf_lsm_get_retval_range() return void
    https://git.kernel.org/bpf/bpf-next/c/351668b0b8b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


