Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D232E414
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260181; cv=none; b=Z60pcG/HoR+mPNal8Ino1eMxzk4Zn8qu4mBTjEKXBz8L5ZYx4xa5N0LNwldzTzNDqa0jxRUjuMgK9uuIHdrjwJvSDmkZ2ZzY+q7JcCIilT4aUC31/83CYU9i+Q8Kb7DM4x0Wi4HJiTISiTn1wTumebCINlPQoY778wDjfDk2WfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260181; c=relaxed/simple;
	bh=Z2L3QKKaPwrhMvxKy7aG/ll9Q7ylGLT9jsp6cnSFA9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hM7Ypr52XEhol7MXiPWwtVjwEH9811NifYza7BoGPj5w8KyNYQD1sD+nBWRbdq2jm6aLQsatBd0rBgpJjtFjjem/svUa6PYA/kNCAKGba4ENqSsI/0AU0LHmYKxyZzwieIQsSqp370vJVUAVc3V8Qh1UJzfrjSbQkjagU6130vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tPX8BQwq; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="tPX8BQwq"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c6040aa54so683006eec.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782260179; x=1782864979; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UAkNveefuJTgsJ0NBHhwMmRem65M6YgSNW6+kcyow4=;
        b=tPX8BQwqKIYyKGevK+lArVvqtKms8VW2Nmkxaid5f4rIpmnYp64BVWCZJC1Ls8uj/I
         cYehJhGYFrwpeM0cy5HM3pDT66FwBo2c6cbDlXu6nGMEi65CVdmvaurO7dnBUfEO7BYi
         WTeMJAoJl0VZrj2FKuoUCyp2QROySeX5mUgp4MV3gKWpWL4HFH+JoQU3EUWeyOLuWRuU
         jxcLWMqfUbX6odu/ACTNCBuiPMJozO1tyKvO2t5Gsvx73Nb64V6Cliwv7PmBLvRR5eyr
         3lVSCMDTPXTxlzb6PkTRH+6iO7zTeLKIyXW3kHAv84YzCmn25E1lHVCnyCTQExTuObO5
         BmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782260179; x=1782864979;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UAkNveefuJTgsJ0NBHhwMmRem65M6YgSNW6+kcyow4=;
        b=GNnhlOE5EtwKyO1G7e1zvHAgfSnoTNceL3WBEvR5+Eo8Rlr5g7+PD3xyRzXO0Z7tEU
         KYzxJkH0fNTpJlHHkuwRGEy6XJrdujqUgr/9z61inDmfq/gr1c32i+ocWOwCHwWtIRep
         RFDECHnWMqVNEpeJN2o0Ix7pwwYdj0zVjgI7Fh6RXZ4SnTjNxziVzeQH4mB8Oans5CH+
         rEdCszdycYYrn8egGrwHRAfbf1o3XR12ad0VvXm1CMRgTfIJEZFQrZPyD6nnebBIcLso
         5eTArqUkyDXiufHYVG6Idcq99w/Ct6VYQ8vbkLq8h6yisvTNQyA0KtXAUmkRZt05zsmA
         /aiQ==
X-Forwarded-Encrypted: i=1; AHgh+Ror66HGVocXosN5B0hPQUFBEMSiZD+5Vc/sy4ydL6lNTe0l98cWgTP899m6esJm1wQP3qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsrEqgM1f7VyIYVKmHDTqKiYBUHRSKdEQcZKqskx4yFHfGUn2
	k5jGFYkrsgY36pImhkLeccduTV38XOFA4Ns0GJz2BOEXHh/mK37fQr7hMyZo0PHzBNo=
X-Gm-Gg: AfdE7ckxxl//Zbts//dd4cV+0NXgu8qdvuSSMXU8ZgjEUCm6wzOnQo/eyQLPE+B591h
	+Wq7SPFbuoXdWsCB9ZzDwdtdiMPa77vqhz8ymGknuJl9qUxdl0kfPRx9NtslCHNtdwGsWpy/HNy
	xzJ5kU7Ww927ED8pTs/JACnk8omz4GNi4OxMVjNvPnc8bxf56o988rubUceqOMbbHyZtLYUd1Uc
	F0GNoyx4fzBcRI8jX1lGeOFF06cKqsP0gPIWRjbMoVVULWssKZ245f+vDpJHlbMV68yaRCA5Nd9
	l7SgAc0PpnF1dCKclGoEmJFtCzcAtNOlHUgBuYe7/H0VyzouhBO8ne0Q9LvaEPYvpqdklUs0Jxj
	EO3w+tMsnmbOgLl/nizrjevRKCMF2+vM6+r7kQiiMxATCYDBqqAJ0ukc5llfF6JK8IXxWZA==
