Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC326E173
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315107; cv=none; b=KcRcWN5K7wF5Zpfj1Y0EHCXFFJn+6qadEDcDqGNHi+o+mOkk2v8GW19ivpus21jBgG+zZtSXP0CGhv7AsAftX6zaOAtRvrVwJMuy0GYY2g2jORayOYj2HOQYFR0bKqTHAUQk9se0TyHdZoPEaP7BNzKUcTSyXMJljh9ZYM/wtv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315107; c=relaxed/simple;
	bh=ObziIMZJptMx5wFSI3BwWls1eWUIp1bWLKEkqSnRD1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCE/tz0THw/opKG0hRO2Im5LiZOmNKUUqWKLyJ/hkKSlxzDh0PwdSwOdQs4XnYSSx90+ZpdfmC/1xfmn+m8YLNcuLXisr/Nx4UsWYQ6I3wfG1hYCoRkFq06T63mXxXQwyOZeXoFIKC2QfoieEl/6FsOd0KAnFumK3cvd8Pttx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLGrpVTq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLGrpVTq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35c1d101355so1079816a91.1
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315106; x=1775919906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7ow+y9L/LhofY2oGoxcrOm0+fzcC/letzWATueLsqs=;
        b=FLGrpVTqmzCjI6iQntr8QytJAztCKBReyE/YmfzLImxWehx8q8YKVZf3La2FTA8RTe
         xYqvZsBI6uxv9Wz+KgdWKYEOKIM08xmUu/cXcyXOGh3eAuqhPtGN/MxXByLkkcKehYsg
         +sEe5hnVsIOB6XoQWlluxfBc+akXDntPypBJY0A7fQhUZSrHoCeDdrW8rsytHOOGAmEX
         0yYuGJsXXZmeUgUDy21yM9GT6p+K82DpPn5DB3D+rFNq7mQvSAuDoUFu9uCF0+VEPxcx
         oDcrvxcw8yMJTu00O4vgAB9zBA46ZXOlUOtPvjUfIBJRk0wPTalELRdB4eopAwqhSIsS
         ZOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315106; x=1775919906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7ow+y9L/LhofY2oGoxcrOm0+fzcC/letzWATueLsqs=;
        b=qTp7jojJfB//zWcS6gsao972nIU2TJ9mdgSRCSadCifUYYI4Gks+LwKigcRZO9RuFB
         vKtOELCp8dvk+XqWiHGGfKqlcCZSbxCtUwSKTBHf4E5sNIhqRDSaJOiWNFKEfpKUdIES
         7rDAIhIhIghGApMKqjtNvEvLT9tBjStBlcaeIaiqLNFlVLRxO7FBpQzvrS0ZtY7uzJyT
         QdJ7f7RLX5cqZIMz3qRIkpVQZmCMVXsYkcez9dkXKggspXY/ryQIECR34Pdmtnu4k7Yv
         t6RjrcwJ8AwGC3p8+ZPRWg/cCD55uqLo7KpePiNvGOvejKt8RBZZEvs+qh/deRvloru5
         f1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJlebVIqP9VjwjP+mtiSWwE8/4pO4+hqvp2UYGIB8CVtuEibpSpLlrQUXrgWbOduIpmxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfML+K0Vk2q+V11cTJplSopq9HBSoT14lGZBdrcmWPp2bqdyND
	8+j8DRnU9FKnjQgdVfIrdQlJ7riEhO76qQDRffsNkZ+x/3MB2IQTSFg+
X-Gm-Gg: AeBDieuCxdt2Pti2WNO3CXctJG86NYPIDgZe8v+hAzwMNWQFcvIa1IFQVzjjnwpeGoB
	AOgzMpWSAtjMcuwWLPHwkhjXiJ/nvgkY15BO3LJVnv6XpNLPWTI+M46QBHiD9Y7WgR4JJb3WWK7
	HOQmvfYmEi6vQmyoxXxzOKO+YGawZlW1K0HBTICDZUyS+B9HzVNmCc8ps9dRY8mMeoPG5kW711l
	I2rd4vX+3WY28YoUcNVIBahhH2q/w8DCioZasBSHW7HvLHMMPFgxZgUAdjgj6LxtAFoeF78ffPD
	/1NRvCMXSydjak197OCrgRzQeNS6vqhrSb41D29xU5+2oAezQ+TcZsxN3Em64v7eMLe/2nPqkSl
	JxZgn5Wmz0Wj5CsQb31JWqxV7RBhwLpfhf2fyQVuC82j+fcXdkZWq0rzZ8lGwd+yU55n+9tnNc/
	Y7zxrK/Y5iF+lcByWsTeMN9Uya8sYDPZWlxigJ21N1m98b12xdnrmQV4Pa8Ak=
X-Received: by 2002:a17:902:db0f:b0:2b2:4b6a:f3b8 with SMTP id d9443c01a7336-2b2818b4279mr71216535ad.29.1775315105726;
        Sat, 04 Apr 2026 08:05:05 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:05 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	martin.lau@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH net-next v2 1/4] tcp: separate BPF timestamping from tcp_tx_timestamp
Date: Sat,  4 Apr 2026 23:04:49 +0800
Message-Id: <20260404150452.83904-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260404150452.83904-1-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a tcp_bpf_tx_timestamp() inline function as a prep for the later
patches.

Put it under the restriction of CONFIG_CGROUP_BPF.

Add a SKBTX_BPF check to avoid duplicated call of SENDMSG_CB if the
skb was tagged before. If we've already tagged this skb, only update
its tskey. It prevents the tskey from using an old value after more
data are all written into one skb, which is compatible with socket
timestamping.

Note: I didn't add back the process of reading skb from rtx queue which
was introduced by commit 838eb9687691 ("tcp: tcp_tx_timestamp() must look
at the rtx queue") because in BPF timestamping scenario:
1) BPF_SOCK_OPS_TSTAMP_SENDMSG_CB is the starting point for each skb
   that needs record.
2) BPF script must correlate sendmsg and the skb in this phase first
   and then will be able to record the SCHED/DRV/ACK timestamps to
   construct the correct timeline.
   Please see how progs/net_timestamping.c works with map.
3) at this point, notify the BPF script is too late to take care of
   the timestamp in sendmsg in time.
In conclusion, that doesn't work for BPF timestamping.

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h | 20 ++++++++++++++++++++
 net/ipv4/tcp.c    |  5 +----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 565943c34b7e..6705205ff236 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2883,12 +2883,32 @@ static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 	skops->skb = skb;
 	skops->skb_data_end = skb->data + end_offset;
 }
+static inline void tcp_bpf_tx_timestamp(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS) ||
+	    !SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING))
+		return;
+
+	skb = tcp_write_queue_tail(sk);
+	if (!skb)
+		return;
+
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_BPF))
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
+	else
+		skb_shinfo(skb)->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+}
 #else
 static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 				      struct sk_buff *skb,
 				      unsigned int end_offset)
 {
 }
+static inline void tcp_bpf_tx_timestamp(struct sock *sk)
+{
+}
 #endif
 
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bd2c3c4587e1..169c3fff4f6d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -500,10 +500,6 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
-
-	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
-	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
-		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
 }
 
 /* @wake is one when sk_stream_write_space() calls us.
@@ -1417,6 +1413,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 out:
 	if (copied) {
 		tcp_tx_timestamp(sk, &sockc);
+		tcp_bpf_tx_timestamp(sk);
 		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
 	}
 out_nopush:
-- 
2.41.3

