Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646668;
	b=C53dXXJOONoUAZZBlVWac7u+Ubb6QZYhA5mvCT2NjQDf+aW/LNl5Q0+Mtbv3le4i8544
	 V6JlTuGNbVPJmqqj9/+arciyS6hpokh3mygqGBSsagzBD03/+g9J8g3DEZxKPLtvyNHvd
	 MMt2mIOSN0PdGHmh0GiNjmmjQEUg6Czvt9xhJ6edcAeEPnVAbPtYe+y0vYQq7IP2OgJT7
	 ragwn/2Br05TmLDTiQtEc6d2vPl9CJDG1bHXydNn6HoxrPTHwFuhS6ozygi9i4L8igQgN
	 dxRM9vVCnz/2vgmup/u2C/zrsyYNUM3xq+XnyCXjC3Y1Ywv6inUGL5SLquSOSOmYZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P59oydQPeSwr+tPqd2CX+2z+DDz1Tv1MFH2M49ikoZI=;
	b=PT93RyaDw1TvMhYnz613Aclr56ViMh+XeipyD8kyPwt8FTKxJqkqS4nK66YFim9ruX2J
	 +mT7eui38CaMy1QPULMn4R3RRmUMgzypOINsSmevTM/FkO5BddFLvGuANoEl2ryUlTMcv
	 tOOrbBKC/YlU8roiR7sXobhl3wkR5ALmHPK7mRmQB3cBUmgjItOTIMhh+TdQgcJd2cqk9
	 CIakN0tQ0zdAOgPyRD0QqnNpIeWnsfK+SS+ixA4q9/vDuBRWnWgTCfrAwjRhy50mtjTMM
	 A/SEDMU5OmgAOsu7wHVAJIMMOfm6zlePBp4ul3wTli5ikNKacL5h9FEDjkShzTMnrLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=f4Yjg+o5;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB9606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ABB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=f4Yjg+o5
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso1200630366b.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795646666; x=1796251466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P59oydQPeSwr+tPqd2CX+2z+DDz1Tv1MFH2M49ikoZI=;
        b=f4Yjg+o52InzdJNjvABjrOWkTRff21bgbNuy+Ba5P4kWOKQN6ofIQHP+Gdt1wex4C8
         EfR0NiToo92mJex+SEXg8qtF3pUBVWO2ioUbPZ+2mfyazWyZWJVM02qeRfTr/Jyi+Pui
         v5Zb2elC5wcDZ33RJDhLmLDOUczvJ2remoooUn3z6KjUpNnv9Crv7nhWUw8cLNHXmIh/
         M34YuzpFeuNN1bOYI4H+iDn0VV3UqbgsQtaZnk0GFViA1DYxm4Y30JdBsXR7zHJA/ZCh
         9jrHzV1amS4JSDrbOZwrTjkduGab76yTwe/4rRxOJN6FqjqV+k9ptCRaxYjR3sHx9VMF
         oXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795646666; x=1796251466;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P59oydQPeSwr+tPqd2CX+2z+DDz1Tv1MFH2M49ikoZI=;
        b=h2qC3vQKdlw7WpHXpBBNXQVDW2qvut5Zfl6tYgYON1XkrVou1MquUfE/wLG5WFkpgh
         yTcbNIMZ9vHS4RLxZfF0CW5mHDmFJTK5wdcHcvV0IMrxtJ0QghSR21qSlXPkwaPX4ymT
         Ksdpzgr9ylEBp7JgKGWsNZRyNyExjgqEOm2N4FW11bXxg5s5024PO5xRYwdut0UNgfDF
         zkr86GdfyNohn5Z2xOq7e17Jz6KhYgBDKIOpCaz1b7l6YxF2TwCWaV0qpvcPIWzl6U1w
         s8HGeJk35OZL4eGM0Kl5nXlvDTqEC4DPQl1iTaRuTLjIlZ3ATLcVtaTsahAOcwVM/LMC
         ErvQ==
