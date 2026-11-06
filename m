Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937017;
	b=H4fijZ13C/uKkFpIx/rU7h0UDYm2RVqqImPFLsTYKKsduDBBx5Yv5ZZgiiJKduEurFTm
	 Akg9ciB5Ftrhj5sPvQnEkZtet+Zrk+7mYAm1QY1z3hf9M/NCrpKv+oLBz/rVEkw3zfapJ
	 huolmEp+OtzixT0+TtIjLnAMmRAcKEogjEt+J26j16yuhYFLpkmA2+sgiH1GdrK9rceao
	 tbE0bFLikCscSFyzumT9QLsRRfi0v6tQW7L158OXx1tr7sQi7nYDjUxTYbPAE6KdMHUQF
	 aI0pIOyzATlLyQHK0b6emDDsAIYqHbGydxa7Tbno94YeXKpmFNjACRB0t6aWFF8OgKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=mzWNIgox/w4qNjiRIlcPQMIvLrmBH31myx/g/3s6wQA=;
	b=w7hi1YZWpLYGK1iKGDPxcdwiKCHJso8g2rs5mEZDzw6qNIwYrige87hb8Cm7uWIOsLiY
	 stYIiuz2Ud4uPJj1VN87rSk7RhD0LwRoNGZv+O3KIjg1rQdPe4Eb9CKAb22yOOgRci1Jh
	 6309Zty4zgH4CofeaU9AIhwpc+8Kyex1gasWO7NIglrukkYkHCqolNuyqZz3vq6/48T5K
	 Z9LHGcNYdXeocUgeFGEURFxNM82ZL36HPyVCD8xChKPWH42RoM9vPoiqvtFgQ0du9p+Py
	 /rjJW7IP7Ql72e3etKEA8w3Zfb9neZQe8z6W/6I1vSLrvvjVqpPIj9Z82TzA9V2TM9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvSH5nMQ;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD4606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCD4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qvSH5nMQ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so121194a91.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937016; x=1794541816; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mzWNIgox/w4qNjiRIlcPQMIvLrmBH31myx/g/3s6wQA=;
        b=qvSH5nMQv96uu/Fnl0su+/LAaZ43VJiHaYCmYpPGAOk/Ju+NE8lTdad4+eQf5vvj4u
         26iatJElu7RIlaEovBJHVBFuGUSan5FxnyPCy7cs7x+oKwV039X0z6pBuFmCHc1LNWh9
         +lkXwrg9feV46Ai91AmE4xkEupWH5sZb71NKbVklp/uvJ0JUqGxhMjBw116wEmK3piLq
         3OFeNqq01y8QJkWdh0XtlUBNNa6gpWXsTdjLrLYG/c4deRHZM1cnsWlX9ETk2E4knqe5
         gb2wENguyDUMV3nrvMw/JP/BWdpSS9P++c7ti9U6ruN2jdp2ksw/dW70uHw8Rkmm8C9F
         Ivow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937016; x=1794541816;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mzWNIgox/w4qNjiRIlcPQMIvLrmBH31myx/g/3s6wQA=;
        b=U7aCzocvqj77IhhadsBv+HjKsqg1Otcc0iTZ/CNrNjOllEUZk34ju9GJlzW89nlLTW
         L8KTpa15qFHnd1ExxGU+N77u/l1VCRfsvNy3ir9Sh4lx8rvaFp/xmO6LJCdMoBVrj4I9
         gf2Ut8s/tIGPr2N0beMYiU2+CBJ8De2uQDr0riJWn+7uTSrUMa9xC5SPs98JiIYDimE6
         N8EjXDpoo42Lz9kRVOZtTUmsHG0i1w++BWEix4CDG9voBNUkiIb5v6bQ/F/AnABPEaXy
         xuie8ZQw6m4DVoGPCJ6enugSXP/qdxfBux1Urdo6y0pYMEcIpaeU0eH/XKQ1c6UCB1RZ
         1XXQ==
X-Forwarded-Encrypted: i=1; AL+hErHu3h+NWsKUTf2zsqeern0KAahDTHdc1Tc8fIWALxjDqsQMsHRi2ZQ0kSdM5ewCZpkGduQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+DOQm0dgsdXqBOOAODsdQPOMss/0gkZVNtpLBPXcU4ViaujnE
	C+8WQ74oGoOUrUrlpDqdJSYQhFV4zxUoPiBvQVMqvEqpqOJFXA1ZznLt
