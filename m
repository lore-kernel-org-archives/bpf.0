Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC003839A3
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598444; cv=none; b=YyyK7mA0///qE3EAS1NCdMOkixXdeA95Dqeu3MsDujiEa9oaKR1/B6Aayb7JRofLQsbpR/GY+7z9HeEnL7EKm4SqwUMhlkooIj2Mul7B4aCOKXRxeB/U+efE8cUbfGFTIixcm1OpQctJ7YLZlXjIbawxMnmQee2l0i0bCJGpZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598444; c=relaxed/simple;
	bh=4xRrO4B3e496ASKCjYqD1h6zJkGdEI5e3kThLtCQ6YQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EsAsJWdq1/G3p5WalIQLpkIlRb4cFprzKtIidtg2FP0N1xqqLWkpJGWZ+jL+Oixlo8uqXTXtmGZ2ZaR5tXjPZxcyUFlK+dCNDVz68cCU7By/yQsCE9wc3hO8hEbKwezsFFFwCrNepCuWpPFrpKMmdKM5VIG76Ysmo+CWgLiHywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imY7tu4d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeUSm4Sz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imY7tu4d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeUSm4Sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790598442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8lg97mY9vEh51cxwOINZ9ICG6PIesTeP5CKnCi+ODo=;
	b=imY7tu4ddQrXUIbs5/FCslhbjmVfSREPkM2RHqx56T6/mlt19u3zvJD538OjKBYf8vLNv/
	QWSX7uQeRKGfjA01eDRCtgcHXGHQr5kX/h+n5a8/7XYrkmsqy75AUV9r1hEo/rEU+jpTpB
	2NJEbA//9WWudaOzpwBB+Yy7JcOqEgs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-HPkCfMRyM8GfUDfoQ7i9Xg-1; Mon, 28 Sep 2026 08:27:21 -0400
X-MC-Unique: HPkCfMRyM8GfUDfoQ7i9Xg-1
X-Mimecast-MFC-AGG-ID: HPkCfMRyM8GfUDfoQ7i9Xg_1790598440
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c251c140b41so283899066b.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790598440; x=1791203240; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8lg97mY9vEh51cxwOINZ9ICG6PIesTeP5CKnCi+ODo=;
        b=aeUSm4Sz5VH4LWTFlx+5yqTgKQycXxIdn3sI6i1jHFJgBurCzlXqBGpIlarjtDrfN2
         jP96Xv9fXopVWpwmDNvaTzoOSmZk2qofbxGA1prw9DgrEdlxv4T9jZCqnZX8zgquwrDQ
         AKAbbcNJMUKjsINS5z9Qf4D/2tPc30alvP31U/PJY5XPxU1D+NckbG6k1j0oESvrG7AA
         2nzy1+xtC341wclpqtawrnRXckxfJNpamcmG+OILBPGGutXOg4XsBVqQt6gFh5+nbr4Y
         lqs0Mym7VkU2J5JTO5vTIUKKoDiUO4yntxnVc+fIPb5furLWyD2g/MY2lbEfNWe8OtIP
         RZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598440; x=1791203240;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I8lg97mY9vEh51cxwOINZ9ICG6PIesTeP5CKnCi+ODo=;
        b=hgRK3P9jnpdax7b6y1uUBVaRjTBf0AIBoHfZw83yZGpDzcjQIZhKOz0VRAFnRAFrO0
         ky4FkSR2dIok84C0TluKWaUpm+s2ai596lIwEMW7MwJQjQdEFeqI4+mUukdm2aP7raqz
         aimsBh/81igWXtifZoFFhXDtV+gXF8nfDD1xqyjKpO0PEwDG57I71JdVyCDAttBg6s2M
         qmqyFKlp0RkFGaVx7YUFRi/uDRM1OhMIdJ3wK39BwnO7docCEmJwjHaM0+Gn8gtJQszm
         z6o4qOLlFJmulODFZFcIeMQz5ynVTWo0RuC2xJHg4tkjLBfaDWUZxQQpberGkZ6MAG/k
         mhVw==
