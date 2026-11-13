Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794596072;
	b=Fm1V3eQL2I2frHVMI9mMMeJHr15b4RSJXtFxJuGrdcyHMwB4TKANlPOLflsZyXCUGn9q
	 ncISM0nEknFDg8+eKKT0nIE+Yu/4kEDOEUJhk4PKlDrRen9ykTqVrpsIpGfkO9FUVPLft
	 WxnhuMO1fMjH7G6So2nljFAxy/4JD8B/e3mpddRT6jFSkvJ5O+sdHhbfsOdUPevrSLYC0
	 sDFONI//ZqtMtbbSu7zCsHx/o8SnFy/sszSaL5y+XQzMqNGewruNYGFm1uPmdtu+upTTF
	 HUU/Vywguu6/meXZQPsnji53t7gNntC75DaNPIYsd/hRecEcmYXx5aFkSoXZjQWWaCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
	b=lmSh1DlvAwyMO1Aqr1Mo9WoH6z0izr9vhxqnUBLj5jhFuHLLQRLcvMGm7MHo8SjmCVsG
	 pFYvcqEAfrw1HddBllhSdAcy89Uu6EsHkCZRl8Lspg2VDnfVA1dNPihLKHsRqUq8IuDMH
	 6si6drk9z6jvH8VjHB7Pf3m1z9lN9srtdyOC3jkY25GFOb62KrIeidcKbJa2zO12ruCEH
	 gI5H0bHZDcu4u0N/9KWdlfe25ledJouhJrShrPnLf9zAsLv5eWFYIeWhnzXsiegAM70uY
	 wNyV0luZKNM8EJ2PfoQO5I29RE3kup4lugB+hXJIZV9Ar1NHjo4MH3r1adlwQ1hRkSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eisEEVVM;
	arc=fail smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70B606A338
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 18:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A70B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eisEEVVM
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso1363a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 10:54:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794596070; cv=none;
        d=google.com; s=arc-20260327;
        b=FY/kWYzV8szk20HwF5+Ka2+aijnt0Lhn4taeADQVOCUzdqdYvap0uf57bh6HtFknYZ
         j1wvi5kJF8FuqSUoxsQrD0arZVk8iA7cY5cIGtbVbtBqgOR3lAewvfGNaXyGiFkgtE6/
         roTzzgTxiKUn/HJL7RRRj2HJc2tLoVSZD9Q9WIcTv1IbvIfV0bCknZIu5l/F2+v3BpkA
         PVHorYR0+znq/yzrRMZ8G4oltYo5Jv2y/K0H7POUC6IsezRl8XqvC4EZEjc1OLD2NrKK
         vhE6xPEklkkzNHjxM4z8qrnley2JHcmxMcUyakS1VlUCz3JNBycvfnyLncXrKvboC/XJ
         /1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
        fh=vh3/UATGbtmqN4nJz8VGE+bTtYM4G2r+IJjY2yRjcZI=;
        b=XyIwRH9K94aFPZazkb4gpfP3MVhxNGrUBschcGT+aZixCS5OiXKlpfOK+NnfQ+pBKW
         hCrw983UavAjxEJ7FhlKqNCuu8MzBj8fXwLeAHcH4QB+4/kR0s8SAislfBxTEkAvtcAQ
         ArB2As65ptI4IKVEgcVflMZT1k+6c+pt/6snK1eTrrQhdaBg+fvi3ScaZybNZZrnP6OJ
         j+HFatltaEWtdJ43sPxnDSTcfFzMoRTdv9Eo5si75uGQ4+3wSR+6t9xurqJfT/WTxLj0
         3k565G8PRQvraM4krJ7Jv7xBUO1ocefUa+/FVlE5z7Ges44DXcW1ipbM94IVezfU0Ial
         Io+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794596070; x=1795200870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
        b=eisEEVVM8PCaj/Wxux+iAJmBT1k8bHNU35jNjvPdKn5A1HLZOH5LQ1EY3BcJG6WJSd
         zQJHCca5ZSW272RR8ZqEnxlJfsFyhdrMZusl8QaA4c9HP+xH6avVjT/oc3dDYcv5aBdd
         PX2GBBsx7FbYnffDffV/A8+nFo7zh1u9hueKZ40B79RrQ6sNRvq4xDRAPGyAjZ7E+JEP
         dHQD/L3wxxC2OFdsSm7Io+s1kd8AHRbV0NiLsOq1oDTCRUWH6uhuvzES4DspcfRe/mVS
         XpFUSQpVCuB+A/wp38W4sFKkIzI7LAQear5+guYAQ2EbAMwuzP8+PeaJ1TbqOdpbCAyr
         OtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596070; x=1795200870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7R1hXZXnbTwKM70quTRieOgRc26BuTodcH8VZYBkreU=;
        b=f1KomO4yEJWB/e5jzrvEAbyGcq21NZYurB5mKTcqU2d1tCNr8SCGDO5pUQuh3zQ4mm
         5Iw9EseKY14i17JnG+m1xvvGa7aAKZUcQOLwyRFoR+7qmlOVc7XfmgcJ5JyHNf+s1+op
         V/R4U8xyrXoc9Wc7AFATWtkCFs9VyLFd2RGywhf0832U9F9XDdGi8raKO4fUDvNCt38/
         qhSVmvAMz5ktYSxALld5lZSJIMQPzUF4lt3PyLnVJLVkySHfYwIrAFGNRwPzYlif7cqJ
         Yym4bErsU+cyFvsbV+qvnsQ8pg4fggeMphFLMlKGkavNyGWGnfz2h+fFQSl6dw+NBY8/
         4SPw==
