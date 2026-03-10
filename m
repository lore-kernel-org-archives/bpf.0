Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4726F2AF
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103972; cv=none; b=biPVY0H9c8ZqOm5B/ovtimeFSRBDj178yG6k0geCEnk76ij8W4EixrwM2gnMJAzkol/VtrdBVK6Rq3s3Ys3jg+KwSkk8Uup/z/v89Kmr6bWvRR7PQUEoNjpBSkM8R+VcF+15s1ZSAQpQ+UsJjEF2IVw083P6H/Z1IJICFioZGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103972; c=relaxed/simple;
	bh=1w5nYgSGneWv1fTGho3iHRUDa3qYd/rN2g5t0VLnMxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKnQYoIh5aMvATyuIvMDcRwEICO5iadLoLIVPHys6LgmNCjy6BsoVYfx6ov7LPK7mUF+azz/+L2F0dgwjOrajUNjQ5RELXzR2RWBt/69wYn2othGYT1Dd4rHiwRimoPwllj2MNfh5rPdgHWti/vogoRqOWTiTpJ5Nwngq2rFcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=l6w5cri5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="l6w5cri5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae50a33ff8so63313805ad.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773103971; x=1773708771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0KRr1g0bUXUFpohVfNcD7Dto+nX2pFoxhEU7JGJkxU=;
        b=l6w5cri5Cf6al6Yl/n09oTEiKqQL/4ssX+bf3J/poLvsRPixMCPP/o7Ic4UjdpakuN
         2TeZd/ml+tlpwN5x5OEkcXed195uIfEqCaXEpHenm/ZVfqzDCpewpRsZfoi5xWv3Ish8
         wag015fBSein9rQRPZpBJXwdk5lzqO6CwJPe8+IL+Y7RpDRYiMhJOwdPyYdkNhNCdm/X
         KXZGDi+yIhxu3v3pucEZ8ODl6Z8RL5aCE0/5ZEjSVUHZjB/d6FTudwkki2xtSMaOH+Kz
         SyJ9YayEToVgsOBawk18zPeELbT1vvCZTDqHcVGkaL99oxATX/MtTqKuo0cb/MtDihbP
         CoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773103971; x=1773708771;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0KRr1g0bUXUFpohVfNcD7Dto+nX2pFoxhEU7JGJkxU=;
        b=vWWCha/4hJQ7XPBX/VXIQh74CqdD0P2je8/QZVEZOSS7fA+etg71e6d89jNeJaZmKH
         kUD5np9dqTVH207uYKWqfZpjp+vr4clJulMrgBt3H9HIGnmLVajeC4L2XI1vCGmC3G7V
         KjcVPiM4j896/3v51YZOz9rJ/x5IZ1tu6Zk0Hih9Q1ZoXstULuuiw4bLu+ze8xdk6NFq
         GcgxLntCQcvtHwYrtGQU0vJcNuK9VRSdb0ULSnQL8wGj257nuJwmgqNZGKOuziC/5zfr
         v5y6ikylG2B3nTmxEQ/R9tYMlC4eIukl6MegB9FN/G78LkwTF1DHYvoXCWVQncIlxww+
         U8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBoWRnfBhafvmPL8IyFSwq8F+ZvsJtbldNNc9oUC3zqTnY5syiqo/YKwCJfkssBr3sHR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRB7X79Vr6JyARsg4ItEXddlXAyjTf2xe2KTlu6iFzMOEaiHdK
	sXzrwqVjOkWNPOtEBspYxAAODR+CVjeixa+HLzx2LbGZTAwo7s0zv+AdW4lZS9XFh0c=
X-Gm-Gg: ATEYQzyTwwVXTccriU7lw3+pEHb6qsg8nWcMIFwbEs2qKrhvCVQsNCtGyOic9ANdy8w
	rjf9cUM1D7/3bGsqx0Js36oB9crLgDdNAnlxdgpxxgKBfiyScSgx1SLhiO2BMw3IbDCNvXUsXXM
	pnVvLhi1q0RRC2JSk8Ew7AOzeyVxDcUZCXg3HS1ObqEZdhXUtUHk+6uG4h+ReewFZPCLAa2z62p
	lE1w7d5uxxQaw/6kh4JxOHOBEI9Io8Osi2PFuof9h6cT3Jh0yht33c6quUccI8Ns6nhmi9jBZ9/
	ik0buc3+yQf7bP3QSbcCMatVo2oAntJt2eL0RjcfXhRIoSfBlm4nveanamh2wO3PQNe1b64SFzu
	ne7Wfq/GaF96i4yuPmzKo+5Qs7qjlk6kjkQmS88ArrkFttUD8/6LVHL8Es3ieyplire0gAKT6mW
	W9E1o6
X-Received: by 2002:a17:903:3bac:b0:2ad:9edf:7fe9 with SMTP id d9443c01a7336-2ae82431ff4mr120993145ad.27.1773103971001;
        Mon, 09 Mar 2026 17:52:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e575f3sm171995055ad.8.2026.03.09.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:52:50 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:52:49 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/5] bnxt_en: use bnxt_xdp_buff for xdp
 context
Message-ID: <aa9rYfExRBUREZ6Y@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-2-carges@cloudflare.com>

On Fri, Mar 06, 2026 at 05:00:16PM -0600, Chris J Arges wrote:
> This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
> pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
> along with the completion type.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c982aac714d1..ab73aad40593 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2118,7 +2118,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	bool xdp_active = false;
>  	dma_addr_t dma_addr;
>  	struct sk_buff *skb;
> -	struct xdp_buff xdp;
> +	struct bnxt_xdp_buff bnxt_xdp;

I think I mentioned in the v2 [1], not sure RCT matters here.

But in either case:

Reviewed-by: Joe Damato <joe@dama.to>

[1]: https://lore.kernel.org/netdev/aacrSocsBAV9wZsT@devvm20253.cco0.facebook.com/
