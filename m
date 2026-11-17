Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932186;
	b=QSkv4Dbh/hJ92yR4PC+flNvcKcSJnGTNO7sZ7Zt/hREADPjFpcqPlBbVINFkr/EqSUkF
	 gYmSTo2Pmopy8Vnh/f18Ud1HTvyW0nNWQ3I9HoyQKnO/imWaGtBBFKuzQglvVWbBmLAX6
	 xdqV9pk6kd4tHSaKIhZNdJxQBzIAcfWvpGntbBgiRkLbC/8UgAZ9/0nRQaLOXQFsNJ8IO
	 0l7ik63XgOLDAudzH4U9HXkVTOkwEu8LApgpPtoTZFiovljgkRaNgm5BwgoDwdNxjykdH
	 UK8ytb7BdTqZ+DUih8CQIXTYXWzLLRrw9OfqFM0expY5Riq2zFyxL1ycotZD4QR+eXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3epTVbKPJVG8iTt/z4MHuDPL8RwQKn3lHAOFYRFX2uc=;
	b=dt5K7RvcWB667dUhN2kM9PloA8NaaYoQVfbmrq1IXiO5lwUiS1YZFtHCbLRcg9iONxAC
	 sEEXwAcHwQ9/ji9k60IUyZZTxchcNybJ2wk031I4Xs53J9pSwOv7vEszPTJq84NjssuXL
	 6nRHmOokKKCEnRZ5FWlFpK8u2nBFxT6/P3P3Nq2LQKNPndukd83usxicjimAdr8kYLNSp
	 Tw+gp1Lq8Vit+Ls0hTu018Lhlu+vM0qrJa4M7xNC6VDsfXHSof3AINn0kEfrj4B3T1+9j
	 Q/gzi9NIyvTjOm19Aqs9Ac7Ye/MRyoiXA/EsUwYGIeUYtmZoZVrw2EfbUokfv8LEqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UpSR2Myj;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518E606A32F
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 16:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8518E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=UpSR2Myj
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d427836e9so657115766b.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 08:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794932185; x=1795536985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3epTVbKPJVG8iTt/z4MHuDPL8RwQKn3lHAOFYRFX2uc=;
        b=UpSR2MyjHvrEaRxBPQUaVNwY5hXBUuG7pyxygzHG8O1OlkFcTtvImstuQRqRpLBA4r
         d8ujp2NOgvsfRkCgBHT99e6DvBL3yjoZG+IRzwPN1ecpq8Zu1gziqA/LJJbKmUU32L96
         +j5J/XDhamhmyebOPpBG6lvLVHypiH9s5zxH4yI6N81cQPeunv+Y+9WbmyCs01sxiCoX
         E93SVwIf7wxbx0XWpPk+aocZMK9ejnb/JEglkxAcxqwse1Z8hwdGohRj63Nd4/PwWHJk
         /kSuhuk8KNpLagBGeAGXgI3LSl3mMI3oB4+FQfhFlZpxkA8lCcHoxW090cLST8CcTcKZ
         OhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932185; x=1795536985;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3epTVbKPJVG8iTt/z4MHuDPL8RwQKn3lHAOFYRFX2uc=;
        b=WtW9wthG6FxlhyoUcLUb6kkcRGKRu69V4wFw5c5ww9lEuOeTorZIH3CXMIsbUvXyLm
         vXTEb/SOxVMHW4OKxZpZHyikyoFVEVMPfcksLrWAOtoRjvqnaPxpCqnXW1LxzwUlhCzv
         Xb2MWk3EiXMbH/f2tKdT6Sd4hlely9XPYBgVDxSIFxLVgT8UYCkwxW27/NhVqzAIUbnO
         jnEQNkUx62KKDL3SeL092WAK8k7AwqAOH/UXr5Ndwo4a2oFEDixSS5nyN6Eb+ISiWzkZ
         8KToTov4fBR0m3UR9N8Rrqc0Pj2s9xy5R5xBn1X7rCtiHMqkiv3jevEmGfaEfrWHiJCT
         UJrw==
X-Forwarded-Encrypted: i=1; AL+hErEwbG8bgw+ch3qAqMPknoD2TMGcj0Sno7mOLwFqs4h7mWBJIES3nWx/dw9yCU6JL79M4Wc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uf+vN9yghDb7qFpzFCRRPqQMC535gdeJ9y8sKjWuYPVVbsymL
	Oq2Eq8kESLTDZw9AQPpyEMa9L9iN6pZ2JDsZTItC7QDosG197mbHs0FLSGk8kJXcsgE=
X-Gm-Gg: AYBFou2hkPBmL5gZ3W7hzLJZHF0j1D2BevrgYM8zQniHRs9tePVF4IXD3oeUbWahlU2
	tRJTTrUqax8aBo3eyxjisVMjV3+s0E+pZxQ3GlpCqrGLhlM87vITRvgiyCRbJM+fMxQMryH7HBi
	WxIvGdk7uTIhXACWslwL7WdV+AMSK9gPDxJAkoL5YbcniW1LSidnbGG+c0qeBHp55x3eo4g16tS
	iqHlp78/hbS1ZwvddXEfdqUaa5Ixoehftk4hGLIFGPqAq+ZxZUbCIuOoGcXbaZQ3f5HWr5s8KqI
	20M4x6Bj98zmQMyZnl60r57Ru6i25c8mSFAURul06sVGojP0f0WQMAIhwUsbF0jj8UzV4X+H8FI
	8IJMa3AytyJZXN6TSXxXZ4DhHU4vGwEwLGlh7+oTCkD0IKbvV93jb0OyRjH6MOUi1xnwxKAULF2
	gdUbAKR4pOLIRuztZ6fe+D8mLAxGX8ia8LWLTP3APm9t/S1TKX23USqUMKPzmPKtBIe4hgQc9Xh
	S4UbY8SnS7SnZFsLP78kT+uI88s7zlwNgN7DoR4B04Hy3nKS0q6vZoIB14xnOIVU3EDQIwNfRJD
	/pe/a0/mynSPQzlWpXw3sgXuKQSXBU5EWLPboyHcmiEfD7Q=
X-Received: by 2002:a17:907:dab:b0:c49:df8f:3c79 with SMTP id a640c23a62f3a-c50963b88f3mr1191532666b.34.1794932184976;
        Tue, 17 Nov 2026 08:16:24 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cab33aasm857666b.52.2026.11.17.08.16.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 08:16:24 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	ihor.solodrai@linux.dev,
	tavip@google.com,
	maciej.fijalkowski@intel.com,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH v6 bpf 2/3] veth: use the frame mem type when running XDP on an xdp_frame
Date: Tue, 17 Nov 2026 16:16:20 +0000
Message-ID: <20261117161620.62739-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104121316.1155680-3-sst@poczta.fm>
References: <20261104121316.1155680-1-sst@poczta.fm> <20261104121316.1155680-3-sst@poczta.fm>
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

Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
