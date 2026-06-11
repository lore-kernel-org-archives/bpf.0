Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E01E47CC
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166641; cv=none; b=QFTEvvRPLtkjtfAzxYOiO3PJXZW2bRtT/qr/mTKQF5dZAy+sTnytBg814inDMaiDEsHePIQGbEELEZW1qfk5VwM8kRTWsJpDNt/4WwkWV5PRt+G4CY/tBeyZzs1sEoUtklnaIdzpQiv66D2xnMkmsbbHjRLNqiJMnY47+4Eybkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166641; c=relaxed/simple;
	bh=XR0V+4h+8MJh9uy6euPn7a63rvq06PZMS77yDeSWSwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0adKvCXPBAdgZY7en/Z+ax5E9WC7A9wXA/fwjAGZQOW0DS5Eavuj3+xBsZted33DXpeAV/vCNmCg+fX6AZMSpkJ4IAj+FHrfYz3Rq3pI7IH0GYEvY1NiFFdEO8p2YT77w+vrOsPgNY2Tn5+VitOwsoPZzf9wyOPahgsnHh+HTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctDdKLeH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFevLNkb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctDdKLeH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFevLNkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0b7sev+YXar1BdsAXXs6+O/y7RGvS4oVWMa4UAvNR4=;
	b=ctDdKLeHJRLv5m4ouOEffdB3b8dMB1SYIaqvPfmg7+M+zZsNIwwCSEJbHGFhN5mdB1EbKp
	ckjha26x5ELzzLHrCMciBPGgESKot7uOIhfVmVYBR6qDKztklov2TKgRA+9hTYYBgv8SeF
	aOyX6yOsFDjV9gF/L7PtRMPzSLzqDMU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-3Jef1yJpNE2JpG8VPiYRng-1; Thu, 11 Jun 2026 04:30:38 -0400
X-MC-Unique: 3Jef1yJpNE2JpG8VPiYRng-1
X-Mimecast-MFC-AGG-ID: 3Jef1yJpNE2JpG8VPiYRng_1781166637
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c4f61a34so40432055e9.2
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781166637; x=1781771437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0b7sev+YXar1BdsAXXs6+O/y7RGvS4oVWMa4UAvNR4=;
        b=XFevLNkbb2tPXCzcxti/MwmkwoZL1FVCyYfFqjRoidx3forL6ayFkISRluyeI3VOL4
         nZ4MC3HZ4+5nwOTxeBihImXnsk4JOeR6dYziKuL0nyz7guzIWcathuGv4rqNf+jCbkrY
         WDgSOc9CUsSLWEqPD8EbYMQw7u6xdsThNWiFfLeXMDhCui5po1XTqRFt8XSDTBvpUBuE
         DAGcyesZ3jcAeqpjVfTBm90uBo/QreH+10Ct2WlOzdk1l9dxQw8DDKZWGBCJtDTBi78a
         BtzOclt9zyK/DM+MW9S03kH8Nd8o92gPlLSZs+i9yk+YMniYe8UK9RS24Zifbmn7lBC5
         5N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166637; x=1781771437;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K0b7sev+YXar1BdsAXXs6+O/y7RGvS4oVWMa4UAvNR4=;
        b=iSGJz9b6dDwnTJzCBLTJ2+uRVWHFTZ+MEX1JO5mMt1ZkqAaVy74GdmI0dfO72jW3vr
         VfvmMqGXXSwfThmTr0lPjtUvCUP4HgQu9Gflnrc+BhCGcI1+oYKLIE+ftWOPW13R4MIR
         FUK0MEIqgWIA7BySdsaF2alH5xDWltg/B90V39bI6Fu8cMjkQY7fjvjIjLAlote7P77/
         UOf0ZbZe37xqXeduUXDO+Zq3S0oTcikNzSubJAx8ncXQAC/4G3kpj926jA1yIrLPq38L
         zvOJGiQs44eRJRsTHbcTYTXe19aEYW12nS+oc4IsziK3JxjBuQCEXn6AvRB/DOF6BIpz
         E60w==
X-Forwarded-Encrypted: i=1; AFNElJ8wK0TVlHl2S/hoFrVSvocasdJLnyMNlHbSYLdF8K6NM1lUb82QXa27afP7KYUGxco350I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhyWWZIe94CRqC2gh1NCLzmBPnT0Xx4JwGx6Ss9UOTh3Ah0DP
	wGWaIfCOl2mL2YBQLYx/BcpiJzUal4EQVJ34xnIcnXYouUNsBhmf5Jbaiil5Vcenmgv9DYeyyXl
	vmEfjY2O6UsMM576srEWyjbc34w38X2ARRbwVHaY2mM003AzcPn8wVA==
