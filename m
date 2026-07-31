Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5444AB62
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514470; cv=none; b=Nb7rPLQR7N6VYKOyccgyU/lFTSrIyZcrYHtRndb5DactRFV3+gxosgmoOpXwbOragv5pRjLkLm7dgdxB9Y/Zs5phihkHgdf6nx6JgIswgEnq6aXbu5w6GFsMJD2TVvUN5sx/vCsCUeQ1Ax7+C2h+f/ZV0WkSxZUStfwapLiwtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514470; c=relaxed/simple;
	bh=5JOON6ugIR1d0E8GVuOUtOJ3ZKqEXg05GE7/ZQCPswQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rk7xoEXgxq9C7Z1bQECk0rFCezM0x7tgHzo/xhBHR4xH9jqysaNdoYCXs6GM147eEIsQ88dLM0xM+VArUPiT2+8wq83S6xJ+r/7oKuSp9Ew66V6MhkXenkUi3hPbuCf8LLHgruCl81QFf/Hk6BuP25UH0tk7hOTKmPC1KcdWUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQSwsN4j; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQSwsN4j"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848595b338cso1512049b3a.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514457; x=1786119257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARP06WocnAfqnx38wlDxcCLXWFVWx/Pmv/oo2KGc88Y=;
        b=mQSwsN4j+iPqK1SZXszssvWrdmhQznA/7W3S9fp8U4Hry/ph2QHPOG7UXwrxbjWM/M
         zG/oG9FoFwmvvrC2lcwEclq5o0d4+S6fAkb6uvlHHS231qRdi2GLz1vQVs6erN8SNPPP
         OvXM+nKv1SkISqIlARlEpKCxmuiEP/3OoGZIk7IeSUNR+aHmODDwaIv6K2PGBMIJFiq5
         ALvxLtAmGe4jKnLSwMsRUsZ40vgDHgkP0uZDrQNvWkn7+kBHe8q2rvAwufm9SVz3qIqU
         7PyMMgJpegkbscWILnXQUi+9pOTA2AQ8x9tYRHRmAg7SHuBLLYpBb+gBVrlecc8PzwEi
         F5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514457; x=1786119257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARP06WocnAfqnx38wlDxcCLXWFVWx/Pmv/oo2KGc88Y=;
        b=XatNsz1bfMJj7TOAFvdIgqKWyksE52s1FyZDCjZzMNktofpk13QJcwf1loJRdMXeSE
         u6krXkJ9EKcpqdMxny14Uw2X88ZGN6ptNy3UrEZd9LryABT5f+iDBDd2KQKSElr1V/OL
         nWvfN5XGXzRAlWTjEue4bmUtz9aJWTiEq8r4/ipBJ+KFrTH19W6BUy2aO8e0dKG/9tYr
         vNxn1CpqKGh1tRhlH7/FMnxQ/g04wWSyxBGRl8Zp/N+ga4DGHnjSCKs8BGOTjRDedvJc
         BOlU0cqXwN9MwFQ8IzJeUu9AzMKJUgyrmr/xaVdQ/XJVNq5CtKANPNaxONz+xzBYuKVj
         vraA==
X-Forwarded-Encrypted: i=1; AHgh+RqbnLGUg9z6G7It4JjyX3cNNUopzv61r8bwaD05XjQiFQ2vHXkQnk0ICvuU16DRQWZN+MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwB73v3qTqi0kin/Vk3WVIG11gZAIKrFsfqsp+8VDO+HdfSqX
	OYbaPCkjON36ByZYNK9yhTVHZ/nylHB9PuS9LJiFivztkR84ey47V+wx
