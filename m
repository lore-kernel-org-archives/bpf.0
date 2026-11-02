Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578208;
	b=5iRN1Lk3SrLTytuKT/e7Ju8EYxUZtY1iosPBezMXQEI/+kEFViNPhK2weK9jrnjHVLxV
	 HlEMf8WLb+yDGTfGLqxjS1rajRN+6mfx5joqmwJ3ONEPr6P/jRhUkAWj1C17kSJVJopB9
	 jrz13QleYNEpbXqCdSRrNsZewPf/PtlRZ11QkOP7kmlDJlr6mH7aTT7y2dV9Z1XkXx1if
	 NZXI05LJJ35cxLJHrxwyNEHJ0jVFrGL73Zumtbh94fsxxmihoQ65m55lkVsPRzft5/znW
	 wxVdQS6UHAeLkWQvDhU5fzn0W4mK0BSB+tFKC57yWowzsdW1urL6nzi8lz1Za288gzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QKFaYGJVr56G1QVqb3i2JANs8NYB+sHXNhlWziD3p0Q=;
	b=Z4ifuKTdz/6uTd6NaGPYrXdQ6G54558VzZUPQ4o+kPR9aXx8uttg6BTSddXAvWSUxyKh
	 eCgWmG+phmnSWtMeNmY8x653o4FCkX2N1TlwjCAqMBgZ5pMTcaDPg3MOdOT52mipxJb3n
	 uaOS5gc6YVLHzhq84HrBb99BLL9Bllsy4GHA4r+3NCA/QQausfo6584ZkalsgmT6Z6Hif
	 oFe64i77gHFQNI+DJgS8IvU7vffNHNO4u9XSalRskh8INvZhS5qPLEtTnkhHX/4R+SN5+
	 dsHV0WCMk1x2pRoIQH9WUz730PcGhkKsZihHW+DN5PiDUfmicoDDMKE39vp/d1OvEyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPxipRIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0794606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPxipRIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853791F000C1;
	Mon,  2 Nov 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793578207;
	bh=QKFaYGJVr56G1QVqb3i2JANs8NYB+sHXNhlWziD3p0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GPxipRIeV+D4shLRl2qv89D8CLrqZvpeKGmh1isPyYUH7pN92N7qDNuPzPZZl0Kgd
	 YNP8Jm1BUABiUglxX/LuBRhJuyFHh6iHhqQ/H4hB3Wgt4uV+fMxktCshv14OvelelW
	 zRI0z8FM5pDY4R/yZq51MRrLwxPao73C3HlNgPwS3pwTOkNvR2ZG7detnqTa/duCQJ
	 dOr0j6aaQ3GR7Zfcv3uJ3MAOxwpFPLQXhBGaNwu41RjgdTNctWICnVdg2LXIMnu40F
	 PqkcRwRuNEAy/OSe8wFqyygbYNwUlrZmxJPe7RZ+W5YvX3YG2zrcwekchpKr+xPe+2
	 rur5P93t1XpeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D11F391AFE5;
	Mon,  2 Nov 2026 00:10:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf 0/2] bpf,
 x86: Fix bpf_throw() in a prog with a private stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179357820630.3679073.7807830194038168117.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 00:10:06 +0000
References: <20261031050558.2410721-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261031050558.2410721-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 31 Oct 2026 05:05:56 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> On x86-64 a prog whose main prog has a private stack and that calls
> bpf_throw() returns to the kernel with wrong callee saved registers. The
> kernel crashes. A tracepoint prog or an fentry prog with more than 48 bytes
> of stack is sufficient.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf, x86: Fix bpf_throw() in a prog with a private stack
    https://git.kernel.org/bpf/bpf/c/91068ed2d3ee
  - [bpf,2/2] selftests/bpf: Test bpf_throw() in a prog with a private stack
    https://git.kernel.org/bpf/bpf/c/6cc0cf0a6fb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


