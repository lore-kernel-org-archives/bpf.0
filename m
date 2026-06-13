Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD42EA731;
	Sat, 13 Jun 2026 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329810; cv=none; b=OgG4+Ef6jRtafMRT0cSFivmWw+PGsrkmqHtEPsoDogdJFOBzWkAyokdxFQlaeFTQQHD5GEVC7K/DrZQ1mcnShV5tINqXQThkv5pheFICbOO2LwMQdkC3xciMdl06aAcc5rWHpSBpxillJYHARsvJwUfdIxKMGjqN16hRLSoC8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329810; c=relaxed/simple;
	bh=TJ6AtKGIrz9W/yLVKkAHrXO1k9EbEIvVHXn72noWEKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/lS8XXcNZP3o9zPlpPnuhhsl7t5pptbBWqZtzIYr4qIa+XHwJ4jc5l0/PVXo/ha6LSUOi1pFHK2StX8G1LiPbfALwNUy0+Ns6CKUdl9+V7D/L9KO03z9/Xxfzq8PxQernB2JJmYvRu4fRZxMu19CjVA9gyUauHm7br199s2IyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcis5rMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcis5rMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284601F000E9;
	Sat, 13 Jun 2026 05:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329809;
	bh=5a4AVJpZZqHMTuYzKtBcX9VwtdXTCY5R610ZkJJpi00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Gcis5rMvacdlnHjp6Uw2ARA4wL+T5Gfcccby9yFPY2PF95VDoOJCEeeJgILwwa5N9
	 l10xuhWkMaevU21pUH0KaQqXweL3LMZInePLR5UAMxUd0cwcV2I3+zQSV2Lv0ghrUY
	 Hg5KOrxwPQZQip1h1RhrtUyZS04chdvgYz7WPeuv6VWYQrHOdVKeRYQeOLvBuRk8P+
	 OrICWv3o0q4J4yxU2RJ/XXjg5aI4ZlINe+HHKYO/uR4KpqqRWTb1+33ZgbT07IhfVi
	 9Mm3zQtX1r+HKNJ7pe9x9acZjsX2qtRmh1pZt99pOY5jPhtTru5z5wbpiqZEHRHwnw
	 Ej1gYarbBgbsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099539E960C;
	Sat, 13 Jun 2026 05:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Add arena direct-value
 one-past-end reject test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178132980565.1389480.4761894632553713194.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 05:50:05 +0000
References: <20260612-arena-direct-value-v1-v4-1-b81b642f5277@gmail.com>
In-Reply-To: <20260612-arena-direct-value-v1-v4-1-b81b642f5277@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, emil@etsalapatis.com,
 graypanda.inzag@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 12 Jun 2026 14:26:55 +0900 you wrote:
> BPF_MAP_TYPE_ARENA supports direct-value pseudo loads, but unlike array
> maps its map value_size is zero and the valid direct-value range is the
> arena mmap size, max_entries * PAGE_SIZE.
> 
> Commit 3ac1a467e376 ("bpf: Fix off-by-one boundary validation in arena
> direct-value access") fixed arena_map_direct_value_addr() to reject an
> offset exactly at the end of the arena mapping. Add a regression test
> that loads a BPF_PSEUDO_MAP_VALUE with off == arena_size and verifies
> that the verifier rejects it with the expected offset in the log.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] selftests/bpf: Add arena direct-value one-past-end reject test
    https://git.kernel.org/bpf/bpf-next/c/7bfb93e3475b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


