Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFE3B19CA
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713674; cv=none; b=ISc6+qe7H4oeAhcUHjEqIlmEaydQMB8qvSd9bIcC5F8W8VS7Cc7lgHZlXoLe3Wpj/OkoKZKTfXBD9+umviHUx40D70HvJnNSN2lc/0rO5lLixfUKLcsXyeJmzW6z1IK8d/5fQPX4+C57AeVUdE3anSQbRU1ScLOPhWGgNP97q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713674; c=relaxed/simple;
	bh=FZUjnqDk1Xh40RuylXfAZfHlK8yCo4IiGfr9Vlt94N8=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=KXy5pnNhf0i8rXgrukQO9aBnDl2BUxf8ZzEwviTRobzBSJumB1M7TOwBS9NHsK0Z6N2d2aetJRuhlS18C7yyZ8ONabIxaOc1C9x9pWeeFSG/nOsU43pXWImaH0/OpoSuL8sBQkCS2p8sgFkQUXV0Y0UbRz2BgmzZiNAcpuMOJ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBTHD7MA; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBTHD7MA"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dbb89ab229so3346276a34.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713672; x=1777318472; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qy1Z22ONGxA0iuWXSuM/LMweV9FlzSCH30fXWwBGCAs=;
        b=TBTHD7MAqxK5baqEiSNZ+q1sD7Qp7KpwjwG7RYVOctscs8t+UFKnnVsxBWNRporkph
         g6StTDvBiSTjJ4Q3ZoeDDBld6vMQoKoBsCwAgeKa1uikjerLrf75tdaoJsKhK13bgb4L
         62jKsOnLnJZofdA2hBeZxXC3y9r++7/Dn2jmWnPUf0zAa5aVOUA3pmQ0ZusQTOigwcvc
         kv+FezrSnga0gchAeSFhTL2XJTT/D4ev47lLPG8p6eHRkx3Nnnep6qQwBfpscHF6d6lZ
         //EShAcYw69vhxVH4LgTwFuAXnuDezEmUF8OtzM3MiI7c0BTYYW7B8fYmqlihbYfB2AZ
         tpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713672; x=1777318472;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy1Z22ONGxA0iuWXSuM/LMweV9FlzSCH30fXWwBGCAs=;
        b=mhqAPgIwWaaLzcMT2xBKw8dNjI6IjRxjZ72uj6qvp7NFaOeX6igC6a7knJDxhou95O
         0XYpBoQPeU5+gNhr9Q5aNXFR14wkv7CshPGzqga9MkuOZtgmGysVnexA0lAVRxaSlu5I
         fSqblCrtJIFoDFq2lGgSQfrwbxd/Zn8YS4W3OlgZRVQqMzMJpUULfMjexz2z8TJAmZQX
         l/OApULo6vmSzvPUzndYa1z4B+0hL6BrUimZdVNN7fnJP/eca19t3FR5+bM/aw64hd9M
         wQozowmpc6qdaaHP1E5wR9+LmeqDVXnF59/j2Y6JZnq+JsF4p9+rUPZT4WSGa8S4WKEc
         h+BA==
X-Gm-Message-State: AOJu0YzL2RpbWX5CtMlrmcM6pnUOkefc9qA3qur5IUy78PYXQ9ZLjIA9
	BJ0SC+q9vxYlhHa4A0l3LBgyt8BM5OgJcXhpAZ74HsjjQrk+L7LHPqHl
X-Gm-Gg: AeBDiet0+whiKe+8v7ofPf8rnw4b7K9x5rx3oyfN6gRtE1JPJCSeGRyjNidW1ilxdKw
	F5DmgrYg1L6FUPsOkkesnOp/wEqUQySbmgMmITxZbFQ3pbGRueHc3bShU1o1Zb86VAEyA9GGnZd
	oAuR6T0dH3C8x0A2ucIQSCOMmvK5rGKVBh7slrRaWQ7gtaVjk6U1N7p7Z0r8bBHpuzSt2ySc+4t
	8bCodub1QcG3GEmVxt6Ch9f4ciATYryer9ePA4K7+q0F695uz8hfvtl8UHG9kiAmpVHd0irP8oG
	12XEkBhyK42tCq7QlripECI3hxapguCpzVaXMRGn6uc4MEzZpVjHEihVC+FA5Pqfc5U5s6H3tpU
	eL1tsL8WayT8cTgkycJDoc0d/Evbov7mAgS8VHyhk+QxJC80LDrjOXQjCMKrrtxM0ZQurqLYHJz
	kj1WgMMwyGETZi5NKKMLHsBfg7
X-Received: by 2002:a9d:5cc6:0:b0:7dc:a256:5e2e with SMTP id 46e09a7af769-7dca25660f5mr5106460a34.1.1776713671739;
        Mon, 20 Apr 2026 12:34:31 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9f062a71sm7927093a34.10.2026.04.20.12.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:31 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:30 -0700
Message-ID: <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> skb_checksum_help() is a common helper that writes the folded
> 16-bit checksum back via skb->data + csum_start + csum_offset,
> i.e. it relies on the skb's linear head and fails (with WARN_ONCE
> and -EINVAL) when skb_headlen() is 0.
> 
> AF_XDP generic xmit takes two very different paths depending on the
> netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
> skip the "copy payload into a linear head" step on purpose as a
> performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
> pages as frags and never calls skb_put(), so skb_headlen() stays 0
> for the whole skb. For these skbs there is simply no linear area for
> skb_checksum_help() to write the csum into - the sw-csum fallback is
> structurally inapplicable.
> 
> The patch tries to catch this and reject the combination with error at
> setup time. Rejecting at bind() converts this silent per-packet failure
> into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
> launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
> because they do not call skb_checksum_help().
> 
> Without the patch, every descriptor carrying 'XDP_TX_METADATA |
> XDP_TXMD_FLAGS_CHECKSUM' produces:
> 1) a WARN_ONCE "offset (N) >= skb_headlen() (0)" from skb_checksum_help(),
> 2) sendmsg() returning -EINVAL without consuming the descriptor
>    (invalid_descs is not incremented),
> 3) a wedged TX ring: __xsk_generic_xmit() does not advance the
>     consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
>     the same descriptor and re-hits the same WARN until the socket
>     is closed.
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk_buff_pool.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 37b7a68b89b3..c2521b6547e3 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (force_zc && force_copy)
>  		return -EINVAL;
>  
> +	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> +		return -EOPNOTSUPP;
> +
>  	if (xsk_get_pool_from_qid(netdev, queue_id))
>  		return -EBUSY;
>  
> -- 
> 2.41.3
>

Wondering whether a better fixes tag is commit 11614723af26 ("xsk: Add option
to calculate TX checksum in SW")?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