X-Received: by 2002:a05:7300:3210:b0:30b:dd58:e167 with SMTP id 5a478bee46e88-30c6938c45bmr1378913eec.29.1782260178724;
        Tue, 23 Jun 2026 17:16:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c44ec51b9sm11937449eec.29.2026.06.23.17.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 17:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 20:16:16 -0400
Message-Id: <DJGUI5XWVR5Q.25HFEU8BW6QT4@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <jordan@jrife.io>,
 <kuba@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 2/7] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-3-mahe.tardy@gmail.com>
In-Reply-To: <20260622120515.137082-3-mahe.tardy@gmail.com>

On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> Move and rename nf_reject6_fill_skb_dst from
> ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fill_dst in
> ipv6/route.c so that it can be reused in the following patches by BPF
> kfuncs.
>
> Netfilter uses nf_ip6_route that is almost a transparent wrapper around
> ip6_route_output so this patch inlines it.
>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/net/ip6_route.h             |  2 ++
>  net/ipv6/netfilter/nf_reject_ipv6.c | 17 +----------------
>  net/ipv6/route.c                    | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index 09ffe0f13ce7..eb5a60d3babe 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(stru=
ct net *net,
>  	return ip6_route_output_flags(net, sk, fl6, 0);
>  }
>
> +int ip6_route_reply_fill_dst(struct sk_buff *skb);
> +
>  /* Only conditionally release dst if flags indicates
>   * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
>   */
> diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_=
reject_ipv6.c
> index ef5b7e85cffa..7d2f577e72b8 100644
> --- a/net/ipv6/netfilter/nf_reject_ipv6.c
> +++ b/net/ipv6/netfilter/nf_reject_ipv6.c
> @@ -293,21 +293,6 @@ nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
>  						   sizeof(struct tcphdr), 0));
>  }
>
> -static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
> -{
> -	struct dst_entry *dst =3D NULL;
> -	struct flowi fl;
> -
> -	memset(&fl, 0, sizeof(struct flowi));
> -	fl.u.ip6.daddr =3D ipv6_hdr(skb_in)->saddr;
> -	nf_ip6_route(dev_net(skb_in->dev), &dst, &fl, false);
> -	if (!dst)
> -		return -1;
> -
> -	skb_dst_set(skb_in, dst);
> -	return 0;
> -}
> -
>  void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *ol=
dskb,
>  		    int hook)
>  {
> @@ -440,7 +425,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff=
 *skb_in,
>  	if (hooknum =3D=3D NF_INET_LOCAL_OUT && skb_in->dev =3D=3D NULL)
>  		skb_in->dev =3D net->loopback_dev;
>
> -	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
> +	if (!skb_dst(skb_in) && ip6_route_reply_fill_dst(skb_in) < 0)
>  		return;
>
>  	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 6361ad2fcf77..0fa56c801178 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2732,6 +2732,24 @@ struct dst_entry *ip6_route_output_flags(struct ne=
t *net,
>  }
>  EXPORT_SYMBOL_GPL(ip6_route_output_flags);
>
> +int ip6_route_reply_fill_dst(struct sk_buff *skb)
> +{
> +	struct dst_entry *result;
> +	struct flowi6 fl =3D {
> +		.daddr =3D ipv6_hdr(skb)->saddr
> +	};
> +	int err;
> +
> +	result =3D ip6_route_output(dev_net(skb->dev), NULL, &fl);
> +	err =3D result->error;
> +	if (err)
> +		dst_release(result);
> +	else
> +		skb_dst_set(skb, result);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
> +
>  struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry =
*dst_orig)
>  {
>  	struct rt6_info *rt, *ort =3D dst_rt6_info(dst_orig);
> --
> 2.34.1

