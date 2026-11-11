Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362375;
	b=jCRBwDhJCCnyBgoNtIamxoz6HFmPdEz8cO10ZM6ZP2huG21zfj3JCYOWzgDkYP5pqbLg
	 Goh5s1VdLigz6xqWx3REbvfluBAQpV2KA5nRgAguqUpdp9z8SDUTbM3UkEsrOqyhZ0OI3
	 qxztzEuhFnQmhKQf/DNtSqwDIXthU8iNPqqfphlmRGEfCpqcFvdPwPUw9J1Ssn34DzhDh
	 0Mj2islUy55dR3eIkr61AKSmu75cW+mcfG3VPCskcbKhxx0TOrqwDcQZIXjBUjBIhadcu
	 iZyjfmZjGDIG0epffK5kmdBWXMpGO7G6mngdhDm/zkkUtu3QqDqYUX6Lmuy/YWLCYcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WzryhHStuQlBVjCAYw0PiX7ovDnbv3qfhee+mFhRhaQ=;
	b=Mme65DfCQwXmmEWQG5Yw+9+1DVNe0VlIRpZd0j4HYfzK4MRGuQUSuskPIOjcYTkTCYwU
	 Sgx9pgQdQKgNhZRNhUOx6cIcZlPyum3MSL3WJfr3Tt24PhZQRmfE2LDc0wmup2w+ZDKWw
	 XKyIETr36eGoL+KkaDYOEo4EepDHyrZ+bJ2pPPj6yUAGM3uhsIoA4duttx7dBO2c1EnR3
	 5p8ZJ/llKb8YFGCumQXGt8GAOCcpxExYbmSEginfhuzk9UVcgga9YFN7+L9qSMSzZaGao
	 ceNy9silLamTCYHUIhKt3ZTW9AmJVRhybEfl+/PWAMBvWRx8wrTZKRAJ+cRh1kSe+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=T0VRk9cy;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF8606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 01:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACF8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=T0VRk9cy
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4322d310e7so408865166b.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 17:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794362373; x=1794967173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzryhHStuQlBVjCAYw0PiX7ovDnbv3qfhee+mFhRhaQ=;
        b=T0VRk9cyW5oSeiYyDz+wV5NVJ8rOFF1fugEdBoGMZNcYyTJVuzZdhlSKnDfVTGOkY7
         WxQ1c4TjxwX/TMvf3XvADgIt1SncBkH8gXxclu47MWVegv8Ds/763QcTVVLQsGvTliiF
         tSWtnZkGcwJbQu1JOwwFkMFM+HRoDxf9w809+So7raMfWDcKbbVBOntah8IgCv4MvsLd
         hdkxpovNIpy5NkEsEm9gvLwxHlbhDrQNmbaBvUCxW/S35LCX/3njQc2Z1w1t8779fjUI
         aq7th/FeAW5qHAFZGXSFfYJfDzyf8aI+gLMLlBrWHKVFmwKeOlim3nnk4hJRG72eULY2
         qWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362373; x=1794967173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzryhHStuQlBVjCAYw0PiX7ovDnbv3qfhee+mFhRhaQ=;
        b=bT+NTYfngbeCCVEueg45chaqlP4oqVK0pY02Qp5LKXlhQbjOyu7+kc+B0cSJ3ctQur
         KOq6KFnsc2LDo0Xe6dPQTVTkPgG25E+WXXMZt0SUD1bzjfEs6iqMlKirdFZrRalCXO0Q
         hMV/4/Dbc2VtDSEG6xN9vG07aka4pkaNT2mGuJZ2aEeRxAE89kGII6NEu+1IDZ08zi7I
         lKiq4CzKJXX9AIrf/D8DqLipPYsMclkc4uUSxtqZ1ztiOpbsEqQKMl3kiK2VY7BeXczF
         z3wnSEVw1qoMK5MAMiynJJmZ3tC07+86w6rXp+z1pAZVy8qhTVD1uKH6E4uLLjt+oycg
         +qsg==
