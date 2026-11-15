Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771348;
	b=G+8O7f8/p1RxkoryxEEnfFoAsW8++XtHl1/gzYhe0WDxnMBQsj/ZRGceKaMU5vMgdSsU
	 gztb60b0NZc5ElevnzpUgiWccZP+yNkJ1awFy/AeC+q/N/Rm8/OMeL84JXWBu40DWjAwI
	 ugej+lqzpqE0L9fEKM479156RkU+OyYZy/bHAwa7TaarsCw7RPM90N3Q/X0OGSCnvnqu4
	 MZM2J5PHbJyBLZPQJBTFvyTVZM5a6wftCfrgXIZ7hcfpBg70pzW3zPPCKp+bm1nNesF+w
	 k8zW+0omn8E2rykNeWcAdwSpFAmmhgLL1HNjM1lXRCHE9f0hXqyvvXcyzd/UxtW6j8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A71Vxm6qPP+187+TkTcZc1nFho9ZnzIp6cYrVgpdGpg=;
	b=TL5eWzv1z4Am8nAkx4P4I7ZIGXdiBmSnjrO6SAMQ7c/x9hFhhXzHYI6rJjJc+1aL4fId
	 buwprLQQhfj30or1FZlpV/3yxIeZYe0Gzgzc9WCeABebhMJJwqnbi4nYe/jUU2N746HvH
	 1g3m57hpxVNtlNTCkh+PkxN8n/DjyEzliVtIMkWlg1vBj+styy1kWikUmrV2XmTfJSmUk
	 nGBm5nh6iz56nTqiPUdanKx+O51S38FvU3hnd0PMuqMZYWyH6WOaA47D5YJ38oSCF+LiH
	 JFGph1OfmrumQWL7pJbMnBEQKnX0SV8+Hpg8Tc53kfabDiZ+DzyO/DNtNlISQLoC5fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=BnRr26k3;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C65606A891
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 19:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C65606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=BnRr26k3
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso496724066b.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 11:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794771345; x=1795376145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A71Vxm6qPP+187+TkTcZc1nFho9ZnzIp6cYrVgpdGpg=;
        b=BnRr26k399RsdMOHX5eH/Zxcr0/ZNWhSJ0dtvkwH/YUqVso17JVwuWk1gH0B4garbK
         CT4nnq3fpTI51stp3EpGM4ZB3aWoRlNcp61ZHTZN8jhjdzHyVYGEWmjPN6swd2ntHS1N
         IrvOiVM/qhoMax+IaloSB49L2W7FBrL5BKiv+3opc3jBBqBi1gHuJjX2PIrLzttChG5b
         Sbw5Mcq5pt4lIWRFGkV1T1UWIszVEz/BmZ16V8F8KDopQ86V/X1nR6fjdEoGmpCdiQGf
         aZm8HUU/D6yE0d/cvyGR7WzYuI2PEDBopzxMP3qw5vZW2z6gc+mjZcUnn+XHfU4lfsUn
         swyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794771345; x=1795376145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A71Vxm6qPP+187+TkTcZc1nFho9ZnzIp6cYrVgpdGpg=;
        b=XqLg92gYOFwmgkciomnZTAyFSVT0yMChijGf9myPi0lG7+lE0/wGyQeySJSwu6Iik/
         AmAtn5vlBL+o9cHWtkaCWt4Z5PY5U7duFatUFOnwTEgwP1xGnErMoUJt/OJ4r3kQIrIm
         8XhfhQBkeq7uUA/gyoA3CPByIid3LsRbbjY1Q4AIaINi1oTMbYMIeKQdNP4vQXGPpbCN
         lmeLsLZnB1+b2D0KbazO65dgVa1YpbFIxFN1S8LU8X7ahpRapSV1GQHrimZ634ig2HhM
         JTZg5UtjbwAxzz9BuIXumsoNqRfxpxxMvjg8Vj/LlfOWa99C4DSQOHXH05Mekn/EKSad
         KfMw==
