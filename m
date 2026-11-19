Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795096769;
	b=QYWnThMeRmwRNhcZZB9oK4AdcYC/8x7xJhwSO/yCjJjeDsQTzncBF/Nyzd70Jwo8bgtj
	 M5h10gOJ9Ukn/i2pJgFEXbeYgULC3JgKMrCTVj1oIaW6VCB/ZWQK4j9OyBw3YIqLESnwo
	 OUXIoFYxErzBAnEi0Sb+LgeUbz1nFX0fAB83Udd8XH9pn5xxfc1xb5Bbgg8/yrZBETwNh
	 KFyefNKCKUpSC3lLos6/9swMAwD+D36uahWIKtV/F2dDHdtFFzHEaOzEo2CWVtppkjNwc
	 bNCiYpS17eUWQo8PJtjtkOikUnKxvK1NYw5BFmMLV4IP+IgZEQZTOXT6iytm0HI693A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TcRDSmxP6zrXXOwn1D/JZjQjo+HV2O0dDJiN9wjmZqA=;
	b=Lg9ZHxZkcrqGRAUGmVJmx2NBvBQN3q/Iwz3LDP8hcprFo8cikSswvOQAYu/mnOmWIuI8
	 NMehkUexZ/I/pawD9xkJn2HK4mlP7+hyqnZ2rymr4Xzbj+IWwPuDaFklzrjGcwcUMUuHX
	 roaj3qpDNWqDCIZhPuzQTJJpqT5BEDRguuZatOwG9IMowsA7wWbN9ZbioY93n9+edByFN
	 QSIW8utDQmOkNN2cH3tRLI+ccxKUSmVSb2rERHS6OjKcEemv0oLtiu5CoPBJN4sWS6KkI
	 jAS+FHCZZaDIeFjUBYJ2MsI2BmmB/wQ7vioO8qZ6wU8EaD8KMdbw5kZ/Gc6ne+q7ZzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SZ1IVyY/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A15606A33A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 13:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A15606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZ1IVyY/
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c14470729eso1687545e87.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795096768; cv=none;
        d=google.com; s=arc-20260327;
        b=gfc9JDtm6jPnofgvWmfSr8ogxJsOsIbhxnGYwUtgygQPdkcT8AAh3X3Bb5zYdfaDsL
         DX5bwU4GPqb8hezTBFgJmBNet9AFJBNEZVG0L2ZJKHbTJ7LpOyv45KS6w2xgNyDjQJS/
         WjLJ42AgfpzDA/OtGQTKi4JmZJgRLSJECQbrWXtYA5iZQAd41/+wKpoRkzmS2cNngBPa
         GoPAZ8nGApzOvoEMLf+YYDpV8OypmZfzfTiO1q2OqprzaSqoSALdu8yGdX8tarXgr2L4
         HkKVnut8omxjVI7zu8pziFy70hm/wW/Tb6S8wG5KIWOVBYzEJ+i9s7PbPgOxiZsu5Uhq
         yr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcRDSmxP6zrXXOwn1D/JZjQjo+HV2O0dDJiN9wjmZqA=;
        fh=+OpOdgJZV894Cksz5c1ZPE2/DRb/ZQ/z65/Fo1zVqLg=;
        b=plSuG+HUqVh957DhX0PIPoOs5CwZro88ODIufwCJgP6xlpFw+ocEBVEN9CriQ6xf3O
         FXDrk6BqFjZeuI/9q3r23Fj6fn+9Cyn69/+H16QeR+MoeuwsUQbl3QK6ryjeYSBK6BeX
         lDfXay5MKKFoTL7D4qa1QdYloSnxrdyVtPZtL8mjWmtx8h+Smz9z10YWg/skIu3x3P3R
         d+uZhvaaGelMvBll4VNf7JCJilfhN3VHAze1KploFoTGvDigLTSV2ECyDXk8ulZFFNJV
         DD1XlF7Q8YyfBOH70J6TOttdkqC5Zi9E/yyJ7PSN4NOif0qfV2jiCbjwLKvMXhccmzj2
         LMrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795096768; x=1795701568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TcRDSmxP6zrXXOwn1D/JZjQjo+HV2O0dDJiN9wjmZqA=;
        b=SZ1IVyY/NIo1cO/0Z63rRhIbPTAcktKZBXOjucyYeUpIoEhJdkcZKQOs/JYbmpRS2X
         1mxyAHXce8t5KJqDZTSvLwfMGSlCYv/1cR8E5bz3+uGYJdWxDCGOaeVKIg1nnCZOCfUE
         dBcL6bIxaH/l1xJR/Xzy4Gqz9MBo6WpnLC+IkdiPyZOLJdsgjEK4AUX6qr3YXel6nyzU
         YtPM6+4gI9e88av5HANyVOSoMJBosyF/38mBODeTKXfdDvQ85tmjPX/DcZLzPx9hOtxT
         2IQhpgRCLkZ9zE3FQDkYRKbCRR4ccsB5Sk32fJRqw3g187QtdqXbA4h9L8MNsizHpX4m
         9bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795096768; x=1795701568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcRDSmxP6zrXXOwn1D/JZjQjo+HV2O0dDJiN9wjmZqA=;
        b=P/wJkGiscYJJEJawtZe2gqUHCAW80caPpbZKM9MzPnm/mUE/EPv5jgY4Qexzdh5upf
         FdKDFMEFI7W3lo7nNtrF44V7sdRcmgqIiSf559YqC695+jBeTa7l+L0CI0TDakd2VZNZ
         5rHwl4PO6aiSNABTabdWBR0GKVzIdAGMJ1CmqjwQuxe/6Rysqo6GAOmLiNZAyZtUvv7j
         HxVO1yHlypY935S4fsodhTO7meQlKBkDz9u5oyEW89blZkSJdhWN9cRhLKUzVFYWvJ/K
         6hAfA988p/kqOYDeJszpqgFGdV822xpaN/I9ETQPctHU360gDWhSafbhs6T/ODbuIxC8
         IzsA==
