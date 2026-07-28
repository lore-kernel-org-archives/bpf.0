Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E21318ECD
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 05:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214980; cv=none; b=ZreFuVQOro7PkVq1GftLNB1HilLEZNc3OcI8l2CuPfKC4i0Mq56ruRanY6WFoP6RYkWVT1RxY7KZ2alSnEskneRyrsq494VZNM9oIFLndh5XNu+LAvT0M3Lu70R2Zq/bBNHFWzbtY/XGq1694kqEsJQGs2FzxTo/PCksaDQQfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214980; c=relaxed/simple;
	bh=B1+FcGLNGHC2B68SCNV1Ab2PSSGbZaBkxLmzzxAqds0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=CbELcpdONWskP1Sv8OaFtjMyCumXXELqsiLsMiLp76+2jwglQRW9TRo7sq2mrRx8vUn1r+cf2Gulo5a5GtLCPb4Nb/aj1otKoBAu1Z4a8Cow1S+fUw0uboLW5oT6HmL6mOVyUicbXo3m+KxCXqGxOhiYOimnIHmftvh4s5q0wog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mHGOGKpH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mHGOGKpH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceab75934dso43288025ad.2
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785214974; x=1785819774; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T8aS/uejKv7louod86vZ2BwR/yZM1ED2aHRqvrv+yk0=;
        b=mHGOGKpH2+h9m9YS10fh4OP1g5R0+jvwrOfmHU+UTlYaDeLuNu4D3/IAWFTydLAIAg
         RZbQ59zfkxFRBE6QEfuO3heDmytlJKqSVvkHp+4yfHCfyjviQuGzjNWTlM+2Bbz7QESE
         G/lPl9/gGlDxdQv5neJpHyPwLSyVJ7N+jjOYjDh7Z9KA0pF49bGQ5TnM6pe5VWTg2Tmf
         3Sva5gdwcjr6nLchMZ9nLYdFxrUoR81C9sPra1HoVoOVC8TMUzH3uIO05xEk1iFO8ghQ
         RblYXfhXsTxKG1QErPglm2wtvQLp3zQQRZr8QEGDn6CnDuyFhe1ZcG0qGAdMhs3bxLcT
         jURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785214974; x=1785819774;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8aS/uejKv7louod86vZ2BwR/yZM1ED2aHRqvrv+yk0=;
        b=sfao5k2OxjJVb3iKUsTama3q9+I5G9zXe1b5yfKCx/VyQONAI8sh4S/A8QzQ21SIIg
         FFyuXDXcgCGtLOuw/ycsNeGsbonycfG0QdC94mIwm7TBi8iQhZGBh2t1i7t2N5L+NLBT
         Ei6wp387XUFS72mSlHGMkOBFwmFv9XjUhwM4olCD0q5j03Lf2jLa1C/zyhtlnLJGD56v
         1WWyWK3K8H0/9wKv9+YttZs2ElHlA1fXqhu9xWXEtPzWBrBqJFk/9EwdTd8asBtt3sIF
         3Ik8O9Gq2mvoo+EahlVUxjOpLAFY1rUr+pujW82SKQZf8H1TbrJCgKvywiNotO1dOivD
         KpXQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcUIWo/iB2rK9EBfS/kLZhKveqVVED1CmmBm3f38APCU/bLis88fAWVd/his8RGhsOYPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5WnkKOoVBkUPfTiT3lTro4O5B8uCr7F5gaUspY0zCHVyFdCY
	m5TQbxNlzXtNu5w1d/e+l6fjnBpWFdNsHKxVUqRg2j7PElomkyV9Hf2zzKiVyVIt7KU=
X-Gm-Gg: AR+sD12FzLZ06boKrNljaNTv2UYXvL0lNsqAqHRo9EUNT/EhHbQmj64IFe1/y+tqiIP
	w+HlJOWn5raG0V661Kq1M4/ISMQYqehFf6C/jza8ALfIRhLpBOfrbPHyaF6NgXxxVNyE3yRn8DI
	1M0jtx4E7MmhJVmoJwMyRc5+MqE/ph9cRBuzBk6JfzWcA9zPNN/+6UlJ3a1/01ZdLRSSFPlYJmA
	ylXzZRwjPYfQaZj9zjVynpYg4hNCRuuVFEBaAIc8NpWMvNgotMJ9J/ED4xGYalPSUsbcyMnYrM4
	cC3smqfrrVKd9jS44FRuLdXjGkdI7jrDuk9K5vVoBWaGpSRhrgxMZcawzVBQNUK06cSOl46lUZn
	cWY2rAOmCHJIYr/1Iqc6Sfp3v+UCNtA5ojumoRbI9EvFIZYlaCqydFegCYPB+MjMfm83iQ+UPrh
	VEVHbRCRkl/stIYdGpA0bzlqapKHtxjnN++TA18AV7CQ==
