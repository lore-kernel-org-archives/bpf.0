Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794150786;
	b=mjohlrSsG4ZGjIGC1eovljNjAw7QjUDBBPdxF00MdSFObXKQgxCkErJ68Ue7J7fc68ZQ
	 5rXCgU/1VKfoMSk4OvtCytp+gWKgXgpLypkDg007uCvzqhWqBIMnIrDiC1/Z3zyP3jgb+
	 byrNNigspLDIBciBn3fXagyuOibUZ951i17k5Or2O0xPjn4CUURiGJ0UiXzEQ5vabsPj8
	 a9G4jULF213DZHPF0raQUVCnZYf5Z4NEFo0+WnG1jz2nkn5AH+bLiGX1Xdw8o1pqiK1/t
	 MLpBOzYLX1HgXskzOE/QlnjOwYZU4gY0rF4IYlXJuRiDAxe9mUVpByfGKgED1ay/zOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oGOpptMTTRvU+q+lGfxSAwJKiB4VoXJ/0q8Ure01rsI=;
	b=QwtweNGNP+LWwRYkmPJW+IMomaNUjDxMhmga4y2cJvePeYZ55kaVvPF9uMgyZrxmQyqG
	 ETbll16V3RrhXApM2DhMnkmFPyVunz9NjHpwm0LV2FKRDzQN66cwJRhBk7fvcMhRR4eYp
	 ohIPRYWRxqYiHkxtLOzRO/R0YF5Nxe5rWi2R/6sej68VhYlbVe8KcHoHCbav+3QO/72O/
	 gMbOGWYS9ymTZPmEBf00aEgqc9BDKQyWuAo8d29IVEotyVOwPl4WLzwT4H9ovZKNpFMMw
	 Op8KyvpmKuQR2Z1g6ThcSlaeeQeF+y5wFMtdzc5EloegSGw+LFXMAn7wLSihWlfKQWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gQ8KArV/";
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916E606A331
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 15:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3916E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQ8KArV/
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso69651241.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 07:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794150785; x=1794755585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oGOpptMTTRvU+q+lGfxSAwJKiB4VoXJ/0q8Ure01rsI=;
        b=gQ8KArV/ErbsVTXda3c9mTt1T9/eZSFNq5fU2hi92W6EJ8QEPp6hstG1ZKrfTTKuCc
         6fJdT2zddwVPqHY0dKFwv4p91YTgDtmIDdAhYaXTS3SS+u6dDKU5CGob3wri1RZx1phL
         4bmJ5mAcBjzwlr6WuixJp8lWzr4KMK+74i+QENNkzHlIOFd8A6dDN4wvKZ+y7/C3NYfr
         wpD8s84LSUxk0othXtncH9vgHxVoGqDatOLHXpHfPrE3Xs2mKY3sq320MQPxsvZRWoxB
         TtlrLoRibfOEiDkIkABgHwKAuTnwXCG7JUdQxIr7MkKA5fdaTQaG0vNJIokjKs8yATrW
         XaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794150785; x=1794755585;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGOpptMTTRvU+q+lGfxSAwJKiB4VoXJ/0q8Ure01rsI=;
        b=yngq743waH0dfX1UiULOCOhMKd6QK2Tu6D8T8k62PIODPjDYnfhUiBJnt1+pAn0coT
         II1oB1AFCmQ99Naugd+twULBiu7hnQLGKS+dN+vUhAwuxE8jR6jpee3O0M0P2qLhiONt
         iYqw7TEbPzccixns5tSbs1fjKN14GrC9aty2MHjX21CaZMbtgAqt6wZ9qhHm095aB88j
         y6Y/TBZ/jjKoAhwvdXEZMxOA6pTM3WTF5pNE36fyEXqX5gyjyysWuegJKMXCWGkHaoXO
         pL77QcUF/UF31n/7DaEA4iIwuREsZqDFAj9jx9s7IP+oHa0VMud+MFPiuVy9oPUGWVJ0
         xN5w==
X-Forwarded-Encrypted: i=1; AL+hErGQo8kEJcFfhLuOZOdAHSMCkWrXSPZW3eVKQ7aTGXgltrAPYfYsgHjQJNBDDV5Evwy4VK8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lBDbd7e5pgxRei5XVWkZBeecYig+UAMBlwvxJaQghzAcicsVh
	dvieXzK8RkYIf432r2pJLWh9JVFavZDclXfK3GuBbKScaEUcD+3jYVdE