X-Forwarded-Encrypted: i=1; AL+hErGxylgaSAulSOup75RA4lusCXgsnRdgqDJ8VBIjznO0/BtamwFNfAEbgTAObmIl8iLJq3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z++y+W4y0SnxfdjFHungARi2WxJOMJphEuA+Atj4ZNO9TF/4GMG
	jT4xaxCKQGgy9zmlR1PJbJT+6tgMI4ENhPyPbNLhhRGO4qwelzJSZKJJtwlr/6UJsikDaCBh3cm
	/8L3a6Cjcu7u/Hv4WgpD9U/CS+L6B6T8=
X-Gm-Gg: AYBFou38h/DzGBKhq28IayERr4zdkRqraqG8RPA4HImPzWHeJxU6Aj+L22ma9FjGvT+
	m7uQurVZXvJBSidXdMQGleA/4KYjQ/44kjBHzDy3VuvhJXuNIMoERYIg12dmupvxOEpXx8qka3L
	tCvxyWw78ItskaTWlLUStUVYhe2vEkJrTJciIn6k+15v/R3iNtDr0cnsiQpqOZC7RKw3FjEXGSb
	sr+2mm9CFlaXMc2TNQMyw6oxQU3IpHFeK3YZ8WxFS/Mhwwv6aM4nZ+2/ZsnuKDw7xnSmyqFeLp3
	J24W2dS/7UxqfxbjozXJu2ARs1PHS47IQER+TXAPT1eXEvP1Be1+O8knncEQG2YcieBfsEZrnRB
	BIf72iKUkKr4o1aA2EyNNUtSG8STui+X4axOpliYxOQRRKXL6iYVLRmlP2vlZWOmUaDm9a0TOmL
	lfIe7Q+YwRngzSA5gJ9AttG9zCz6Cg8dUJHwoQkchQZKbKf0OzBA==
