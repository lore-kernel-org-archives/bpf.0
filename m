Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDF321F5F
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724083; cv=none; b=sWg9tP6cBZ3YQ0qR20wspblcEaAHI8SCy6W9oy6KvdIs5rKEfIBLdMSrlsIMjEZM51PrfBj38Eq3AjxKs1fuJR1fEiaL+H9IyRYG4OWbKIQ0YzTW201Y5nXcEIqdpAiK5GZKqPcLDPrQVTxJ2N4nlv0XcQ2BdIug6eKt4yVEEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724083; c=relaxed/simple;
	bh=eHQC/1uXNqG8Cq4bOsObpnrSbfAgHkc+3G/800mPjiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2jtNHlmpYGlaqhkH5d2JvkrC4CzKrkD5VaqjXfSmwXyjYswIuacZR2hV50C7HF7sjOFoszo5ODf2i4n2TblaCOkBgcp2DWjaLFRWNEZprwXEKL9unXBRnXPlHKF0p9Fmu9kAirVHWCCmdoSEsnn+J9fTcppThXAc+EAAHrxUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfGfLXUL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mXqoyKXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfGfLXUL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mXqoyKXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EN/yPGhkQUnfeD5ks5Tmc7VGBgpgQUKl1WzPpgUbvpA=;
	b=KfGfLXULk/vmtgZII3gxuHZh0XQhkzmp3M9PUVGLuXqihpPQaSry9kVc/gm1urN9r/Y50V
	y8wLuDSqZ0izRIvwRgarsfBqWGPP5DpwVi4zC9xzMmR8jiujwMIxd0EKEffD48Mn0voLpY
	MTmmarqdOau37j8p95VFaXsWmRQV3Dk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-dL-6J6q4OZGaE42nnAuVyQ-1; Tue, 10 Feb 2026 06:47:58 -0500
X-MC-Unique: dL-6J6q4OZGaE42nnAuVyQ-1
X-Mimecast-MFC-AGG-ID: dL-6J6q4OZGaE42nnAuVyQ_1770724078
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee432070aso38587955e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 03:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724078; x=1771328878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN/yPGhkQUnfeD5ks5Tmc7VGBgpgQUKl1WzPpgUbvpA=;
        b=mXqoyKXYO3ZokWXOQMG17Aext+E5IK1OrJwT+tQdQPxAi710JxMbJR3Lrqc368r8b8
         l9hnhQ41JVttqsPKl8mYew5YC2nM/LWoCuHeNqkeUVELfeRxk8w2oI/zLIH9f99ymcT3
         IFlovsf6tpA0knD3we4NfBtutsa9zeRQHybo+qdoSShWd6ao4Unh8Yi3p08ggz9k6zxN
         xY1SgUVXSK4xMDhfjirEr0EKHlcm7Ek2pNP4ovGBAWe67cA7fFyXAy3LsvkpNPh76aJz
         73hkn/u0Ij3Cu5r21ZaQt0xrt5coiIepu5Iwewv0qgfBBbRVoPtjjV4jP8oCMwZGGiAD
         /PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724078; x=1771328878;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EN/yPGhkQUnfeD5ks5Tmc7VGBgpgQUKl1WzPpgUbvpA=;
        b=wqv4w1NgvsbZqxjjTFZ4O4v0ib8lLieCK5KVEtORUtjVGgv+uIqG1D29QhLJJ2ZsLU
         VDQfgpv+eftCTD31B6srYAHvWA1BSL17EdkoXZfOKgpDakUKkrWKMFmytUEHVZdNZYiR
         lgk9lkjbTPob69kLKUd2EH6sf4+jvoPDU8E1odn5puUKWRb/me38NMWsIo+dsvqYAEm3
         77W1+ndcndjfVUhl6AJleypN8AiKMxcyWp0ZOoW09z2feTdVA2UMubigJq/CtGCr0vUd
         XXSDV4+KjdBQlyZdpaWessfAB/C5Nr3fdl7J6ycrqAZO3NF4QcmNmQIGPboBS2Al1098
         gwLw==
X-Forwarded-Encrypted: i=1; AJvYcCVIwqvZd2sdccwwoF0sZl8Qx5ywK1e6jm9bKfd/2zZmFwsEhEq1dXckfDmfhAyfQBs8g7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QCTV3d0oJ99Dwa2MA4HS2sFl4feXOYTKoKmW8UVp08gMe+6B
	agoy4e2+28GsZRUbJKdKD8N0bZ1nuTasowLh8766qGl42AhMFxX/V69xaHLgBPEOubbS4t2WWa3
	W5aR7Y8ZpJR1B/NZ0ylBIUXVew7L/p8SIPg6zWrQf7SVvKXjwywbNag==
X-Gm-Gg: AZuq6aL3akxmykSLSJkluqFDTwM2F2zusVnOWA6HcCRpt7cfLeN1Ls21GUJkjEnVG2s
	06H3+6jBDxGcL7lZypmBWSYhIZIAVnUqKtTFr/pU2EE3/8N8uuYiYw/BDyqrMlFjO9zQCi67Jzp
	Y4CL8IX0o3MgrefSuZlvitg4w2wYRpJHCLIjcikiWaK3qBPV3OqA6N02XTxB2ixlkPkD7aYbqyQ
	bdBa99WA5j5Fm/Lef7/BRR6J0l+GeXhJ6hS1CyknM3LcSFuBJnj8rl3dEB1BnmhYqBcwu/KcqeN
	e0Tvs2l1XzdalJNUfAghpv84K9xBszSZL5eC8PgOXaUcvc+fX2UTdWjlZJdIwEyT1TjXan+c7zQ
	OYYr2X6rD0I6xxH8H6zOhmNU6gMaVwhBMNn5i9MeoG/A+SA==
X-Received: by 2002:a05:600c:630f:b0:482:dbd7:a1c1 with SMTP id 5b1f17b1804b1-48320226287mr213039525e9.34.1770724077576;
        Tue, 10 Feb 2026 03:47:57 -0800 (PST)
X-Received: by 2002:a05:600c:630f:b0:482:dbd7:a1c1 with SMTP id 5b1f17b1804b1-48320226287mr213039065e9.34.1770724077144;
        Tue, 10 Feb 2026 03:47:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm31436401f8f.30.2026.02.10.03.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:47:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7BC834FE897; Tue, 10 Feb 2026 12:47:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific
 drop reason tracing
In-Reply-To: <177039506239.2258217.7863252279149995024.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:47:54 +0100
Message-ID: <874inozuol.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
>
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
>
> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
> infrastructure.
>
> Reported-by: syzbot+ci335f183b8446659a@syzkaller.appspotmail.com
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

One small nit, see below. With that:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

[...]
> @@ -37,6 +37,31 @@
>  const struct Qdisc_ops *default_qdisc_ops =3D &pfifo_fast_ops;
>  EXPORT_SYMBOL(default_qdisc_ops);
>=20=20
> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
> +			struct netdev_queue *txq, struct net_device *dev)
> +{
> +	while (unlikely(skb)) {

Seems a bit odd to have the unlikely() here. I guess it was originally
there because it was an inlined function, but since it isn't anymore
(presumably?), does it really do anything?

-Toke

