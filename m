Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447009;
	b=xZH1bN1HyjgpMGbXNrScN2vwkBD2yd0zKoP9+pxOEWeuMrX6NxexfDKBqv/RJTmd/xHg
	 6tyTavQOvWX6q1PJmjdE0o/hmycBYIblMBWBq31+IQvwEAYx1cD3T4QyWMZlJab9Nvg12
	 p/IruTPXJt33jGm1INcM6tlAdqrmXZ8PjcIostp0762/QrQ+ISZvSeXBnXZGm3tcFUZOn
	 3YZIiM6QomdCLvSwczt+7tos61TNAoerNNFsGpMEVY363GXU/OjBImYSaBJBz05lSOpcx
	 BSOfGXAab2qEz+gPAfZBkDW/sH2xEJ/AIxVTQWuJBmlmz4s83g7fIid0zSoutk7HfAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0mvwJ5u7CVLi8wnAR/yBIhqqmgfvfbGS9sdPc8+kgjY=;
	b=PQLURMWwU6ThUiro7Y3E3O5SC2L1zxQWop3vVj46Bn9WdKoK/ggos8bddYyzWOsGpg6G
	 ti64kH/5zIWvWCGKVjdYpbKqxwy/Z7k/AIJHei3Th5l9pFkGEyk3dzCYedWgHunsdBbgo
	 Ucp9bxnycWKy11lirLUx1eIYjz9SbaQsLj/7lhRwU/usH5s5BU0XJfKQKVjhGXGs9n1mD
	 dwAp8er6+dro/KO4U5HzmGLvbeSbFk9jv7KOjIwhfWIiQ4e5rAH/SaAlyFAJyHmGB1nYR
	 t/4Zdf/Z1sLya8tvM/CcId0Lov2cxXzLS1+wwW9BmFbaw5XGn9kKgZTQwJm/zfiv6fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACjQxyQP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADE606A885
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACjQxyQP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED771F00A06;
	Thu, 12 Nov 2026 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447009;
	bh=0mvwJ5u7CVLi8wnAR/yBIhqqmgfvfbGS9sdPc8+kgjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ACjQxyQPgQB3ij+gS/AWdKFMAbRu7KtlOZV0chn/xtyTz9v93UY1oPGlm12tOT8/z
	 fgQPUy7LZtS1qDYG1UvJGY+yWpNJEXTUMqF7ZDmjJOFCF2zniBFMESDgDQxQPSZk51
	 ZEE72jVO2kI5E3gLo6O13T4vYYX2/n4Z5GZHXF67El3KwDLH8uKn2jiI9Oa2NG2WOR
	 a//WjfiK4KwzKHOC+KLvDGlYbdUuIcqk0q+gqGiEDuYs9F+EquQ33aXkvoACspCHTS
	 36nk8yRcUmPnR1gkJn02CW4rOjJ3C7879XPjGZfvUgVqAhkudHXH5ZTnaDbrWWHF2m
	 rv5zdAKbLhwaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 21291391AFCF;
	Thu, 12 Nov 2026 01:30:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/7] bpf: struct scalar,
 and one backedge-taken count on it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444700768.1753823.7340169159675729297.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:30:07 +0000
References: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Nov 2026 00:08:28 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Eduard asked three things about the code in scev.c that counts the
> iterations of a loop:
> 
>  1. Can struct scev_value be a cnum64 and a cnum32, in place of eight
>     open coded bounds?
>  2. Why are there two functions, compute_backedge_taken_count() for
>     constants and compute_backedge_taken_max() for ranges? He suggested
>     to compute on cnum: no bias, no struct latch_domain, one function,
>     one way to handle 32 bits.
>  3. Extract cnum64, cnum32, tnum, base and step from struct bpf_reg_state
>     as struct scalar, with a set of arithmetic operations, and move scev.c
>     to this abstraction.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] bpf: Don't WARN on a register invariants violation
    https://git.kernel.org/bpf/bpf-next/c/d17237abe54a
  - [bpf-next,v2,2/7] bpf: Add const, sub, zext32 and sext32 operations to cnum
    https://git.kernel.org/bpf/bpf-next/c/5a8baba3dfe8
  - [bpf-next,v2,3/7] bpf: Add struct scalar
    https://git.kernel.org/bpf/bpf-next/c/adcbaf887108
  - [bpf-next,v2,4/7] bpf: Add scalar_add() and four more operations on struct scalar
    https://git.kernel.org/bpf/bpf-next/c/2d6abb265b1f
  - [bpf-next,v2,5/7] bpf: Compute the backedge-taken count on cnum, in one function
    https://git.kernel.org/bpf/bpf-next/c/1ce78eea8373
  - [bpf-next,v2,6/7] bpf: Count a '!=' latch if the step divides the distance
    https://git.kernel.org/bpf/bpf-next/c/c7a4e3f18d0a
  - [bpf-next,v2,7/7] selftests/bpf: Test the backedge-taken count on struct scalar
    https://git.kernel.org/bpf/bpf-next/c/577e75d8c04f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


