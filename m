Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736054;
	b=Rh9WhI7A20IqTLEcmEE8/OLtTilKYzSICHOoCaP2SI5DRqTSoazHsroKKv0SWUe+g/Ga
	 wnvOizZHldpLr7JDPhsY2e6P6ebwMoOhzGN5RT765CcvimQRSLT3xRqiJQW2JYT+0TIp2
	 2TkaNvoJQLvsL26I2ghOIW8WPxptSMn51Uv88Dnx/iUkB5dDPelkjTvVPEkv50XN5f1h4
	 vaXORYFZ7UqNtCpsUzdg3kntZMEluV5daohdLGR1OB9ciantaICoQ8ippGR1QkPImiG7z
	 6D2bVckfrGGfvzYwglrz/lg20600yc29t87JU1oN6e3N/75a3NPbamc9TyNaLUh4XQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PwIPxynn/Ts+hRyBLxahwIuYBf8HIZ9im3ZAloF6OKU=;
	b=1uE60+9YQ11RpFBIpzw1bK2Z7qgZVoEH05B/LukPPfLyMQqHClTCiCxQj2oHv+/gZIPQ
	 1Qhpv/hmIGWND+EUmjyzlnbBlL05p/t9vLSsfRVRuvVfYTYxU9/FfJoS87JHj/1gAcxxi
	 3sJgceWsgg6G/T2Z333Sdp2iA0bV2gw00kbU1cPTqshnMypaKyUYXjmW55eXJyHD/8XLF
	 tbX0WTJ/kE1WTQCV4dfd/e/TuG3hGFKHnZdQXVEzDlhztiWKxy+WEpaFen0GFgNJEgJB2
	 Xit8cO9DH91B8LPXj3Nb/9DP9gHIuuQegsbXdaiRUr6YgF2xn5jDqxhsXMzhUAGqjxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TvQA4Pri;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9B606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 20:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D9B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TvQA4Pri
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so6178203a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793736052; x=1794340852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PwIPxynn/Ts+hRyBLxahwIuYBf8HIZ9im3ZAloF6OKU=;
        b=TvQA4PriTmn+nz4DaXS/V9tkl72XSKiTidZx9tK4/+l4YXO7Z6CJDGxU1X4jxIgZeC
         PPzjjCrW2dZ5+K78SwTMxcKOXaxQ+2ZIyL+3LtQcWWGMcyxt955QX4NFsjj9t7LTW3tj
         usr9957QCwSh2azAzuYVIY+Skh3Df/rPIj2X4Eo/Ht6tfmxeCBE2t0PHpTBhiaP0sGE2
         ixvjcR/xCJzJ7T4S7ClYyFkZtGn9Q3h1lOAvcHdlKJx8PyKfUdf+6lMJiCI68pVpnD68
         8DNX+KAErrKy9Z/NT4JGp4tfR3XVfWQcbfjGoBipTZR1C0xBprQasEUFHJ57KtGMSLtA
         bdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736052; x=1794340852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwIPxynn/Ts+hRyBLxahwIuYBf8HIZ9im3ZAloF6OKU=;
        b=ZrEtfO9fH4W3r+YgHjzc7kpxddWy963CAf4IIIAYYwl4nMuR3wk/Wvwthz6bI+Kv+M
         hyy2GXvq6aZFi5xVosWCfQ1RjgPaRXEuVdy61yYNSqukUIy0xr9zg1qQCkfWO3lZgggR
         H3rDEs0X2EKvgOj0oxhJcIu8dtW4MMkcnRqZxgu1qtcTykhJjgn3WrWKY3EVcWDR6sU9
         jsaG+pZKAZkxhtKUPrpL9PiYDatOSiXHUmanStkuJWIAeUFNTYPT6Rng8RVekDjFENSN
         epW9LCtxLh2BbX+TjW+wkQlzWgV9s1fDzg+9ArJQjyCButwSVg+nIa/Im/7VlvdRTjGR
         eJQA==
X-Forwarded-Encrypted: i=1; AKwUvBxXn0CRHnSZaOW9oxCAlDUq1vQ1+2fKjH7m0kdas1bTmVBqe4NfXPBBhD0M7444cJHhBlI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SuV7yZzjxeskRE32FKXIMySYFy4t+S6YoPM9Fypx/MnlV/ucm
	Brsyu32N5kMOA5Lo64EU1QhId/8bKCjEqQ4XJEv5PyzAwlCIPTThVi6c6sOg0RsWMbw=
