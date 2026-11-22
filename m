Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795383288;
	b=MRnlE1481vdX4Jbz2/CvKaezkswq5bfXh4qzx5nijoGEN5FAFntxGvfhsXCa8qWPmaHs
	 Pt04fabRGo/7XfxhH3+hQa6fBzhhMP5DSs9yUTIqmcYcaiXYbF87LSgXYpVWALxykM7kI
	 1bWTDK6GaIfhjIE9qUbptRLb3cTaDESc4GcebWqKJa32sx4lEP1b3eZ4fQRckJTKiBhtq
	 p0pOur0PHyfupPj+XZFZCp8VW5H4Yt9ViYURENreO/GZLcFa1EoUDL2JYHBUf7ihRtoLO
	 yBJHCPnpC436EkRzvMIkTA/KaoE3sahU9kZH/6TV6JfSUpYBOan2QYE4ErG4jAcGXnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
	b=PpoOLaAYd8NJ2/ELgHQqg2P1Jhl4pZ0zvttoDxAMY8dlv1VH8DUygpFTSo43LM0cqKcU
	 UwIcF3vvvuJ70d8Xiqa1gFob6nZK3ZAh9zz9UvnovXaDZo3N2OcIbS9SOUI/nw6dSpwIj
	 YLCRYL9W9G4wrad/3xCyaoBfeqnv1MnecLDxbyzWuGBT+GXS/BL1oH3FxyFUmB2g7VVj4
	 t4SqSMeZPTn3M9vaS0dQsRmb5driPGowH0HoruXD9Xcfin8F09nNaiGiWFXGjHlCr595P
	 IIaov4xbZlEYxrhFgZw2Q+F4iJ0L9dDxP9PZZKOPsxKkxDxFylZo6IJjAtd0mE6irhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L48SGs+q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90221606A31A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 21:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90221606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L48SGs+q
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f052ae3c86so11700815ad.1
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 13:34:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795383288; cv=none;
        d=google.com; s=arc-20260327;
        b=Uz8qf4RcUkoPwDhCpzaLol4AXAdgEgVQi+Z5FYOslHDLDES7prjhWGgi4crnbKk2Bs
         3OIUmdQp2BlzNtZGIrKCIeiEc7vMvt6TLQqVKioPxDdJDfahYYXXKnbW38TMjP4FhL2e
         S5wD1Ie/DZDHfB6lXOVXQWfMBpukdwE5mSem7vHZidbZ3L6z23jOQ3jz+x4GXR0WPS6v
         42cGXsANPHtZC6GK4EHC50+hTKcbVzqjZax2RZnslWgmenZW8nK6oQj6EjSVmRSWbC5B
         5LPj5bAWh1LTcI0fZ/6NGoqdcHcsT3rI+xLpuOHVLZN3lpu6Wx8gZvaBDZnhEKZxEfSC
         MbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
        fh=F+kPJ0LGTOkvtllylhlznzFkldBKCbG7Fs1/sEXDGWc=;
        b=r3SWgmP6V+/Mltc4EN8PgKNcNFi2CqLwrgsPI7kBofKIsvf2O5jfP2e+FM2s2GN3vD
         Vwtb+4m2zfeGpLP35+mao1cE9Uk/DX9vJyKUposgO36Z59qP1VzQF5hUMkBOrhR2ivp2
         Q1Siz+334Dl3DcLvvb061eEd3kE/Ou3v7A07liQXPKV0v778D9suj1ZwlHDGfOm/+TRm
         GL+QCNmyzqZlcCjGcikjt8GinCaheOEbfRDTO2Wd+P5R5kfbevdFpMJoVwQHKdJiWRCi
         8au4XLKKdsFLXZlh8Nt8PGwY6J5dLcg8vAmG5ce7kfYVDfkgyTWnJNXmUkWqjw85+Jnx
         qfHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795383288; x=1795988088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
        b=L48SGs+qITSiU9hSWY4o9yQj/aAnGU6HZ93xE0Olg0EWUzUN6CvNjvrp5INE026cGL
         m5+b38kIjvEV2FS5GipiC9A5XaQ1sQcUh1JC6pv7PmVZOtknNfL4ut0ivMegw4yoKYII
         ODqiQseoTD6yv+FbbokDjsVdRvfZAFx+EYFUKaSKT4tLNLy6GJi3CSAHO+pj+8DBcNnk
         g3MlHrBmg1XIsQyJYOtVqFnT5RX6vev9FXIR4wIYG5EMU/jYpc2f3/yntxpvfPHIfY9M
         n3R5Ww8jncIYH1BR6AQwQc/6TnbXSniQDHGBGeKXtVhZuR9CufKnHMncu8IE2i7y/okQ
         IZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795383288; x=1795988088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
        b=CSlj/IK0igw7dX9C0VcEC23L1Ya87k0Ok2p3O3qYScanNzxlGfhsxloieJtDQJfkXx
         LxdStfm0J7i8mgiTpPdNnqdWOmW/ZZ9r8H4K++Jbt8xxgmFhzV6Gwjgx21f8Dh8CrKbV
         yZnRyYOw4JU7JbMK+WDE/vdHKpD+LMNDEyPZdDvH6fqbf6ZTS6bOthaBaW62MTU/4UUU
         SRJj3BRyHnAsV7JoJOyiWfBgftftYktmbuSqH+w/QcyMcv75LCAqC3LPYGdxOP65K9Lr
         ftnftVtcKDb+uobMS59f0gO6kl5ge7aPGwcJuhjY7I/SS0CZylg9mtb9W5DLQEeT/3MG
         2oKQ==
