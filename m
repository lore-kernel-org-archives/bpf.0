Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597207;
	b=yqsb/XDC5SgynyGWKFpik4vKIp7P8bACuHXi5mCr3BE3eI5thpAfrtc3SdKeVEcdODeT
	 0fnqV30Z38P5yNRM8V+PNxbeHR3BGYl4T1BqYHY2GM6rwGd1t4QVrZOk9sfD40flUuLAR
	 tEaF+RbZWZYu7GHlEnsXj8UmLWnibSyo3EBg/RTUjuO68/lh3A1FPINhUj2Xu0yeue3Kw
	 vArVu6IBQ5lu63f8uiaZx6kD3vEY6jxUi5Saj86ze5nOTFJIUXwIo5LjQHT9Vgul2XnM0
	 QeDfEamGIfVfOyrFA7ICWP5GbI+l8kdQ3/ESKFxEpSOBsJ3fqIYpOyNBY2oZTRtO0cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wCuJhhLEoHgkC07eMz8DzYO5TWgSi6mxnzjUookJyTY=;
	b=Yfi1uWj4M4L7Qrhiwd3ad7eSA5Zk7pxf53tOGB5W6Qvyllpb4trLvDFhpUJH9Pb3S/Of
	 MP96vqcUjEZ7kELTCVqHMCDyM+fT9oVxBNvtfXckDv10jm0huU5zvD3dVxPa6eyECRO3y
	 jDW+zy8v2Q1DqWBt+bBBASCh1mxSqoDGEd4iN7skLPVZ1+Noq759KHZFCbXHcGmlpVUj+
	 BbPTggrDSbLpnWq5zJtdokMjT2GYDLweo2sBYedkhP3BFigjXIhc2rD2zN2MLEYBXmQ5I
	 O6TpoaGKDnjUImiMwXnhBJLA2HyJf/Su88A3h+dnHhlUb/qlwG196wFoMSchPPOUcgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=bhBpgYSE;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DBC606A335
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 09:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1DBC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=bhBpgYSE
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c5126505cb3so707862866b.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 01:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795597205; x=1796202005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wCuJhhLEoHgkC07eMz8DzYO5TWgSi6mxnzjUookJyTY=;
        b=bhBpgYSEVMMI2tkfZ6abvUy2hz8ISgTfJsny9X7YS4AYnon4DTf4YzuQBYvcdYYCG8
         hNRrq9ym7RDeyg21rIjJJUSVZOkrlO6ECJOMQSXyHvr7pr1nitIQFeYinlX5xJfXsO17
         Oo9XlIpVjXvwFYbmnZGLXvbtCfpBo0HMJa2ATOf7wf97+DO9nCT1BgQ60A/blA1yNcxC
         762F5M2KDC049K1HYJL6iBRlhT+GIKJdELAxPzgQd2UN4PdqV6IMRVXr01mBIvIWeYJQ
         oSPMpJxtg+q5Uv57GyAu6QygUP0GuiSI2iJ3JYSxQXSSX07kEIiHd8iNy4X/KgN97vYz
         3I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597205; x=1796202005;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCuJhhLEoHgkC07eMz8DzYO5TWgSi6mxnzjUookJyTY=;
        b=lxyOgepg4bXHN+uDhqwYo9dWVmuOU3kUYcGLwT3lURaBj5fxIS9YJJRBi/Zcv/fAAI
         HtXL0+IGvBM9EMCXTY9nezydaWCNWUUZzHHolZwG8dGjOQSZPkO3YBCP6FcgLVbJa65B
         Qsie3r7HGEqNB4K6NsvpBGHdoecdoqTvnqNuQHxsqYRCBNHtJYOFKWt4Wr7cWgPTvJ28
         kYPcTBzkNv0MTwpLDp+2y5fNZFy26k5rN5NX3VsQEXcvcAfaEvGr3DR7WLDEtMx5o/kc
         qsHT5uiPyTn53BCNKaTAXzlplv5pVd+L2lgZYYOlEMYnGbI7rNiadzcagow53+rcTgEe
         olVw==
