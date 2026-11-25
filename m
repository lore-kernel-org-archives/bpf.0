Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631514;
	b=WcM6RJB3pIatFFnP0m0iZBvGHK1sDz/SpFkuIvWqKc3+cNJsrtk5WBS2enhniT1xhzVf
	 7GH+e3fcX2ROblop4Pw+jdmA6WLkJP/szC3LvAWMhloHt+sh6VJELPldVdl8eYnUjXDXX
	 tWSTeEweKdnsFpNXg28+YhnLHA8f06+KLgX/kgzHAsnR8IngfUrj81iVHfvMp/0uozLXs
	 HaVomzMe9h+tHfdDpNltn0820tSJn/sNWiAiX33TSBVa0XTPFZWSPGuUJ7YN5EySSzKK9
	 aCnjEja/jOjGMqVHa/LrWZNESNMujTkeKgab6NbXFSSOv4NMcR+8RsWZtYlOuPKXC3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c9NWxL0URY5wSNoGWrryAkeMpSu11Af5bqDWyaekRIQ=;
	b=XqKxQexB0Fl1ewbyVwT8FB3y5SVLyITNxJfINjgu8koLT/S0ZhRYInSUVSeAnlrjdj5f
	 +8kB4jOf5BfJKItbRanI7tDvZmoPp3tw2QDbVWmWZKxabwW0CDZ2Yxs8vgnSFWnEsLrvF
	 Z3QvPGJHLkDbVTOxDLKNyzJ5wKom5ErhagvlS3zjrCloPjrloEvTy5CLNtiT8ex3ADYo+
	 6L+guF089qL+K1LIoVgvNbyD7T6/C2E/C90c5ka3hWAhFHkKF6lTwqvqFCYzL9mHAP3il
	 lGpcQ5opW18NNZVVnOtCbI2fPT6qzFpFtkq1gvtxjWs3b79zgBGwYQzwge/Tj9hMgdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=aw1a9JAb;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB4606A32C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2CB4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=aw1a9JAb
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so1025284466b.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795631512; x=1796236312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c9NWxL0URY5wSNoGWrryAkeMpSu11Af5bqDWyaekRIQ=;
        b=aw1a9JAbqZNeXN/uQOFkv/A5Bp+ErDRYSZtNb+3O8jd8/FYFaaZW5YyhqWuY9PmP6Z
         NOXKeasRmYrqB0agWOj1PHJf1AFONdaA6PHNlGtTMCqzQ0j1BJUSwGVLag4jWrh40thr
         Mcmv4LYbb1Nq5MSMMZV58sWSrs8WbV9oZMBQPVowkcRz1GtDNjt6Ss/XZ+ximZ8UIb+I
         BsO/7nwIuaJgLegTqTdtUdBFTtbf+IUgLkBRFcZW1/x5pn2GiksScU8LUGBCwCR/mt+i
         d2R1MYTGeSW3SdW36cHEuhzrCAmx7qO4apSZubpwbl3ncOnAET+apmjFCVKf1wJSZR6K
         At8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795631512; x=1796236312;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9NWxL0URY5wSNoGWrryAkeMpSu11Af5bqDWyaekRIQ=;
        b=KYgeYG7gKiUKDbVNS+ur/uCSFwOrCU2ft0QOA67K0KMIkzjTP3d8+4NPGNWJHTjvaR
         C0azWuuCEsdAByuYzi4caMDH/UTzrKVgD/qF5Mx5nyR86DPw6sxO7dZT5i48yXEwRbEO
         xhyt2K0G7IVejy1/ELih+j4PzS2te2EyKihRrhqAnOmHXhFtUZ1cLiRK6VIcpGyYP8Uy
         8HKSMhWtlazyZEA2e/G2Mm3O5up2zQ4JnInFdBTG+coOV5dwvh7K3ttk4wuZyKCe35no
         Pu/2uWjvF8sqetqlrOE7BLIdPBTv3Tc19csGMkZWGKjB2395uyfXB5SFKHu2FKNeO5eG
         ShWg==
X-Forwarded-Encrypted: i=1; AL+hErHsg+L4tvs1NdZ90klg01ix/U9nbl4g180V4tiiwN69VEnq1PIdW1MWkXW0dngb2BibvN0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NF29P0KWO/2gNnUQmO4k/seyv+oflg0cZIYQIT+RHR4DX7xAa
	9OYd3Bjb3GGW+6CFG5HLVnDfRW/V4+kzIhePyGVDwESG8VJ26mjCRTZQj4BM2oAbGQI=
X-Gm-Gg: AZFdTZeGm1cvMkubIdv2S/iHBB2guw56LaQF+42zj5l6HzlGnP4DhDKtacAIvwkh0Km
	v9fJ6FILORgtIvUCEqlgEtvbadrHZ3KVK7WQ7Ybq1j2oXFWgZE+WKcI3/0BihQSBK1MeKu2AKsn
	XLqodEQ/SUrKZ7YnQ/Fq7asVvLVVePO7wUD5JZNsf0+qP68k6oBUqJh08kjudtFkt0eQG3Pq57f
	ma/cQrJT2rdsHxMWXvuEkCTFP/uNxCfgQCLNfHCaPBAGEwqete9KGduc5W+tgPXjztvbalr2gJv
	r7e9A2iOv2TH2xXVaDeHz+2KKCYzve02kZhZByBLC+WDH6Kfkz9Ki4YtEX1HIJz4ZMZeyWd5W8Y
	oeStezLd0POj7osq/HBSCYIdrJj5Fuu9FqpB3T4PXLbpDS4Os3b/kJZSb6czOWbclNii5oY90s0
	brub3CRTomBeppRp148jdkLgd6I8xvRZP15n5viNclaarm2G+Ktur/SI1U4d2t50fii8Zl/HuNm
	zj1LKOeSpet1wWVQHLA6sZvzC/HWLoiPG3a7cp3JGMjQM0/9CBr215HBd5sGR/LWXxb0fT1oeIo
	CEzs3awRz+KhTLPSWx1sJZTOMww75gaQ17QlFKASPFrjW5k=
X-Received: by 2002:a17:907:a88f:b0:c46:d493:501a with SMTP id a640c23a62f3a-c513a8410d9mr1669468866b.22.1795631511890;
        Wed, 25 Nov 2026 10:31:51 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm686554566b.68.2026.11.25.10.31.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 10:31:51 -0800 (PST)
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Wed, 25 Nov 2026 18:31:33 +0000
Message-ID: <20261125183134.25863-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0UcvdZgtNtURJGPqAJ3dPGnCpa1DbpX_KBbEmoK==WXNSg@mail.gmail.com>
References: <20261125095201.98279-1-tianyi@cloudflare.com> <CAKgT0UcvdZgtNtURJGPqAJ3dPGnCpa1DbpX_KBbEmoK==WXNSg@mail.gmail.com>
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

Thanks for the reviews and the ack, Olek, Przemek and Alex.

Also adding back Maciej's ack, as Przemek suggested:

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

On Wed, 2026-11-25 at 09:11 -0800, Alexander Duyck wrote:
> I would rank it up there with the e1000e jumbo frames packet
> truncation issue/fix from back in the day
> (CVE-2009-4536/CVE-2009-1385).

Thank you for the pointer. It is interesting to see how it was exploited
back then.

As you said, this case needs an XDP program that changes the packet and
still returns XDP_PASS. So far I have not noticed a way that it can be
stacked with other bugs, but I will keep it in mind.

Thanks,
Tianyi
