Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640406;
	b=Navp+pUsawzPycdcdOdwRtY9iTzb8E2EQXWDzEeQDkQFYFhQ5WNUYOB96wa4YhKLwcjo
	 3ieDKxEejf3bW4rQGusq1Dc+GDPSlL5kp/+qfYfds8SFPv2kTrDhroA+4v9Ks56qGllfb
	 28PjWrL+LfctBYXsnSR8R/YPR+PMW40JmTsKkwfz+Ycqa0crEz83tn0maNo4TCJz4xsHA
	 OuMRtenKdFxr9RksqCn6MuhNeMIj1ZFFfJ6ip38iPMrpkQkRhkgA6QFtdN8bD730NG3Xf
	 M3M2U4fwa8lsKh6YTLZ/eYe90vcsSx8yTjeH8k3Fb7Yvq50ce81SHokr662gr7NpcMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Ae+wuLaD5Oy4qebUY4jbFj5qLIe7o03Ea6QAoSb1edc=;
	b=iLfOAUNTVk6FxoJ4JFOEr1jUHDYdHuGz6KKDa4lx8SVxWLL8PCy/PKV8Uhr5qAlwJEPA
	 ecAXcr4IUZxGTKnRYA0DikiQU5lnVrPjNIglzd9C98s+Ko+XMfOJlWAnmIg10sJanVIvz
	 sjpnZfhEjdNfLKxUkypVWAZt9X7ZeYg7PdoxHlo2X2GRpE3I71ZqQYLWxDLrTlU7m1opg
	 Xn2NKTYUdUfJ9PM8XNK0qzjQhezeKX2e9TDr8xHB92xG/6a/uMHsnLL4LERDgZfekx28R
	 wR32/H0Wi3Jgr+nuHKsTEaE5MQ4nq/laeJWVrrbwaiRp/s7WAA0RuermTH0lml67D4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbplnnqV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB8606A32A;
	Wed, 25 Nov 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbplnnqV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F231F000C0;
	Wed, 25 Nov 2026 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640406;
	bh=Ae+wuLaD5Oy4qebUY4jbFj5qLIe7o03Ea6QAoSb1edc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dbplnnqV/aUnI4EVaWt4cT9TjCHL4owChuD4/GvNs+9UC3Qxfgi8Mn85i7o62tzXk
	 Fjq+amcWk4i1E/PdDC2A10owbR4e27pnovXfUPRcKBdD5uJaWzrxPNo3zuHUtlrqe7
	 3xXv2atujDQ1mrrf2hxmixzIA1ZTpjJDprm6oIfvzZap3JTk3zIx3SLajjpz9Ig89A
	 qClsGMJNJ9n6QVVHfDCEyjH9/hL6S6t4O1ETDTVR/k2sfYOO0vGMeEAzYY4dKzgTLt
	 xikhDYY9w62K3GtEdQRBPPbQBsyo7UYY60vLwju2uwl4MoNu3rAxir6M/pmNuuE3ci
	 9Gc8vBPnpy04A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2783D3809A13;
	Wed, 25 Nov 2026 21:00:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf 0/2] libbpf: Skip BPF token preparation for gen_loader
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179564040476.1330987.5241146907149197485.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 21:00:04 +0000
References: <20261123045730.1960346-1-tweek@google.com>
In-Reply-To: <20261123045730.1960346-1-tweek@google.com>
To: =?utf-8?q?Thi=C3=A9baud_Weksteen_=3Ctweek=40google=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, sidnayyar@google.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 23 Nov 2026 15:57:28 +1100 you wrote:
> When generating a loader program offline (obj->gen_loader), libbpf emits
> loader instructions rather than issuing BPF syscalls on the host. While
> other host-interaction steps in bpf_object_prepare() already skip
> execution under obj->gen_loader, bpf_object_prepare_token() does not.
> 
> This causes offline loader generation (such as bpftool gen skeleton -L)
> to probe /sys/fs/bpf and honor LIBBPF_BPF_TOKEN_PATH. If the build host
> has a token-delegated bpffs mounted, libbpf acquires a token FD and ORs
> BPF_F_TOKEN_FD into map_flags and prog_flags without gen_loader
> serializing any token_fd, producing a broken loader blob.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] libbpf: Skip BPF token preparation when generating loader
    https://git.kernel.org/bpf/bpf-next/c/d92defe04ad5
  - [bpf,2/2] selftests/bpf: Verify gen_loader skips BPF token preparation
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


