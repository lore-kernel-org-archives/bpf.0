Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286646;
	b=n6NXtYQkCTRyvwHT5L1SIxDi5vli09Xr76i8IN1IvoWH4N1/AuHIOQHDwMMy49aTVXD9
	 QM3krzqutnBu21vbN9QdNHsmoOBROp24F/EagNdlTncNqCXEyhTv4Qp8D4s8cIajYqw71
	 U84xAMmcT3uH+kmnQA1kDyjnqbgquromgmeZvsplVJlC3OvguilnU42rx1Dc4lH6sVhcf
	 1QXRaZrcY78FtimFuH0yfGZs6/OgsUUh8NGU5oH1N2SyYmxABFLSCjgS1f1pDc/etcKJq
	 gigU2XmRdxNIuR7pNcKAey/tMSpPBNo8dnM1TV/cxxY+7vopwVS8/yqsqHDLEwRABTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
	b=zkJR01JnBuT7N4hov5S86VOHS54UtMkWhyqaTwuGSiPEt3j3YEd+qZPjuS/xiXO8ddR0
	 Y0LaQ+dDcadyl6P52UcH37CE7a4237voSoE7xxN3Byb2Ym64xj8gPyqRvjre3zgUd2eGR
	 tijqIan+y4HsxbYhOIrXsqOc8ysTdT+d7b8CpvXns3JL7aXVtSowkpy+LoG6s5Qja0lVa
	 EIitkjDlagUXujEhWM11xyUyN3jM0y4Vuiui0YPiO2DI460+9IFpbkJ6GaDqa1x49mURd
	 usD0OK0VqwD8ujfSE3sEMgG3MT9CVFto0xIL39ubKsIRL6sqfTYiHw7kuGAZJrZ/nMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Pmo0rHrZ;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744F606A32E
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4744F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Pmo0rHrZ
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5049f267c9so62759366b.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794286645; x=1794891445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
        b=Pmo0rHrZ8xzQ4pc9jzGRDfzTjtLd1IRAVVjXk3M8DK+x5lpVtGm+3Dl6uTtb4GPmpW
         /kKBYz2hrc2Rm+Kxx9p9Y1rOYhYETA+uur0JgwJCQfbRVDCqGAQvJaSqLr/CAtouJUUp
         4EI8JGlE4+HOHQpjKg7Wj36ghxkdR1iij2T5AfQs54lGgGxXfNWJBpU3fu6uYaxmp0iE
         h03+ZFTJVKcxuVU+h2Ajxu9vjISLloWpvzjtjz8V+N8eqRtKz/j204rfu5i68WzK5U7n
         uni6yfWdBejSU4Gl6uBoPfx8AeyMtwsNevJKn7zLq80NHgCRRKv4vWsIOySGtv3QDvth
         obtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286645; x=1794891445;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svxxE6aa4tOgEOuICid1wcHp6IDk6Icb9UfPgrrg5LQ=;
        b=2Bq5/zMaFvH0NBNIZTMFjBb/u7HjjheWr2ElUJIV4spH56RJGvtR/nMMo/FizYQSt6
         zONnWlQy6HtahXWPmqatT7dej176n8/e23g2XEyTDEWAqf68/2EsEcfAUzilinBrmUWy
         uambErwRxD2pz22kA0KrSKHIMashGEoZk9ICN7dWAqGQNWkvXvp0Z2ROpRLQkpS97c8K
         zTpwJAyXp4ejRaaivBOw5QnUAJkxGQbcMbMDt0Ef4grYQqHCTj+LsX7m0/WXst2KmE2G
         7scvWxgL1gygQVBiEf1CZwOnYl6YfdNnuBQp/77AS+0P2f79tcgUhVnpeVYgocKy5kJR
         0v6A==
X-Gm-Message-State: APuU4Z+n2BbwwVy+k86tazsv0YfUZrziw6OSCz3xPUuLKL0rg7MxNs7W
	wo21/kXU7ex0WFRqmwDHEs3eDYn2wfpgt8TCqa7D7i5YOp7wvhaIf3qoB8mVuEH70O0=
X-Gm-Gg: AYBFou0qMSYSTB9E4ZVSjoPXjk8ypkErovSGl60RgUxbt9Uq8GTeY6RocOcMxFwrzxx
	FN5QM70tR68AeZWc3VH9YQISNlYpzja8AdP9aTPnXfifRtmxBincaapSBvRqFw8qCM9ArjpPEQg
	19zbrQ/BbtqRnE4Fb2RvJSGuuBkWihqo7twgCwEoqoncipUcG0W4OJXJn3XRYU55/bKbiQNKBBh
	3/cnNNKkVfx724MiaFxSRop6w3cKiGdHdPO08AUSWb65E+fGEYmBh6J9uvKywmyNNSrHWXq/RJI
	dgAh/uzk4Yi/RqCTpffNM3kpXToiGnhsQFv+jJkvFTM6wtDIquN0tlr1I9CJW8Ygrh0WkeGap2c
	lMjzURh8ochqIVs5CehsFTle0NZGS8k2QKKi8i16yViFzf3HCyegd1gSxlYsNe10T1avLZswL+o
	7hUTiyRLjBZlV5ENY+627PtPZHPCEL/B/8Pnbhda7IOgtPHS7Uy0Pdk3HgnKccvdBK+Irodyg4B
	x8KsFQv6JjTsuUBSIa8jbK9HUUsu4Y1i5XwaIkwBEXLxLp3uU7GpqgTygx8jZBbmYOoE23wgUj4
	1Z8KIzdx/vWoB02IU4OQf1mb9uNgr2km2xt3FOSFkSHoNBGcxqwNfrAYylY+SQc=
X-Received: by 2002:a17:907:c13:b0:c49:9632:9280 with SMTP id a640c23a62f3a-c5049713306mr110969466b.46.1794286644790;
        Mon, 09 Nov 2026 20:57:24 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56c721sm61278266b.23.2026.11.09.20.57.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:57:23 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values when XDP runs on an skb
Date: Tue, 10 Nov 2026 04:57:20 +0000
Message-ID: <20261110045720.77278-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-206173@kernel.org>
References: <cover.1794281983.git.tianyi@cloudflare.com> <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com> <sashiko-outbox-206173@kernel.org>
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

Hi,

On Tue, Nov 10, 2026 at 04:10:19AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Critical]
> This problem wasn't introduced by this patch, but can veth_disable_xdp()
> unregister rq->xdp_rxq [1] while veth_xdp_rcv_skb() or
> veth_xdp_rcv_one() is still using it?

[ ... ]

The list [2] and I [3] are aware of this problem. If it is still not
fixed in a week, I will send a fix to net.

[2] https://lore.kernel.org/all/20260917185814.0f944e78@kernel.org/
[3] https://lore.kernel.org/all/20261105143356.17062-1-tianyi@cloudflare.com/

Cheers,
Tianyi
