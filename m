Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862881;
	b=pPhioP9P+JrDOPgNOGeJpOAtAyBjiicN7FLYGJWtlx5Itb6bJZibTYavQvYWaCHPlEUD
	 2fOD1wdYJACco0VHpNSGiDbqHOj3YLHlsyK4t8b/ovTDjC8bbt8zz3KBH6/R9yAkL0jh9
	 rCFv48s4idnEFGgRGP7sM3t6p0cDOoxP4mGgHzvkWpOmU8akql7KIMTwPDEGFD+ABwzAd
	 nR6/jM/UguV1wwod/ouQkUXjMagplWXjiVjau0fYnbO3LoA1bcNIxcqr+wZqKJDqJXN/B
	 2NKPIik1MTOahZEdW65x7avJ3hhai9D3O0T9srXPgCP/xhjNs5ePp1of7XH0Ow0TVWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862881;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
	b=krdW594wKL7mQqgLrIe1gbLASEjtbTcejRDYqVicIDi2mgqytb8IU3J6Pm1U4oMHGPnX
	 SLnG5yjluEmb31yw/4AyOpYTo1LRdRyc2OmviAgnUq6H4VLXCf/Rlqc/nD/cZJguQh42Z
	 /ZQ0IuvJ10ngPx1hNFH2viLKBjMYgD7It27vkXKU+pGENefp+jgI6OC+vVQZtam+bxrNW
	 vZpc25BdjT0ELKcgDLj/mACKRJfgVfBCnUulHW6RrJ3qU/NhIQ84mOffZFPBhwJ3+Uqx6
	 Cavtp1Fv0u2TD6CW9l4MLnyL9LBfdrtY4A4jnD92553VmV9EEjLK9r7UIGCljgISA6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKBMT1o3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UWmCt+L1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6B606A32F
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A6B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dKBMT1o3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UWmCt+L1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794862880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
	b=dKBMT1o3pok75IbnAtfRNFzoHBGFe2uVBFRUbSRZBRQbySlarnY7l63tlynX0NhmUg0v/a
	DJIqP6ax3+hU7fK9bHecxHIOMeerVWA6PKxGJSuDYcms5ljWC3CyQn591bjL58X4+P40hD
	sCuER9X83KkOjuXcw8wcBYBs/d92NKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-fxV8AJfONrOD6cSVds9fCA-1; Mon, 16 Nov 2026 16:01:18 -0500
X-MC-Unique: fxV8AJfONrOD6cSVds9fCA-1
X-Mimecast-MFC-AGG-ID: fxV8AJfONrOD6cSVds9fCA_1794862877
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so20144035e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794862877; x=1795467677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
        b=UWmCt+L1yLojGLi1JJPb1er1CIug5BOIcWzK9D6Ki1BKVE5blUkly6BNf8C/uhOpPn
         OeRlOd0MItNECGd4XYpI9Xhq7vpEE+XXYjG4Q4OQ9xuusdVvzgWsiKzgmwh53AzNbb4k
         4SkvDtvRNqySsS3I9KoQVuqlf+35Jltx1PqUQySH46UOVT3C20wD3OAXVKvFKXxe6sWh
         PS/fRs9lniuiBEcaLoflMIvKXU8K6y8HV92M+MBhgu0qgFvifZIG4EEn9qokPEbFXnMh
         8bHHzTVNSZWTIn377zoLSKga96oDcjGBWFWDXMe3FUPVawEV79s+/uAJHzCy1pAgZkmu
         lZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862877; x=1795467677;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZoIL09apRESCSVy9LvCJwT2nl+8SSwpAsQe0tMlFOU=;
        b=siQ+a7m4RxbUOGQO/PUchCA8WpjOKy7gNaFVqGoZJAgDXPSgNbuHrcTwUAibzjLabe
         sSsSXPTtOojvAkQrH0SV2AnH2WCP5S1qMddPcOJa6/7WfphwHKSD2qyJqplNpoBdm/e5
         Wh3UHOsd4CwyLvcdcH/jfBvaT51NhaoMBg1rbaO12OAYQcQEenxXj5ilITroNaJGMZ1U
         BEgVAEaSnXGd8rJWEuUWrDAyCkBoYW23ExUw/PLAYF/b4WylfCKmxoo76T+y9DQ0p4qQ
         grJVHOuWe47ncvjimxypRD/DC4qCgNoH8hXViyN3EmU/6XmtFvR3DfTPCH7K76H1xXrf
         d7/w==
