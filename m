Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679780;
	b=ioLZgBfMH3jUPmQEYQ6+EJSj60dS+E4m3aD/QbWZ9DR7890xZ7OLCPtO+1hcukTA4EJq
	 Q/RqUVzU1TIrtfSZKprp3F8+G3zagbpeh0nNiHQ4M3UFBHyJ1I9IJr2rKfCA5pX+5av77
	 WY04rPZQKW51vl8eZYCqhQUCrsoZMYr+Jr3tbbLq0tv8G4TiOosmkLt8hpoBi66p3bqWL
	 jnhp8mZzLE2ds+A9EhJtEmJtb+qWKsXT2HlF8HQwE390UBdUHj/Vj398SRuAy2GYJcwhC
	 ErX3L8sJDpVhGcsQAYaL+wG5/eADNWgMxmK/zjGvmp7spK/GA3BsiFx5IBtgIm0cIvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679780;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Zp7KR/TTaOmH56UgO4iVbM4KLisFeV6A9K8Gnq9SP2c=;
	b=JRhJwyKUaOEcKuUqic3Z/p664ZfQyr/jHNhImtGHqXCDzGhBfx6f9n9uDb+l6jb1M4fZ
	 4YTiOD2LYJEoKwwCWDb/FtyYcYsWd5ljmtZjSG0bsuY0TKGraWvX2srHva05WejEA9vgh
	 SK97TBlVwBfysccA+xrX/4JVXdBGCmSa512e5x+7vMsfJzslReqNzMk8NgE9V5fRddwOZ
	 sH87OljGovdeK7RtYcXy46xuZ0QN7UTGzWsP7agWimwao6pJm/dDySI+k/06AIkkDBkln
	 kLb0fsYVzWD9cDzQ0uyGisF7Xc1hdo+NueaTt1FAH6UPzeYCmOge5oVJZDLeVGHGYJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wopqudTI;
	arc=none smtp.remote-ip=95.215.58.151
Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A56606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A56606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wopqudTI
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hc7O1kDVjwwjdvW8dTk23z2Y41qPruXloCw6mIwLNgg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795679777; v=1; x=1796284577;
 b=wopqudTI+GYAMTvbtvkHUvwJgyGDz440Xkvxa9G/BUX9txNM7C6aTMqZti2yNeiMB1x4ADGu
 k/svzrkGTP1csJ/brMPx9c3qE6IblIU1TNGnoqKXxVYuP2YccYO60nppwztoSxSEgXpD9DK2ZcZ
 fg5uNUF8MtHUClaKEWqT/bNU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 0c367e1d0eed308f;
	Thu, 26 Nov 2026 07:56:17 +0000
X-Mizu-Trace-ID: 0c367e1d0eed308f
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 15:56:10 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: netdev-bot+sashiko@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: check XDP support before enslaving
 changes state
Message-ID: <20261126075610.GA33976@Liu-laptop>
References: <20261124-bond_xdp_fix-v1-1-e67983924324@kylinos.cn>
 <179561592046.3135.4020262152427481394@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179561592046.3135.4020262152427481394@kernel.org>

Hi,
On Wed, Nov 25, 2026 at 02:12:00PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).

Thanks for the review.

> 
> - [High] bonding: bond_xdp_xmit() checks ndo_xdp_xmit instead of
>   xdp_features

Ack, I will check the xdp_feature instead, thanks!

> - [Medium] This patch fixes a kernel oops that is self-contained and goes
>   back years, but it has no Fixes: tag and it is mixed in with changes…

OK, I will split the patch and post the xdp_feature guard to net tree.
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the XDP
>   propagate failure it keeps on the late path can leave freed memory…

This issue is working by Jiapeng in
https://lore.kernel.org/netdev/20261124024319.52145-1-ljp1205831794@gmail.com/

---
pw-bot: cr
