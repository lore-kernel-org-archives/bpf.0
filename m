Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4767838238F
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875497; cv=none; b=t1ttZ+TMHQD97VMcVd45TjU+vspacXHP/viPp9ubg2eGMYtnTKIyaCiQCo37uQ96EbDi1QrsxxsmCRpSNGon/xfYbqMZjkTato9zzaxIYjP9JmihPoDjcp9+SqmhriLCanEr8VlSO36/dXZFeMI7ZNWGJ2U8AapaS1eOh4vTHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875497; c=relaxed/simple;
	bh=3ujk49r9hJpxD6QzWI53EPI7jhtl4wumqKjl5sGJSQQ=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=Sr9AmStmV28ukze09ZSfol4utBcDxEBABu4F2VCWVZIDv78PvhOUocp13gFjEdb50uxC6PRAZs3a3F41X/0+bIxAUpSV3nDuXhDyagq0JCQhRYlz/Tp7hxhfUagoBgyhXyWuVg+zgHl4rxGNlzJxSAvg3LL8xLw7zZRmUzN/KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw2eeVD6; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw2eeVD6"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7de4550dfabso45011a34.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875495; x=1777480295; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4wYh0G9rovuK1N6AZh4Q/4rSlW66xtu4/puuvsD2R/4=;
        b=Gw2eeVD6nzB0I1BYiWFyTfTS/UemiGpGxnkRgsUlSKJvak6C+B1wGCAMzws0tK7Xzj
         w+2T6mz9rbrUkp0UuYoCE+16k0Hikl/hc7GoMa2NAgi0G1Z6szZ4aMm8W/Fqh5eFMZ8Y
         0D/4lpuqgcY9eJhJ7ckAXVjDzowl1c1hJbhveecs8XPcS9T3lhvysmzh6MW3hrUEVC5u
         SO4fUhO52ax9Z2b7lXt4yjydL5sguPBSxsbvujmzGNW229k19J9xH8cEo8hh4cbFCHeH
         oW1vQ7LIK917YbvCrLhwP9755fWs7HwgXxjlkRRWOJY1s0W5rbjCgOJl5jQ5MAa6jm2r
         m6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875495; x=1777480295;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wYh0G9rovuK1N6AZh4Q/4rSlW66xtu4/puuvsD2R/4=;
        b=eXmI8/iy3OhTpZeK2aLy9XO5LwHNT0j7dcV1FxDZykzjGMkTq4RIWqnRHcpnWqQoz4
         PkV/Q5G8ZI0LD+mnK/x7ICnabhqrVXP15NNStYw4Zf8jYoFU+cdUL6IxBgPAGxEFgS63
         801lewtQIftzqETXeMOwDWUD9dBOFn1xGGJvOou11YKVg7gnihX/JkXWdDir+XXLkHLg
         O+P7LKEWvzBHSbxy4WMEqkU73WT88asEYA/NYce77kOVHt1beCDNWcHOOqNqlDR1i6X4
         hGFIDKm2NZ2eAOXXRy3kvsYJ0Ct9jaSWevMBoerepWddwnSuKq9VV8LOAVIsa2gVHkYK
         7LUw==
X-Gm-Message-State: AOJu0YyB4tv7+21tHnyAIw1T4LUgJP7AgL+XgKYR79b1Y/ETJaRGwTHx
	YDaJtboy2f855TyP4/Gq9e2mhjuuTc0+Qut8FRro0TiVzMf1vQNoIP33+pZJ7BtO
X-Gm-Gg: AeBDieuMeQByoWqkHC3j+uMnGmKP1McvDKuTBHKPV5Rsx7kmPq0Ff/+wiJ5VvzvG8hS
	u5jSAxTBXPDBAw0DQB0YFg/IvHxLafVl2FFSez6Pif5UdCx31Z0V3y9S8Fxa5T8C817TB0ivd4y
	LzNE3OagYKyDvFKu7A6oJihml+/q+UGIrly4o41jHdb0wCj5rxTzQSIG2XZErBogZF9lwy39Wry
	t7N8TsyY+P76A8c4dY+o62xVI6ylrNHbw2pDETWkG24kxSnVwBki/qjK0b84LhlL2sof1+r5EPt
	8/1z//oOhqWpfvxh0AD7DlCDENG1PXacqRL/khaHMdgal4bXrQ17HQzpttWSdqtDyypifQekIaA
	+lo08Cahwj8eaJb2FdUkAl4pPk3piDcpYdorRZQEQPiNTb05/0LSUAA8JqjVXvdNc38oDk0gsLp
	3JQJ2PMsMgGJp+NkuIxwE00jsoHSIq
X-Received: by 2002:a05:6830:67ec:b0:7dd:e032:3cdd with SMTP id 46e09a7af769-7dde03240e9mr1511113a34.18.1776875494493;
        Wed, 22 Apr 2026 09:31:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm5895751a34.24.2026.04.22.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:34 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:33 -0700
Message-ID: <f019ae7f3c2ec5fafddfe942eddd6591.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-6-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix it by explicitly adding kfree_skb() before returning back to its
> caller.
> 
> How to reproduce it in virtio_net:
> 1. the current skb is the first one (which means no frag and xs->skb is
>    NULL) and users enable metadata feature.
> 2. xsk_skb_metadata() returns a error code.
> 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> 4. there is no chance to free this skb anymore.
> 
> Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 88ec6d2cbbcf..c49b58199d2f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -741,8 +741,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  		skb_reserve(skb, hr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
> -			if (unlikely(err))
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
>  				return ERR_PTR(err);
> +			}
>  		}
>  	} else {
>  		struct xsk_addrs *xsk_addr;
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