X-Forwarded-Encrypted: i=1; AL+hErFtGfKcQcFdv4s2iInHf/U+MDXOdMLWLACuXliPs50MqS9AhQ4oO7BJIHn9/sLsu9K+jas=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MxNyGJnfmxIr1FWQguSGU0Evly7Cfli2NlEcs0cysMCyndJuD
	1iGB8jCe7z2Byt5hjt3xaMNXOVKkNldFBUjR5bwOovhMQNr0okOvHYlPxgJazLTe10XO7jPKJgZ
	UpOcKq59dHyaxv7vE+a+awg0gVekCId73WMaEcCgjmsDa3DBWtEGJ2w==
X-Gm-Gg: AYBFou3IhQq4U1/c2Mag8X5a2/oeEGaEzKOVJn/22dXOfBod+iyAge6YTy9bDi3QLr/
	E8kXbk/YXxCpod7QJu6/hPuNilTJmptOlfhzxNB1cyhhmAWY9Pv5cuQVVgfSuCbuvqpeOCryQZW
	H/r8tlagQGzQXM//lLhAIQnNve/GBdTKrXN0g80YsIfgd9q1xt3qvrorU/GGmIYWDix3GOG0zi+
	JeAGgoCVE1uZje0mUq1KfnC9s3iNdqjbXrWlLSy+J6KwIMN+CIvfjVauiaQ9CnDFLPr1/LSZ16z
	pAItNOYtZ1qc32U5ukBifUUcgpRwlkKP8pHMDyWZJyZAPhvkaOQxPh5ZjfisN0QQWaRmOOIhQ+N
	ueh/nH6qqr1ft2bfSTUVbB534xx46FKJLgOBTyqRJ0g==
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr166278255e9.14.1794862877115;
        Mon, 16 Nov 2026 13:01:17 -0800 (PST)
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr166277685e9.14.1794862876566;
        Mon, 16 Nov 2026 13:01:16 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7813fa23sm22454295e9.2.2026.11.16.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:01:15 -0800 (PST)
Date: Mon, 16 Nov 2026 16:01:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kvm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next v5 6/9] virtio-net: assert header sizes
Message-ID: <20261116160026-mutt-send-email-mst@kernel.org>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>

On Thu, Nov 12, 2026 at 12:19:38PM +0100, Steffen Trumtrar wrote:
> The header is cast from skb->cb and from device buffers, so its layout
> must not change silently. Add static_asserts for the offset of tstamp,
> the total size, the alignment, and that the header fits into skb->cb.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  include/linux/virtio_net.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 2abd8a614a23f..e7776a37a486b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -29,6 +29,17 @@ struct virtio_net_common_hdr {
>  	__le16 tstamp[4];	/* le64 TAI receive time in ns, 0 if none */
>  };
>  
> +/*
> + * The header is cast from skb->cb and from device buffers, the layout must not
> + * change silently.
> + */
> +static_assert(offsetof(struct virtio_net_common_hdr, tstamp) == 32);
> +static_assert(sizeof(struct virtio_net_common_hdr) ==
> +	      offsetofend(struct virtio_net_common_hdr, tstamp));
> +static_assert(__alignof__(struct virtio_net_common_hdr) == 2);
> +/* virtio_net_common_hdr must fit into skb->cb */
> +static_assert(sizeof(struct virtio_net_common_hdr) <= sizeof_field(struct sk_buff, cb));
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>  {
>  	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {


Waste of time. We know how to maintain stable UAPIs without this
kind of stuff.

> -- 
> 2.56.0

