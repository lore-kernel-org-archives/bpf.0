Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB102E2663
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040798; cv=none; b=D7/bLVCtbciCHoeVHhbBOEq57Fu8VbXbu6VrP2GFksSwixjPymYYDaSnLnFeMIXsRO6IShvvjAPU05CiJaNL+u9y6IJFqzbfDZlz+JvXKdnSwrh5LzYybKSnjA1JujW7UyTSLJ2i24OhiyqGjoJ9h0sdinovX5uLhm/8S796vvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040798; c=relaxed/simple;
	bh=RwQjF5gp74MpRivf4d3S2U9VdDQkXPXaJDMAW5/Hpzw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GtqIUF1X1x/oJQbsA3olSAzejOyFCMuPpwgQjZ0qQ790Qbviac/CTrSwdWYhLnfXxasHILlccbor5LNB+S9DaXXEghrSRkLKDFjPJ0GJ3chYA6QbO6G0qTkvzhzwthHxsAgwcQTpCBRR4vBAPbBUfMqQk7o7lsmqwJz/Rp07VKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttd/2bSd; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttd/2bSd"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae3147so2624046d50.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040796; x=1790645596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ay4065FSvCY9ZRaYwz1DEwsmCGDvPHvVukTn40zk1F4=;
        b=Ttd/2bSd5NGIxyqMvAwb/7BTPyziMqL//NqakfFXG8bZsB80Rcydmd9yhbQ3KvQeJJ
         Wey/D7Bkdkmw8r3sWHl7+LzMAiAT7setx8n5lMSZEuoXCj6hTeYK/hQskV1nQVsB95ch
         MnKGJ3INOgHEcaH8SdZFPxRXnWZOu9ohk6pSRyYAa/ezCOOIKY3Ji+QtyKg+gmt3TZC0
         BLdS8xqLa9azi0jrvRA6jHe+kzuf0cVInDEZJqpDDzaWBUf9rr/7jk7i1coxu98IA3u2
         Ej7SnbNweNfzU7BPjile9+d5IPdIuMJ1pZHS6pnagLbW+KE2Mufe84/c1rkJgFfIp6v2
         HCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040796; x=1790645596;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ay4065FSvCY9ZRaYwz1DEwsmCGDvPHvVukTn40zk1F4=;
        b=IfXpZ0RhsoKd24knrn9dRuTOy9iujeKrXuy2Q1S8rwK6Sfxn4gk80sxCytcq8BSNMB
         Tt3SXjY7PkTGCVKMd5qOxErano7HQ6aShBpf41mBvgN/c9VxrR39xF5zrJv03qw6Nl8q
         qKfWP/hOKU4U05g62hSKra1YsygnVQAPSCu+fJzmoFCJpva+DNX8FlvQcKRXxY3qyn5h
         BQElxZB0vEspTmnCvSwQl57wNZwP4gnCc4piTqsia63JP2MUgM/OK4X7nv1I/9CiIxS7
         OWVkFlsN1NIa+dVmxDRN11pE8WKogRJgqNDz3P99v/9MmzKIZ5RhZic9q1DtpYLDfV0s
         jtQw==
X-Forwarded-Encrypted: i=1; AKwUvBwBJfRgUAbGtsy6JVZq1WUV5bk9HJsjH6bW2Jo0TyyVI4kfiKhzxTsMEgQCmvNlDz8nRK0=@vger.kernel.org
X-Gm-Message-State: AFuF++k4hgSRgku0REQGAA6nf7jCGFwtjNY3/hkrmr/GJZvAsQ6LrkAo
	ARjwIaUGAaYDPCdrXtIMw5YQUk9bivB5YFraIdHYl2B2dop+0IpcXKUA
X-Gm-Gg: AYBFou0+Q0fKLA92rOvprhdQ1APCyLR9TwkY33Tz2/ecQFvzc4uHHYzX+CzWeeABNz2
	uoNWFFvw6feJ7daZP9bjQA+z4anifNWJoxmpm1HXJRB3NHMVt9Mr3Uw9/9x6Sc8HKZqkLm68zff
	3w5VByHZdhnFvCKtbVkCOda2xyuCKsdre0VVtjrPrdOuRrTT7dRaf9/qAs7vbo6K7754ee4cGfc
	W5IHXGJ/b7dYDaUjx+I90O6aq4IquOdNlMx/d7OyLAq9/9R6FqxMjzDaJgw/o2yp8zDZEbolRI7
	ixoYFS1X034+1e1jr6mowgY/wSbTi4mInj6ivub9uCmtxaQj/VK2axFP1Q37HOZxf5lNaiDMcfo
	VJH4L3DvcGbsJsG7i62txnIWKGmnbqhcg66fSvXM+31jj8uZjHOuUjl7+eqFd83BEqoD3yeVIcR
	Ht65NI7w+hCi1TQ5hTxQ1ZWDAJR4D9Bsv++NqdGEesPa0Dp8mfAKn1yFo8IqkfhL4V70DORm4ej
	WNpDJxysByhudLsLJH63udQekgJ7y/JLFR/QeEbAWlKVKdFf58g
X-Received: by 2002:a05:690e:1c09:b0:672:b6ce:62cd with SMTP id 956f58d0204a3-672b6ce65d7mr1585414d50.69.1790040795858;
        Mon, 21 Sep 2026 18:33:15 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c768e6a3sm159526d50.18.2026.09.21.18.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:33:14 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:33:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.3b33970b82622@gmail.com>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-1-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
 <20260921-v6-7-topic-virtio-net-ptp-v3-1-3350851c4f88@pengutronix.de>
Subject: Re: [PATCH RFC v3 1/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> Add optional hardware rx timestamp offload for virtio-net.
> 
> Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> virtio-net header is expanded with room for a timestamp.
> 
> To get and set the hwtstamp the functions ndo_hwtstamp_set/get are
> implemented. This allows filtering the packets and only time stamp
> the packets where the filter matches. This way, the timestamping can
> be en/disabled at runtime.
> Currently, timestamping is handled the same for all supported filters and
> therefore handled the same for all received packets.
> 
> XDP packets are not supported and timestamping is skipped for the XDP path.
> 
> Tested:
>   guest: ./timestamping eth0 \
>           SOF_TIMESTAMPING_RAW_HARDWARE \
>           SOF_TIMESTAMPING_RX_HARDWARE
>   host: nc -4 -u 192.168.1.1 319
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> --
>   Changes to v2:
>   - update filter handling
>   - move tstamp into virtio_net_common_hdr
>   - remove new struct virtio_net_hdr_v1_hash_tunnel_ts
>   Changes to v1:
>   - rework series to use flow filters
>   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
>   - original work done by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/virtio_net.c        | 127 +++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_net.h |   1 +
>  2 files changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d39..ef6238cb336b9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -416,6 +416,12 @@ struct virtnet_info {
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
>  
> +	/* Device passes time stamps to the driver */
> +	bool has_tstamp;
> +	bool hwts_rx_en;
> +
> +	struct kernel_hwtstamp_config tstamp_config;
> +
>  	/* Has control virtqueue */
>  	bool has_cvq;
>  
> @@ -499,6 +505,8 @@ struct virtio_net_common_hdr {
>  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
>  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
>  	};
> +
> +	__le16 tstamp[4];	/* 64-bit timestamp, 2-byte aligned */
>  };

What is the alignment of the structs in the union and thus the padding
here?

Moving away from introducing a new variant of the struct with every
field is the right approach.

I don't think virtio_net_common_hdr was intended to be extended in
this way. But it might be the simplest approach.
