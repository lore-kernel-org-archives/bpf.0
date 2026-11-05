Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889244;
	b=K79XuijqPrRFhcPIm2qbKwF48BsCnnoaSLpI2PhDWpxkLgXdX+wbb+lZMw9U3h1J8BY8
	 RtRKuKVnqCi9QO1TCixN1wLaCN8MBxgsLtqQ8FwL+QmTEO4zWTFkcjcCFm+dxhV57I506
	 kloZDGoWcanwg8v8NM2DDbQPIsUOxYeS/2gOmZhiYbpjlc5DjGqo60YGAnIEgp5iH/Dqf
	 eDaxH7eyC50eL/K75iE1BB7De46WsZHvkxc5MI1WAndhUb01BzLaZy8SFez9ENDp/Bk0+
	 KVpDdH3umAO0wWLj6qeXvYCnMfMLWoHmkc0nKAaTUFAnURHVgbK82WZidIzDQ8kwj+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IhDYLVk74KLE+6uqmnSquzwjdzarIeNlcvxoecJwRDc=;
	b=jUJNyX0QtsvwZ65cYNvm3LgaLV3zbnfnHVouvTJ98YBHV/o7n6mfsN0JI3PZNxCTuSvM
	 7xYij+/CozV5/F7VzDV7d74tYrhCUpyen2lsB2i3aYPQSST1iRZzOK+GH3I3/Kh+hvGmA
	 ZwEIDNnPzZXlhhScjo9RWDx6ps/Z4/wMTVHrvfrq2HjaZFTmwdpAVLjMbUDtKtvFvLHAw
	 1uI8eF67hFoW6+lhI28imQAkK8ZHSGVCQR1cHbehxIMx90hSvO6dA8aMQeSkBCpmSCRrG
	 Jh1aFJp7/bjtn5QW68Zpuhfz0QL5jkdVFhFiUiI+dsCZ95y6xLFNJOGNttC9uXbtqpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fI7YdUxn;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC00606A32C
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 14:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC00606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fI7YdUxn
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4697404c2bso19846366b.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 06:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889242; x=1794494042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhDYLVk74KLE+6uqmnSquzwjdzarIeNlcvxoecJwRDc=;
        b=fI7YdUxn5VVBV4gj6rQ1cryJGapHcjKNUi4OfPse3RV0xiY58lbw36dK8j3VxJOmg+
         hf1pBxhWTSCnVZ65APXcKDbZ4kVyq8yqyH2D5tUHc1z5Erq4rRDvqS/4vXXOmkUmPlDc
         LPvkbhN2Y/z7uXHGXqinekWGW5Fkg/qgO7jfnWKcbjsKE2k2BPZXPnyj3AT7JRkO0dSk
         VD2oVvau6hzh9+X20J7oRzTomCYuA6oGgtgSHogRD5Q5w2bgvC3V4ZEfJpfAIDtWZ2OT
         TU4pnrSkVqebHisq1NuFFY5YaLnT1xXklB4Q7uaO0TUaWDiDUtbQaF7OOGyGTI0ltp7f
         68Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889242; x=1794494042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhDYLVk74KLE+6uqmnSquzwjdzarIeNlcvxoecJwRDc=;
        b=2PxHF9JlWdKYiddq5+PlxUFVYAjy6CM/TTf7J0TM/CBWIAYN5rUo7DU9n6BrcWkBnS
         RJDoolCZYVpBuqxmKpjiO2vVRp3ZaZ98pYbIVwEPzy51VuGei4DCMUhcKMR1IJsn1Cgr
         oTrTCSAoe/nzpzpl85H62q2Fe83PSTuGXdBN3rlXiUFLwTWitKA4j6uuF22rxf/0XMle
         jxrEDF01eybnn05LxHqNyR9uOLxNj4Q9sIEJEkJnXS82JdK5JENNzV9y26ZkDt9+jxI4
         ikzKVsmra+dIbBKuS/HoN3+jJQj5mvFLbAvrVVN+B4Kh0439+nl3DHqBis8AIPweWXuR
         m38g==
X-Forwarded-Encrypted: i=1; AKwUvBxmcsIwhUwth/rT2jUjc1/e1b1s09KhLkev4PQVZkvb0pyvh4903bi45Jm1ggDRWXHc4PA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JzYLl/Einlig7VRlIyISiTgYattGDIPv9Al1x6gsnRLyeAKFF
	e1AVDzU+BDG4Sjyx3PpN0Z/ygJfLrJAf4UEaH4/rgqulVSOcEhophgajfOmzUawRXxc=
X-Gm-Gg: AYBFou2FFKSvjmiLqNKxyvZXYPzC1vgl+EC2W8DolLyVYqjM4vdA20OLyarK71Yf+zF
	lH6IXFAQSPSz2MWPZfQH+waaCT53vncFOngG8HLNjpJVZm02m4AxRl5GsUNK3OfaEN0JF6qES0C
	qdCLJX4pBUZaIRkcKc7ykDvZ2AX9d43aSPj5mhxK2891z5/IsD6q5oksNHw7YNkGX2EGsW6lrsS
	6HaNr8vlD4xoYkQb2CpYc2dFFsKhKkn+hupIDBKR3fi+Mt5QlrCg/kZh01XB1RZouc5wYpQg9Sm
	O6NTmeRZt6Qliib8jW3EvUoFTyBu0cUZE6Oi536vLddGUij+Ldn7Wl1zxfVUXN0Ea4woHdzVKRi
	6NwaYYMV9MbcEzRemhSbCTB6QarIMMyBt4ECvQW2QH0SvjmDl2CVNTDRjwTXtuRvnlkKPL9S5ai
	T3wJpzFVw6JYce34R3xH+KYB8Ar6JyO2YTEGM5SVq2AVGhYqXsOn+3vfropT8tFv7OGPrF2Srvo
	pqJ1zLWgdo/n7kafU5RmllLt43hBuTUPowzJJ3UbF2cGi8rbQ+oVwX/3HRXKd4R75WgzQ4rGmuN
	IKJRMRnokL70552cq45bBcz3ntAoqC8NW734dTdJPATLJGAuTlWpathNKKxSTsV7MlYj
X-Received: by 2002:a17:907:a890:b0:c46:9ca9:f522 with SMTP id a640c23a62f3a-c4ca7a69782mr1644438966b.26.1793889242456;
        Thu, 05 Nov 2026 06:34:02 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.34.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:34:02 -0800 (PST)
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
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 2/3] veth: link RX queues to their NAPI instances
Date: Thu,  5 Nov 2026 14:33:55 +0000
Message-ID: <20261105143356.17062-3-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105143356.17062-1-tianyi@cloudflare.com>
References: <20261105143356.17062-1-tianyi@cloudflare.com>
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
index a3570547ee99..c00ebc5b96c7 100644
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

