Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CF355F33
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446442; cv=none; b=s4vFm/tkpoXq00vZ1wetKqDawUq4kouF0aet8jltFgmm/5C4UTBYMKgwz0cdbdAkZfU5qowtYLxwaXnXvQT1+pNtDV9ml52Ep7yGKkj+jSxoyKSaIv2ZcMr540nvkZvqC53OIrPHbBp7RX9kGG+kI2zVef53go33E5DB5T6eAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446442; c=relaxed/simple;
	bh=ogz1Fu2a8c9OHV42LwF1nEd+HjHje1xFXcT0DGB8UsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g09sTH4tXPiJra282RZFbKxcPV3Tw5LtnpqmkrW/hifRHD+l43WOneK23nQIegABNw8CQ4Qwygc++aW2t7rzURnGAOXhgRDKWiN48E1Xj5zcG1pmOycaKbK0WLWXsS4uclbLaOKuyH/ZUYTeZMsTB1QFmENYdfQNQMXJ8BP6zZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh/n0wr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh/n0wr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1147AC19425;
	Fri, 17 Apr 2026 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776446442;
	bh=ogz1Fu2a8c9OHV42LwF1nEd+HjHje1xFXcT0DGB8UsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kh/n0wr0oJ3fkbjoP3F1t0yLLLtSSrWia5J9/xUr/Dp9/rJuxxMJ1T8ccCWTFuepV
	 yrANxytcNnTjgj8d1bW4jMNNe/wmrCDTqgZo5kNDUUxtpIouiEjFCDS12/7fPjW+ua
	 8Si9FhyWY6kq00SsMVFUH+1n2Ps2UDOcPKX4eBIJntyKW3RipHfXXaL8gSyts5gmae
	 +dPl93iPyW5I4LMp4aLgbuz6sD7C3qjn9GqhuIBAoSfTY57yw8NnM5u4GEC720Sugm
	 KdBYFbI2DFJezQxsHrlcgiZzhmfzYey877aWQcuXrs/ABoSJUNYUCiHkl/zB69ySST
	 uLnXUB/W3d3Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E6C380CEE6;
	Fri, 17 Apr 2026 17:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Validate node_id in arena_alloc_pages()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177644640955.76123.2613760344901893868.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 17:20:09 +0000
References: <20260417152135.1383754-1-puranjay@kernel.org>
In-Reply-To: <20260417152135.1383754-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Apr 2026 08:21:33 -0700 you wrote:
> arena_alloc_pages() accepts a plain int node_id and forwards it through
> the entire allocation chain without any bounds checking.
> 
> Validate node_id before passing it down the allocation chain in
> arena_alloc_pages().
> 
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Validate node_id in arena_alloc_pages()
    https://git.kernel.org/bpf/bpf/c/2845989f2eba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


