Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637007;
	b=tYsZTjjhDugV4+TDbrDKGxSRq1QIjc1l2CZqriWdIC1gI6rvkB2BYccZ6XDDttbjaE1U
	 tIYPC1Saeikory1vroJXdGTZJ1mI920PrA71LXUnpeHbGU7IhDQCndVLJ/k6Ch0KU51We
	 W1rlBpL5vZSLFizz0owWJxqBUYRwXABkvadIu6NI3TWYJlYH8ED1+qO2rBGm4l0Sg9GGy
	 4vZ+2PFMkvkthCl2B9Gtop0NYT4CXb0gXKuYrwOZ7lnrYGHzAtiw0uZTufsjDLbw1qlfX
	 3oxNkfZNyHRLfywiojEjDRakoUMSSdY4SQP1rOgDaz05RB2E5QKs408c8/sREekezWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UBXVkXn4RIncG9+NIgY22A+jzAbZ+wcOYWXIGowzXcA=;
	b=QlPFdjx/UPa1IgFjian3T2XJM5v5ANzHfnhaaxJORJN0suxoVGiMMatyGbMDVmj68La4
	 ETkeaNLhc725LSjwa3fCCOgbPR5lYDbAdeBAZXCvn8aY+OAU1Pvqvjcz2QZiKBEilQywl
	 mhlNMMbbdYFQ+kDRVvjLdV4HkHKfTUc9IRIfTxGVmVf/DP8mFJn/fcsnBG6UCJZYIhItn
	 3y7e8F91+pvga0ocgUv4YJRK44UQWqWN035304ndu8As+mYe/6MNwoFp6hrhN9oPeW6P8
	 06X2qstvmpQuNmpz60NuSMCgFv0sxkTtBgEtrLxql+9m6u2NKHKWujkZoKO4SUibqzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyntWazz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272846087636
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyntWazz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48A31F00A17;
	Mon,  2 Nov 2026 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637006;
	bh=UBXVkXn4RIncG9+NIgY22A+jzAbZ+wcOYWXIGowzXcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JyntWazzZ00YXZmNSmOtYFykuXk1n2658nPrpZwIY//qqJ3RoyMEMSb1Zv+CxS94z
	 kU/pLtPbUvBpX5MdlcMKhGpKDbZQcrVc1lJ196MkDmqhGc85jX+J1ItXpV9B1eScHT
	 Q33DFNcP8AHYu4rU5Ufun0XRzo/W8lVWqB2pU1jXt2bZUqhNf0dmFaU6cD09JJtDYT
	 /Pz2InJJjCo2zJ2kyZn9ecbG5W11IGm23M+x6Y1FBXOjJqdecbTMGdcbn7snZcDlDe
	 YehbtwSqhUxyjs1lezR72ZBB9Ib0hk8HmFdNIHgnAWNd07MvNLIZPhzGddbB7SIBUl
	 8pYlRFiSsipAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA213380821F;
	Mon,  2 Nov 2026 16:30:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf 0/2] bpf: Follow-ups for the arena mmap() fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179363700563.39295.9727552603720580437.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 16:30:05 +0000
References: <20261102064231.2153879-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102064231.2153879-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 06:42:29 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Two follow-ups for the arena patches of the series
> "bpf: Fixes for the verifier, arena, skb and lwt helpers", merge
> commit 714b7112017f. They answer review comments on that series.
> 
> Commit ca580b034380 ("bpf: Refuse to map an arena at address 0") tests for
> address 0 in front of round_up(), and round_up() can wrap to 0. Patch 1
> does not move a MAP_FIXED address at all. Patch 2 makes arena_mmap serial,
> as the other arena tests are, and adds subtests for patch 1.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Don't move a MAP_FIXED address in arena_get_unmapped_area()
    https://git.kernel.org/bpf/bpf/c/92b5ce3ca5b7
  - [bpf,2/2] selftests/bpf: Run arena_mmap serially and test MAP_FIXED addresses
    https://git.kernel.org/bpf/bpf/c/c08b50dd174a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