X-Gm-Gg: AYBFou0btvZL/0h7j8c3ULFesT18TrvYCbVDvcXYqJyGovaEwOlSaMeKYow5MGx0sUm
	GV2ZoQXSy8x3aw/elNxf5AH6xOilTzfbPYSM9vtf3BuL/P7ZwjFJg5FZFD821SBrr6LfvWIrIdc
	nEF1d/plWwLD4bmoOiNjscqmTimsuteD7KXRoDE3Qt0CrM+aOLtTjwbv3EhOLLX09ldILlk9iAT
	wFBnNGu9+ezVlN61LeGn5a1hr5xbr+yprI0AAB78veNDRQS5z0aBv4oz25f7/H/66yhuoSI5aDw
	/2jeHw5kNsqNvSja6/kyrBBUUL/pcPV0tHAWnBwlywGseciACFpV+5Vjpdh9OYowRCA1QEJaBZs
	R8XULDJXNoBTpQCj78ZLiwhlexkPs7g72Zo6jCwDBb9TGXcR63IEbfO8G1R9PMVjQrUhaW3ytec
	PbmwxThxsi92AkIa7Gxk+meyO1gUCHoPWyy2NpBADrtqfZtPedVBU1XnBeko69Owedza696QD3O
	iKlpxvrS+5vGIyzYNhcqma5sQaG5RURiUiAYrsFEB8LGI5scElYaRTgRUh0hK4qZmtPJv+pXTeq
	2KAhQ6zjtkpShYBPJeDEs8V3StIjq6xVzn524J98SRuzuso=
X-Received: by 2002:a05:6402:1d51:b0:6ab:7700:9371 with SMTP id 4fb4d7f45d1cf-6b4d468b63cmr9974496a12.25.1793736051901;
        Tue, 03 Nov 2026 12:00:51 -0800 (PST)
Received: from D90XRJJJNQ ([2a09:bac6:37af:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec91e2f2sm4499801a12.0.2026.11.03.12.00.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 12:00:51 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 0/2] net: fix mac_len of skbs copied by generic XDP
Date: Tue,  3 Nov 2026 20:00:35 +0000
Message-ID: <20261103200036.65764-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generic XDP copies the skb before it runs a program with frags support.
The copy happens when the skb is cloned, nonlinear, or has less than 256
bytes of headroom. skb_pp_cow_data() makes the copy, but it does not
copy mac_len. After XDP, the skb has mac_len 0.

Two places after generic XDP move skb->data by mac_len:
- On XDP_REDIRECT to a cpumap, cpu_map_generic_redirect() pulls mac_len
  bytes, the length of the Ethernet header. Then it queues the skb to
  the target CPU. With mac_len 0, the IP layer on that CPU sees the
  Ethernet header and drops the packet.
- On XDP_PASS, the skb can go on to tc ingress with a BPF program
  attached (tcx, cls_bpf or act_bpf). Before it runs the program, tc
  pushes mac_len bytes, the length of the Ethernet header. With
  mac_len 0, skb->data stays at the IP header. Therefore, the program
  reads the IP header as the Ethernet header.

Patch 1 copies mac_len in skb_pp_cow_data(). Patch 2 adds a test to
drivers/net/ping.py. The test redirects packets to a cpumap in generic
XDP. On netdevsim, the test fails without patch 1.

---
Copying mac_len in __copy_skb_header() would cover every caller. But it
would also change skb_copy(), pskb_copy() and skb_copy_expand().
Commit 6001896f0098 ("bpf: Run generic devmap egress prog on private
skb") hit a similar problem. It copies mac_len right after skb_copy() in
dev_map_generic_redirect() [1]. We followed that approach.

The bug can be reproduced on veth, virtio_net and netdevsim. The fix was
tested on all three. Native XDP is not affected.

[1] https://lore.kernel.org/all/CABFUUZFQXxYVdi_QqhGG8WTTf=F1BqOmroYj50mv0w70Acf5Bw@mail.gmail.com/

Tianyi Gao (2):
  net: fix mac_len of skbs copied by generic XDP
  selftests: drv-net: ping: test generic XDP redirect to cpumap

 net/core/skbuff.c                             |  1 +
 tools/testing/selftests/drivers/net/ping.py   | 27 ++++++++++++++++---
 .../selftests/net/lib/xdp_cpumap.bpf.c        | 19 +++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/xdp_cpumap.bpf.c


base-commit: 647b81ddefc6364290e67bf33c89d54971f8995e
-- 
2.55.0

