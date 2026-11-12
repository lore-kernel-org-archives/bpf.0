Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517214;
	b=EyTvfQ8GlZBiWf7hj0CyWy1S6BQYs/M1Aao8hwutWVWMXka5hWwlBY/1czbWITGtcoST
	 moynC3O59sUexcBDlMmqJ42PWOVTvBuSniXQLBsaxrocfYEpckd+9h6jdN2T+fdUVInIR
	 FqMQh3AWypLyG2JKOmknFsthp3zclsbgTogzBayj3gybs1QvoNX9zAK1LDAwK0ZVkjpjA
	 2IFK4tznB4Gquytx7XG01vceuZNFMFHEZ4BAwWtH5A4V6hLlF6TDOXDp/1xmOWCJvaV4A
	 gzGTed5cae9Maa53k38mogtR8jowoEgW3DghBSH87i62S6zzjwofX8t6Jdl4US3LxHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517214;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Qwf0acPSMD92gF0t+9M0rMNp0XJ9qSV0Tz/3iVLnuJw=;
	b=ZjufFcEpJSznqKnIci13Plw3RcOn3z7NhbrJFmW+vUbYkvkC2BYtow9yJWPIvpG7/ZPK
	 KJqdXjZwCwTg/nW8ov9WXRljiuZZVTnSWEJW/H5UGy6IQMZApCEFf6vfJWM2Zcmbmz7FG
	 UcqKoebqRBq4xPFTyn8kO2oMBTm9TsS+wMEI7+MUpFr5HRWCMJVC09OpRdUR9e8svc1Sv
	 Fcs2TvPQNPbyTRHf4cukkScJ86fYR4YcTGFKj+oKNKjwFKCmyqc0VetQlAW0Pub2t1bjw
	 V0bqzDfNcqNomwjBAnwxVzabso1ur49u70sMFNQKulIkzhWDJIRO2P/GMVC0EwoXKxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3TidS5t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718C606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3TidS5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28F41F000C4;
	Thu, 12 Nov 2026 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794517213;
	bh=Qwf0acPSMD92gF0t+9M0rMNp0XJ9qSV0Tz/3iVLnuJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P3TidS5ts3/k1NR/1XeqE0ew21SBsS1/vzcwwuE7sKDP+sHilmbefoh10GM6ko9h1
	 /QL+j/y6bCUNf090i/DvmHm6BjR6Hj3h0SeR0M6bTlY5bbQ731G2tYQth148MQrXRm
	 M65AnDwLmLgMD0Gm03plLSW5/Qf7yeFRLP2JsIo8n14FtXt6Hgn9j5LYN76hozarZm
	 /YQJX5uYYKJlnil26c+tM2zaDmU33gQkUzyIvI3dTAs1g71Uu2TgFdDSTeLoEC2HuN
	 9XDLKvGF/KGkGrcVZWSfXL7Le3w9kZUkQki6vzdjp/0vM+6dv/iaQWYRKoBoUaMI8B
	 05AZzsb9Uq9cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45933926266;
	Thu, 12 Nov 2026 21:00:13 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/2] bpf: expand BPF arena kernel fault
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451721227.643214.15095168549502259048.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 21:00:12 +0000
References: <20261109181906.7350-1-emil@etsalapatis.com>
In-Reply-To: <20261109181906.7350-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, daniel@iogearbox.net, tj@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Nov 2026 18:19:04 +0000 you wrote:
> Currently, the BPF arena fault handler protects against
> a misbehaving BPF program passing an arena pointer to a
> kfunc then unmapping the backing pages, causing a kernel
> fault. However, it does not handle errors where the now
> unmapped arena address is instead accessed by a non-BPF
> path, or by a BPF program that has a different arena.
> The former case is already possible in sched-ext if a
> BPF program removes from the arena pages allocated
> from the genpool allocator.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: recover page faults across all arenas
    https://git.kernel.org/bpf/bpf-next/c/92a4f1dddd99
  - [bpf-next,v2,2/2] selftests/bpf: add arena fault recovery tests
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


