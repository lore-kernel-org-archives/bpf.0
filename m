Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AA327BF3
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798977; cv=none; b=mI0t58Avd7Mh353Edcdzf7ZJbYFUJT3XZ8rKylzdjharyUMmM57ktwwOHLOoRd/3bvT7qAs4hmfvYtl6Mndetb4YLsb8kxhf98ZJkEF+OHfqysFasPBB2YzMXdSnvGGOvGYTiicFN/5AXZDePLHnDojus7hraLSaQQ91o3dvQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798977; c=relaxed/simple;
	bh=Fgvn9NdUJ0UaqEQPHTgceBx/VxXDZhrgOmsYdU2E9zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcMGh/b5Owe34qZzN+nwJTTdhX3glVfkXNdJpZV8qmx3TzSbKYfwGnavGjNnwDmievPy7rhkKoh5Tof3H72Eyc8GF+toOb8jwMnHJglr3Rek4yVMe/ENDCbTxQIR3qGuDyValWkx3HJnl/AUxvJpnbOyFQ9BQsNrS1Y9WmJDGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Izq/ltuP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sifV4Du8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izq/ltuP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sifV4Du8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4UPaFgD/UBEaEuWdchd9bGdGxA6y7+fT4fa1mU+DAk=;
	b=Izq/ltuP4L6aoyNSS28sC035g8zN7o9tzTV3RtecNdnXMUdJF06kjH7GYdOZI1/nQoe00M
	ftrZD+B3WZ9UfqldX6mvjIeb7ejLKDfqI0g0DatRwsleNCVt6diCGyVAqsQ17hl0h/itqb
	dViin5Ov9/Fw/zT4qb9Ju0bCKokv1To=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-tNKC2B1cOZm1BoKxK8_dNQ-1; Wed, 11 Feb 2026 03:36:13 -0500
X-MC-Unique: tNKC2B1cOZm1BoKxK8_dNQ-1
X-Mimecast-MFC-AGG-ID: tNKC2B1cOZm1BoKxK8_dNQ_1770798972
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435af2d3144so3122621f8f.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770798972; x=1771403772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4UPaFgD/UBEaEuWdchd9bGdGxA6y7+fT4fa1mU+DAk=;
        b=sifV4Du8xBCRmYhx6TEnLbgIHaOAiXa6wRjFgvsWeNsIKwlM+BcFtCUM/Js90pDVil
         vuqlJxanZeIUsDAmy2U1J5goHSVqpEWJa3Uux88h1v1kst8wi70L/5te7raKFsbyw9m3
         jyvg6QM0Luik+LUlkfFe1x1Gh9NVY+3BV72hoPze0ABrxEcYQmu9eR3uAEXYA+9rrEKm
         v+RQYBlYFeJ+0e4tG/BvcrQkLgxCvdq+8ciV4GnoJXgXuxKrdXunAeoWmq0qMb0r1UaS
         uCvsHMmVsLO/IprzrDeOtmsMzWlxiEJVaLH59S4ghjQKZvCWptfgUzpqi1azXWTda+hO
         2ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798972; x=1771403772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4UPaFgD/UBEaEuWdchd9bGdGxA6y7+fT4fa1mU+DAk=;
        b=H+EV4QGwGNd5gJr1OY+xLg7MeswntBnQytv/KmcDg2uvMvehXntYowF1XU/z20Lg6T
         MhweKXXYH+GQEUxRmJhwu+NDCcIIG6ggK+lIw8JXsEaCxEjZssB+JTwtViy3YFaVRSmO
         SBgUU+65UzEPRC47A/WRiGkmuOS+DlFv2HDo0qGlXrEgomA5URpWHbcbvAEFMEZZay5B
         toEyNdkj7rUNCKsu56c2TcQqCO81IWtOS1EcihlvZk2In5O0l/G/rl8wm2oOpO6evou5
         3Uk27xxtFBb0rr4PiQUnDWQJgNOqEb1WmMaOChF+1eVY61ljHPBOlXf7cO4x9WuNkjnK
         X5Zg==
