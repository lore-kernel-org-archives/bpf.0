Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438154;
	b=QPrgCG251q7XR8/4ojV0pnlCWCqdlaMOyfje722eKmp3v7+VGARYpL46NzNCAuv5NDT8
	 mC0RN6nh2QyHU0ZWXJu7KO/FYt9p+BCKadXChXaDxAYPIfo6c31RkBDa1tfrLGU/dFNSw
	 FB3XnzMjLJI0oXs3tRNRKzCnXe4YcpJgjP5T5PlkXnfn0kgwiXE0CBGB/Y0hnirNmN3DG
	 pR2uMemRvQE50vPxVruZJVdpizqGcsPOotjmAN/QmBvv8ibSa+9oFuaZmv+fTRIaS71md
	 DirDdU3Sl2tSCjbDYpgmR3/ZCJyrsqjm5OXFpwTPFXH/eUEkadRyEAPJeOQBgvY95OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1Hgxzjm1uOtQ/P84+Doh9X7srtoVpZDOxSxaVIw14Og=;
	b=yjC7BCosC416rAAH9Ey2DAtm4diSMOs3qdz8YCCnp1GMcGRoOBqxg++4cysgAahDI019
	 5UEp7elr4ikXPqdXen9EfgdDM+2zz4Idap/jl9Cyj0uEVAcYDrRNmBrDxbCzHfy83EkFV
	 0XQ2oixnvnPg+qml9Px5bQYvX0VagE0dWU1ru0IpmDzDRY3Q6QhEI0Dh0V3tjd8atqp8F
	 8Ocf7/C2CIEzbc0ASLyRn2R8EwHqiGPHvOYqGbj7pAoFyVZH5Kvc8S9VLKXLUs1XrvWh0
	 gmDyOYBMLgYoPzCpoyR0rxMokRBVus+DaCHasR0CJCmX7iTSFxZhpxSskv4wTtC782g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Blr6YDc4;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66928606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66928606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Blr6YDc4
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so27219265e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438153; x=1796042953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Hgxzjm1uOtQ/P84+Doh9X7srtoVpZDOxSxaVIw14Og=;
        b=Blr6YDc4vUL2o+spSlBE+pYyjG2ZjWv9xgd0PQoVlnES+BzT623KzqNPkROOuR0YcJ
         Tahd7EeqVO+5sbT5DkHX3SWQ9zAu/qneIEPiCS/gtpVsnjgve/E9Y1wBmgi0NiZcIgQY
         1QZXQfwHkhRbWjHUga1fkoZlyR5OgTBqzJnySDDOlg94QoSWChRcuNQ0wNFwxs9XbRpm
         oyL1z8YvgYaayd97V6vHl1nZxwOjovyIqrGqSElAzpCaZGFnx8U+GdwbcoDXCL1kjcaq
         zDGRM97RI0LiQRMmZgi8h/rf/1JxoDnU46C/ZhUMGf7nOaVPcmVHIHQB8g9V3Ss6frSV
         VSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438153; x=1796042953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Hgxzjm1uOtQ/P84+Doh9X7srtoVpZDOxSxaVIw14Og=;
        b=XFnQDy3BmxTFb71uy9hbLTC7JYfx5jZw9fDoU+laFD1TvdRYfMRKPhbBMFjjjCvF2G
         qps+47uUkZanMqS592TNVaRn7dYAcgWixNfDypuvwB6m/KQvXbekjIbRJLK8jfaEBRJ0
         u3IMiQJj0KjNgvQbYLQ6KsBWcajkcJE8kF7/Po2hjRWK1lms6waYKJo72QLIv0qePPjK
         5zvHn3NWeHoq/2j/YX5t2JNFhWNU8kUks8PdyP6EOhCMYGDQtVit8dPB+FMdR4B/YuP/
         cCZqOQ06U5R5/3WWLso3o54iQrEr4ampyI4imer+1TfAow+gi0CHjKXSyAeyjApajct4
         1KGA==
X-Forwarded-Encrypted: i=1; AL+hErGPaI/I/CXYAyIVHQEfgHnQveY4ccjMDuAQDeeWhXm5/MJMsR0og9m/AXs0BRulLy2vR6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2bHBQQqL7XRbWNk4FWa33djfybyY4PkZp59L7d4jPEvrYjRBL
	wlO7Oyznh4FM6HaijgaBkqbBP0OGWtZs02k211HQY3ixgDS9vVrIlVJ+