X-Forwarded-Encrypted: i=1; AKwUvBxHYHD6V2728fSRbgj+1+LIxe4KepwkRx2XVjXMWyEsN1DM5moXSWY052BYTHUW53iVxOY=@vger.kernel.org
X-Gm-Message-State: AFuF++lc4Fs4r+Nki0kCzmfbSgDWspIgeQGGxQUoKOOqfiyr4HYdqRuC
	x7FNJ0TFDMc8Z0AjnD24G7fdnmowmwpn3JXahV2Sj26G+7rGgNLwJohRmrjVZRhQyUIwq9jBJcl
	gpEiSPCrF8ulL8py6i3VpStfs5ph5vZ9QUIhb8GToOv0BJoGKL/bdFg==
X-Gm-Gg: AYBFou3HFIxwhkNPo5I7c4j5c3BJI/nx9FPX48f/Wk0oH8afllQRNyZII4HRrSbc+jn
	5ZJ6QSl3h1Z+J3DpI/d8tayQiaY+7OOIc/weXebRcOO0rdNVrLAQcotx5hTOS178TCSG2BdyGc0
	tT0F725tDjyXbsaya3PSz9E+7i7a/DjHIS5u6v7042a+cNoQF+jZa0KF36E2LxPlF0EZwf7otUM
	r/3x2HNhBpL4pAgoOwVuhG9A0BZk6g5bJQOOr5Hqla74sRIRJMwFS2sRmRl8hoHzR9hIF1btdco
	FgR75mqtk9Qx+AuHkMY8v2Cb7uXQwtbbJG3+f1XPAEaPyswFzsvtmiEjGBJ0WXLBfwCrskCmK32
	rzpcmKzLT1Kt5wB/6BuJ+
X-Received: by 2002:a17:907:a909:b0:c26:1649:47b4 with SMTP id a640c23a62f3a-c2ac53fbdb4mr1041968966b.42.1790598439245;
        Mon, 28 Sep 2026 05:27:19 -0700 (PDT)
X-Received: by 2002:a17:907:a909:b0:c26:1649:47b4 with SMTP id a640c23a62f3a-c2ac53fbdb4mr1041965966b.42.1790598438623;
        Mon, 28 Sep 2026 05:27:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd380636sm274820566b.66.2026.09.28.05.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:27:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 504D9A0FCD2; Mon, 28 Sep 2026 14:27:15 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>
Subject: Re: [PATCH net v3] net: mvneta: clear XDP pfmemalloc flag between
 frames
In-Reply-To: <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
References: <20260928-mvneta-xdp-clear-frag-fix-v3-1-af4a51499eaf@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 28 Sep 2026 14:27:15 +0200
Message-ID: <87a4p1lfx8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com> writes:

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
>
> Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info utility routine")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
> Changes in v3:
> - Rename xdp_buff_clear_flags() in xdp_reinit_buf().
> - Link to v2: https://lore.kernel.org/r/20260923-mvneta-xdp-clear-frag-fix-v2-1-298693a7ea6b@oss.qualcomm.com
>
> Changes in v2:
> - Introduce xdp_buff_clear_flags() utility routine.
> - Link to v1: https://lore.kernel.org/r/20260920-mvneta-xdp-clear-frag-fix-v1-1-d7efadecf959@oss.qualcomm.com
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 2 +-
>  include/net/xdp.h                     | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index c2b1098d8d1d..485af7e395ae 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2340,7 +2340,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
>  
>  	/* Prefetch header */
>  	prefetch(data);
> -	xdp_buff_clear_frags_flag(xdp);
> +	xdp_reinit_buf(xdp);

nit: we spell buff with two f's everywhere else, so seems a bit odd to
have only one here...

-Toke

