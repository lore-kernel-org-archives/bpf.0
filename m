Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AD36DA0D;
	Thu,  1 Oct 2026 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815190; cv=none; b=Jq11cNu2/kQ8E7qg8Sys3m7p+4aeW25X0oRVRA9RTs15cOM/mnJaQGQStiadp/1pxYg79WwbZ931hxMHDbu1GrCsz/G7gpPW7RLoY6yVW5IjEWqla74c6+dYZDVLHPTKUeJ6WoRhx5kYUtm8cYlRdOP6bWweiJBcVzCH6R99jO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815190; c=relaxed/simple;
	bh=Gd4lvvpt3X7bAlSfOOhoJQzERM4MwEphcAay3ppxJ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GL8DqkD+KIjwp0SsE1HCh1eqE7FerTe11+S1MBuUSJSag+EHNBX+wUbnzvnxMszuaIIpiYymaT40SHI2c9cu+JtU5qumjRcFjH/w2xreEs/9p/drUE6atmcNWQg9yo0bLAnTQ6F9EoscsoarHJ4wmkoeLSc5KkjrMLhh0+wlyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzO6BvEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzO6BvEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FEA1F000FF;
	Thu,  1 Oct 2026 00:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815181;
	bh=041oBzfgI64A+tKnoH23DgkTlt/lOUEYReF21DM5gkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JzO6BvEpwbnQal/6Mc1BbUKxKQpPeH3wfpoLG5okliZGcC8cXIICLfBI6KDQ9S+Ok
	 qDjKrNFKWxLDd12CFsN3SV6aO8aEJ429GaghloKFoZWh8PZoPUyd4soNFIheokbtwu
	 sJrAERWH4woyvgxKwHWOQIdv8u1cvWFGDUPNC68ruKqlkqteaS0sPK/PO9tV2xidOV
	 gnYea6KDDnlvZ0NJrHl4uoozxgzxFpo/ysF1p06lnO2147xw47pff9/prtg0L/Z64R
	 FVk66XGiKuVa3FSPvGXbOlk9cRzlmt7Vkg52826tcDmiR4o45ADywLYiK8o0TWBNiy
	 WOhDQyCbhn67g==
Date: Wed, 30 Sep 2026 17:39:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between
 frames
Message-ID: <20260930173940.1c5f55c0@kernel.org>
In-Reply-To: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
References: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 15:43:03 +0200 Lorenzo Bianconi wrote:
> mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
> xdp_buff when a fragment page is a pfmemalloc one (page under memory
> pressure). The xdp_buff is reused for the next frame, but only the
> XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
> bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
> propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(),
> so the skb of a subsequent fragmented frame could be wrongly marked as
> pfmemalloc even if none of its pages are under pressure.
> 
> Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
> for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.

Is there a reason you're not adding the info sinfo bot is asking for?