X-Gm-Gg: Acq92OH+XOilRo5bAGQitD19rMbf92X3QrEGuLUFtOsDDhHTu2XMnRNge1N8o/tHv3l
	wtmt+ugCfnG0RS0xCYtVagrm5AZhZTWsZhCKMhO+C8oC7cPOOi0PGu2AVadat3TQaGU8kkgFaY1
	wy/HWXVELTUuMIYWpVrLNZpQYVARwgQTy0OqCuVnmIcEd1b/34TjxBs3pGRQZuWnMsj3EzW2FQs
	7o1sAxCWfjpmvvUmyGQJ3UB+OoUH0ZrlcFqFxFdyM+71QZluyvnUzqaynDj4KMPJuvHac82pfdV
	36CdULWwymPBo+n8wbk5k6omhKWN0PgkVv0DL+MZKhCGdHYi2o5CLfdnwfvQT8Y8hAgRCBvF9Jq
	NCc4pYeY2iV+Exj2kK5DZo4aVFBo8RNoxYmPV4FR6aLcPD46GnJoepJ0B
X-Received: by 2002:a05:600c:4444:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-490e534d301mr20585855e9.0.1781166636997;
        Thu, 11 Jun 2026 01:30:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4444:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-490e534d301mr20585325e9.0.1781166636452;
        Thu, 11 Jun 2026 01:30:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c9057bsm55175325e9.5.2026.06.11.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:30:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0F0E17BCC96; Thu, 11 Jun 2026 10:30:35 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, shuah@kernel.org, jiayuan.chen@linux.dev,
 menglong.dong@linux.dev, emil@etsalapatis.com, Sun Jian
 <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Run generic devmap egress prog on
 private skb
In-Reply-To: <20260611080850.536996-2-sun.jian.kdev@gmail.com>
References: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
 <20260611080850.536996-2-sun.jian.kdev@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 11 Jun 2026 10:30:35 +0200
Message-ID: <87se6t8ono.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sun Jian <sun.jian.kdev@gmail.com> writes:

> Generic XDP devmap multi redirect uses skb_clone() for intermediate
> destinations and sends the last destination with the original skb. This
> can leave multiple destinations sharing the same packet data.
>
> This becomes visible after generic devmap egress-program support was
> added: a devmap egress program may mutate packet data, and another
> destination sharing the same data can observe that mutation.
>
> Native XDP broadcast redirect does not have this issue because
> xdpf_clone() copies the frame data for each destination. Generic XDP
> should provide the same per-destination isolation before running a
> devmap egress program.
>
> Fix this by making cloned skbs private before running the generic devmap
> egress program. Use skb_copy() instead of skb_unshare() so allocation
> failure does not consume the skb and the existing caller error paths keep
> their ownership semantics.
>
> Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for ge=
neric XDP")
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  kernel/bpf/devmap.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..a3d6c60dbddb 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -512,35 +512,52 @@ static inline int __xdp_enqueue(struct net_device *=
dev, struct xdp_frame *xdpf,
>  	return 0;
>  }
>=20=20
> -static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab=
_netdev *dst)
> +static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
> +				    struct bpf_dtab_netdev *dst,
> +				    u32 *act)
>  {
> +	struct sk_buff *skb =3D *pskb;
>  	struct xdp_txq_info txq =3D { .dev =3D dst->dev };
>  	struct xdp_buff xdp;
> -	u32 act;
>=20=20
> -	if (!dst->xdp_prog)
> -		return XDP_PASS;
> +	if (!dst->xdp_prog) {
> +		*act =3D XDP_PASS;
> +		return 0;
> +	}
> +
> +	if (skb_cloned(skb)) {
> +		struct sk_buff *nskb;
> +
> +		nskb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		nskb->mac_len =3D skb->mac_len;
> +		consume_skb(skb);
> +		skb =3D nskb;
> +		*pskb =3D nskb;
> +	}

So with all this pointer soup and back and forth, the version you had in
v2 (with the check and skb_copy() in dev_map_generic_redirect()) was
much cleaner :/

-Toke

