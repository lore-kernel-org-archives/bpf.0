Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22147D93B
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244818; cv=pass; b=e8UtqJFY7lX0B7J+5NrspX+OSArgQzuCX2IT2NGzf/5yHrgHbuQQho2ovk0ljgfN7PZSjEXiBHvN5RjRm8dlUN/NHQ0Jhmw5lvejdKfYpM2WhRSHXWbcM0afhX6OnMAzzP6GSCYIfJspP0j5F8wpBWagTPFIjKuLPlB+5HVzCMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244818; c=relaxed/simple;
	bh=opv+LcA4ZOcz1hOTwwMwu8TEujjGyrr+wXGQrHmuxS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4jZ2oHhHZgERtI92UtuVY/g0qIRo4//kpDUDGUtIOouQLQgGWvbq3FhXqm9ITUFRRcnrnl2Q+bgeyi3Df9aoi/Y0ToT0dWuj61rUu7sTLlI4e/WAHBeqtukaKPx95wX2nhtTsoFtR/01267foOdj4xAAszUnEBUf50clVuj3Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3VaW6cH; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3VaW6cH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2cce930cso148281cf.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 09:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244816; cv=none;
        d=google.com; s=arc-20260327;
        b=qG90dS2yXmoJIv6WfOKI4ddoTxeXGR8XiKSlwxrQQOaEtnQ/GWgBDZKTknwKcAzECN
         1qWiLq+4/pTpFZ5gwmHvzmIfMgfk61t5EE0vVBJiUguhhBzvWqFfFoG1qccIRL6CNPYr
         icHl6jDwcB03deEji1ZiD+MBopTNFTik3TU2EOy8uZxK8k/BXhoH4mA9gFGFfznbBoqt
         tFZqX5HZZ13unfqEDJUWgHhxykIQB9HvCjJSOqESUzQcFkwwwxRGibAXxjVj2kLdut13
         YfqHtsjpI5rQRLOPBlDB4FwKhGydeKBgkwRQywtpCgHNVE9qjsUgAKjmxYYf61X+NzDO
         B7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGH/yJHkK3M0IjwHdyO54yj9vy1LgGP/hn2OsWlWuBY=;
        fh=Vip3FbV40aVdjj1Hcowis7XuNLzukVVeYKEq5hmr08c=;
        b=fv4vxYq2fUczQ310bdFDn4HyhmaYMcn3FXujGHbzS95ZsfLg3dquCQM1v8h68tt66A
         9vhlJbk525bz2J3BTopSiQa9Uq99r1qAWsdO7PdmYWDZiBb9gK1dHvfns3bazAOqVNV5
         IdHa0ILoX3XvWc+kvsOYOB2ZZhcJnarKawp6ZEGBglmGZ8Aa66/hBe210X3vgYcIubwY
         FwHy95Io4/jka8iifjxTN29O0nfNqrDoIOeyqHJfzrS2mbnV4+RrxAMYaiXPB60ETWsD
         FlR8ugsWeWP1fucthTfA1ohi2bLTFvtSW8rv8U1pRGKCCG2CUKcx7bGmcV6HIZdIqyra
         yWUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787244816; x=1787849616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGH/yJHkK3M0IjwHdyO54yj9vy1LgGP/hn2OsWlWuBY=;
        b=c3VaW6cH/RmcBLe5Q7owLG4Phz5yK5JoA/uuZzRoBbPVsOCV6ixO1lDMjRI0/f5yQQ
         g0KSm69gsaK8kFhSgXFn1II6Tp5+wgnHszxwwC7SVUUw6MMgR60+lglwQm2RUAaL7ZO5
         GrD8QJWMh9KJi0iIec3t+S8hFLxvqDdyNlGiT7msdLi81XtmOV7hXHX/ZFHw6GrnBY7F
         ShTzrRg8Qrmn+STSiPh0Ra0KFmHTx28f0FN3GkhfkC1Hx73xNXssnza+Mq84pRNk/B7W
         +YYWHKjRwaFY6M7HC61LgBWJROVVJNBEt4sl+uP/r8jIF2TwitzFak0l58VIpHJRhMUc
         s5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244816; x=1787849616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGH/yJHkK3M0IjwHdyO54yj9vy1LgGP/hn2OsWlWuBY=;
        b=h69DFn0B00g6+7rSpSACWvRts6x/mtbdTh1mvBEJIBPssarFJFz4xxjuMpTAuTsNJZ
         ye913/aW3izLQH77hSNNFbK5KIw4V/JP1YZenCRQybJRBrObWIrJDwOKQ6fjkmuTLq7s
         44Mq50I4aSd3OsR7GcyLA002EQHKy4zvZp4J3ubAzoTzV9207ypJ9huzUF23Ht56/qGe
         4WWPsPOr0dq7arV+mFhZwLtvy9M8WBySycYwPZp3OYGBwTGkvMps9ChoAXYU0BryrAc0
         AUPPHC+4xpjquPIuyJnwP+ncvTDJl+tqCcNG46Xnrs4vgxO1ZQfw5l0oS216Nzxc8O0M
         /Vsw==