X-Forwarded-Encrypted: i=1; AL+hErGHAKjQlapubpPOcF6xzCJ4W3saed08RVk9Zv2XmKcqIEZCZAywRxD23CujNANPRAsJfw8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/96wGYjhYmRAtKClrMIYP0SB8VQX+ik7DV6y5lQjYndJUG35kw
	ZILkxqqEUvYMvG/b5O+gqXAj5ljnsUWgs/sYKED3dgoskhWs7lNJ/UZUSXg1yFhrzqw=
X-Gm-Gg: AYBFou1GDpmy8AWOR2oVu82bqjmvZwdPcfEnTfIg4xjhchWP8w5kYITqwY2NJrHKeH6
	qg0D8kystR0kDvXjkbwdNmbotj9O2DLD+UFjhKrXTuPkh6U9F0albtGHYjazPSRpzmqH/RImjf0
	k3ikFf39pMkHzPlxbhi/vWGZjofZ/3gv5xWYpIsZap3K07CFqswLY+2cNS+u0i7Ace40VJbA3j8
	QwYYfil1ZOSkR1VPBBGL/4znpC7FOwqB48iFhzcx3qDJ3kpATevBWKshD5rIhmI2xzpBM5PETi7
	1cvzS6OZcQua9kyWcB2Aydl4cwfITi0wn0MvZaU4VAFjb7dw143Dgt/m/7kklBK3r7gN+sdIN60
	oLS8SQfN/WgnMfMi74TQ4ta8ne+Zs/xA/b31UISqt7D/ui/YUmA6tAF+l608lRNJF6fvVQxsck6
	vPH5fmyT03DXMTsHFrLBo8CP/9PtMSLMm7o54TPMdazGrTlv6H7EkXQqezDA+iIBzpytkLpnHNL
	HsRZIoTZggP5DECBhyJev5bmPo4ekovO5nyTWrKdhWITX8xuckxhh3hrdsEtSvA3eeY0Y1Vx6c4
	URrfcDoiRmQ3cfnPwjHSulfzkb0gzgP8NHq9+yJN61vrNyFhIVZ47cF7qg==
X-Received: by 2002:a17:907:9289:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c5066cf5ef5mr59870266b.40.1794362373265;
        Tue, 10 Nov 2026 17:59:33 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm147498a12.12.2026.11.10.17.59.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:59:31 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 2/3] veth: link RX queues to their NAPI instances
Date: Wed, 11 Nov 2026 01:59:21 +0000
Message-ID: <20261111015922.67745-3-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111015922.67745-1-tianyi@cloudflare.com>
References: <20261111015922.67745-1-tianyi@cloudflare.com>
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

veth does not link its RX queues to their NAPI instances. queue-get
therefore reports no napi-id for them. napi-get lists the NAPI instances
of a veth, and their thread PIDs when NAPI is threaded. It does not show
which RX queue each instance polls. Userspace cannot tell which NAPI
thread to pin for a given queue, or which NAPI to change with napi-set.

There is also no way to busy poll an AF_XDP socket bound to a veth
queue. Since commit b95ed5517354 ("xsk: Bring back busy polling support
in XDP_COPY"), xsk_bind() takes the NAPI ID of a copy-mode socket from
rxq->napi. veth never sets rxq->napi, so the socket gets no NAPI ID.

Call netif_queue_set_napi() after napi_enable(), which assigns the NAPI
ID. Call it again with NULL before napi_disable(). veth is not ops
locked, so netif_queue_set_napi() requires RTNL. veth enables and
disables NAPI only in ndo_open, ndo_stop, ndo_bpf, ndo_set_features and
ethtool's set_channels. All of them are called under RTNL.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f5097696df15..c04277186405 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1062,6 +1062,8 @@ static int veth_napi_enable_range(struct net_device *dev, int start, int end)
 		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
 		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
 		napi_enable(&rq->xdp_napi);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX,
+				     &rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
 	}
 
@@ -1094,6 +1096,7 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		struct veth_rq *rq = &priv->rq[i];
 
 		rcu_assign_pointer(priv->rq[i].napi, NULL);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
 		napi_disable(&rq->xdp_napi);
 		rcu_assign_pointer(rq->xdp_prog, NULL);
 		__netif_napi_del(&rq->xdp_napi);
-- 
2.56.0