X-Gm-Gg: AR+sD10Fy4ZvjkNCNq6ukoz+zKWjCc/RrKcriaa13dR9i4NV0jaZLdyK5nvcywM0DPT
	a9vbGPhliJ0Uz4b46T2oXpUlKs7CFj+5BiAXM29Ap5JjxBvHrNMPe/nt40HilHc6BR3ma29w7Fd
	fri6tGSYIJUQUEyi0qgD5dTyNflIbLYJyfhFkA1AD0mtrZDyVD4qzxg6iT3d41bAok8xg7JsTPI
	9Hnj79qVYvYuMYoRaRt14NaXe31NfSnF7U7TkyYWf67ywfrKr9BbvLTzMRGi0r19XhUUrZao0NT
	UXYltIeLgL+tRm2KYjqoDWdlUoxtO36eJblyqX31WZepP1WPhhYR1otpS61YT8JQJEJswmYsI6I
	OZo2QixagZx12l0obMmwa5xXtDOyBSk0gdGQ6XOjwlRyESkA5zYTPKEeUvTF9Jz+ParmqjIgyRI
	nsN8m6YOH14zkcUEZNPLpyz5eRHX0XbsGv0h8Ju1gJHfyp3oDJu7Qw20x2+xyGLHTkZ0QAq+ntf
	KU/nxnAkS5yvasLpv/j9K7EwCZnmpxmtZKZzoMIz0szmm5hJAANu8aoR10=
X-Received: by 2002:a05:6a21:330e:b0:3c4:3454:38a7 with SMTP id adf61e73a8af0-3c92a864157mr343544637.54.1785514457056;
        Fri, 31 Jul 2026 09:14:17 -0700 (PDT)
Received: from ?IPV6:2601:646:8f02:5350:ce4:701d:f6e3:3a6b? ([2601:646:8f02:5350:ce4:701d:f6e3:3a6b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e0700e8sm7237107eec.24.2026.07.31.09.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 09:14:15 -0700 (PDT)
Message-ID: <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
Date: Fri, 31 Jul 2026 09:14:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP frag
 adjustment
To: Sun Jian <sun.jian.kdev@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, stable@vger.kernel.org
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260731032357.6114-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/26 8:23 PM, Sun Jian wrote:
> veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> program adjusts the fragment area, veth_xdp_rcv_skb() copies
> xdp_frags_size back to skb->data_len but leaves skb->len containing the
> old fragment contribution.
> 
> After a fragment shrink, this makes skb_headlen() larger than the actual
> linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> copied 1024 bytes past the actual linear tail to userspace, starting at
> struct skb_shared_info. The copied bytes included the affected skb's
> nr_frags, xdp_frags_size and a kernel pointer from
> skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> amount and truncated at the end.
> 
> Subtract the old data_len before replacing it and add the new data_len
> afterwards, keeping skb->len and skb->data_len synchronized.
> 
> The fragment accounting must run before the linear tail adjustment:
> when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
> releases all fragments, and __skb_put() requires skb->data_len == 0
> by that point.
> 
> A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
> 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> corrupted payloads. After the fix, all 10 runs matched the expected
> payload exactly.
> 
> Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>   drivers/net/veth.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 00e34afd858e..348391e87e14 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   
>   	skb_reset_mac_header(skb);
>   
> -	/* check if bpf_xdp_adjust_tail was used */
> -	off = xdp->data_end - orig_data_end;
> -	if (off != 0)
> -		__skb_put(skb, off); /* positive on grow, negative on shrink */
> -
>   	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
> +	 * This must precede the linear tail adjustment below: a changed
> +	 * data_end implies that no fragments remain, and __skb_put() requires
> +	 * a linear skb.
>   	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -= skb->data_len;
> +	if (xdp_buff_has_frags(xdp)) {
>   		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
> -	else
> +		skb->len += skb->data_len;
> +	} else {
>   		skb->data_len = 0;
> +	}
> +
> +	/* check if bpf_xdp_adjust_tail was used */
> +	off = xdp->data_end - orig_data_end;
> +	if (off != 0)
> +		__skb_put(skb, off); /* positive on grow, negative on shrink */
>   
>   	skb->protocol = eth_type_trans(skb, rq->dev);
>   

I am most likely missing something here but what happens if we have 
frags and we attempt to advance data_end while leaving some frags 
present (e.g., bpf_xdp_pull_data())? Looks like, in that case we would 
issue __skb_put(skb, off) with off > 0 and we would hit 
SKB_LINEAR_ASSERT() because skb is still non-linear?
