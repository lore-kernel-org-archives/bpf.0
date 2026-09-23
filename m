Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4336D9EC;
	Wed, 23 Sep 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128882; cv=none; b=bxZj2tPOW8b5LHCAhOzGoLqjMSzF1KmgfDdt29PoFfL4kFNB8YSeUOQtYBh5ZFzAVXF7oGiAbLyrwzvgqg76OZcHZmswKLf/vYQrn9X6SuAaAtbDFwmWuKeAhCGXJIpdGMwtBEdQKCykItLjIImvPw0LkTlIGixwCzlrzSD05vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128882; c=relaxed/simple;
	bh=YvFaLsUtqmsYO+ZAszpIf48fZm/xegnIhAHLi6fG2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmvwnbEFWHQWDFJM7uYErNs8JoMfsvVQOk4otFIWovWaUD/A1PJwAh700soTDwAqI9OOoINVbBlndY44N5eyfHllrCHD6Tjc6J9I100vguGnseu8xo9IDqHSU+eH/70I7uy/tNz66oftwTEPyHc7DfVjWPP05ZEdZ5MHeldQBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXLUzER2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXLUzER2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687C21F000FF;
	Wed, 23 Sep 2026 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128879;
	bh=HWdpAGqTjJ6IJGhqY2h3nE877M+cJnTnjxWtvJsWKxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BXLUzER20RA4JHtTMsqVQWKlvhHFh4C0x7eOzQGrh/XmpdqhNqnvCRlhiGgCheU0S
	 6z4Ulod2Y+e/SOxDDgGkqBHodbtsQD671ygZuOphOcy2DD7y+2i8Z7p5ywpTEFqfdi
	 7Z00Szm62RwK/glkILHW/drf8pduhvj34B/6Y34K22QYw1EGgY4equzhhSCJL3vlU/
	 wAeo5A4hizmCB4mEezE/mXRIMDLVHaiM/Yah8aBNGYYqJ3iDaYQ6gChH5E33xxZ+V5
	 /DVEZ11eGVD2BIa8Nd195LevNQ56VtswVoNHiTQixwNxRANkqaeXWfrvR76ELN1ggH
	 qvgj5HuC1rrCA==
Date: Tue, 22 Sep 2026 19:01:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Toke
 Hoiland-Jorgensen <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: mvneta: clear XDP pfmemalloc flag between
 frames
Message-ID: <20260922190118.1f1ffb81@kernel.org>
In-Reply-To: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>
References: <20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 09:55:09 +0200 Lorenzo Bianconi wrote:
> In mvneta_swbm_add_rx_fragment() the XDP pfmemalloc flag is set on the
> xdp_buff if the page under pressure is a pfmemalloc one. The xdp_buff is
> reused for the next packet and the flag is never cleared, so a pfmemalloc
> fragment in one packet wrongly marks the skb of a subsequent packet as
> pfmemalloc. Clear the flag in mvneta_swbm_rx_frame(), which is invoked for
> each new frame.
> 
> Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 543e566425c1..32416999f3d6 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2341,6 +2341,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
>  	/* Prefetch header */
>  	prefetch(data);
>  	xdp_buff_clear_frags_flag(xdp);
> +	xdp_buff_clear_frag_pfmemalloc(xdp);

bit of a trap for your future self to clear the flags one by one.
Should we not write the flags to 0 ? Or maybe add:

/* Clear xdp_buf state for reuse on the same ring */
static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
{
	xdp->flags = 0;
}

and call that?

>  	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
>  			 data_len, true);
>  }