X-Received: by 2002:a05:6512:401a:b0:5c1:a828:499b with SMTP id
 2adb3069b0e04-5c1a9b72935mr2080742e87.2.1795096767511; Thu, 19 Nov 2026
 05:59:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260901083325.3445-1-kerneljasonxing@gmail.com>
 <178847847848.4131868.16090144540850507396@kernel.org> <CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyHtABA@mail.gmail.com>
 <CAL+tcoC=w6j+1p8ovjbLxgb1QdL3ipic0nMOvX_9OJrspSQS2Q@mail.gmail.com> <arKm5gCaERk6MaGA@boxer>
In-Reply-To: <arKm5gCaERk6MaGA@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 19 Nov 2026 21:58:47 +0800
X-Gm-Features: AclHuK_gBSKFSHUhkj4k386tuwTJR3VkWg4umQzAXycz3vO5NDxK_uvKKP_TdM4
Message-ID: <CAL+tcoB8f7H1ptcEk1iVH065AcUNPEL2V1gKoJacwr3zndfPWA@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic transmit
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, James Sawyer <jamessawyer@outlook.com>, 
	Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:06=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
...
> > > The minimal reset doesn't help with the checksum problem mentioned ab=
ove.
> > >
> > > Adding simple logic like resetting l2/l3 headers doesn't guarantee
> > > that csum problem won't be triggered. Adding complete probing hurts
> > > perfomance for sure.
> > >
> > > Maybe we can cook two patches:
> > > 1. Fix the current bug syzbot reported as is.
> > > 2. Fix offload logic by adding complete probing
> > >
> > > @Jakub, Maciej, Stan
> > > Do we need a complex logic like af_packet to handle this?
> >
> > Until now, it seems we've got three fixes in the queue:
> > 1. reset mac header:
> > https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat.com/
> > (commit 35fcde7f8deb "xsk: support for Tx")
>
> Hi!

Hi Maciej,

I'm going to revive this thread since we all received a severe bug
report regarding this patch privately. It points to a potential
information leak.

>
> I'd keep this separate and focus on Eric's hint to fix the drivers so the=
y
> use skb_eth_hdr() consistently
>
> > 2. reset network header like this patch. (commit 3914d88f7608 "xsk:
> > Respect device's headroom and tailroom")
>
> For packets without CHECKSUM_PARTIAL, resetting network_header should be
> enough to fix the negative offset reported by syzbot.

I'll send it as is with the correct commit message by the end of this
week. The blamed commit is 3914d88f7608.

>
> For CHECKSUM_PARTIAL, however, I think we need to establish proper skb
> header metadata. Existing drivers do rely on it. For example, i40e and ic=
e
> use both skb_network_header() and skb_transport_header() in their non-GSO
> checksum offload paths, while ixgbe derives its offsets from
> skb_network_offset() and skb_checksum_start_offset().

The blamed commit is 48eb03dd2630 which is different here since it
should take care of the new network reset/probe logic regardless of
the current patch. Since the blamed commit is not the same, I chose to
send a separate fix after the current one.

cc Eric and James

James, I would add your tested-by/reported-by tag if you don't mind.

Thanks,
Jason


>
> For Ethernet I would avoid depending on mac_header here. The frame can
> also be non-linear with IFF_TX_SKB_NO_LINEAR, so using
> skb_header_pointer() to inspect the Ethernet header and the fragment-safe
> VLAN helpers looks more appropriate than dev_parse_header_protocol().
>
> > 3. handle csum offload issue by adding probing code. (commit
> > 48eb03dd2630 "xsk: Add TX ... checksum offload support")
> >
> > Thanks,
> > Jason
> >
> > >
> > > Thanks,
> > > Jason
> > >
> > > > network_header as a placeholder and drop the claims about the AF_PA=
CKET
> > > > convention and the absence of checksum offload?
> > > >
> > > > --
> > > > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#=
/patchset/20260901083325.3445-1-kerneljasonxing%40gmail.com
