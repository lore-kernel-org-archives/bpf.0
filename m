Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075934;
	b=oAfpwjS67VaK9zs/KbSaAm3T+CK9AqsZg2kjDEqoC0RdxRpZNABuDw+6qJEXVVbWE1Ib
	 cAWj6ZHF5L5ABj30tapWdDKWrTStx5z7HtI+fA9p3phDgOuqn9kk52RZ9cMgWRV4uAQcF
	 icW+FoQZgx+ZZ4GfN5ImvtGb/J/FBvdIXm3Y2m2zeCSf1E9tLC3fqZgebhxrUrSW/UUVq
	 jK+4VXgsFhm77usU7EqqexFBOlCq0Iw8gE7MbrdqQoYf7j0nGaJf0UQw1WurukFnfvosj
	 v7dM8LnZIYL1UhMRHPDP+nECcSS6ccAVqY5rWPPJRZa0yxQ7QTiOgkRDWuvlcNId34Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o4KEBZgQa5HXSbmQneNQ9t8RBeb6quQFAx0lvX+O4LM=;
	b=jEf/GCBlTsbmeDf82v6GetdAejXjXFjTeAQNalch5hC3m9W5bPoACMgncXXI7FPI16pP
	 ltb8hAaKLLoDaVjP00HFtlUxK5fMzbTwrBTYvDMrhPzVDZ+1iBV+tvwW5sdfKd/j2aq35
	 jXhsKtbC1XKoF3xL2uKTvFjrN0DMd+5dtJhf8ijxZbnqNOiuH9pT6YAJKE972L8hSk27d
	 dg9+tz0R+p8I+3/YU6ToyK4420l3oE8MXq3QUVLsSAfz9vsffbpyn94zUSWJjskcterzF
	 hZnvFxMPs9SeRfGGg+WGPEUQr75Qgy5RE8qItonrfl6Bir2J/dcPV2cicdjkTwCpqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ZXFxPfbI;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA0606A32E
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 18:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DA0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ZXFxPfbI
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so1925049a12.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 10:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794075933; x=1794680733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4KEBZgQa5HXSbmQneNQ9t8RBeb6quQFAx0lvX+O4LM=;
        b=ZXFxPfbIL1yDhO7eAFUmmD5GbEzTzeTMc45MKZEzL2A15eafYpnSeCWHdGS9HOYcDX
         UfifGvvj8hDRRsWB0ca7cSl0soaX2SEyWI4E/iykJiHosDG8fK12wSekdcoB/Ws9axGp
         1udECMKCzZZi/q9tpGpr5/naHelYTBh0JJCeSstKL9TlkU37DMWbx4i+jBVGgDwwLiti
         Adjl6GsUsd2IAOjOpIiRxpGhKdEYUHmef3yUR1vCWTttx8or9aSdBiR9f7/mFqu6uMCH
         UMTAc1dzDC1giOev7pL45ndBOaDrTIvqkuZK5BsNXdTbqEp7AQ1KOCP7rx2aOUi5AkIc
         xdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794075933; x=1794680733;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4KEBZgQa5HXSbmQneNQ9t8RBeb6quQFAx0lvX+O4LM=;
        b=1/j6PIDs8sEUkh0Hp1Hb1/u6RbtBH69+jOnmqTDQVtibN/nyJEkW3TFudHW+DEMIUk
         S5uMunglg67Vmc7BB38kJptiUS9nWvzSUUwz9YxHsNa6BLj6iGQN2JHMbuZ0QVFwkORP
         rmhzjAzpP8cQTjXY965XZz9+q67FClDurOsrsx8d6lS5+4Zqb2NFLkC56sUDhmIZGHET
         /A2lrP6iRpxXWthq/IZjQY3Zv/KKHtGkW9F5S2BiXWIog/dl4hYJ6+EZpomAUfLblz0t
         vfPzUSJCLPO1s3SG1IB3gpMoEXYUL45BW2VVXel+ICirKkQ43y9OsFqmelED4F2twNut
         EBYQ==
X-Forwarded-Encrypted: i=1; AL+hErGm8e1wLpOA/xkBh4BOkWY9wm7sV3/cQ2jY7EWiAYCk6hScyUsdEAhOQNTWw7qC1YyBnpY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7ghgP42Sv7SxQC4siwCQ17werBom7yZwFabLM4TZ2zqzbhoEB
	6Ul5Mc2YdC5/JVTiMtaIVIOhQSaKe44B7yeL8Xkvh14PpwUQlT5Vd4xcLa+7ra8ypoM=
