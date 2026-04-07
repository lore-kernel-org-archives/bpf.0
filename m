Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41913FEE;
	Tue,  7 Apr 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526640; cv=none; b=XuK9tT5DhVbpukMXKTwM20LEWAQNvVCGHjR+rOBv8YnSE9kULS4iGyTQ+mt7zibpWo7GzdsH2eIrBKCa6fGMQsdsUUpF+MOsOK/iBBWZrt2CScGd3pRb/eTiGve2i5IM8Jwh2On68rI2SRIwgqFm4MjK3e+nAjJNz2lGPAqoU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526640; c=relaxed/simple;
	bh=0obfm49yDlpcsgQJ7+WY11t9WRcyFFb3tzvnm91DD0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckD3/MAxw0ZPixR1u/7d6QGI1yF9o7OHQDw8b5RKriZHJd/+1cr83IcuLQSeMb2PHeMmTvQBtM3MM15VO3GXC9KTWiRfENj+zweronHxCGmOseyzk0BRFde2fK0SIuOYNTAjmTIjX/fk/Gxtyxr8tMNu6fCvymTfSUPS4PIQS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRI4K8kq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRI4K8kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD34C4CEF7;
	Tue,  7 Apr 2026 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526640;
	bh=0obfm49yDlpcsgQJ7+WY11t9WRcyFFb3tzvnm91DD0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tRI4K8kqGzf7DbS6znc1SF6rgSud2wS6iZLYnYZpwyEqtWL8wDUf8/eU7qUgxTzPP
	 7L3W+tRJwLFeJmL0DdE07cSBB6DUXsPyqB/qmGE8OwBKGPsAUnw9yiqP6ruK3eEBoN
	 AqdBJ7BsyszNaWM6Vjr968fTegQet58Wkje4oWV69tavh6V6w9QD+O+MlpLHBx8yPN
	 EbeTELELe67AHV0VLBAu6fy0Yp3G03tdM2H8R3mXwpQ6dwwuHSXa/kba9qBwVXJjLG
	 vBHtl98sETIwSClnh0qv8QH+lluCNm2gmZqsYRXvcWezBItcGrysUYTMxvG4jj0MHQ
	 h6uT42hPq/Ksg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0D3809A28;
	Tue,  7 Apr 2026 01:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: skb: fix cross-cache free of KFENCE-allocated
 skb
 head
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552661855.3337768.4891297868574815867.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:50:18 +0000
References: <20260403014517.142550-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260403014517.142550-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, antonius@bluedragonsec.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, kuniyu@google.com, mhal@rbox.co,
 almasrymina@google.com, ebiggers@google.com, toke@redhat.com,
 alexanderduyck@fb.com, soheil@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 09:45:12 +0800 you wrote:
> SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
> value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
> bucket sizes. This ensures that skb_kfree_head() can reliably use
> skb_end_offset to distinguish skb heads allocated from
> skb_small_head_cache vs. generic kmalloc caches.
> 
> However, when KFENCE is enabled, kfence_ksize() returns the exact
> requested allocation size instead of the slab bucket size. If a caller
> (e.g. bpf_test_init) allocates skb head data via kzalloc() and the
> requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
> slab_build_skb() -> ksize() returns that exact value. After subtracting
> skb_shared_info overhead, skb_end_offset ends up matching
> SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> the object to skb_small_head_cache instead of back to the original
> kmalloc cache, resulting in a slab cross-cache free:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: skb: fix cross-cache free of KFENCE-allocated skb head
    https://git.kernel.org/netdev/net/c/0f42e3f4fe2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