X-Forwarded-Encrypted: i=1; AL+hErGCuQbxccZJEPfSZMOjkM5E1KIZmT63AKjWbE2I4wfu738PuenUFuspS4boGFQzGwVvDQo=@vger.kernel.org
X-Gm-Message-State: APuU4Z94rhW5CWCZhpkwJCI2sO/jqn2fpfWgjX1fXpBZl55MBn9Zf56l
	6BUqnzKVoma8NKf/SIxY/s8dHH9fbm5r7gVeI2SFD4T3Hx8lYkL/yLDJabAaL19qMoM=
X-Gm-Gg: AZFdTZcohix6/tANVjWZOgNzUfh6k6FNP6F2w0QBIXRcZFUAYJfowLCOaXsRlkZ+0En
	ZlXJkvr1vO2vDI68kVJzthwmYbXbxVrMQKhf8ziHuM9IuIuNOqoGRvKD20jOtUCaZ0xIQy+4nLI
	m8BQPuffmglFnAJEYjCvf/5FaR7H2RvI4HFTKJQ8SSEeSlcSCsT8YYO8PXbWQtE4NZpL8qBvNj8
	zFE37+pILPJODIwpUfnJJzymio3Lv6TCFpmq9uEje6S7gzr2SYftVOx+2Cmu5kZqScaLuNihaDg
	pOcZ7cK9xN7qoPhIwdwUa1mh+F2cdq84+J+6YyrVHpBfeNh/flZ+yCowLurIWJu+6n75daFPlSD
	4I8ppsqz8Gg3XmTIK5664T1tfvJLWOQmWhmUXiAxlpFxr7fvfJIxF5u7ut9HmjDbeDLYxp8ZDQr
	+Au91c5MsqcRd1AlpBvt1I70TlZkgIwdFvgfkvYefmeyXTvWu3Y9uR0yHMSez0Ja6cuV+64Nihq
	kg3oHGaOomfKndCj9xjgmiSzzkV9DyVy5u99ipef8+5/9RR4KuFRFLxBPE7cGNE9jSgdicDj1/e
	mHGeEjZ7+t0KvTVeOj5zCiVkz++Sb84F+X/rfiLEkA4HqwFiBaATRalcJg==
X-Received: by 2002:a17:907:3f18:b0:c46:9711:e30e with SMTP id a640c23a62f3a-c5131a1601amr1649414366b.29.1795646666482;
        Wed, 25 Nov 2026 14:44:26 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00232sm717202666b.12.2026.11.25.14.44.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:44:25 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Tianyi Gao <tianyi@cloudflare.com>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Wed, 25 Nov 2026 22:44:20 +0000
Message-ID: <20261125224421.79289-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0Ueso=OQ7=GJp7m8nr90kBUp-+N6ko+Qy4e29MZv6tLQfQ@mail.gmail.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com> <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com> <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com> <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com> <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com> <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com> <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com> <20261125090732.69233-1-tianyi@cloudflare.com> <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com> <20261125183125.25801-1-tianyi@cloudflare.com> <CAKgT0Ueso=OQ7=GJp7m8nr90kBUp-+N6ko+Qy4e29MZv6tLQfQ@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Wed, 2026-11-25 at 14:02 -0800, Alexander Duyck wrote:
> The thing is once you start making modifications to the frame all that
> metadata should probably be thrown out anyway since none of it is
> really valid.

I see what you mean now. Today the kernel does the opposite in both
cases:

- When XDP changes the frame and returns XDP_PASS, the driver still
  reports the RX hints of the old frame.
- When XDP redirects a frame that it did not change, the RX hints are
  lost.

The right time to drop them should be when the frame is modified, not
whether it is redirected. I will look in this direction. Thank you,
this really hits the nail on the head.

> If anything, the path you are taking now with disabling
> CHECKSUM_COMPLETE is the opposite direction of how I would probably go
> about this.

Agreed. Once XDP has the infrastructure to pass an adjusted
CHECKSUM_COMPLETE to the driver, or to simply invalidate it once the
frame is modified, we should bring it back.

> That is why back in the day we had strongly encouraged
> people to use non-zero UDP checksum on their tunnels and had added the
> ability to convert the CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE when
> decapsulating generic UDP tunnels.

Yes, I fully agree, and thanks for the history behind it. I am glad
that UDP over IPv6 requires a non-zero checksum in most cases, and that
ice reports CHECKSUM_NONE for a zero checksum.

Thanks,
Tianyi