X-Gm-Gg: AYBFou1Hw0Cjpf91P3lIz7r72OOKObFx0MFVEk3nChQnXE0C9egyaXS13x1r90FDaQK
	PDvsnS0RgWKLAWGMqGPFW2qURlGXt8G5XgQX5P0bLq4zTIM+R/HOi9ysybIv7cLJgAGEW8QHjvW
	+CNEAg0N4BFtQ+38EXZobJydSlh3phOreSaeLcfUcmF6Yq1N3Gtq2TLbJTwU7JPKnxHS2Gg9D34
	PfNddeAqdQBj+Tm2XT69UBP+oqVBNI4nIgzbLlouwIq4262mnIRzvPbHZztmh7IHjJxhn788hfj
	dI3MDRdfYfj97sNlx3XQagh/xbQGa9Rcky+AkWS/IKPa+cNt1jNqFYODx7eE++AnTyn81QgZpOQ
	/d8uLtv0o1kExkiVH2PR78MmnqZEJuLWtW1BjVAFfljREtpWFBNblU8H8/6iazVj4Y8Xcn5fBRv
	9Ss+Fs5PgemOY2KofTIPUYmhh+pzoBbOCXEAi3KDSahYl8oSz3IqvUIbG+81CVhHmrLxN1x81EN
	6LTl8/CnRNeDETQjSCwK72HwMTD/X2Hp0NZXPLM799ZTsNhTFXKcHTkkwDXGcA3di2pUTTmEV+O
	nWZl/P0TXxYdD0EFnst1ZT9ujFk6dnJN8c9yC5ekPzVsiFGkS7kpdL/brHMNrd7FHLXFFaqHwr0
	4hKR1SAjfuU8fhqfigndxzLQcdbuH6F1O9Q==
X-Received: by 2002:a17:90b:4ece:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3b0db705fd7mr1132135a91.33.1793937016161;
        Thu, 05 Nov 2026 19:50:16 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e57a8031sm5076a91.4.2026.11.05.19.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 19:50:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 03:50:15 +0000
Message-Id: <DMNTLJOZ13N4.2LG5MIRML7XOZ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sariorkunemin@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Josef Bacik"
 <josef@toxicpanda.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: lwt: Don't let bpf_lwt_push_encap() wrap
 gso_size
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261105-bpf-lwt-gso-v1-1-cda5e19d321a@gmail.com>
In-Reply-To: <20261105-bpf-lwt-gso-v1-1-cda5e19d321a@gmail.com>

On Thu Nov 5, 2026 at 1:23 PM UTC, Orkun Emin Sar=C4=B1 via B4 Relay wrote:
> From: Orkun Emin Sar=C4=B1 <sariorkunemin@gmail.com>
>
> When bpf_lwt_push_encap() adds an IP header to a TCP GSO skb in
> BPF_LWT_ENCAP_IP mode, handle_gso_type() lowers gso_size by the length
> of the header. Nothing checks the result. gso_size has 16 bits, so a
> gso_size smaller than the header wraps, and one less than the header
> length gives GSO_BY_FRAGS. skb_segment() then takes the segment lengths
> from a frag_list that the skb does not have.
>
> This is the problem that commit 12d07c38e1b0 ("bpf: Don't let
> bpf_skb_adjust_room() use up the MSS") fixed for bpf_skb_adjust_room().
> As there, gso_size comes from the peer if GRO built the skb, or from the
> virtio header if it came from a tun device or a packet socket, so it can
> be as small as TCP_MIN_GSO_SIZE.
>
> Refuse the encap if less than TCP_MIN_GSO_SIZE would be left, before the
> skb is changed. Return -ENOTSUPP, as handle_gso_encap() does for GSO
> skbs it cannot handle.
>
> Found with AI-assisted code review (Claude Code).
>
> Fixes: ca78801a81e0 ("bpf: handle GSO in bpf_lwt_push_encap")
> Signed-off-by: Orkun Emin Sar=C4=B1 <sariorkunemin@gmail.com>
> ---
> No reproducer was run and the fix is not runtime-tested. Build-tested
> with LLVM=3D1 W=3D1 and CONFIG_LWTUNNEL_BPF=3Dy. checkpatch prefers
> EOPNOTSUPP; ENOTSUPP is kept to match the other errors of this helper.
> ---
>  net/core/lwt_bpf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec6..c151a013a8 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -13,6 +13,7 @@
>  #include <net/gre.h>
>  #include <net/ip.h>
>  #include <net/ip6_route.h>
> +#include <net/tcp.h>
> =20
>  struct bpf_lwt_prog {
>  	struct bpf_prog *prog;
> @@ -632,6 +633,14 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * The MSS is lowered by len. Leave the least that the stack lets a
> +	 * TCP GSO packet have, or gso_size can wrap.
> +	 */
> +	if (skb_is_gso(skb) &&
> +	    skb_shinfo(skb)->gso_size < len + TCP_MIN_GSO_SIZE)
> +		return -ENOTSUPP;

I think it was fixed already. If not pls share a repro
that does so on bpf and bpf-next.
pw-bot: cr
