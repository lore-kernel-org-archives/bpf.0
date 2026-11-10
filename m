Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794325561;
	b=vbrSaEeUe+JVQdJ6yBMVG9dHOmmetSOmtpPdn7B4QBRG6cgj1iD6E53DjwVQQ0xBHeYC
	 waIIzJa3Ukyw1yCRyI/zfkah6tBBtnwD8/+DoWYu97SAjYTwNZVRi3aV0H2zYItye89g6
	 bdItzA75IvFigl68Li+bJbU/e4gVP73u7eXdjbXcCD3PULwBiYjCjOVq+YPH2b4IX2JOQ
	 LYcd1NwXHP1wqmDdcVXP90dB9osQN+jRIT4vgkqDY14a+vfd+P1NEXlIdJMMFB3n8Sqa3
	 Yv6M8r8Wzj8I7LEkJvJIF04MGvY1kiYrUbQKNzsqDNVOVQQ80oQ+En7+zAdPinkFfxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
	b=fC4IQn6/sC9fVXVzZ/usPByVwp8Arb3pCoIvY1hwhrKZRpWdc29omE6J0ENGS2BaFpeK
	 e4CZ0kL+nef9y4C5Nc6oQABPxkxhcVlfgbNLhPbVTzV+KpH7s6SVVpApqSD6KNrSh5RCf
	 9FxYYdoJ5E4aDcdC4ow3rBJCFPfZIyhSVRVHlgFf8H4M3TxLi9YkcSuK8WVUBnfdi9SSt
	 ZHUIaEQ/3smBIyl575YAa134IuYhzyVtuv8BJFsUK1ycf36Y4UcSAPMYLMHmQT16kaQVg
	 5X33xV8J0G4USeVQN0iekFH2yjsR5v8zuLAZu2yjXyH8edJ0wlB6laqdyBpVDTK3JmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CF606AB54
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 15:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 373CF606AB54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6dde81a6820so1369213eaf.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 07:45:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325555; cv=none;
        d=google.com; s=arc-20260327;
        b=iG4UavwsiSnmQaaB3MtxaGcJnAhWNjS0bbnqYz/4BQ1yqdO7CQySwOY4gf1uaEn0ou
         XTYcUoq1TwIB4SFmqzNg6aeCg24qzckKc7dips3E9dg+6ilo0pSLjpHLMEMRmtwLxr6N
         LGouXT/T2ZTK7yJ/sUmlDUS+AQPPugcwHK6JHePtXLRZ9pC1kI6jXhrNOhll84pXUf6X
         LPh1Ycz6FcMetr9L1aq+G9qirLTR/KjqIy3218FuffLUFLVPio2+I7CMEhuBvQwO4Slv
         loQcwgOmrOgavAOu/6VSNUKdp9lpAxm3SW0C96V+NFrJDFybiOLDTgrR0cSyWtmrELmP
         xpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
        fh=K6bkF2HpaeZ+GpyPWh7PI2Kql+FRNvwfgRO1k+7uKbQ=;
        b=J9y3TJ/bCSf0WFf/I8xDpGtZnqu6MtPObCBNrYgfd97YXkXlsm2WaC/5BjcQNXc7Qo
         qT0Y/qwFdM6U15mSb6K/H65sA3hdRmVg6NrexoUrN2vmaNDdPftVC0IdMX+7L2/cBBhB
         9Y3fGt7WrZwQs4ngg7dH/BUgAx30bQCH/Ei17+y5nKB/43idp1S6NjX6Pjy38EkzfvdD
         wR+nNmcxgErJfyhyq3r9zxiOwc/RnAP+nvNHselcBeHeIQc/3lOW+F3LhcroNnK2gkXD
         gNzgVDrqAbbKOGh3a38B9ZXzq/1vsvdoANMdWFPoGE5ce5ImJXpWzvPpTxNOCkp/xV8o
         QzDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794325555; x=1794930355; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
        b=eZLW2NkFr/j9icFxNcvCAM88kGStK/E6aBuXF8X9PTB/TJstGOhvTD+oxnr2K/CFip
         LcDYPep9GKsBbabgbijJK8fW8Ri7k+AQgTpbE0lfmYbq++4uEecMHCP8cJy+ASy5Fn1C
         Z7cmYFLcw+cxPvYec6ZFIcz9h0hx9GUCZQNC8nte43cm5qiHbXRbnTNHTBl1+VeMbkIY
         uqoY4pDGStIpFAnESbzX/o6nCQkRdYtqB95sCYlkXriJV8MXiOEX4NtIJW6wkeAwE2IJ
         9SnQ/rTMEtIWDIXK5bSkmaqWrqOPx8mk6cdC7zj82UixmIlP+udjnEbIS9a3pHbUWS7o
         nsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325555; x=1794930355;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4joyfckgOzoxD1v9F8y539Lxr07wRquNtozOKKoNpYs=;
        b=hVLEaWaHOyajPfYjFcV++kaBVWQV4DXZUEKZap5hf1pfg4iSEzY81FXwr5594RwE8m
         FLpeFwpF1jklgsN/M+y4y/gbWVg9gP5uH+GZHn/0uA1ipprIZHKRuOJ7fE3WvQ44Q4H5
         7E2s+v30aFPohmZ7+Dj+ReUhIh16TgdxzSYx3iLPMDK3K4ke1IfADQoyLJ6i5CyY28yr
         OYExsHwKkZclFhHiyRhj1VtbL2/RJWCmHfdrCT7BqokzDsk657qNfLvWmBx3e99Wn0WI
         cVOjzsjmuPW6LzKOVIH7oBh1xgmHCKRd1xTIb3fva6FB4GtDqiRQ5qmCxfV9Sz1Df0eo
         +B1w==
