Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE073DF001
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225569; cv=none; b=nsPhtd56dmL49qXpTnq19sb2zmCxMgylctGesRs7YpXIVZ786h+IZ79LMt0v/wFsFTZj/8HQgmXYVV4krlAFgQSljNrnNlgZFlX2iwJQVWP6yZzHMhkIPGjcd/qfEx99qL/5tbPttGaLClxZn0lF48EhlSoymTKzngkxwLcVovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225569; c=relaxed/simple;
	bh=UUMVrupYqfa6TrE8rAs70lwrwBL4CkqVSxIZ3LZgMEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAEqv3xOQ+LfDNJg0kGGYyFBLMAeCS868EB6nQkHpy3UEKSNDQF3duR2h8jfBH15/kwZpM4f44wv71UdnELhXPNU8HyjF8cXyzRi8HljrJzigNKFqP7czs2W08LdiXSvu1ON298HlYct+6cfRR6EXBt9W43LNjqtDre59RAfI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXPmENsR; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPmENsR"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3699cdeec05so1505769a91.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225567; x=1779830367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2TTj68F+to+vqHhU98D0/TgvGyPhnpyqr7saUSK8Yk=;
        b=mXPmENsRuHumOvpalgqnY7I1YVN277PTZwc8vloEQtxMiKIEgpIaQVNzVSN360jB8m
         qc+uyLaxRx62FuDe/B1LhMh4Zt1Pc9yi/hGtIaxDKOtOQUuE3o4d9vbW4iIesIZkWcu4
         JyMW9LY5ULbYjEu2rBYMZFETV4kL1k3JS6DIUWDwAKwwsdbOgEbmbAKhu7ThIjdMx0zZ
         yltGtgThz4W9po57yQpiXQfksP1/Fk0lnt/TY1Yw2gVbzfu6r39tjTWYSyGKTdLccMXH
         UZbdnHQqa1IVjEZ3C5CGd8AKdndDX1FImINgzv4gH5ZbpQqbe+5TY3Ajm08z2iiyHkC/
         hcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225567; x=1779830367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2TTj68F+to+vqHhU98D0/TgvGyPhnpyqr7saUSK8Yk=;
        b=MBDB/E8nlHCLbbPiVHmfXK1SRqq09Mgb92FEpZ3rBKrQQaBUx5V1u3o5Ud9UYgfY8/
         AL6gaOoDw6Fh8ydXctqkpllABQH0qdT4OnNDXEhWIddvQWHdQn1n2Ah4nZ7U4Yj8xDVt
         Z2g5UGG1xLdvvgHj2QjKUUVyPG0vqINO+j4pAbwOwBBzaQ/26e6eKKWwEXgR9mInW2kH
         yHN63ur/7N3ssv5ckhPXwmdql/ZeZn9GrYo6/0KDhd/PxnxudD9fLL2PljV5vASBwGJN
         gjIFmbWrgYPh5m/FtKeOz+TpAs6NQtquAV7Pkzq1VCCIZyKYElglFz3ZgqcTw+wMPkrI
         5lsw==
X-Forwarded-Encrypted: i=1; AFNElJ9QbXZsKLTfMGEKhrfbKVGc4b7p8wp8cApIATvEpyqqTgNyHJqbUoJR3ORBPZeEoS5nuyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxKwrXZoOk6+mISRyCcZuQM+Ro9Z1FT0rVqgL/80ZivABOxA7
	zECRRxq4cj3Jv4EUkrTqKc8TvJUnqHrVI2fvzxdoAHFCZTDg6nQ+KWnj
X-Gm-Gg: Acq92OHfR/a55OXYnq0S1gOc/58RZV3DAkyQt8gkKF2DjhLtJKhFfsE21AtEUCjlWDk
	GyFVZIfOHX9WYntU9Gb771qw3StEBdCiBZZEwsmfpfII12U193WtFBtz1ePrEA+5JMsdY19mefS
	6Nmgqbj5Gbo5A82gXMGej9eReyWWz55hkaqeQ2T898Hbu8jbuLTPnzGsbooYGxs6FBX4+xsiTUr
	78lyVvP1F87I9mJmwWYlN9j/mJoeMMvthJOdL13i3zoGnlp+n6twSfypyVD/CgAu0AwuIUn4/+i
	lbyxYhnpNqbG3KryZxXBeu2vXWCyU2FP7NOdTIiRhxgKBmS+g+Pv6c9bJSAAkJlShdLp//ZafAW
	2bIOSPmnIHZ5Wu38bxWPTokH7VtIcZ8otY7iVWN9XeF/bkkrUfGp7q6tyrJ5zvp6s/s4YN/+8Zu
	0LQj+lCkwssZOz5nO0PfGenID2I7k=
X-Received: by 2002:a17:90b:3d0a:b0:366:479e:63a5 with SMTP id 98e67ed59e1d1-369518b25cemr20780833a91.2.1779225567475;
        Tue, 19 May 2026 14:19:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517aadb1sm14984388a91.9.2026.05.19.14.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:19:27 -0700 (PDT)
Date: Tue, 19 May 2026 14:19:26 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v3 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Message-ID: <agzTbgnDCd9DkPOz@devvm7509.cco0.facebook.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
 <20260517063311.28921-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260517063311.28921-4-kerneljasonxing@gmail.com>

On 05/17, Jason Xing wrote:
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
> budget for normal packets. This behavior roughly follows how xmit path
> treats overflow packets previously: stop sending packets when detecting
> the desc has problems. Here, it is stopped only when this group of descs
> from the same skb are completed.
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
>  net/xdp/xsk.c          | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ebac60a3d8a1..8b51876efbed 100644
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
> index 0a6203c42576..298194b7335e 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1016,6 +1016,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			xs->tx->invalid_descs++;
>  		}
>  		xskq_cons_release(xs->tx);

[..]

> +		if (xp_mb_desc(desc))
> +			xs->drain_cont = true;

Since you're gonna be addressing sashiko comment, should we also move this
part to __xsk_generic_xmit? Right after err=0? Feels like having
both true/false/check in the same function is a bit cleaner?