X-Gm-Gg: AYBFou0oP9bgbfLBDtZXH6DNlayMWlqxByxAK2pj/AancSHgYTZEhSCpUVd5hreBkFI
	PwSLaquNOA/bVgNiFdsWnzYpX7j37zDkMPs58KaSMqoHL+3qDEl4Y/nfVD5dUX/Xx5ycjge8x0M
	+8BEaYgdvTct9ZbukYqB27dSTXBeDBM8j7W6hZ+qsV7j5eoo70ZiTbe9E2dEpL2+ZZGWqfQrDoF
	Q00tlF1b/zbtyzH8H5MKgkR+fi7HiyH8bnXbwLJdYxp5IPo5Lc97rlGfnpi5xxRu3vRfPg8MsxM
	4o3hoOIXFcajjnglJmqmHFKtS8T09MkMaUvIUXHZ7Ly8zS0/waroMC5wMpEvo+opdhRFIKHvOJG
	LGX+DD/mZJ6bZ4c4CSpvDMympiYUHF1KefCceA/BAjHMQX/kY4M+6aH65P1f9d8J26JEt0O4uAb
	mJ9vYVWtOYctjVm6D3iQn6jl7Al4l6usFili+tSDNUtiv9bk8je4pvWDelGS1VOfEyPvd4u0t8K
	wu5EWfbl0FfB1rilEQxfP6yjTn7k4ADebYNkmPpksusOwPK/zMCkMzGBHFDIbK+Y1+FWNXJCgn8
	wzQMIZbaERElb3m8QPg5pJEKs+bhtqJ1kk5nP/Ah6l14QDb9uz3Eki6C7A==
X-Received: by 2002:a17:907:3f8f:b0:c49:4450:6248 with SMTP id a640c23a62f3a-c4d34b8d695mr429135066b.16.1794075932804;
        Sat, 07 Nov 2026 10:25:32 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a999f00sm644066b.75.2026.11.07.10.25.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 10:25:32 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and LL_ALLOC_SPACE()
Date: Sat,  7 Nov 2026 18:25:26 +0000
Message-ID: <20261107182526.69543-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <willemdebruijn.kernel.1d64e7848503b@gmail.com>
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com> <willemdebruijn.kernel.1d64e7848503b@gmail.com>
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

On Sat, Nov 07, 2026 at 09:51:07AM -0500, Willem de Bruijn wrote:
> Tianyi Gao wrote:
> > From: David Keogh <dkeogh@amazon.com>
> >
> > Add a tx_extra_headroom field to struct net_device for that purpose,
>
> Main high level concern is just adding an extra field. What's next,
> do we need to add a field extra_extra_headroom?

Thanks for the review.

A user needs more room either in every packet or only in new skbs.
needed_headroom covers the first case and tx_extra_headroom the
second. I do not see a third case.

needed_headroom does not only set the headroom of new skbs. It is also
the minimum that ip_finish_output2() and ip_forward() require of
existing skbs. Raising it for new skbs also raises that minimum. With
XDP on a veth peer and needed_headroom raised to 256, throughput drops
by 2.8% to 5.8% for local TCP and by 4.0% to 20.8% for forwarded
traffic. The cover letter has the detailed analysis. veth also cannot
set needed_headroom from user space today.

pahole on x86_64 (defconfig, net/core/dev.o) shows that the field fills
the 2-byte hole after needed_headroom, so struct net_device does not
grow:

before:
	unsigned short             needed_headroom;      /*    60     2 */
	/* XXX 2 bytes hole, try to pack */
	/* size: 2688, cachelines: 42, members: 187 */

after:
	unsigned short             needed_headroom;      /*    60     2 */
	unsigned short             tx_extra_headroom;    /*    62     2 */
	/* size: 2688, cachelines: 42, members: 188 */

arm64 defconfig gives the same offsets, and the size stays 2752 bytes.

> > together with LL_ALLOC_SPACE() and LL_ALLOC_SPACE_EX(). These add the
>
> Since this already changes callers from LL_RESERVED_SPACE to
> LL_ALLOC_SPACE, could this additional use case be integrated more in
> the struct fields and helpers that are already there?

Changing only the helpers does not help. Without a new field, the
helpers can only add a fixed amount, which every allocation on every
device then pays for. Or they can derive it from needed_headroom,
which brings back the regressions above.

hard_header_len cannot carry it, because AF_PACKET and header_ops use
it as the link-layer header length.

> > +#define LL_ALLOC_SPACE_EX(dev, hlen) \
> > +	LL_RESERVED_SPACE_EX(dev, (hlen) + READ_ONCE((dev)->tx_extra_headroom))
> > +#define LL_ALLOC_SPACE(dev) \
> > +	LL_ALLOC_SPACE_EX(dev, (dev)->hard_header_len)
>
> If having to modify/add these helpers, it's probably a good time to
> switch to actual, type safe and readable, functions instead.

Agreed. v2 will make the new helpers static inline functions.