X-Forwarded-Encrypted: i=1; AL+hErFUtRjpWu/3nHa+I8Zr1Ec5Jjbq5jJFwN3kvymLynoJtBesIjiujHe70sz63M/lRKD31qI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hzDVID759TaF63WUYPFxYt861xIs0Z62x/GcLPU7py6eVONDE
	D/ROUlOft0rAi56+Q/GDcrf/GHplTRmCfX+Yyj08BEetQpBV9PXlNx89W0u7RcO7oLBm+Kxcssg
	eYoOlQB80WrChMxf4natfFqElMCWnd95cEAI+I+AI
X-Gm-Gg: AYBFou1UZBCsrq3B3lg61CMnyNly994AB3EMhy5MenzFDqO5UNf1K4KUepAzMnhbkin
	clYYlNANh0iaeOL/KZQo0Bt1H4sr/6JIP5l2I3H9IuEkuew2PxcJpcUQSq5Aj14O6L7cOnxQG+n
	44jbXjh1xQjcXa+htmtHm4N/F9BKAPPVLjd5rckjBgWBvoZED5I2AOciXDLqTjSxNPcB3wuviS+
	Bu7KDFef10pgQLINK6+k4zVSc2GuHH5wczh9qjVX0zlyLhXJxjXvjp8u/B5nM98czS7fJ9pEm7y
	RXIQPaVjVMCmLeU05dTzK8c5x0xipMaUAmtbZyVTZHe5Fjxt5PnBcR+iPOXOAY+sltzxLr7aPbF
	5Mi3n7Ltves+wnOFRaV56f5obIrQP2EzfQAT8LIyL0jUW3S66Ol7vtyM7HA3dHkm6PwM=
X-Received: by 2002:a05:6402:a512:20b0:6b5:76b2:5e18 with SMTP id
 4fb4d7f45d1cf-6b7e0367708mr7837a12.2.1794596070008; Fri, 13 Nov 2026 10:54:30
 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-4-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-4-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Nov 2026 10:54:18 -0800
X-Gm-Features: AclHuK8hJZjvI7zpL7vkOt-X_2SsoIeZHCGx6Ao6kGKYFChdzs729uK5-y6t5Js
Message-ID: <CAHS8izMhFEMu+v4zAm6VqjU=Lz=vMn58Ft6HKya1L-uNY0hL-A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted lifetime
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> UMEM stays mapped writable in userspace, and it has a fixed number of
> chunks. The stack must not keep its chunks in an skb or an xdp_frame.
> Mark the providers whose buffers the stack may keep with
> MP_CAP_RETAIN, and copy packets of the others on XDP_PASS, on
> conversion to a frame, and on redirects other than XSKMAP.
>

I'm not understanding why that needs special handling. Devmem stays
mapped and writeable and did not need MP_CAP_RETAIN. Also, today the
stack can keep any pp page in the socket's receive queue for arbitrary
time without _RETAIN. I'm espcially confused you're not adding _RETAIN
as a cap to existing providers, but their netmems can be retained.

> The head chunk is writable by userspace, so it cannot hold
> skb_shared_info, and virt_to_netmem() cannot find a net_iov head.
> Drivers pass kernel memory for both to xdp_init_buff_netmem().
>
> A static key keeps the check off while no such page pool exists. A
> frame copy is linear, so a multi-buffer packet of such a provider
> cannot go to a device or CPU map.
>

Did this actually improve perf? I recall that when I benchmarked the
performance improvement, it was questionable.

--=20
Thanks,
Mina
