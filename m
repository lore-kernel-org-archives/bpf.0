Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842752;
	b=Wnlr4aPgEA8nLJt3za3Y92v/C6M48DiGABNFeu0/iuoB/Sx63sH/nX24TBayCrWLWAdg
	 qsmC+dPb4KBE06IatZvH/mAm52ofmbMIfRL5eAwbrtt2yNcBPgE8gxR0hfeEGwVB9Qj9R
	 k+zo8Rs0lco3lTwpaN/xBoGMWUESd5nKTYXkngUIZY6/jzY9ryVJyqvl68Ywjp3YNYOHf
	 xrUckfLIV+HpTRz7cKs8pP5m8TLfruj309WnWxkDoPQ5Dd3q2ZJDRvl4tskaXO72pMfN0
	 a0778Ebg0IFQerEoykzFyIt/QI7MPAUmlxyt9eXqYeQXHqC9PhC9UG9KHQ6nx5ysYTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842752;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CxECcGoxG4bJHUkxZ78akWi3QF20UqitrJenE+Sv7pU=;
	b=TRbsZs3hc2AOe5AZJ4zEbW9IC0fmJApgOE9YAZZxZ3hmKM66j9ZAzN9HcIAUW/CK56zC
	 7KOEibv3tJroQnufXcDnXyzqplttBXV/1VAzX2AOEHxfjhdzC8nUPQuuT9xl5jtG/Nkj5
	 0C0ykQuUHKM4JLbFZ59o0oC5vU3r24Jelhq91KoufopDQvG8+lcqpHSSwN7bp5Yzqcg9+
	 bijPX+t5y2Qq2YmxsQvHBWFGBwoVCMzR7IXU1MRVCH5BJRhSpgf30BWc0bWLYXpSz1Q+J
	 hMEjrRFhvChYu+w3heX39OF0JjbkF/tQgsMr/8CAD6s8un8DdEknqnghozmMOwu3CDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs+5J6Rd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB63606A8A4;
	Mon, 16 Nov 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs+5J6Rd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56911F000C7;
	Mon, 16 Nov 2026 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842752;
	bh=CxECcGoxG4bJHUkxZ78akWi3QF20UqitrJenE+Sv7pU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qs+5J6Rd9BZbhbHnL22oXoUQCFp6iG5stidvs2j647DC2P6eXFadypiq38Q3D3XVW
	 BJuSM7e/oehj6rkuwdt9vMD6hL7JGS0btpUBzuWxsWKkV0v4SYDtuTYMFdoaRpnla+
	 g3TmbRvXZxt/myK1BAzTP9AF/3dAFWlRaM4bpsAul8hFUYUkEfDTI22T/MAPpF8BnT
	 /DEs6hc8wNqhrydfvnrVfzhPu6N+CjKART2xll5e0r/G4nnFTyCqFLpiBF8I0zs4WK
	 Qod7lXTDRzmBJnEI3T6izL52TK0ptuOZ9n+werwflVKWAwXqraG52XrU6o1IcVSGjx
	 M9ZioekCFC/Lg==
Subject: Re: [PATCH net-next 2/3] tun: don't disable BHs for the XDP program
 check of every packet
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 16 Nov 2026 15:25:51 +0000
Message-ID: <179484275129.3136.12211553035452382830@kernel.org>
In-Reply-To: <20261112150612.3866546-3-antonio@mandelbit.com>
References: <20261112150612.3866546-3-antonio@mandelbit.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In drivers/net/tun.c, the patch adds a function-scope `bool xdp`
  to tun_build_skb() (line 1705).

--

tun: don't disable BHs for the XDP program check of every packet

The patch removes the RCU/BH-disabled section that tun_get_user() and
tun_build_skb() entered for every packet just to check for an attached
XDP program. It checks first with rcu_access_pointer(), and only enters
the BH-disabled RCU section when a program is attached.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9fc60a73fb963..395923651f312 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1702,13 +1702,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	int pad = TUN_RX_PAD;
>  	int metasize = 0;
>  	int err = 0;
> +	bool xdp;
>  
> -	rcu_read_lock();
> -	xdp_prog = rcu_dereference(tun->xdp_prog);
> -	if (xdp_prog)
> +	xdp = rcu_access_pointer(tun->xdp_prog);
> +	if (xdp)

[Severity: Low]
This isn't a bug, but the new function-scope bool xdp in tun_build_skb()
is shadowed by an existing variable of the same name further down in the
same function:

drivers/net/tun.c:tun_build_skb() {
    ...
	xdp_prog = rcu_dereference(tun->xdp_prog);
	if (xdp_prog) {
		struct xdp_buff xdp;
		u32 act;

		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
		xdp_prepare_buff(&xdp, buf, pad, len, true);
    ...
}

The bool is only read before that block, so the behavior is correct.
However, the function now has two unrelated xdp identifiers of different
types, which gives a -Wshadow warning with W=2. It may also confuse
anyone editing the XDP block later.

Before this patch the gate reused xdp_prog, so there was no clash.

Could the bool get a different name, for example has_xdp or
xdp_attached?

The later patches in the series leave this unchanged. Both declarations
are still present at the end of the series (5b2d3d96af5d).

>  		pad += XDP_PACKET_HEADROOM;
>  	buflen += SKB_DATA_ALIGN(len + pad);
> -	rcu_read_unlock();

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112150612.3866546-1-antonio%40mandelbit.com
