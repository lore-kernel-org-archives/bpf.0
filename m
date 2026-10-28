Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213315;
	b=uSVov03aOIFpng+FL2L7M6Iye5B4qFF79MwRa91XfYuR+v28KG5RVc0k+wCsNe1crTmi
	 6bKEdSXo7nD5Yg6r+skrqK1fNCfeDddRh/AAdb3sh0Ln9BDvpfESOoOY4fxPUDT15RI5C
	 Fm0ORDJRQp5s4+yw6F8LemkqI0FVQXAAMSLsFo2N2S6cc4Kb2FcZTnz0FrtFf9QGEWDrT
	 GF8HX0Q0ZDwFBUEj+ADvk/uq0f/y9MMMY7wfOjmgf3d1eJZetpbFo1e1uOcf1xMyzdQF2
	 WrRMkA8kOZmQe+u80kMDgnM0bCQZjZY7/+HGZBiFxODfe2HR3H4m6JTHVu5aPwfxVkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FoM3jrwU9mnONLYaNhWTsxjkZz6IQHFf2kOZKAb2OVw=;
	b=mHaQXi92sDxTZ0cvgfd8RMxaaTR94uBPXONoHM0me5J35s3h/CPI7b5lDJyznxlwLLj8
	 W6ZwFTUyCTvibuAt6lga5NhhL34CDjATB88YDQKzvNCf57gFaAYIsz1HrV37liklqXjqy
	 SAm2srwvT7ced0JID+KgJQ463yI/rVTlpqbfIE4ENAR0CSze5fg3u3zc/r35ibZ1RGl20
	 jwgINtKRXn7jbxOi1yugVVXVlNfEUgr2RFTstxHo5M3vzfkE6q5dd7jtuEE5MFCDtg1xD
	 LiaXHW87PZBfEJ4wHFz3z6VXvYEzz/6dG6raRqSc6gc9pwz883khK5RMdUJMv+ebnnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HrG6VXhJ;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CD606A322
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E5CD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HrG6VXhJ
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b10d24345dso12999137b3.3
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793213314; x=1793818114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FoM3jrwU9mnONLYaNhWTsxjkZz6IQHFf2kOZKAb2OVw=;
        b=HrG6VXhJZUpYGzsQlGM7mXpO7NaSEsyM5NgP2QNvXh/XDogGvTnyfAuehx353+xEBh
         IVg4hKvcedg3x50xIyIFetXyyqFOZNUjb4RJkJeTg+o+oY4W0UCbJYdG/vsl6w0xa7WH
         7bYgThfyccr7ydpX8XLkugAF3tj2x8ZLlw5EWSMrAt7UyNEpj9Avnve3KQbMbvEMUocC
         6WOwqa4k5KM9BkQFKycLJB+3ywP/x2YoXanyFnKl3Hr6zSG+GLuTGr1MYj+HgKGr6oaj
         6L37rkJc9y44GssbLEJHjgdqI0aXKwSlytASZGQAV5vDjK2raS3573lKyafTFFR2KdN7
         OPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213314; x=1793818114;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoM3jrwU9mnONLYaNhWTsxjkZz6IQHFf2kOZKAb2OVw=;
        b=WszouTfYD7SQIvtk5n2dTdvI3Ko8mzw0pbz/a2ESjoYsfwSdmBtFaFPaJGY6LSQAnh
         KHxJEtSkD/A8B3+5PDB/CXLeoe7zHlRLAzSnAWRmLuwZMQyCI/aNhumnevE2IGkSPgQr
         wQ/a5m/8nj97hpp9kXQTYdWEsLGDq2Wl+08H8HKksIuHuSpKNgO6UZXbmKiDUm5VIl9M
         VcBjLCiLaE6jbJtGyi9qyjsVOdZcp+JqR3ATCNAPrQZM8V9IcVd9IrCmdIIC3dcwCPQb
         +YJ4VgtmX8GoEMJSsxx5Pkh8rE5Ckai8uJuHrKCUOKbBf3vip3tlNjJWobiDvNdifRhw
         H4og==