X-Gm-Gg: AYBFou2uINJUcsUDB6S9fjv3SSZDmTh27hl4yBNkMgBIdDpvIp0a2SvlqiF/fdQEA9U
	P86q3aPItAgFt4b2FGwYJaenxTRnv32KzXe5CiO5lHDFllH7a2h/9xrHvbzL9QkB4cvCQcpLFnx
	Q8zH5ATjfs2RmVhWZFTf4/wko1k/twtap9WtxJnvci7UbKYwqjFNG9SdvIz/+cDY5oJrnkNH35X
	Ojlo3SmAkZdBEVA1zWF+yKnm3zGxN0mVkYrJhVy4lRQeR6qWGTtusyQ0tBGw5TkK/PBwmOWAs0/
	RQMeUkPoOzBV3OZ5V5ZMl1L356sqkqYDYoAKtlSocSZT65E9w8drJK7Ph5NVzcMyHtB4Tzv7z/h
	TG5oRVGvXsIJev138aWc7nbRLMGeUMiuyEWJ60BcDx/7NoEAY92gMr5meJ1x3yO/Y0WaIz8/bFy
	F7MY9Bd5onVPD2RfGa7wF0EwmTIbvkiEV8ob8qISWzFA44lmS3yF3H2QFZksR14blrEiq0pyTKP
	yP/8729krQ/boTe+KQplX1WYPiEE52A26/IKz3vVS2O6mAl1NDKInuzl7828fRoD5ae2J0AFC/Q
	VixxIAatomqGWfWo5IXj7Wy4e4RObh9R2EMxr4RcC+2ZZSRi/t6kKqWeL7dvGl6TMAKRhG52POV
	6TQ+M4DTO4gnYStNFnXWmrAh90mpAIXRCghHjbZTgXgxn4pqfiQf53pC0iexrY5PpiAjUu+A=
X-Received: by 2002:a05:6102:41a6:b0:7a6:85d6:84c3 with SMTP id ada2fe7eead31-7d2daab4c34mr493239137.3.1794150785073;
        Sun, 08 Nov 2026 07:13:05 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2daf08fe5sm2083603137.0.2026.11.08.07.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:13:04 -0800 (PST)
Date: Sun, 08 Nov 2026 10:13:03 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tianyi Gao <tianyi@cloudflare.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Simon Horman <horms@kernel.org>, 
 David Keogh <dkeogh@amazon.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Nimrod Oren <noren@nvidia.com>, 
 Alasdair McWilliam <alasdair@mcwilliam.dev>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Breno Leitao <leitao@debian.org>, 
 =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
 Danielle Ratson <danieller@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 kernel-team@cloudflare.com, 
 nh-open-source@amazon.com
Message-ID: <willemdebruijn.kernel.2c6a653eb65fa@gmail.com>
In-Reply-To: <20261107182526.69543-1-tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
 <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com>
 <20261107182526.69543-1-tianyi@cloudflare.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and
 LL_ALLOC_SPACE()
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tianyi Gao wrote:
> On Sat, Nov 07, 2026 at 09:51:07AM -0500, Willem de Bruijn wrote:
> > Tianyi Gao wrote:
> > > From: David Keogh <dkeogh@amazon.com>
> > >
> > > Add a tx_extra_headroom field to struct net_device for that purpose,
> >
> > Main high level concern is just adding an extra field. What's next,
> > do we need to add a field extra_extra_headroom?
> 
> Thanks for the review.
> 
> A user needs more room either in every packet or only in new skbs.
> needed_headroom covers the first case and tx_extra_headroom the
> second. I do not see a third case.
> 
> needed_headroom does not only set the headroom of new skbs. It is also
> the minimum that ip_finish_output2() and ip_forward() require of
> existing skbs. Raising it for new skbs also raises that minimum. With
> XDP on a veth peer and needed_headroom raised to 256, throughput drops
> by 2.8% to 5.8% for local TCP and by 4.0% to 20.8% for forwarded
> traffic. The cover letter has the detailed analysis. veth also cannot
> set needed_headroom from user space today.
> 
> pahole on x86_64 (defconfig, net/core/dev.o) shows that the field fills
> the 2-byte hole after needed_headroom, so struct net_device does not
> grow:
> 
> before:
> 	unsigned short             needed_headroom;      /*    60     2 */
> 	/* XXX 2 bytes hole, try to pack */
> 	/* size: 2688, cachelines: 42, members: 187 */
> 
> after:
> 	unsigned short             needed_headroom;      /*    60     2 */
> 	unsigned short             tx_extra_headroom;    /*    62     2 */
> 	/* size: 2688, cachelines: 42, members: 188 */

Thanks.

Pushing back on another design choice: the UAPI change. That both cannot be
undone, and is fragile and laborious, requiring manual admin arithmetic.

The RFC patch mentioned two other approaches: explicit headroom requirement
labeling for tc and BPF, and dynamic adjustment of this field whenever a
realloc in the stack is encountered.

They are left for future work. But should those instead be implemented
first? As said, this manual hackery cannot be undone. While in-kernel
mechanisms can be refined and built upon.

It seems to be that this series is trying to address a few related
situations and argues that no single solution fixes all except for manual
adjustment. But likely a combination of the above (and more) will.

This does leave the veth peer to solve, but that does not seem
fundamentally intractable.

