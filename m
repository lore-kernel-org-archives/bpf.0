Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998790;
	b=MMBGQV8fluoj+Ly0sUXy8Wc/1WzmJjfprEKEBjxY4zM96X5dOwoqpk/TDAMVlDIFB4W0
	 3/NLasr/Zj+XI1NqKW6eEMp7Tr8iMzej8cqDNVRJ5k0nHBI8QWucaCbQBbKcfQj3ZfH09
	 Dg34kssLrugp/8wH0jhWhb9EBb+pLXsDUDW6Zr4J3uYSkoiz+rb3by1/Chw+tKigIg3rg
	 HCiMEl9DS7TY3BW5Cp4WAIwyqOwO0MJOeVp3Bu5ALjh46b+66oj2eFHfJVhswdaLQGu6U
	 4Z8uxNXd4U8lXaETJNlZsD/YA6mPu4FK0BFbVNT9okcoCucPEgrt3Uod/ZKYR4MdKKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eK9wS1PQJuaruDa8ED9WMpeIWcZDcL+VTSMog5FV1LQ=;
	b=OPUCDKHo81yh4e5a1Dx7Ml5ybulV20E2CNXwduTKc4ZHxdWnbQa0VxY1UMYmg/qXFG3Z
	 xmIn+MGsA4wFbaEabWFOBWLNIcmae3q9OBSTVuSVL2JPgfW/s1zeqDMTLEPziQ8RMl6Ur
	 uYrvHNcaSc5KjcTS/kQZpGLDs6MzPmHba/id59z8n5gWxUwdAIUwoXHzfY3ZsBEYw3wUI
	 2wv9X2JMGcI33D+Z4I0SVS0HMECxGlu4BO9zf+ZCdv/FHKgVLcJXF6X94Tbg5vqW2l25r
	 UhpHFw/DAH3gOjBNwn7P3KWEdJgy8ioA5VFjUKh0ZXO2HNpM+N/gba2PmRYTg5bRtRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Cwf6HK40;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFE606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBBFE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Cwf6HK40
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d427836e9so123093866b.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793998788; x=1794603588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eK9wS1PQJuaruDa8ED9WMpeIWcZDcL+VTSMog5FV1LQ=;
        b=Cwf6HK40lU7xC/Aq+E18OIAD4vMigdTT5o4cMnerIWvLp6TYoR4YiZDzRFG20v5bTY
         lAkRSHgBUUdyqkv8ESyzn9pkoupsyjlBLKAy39kY815zaoEuP8x3vYIGDHvSQD9AaLLi
         Ld/1vpDC4o4/INtn6eIgliShhRgPntP3gl6fR8v/+aPKjExsL7O69vz3BNsiS9p1EZn6
         1+Ca/O5dqSuQqc1ZDIhf2UxNI2VA36XwpJYr3orF49JaaGa4jjLCdr0tCsm2ZFre4sjJ
         UzjfZUVNHr+q/guLz9RPTQ44F4/mNcwG4YcJ8zfDiPaOC/4Sw5dZmVxETgTeEgIvOGES
         iSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998788; x=1794603588;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eK9wS1PQJuaruDa8ED9WMpeIWcZDcL+VTSMog5FV1LQ=;
        b=hDL+fkn3x/EoTKqdIt98C6rL2EzI3F76tUa+mwRAj2ych7y69YlxTQ6vDOIbNOjiq5
         dalmDqvzmSQOEmvAzKXxCJnSn+4gF35T2BzKcKFL2aHEYs+k9NFCvMGMOnQPkeIIo1nC
         gjc7E5tHL9h9KObWu8bOR7u5fL1NW3Ues5S1jZiJdLEVLtNY0oGeJ4kncgjhWIqWlFzy
         exT/gGuotlm0pxNNZhytLZ+wr42sDWnma5cNTyb8+U0HRCowFYpdzZUJc+8oipT+QlJ0
         Wc9srfx7P/bDJJz6a4v4ynjRBD6cq4OG+/CbaleDiCfRm+ov1p8YLLkTNAkyZrjvw6Te
         1Fpg==
