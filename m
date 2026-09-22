Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CE31E106;
	Tue, 22 Sep 2026 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037083; cv=none; b=jjK6rq+8FQBO+W8KqQuGS+/qg1CBpTxBpl0LaGXrX/qyzZz+JJaZYB2u9i3aUFmEpK5z+xJHfPTHrk+MN7XPzvDlP4BKiowazSava4EVsT1hG60T5xV6MTOzjitrFgpjhfTPrw8hwkCWPSlS3DJxyaMDQloa3lO3lpQ3htdubx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037083; c=relaxed/simple;
	bh=7eGzkih/oFYOfmlsmrbSElPCe5yuQnbB82es26iS1Q4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JeloM197p5Qu7jQD7DFq/VWl4/Vn/pJC1ijlUPewNBGgi3LCqc/eixaU/AfslIdhMPdSe0ry9NycqmkVwLyd43Ccmwcjw+28NtstXX+79QS6/S/WCXSFD31mVA7JuD6yg2gRAFOXukxASOAYSjxLbb6N5JY7XEC1H4Njg/FTjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8hgp2ZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8hgp2ZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769981F000FF;
	Tue, 22 Sep 2026 00:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037082;
	bh=6K/yuOFMZPT/PwXBI5lQ+Z+drA496B7MgW9TJJ7S/5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G8hgp2ZE+L6EqZ59IAG8P72C0cfhwad2mAzwxIOBMppqr06dfb4+C1VsMkXbV2Vuc
	 XUsbmq8qUxcTMXeeF3nzhc0mSkq4OGELI24w8oES1QU/CP8DAR0SbXLaDntcE5WgKK
	 rIAe1/+nXWgxpyVo0CwGR0EnlINlDN0n4hflfZxItgQDjIZ0Sr3Y+LQVlr5TFcKJlz
	 BStZoIBG1cnJooigV5LWOiQdffHUvtdEvHa40xtsFNIzknxVEaJTLwpIHqLBLEzA7Z
	 U5+X/aT9aFNyVuSb3bgnLgGchaVW3tTetv75qhNH5HZ5pFfYlsYCq4iQycDVQ/Vf7H
	 tDCKy18Imygrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1982B3930203;
	Tue, 22 Sep 2026 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvneta: rely on napi_build_skb() in
 mvneta_swbm_build_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003701364.3305732.7826222757373284122.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:30:13 +0000
References: <20260917-mvneta-napi-poll-v1-1-fb57604932d3@oss.qualcomm.com>
In-Reply-To: <20260917-mvneta-napi-poll-v1-1-fb57604932d3@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 15:22:29 +0200 you wrote:
> mvneta_swbm_build_skb() is only invoked from mvneta_poll(), the NAPI
> poll routine, so it always runs in NAPI context. Use napi_build_skb()
> instead of build_skb() to source the skb head from the per-CPU NAPI
> cache, avoiding a per-packet kmem_cache_alloc() of the skb head.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: mvneta: rely on napi_build_skb() in mvneta_swbm_build_skb()
    https://git.kernel.org/netdev/net-next/c/1643b81c38c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


