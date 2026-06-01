Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220543DB99A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333440; cv=none; b=ulGfyBFFqgvbcxn+lzMXQd/yo0f5021xnqyll1il6KSXW5QdVuUToNS1/RLEE8UOuUwYJPP8fE/+LIohUqiBlB7fBO8czwuc8qcrHskTWWUkXJ1BH3XKWl+//iYrE+3sx1ertBHABbK9xRdYgbdP8MYK8H5avIeVgF4DBpKNYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333440; c=relaxed/simple;
	bh=CJv+ORdfM4d1gC+/h8eXW8d3TcRUhKDuN3NsrTLwwrY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QEpZB8ixNawE436p8Nl39MH7m5IdauqRhq3nPXphIec3C69Z5QEO/iV4eq4B+YPZMbnYql3ThEHWz85ln8SSG5EmVM59YlP0GINuoIXtnq/am6Mv5xKDAjUo6tUDzrZWpsmAyGLExpg8gibejFo7+4ZHL6AQkTzE+rcT7eLOklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=c8zku+oa; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="c8zku+oa"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304545f5206so14332366eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780333437; x=1780938237; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDxjxajjjz+WXaa2HC01+77k69ejzz46zXU7TmxK8gU=;
        b=c8zku+oaTIE4+vxpg+7KrmNNGHSop9C2WtVqZ0oNF05BPNaGvHUFnuI+zI6GzXfbwe
         ikqnmpozZwPsBcNwcOMRiaiGeY+Uz/Ei7hVEf1GFRfspgu+JnJWGtvWUvwLzNNBxzmZV
         C1Jl8n4oCCOf4D+8PkSlfit9DAhknGJU5mkSt4wST1Uakbpbh62lZ2mY8EVCgOVf/t5W
         EapBjL4E3k85qK76XW5vZn4P8pBMK9m0p4UwoguxdeybgyWnuMfD1ct2hIW/KA5rvMyi
         hmaw0U5n2Kc6SHQH+69W/JX9K1Ty6GamRqnYNR0jHm5TDEfoaU6EGInEEh1t5+Mzagtp
         +f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333437; x=1780938237;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDxjxajjjz+WXaa2HC01+77k69ejzz46zXU7TmxK8gU=;
        b=AtXL3/yO3R11ThHrKGm6Ww3UfnSu/gmxHnxoAWztIQHzMErDBPXuhAxhS/6bLwDqXl
         BoeA4EyfTf5FmE1kUG78ZyNc5D3urIHZ3QkqgWdQWzrQSxMN20SMNvbF9ABJ0Fq5XpRA
         vaQrEzPyr2PU7GEpudn1yGNQnAxZ2nCk5ixxD68aaQVjgNeaLH+9Iv2tO/eNz/BSVX5u
         ZXot6f4ZQTs/n9cRSMfHsifzTl2wqJrBMA6CtlDY3/MNY3cAV4gAwgGkR51Se9EBnFzE
         ny02+AVBZ4Wlhle2z6BHu4zS6wXt847DUUmNlxBkyXFrmab3ZGJYDzjV8h/4m5sNqhHR
         WIdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/x0dCDLkaA4HvWKjIqPxV2/pbO9YhatIVIjEUKjSqAUROmYwCQ7LLjbZlaKCBOVQOxLKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/mi+pU8qbdO6yfr1pRtajPuLBeWpmDrxv33hs6xHKgruUM+q
	7K+pumNPBPGBljVyvLnje3bAM30A0oORCzvxJTi63HR1+fis9tseodlk10Arq/jbcBE=
X-Gm-Gg: Acq92OER2R62QI4z2t2JY3db5qYNy3dCeefqhVaDcce8PSTieG3gUuTGHxw1N+FgMm4
	LHxLiZ4AnCd1hYJfvNyl6u7LMMVas6M/6s6qljtVqU/t11XNGiANDstHWekDLZdr7i73BqcU2iX
	GbhYNOOJPrWCWt9BsCs7IXzByrb1ENRhNHBN4jtv3ElNJHaN5GA60gwZTenui793OtB0m7X65TH
	WxS2vZIY7o4MmfrgN6n9w3uk6N0yFjp9WqcvTexdqYdRU8YMFwzAB79T5X26RsGV1BYhNKColr/
	HueAqJPWjeJzBb3h8rFM/9798CFtBk+vHzVFw6SKzgjcgMv7HtJWV1UAV07dOXALa+XoGlXMr6D
	i97BNuqJL8O/FroTZNeJ0BHZ+A7U5MMkPTU0ATIxe9YZuwmI3O6v8vXW/UYy+DPS7K5BYdPELsC
	7TRCly2ytERFAoUX4=
X-Received: by 2002:a05:7301:1f0d:b0:2ed:e14:42e9 with SMTP id 5a478bee46e88-304fa693628mr6131496eec.34.1780333437177;
        Mon, 01 Jun 2026 10:03:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::a996])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a0b7dsm9613132eec.22.2026.06.01.10.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 13:03:52 -0400
Message-Id: <DIXVJ45H90X3.3DOQOUXJB6DVN@etsalapatis.com>
Cc: "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Guillaume Nault" <gnault@redhat.com>, "Ido Schimmel"
 <idosch@nvidia.com>, "Fernando Fernandez Mancera" <fmancera@suse.de>,
 "Peter Oskolkov" <posk@google.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>, "Leon Hwang" <leon.huangfu@shopee.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601150203.20352-1-leon.hwang@linux.dev>
 <20260601150203.20352-2-leon.hwang@linux.dev>
In-Reply-To: <20260601150203.20352-2-leon.hwang@linux.dev>

On Mon Jun 1, 2026 at 11:02 AM EDT, Leon Hwang wrote:
> Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
> When a driver, e.g. ice, reuses the stale skb->transport_header to
> offload checksum computation to NIC hardware, VxLAN packets encapsulated
> by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.
>
> Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> encapsulated packet uses UDP, so checksum offload works correctly.
>
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Cc: Leon Hwang <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  net/core/lwt_bpf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..65d1dfbf3312 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool=
 ipv4, int encap_len)
> =20
>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool =
ingress)
>  {
> +	bool is_udp_tunnel;
>  	struct iphdr *iph;
>  	bool ipv4;
>  	int err;
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void=
 *hdr, u32 len, bool ingress)
>  		ipv4 =3D true;
>  		if (unlikely(len < iph->ihl * 4))
>  			return -EINVAL;
> +		is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> +		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphd=
r)))
> +			return -EINVAL;
>  	} else if (iph->version =3D=3D 6) {
>  		ipv4 =3D false;
>  		if (unlikely(len < sizeof(struct ipv6hdr)))
>  			return -EINVAL;
> +		is_udp_tunnel =3D ((struct ipv6hdr *)iph)->nexthdr =3D=3D NEXTHDR_UDP;
> +		if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr) + sizeof(st=
ruct udphdr)))
> +			return -EINVAL;
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
> +	else if (!ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct =
ipv6hdr));

Minor nit: Could we do something like

if (is_udp_tunnel) {
	size_t hrdsz =3D ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);
	skb_set_transport_header(skb9, skb_network_offset(skb)) + hdrsz;
}

to make the logic clearer?

>  	memcpy(skb_network_header(skb), hdr, len);
>  	bpf_compute_data_pointers(skb);
>  	skb_clear_hash(skb);