X-Gm-Gg: AZFdTZfqQ3samHqg2yBIfRXX4DMA7c6chQB1uOAl1TIxjT905sRIRy8tAnrb0UrYE8Y
	aTJqGH3uAzMa+GWzKF/qCsKvV57kaZaGnxmWTgPYPUwHwqXthuuMd8gBPhhzaO/uY0qhdiLngSK
	2u6+NhkfNchbbDSxS/+V5dqQSPGapbDN9lXQ+CGY9qaaYs0RyVY8Go9F/0jt3wIYNquQvXu4P5B
	LIjuOpAF8KfqLK03T0qDRWhoQ1s2Yw0Itytz1tLrdhkLlmkRVSGYXObHilBzppXM5raQc8b5DP4
	J42AKGkSjN5nMf+zCuNo99xgfKJBgbeT5JDNHMIwp76J8hfhxjrDdw/d2xLU9r+FN5LDmT9ZRIA
	wbWHbH1qWOQ6XuMc0JCqGV+5zl9tsN26dvcNPll+a23UQ49cj/rAtYHoulmqGtheS4MfsYiYnC1
	+hpVpR3bHygRuK6+FtewLpnmtLyZpHdy3X01XxE9JYmIPxG5RQdmeFiIAc/g8jczEZN9sUH0+zZ
	jXQjiZ0yRmTOdkDmt0KGrP+KKPdAXix673m2Js9Ee9XexX22tb78wW9bCu8AtrH7H9dzpm53toY
	NVM1e/bF+CpcStjLiumr1AhGoYHpUrVfGNINsIA=
X-Received: by 2002:a05:600c:4504:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4bb888284d7mr242846645e9.31.1795438152673;
        Mon, 23 Nov 2026 04:49:12 -0800 (PST)
Received: from Philipp-PC ([91.227.186.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm165097045e9.5.2026.11.23.04.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:49:12 -0800 (PST)
From: Philipp Sudakas <filzador@gmail.com>
To: ronak.doshi@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	u9012063@gmail.com,
	Philipp Sudakas <filzador@gmail.com>
Subject: [PATCH net v2 3/5] vmxnet3: limit the XDP MTU to the rx head buffer size
Date: Mon, 23 Nov 2026 15:48:53 +0300
Message-ID: <20261123124855.1021-4-filzador@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261123124855.1021-1-filzador@gmail.com>
References: <20261123124855.1021-1-filzador@gmail.com>
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

With XDP, rx ring 0 head buffers are page_pool pages, but the length
given to the device is skb_buf_size, which vmxnet3_adjust_rx_ring_size()
caps at VMXNET3_MAX_SKB_BUF_SIZE (3072). VMXNET3_XDP_MAX_MTU only
accounts for the page size, about 3494 on x86_64 with 4K pages.

With an MTU between 3051 and VMXNET3_XDP_MAX_MTU, a full-sized frame
does not fit the head buffer and the device splits it over a head and
a body descriptor. Such completions take the skb path with a page in
rbi->skb, which crashes the guest; see the next patch for the details.

Cap VMXNET3_XDP_MAX_MTU at VMXNET3_MAX_SKB_BUF_SIZE -
VMXNET3_MAX_ETH_HDR_SIZE, so that up to that MTU skb_buf_size is
MTU + VMXNET3_MAX_ETH_HDR_SIZE and a frame of MTU plus Ethernet and
VLAN headers fits the head buffer.

The problem was found and analysed, and this patch drafted, with the
help of an AI coding assistant. It was reported by an automated review
of an earlier version of this series.

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Philipp Sudakas <filzador@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_xdp.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.h b/drivers/net/vmxnet3/vmxnet3_xdp.h
index f9d843e..6fd8a4e 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.h
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.h
@@ -20,8 +20,14 @@
 #define VMXNET3_XDP_RX_OFFSET	VMXNET3_XDP_HEADROOM
 #define VMXNET3_XDP_MAX_FRSIZE	(PAGE_SIZE - VMXNET3_XDP_HEADROOM - \
 				 VMXNET3_XDP_RX_TAILROOM)
-#define VMXNET3_XDP_MAX_MTU	(VMXNET3_XDP_MAX_FRSIZE - ETH_HLEN - \
-				 2 * VLAN_HLEN - ETH_FCS_LEN)
+/* A frame must also fit the rx head buffer, at most
+ * VMXNET3_MAX_SKB_BUF_SIZE bytes (see vmxnet3_adjust_rx_ring_size()).
+ */
+#define VMXNET3_XDP_MAX_MTU	min_t(unsigned int,			\
+				      VMXNET3_XDP_MAX_FRSIZE - ETH_HLEN -	\
+				      2 * VLAN_HLEN - ETH_FCS_LEN,		\
+				      VMXNET3_MAX_SKB_BUF_SIZE -		\
+				      VMXNET3_MAX_ETH_HDR_SIZE)
 
 int vmxnet3_xdp(struct net_device *netdev, struct netdev_bpf *bpf);
 int vmxnet3_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
-- 
2.47.3

