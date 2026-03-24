Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35712408257
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372619; cv=none; b=WQLOVum2SGjHUebVL3oeWRS+QTv4QVwZ6C34dwjTlZQKSHzHggeHhjJRjV6n99AhATB9zIlORBQLvw4kk+mb8JnrkI90kVUIK0Yxs/z+txF9K9PU7iSekJwyQwcyOkvEoa3RNn4Wj2/b4EZdFgSosEDPyAlQcCHynmUnfXVF44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372619; c=relaxed/simple;
	bh=NJKSoCbXn+QUpPwOGq/+GC6/ZE50PsuhKLKs7WIYIi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxP46TyyVC1cc7kh/L7mIV1zxzCY5p8LJvRQ5vq+/s2PItzVXHp793880iYkksqyK4Tq6gPpTuUyP5XcbT/OG7L7XpPk6eDTu9edpA+XVGkWs15A87Oa6UvAsvZvq7uOHIqe0j0qbkMH6BiZM7KlNbcxI/ono7UD4Q0hEmzJJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Dlb8YrSA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Dlb8YrSA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=B4fumjl0RR/f2jk5HdtWIWLHYtaERV+C6H1s9c5PRq8=; b=Dlb8YrSALU0EPvIghZp5zb8WDr
	tOBpYGG/N/1zsxOfuAUSgrgZbiEF97G65kCYE00bj0BJDGQWB/labQNj3NqmxanWMaeKvNYsErkq9
	ZHz7NTb8JACyg4RRpXFZIJjM8NQFo3zvM6f5oGRh0UbSEEnJ7UFYUHyVjPgXGSnLJRtoyBsWyKthN
	lA71ATXlGLi2azOfpERnbDL4/N9Auc7b6RpWq8Yax4uk+k1xUzZQxyBWobkMAQlf4Eztnte5sI4gT
	1PG9Ds6Yoq49YmsVEybh5OJDik8kWxnbAzWPDX8gyibeZUZ/XlHfTW/jlCbKxUIV2LzIfas+0Q22M
	FjaSpdlw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w55N1-000HFT-0Y;
	Tue, 24 Mar 2026 18:16:47 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1w55Mz-000CtN-1b;
	Tue, 24 Mar 2026 18:16:46 +0100
Message-ID: <de203a42-0830-44cb-8746-53de037a9c95@iogearbox.net>
Date: Tue, 24 Mar 2026 18:16:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] net: clear the dst when performing encap /
 decap
To: Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Cc: maze@google.com, willemdebruijn.kernel@gmail.com, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <20260319234531.3022634-1-kuba@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260319234531.3022634-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27950/Tue Mar 24 07:24:19 2026)

On 3/20/26 12:45 AM, Jakub Kicinski wrote:
> Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
> added dst clearing when a BPF program changes the skb protocol
> (e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
> the L3 protocol actually changes to keep it minimal. As suggested during
> the discussion (see Link) encap or decap operation which wraps or unwraps
> a same-protocol header may also render the existing dst incorrect - even
> if that doesn't result in a crash, just the wrong route for the now-outermost
> IP dst.
> 
> Make dropping dst unconditional for bpf_skb_change_proto() and all
> L3 encap / decap ops.
> 
> Link: https://lore.kernel.org/CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

LGTM, one question below:

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2f023999f046..0f8c508c5f8b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3257,13 +3257,6 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
>   	.arg1_type      = ARG_PTR_TO_CTX,
>   };
>   
> -static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
> -{
> -	skb->protocol = htons(proto);
> -	if (skb_valid_dst(skb))
> -		skb_dst_drop(skb);
> -}
> -
>   static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>   {
>   	/* Caller already did skb_cow() with meta_len+len as headroom,
> @@ -3362,7 +3355,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
>   		shinfo->gso_type |=  SKB_GSO_DODGY;
>   	}
>   
> -	bpf_skb_change_protocol(skb, ETH_P_IPV6);
> +	skb->protocol = htons(ETH_P_IPV6);
>   	skb_clear_hash(skb);
>   
>   	return 0;
> @@ -3393,7 +3386,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
>   		shinfo->gso_type |=  SKB_GSO_DODGY;
>   	}
>   
> -	bpf_skb_change_protocol(skb, ETH_P_IP);
> +	skb->protocol = htons(ETH_P_IP);
>   	skb_clear_hash(skb);
>   
>   	return 0;
> @@ -3440,8 +3433,14 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
>   	 * need to be verified first.
>   	 */
>   	ret = bpf_skb_proto_xlat(skb, proto);
> +	if (ret)
> +		return ret;
> +
>   	bpf_compute_data_pointers(skb);
> -	return ret;

Wouldn't it make sense to move the bpf_compute_data_pointers() before the `if (ret)`
test? For example, if we'd fail after the skb_cow() and return back to the BPF program
then they'd still point to the old data pointers.

> +	if (skb_valid_dst(skb))
> +		skb_dst_drop(skb);
> +
> +	return 0;
>   }
