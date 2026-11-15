Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771346;
	b=n3N0mjAGW4bWfM3tp/4IVfE4zuX7qqeWsbTkIF0tgvQwOPBN86V5nob9JZAcNNpsU5+Q
	 PCHbnqGiLV+hVnOVo6llddsoyIMQWRKXmZhxYTKCu0GLxHXva8kZaac9EeTnysp/Sjoar
	 KDvwITa6xhdp9fRx8NbMQoL+dT4MNg4LBnJu3+7U3ZeiQCR0Rd4WKGMAPMRDU7pbrfDjA
	 1bAZgAk/lOlRxIcLBIvX+wmyVHSvuDe732s66UmnHChjmZjiIRQVkpAiDrh0biY9IkVC0
	 I8eKD1MxNJXN10VKMRae6JHXap8wHg3gs7PPLGfIt9pPA8h5ECHeKZrZX2WeyfHTMTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j+9Eww07QSnuPfPdAGrAWpz3n8x4NlApyIViVNGE2Rs=;
	b=zehIwwNv5DRGAeISQKtcSmm8bUhONhXJsqdJo18ZBKUJgS682UWLRPKCLNUejoIPlSVM
	 lkXDNRXtUmJU9N+L1Gmjamrq4HJJ99spCXFpz038Fd+Cd1OUH2LW3CQnXeklvBoZQw/Fu
	 4J8u2Bm32qdX5daoX6SjeIkqcupWiuHJyxFgYdObvD99Yc2pb6fbHZbLrbcxFm9D/WeNH
	 7G1tYz11AhhsErXDaKFzYOt7EhVHImgs6P9bxb6nJKp1DsfuhdBLUZNe/R0QrNSfhfZuo
	 60zhGKW7fiGMJ6lCZEWChUnZbtXDF+8fH6zywhO4XP/DITF2cIF1p01OwawzRPzBolg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=HXSN4Aab;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E19606A33E
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 19:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E19606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=HXSN4Aab
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so412105466b.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 11:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794771340; x=1795376140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+9Eww07QSnuPfPdAGrAWpz3n8x4NlApyIViVNGE2Rs=;
        b=HXSN4AabSc0xFbzvP3lfjK3rXrzpQizGnweDKmW78qPo4LF3MLDWwN7erZKotV1GZS
         WPfaCjmK0Ijkkl+CtI2sZ/7tiuOzujdsIfgKzfSGnM+ksmsqCZTVApKVezMZZ7RIM7vv
         oBx2hC2ZgglhxWpdMrTdy/p7P/eYGmnlxJp7neuu/H/i/6lDYYfzPAfDq2ony1QimRuf
         uJuVdpS8ihHU+dqEXq92fbsDvvyVvSBTyoH886nzvz39gnp0+ppVgwVSLgJYoCqxEjG4
         A9uyMMOFntHqgZ2S9EQsFmu6xxqf6mR6m1r69iLRspoV2bZdMHeCD+0GNAtesU2u91pt
         dVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794771340; x=1795376140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j+9Eww07QSnuPfPdAGrAWpz3n8x4NlApyIViVNGE2Rs=;
        b=ASEJOsdyHy+qhSmqHiMEXEIioWQh6lzydkuUQZLUeBJFug5vs8/MhNNakPKDRUiRbs
         e/xlPaCu1P3Mhd+u8luo+GTUpHrtPTdGiU1j7pMysBq7xeTIAngGuVAiJoyvco+hGxGB
         Q5nYX9Un6HmvUIaZYOEoqBuPO/woaFB7nruOgEvZAhggNKrC6lZAXjBpSwpAoTWPk3hP
         32//O9FABLvjX1Wk+0puEsS/s6HYRkwAM5oaVFH9TE5rseCW4qhKA+69Ub5lBSpu6yEB
         qsTL8gSTkGELP5vggMQsbD76oM8BZVtegO24ZCOdOmJSWPRbjdTcaTni+qUnTe/Fj5La
         PkHA==
X-Forwarded-Encrypted: i=1; AL+hErHHqPft3IXMXjJdnJeOHY4ryMJMTnMx9lP3yVDfODEfrwrDfsg4WrY7YEC7wcNFL5p/Vzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KpoU9buH/hPibAtxlYSyY5cV/fMMJ8tL3dDv9j0ASkDzeHBhp
	gxfzE7gM8hdXDknYoiDzLhOfgvnZ+ez9kSq3x9cV8ug2GA6p+WZmv5GOjWpD8Ad+eDA=
X-Gm-Gg: AYBFou2Ii2/IUWE53xf+NZ8bkeeLGinESxnb+TbqtqakNfgXFA7nhqkCAat0+vPiRCh
	VqqbKDVzOchMZiwnae9rbo2C18bPDk8Sj2180vltqYT/GK92LswEpDpm5VLeKtXVgXxkBTYF+ks
	0LLPxI/fyqlXgsBtXcfpClmo9HDobFCpqsxNB4a1XMfi7izjX5n0b8WZeFh001hkV5xi4ni5clV
	pDbLW6s/lCUq7LbiJuprYpULYLTU2RwhPggFC69h5tgIdK9vl3qJ7IxEQ7Woo7wdtguJuQp3xM5
	+yCJ7xn/N5G7Mh7yXCQmmAc47MdKfScRT+STFCcVAMCDEAKpWKlCiXCr77WrfWl018OomqRp6TK
	TP3qJWpSHHZCog7n9spwJRc62rXhIIBsh+DXJY7wncbPECUHe8vH53dn/ueU+6DmzYn+0p/82hY
	G5ZRBSxSeg7dClXzriI8/5QBSf3cU9Ih2kSJSjGO6xr8vk4tfzefyHucuW3pmyipG+QiLfSegOV
	i27DNcPBnY7dJ6qtni4Rh5v1/K0Nvo6vDADFYZCHt7DFv7QaPaTkM+aFFC1XLr2HIG9ByicguJ0
	3awRwmp2zZs5AaOf2FWjKRyW+IBnMf6K+/azWiSGWRRA6/Dq/8YvX55ddg==
X-Received: by 2002:a17:907:2d1e:b0:c4d:28ba:f221 with SMTP id a640c23a62f3a-c50963d46dfmr689355666b.42.1794771340127;
        Sun, 15 Nov 2026 11:35:40 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b24b88sm340448766b.16.2026.11.15.11.35.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:35:39 -0800 (PST)
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
Subject: [PATCH net-next v3 2/5] veth: link RX queues to their NAPI instances
Date: Sun, 15 Nov 2026 19:35:28 +0000
Message-ID: <20261115193531.57679-3-tianyi@cloudflare.com>
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
index 3cbedb8bad53..470c4f95e4a1 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1064,6 +1064,8 @@ static int veth_napi_enable_range(struct net_device *dev, int start, int end)
 
 		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
 		napi_enable(&rq->xdp_napi);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX,
+				     &rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
 	}
 
@@ -1096,6 +1098,7 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		struct veth_rq *rq = &priv->rq[i];
 
 		rcu_assign_pointer(priv->rq[i].napi, NULL);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
 		napi_disable(&rq->xdp_napi);
 		rcu_assign_pointer(rq->xdp_prog, NULL);
 		__netif_napi_del(&rq->xdp_napi);
-- 
2.56.0

