Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659809;
	b=pDDazQKxwhXYzVyNKCkIoyijKttkoEwsJ8xKjtAONW2c/3L//oJ5m07t9vkO2tAQsaWU
	 gRoeWMV49BWhycxWXboJ6Z+yVXaGJs4OoLfAen2oMkmtbw7aEaAfI6/TNbsBmxvrGapQq
	 +zOaqSZDE2UlRN4hOMV5fatSASy7J+8H1+gOtnOJdW38Btrdf09VddmJaICqFYWSV7VBY
	 WWnUDT2mWiB5/y5WoFkey2TCvG4J1szJnIcGX8BdhczKqU+vSSTq7C2q8EgHFhoa88azL
	 W8DaGLUDWn3D5HYz3hlSfG0X8UGVsZxVbCiOgFnY9iO4me7+XdKl3MrTdoBuso2S21A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/0qiMISMNLVoHtpbbLLHUQ4ZXU/ejkfReM6nJA6Bb/Q=;
	b=zSEw9LgOjn2P4Vt8U3+e5ihcdQi8wE8mhLZLD+OGSlEXClJaklW++RgY7k6lhDp5239E
	 f3c7TGKPslTip/4plqw8n20jcPx/7DQTmmb/JqLGCD8+UdYvam8VIdNzFIuh9RSMZK3Gg
	 PWgy3ZlxA6xMaESRMpfM21paScgHOim0ItBHdKx0cXLGMXbjyHlwGMrXLOU1jSXyJnFeS
	 UBctDMGtjVyHGbVR1xsFiuI/qHxu+gC0XSr9VkAoA8S7MvwUA15pEfDySB04OmweVt97Q
	 U4sjoXzFP2sLmfwhg0Se5C/INCtKAZ104pWLkDW5W+FaOUSNmlGoEFOrY1ZFmL9FqaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLW+Wltg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71F606A32E
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLW+Wltg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0F81F00A16;
	Mon,  2 Nov 2026 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659809;
	bh=/0qiMISMNLVoHtpbbLLHUQ4ZXU/ejkfReM6nJA6Bb/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mLW+Wltg9jjNz4cPJLL0r1aOFcqJlCFqLXWCQb9WZNOxd9WNfO6n7kXdIRiyJFt/l
	 7QgPt/QmMvTJB0a8YPyQqoO7a/hgOFd+p16bVLi6NXwL0UjuNWNdfXai6kxH+e9pR2
	 T62jOVybetdDtgM6badWOcNSsBESRESw9A54StbPYGzMuImriLqCcwQFWKZQnMdwOF
	 XZfVv/ea51NEQ3OeHPDuDDtfThQBSt417ATWoQzYahijyd6y7/pzQCtloQCbEMEfHm
	 Ei/rXml9NHD4pyh8g//2UlKKaO3Lko14gQgQXs+whmep4+3oF3Jqesnb5dfgHTGGuW
	 mWkZk+Lc5mk9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4027D380821F;
	Mon,  2 Nov 2026 22:50:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf v2 0/2] bpf: Fix stack argument precision propagation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179365980779.707305.9881709409053395566.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:50:07 +0000
References: <20261102190350.788433-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20261102190350.788433-1-xyx2021@mail.ustc.edu.cn>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 yonghong.song@linux.dev, alexei.starovoitov@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 03:03:48 +0800 you wrote:
> Outgoing stack arguments retain scalar state separately from registers
> and ordinary spills. Their precision dependencies must reach ancestor
> states when verification reuses a state or falls back to marking all
> scalars precise. Otherwise, an out-of-bounds map access can reuse a state
> validated for an in-bounds argument.
> 
> Patch 1 covers outgoing scalar argument slots in both precision paths.
> Patch 2 adds two load-only asm regressions in verifier_stack_arg.c, based
> on Alexei's examples.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Propagate scalar precision through stack arguments
    https://git.kernel.org/bpf/bpf/c/d537252cc8a5
  - [bpf,v2,2/2] selftests/bpf: Exercise stack argument precision on state reuse
    https://git.kernel.org/bpf/bpf/c/68851f7d3e20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


