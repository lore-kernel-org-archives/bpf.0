Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12043302753
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828759; cv=none; b=GniRIVHUlymQidSusQSIpo+LwDcdgaaF9SYqZ6c+5k+Rj/3tQ1QylpZfwFV/ny5H0oNkcMMb4K+DLFCxB4HBwtRzSYwA1ViJQFKxKKiDiIrt0cGK5x722xf4hoJ5e7ryqMhPJIuawDeXxg6r5K70fBc95jDKZPRL8OCQ5KD35ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828759; c=relaxed/simple;
	bh=naG+qCm4aL4Co4wX5TKuMtkEpbyD0CYMqG/MX1lqCAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTT7FHmmasx2oVv9NIdwqwId5D2U1p99/JJGOEmhkQAOtaQ9ujfUb++vrZzS9jPGWowpTgBiwX4ARReYTp+rFgGK9TQAL5SdGTvLyiOxFgJlSf0hXnCQoxe/aU6IlMkwGGCdXgpI3SF0iGpbSwlIv8szKDfEJY/lMFuIaw2aEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3oBQs/Z; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3oBQs/Z"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso18905355ad.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828757; x=1790433557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rdAbXda/9ru6Bxjh2LNSXFTGdNt0WNWjUFKXe9QRUEg=;
        b=p3oBQs/ZyGpqV+qlu5TpcjIgFVgA+RJdfZGbRo3Bv/fu7kEed/OTF8hBuvsxsDXAfV
         mQryEGQ6d7P3cOCQqhICnUZDbfjAgAk70gSvsC/KgR5fdj33pjZjgXD0hRhPlQ2u4Nlk
         AWN2NSobNcGRZ4XQ/6vHYqqr4wH81s1oW58vF4zgHKZVD/vhsWYaxZjooSP2OAMoFiOL
         Vea4bfwUdtMmpf6J9vDpnonwAzXhbo8sESsa4CMwHGErVQAEfqek4fsAJ8H9kiMGtrhy
         hDOC5eFgxqgEM3C2CYveBxSi246zU3/yO9YAEssRKJ75JfOSrcuL82dGfPbutWenRQXn
         RO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828757; x=1790433557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rdAbXda/9ru6Bxjh2LNSXFTGdNt0WNWjUFKXe9QRUEg=;
        b=fdnzCc3Gnv2Kf3biyiUO6yIfKFZCbe2zN1Q3e2KUShSLjtWLfgJ56h4JeHDQsuKt1w
         1VFkpUDEGOeLUKvQEDZzTc4rUuWNENLFuqTzgbsCz+6CxGT1tmVK2Y8b+86mwSGvY5Gs
         kUtAcX58k42XMc/AXHCS3OHS1PayrUFlbFiCcQcfUHZ6nwPpjkzJSB8FzrTGIwQwxy9o
         aaDjpPT3/Ynqv+Dk2ZU23XKtj0WgDUfFQEYe1ZHzYk9OTYMMjVZ7xt1/NTQYD92o+GSO
         ZjN7kmCH/Hvlfq8FU9iFWc1KjgDQRHpAfCRPgOdtZZYiV/mayUccVOXtNs/3HgVSop/u
         kW6w==
X-Forwarded-Encrypted: i=1; AKwUvBxQMifs4mMkG8d5h8ZtI0ERfWIc4xY4C8mTp4Y0n5hzTTt6bsjt6nAvoImahzIIRUu9ThU=@vger.kernel.org
X-Gm-Message-State: AFuF++mzh/7h6e322xBfHiJGp93VSs+9gZR8VU/4Q0ZZhcIftfQwOmjA
	aLtjp8HXyS4IazMdwW6zsS+ooIA6zZTUUWXOPJNuK4gJHTm3Z4mvR3Y3
X-Gm-Gg: AYBFou0E50am3s5WCITq2dw0MNRaf01Wa+iU7iRx0Mdr/7kklDLHHYbE0dxDL75LAN0
	OmdI55YRk7QiCfUbxo9fX7oUdXtsbdD1SC2bXktQS9RUbcWWziYkH++kAaB00/xoFPJnnnGNn+r
	v7ee+O0+LGoJ/YuVeHK70zJsvbQXeqNosA9aFYR1fYCBskLregaraqpb/NSv633Dz+QOt51VvTq
	WfvsuXXpHk6WCCw+aEi6EEsyf+y0fQfzZNWU27R/7BZFwRDQj6sF5c2YV2DQPCesCnU4BqFoQCu
	D6I0+1MfO9K4eUAzc4lDw5dieEVy1waCFkwMjV6YWcgrbZ1Ahow/A0FFRRcfHHdCHOIJXdjNV14
	c3zDVEZrD6LmrRz2pYOE4OPyXT4K6ehG+RZPSIrGged3lkPw9EZBRoQ4a+pbc1LYbJ3xfSn1OT/
	ykeyv1F7ttJ+KQMUnYQhdg6xdLQp/233Qw5sYQ1UFl5t3KfJbJJEvDh/jQ4ZCsdKtZIa/IMJOCi
	RxLSDHl0f7nSJ/JX+3Tcv00a9+j6C2LA1KUKq53SRxbBGRl2flBFX8hZ6Ne/4M/RZtWLclLBFmi
	PaALv53+ctYaFuCRetEAjsDB1GJzivjZApX/MKDzS4J70973maSNHm1zUPY=
X-Received: by 2002:a17:903:19cc:b0:2dd:c054:197c with SMTP id d9443c01a7336-2ddc0541cb6mr42713955ad.33.1789828757348;
        Sat, 19 Sep 2026 07:39:17 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:15 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 8/9] net: generate the start time for every skb in the rx path
Date: Sat, 19 Sep 2026 22:37:31 +0800
Message-Id: <20260919143732.11772-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend net_timestamp_check(), so that it also records an in-kernel start
time in the skb's shared hwtstamps. This gives received skbs the same
start_time semantics that TCP already gives to transmitted skbs, letting
a BPF program compute how long an skb has spent in the stack.

In the receiving path, net_timestamp_check() will 1) reuse the hardware
timestamp because the hardware time always takes precedence, or 2) uses
skb->tstamp if any, or 3) generate a current timestamp.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/dev.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4479fc87b789..8a9d2205a884 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2501,11 +2501,17 @@ static inline void net_timestamp_set(struct sk_buff *skb)
 		skb->tstamp = ktime_get_real();
 }
 
-#define net_timestamp_check(COND, SKB)				\
-	if (static_branch_unlikely(&netstamp_needed_key)) {	\
-		if ((COND) && !(SKB)->tstamp)			\
-			(SKB)->tstamp = ktime_get_real();	\
-	}							\
+#define net_timestamp_check(COND, SKB)					\
+	if (static_branch_unlikely(&netstamp_needed_key) ||		\
+	    static_branch_unlikely(&bpfts_v2_needed_key)) {		\
+		if (static_branch_unlikely(&netstamp_needed_key) &&	\
+		    (COND) && !(SKB)->tstamp)				\
+			(SKB)->tstamp = ktime_get_real();		\
+		if (static_branch_unlikely(&bpfts_v2_needed_key) &&	\
+		    !skb_hwtstamps(SKB)->hwtstamp)			\
+			skb_hwtstamps(SKB)->start_time =		\
+				(SKB)->tstamp ?: ktime_get_real();	\
+	}								\
 
 bool is_skb_forwardable(const struct net_device *dev, const struct sk_buff *skb)
 {
-- 
2.43.7