X-Gm-Message-State: AOJu0Yynem4U8M8FS8XgM3DIqC6nLPk34dWuAamjMOCG8yEshxAoZF/R
	lO5Y2oZ/CY4TshlbWZOs4JO0aO1PTMvxFlD/TeV6J48moQa41jwKr/RfputJzL8v89CxirWh9X5
	257Nxh+AemsP0cSxN6byWVDmoweGw7nH/qzEyLquluaCzqHfrpp2i6g==
X-Gm-Gg: AZuq6aIbeV/VXWLUu3nlS7WZG/zf7PSWcx9dxEFYw2OmGfsFUyT5sSaz/dBUL7xErVG
	2NcUW0YeFDtdNJGKnZgiJCEPynctidmsTPaAl00iVkoxGiTNU09dV9QqmFkHon11eXIW4k+mEEG
	6MSyRzklqRwONvRYwMPLCnY0cY265cwOXuKA7gjYdpemcI0p+zarXPRpFETN8seccJOQ9Lo1pTL
	odAqoUsqAZ1VxRtg9Alsytg6JSWfSAlhEEAVwBO2rqi1lrile1pGXt7aFPH5OsdkqGfW+cF17T0
	AkQ+1ajP8UVKMZIq7yoLQkr+VgJ8pHewlmjkZZq3LS3gqdB7JFQ0lYMyEVoPzilsDp9Qt/4pEPP
	oiUFV7DwP0mMKG6GaOdqkNSngFA==
X-Received: by 2002:a05:6000:220d:b0:435:9e32:2b78 with SMTP id ffacd0b85a97d-43782b1b383mr2151998f8f.1.1770798972231;
        Wed, 11 Feb 2026 00:36:12 -0800 (PST)
X-Received: by 2002:a05:6000:220d:b0:435:9e32:2b78 with SMTP id ffacd0b85a97d-43782b1b383mr2151970f8f.1.1770798971748;
        Wed, 11 Feb 2026 00:36:11 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d48954sm2895544f8f.12.2026.02.11.00.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:36:11 -0800 (PST)
Message-ID: <f1827414-b6c4-47de-827a-9f9f4c796cf8@redhat.com>
Date: Wed, 11 Feb 2026 09:36:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, atenart@redhat.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <177039506239.2258217.7863252279149995024.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/26 5:24 PM, Jesper Dangaard Brouer wrote:
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index fd56b7d88301..a2d1b292600d 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -548,7 +548,7 @@ static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
>  	if (next_due && vars->dropping) {
>  		/* Use ECN mark if possible, otherwise drop */
>  		if (!(vars->ecn_marked = INET_ECN_set_ce(skb)))
> -			reason = SKB_DROP_REASON_QDISC_CONGESTED;
> +			reason = QDISC_DROP_CONGESTED;

FTR I think an explicit cast here should be better than changing the
cobalt_should_drop() return type.

> @@ -593,7 +591,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
>  	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
>  		if (!q->drop_early && must_drop(sch, q, skb)) {
>  			drop_and_retry(q, skb, sch,
> -				       SKB_DROP_REASON_QDISC_CONGESTED);
> +				       QDISC_DROP_CONGESTED);

An explicit cast is needed above to avoid compiler warning (or you can
change drop_and_retry() signature).

Also a few lines below there is another drop_and_retry() calls that is
not converted.

> @@ -37,6 +37,31 @@
>  const struct Qdisc_ops *default_qdisc_ops = &pfifo_fast_ops;
>  EXPORT_SYMBOL(default_qdisc_ops);
>  
> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
> +			struct netdev_queue *txq, struct net_device *dev)
> +{
> +	while (unlikely(skb)) {

AFAICS tcf_kfree_skb_list() is invoked in the fastpath even when skb is
likely NULL. I guess it would be better to split it an inline helper and
an exported symbol:

// in sch_generic.h
static inline void
tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
		   struct netdev_queue *txq, struct net_device *dev)
{
	if (unlikely(skb))
		__tcf_kfree_skb_list(skb, q, txq, dev);
}

// in sch_generic.c
void __tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
		   struct netdev_queue *txq, struct net_device *dev)
{
	while (skb) {
		//...

Hopefully the above should fit the recent compiler oriented optimization
done by Eric.

/P