X-Forwarded-Encrypted: i=1; AL+hErGYCwRhZWtcfL3Dn36l/phWgNUt6OysbVDvgrhSkwUAjGi6uPC4vfQQAVHkjmpnhd1NYQg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/a5eFEzGFwgIDYxGN928YLBARzvmi0ZGfk9xZ6FK7rNb3jhSZW
	0vviF7RQlSdiGZCVoCseXrNsJ0XBhtzpmayLNkskCZAIlf8XBwmpSWzTat1v+hlRbzE=
X-Gm-Gg: AYBFou2VhPDWbV027UaOkZ6+80pI55GZHOD6HyGSzfPBJsdMc9wO+OY+ZIQsTfCxXGN
	hjPbhYfrbZz+YQMDKy8f8gCMyF+5KZO3U+zu8MPf7J8/Y0iAGq6mm2Jb5mY4qV2sloWd6INUyOS
	a9ffmisv0D3zyGJkMQg0Lz4tTzxdBX9lll9fe4IHN0WrTD5ven7YCcFr/jLxSEReQOlcgfzRi1L
	Q1omOfys5B2T+tgO9ctXxiggOYjDa4r9xAjMDGs6q5dstrHrCtl9klcOsE6IpN7QILqsww4qp+Y
	qyo3pqkPAcQ9lThV3OyOiq3tPq8EJzFRD4lZUh3c2ccs3O8GoYr8yNmeK+JGtf+7X9PRechjkr7
	LVjUYFTO+N2Qz8D8aH01ILFvkIMsizvYr5fJDtJfgO/wi4meyhAWExMj6OnYKeRvs0KN6tnXnrB
	mCg4hTzN73v76242WKsMjHpA1nqQ84N1uIuMV1qQHoTVD+SIlCWoqSGJwkvxHDnlWHynKf9/LGb
	yEuQ8SR2GlS9BNXQYzKZ1/3w6RbQRFnfFBD5Gst+AsUKWQOpxlohpm2lcGeDBI9E+oOXKiB8PN/
	HDl10b7MyIAWV5EPjVjjFqqCKwGhssJNBNVxTCvwHeL24oRaSC/FHlR0KA==
X-Received: by 2002:a17:906:9f8f:b0:c49:a539:aa45 with SMTP id a640c23a62f3a-c50963cf771mr650243166b.42.1794771344781;
        Sun, 15 Nov 2026 11:35:44 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b24b88sm340448766b.16.2026.11.15.11.35.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:35:44 -0800 (PST)
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
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 4/5] veth: use persistent NAPI config
Date: Sun, 15 Nov 2026 19:35:30 +0000
Message-ID: <20261115193531.57679-5-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115193531.57679-1-tianyi@cloudflare.com>
References: <20261115193531.57679-1-tianyi@cloudflare.com>
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

veth deletes the NAPI instances on link down, when NAPI is no longer
needed for GRO or XDP, and when ethtool -L reduces the number of RX
queues. When veth adds them again, each queue gets a new NAPI ID and
loses its per-NAPI settings. An AF_XDP socket bound to the queue keeps
the old NAPI ID, so its busy polling stops.

Use netif_napi_add_config(), as Documentation/networking/napi.rst asks
drivers to do whenever possible. The queue then keeps its NAPI ID and
its settings. virtio_net made the same change in commit d5d715207e29
("virtio_net: Use persistent NAPI config").

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
New in v3, as Sashiko suggested on v2 [1].

[1] https://lore.kernel.org/all/179470883411.2199510.13825316417997386083@kernel.org/
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 470c4f95e4a1..1c7ee3bf65f0 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1057,7 +1057,7 @@ static int veth_napi_enable_range(struct net_device *dev, int start, int end)
 	}
 
 	for (i = start; i < end; i++)
-		netif_napi_add(dev, &priv->rq[i].xdp_napi, veth_poll);
+		netif_napi_add_config(dev, &priv->rq[i].xdp_napi, veth_poll, i);
 
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
-- 
2.56.0

