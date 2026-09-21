Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB41442F709;
	Mon, 21 Sep 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993956; cv=none; b=ZCeRxOZz5JdsP7ze2Mg9zRXbh9I4EOCVq+riVdiQz0YfZflAhky0a4s6rBMYyvscVYmX05QKsQ02f0MT9JRvmcyapLfJQ5YS1UZlv38/JoLAK1MxzSze4ZSYLSGb1VsxtY9kRFYNrMsz0CRYleT8TJegjLSwL9E5K+q/kILpjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993956; c=relaxed/simple;
	bh=2IG0QG+r8CgOn2v+pNiJiMGTrc8Cjeah/exqAT1s+go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWrN1oe0G8sGemSka9OFfJFpX6ROIi3czJ1C9MaVkKeUkP43G5gCFc7LN5ykXIwfbCHEiP72mHKJTQio0Bsv3DCP3bEOp7uRrI7DziRZl2fYSOZi3yC2DBqvQjK7lHRn1g69OobKMr61VTgb/7jCOC8X/69aZo/NkHQoOvBkESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1WTWXrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1WTWXrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F0B1F000FF;
	Mon, 21 Sep 2026 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993955;
	bh=WK+5JD3aUCohiHM5k4NLIXR0LbkjGu6NUYd2nH0TAxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e1WTWXrf5sARik8mELVx585UBQ5WHcnwZ2AS3naeLjrZ5Eyk+S/1KjCfWN1XJUhtq
	 YLMfPxZwWfrMluW7WHP9htk28pwftFhEg1OMZs3J57HYwTKnVzYltoMKCWnmtxIb8G
	 3hn0raohIf7EIuL7lCc962yZ5CjAviJisEKhSszA7ZkDLbjX0NNgeIm1FXOY7/TvZB
	 JMTTmRXBs2AJmIAKe0ffEKQFe4hqvoW9DE+OH64kYw5yppHrE8yl6f4y+pmsXnjA+L
	 4M1ysb3dsAx9StE9Vnru3RMf2dfFBNAzMh4Fh6AaMA3ZflfVUJbtpGqU1olqFF0fvF
	 Nar2/gGMtpS4A==
Date: Mon, 21 Sep 2026 13:32:30 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net] net: mvneta: clear XDP pfmemalloc flag between frames
Message-ID: <20260921123230.GN13925@horms.kernel.org>
References: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>

On Sun, Sep 20, 2026 at 09:55:09AM +0200, Lorenzo Bianconi wrote:
> In mvneta_swbm_add_rx_fragment() the XDP pfmemalloc flag is set on the
> xdp_buff if the page under pressure is a pfmemalloc one. The xdp_buff is
> reused for the next packet and the flag is never cleared, so a pfmemalloc
> fragment in one packet wrongly marks the skb of a subsequent packet as
> pfmemalloc. Clear the flag in mvneta_swbm_rx_frame(), which is invoked for
> each new frame.
> 
> Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