X-Forwarded-Encrypted: i=1; AL+hErFWi3EdK39zpzKjS8Ri1S2qPOlcGCSxSk2OMdzygHCfRbOnYWTzHJzC0MQI0T3gmoODAE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MqjqvKKDB6BLwLEQ4v7XtIGI+/F120YvHY6YlIfUqYDOx0juM
	02uYSO3PJiqLuQjizrllx6IG+w9WpTo5IlRGPiTqAepYZbwiU7MIbu99fOj2+TSz5L4=
X-Gm-Gg: AYBFou069FB6MHI+YPTGdZF3IPNIuZ3C1qNH2Ch+K8dSjF1IBL65RSAUwQqWTQLh/gO
	yNdJ4e1f0QyipxwkmVtUAgOtwTnPjILc2a0kYalgszT46qfr0m2Pfne15XsWOOYxYWG2APucbyA
	fPra70muB7PCV6wcPbjJWwVGQkijjWWUd3626zvNk9O4BTJC7V2KtOVvcJrER9rbqjeH4dipRsL
	OSW+voPZDPibtjMVkFf2d22rs+GDC8mYA2u6baIaUSbSZ+/q1LDP4fpV5cOupWQrXI1U/Wm3B1P
	InMcvmf9faWYH1Q2oIw1UOnyWcDTecxSXl8XVFj3F4eXb/bL0hf+VOL6WLbEge4AkoFjxsY/yoU
	WwnGU5QizeLBLl19HsVYdFGq8qSBM2v0CZiSQB0LaLUYsWcVluZKq87kus0uCaRgcKDAI8BwWM0
	QWSOZLbK5FvRe6ZjQZc6W9ITr/f95mHJ2i3iwZBF90Ntev3sbJFmP5aIwUTNbEFy9dVQ6KKy8Gn
	o0lOASJM0BIaQRMChzcSniCGaj4rMU4FDkmMLkaVkBhQQBuNabMxNqUnciaOq9zoRrYRuxVnrQT
	6i/6E8AbPbFdxRHKqlNFbUrCY6xPPX62DYGxBe/xUc4i3AZJFkfDYJ5RuNp3AsU0Ft1/+Dtdb5s
	/0rEqpF9v
X-Received: by 2002:a17:906:9c8a:b0:c4c:b4fe:c9e8 with SMTP id a640c23a62f3a-c4d35505ef1mr307307166b.38.1793998788172;
        Fri, 06 Nov 2026 12:59:48 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562df86sm104305466b.24.2026.11.06.12.59.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 12:59:46 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: David Keogh <dkeogh@amazon.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	David Woodhouse <dwmw2@infradead.org>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	bpf@vger.kernel.org,
	Nimrod Oren <noren@nvidia.com>,
	nh-open-source@amazon.com,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [RFC net-next 0/6] net: configurable extra TX headroom for local egress
Date: Fri,  6 Nov 2026 20:59:39 +0000
Message-ID: <20261106205939.95366-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <au4j2nQdOwr90ffh@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com> <b8914a523b4a6b80424c5001d3d8012c6a98fd04.camel@infradead.org> <bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com> <a8f2f84e-7dc0-473d-afb1-af710d621f69@iogearbox.net> <atW00dwVpYS4WO5a@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com> <au4j2nQdOwr90ffh@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
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

Hi David,

Thanks for the review, and for testing it on x86_64 and arm64.

On Fri, Nov 06, 2026 at 07:00:42PM +0000, David Keogh wrote:
> Tianyi, you have a second use case for this: an XDP program on a veth
> peer. Please describe it here, as it bears directly on the points
> raised above.

At Cloudflare we run some services each in its own network namespace.
A veth pair connects the namespace to the host: veth0 is in the host
and veth1 is in the namespace, with an XDP program on veth1. XDP needs
XDP_PACKET_HEADROOM (256 bytes) in front of each packet. The packets
that the host sends into veth0 have much less: 2 bytes from a UDP
socket and 64 bytes from AF_XDP. So veth1 copies each of them into a
new buffer before the program runs.

Raising needed_headroom on veth0 is not an option. The v1 cover letter
has the details.

> I suggest you post v1, with patches 1-4 from me and 5-8 from you, and
> the cover letter under your own name, since the veth XDP case and the
> new measurements are yours.

I am happy to post v1 as you suggest. I will fold in the points
you listed and post it on the latest net-next. Thanks for the TCP test
as well.

Thanks,
Tianyi