X-Forwarded-Encrypted: i=1; AKwUvBxCV7M/rootmrzV45TeVmn9FlzM05GpuOpNYgDwyskzvOKLGp0rYPM+cfJNs8lMTOACyLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrmyZr5Fa9VlUM6gMQJKWzKfYSXrQOdf/mlwtbn+TZMbzlJsZy
	yDsWTU81s2iYQ5QuBhcBJhayPg8yNGoCS4Y+83/P3UzjllY+Up0vBCb2
X-Gm-Gg: AYBFou2GKiyZrVLyCcFyG62iUM8VnHCqfzWE0KrLK4OJu2QYPiYUiK3fBBBmx5gFhpP
	w393doU/3KeUj5pHokMxC4ppKPrht9ApvzWXznyvWInT0Ys/st5fiRlfN/b6l3XN1u3bsosnHXW
	54Vpm/iFYe3Jsf0VQm9W7ETmaNkLMOZGiK3t4t3A1dK4FyjTQUUXnmB0pCYKYU9LLwrRM2OCNXx
	shv6e3acSOLOtpYS6Wk91oSTTxJsRG8eKaOat7Sb8lZGd7l2FplaxKENdmkDkBa1M7HSUuCYXsK
	SFBiXesxpGG5ntn8kQL5/W4MyPU5NLszJWRcUPZw4QT9VGxmv816tsEqGmzOnPmBlx3cvJM1vhv
	vVjof6nY/dZh85JcryIuQQ4wleikKa+SBINH+rsrU1GBZqfrX8vg0tQyf0wyq7wD/HzPrIdWIdP
	rVTIwj6t6t9IUWX5BY0xARhhKY4sVI4TRdpZ2GOwwcmeLtKuT+Kfuf4xWT8yxFTsAkEiVI+RShe
	qRzuFPq9FJdjlveACQCEG4vcZlEVgo/uF8Ov8MIB3rhkx7IyTdlqluIj4IAFGgURqHK0ZN2baZT
	znenKDJoW1Botf7jsljO9Mt0kxzHJ2lD2CKVX0+EdqxHvoojwK7JFsew3OuylaUMgcU4G5WOXca
	49EHJiSmAFryI+sdpaXlZZf1MJbZbNSYi1WM/HpGeI/sh1INBghfC6BIP8O0US3IUbM0U
X-Received: by 2002:a05:690c:38b:b0:8ab:37e5:6678 with SMTP id 00721157ae682-8b1b5d394a6mr23556237b3.44.1793213314099;
        Wed, 28 Oct 2026 11:48:34 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e5c7d50sm33374577b3.30.2026.10.28.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:48:33 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:48:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 dev@openvswitch.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ren Wei <weir@nebusec.ai>, 
 Vega <vega@nebusec.ai>
Message-ID: <willemdebruijn.kernel.1010e42464cde@gmail.com>
In-Reply-To: <20261028122703.2093730-3-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
 <20261028122703.2093730-3-edumazet@kernel.org>
Subject: Re: [PATCH net v2 2/5] loopback: use eth_type_trans_careful()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> tc egress actions can leave an skb with fewer than ETH_HLEN bytes in
> its linear part. loopback_xmit() then crashes in eth_type_trans():
> 
>   tc qdisc add dev lo clsact
>   tc filter add dev lo egress matchall action vlan pop_eth
>   # AF_PACKET SOCK_RAW: eth / eth / 8192 bytes of payload
> 
>   kernel BUG at include/linux/skbuff.h:2839!
>   RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
>   Call Trace:
>    loopback_xmit (drivers/net/loopback.c:87)
>    dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
>    __dev_queue_xmit (net/core/dev.c:5066)
>    packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)
> 
> The same happens with "action ife decode" on lo egress.
> 
> Use eth_type_trans_careful(), and drop the packet if the Ethernet
> header can not be pulled.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebusec.ai/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
