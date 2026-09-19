Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AF35E956
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828751; cv=none; b=gnv2bjocCRDOlNK9ffrbXcPv5LEOgibnxCBFFzj9bb+5ueFLv5C3nfxpARXhk1E7VgWVo1OKIx7pelFH3F0SAb1Y1UyvHVVPgX9nD7L2gsxLgfjusUyrcuX3R8GZIMY5unogv8DjTJfDTEZyM96RmWgC/JEnC2qYFR0vjtF+Evc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828751; c=relaxed/simple;
	bh=hE1cVQyQt2OU6ibt8nyDkD4ZukailLQ60/Lsgbzd9KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJScVN0K8bO7G7CvJtjXu2PrQLSg/ukuAd5ffqnJsdFwXR+8gF1oM78jPEURbSs5uV+arKjodoZRAm6d3EdXulBEu3w4QQF9lIKVv3chHcgviG93h7UjCxIHCZS66kY/kdkxx+taU6B1o0LHcKy57cg/8VavDQ2IJ3huyRY0clw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7K+MwaF; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7K+MwaF"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so11592895ad.1
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828749; x=1790433549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xl99vzI4+2TnnI65ZZD8Z3YjYIk3m3LZhJLmHUA4G0M=;
        b=h7K+MwaFaxlRtmxd5+/AHQz3quQ9CjjtN3UJh6rBeDoc+U+6lE+/i1xwUC0sUSt6BA
         ljZl+rx1Jh3SkerTYD0llg32vj2g5vA1W6vkNypi0re8sQJMWFxlo1ooYX1YFcy7c20a
         Q41lLrimPT/RAU9jIgP13Ixry+QYPH0k3to7El7wutZMhouXS+SCJyxAigIenObKObLu
         3k+LLoBIjSLd4/QG3a8v0DCFtEtskgMthTg9Ry3sXjVqz95lPilNm8itY5OhjOV3PWim
         Ml5XD5so/6mr+ZF1v39EmQKGc4ZN0754csI7QIYWDydWQzIr4QZWZZzU3m8M90xD9z5c
         bFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828749; x=1790433549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xl99vzI4+2TnnI65ZZD8Z3YjYIk3m3LZhJLmHUA4G0M=;
        b=I21zAU0RBYExdRSgBs/LSmqvueTSsghFE87DuQHfG9mPeiS/gjRZmJbHkUDeRRJGWP
         LhnZvy3pfyeXQ0stixT+tLU1QEyhi7QFT2t0YvFDMUcokuFlDEEIVCSjSSs14h7imlHg
         riSkDyqTbHdbXoD4aFUX5g43H4vDHAcRHZcm7XGH4DiAWA9u8ifePO4HSiJIZVuRtjdC
         043dts1EwRRVFozdeiS33q+l5akbiNC7SG22oI8B0GdLH4zP2ZYGzjYkUffza9oeD2UV
         uVI4hACxsdwo444nSAx20FFIY0GpnuwqTfgOqoaV/+4qP2eqfKgr8wSqymdqxdZqogXA
         xD5w==
X-Forwarded-Encrypted: i=1; AKwUvBxGgy5F1WXyU6h+0pSNz3XD+Iw5pzv0dYI8N3/4s4ElY3hQxu8fbVscJJBQlwu7SUxP2s4=@vger.kernel.org
X-Gm-Message-State: AFuF++nVsRPYvn0zyhpR7yzmU/v8I6jNyoOzIsXVTKfD9ojZ8uH0a34p
	L6BIGZ+QP4V1vJtFgolT/Iuj9DF7UseUaikSAAAHuZ60XJV2KX4spZWh
X-Gm-Gg: AYBFou1n48Tp543fFE63LDGTPgO5b+ttf7fSdu7THUXTPp+iHgwAs7Be89UrA7ecrFO
	CYabcdEbBOjaBJGGLojwpUsBucDjZ6zWf2B6k7BFrfcyfjDK/c4fhfCFOvKBcxPZ/vx4iuCoICT
	WVU3La5zpVoKoeUf7TYsAv1SJi6Bxofv07teAJEmANgu4xqh88Ptu1W+O7ckhYjwbhXgiLJ/gin
	ozF8nSPZck8ARAAgzqp6kgJG3SVssUzQBQUL8E/th33vU8l4kLl666Agu6Olwc+ngjiwSn51Yme
	is79MIBYSdTFm4IDWR0Thi8UWiw/2ReRqyT6lVmm0R4LRo8YOOZFUKUbRQrco5J0JvNMEL40Lsd
	5YS9R55IiaZhuDJfbLHRyNHnVQmWukdQu4xrxDkYwSq0z5xVSLYnLHi+RGxZo2ADGkdpS1tl98I
	wTnxnX9mxnaDLp+UJMWjqU7L3L+CcnIFNNFcz8rFVg8Nu9sZRp3y2Zys07VIueaMtcGYL3wz0Gr
	9cNt7HNhf70T84Q9a5nNGbRmsWpGx/zVYVRWJcOE2KlXL06WpLYvFMUwRONca8/lzKcnI0mDlpW
	DP3OQ7AZ2eCjY6R0bAPJTM58Ivn7qZHUw+CQ2i8ISFJL0a8VjxHVibPxVMYaG8PXf+GCMA==
X-Received: by 2002:a17:902:ce0c:b0:2dd:ad73:c989 with SMTP id d9443c01a7336-2ddb1bc360emr93215125ad.33.1789828749395;
        Sat, 19 Sep 2026 07:39:09 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:08 -0700 (PDT)
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
Subject: [PATCH RFC net-next 6/9] bpf-timestamping: restore skb hwtstamp if it is used by start time
Date: Sat, 19 Sep 2026 22:37:29 +0800
Message-Id: <20260919143732.11772-7-kerneljasonxing@gmail.com>
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

When BPF Timestamping V1 (SKBTX_BPF) and V2 are both active,
skb_tstamp_tx_report_bpf_timestamping() writes the hardware
timestamp into orig_skb:

    *skb_hwtstamps(skb) = *hwtstamps;

Since orig_skb shares skb_shared_info with the retransmit-queue
original via skb_clone(), this clobbers V2's start_time on the
retransmit-queue skb.

Save start_time before the write and restore it after the V1 callback
returns, so both timestamping generations can coexist.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 44aeea713da7..98cd813006b8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5686,6 +5686,7 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 						  struct sock *sk,
 						  int tstype)
 {
+	ktime_t start = 0;
 	int op;
 
 	switch (tstype) {
@@ -5695,6 +5696,8 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SND:
 		if (hwtstamps) {
 			op = BPF_SOCK_OPS_TSTAMP_SND_HW_CB;
+			if (static_branch_unlikely(&bpfts_v2_needed_key))
+				start = skb_hwtstamps(skb)->start_time;
 			*skb_hwtstamps(skb) = *hwtstamps;
 		} else {
 			op = BPF_SOCK_OPS_TSTAMP_SND_SW_CB;
@@ -5708,6 +5711,8 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	}
 
 	bpf_skops_tx_timestamping(sk, skb, op);
+	if (static_branch_unlikely(&bpfts_v2_needed_key) && start)
+		skb_hwtstamps(skb)->start_time = start;
 }
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
-- 
2.43.7