X-Forwarded-Encrypted: i=1; AL+hErHMXOLWGAVbjs5QRpNszQnpMRdrZSOWyZbKc2Qn7o1IqUi0tAeNYZWkxERel7tJxrIc1jQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uLATGw2uQ6OIxP9J1hfMqI4QY4znChJ4liunoWwXMh7nYUS+4
	768Jm+YYT3ln882fv/Rxg32HYnTvUFJ28xZdhjSPCn6Yxk5s6b2eiYSYgzY3rOuGpi0=
X-Gm-Gg: AZFdTZeAhqi/dL9rFJVSITsGbBIXgYBrDbF3ASjddWcsX4AYw1/CyfjogdmZ7MSguyu
	Ik2MfJ+fNl6aIbzExJWwztuC3Fa4JxQkfcgZhBCLntSmk8rYevn+K7Q5/f13jZSuNPWp96FGRKk
	oE+213sDskqz2eOMoLjNa16Om7BxtQCHAXk+DJTDGel6yq2H1cxv7Qj3oGbHEriGO0bUcSjCkGq
	Y1CGVcqLFvYBsEHvu8vuYGznrSbW02LbWHWpfddF1GPOK1J1jmf/PGMa+dJSQYcssdIrrwPx/OO
	NuAUd45nI4lmN0Mx8v1kiMExVXyL3RXdgWKDf6E3OpxMyqh71KVZNTrFC60s/7CewXR6jwMlDm2
	RG4CD11RlsDgNF5L332/2g4XOQYx4rbjIDELd0P7H4bplOHmSXSBIqCrDssibHyfP/E7yQvkcRc
	FarP09YBGjuuf5haGymwpUwSdEcPaFnZuJxvgTF0185uiuYHfNX5om+tWIuhitmtLbKJnrD8qCa
	wIpitk99EQeSPcnyPwTAcgDZJVDFMmYMIkIUEGbEVngQ04M3lqm+Y+CsYAVtyHxoqLjVdPBAS++
	2P4yepckV+tN6xCKm54VI6Bhobl6ZUT+Sf7Y4coB2b7BqFtdaJvdeJxpcZJwV2AZVguIvsAt7n7
	bazE=
X-Received: by 2002:a17:907:ea8e:b0:c49:a235:8e0c with SMTP id a640c23a62f3a-c513aadb22dmr1360811566b.22.1795597204487;
        Wed, 25 Nov 2026 01:00:04 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b01e242sm591351166b.82.2026.11.25.01.00.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 01:00:04 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	paul.greenwalt@intel.com,
	alice.michael@intel.com,
	eric.joyner@intel.com,
	jbrandeb@kernel.org,
	lorenzo@kernel.org,
	alexander.duyck@gmail.com,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Wed, 25 Nov 2026 09:00:01 +0000
Message-ID: <20261125090001.60782-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179557068810.3135.17964087549504688357@kernel.org>
References: <20261121012402.84848-1-tianyi@cloudflare.com> <179557068810.3135.17964087549504688357@kernel.org>
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

> [Severity: Medium]
[...]
> Would CHECKSUM_NONE be a safer fallback here until the pending XDP
> checksum hint series land? If not, could the commit message describe
> this trade-off?

Yes, the inner checksum is then not checked, as on E810, on mlx5 with
XDP, and on E830 before v6.15. CHECKSUM_NONE would make the stack check
every packet in software, also the ones XDP did not change.

The discussion in [3] concluded that CHECKSUM_UNNECESSARY only is the
safe option with XDP for now, and that the decap case is a known
problem. v2 will note this in the commit message.

> [Severity: Low]
> Should this use the per-poll snapshot instead of reading ring->xdp_prog
> a second time? The program that actually ran comes from:
[...]

v2 will drop the per-packet read and set ICE_RX_FLAGS_RING_GCS in
ice_vsi_cfg_rxq() instead, as Alexander suggested [4].

[3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/
[4] https://lore.kernel.org/all/CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com/

Thanks,
Tianyi

pw-bot: cr
