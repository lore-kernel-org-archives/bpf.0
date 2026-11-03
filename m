Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731210;
	b=vkKbH+EM78PEe9LEkwQQSTBMRj6JFThTWeEJF36TbkpUFOhhXunqC//pm61SJQgNZk79
	 KartWvvZndGb/uPmBIzx9tYVaM/twCCzdcJoR9CpQklw+mLUAcadTrM17+lFcH4jRH3aj
	 +WdK6GZrJSsKMEQsloIXK9wykwTM8zZs5sxIM/HZXen5OhNR3rY6B2r/vfIS3QTA7c5Fo
	 KnfkWneHCaNo5lPMaKrXz2N84Hct7OeFubvZxG+fI9iM9vM0k0unUli5JiWlmJCz1VCxr
	 BWNmb26i0Rq/j7O9tI9h1ddJu58tH3SBmj8VHDxeH335G6ULP0u67Q0SzIbNxW6907A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Bt7ardkUaFWT2A6LprieZN0BSPug0/UANu6FZtrcvC4=;
	b=mNmItDxa7AGtyeTBVan/asoR6u+QaAEd7CiZdKMXfGHG8q3JKEoigNDtVtZ7SG9E8xzn
	 cQfXEUCKT0GLBqUeXH2vL5/atjAhS8U7Cdn7T7sQxR5KZxC0PeFi46uYTzFUbzdvGRHh9
	 1r/S2E2VvSOrtShJ9pDR4amu4tfFIlOlvZUQ6wAqr8NsPWJDZNjvgwaxC0dyeIFRXt7E+
	 WaC0q8d81jWUdJxD0OTF9PwUzZytoJBfb7Jy9vTpnUCQ/ysMUsN0J7Th0/C/RFRvzTxdu
	 duEU78jYaQ2pDz8GhC1N/QhaRRjGOY6HikRief51V0vZY0/6tvMRqU6PJ5zFtsSDjBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYEyjqkI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7432606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYEyjqkI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CA41F000C1;
	Tue,  3 Nov 2026 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731209;
	bh=Bt7ardkUaFWT2A6LprieZN0BSPug0/UANu6FZtrcvC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JYEyjqkIdxCP90N29CIf9218yDo9wy3fCoaz0TD1d3VQQP1l+5naPIO19Snw+EQys
	 iBgQ/Wf8xNw3i59l3byZHbhDmdoFBKB2SeteWEmCVIdXRTkI5XDQjm8ifJkuq8uhZr
	 Bb9elH0+cLYfELOm5Is/TT5bRNfLXBHtl/1ASuX/QReFnCnRAx5C+Oo1ZKbFVZao9U
	 2YwumtuqCw/HFmJ/ZdB7fIVk/juSvla2xKco+OQ19CST0knOihW9bPWwcx8qIYY/rQ
	 WPo0KFflOKnMCH9KEqf60NqBQQ3s5P+Z2rAjnw9slIo07FdTJnKDnUfGjVUvkbUsV+
	 qe6mjrcey/X7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1B5391B086;
	Tue,  3 Nov 2026 18:40:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/2] bpf: A lookup in an array is not NULL when
 the
 largest key is below max_entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179373120804.1810830.15864916469899205797.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 18:40:08 +0000
References: <20261101174700.4086827-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261101174700.4086827-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  1 Nov 2026 17:46:58 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> A lookup in an array or in a per-cpu array returns NULL only when the key
> is not below max_entries. The verifier knows that for a key that is a
> constant. Then the prog needs no NULL check, and the verifier does not
> examine a NULL branch that the prog cannot take.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: A lookup in an array is not NULL when the largest key is below max_entries
    https://git.kernel.org/bpf/bpf-next/c/c1e03c8479e3
  - [bpf-next,2/2] selftests/bpf: Test array lookups with a key that is not a constant
    https://git.kernel.org/bpf/bpf-next/c/2faec15e0153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