X-Forwarded-Encrypted: i=1; AHgh+RqPm2nT2FqBBSNUcKmSggOkD61rc5nXqBo8aQ3q/eh9zFmsS969OmLGR3oDZgQToAHZKVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxto3z6VSkO3fL639XAnCLXSmRkwXzPxvDnVUCTVWeipDmTCEFQ
	U4jxM95uuj00F42q2C2/UTsngCiKVKFDpsOMe7lSb1XvHxElj861y+xxXiiVUwS1ukmXvBc0Fp2
	QQMUIqBW6x0g6YR6fw6UOlxJ5FmVqnZhJptPwUpSK
X-Gm-Gg: AR+sD13chx2qFXpkC1ZMnwoS9FL0Q/XwoRI7UFXcpjtfcFezxSur3JNyBGJDeHjjP4J
	7CTx6apl8IOq6HtGxsQxFY8LHgquu8fDg0yvqH7JGELIwmU4i1xE3stkMpxfYPResObQ1+lj/IS
	q5XZO2UrfafzqVtSBlaPjc9um5E9b4ZGC12VtbH97gSjqPHzyG4xKrvZOAk22PY/jgmPHvSkTmN
	2JFU31D0tLRQH4yVeNLuVpGBpayi9SRboookQYOitGMZuNF3dJy9qP3jl0qvrF/GNC3ZYyGfn3R
	leNbPWEcxBKC1ETOleiUmLRst3CVIPbdrEmmoHGusXAcHKX+RTIZw1IhU84RrU2z7KP6O1qzux+
	O2jMKfGXJ8uJGvbtMo2MF+PRdx09z+bsRkzIdBvJ6lIXkCwuptTDhPhewsg==
X-Received: by 2002:ac8:5f0b:0:b0:52d:2ddd:27c with SMTP id
 d75a77b69052e-52dd5cb09c7mr113827831cf.31.1787244815224; Thu, 20 Aug 2026
 09:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com>
In-Reply-To: <20260817153957.3177627-1-poros@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 18:53:23 +0200
X-Gm-Features: AcwNN1Xb91DpV9WY_Q-Z2-aLqA5VqqqNBYRmDzZhkVHQO2OraLaV1QOhEcvG8-s
Message-ID: <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> wrote:
>
> __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does not,
> so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
> the sentinel left by __finalize_skb_around() and skb_mac_header() points
> 65535 bytes past skb->head.
>
> The packet socket reaches it through packet_direct_xmit(), and
> packet_parse_headers() was taught to anchor the header by
> commit c2707480cfbf ("net/packet: reset the MAC header on the
> packet-socket transmit path"). AF_XDP reaches it through
> __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
>
> ice reads eth->h_proto through skb_mac_header() on its ordinary Tx path.
> On an E810 every one of 2817224 AF_XDP frames reached the driver with the
> sentinel still in place, so the ethertype never came from the frame. With
> this patch all 5757920 frames of the same test carried the correct 0x88b5=
.
> An AF_PACKET sender on the same port read 0x88b5 in both runs.
>
> On a KFENCE kernel that read lands inside the pool and gets reported as a
> use after free of an unrelated object, 387 times in a 180 s run:
>
>         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xddb/0x1=
650 [ice]
>          ice_xmit_frame_ring+0xddb/0x1650 [ice]
>          __dev_direct_xmit+0x347/0x4d0
>          __xsk_generic_xmit+0xc13/0x1e70
>          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
>          xsk_sendmsg+0x6c/0x90
>
> Rerunning the same reproducer on the same E810 with this patch applied
> produced no reports and no bad reads.
>
> Anchor the header in xsk_skb_init_misc(), which runs once per skb for
> both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
> real header, but it stays in bounds and no such driver reads it.
>
> Fixes: 35fcde7f8deb ("xsk: support for Tx")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  net/xdp/xsk.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b640..885427392cb6b3 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb, str=
uct xdp_sock *xs,
>         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
>         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
>         skb->destructor =3D xsk_destruct_skb;
> +       skb_reset_mac_header(skb);

I don't know, I had at some point the goal of removing our dependency
on mac header in ndo_start_xmit(),
as this must be skb->data.

ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
and save few cycles.

Some drivers call skb_reset_mac_header(skb), this is really a mess.

With AI these days, it should not be too hard to completely remove our
dependency on mac_header.
