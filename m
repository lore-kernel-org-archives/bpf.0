Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988EE22ACEB
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689669; cv=none; b=gx2utlKoTu0Cn9mXEQIaPRnlYB3H1hhZ+w7yrcuL0YysrIAGgzo4a09A10/7OvUMdnkFfh1UHykhmTNYCEkOYqXQdNQOIJSPI9EfhmN76WFuET6CxPKts6JNynoI/rmX+4kgg1SueA0dqmeydr6sWTu+ioVNu798NAotpq0DxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689669; c=relaxed/simple;
	bh=TX0kYo3IPD/QDmZb26RHDvq8OAtrVLD5KqLuIxcLHo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVbQUixEBaGkiGpBNjrCw53TX4iYK13X8gOpS7PbaoLe2LKNYJ6TPHH1XZbEFLMIJQ2gBGSnMDIH46kmvloLm8ZrzaH7JdYumDzGE2fdrnZUcBGKiO8/uznFQNXwD7jV1tYaT5Do++RV/lqOg5P0UinehsLDEqtZTa8OAPp0FeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0JDUJgr; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0JDUJgr"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-366087480d8so6320876a91.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689668; x=1779294468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNDcBPQNCRGE0nvZJMYBPFPscAWzaS2iHrcSd/IVAZo=;
        b=Q0JDUJgr1IiwmXruAxZjqKQecXrgaramfbdYb6TyCRSnX35rhM1hEXBpza3ln3YcQu
         bNkAbvjL3sFUMBimC5JSWwETr7kpHHYGzpUOrJRDhVYQSQyNprrd6I9lRdKoxP+Uil5s
         jnx3CNa2lQhnbxPWHz72WA802Wbrhjb0jjSwUyEyIKKRCM7o5xRkrz7DovAB1JWnb9IB
         GWjlf/OItP3rfeFHiHoA/9peJON23piw+1NNC6A5kWYeSG6CdCubXdQq0KCKqwPd746D
         7cOEGhtppV/sJEVvkcKMVlE/z7gaA/8zxiPNoEdQq73vjaNpuxqJsBHZoSlWaDexRZts
         MpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689668; x=1779294468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNDcBPQNCRGE0nvZJMYBPFPscAWzaS2iHrcSd/IVAZo=;
        b=SZ8g45B2iXNANvJugq3g3dh66EEe3pHdvY6Rwv2i6tp76oashhX3jMD1bXucbtsskZ
         VHxTBPEZD4gCpXbI5aa4YXawx1jIApmIzLmxBZZIuUKGzbe5jfOdifZkrGMB4mhn3uTJ
         pKOyUeAe++SsWk80Z12pfJIx7kxGjeNXKrhjFoS/XjaXxutN6SIXvpeoS5Ryvtg4qYv2
         ADr/Dft9egAXDAwYMCbjqMdRgm8LhkCa3k1/c8en+DuK8SS+WNuaDOPp/ZjnlHr6z+5e
         CHRCapVrcF6LjVewkyips+tVHV9htnPYoRKEVBEqrwzg1Eo103WLt034TQAoRMVfqbJh
         519Q==
X-Forwarded-Encrypted: i=1; AFNElJ/1xMENY8CPwYbLe/0zij9qQicK5/XEEaisFYMPjsl0hnD6OeIJiXnhoJYyyvG33pHvGj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfexEfEhksNAyJ+YAr/HPzsCZV5pGaxcacBTj9WBPbznXKAtH0
	Lv9ZXrXf1FrvHgqIhvGALactKi/AYkMLkZFF1/w58yDNb14pMWR2uiKu