X-Forwarded-Encrypted: i=1; AL+hErHrnPymr0G5d4eShnyT2xQdUQ64zqVbxkD8Ro4hZpqBUEPHJ6rZgWAaqbPoqmtLNaBI3pY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ifITy+IwQh76iZS+hCRAJSzdqxseuOf0I7nX5mK7bEuQe42JZ
	D/Gxghek82cQK+1iQ+b/mbxcC2UqlZws1eGEQB0ozjNOs3BB4dFiohGIHuULxe8ml+R9xmOX+WG
	5J3q2YzhBa8u7D1+5GrcxMCaP9PMuqjQ=
X-Gm-Gg: AZFdTZeIEMoEg67pIwW1zrH2YbedcEsPQ7WopWw7UvSGqq1ANBAw0j26hWwpFyFc0un
	m0RKKvd4HuFDVt1md1sZ7mOs+FUhylgWe9OMVSNszTjZkx2myiyvAYiFvP2rgoUeC/STopgUyqM
	w0xb/ZVCAY7LLGSH+2vJiZ0C1Y+iN1Fow+COecOzsS5EGl5p8h9xQZSpMBt/xN4qiEYSbh3dKt/
	AB/seKANz+KyCOoWXX2QIclkYTC/+Hw4nIwMbn3+1Z9eb7Ytg5O/OxDI7OQrhgXT5dnpD4ADj73
	UTZbhUS13dakMTaQC8VB3YKLF1xOGraGlNPEmSa+aOnxhOrDxfaVc9khCIdzKU53cUZ5S/4Ax73
	moQiRMq54fVw+wZNadf6WSdOWTOXUIqzfXZpOo8a/ZRrTL9T+383siYc4cWxl0fClKm7Hxw==
X-Received: by 2002:a17:903:298c:b0:2ef:d952:4a65 with SMTP id
 d9443c01a7336-2f03f1babeamr91216115ad.43.1795383287859; Sun, 22 Nov 2026
 13:34:47 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de> <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
 <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com> <3303844cdf7c00c5369453eb91027c1b@tipi-net.de>
In-Reply-To: <3303844cdf7c00c5369453eb91027c1b@tipi-net.de>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 22 Nov 2026 13:34:35 -0800
X-Gm-Features: Aa3M54ojoA-gtiCq3dXKw6zioYXOKf9vTAqllY425ytZiRU_L22WV3K8LaUJ9aM
Message-ID: <CAH5Ym4ijMNSAWZ8k3GmwOoLDBVTy32B1uhS_fE-dGhsPkgozeQ@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Anandu Padinhare <Anandu.Padinhare@electrifex.com>, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>, 
	stable@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 1:09=E2=80=AFPM Nicolai Buchwitz <nb@tipi-net.de> w=
rote:
>
> Hi Sam
>
> On 22.11.2026 22:02, Sam Edwards wrote:
>
> > [...]
>
> >> Do you mean "first as well" or "first instead"? Because "instead" can
> >> cause avoidable packet loss:
> >> 1) Initially, network is idle and ring is full of empty DMA buffers
> >> 2) A burst of exactly one ring's worth of packets arrives
> >> 3) The RX irq fires and stmmac_rx() attempts its refill-first (none
> >> needed) then depletes the ring to the maximally-dirty state; the
> >> refill timer is armed
> >
> > Thinking about it more: the "unreachable packet" problem happens at
> > this point too, even with the "first as well" behavior.
> >
> > Maybe the best way to resolve it is to adopt stmmac_rx_zc()'s behavior
> > of refilling during the loop?
> >
>
> Only if the ring is no bigger than the NAPI budget, right?

Right, but as pointed out in b6cb4541853c7 ("net: stmmac: avoid rx
queue overrun" -- the commit that introduced the "leave one behind"
behavior) the ring can be as small as 64 and that commit's author was
seeing budgets larger than that.

Perhaps NAPI should only be told to stop polling if we either:
a) Reach the clean tail of the ring (so we *know* there are no further
packets for us)
b) Run out of memory and have to arm the retry timer

Thoughts?

Sam

>
> Otherwise tne poll can't empty it unless a refill failed, and refill
> first
> covers that.
>
> Refill in the loop sounds good, but this would be IMHO a net-next
> follow-up.
>
> > [...]
>
> Regards
> Nicolai
