Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896806;
	b=E8zJlEoaWW4igR6ZNTwQs8N2P81awByyAOciHPr4x/rbezBf/koam/emhtaUIjliL2Mh
	 LSU7S6LPPOYKmwaEs7EJnuIkjAjfXbGa/ek01iZKBmmM2SsrrYFEvkgLjqTuGg+uWWdFR
	 90kW/w52GnYkTV9sCLkl9NQYQGXguxQytQWL9BbV3mQp42yTCBv2fG1g0u6ApWjOdVxuI
	 d2fD6ubptGP5tyE95l/yc4aSpQUzGpisX0I45hEIj/yC24qrn4Ac8wNDPFpjXjQ7Z+9lP
	 C+EH/WOD1PQq/amFXsy/HEmAdW/aVYNguodRPFYhaKxTXL4BPbLkY3MJ+wbsGYyW86A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=93pfEFnv6eRYVo9MzO6iXFxZSxZpA1iR6ohe+lbNyrk=;
	b=lHr1nYDQFA0EJl1/dFs2w+oyRmhHJmW2dc2JiefAbw8+dv6X8MPrC/1o7ysA4ci5uPnh
	 o53dULE6OusT1UeP71i8VBl66pc/UGrMsKbune8jO2o59fbayapQrwB6nrwHFHHnCYVtx
	 r2ROY2Kdi0U+gK0a644KYxQ1bnriWAf21xpevngnEL6y2upx6FQM2988sotfDyxNxtSKb
	 LcRiqaNlz+LGbGHYz/6ucbs0mumD4KRCGKhuTAJLAv62WRvKTs0iRDStxn8s07KhW8HN8
	 D0x+uChb+/t7A/rLtlyYrvXY07R0WB1rHWLQ5CzwQ5z49cHsTP/KwusFClM6h54K1QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSwXTV3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C303606EE9B;
	Thu,  5 Nov 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSwXTV3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4929E1F00A1C;
	Thu,  5 Nov 2026 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896806;
	bh=93pfEFnv6eRYVo9MzO6iXFxZSxZpA1iR6ohe+lbNyrk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WSwXTV3RtiMIxswplO0pWn1MpDMXcg5dAKZ4kzV/UjoyU18DDXJqloxlVvzQwcqrr
	 vKyygS7i7EHWJFhD6dBF+KftsjFMLlGmfH5Q7ptgxT9L+qY+wElxkx4ByQ8gIeaVG8
	 QVcsC/FMV2HiCgVhr5tWXMG+vB5Junr1d5l61ty/dM7m3VY219MmgZQIf7ivw0WnTW
	 SjOjAsuAq1oZN1LzYxPhn+wVnmTrM9+vdoweiyMzfwu7dhndH5jjIllxu9RApFq7E2
	 r23/urv1toBt7EXWmqUb1lnZUK/Bs4NKkUwJPJyopxIMZIX60CNv9X5TeB7CEzpq8q
	 zLxu9lESLToBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 40226391AFD9;
	Thu,  5 Nov 2026 16:40:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf] selftests/bpf: Look up unpinned maps by ID in
 bpftool_maps_access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179389680506.111114.10152549399816120190.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 16:40:05 +0000
References: <20261104183323.409412-1-hi@tychen.cc>
In-Reply-To: <20261104183323.409412-1-hi@tychen.cc>
To: Tianyi Chen <hi@tychen.cc>
Cc: bpf@vger.kernel.org, alexis.lothore@bootlin.com, qmo@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Nov 2026 03:33:23 +0900 you wrote:
> The unpinned subtests pass "name prot_map" or "name not_prot_map" to
> bpftool. Both maps are used by programs attached through trampolines,
> which are freed only after RCU grace periods and hold their map
> references until then. A run's maps therefore stay in the map ID table
> after its skeleton is destroyed, for about 300 ms in an x86-64 VM.
> 
> If the test runs again within that window, the name matches maps from
> both runs, bpftool fails with "several maps match this handle", and
> the unpinned subtests fail.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Look up unpinned maps by ID in bpftool_maps_access
    https://git.kernel.org/bpf/bpf-next/c/325f263b2a7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