X-Gm-Gg: Acq92OHRlm+w4fewXSZYvmhnJj5wtgbolicddaY+u2zHZX5ixVqaJMtPDHNrpCQUtD8
	IwgKbW1MMEhw5zpyZIWNi9CGIAYJQxCWhbeXYfPqvu5+raW5VN1ERcjgTuRxScvxyO6RXbhcqqq
	aDkdn5fs0mrDht/XCDfDpJZ0vKYye7H6lQp9kW6GXFDETQx1PqSdcKOS4ZME+nCa0/YkFDAOug2
	B23Y3NH51n6qR2kePf8NINcYiDGmRjOVADAc32ADCqKITs8cF1BDmLgff47DjZQKXdgHsxIi13w
	oAkBMP6EKndTAToR2dTdMLqn2uh0/dZ54CUYwUUUU5ILaMvc31sIBmVO7ieYLdrtHB0mEI5m4Qj
	mEn0BJjA7Kx4NaIgD1tVbELpqzw740WmacOqrRfSfAo4aryahv7tsLkN68E2pmO7GobPC0zgILR
	WyUwNfReP1EuK3+WM1rGEd3WVIDGs=
X-Received: by 2002:a17:90b:3c8f:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-368f2dcf4d8mr4396218a91.0.1778689667716;
        Wed, 13 May 2026 09:27:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368eddf4d84sm4342127a91.3.2026.05.13.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:27:47 -0700 (PDT)
Date: Wed, 13 May 2026 09:27:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in
 xsk_build_skb()
Message-ID: <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260510012310.88570-4-kerneljasonxing@gmail.com>

On 05/10, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> only the current descriptor is released from the TX ring. The remaining
> continuation descriptors of the same packet stay in the ring. Since
> xs->skb is set to NULL after the drop, the TX loop picks up these
> leftover frags and misinterprets each one as the beginning of a new
> packet, corrupting the packet stream.
> 
> Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> The main TX loop in __xsk_generic_xmit() then handles continuation
> descriptors one at a time: each gets a normal CQ reservation (with
> backpressure), its address is submitted to the completion queue, and
> the descriptor is released from the TX ring. When the last fragment
> (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> function returns -EOVERFLOW so the next call starts with a fresh
> budget for normal packets.
> 
> This reuses the existing CQ backpressure and budget mechanisms, so if
> the CQ is full the function returns -EAGAIN and userspace drains the
> CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> 
> Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xdp_sock.h |  1 +
>  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 23e8861e8b25..1958d19d9925 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -80,6 +80,7 @@ struct xdp_sock {
>  	 * call of __xsk_generic_xmit().
>  	 */
>  	struct sk_buff *skb;
> +	bool drain_cont;
>  
>  	struct list_head map_list;
>  	/* Protects map_list */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 3f1e590c855d..232dd7126905 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			xs->tx->invalid_descs++;
>  		}
>  		xskq_cons_release(xs->tx);
> +		if (xp_mb_desc(desc))
> +			xs->drain_cont = true;
>  	} else {
>  		/* Let application retry */
>  		xsk_cq_cancel_locked(xs->pool, 1);
> @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
>  			goto out;
>  		}
>  
> +		if (unlikely(xs->drain_cont)) {
> +			unsigned long flags;
> +			u32 idx;
> +

[..]

> +			spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> +			idx = xskq_get_prod(xs->pool->cq);
> +			xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> +			xskq_prod_submit_n(xs->pool->cq, 1);
> +			spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);

Not sure I understand why you want this if you're still marking the desc
invalid.

> +
> +			xs->tx->invalid_descs++;
> +			xskq_cons_release(xs->tx);
> +			if (!xp_mb_desc(&desc)) {
> +				xs->drain_cont = false;
> +				err = -EOVERFLOW;
> +				goto out;
> +			}

I also don't understand why you want to return -EOVERFLOW again? Why not
(quietly) swallow these invalid xp_mb_desc from the previous packet and move
on?

Also, have you considered doing this drain in xsk_build_skb error path?
Is it more messy? Carrying this drain_cont across the calls seems a bit
too complicated (but idk, maybe the alternative drain in xsk_build_skb
is even messier).
