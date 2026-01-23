Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4050122173D;
	Fri, 23 Jan 2026 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769133562; cv=none; b=jR1q8yJZb7nQW4YrPl2Bd29RZP+gQwAo2GMj3CbujYlUbROtVYw/9mYUr3Oq/e+XvunZHbGVgpSYIbmUicxkSqxXJbTHZBa56u0Aw8vgqrdsru1JSEm8OczUrY93bVTAuNqkUny0GWYKuy/MFguzTRLanCfkF4JaumP0BPnb2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769133562; c=relaxed/simple;
	bh=tuX+B1m6aVOnTDrES4Dffuzl97D9Q9bjlMnIuuT4C/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0qLcQQ07umKKWIhYU4t1vUFFUSjnGaIy/bORK7jZ5Ym5uIoeiZfigKj+3z6CTBUPxewC49RJdX6gwKN7Wy9YOnKZH9EbdtSRX/4Q+GLx5J/5Ds6zgZuzFU1045hJhdIUyL+f3UuA0was6evtoB7jCJkTRFQfIUSxy55zFzxKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVdF6Faf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVdF6Faf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F46C116C6;
	Fri, 23 Jan 2026 01:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769133561;
	bh=tuX+B1m6aVOnTDrES4Dffuzl97D9Q9bjlMnIuuT4C/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVdF6FafABPah3b7WO2A5H6uQXWkWolqAw/dHpXoWTbc6StKN3Oykd0bl1cd/oSqH
	 YAFTyFRuHDGajKV31nAzmM1z6+PddLbudDBmFkjChU+2KtkhY97kvCTvlbhBmSlMS3
	 8bjSNpUfUEecAH/3X2Ij94pNbid1GddnEpzTvXu+7xG8H+r7RiQlDB/zOhySbNh6nF
	 C1SpB6Rjzzv5nbh82AlIutVbKkBgRvGT0yB1WIzMPB/D811sy0OtBCNTaXvc0LifJU
	 Qbuw99LLUV9cQ2klnTC9GXle/aJ7hKJaT86kxmy5wb8/y2O02wm+ANY9TBnlHO54K4
	 t6OKoFHJe4MTw==
Date: Thu, 22 Jan 2026 17:59:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, carges@cloudflare.com, kernel-team@cloudflare.com, Yan Zhai
 <yan@cloudflare.com>
Subject: Re: [PATCH net-next v1] net: sched: sfq: add detailed drop reasons
 for monitoring
Message-ID: <20260122175919.590601b6@kernel.org>
In-Reply-To: <28911dac-6aec-42ce-9101-9071e18e1522@kernel.org>
References: <176847978787.939583.16722243649193888625.stgit@firesoul>
	<1bbbb306-d497-4143-a714-b126ecc41a06@kernel.org>
	<20260120162616.463c8af1@kernel.org>
	<412b91a2-15f3-4a5f-8f1a-249c9d79cb41@kernel.org>
	<20260121172155.6ec96ef8@kernel.org>
	<28911dac-6aec-42ce-9101-9071e18e1522@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 16:33:00 +0100 Jesper Dangaard Brouer wrote:
> > The kfree_skb tracepoint does not have netdev,  
> 
> Correct, the kfree_skb tracepoint does not have netdev avail.
> I'm also saying that I don't want the netdev, because that would
> explode/increase the Prometheus metric data.

Perhaps cutting someones reply mid-sentence is not the most effective
way to communicate.

> > so if you're saying you have the ability to see the netdev then
> > presumably there's some BPF in the mix BTF'ing the netdev info out.
> > And if you can read the netdev info, you can as well read
> > netdev->qdisc->ops->id and/or netdev->_tx[0]->qdisc->ops->id
> > 
> > It kinda reads to me like you're trying to encode otherwise-reachable
> > metadata into the drop reason.  
> 
> This feels like a misunderstanding. We don't want to (somehow) decode
> extra metadata like netdev or qdisc.  First of all we don't want to
> spend extra BPF prog cycles doing this (if it's even possible), and
> secondly we want to keep metric simple (see cardinality explosion).
> 
> I'm simply saying let us keep Eric's current approach of having qdisc
> specific drop-reason *when* those relates to qdisc specific tunables.
> And I'm arguing that FQ flow_limit and SFQ depth are two different
> things, and should have their own enums.
>    I have a specific production use-case, where I want configure SFQ to
> have small flow "depth" to penalize elefant flows, so I'm okay with
> SKB_DROP_REASON_SFQ_MAXDEPTH events.  So, I want to be able to tell this
> apart from FQ drops (SKB_DROP_REASON_FQ_FLOW_LIMIT). I hope that this
> makes it clear why I want this to be separate enums(?)

It really sounds to me like _in your setup_ there's some special
meaning associated with some traffic being in SFQ and other
traffic in FQ. And you can get the relevant information with BPF,
you're just saying that you don't want to spend cycles (with no
data to back that up).

I'm not gonna lose sleep over this, if you convince another maintainer
to merge it it's fine. To me having per qdisc drop reasons. When qdiscs
are *pluggable modules* and drop reasons are a core thing makes
no sense. You're encoding arbitrary metadata into the drop reason for
the convenience of your narrow use case.