X-Received: by 2002:a17:903:3c4f:b0:2cb:2b69:8d53 with SMTP id d9443c01a7336-2d015d94ccdmr8414675ad.37.1785214974397;
        Mon, 27 Jul 2026 22:02:54 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc585sm44893985ad.51.2026.07.27.22.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 22:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 01:02:51 -0400
Message-Id: <DK9XW469QE7Q.18L1HIO9BRHC@etsalapatis.com>
To: "Junseo Lim" <zirajs7@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "Simon Horman" <horms@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Martin KaFai Lau" <martin.lau@kernel.org>, "Leon Hwang"
 <leon.hwang@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Guillaume
 Nault" <gnault@redhat.com>, "Fernando Fernandez Mancera"
 <fmancera@suse.de>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Graf" <tgraf@suug.ch>, "Sechang
 Lim" <rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf] lwt_bpf: account for aligned neigh header length
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727103005.897983-1-zirajs7@gmail.com>
In-Reply-To: <20260727103005.897983-1-zirajs7@gmail.com>

On Mon Jul 27, 2026 at 6:30 AM EDT, Junseo Lim wrote:
> ip_finish_output2() expands an skb to LL_RESERVED_SPACE(dev) before LWT
> xmit. An LWT_XMIT BPF program can then modify the skb head and still
> return BPF_OK, so bpf_xmit() rechecks the remaining headroom before the
> skb continues to neighbour output.
>
> That recheck uses dst->dev->hard_header_len. This is not enough for the
> neighbour cached-header path: neigh_hh_output() copies the cached hardwar=
e
> header using the aligned hh_cache size, HH_DATA_MOD for short headers or
> HH_DATA_ALIGN(hh_len) otherwise.
>
> On Ethernet, hard_header_len is 14 but the cached copy needs 16 bytes. If
> an LWT_XMIT BPF program calls bpf_skb_change_head(skb, 1, 0), the skb can
> still have 15 bytes of headroom after the program. xmit_check_hhlen()
> accepts that, after which neigh_hh_output() hits its headroom warning and
> drops the skb.
>
> Compare against the aligned hardware header length in xmit_check_hhlen()
> so the BPF_OK path leaves enough headroom for neigh_hh_output()'s cached
> header copy.
>
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> Signed-off-by: Junseo Lim <zirajs7@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> Tested on a veth pair with an LWT_XMIT program calling
> bpf_skb_change_head(skb, 1, 0). Before the patch, a UDP packet sent by
> the reproducer triggers the neigh_hh_output() warning and is dropped.
> With the patch, the packet is delivered without the warning.
>
> Below is an excerpt of the warning before the patch:
>
>     WARNING: ./include/net/neighbour.h:538 at ip_finish_output2+0x19f0/0x=
1f80, CPU#0: lwt_xmit_headro/55
>     Call Trace:
>      __ip_finish_output+0x59b/0x8b0
>      ip_finish_output+0x67/0x390
>      ip_output+0x1db/0x700
>      ip_send_skb+0x1f6/0x270
>      udp_send_skb+0x8d2/0xe00
>      udp_sendmsg+0x1717/0x2620
>      __sys_sendto+0x443/0x4e0
>
>  net/core/lwt_bpf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index bf588f508b79..2890aa59a3a0 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -169,8 +169,10 @@ static int bpf_output(struct net *net, struct sock *=
sk, struct sk_buff *skb)
> =20
>  static int xmit_check_hhlen(struct sk_buff *skb, int hh_len)
>  {
> -	if (skb_headroom(skb) < hh_len) {
> -		int nhead =3D HH_DATA_ALIGN(hh_len - skb_headroom(skb));
> +	int hh_alen =3D HH_DATA_ALIGN(hh_len);
> +
> +	if (skb_headroom(skb) < hh_alen) {
> +		int nhead =3D HH_DATA_ALIGN(hh_alen - skb_headroom(skb));
> =20
>  		if (pskb_expand_head(skb, nhead, 0, GFP_ATOMIC))
>  			return -ENOMEM;

