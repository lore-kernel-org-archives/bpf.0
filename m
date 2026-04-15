Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C93CEBBF
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241659; cv=none; b=o0bm/cL+5dhDO4V6YVs/oU1T3MF7mTgovVtuwD78KHgB3EaYe/IQYbggRW9Vjp2BIiGFL8DnyTnQqMo2bhv6cbzComQXMNtUGHBEgfo4wTu4ShbstiFnxPzMd+7+WXBa5IcjZWrKbCIEVtWvwo8CiLpKe5bfUBvL1niwwWqxLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241659; c=relaxed/simple;
	bh=jHy49aFblnIvIRVscKFcvbhaJNd8YByECHZ/Ib4UU1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJEvzj6IFRHqyaKaSrYAkRWZMvELkyh7wTtQtOIn81bWesEZQXc+LeeIvWovTQHJc+H49XA/2v+BCra8RLr0WIKk0zRgkWNOfcEktrbUuEu3+gRe2kuYTYVlcE/Kf20SNyA+NnFZtCIi97ujShXxPTysIZOLUO7Xq/8EJQzDR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKkPxbGf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKkPxbGf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fede2acso38598055ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241658; x=1776846458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKGpUVJw2BsQmKke/zYlvHk6/z9E5V4zdWGX8V1hKW0=;
        b=MKkPxbGfjROhdxLqc3xjeR8Cj7PSWwRScLNd3YjPoXb3pubnDknLoC2xBLo4tjjUrU
         AHfafQRrZxD9laMqMzMRbkKZF0hY3Oou3qPG6dLhL+8c3t6Bv74Amnu8kMfdFGWrDkVu
         1OPLeDV9rklQZBVToFWHVxBmKTgb+uhSO1LJN1iZGP4C6iu6X8FkAwjNuTYvObM6wxiM
         /rQeqx4pGYas37N+DzBuLJnhJDlLFcViiYt5ML/4dsXKgNq7HQejjZEOzQ1PM0bX5t6u
         Rt5JK9GyBtwt4DcVhFXiWGjOXqjkKHU38s1GJfQEQq4CcLZfKJPA5gQIGMB7BPUCL3/4
         BnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241658; x=1776846458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKGpUVJw2BsQmKke/zYlvHk6/z9E5V4zdWGX8V1hKW0=;
        b=kwBvkb438aM47lOqpuMw/FUoWGq+X7iLj7eOE0/fw10XUCat8XCvqAv0qK1u/9J4PH
         ledGyEcZwG5jJsPLu9fwrFhc7U7qxX4o5/nty2dTFsyYlIFY6MoZ40ZdHVfMg/KomUhf
         hguL+TWv6SBpogzx6YMQ/loQbUw3MCnWrx115s2g2ITi/sJAebuO8KXbq0ZoMA0fMMLy
         ge3Jwg4Gw0I0Ztu7zByetwy2OM3GMldAzy9ZiLLtTuXu0GCuj9ZSeQLkXUQyqGas3/Gh
         I3SK0/9CWTS668Oko7KzFgS2qN6ZyHAgiztpkYYrP+k0id2VgZni92xFrCjLVqcGJwgV
         3c+A==
X-Gm-Message-State: AOJu0YyACegkkLWq2jpyVve11wrCVvApS8GqL+veB7fGxkyRrIYFuyVW
	hpk1iIuYnNR/oApqezEIyFHhPrXT0tvCSDEU3GajgGzbqXjABkigK/1m
X-Gm-Gg: AeBDiesxEMUpKu3FOXXAlzN8FarYrUvmCku86eL+KV2t3Ui4tYwKpKzZEBHwjtIhMk+
	8hCT4BL38tShB4VAYVMCojN50cj4VuyYmAA+OVyopfi9av8ZlUrpHRt7dM9LwV68jAlYXmPqjZk
	r5LzDl7RmRDaI+ESoweuTD52dNzxuCKTOryvKN0BhvV4d8ycvg+LEDy1BQmhsQe7KcZvkpbcyGW
	TdQ7mdQxIq+WN65ZOSLk1zzZeUI4lnHQVPqkF/9Bc/MBXiRbH2SN1q/eIzu37ZXSyJ3VBCLCv5K
	ncsRGilupDYwXQMnU1hMD5gaOzaAEfgTfUeohYJV390abcrWc4ZMt/VaDz0UbBvK79Z8cL2L7mh
	NymAxO4VjVUJNtjnapwMypgaqVHvDNMagWambYm1yChVrujqRyUZu2C3cW0eVL0mnRwghcEwwQf
	2L7Xu1rMXtuixp8Sqn1a5sqOfunkZlxAwUO4u1AR0GsKgso3f+aUQ074jl8yDzDWKZoS7H0NUVk
	LbzcaKx
X-Received: by 2002:a17:902:a506:b0:2b0:ba14:fc70 with SMTP id d9443c01a7336-2b2d5a8d6efmr152252535ad.42.1776241658285;
        Wed, 15 Apr 2026 01:27:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:37 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 06/14] xsk: support dynamic xmit.more control for batch xmit
Date: Wed, 15 Apr 2026 16:26:46 +0800
Message-Id: <20260415082654.21026-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only set xmit.more false for the last skb.

In theory, only making xmit.more false for the last packets to be
sent in each round can bring much benefit like avoid triggering too
many irqs.

Compared to the numbers for batch mode, a huge improvement (26%) can
be seen on i40e/ixgbe driver since the cost of triggering irqs is
expensive.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e33a2406d8ca..a6abd621a7f3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4901,6 +4901,7 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 	struct sk_buff_head *send_queue = &xs->batch.send_queue;
 	int ret = NETDEV_TX_BUSY;
 	struct sk_buff *skb;
+	bool more = true;
 
 	local_bh_disable();
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
@@ -4920,8 +4921,12 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 			__skb_queue_head(send_queue, skb);
 			break;
 		}
+
+		if (!skb_peek(send_queue))
+			more = false;
+
 		skb_set_queue_mapping(skb, queue_id);
-		ret = netdev_start_xmit(skb, dev, txq, false);
+		ret = netdev_start_xmit(skb, dev, txq, more);
 		if (ret != NETDEV_TX_OK) {
 			if (ret == NETDEV_TX_BUSY)
 				__skb_queue_head(send_queue, skb);
-- 
2.41.3