X-Forwarded-Encrypted: i=1; AL+hErG+Ed3/fV9ZNuC6QviqLj+bNcYq4nbKk2QALwZS0qUg2x7unrAyzpJpu0L23Bt4sou8CsE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RJvLEEYofCt14yD03o4Rm+/PjqoP4zfkin4kH2UDyLVafh+4C
	r/ZA0WhCRdnCkMPQH63Q5dFeChgPcjze1sEleelG6UNQ9TPlpxNTxdCnne/Q/zHJ/cZc+mG+oO9
	ZMfdfqSR1ZHQqXZyc9ik8Tg+IStVJjyKNFibqrzg7xw==
X-Gm-Gg: AYBFou3FZjYXwkRWLEDGFdg0UUzUkJbFdQExbbp4mVVS2ZRXpGRLCVPBbd9fJcHeDv/
	LxL0fKmfRnvvEhGMzgAbxe/+LeAwzc3pJ/zYXjqYAE5Jd8lIJCfbIN5BMAfMzBB9F5MBd4gfLcL
	b9KAsYxrwEXDQcX6IAJNnAsqXR93bLugPL8vdlLFBdjLZqaPIjP7QwPziqgUU80s7sS2RJcWCI0
	iuSlm1SrVLLFd9IlRfk9fFweq1n4wqSLSQAJiyOytzY4pUIxxESJWa2QmA2b3apM6JI0YfcmjF0
	imn2Yo2uuehhzsnn1Q/0HUxdS4F+km20D0/Ill8wXGXsn3FH5Kre/97ibtDYx61IQGgiGSGUS4G
	I12I2D4rFFpHeLxARuodlp8A6MV9+I1QSfHE9NBLvdx3TOh+/R7vmBU8StWlBz106qP13NzDOh8
	apgAG2B7Fi1w==
X-Received: by 2002:a05:6820:c2c9:10b0:716:ddaa:40eb with SMTP id
 006d021491bc7-718a4f92ba9mr1015097eaf.28.1794325554928; Tue, 10 Nov 2026
 07:45:54 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794020868.git.tianyi@cloudflare.com> <73b9d23a4190cdd02e89d3a2ce8a1a21ad5feadb.1794020868.git.tianyi@cloudflare.com>
 <20261110073807.2fa62e6c@kernel.org>
In-Reply-To: <20261110073807.2fa62e6c@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 10 Nov 2026 15:45:44 +0000
X-Gm-Features: AclHuK9D14tZ4FX3CoGnuGmDbJMM4Y36vINL_kHffGczXiZfZcX98tAF2DEPmTU
Message-ID: <CAG4wq-fJfKAiCY2Z0Hv_nCBM+8gKSBq-N2Xc2KfKREkRL-VDvg@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] selftests: net: tx_extra_headroom: test veth
 peer at creation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, David Keogh <dkeogh@amazon.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam <alasdair@mcwilliam.dev>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>, 
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Danielle Ratson <danieller@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 10 Nov 2026 07:38:07 -0800, Jakub Kicinski wrote:
> Please use Python YNL directly, we don't want the dependency on iproute2

Thank you for the comment. I will use Python YNL for v2, with no
dependency on iproute2.

Cheers,
Tianyi
