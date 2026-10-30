Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384408;
	b=RCg/WyXL1wOHtOFarz/L2kHetLoz9A+CfKNTm0u6aBHU1aVFWDJygn303G+xnrSDNATA
	 eS9gpjahuyP9VpKXruqQVprCIPAZ46LChFOBxmNqmTFR9Nkheq7aNiH2Nc4wRnI8f/2XL
	 ODtsOGJC50nGS7oX4zZXHQus8wqLC0ZxbVzLv4UmEQuMGJP/Z6G/YxkTjAv3a5HHJka+r
	 iHjnKulG2SjulVNX6E5E2i7xhT2iG2f8pBnNHm9Bnc4b7JoQg/K5mmKO5h7qz812sz7Sp
	 j4OmPm67D0Kwu+QIMTM2AJUO5HeaRoyV04U9N0crrrTeRNDYwDgS1Xj5PWHPsY0OrTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=T+Y4owQVKbyDJdRREGvEjtetzfUFOQyUmcM09JJLGp4=;
	b=km6PaSKWwlINlB2GNDDAD5LWd5kdr6lEcp3+JETp6wVOqW1yAlSI9eiLPNMuih4qGk1c
	 7oh0akM0xZLpfPV3NVpIB7gqPKkrKlRlJecOlhwyNZ2abkJAF01Iz6rCl/ejF1Zbh7qVG
	 U8p/pdgdQ1hyTPfuxo75r/d22/sWpwylcf/aybxeFQ0W3sFdUBb4J70q3Mapuiw5Lro/T
	 lwzG7JLgFyRvZjvaazphMc70LOSAtPXKCrQFIIYKbmOGA1+hqlbC57S4QaXh6TimEiDJK
	 Jo/O/IMgnuCc/dKRH8HYsN31De59xADjGwAbKqEMajbtH7+YXUDCDG9kt11c49y52Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CW4x/ee3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C5606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CW4x/ee3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD61F0093A;
	Fri, 30 Oct 2026 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384407;
	bh=T+Y4owQVKbyDJdRREGvEjtetzfUFOQyUmcM09JJLGp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CW4x/ee3GcdLHGT2YL6TSyKVtqnpg6ZMz5rHDovLL0Mj+wSPQCkNdU4MNv3X0nSoC
	 E8gr1MWIzYmUKGO2WO7Xox2UWKH7l8uxKVxM2SR65GlOF33A8SM7oty79D53/Cj9SW
	 k08plw0q35e4AH86DEmymkKRizMnX3u567qacwWM3hK0ZPmvG/PgKH5rP5I8Xll4Wk
	 M1rAR/Gk6VcZzbjNNKFF3hrP4kOkV6+M1C4+y4CTxtCQaJc2o7CXNxcaKzoiqo9ZiQ
	 us7c0vtBuWVdhxwPjvrI6KvrhDvv8VqZv+08mN6XKAk6FVnt3e2V0Ws+U378Xs1JWm
	 a8ypsk2WKigGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401593800473;
	Fri, 30 Oct 2026 18:20:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: Make strobemeta and pyperf
 robust to branch reordering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179338440606.1701677.5879253412704915379.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 18:20:06 +0000
References: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
In-Reply-To: <20261029-bpf-selftests-branch-order-v1-0-425cc1ef8581@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 vineet.gupta@linux.dev, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 29 Oct 2026 17:49:09 -0700 you wrote:
> An LLVM BPF backend change ("[BPF] Analyze conditional branches" [1])
> lets generic passes such as branch folding and block placement invert
> and reorder conditional branches on -mcpu=v3 and v4. Some verifier scale
> tests are sensitive to which side of a branch the verifier explores
> first, because that decides which states get cached for pruning. With
> that compiler these programs hit the 1M instruction limit (insns with
> the current compiler in parentheses):
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Check the strobemeta variable read instead of its location
    https://git.kernel.org/bpf/bpf-next/c/3e59dc1ba8a9
  - [bpf-next,2/3] selftests/bpf: Keep payload offset for missing strobemeta strings
    https://git.kernel.org/bpf/bpf-next/c/6d4bab548b11
  - [bpf-next,3/3] selftests/bpf: Exit the pyperf frame loop once frame_ptr is NULL
    https://git.kernel.org/bpf/bpf-next/c/55e92edf877b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


