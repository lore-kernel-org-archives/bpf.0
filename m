Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E726E173
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315116; cv=none; b=qmOqMD/hR9pzRuXeLKo+szJseQobXKTEhtJL4ro8GrTp1hIO/F0WpUqyUTVELVDRIUruah6PZUDS2+uid2JPoB1++ep9udn2kYjwQA93zjR2Qohhb3Bw6XQRO7WeNBkNP/4sIfL+Dlg1VzPh1IR2x0Fxu8CR8ojlQVQfBweMzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315116; c=relaxed/simple;
	bh=M36wO1iLBeappZvKcrU5VE7BwVOSjSBPOxXAKwOBYy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZhkP6bKKQdvCMe4z2nzyYHPo7MF1oHiiPK7I7lPQwpcVVXUm96CNtex28HhXYGboUKTA6mjzChfIYaN5K/h/Zg9CrrYGU8pUAAzHuN09RYa18tVJkUQCMUzVp+UGG4cXjxW2q/4he8kgL5nyYwvF3hsbADGJOnWueHPto0AaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHyply/w; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHyply/w"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c76e702e01aso63759a12.3
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315115; x=1775919915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SqmaZWSq0c/sFy4TW4UeB/Dws2Pj4gNfU8a5P2DD2w=;
        b=MHyply/wsr39x12rJle6UeJrlFibm7c1vyhFPHLAF8tZbYhntfaDcwF15mbB1e7Ebp
         6EVQtXjW7hK/n4bTIlggfJOfXkgytb5FkF38HA+grjie37Zpnk9VRCMu65rJHs7ZAN2p
         5PRcJUuus0phqiOep0DF/RbBcQBxb2HP6sCKRMlPq5e5WG0tHTNjqq4WRaaCQ6X80oQF
         JyTOHYaQWbduHhqXqaKTQHJcmvqUot1OnpRbQM0vqWg+zEC9UmsXYU0heaLRBqoTgT82
         A4dBy1pUui5DOwMQvrSpKgZ0FVWrUtnYjZKYb2Wj/rbA8D8anXSOXz+0qhrCNN38WMb8
         VcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315115; x=1775919915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SqmaZWSq0c/sFy4TW4UeB/Dws2Pj4gNfU8a5P2DD2w=;
        b=fpLtsV4u/WLjAN0s+McmaX9z4GVMvymDy3g1PHK9Xi/gkmaZCAPqodjCBVyXNvjjPJ
         RxHfVtYepUagYF0/RSd84l/jOrtRVEBEmGvao1SHmSeRpp701Ky18IjkKwLOxGGojS5e
         AOIlga8XYCjVodAz2wqyDWPett1WFmt2ku/UklxkSHO7JxGDSmQXE43dRNIBcb1yvEGe
         GVYHqknQDmEmJ4as9jzdRvhwz3i2/pozd/BRdCg+E6L9NrqKGaEJcN/vPScta2rLjNuq
         6bWY8DHGR71O27nTPFUNWIdP1F9YlrD1/9KB4YVUQLXYRpCaX8POH3QlUI8U9WB64jeD
         xXKA==
X-Forwarded-Encrypted: i=1; AJvYcCWOvbVJvWYXRwa2vCRKDU4ATWeQ2z417Wn2pKsTokKFYj5xLjsiL4+0S33ovaFuBxnf6YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZJU1lhdODrDCgQFcTpVjySsE4dPP7YrtL2QgOVCOLCuo2ZsF
	00O1dduBeSlgZpVWFfneYt19hk9B9scWEo95uyNX2LfVmWvbQ6414M7n
X-Gm-Gg: AeBDieupQk6jSgrFF3swqzaCLx3wMyceA5rIcghhbWlO3ELD3KUJUMItbYg4X+CqcNE
	0qChxL1YECspBAqByacBhSWL4HegpZRz/wQdWT3/CtLFSBFoAwo7k7U9W+xLLo+lwUL6uRNaM8F
	UodJyJTzcpKPDjjV1J4zjvk8znyb9UQZWjo6th0iTkAUaz7C0Q5DEkXb18HNE0T1Hcq+JdGLxJo
	EdmOPt8FUMl3sbS7ffs/s0Yd9rJn3pFvWIOSfG+j4jorAm8PQd9h1XOL/RX8K2VAQlNpjFAsCdj
	AOw3EfFwUHxfSqKjyeSYjuOJPYsrQB6B6MGBkRRCvrZ/EwGg49AP2C8nwqTfLViSZa9g+cX3BxA
	wLVXgTYDJswDlV0NZTNqd2oS01nuVWKT39KacYrKGGRk/urSjK5m+GYBzkbO6Bj754laLsrE0oV
	ug5OCRzgHPCHrGCSFt8sew0xUmq08dlqB5TeYbukhqWUQgEXUQ7452SW9Myj8=
X-Received: by 2002:a05:6a20:2448:b0:39f:2c96:e0cf with SMTP id adf61e73a8af0-39f2f0b2d05mr6892022637.18.1775315114591;
        Sat, 04 Apr 2026 08:05:14 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:13 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when wait_for_space occurs
Date: Sat,  4 Apr 2026 23:04:51 +0800
Message-Id: <20260404150452.83904-4-kerneljasonxing@gmail.com>
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

The patch is the 1/2 part of push-level granularity feature.

Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
though it might not carry the last byte of the sendmsg.

Prior to the patch, BPF timestamping cannot cover this case:
The following steps reproduce this:
1) skb A is the current last skb before entering wait_for_space process
2) tcp_push() pushes A without any tag
3) A is transmitted from TCP to driver without putting any skb carrying
   timestamps in the error queue, like SCHED, DRV/HARDWARE.
4) sk_stream_wait_memory() sleeps for a while and then returns with an
   error code. Note that the socket lock is released.
5) skb A finally gets acked and removed from the rtx queue.
6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto)
   'do_error' label and then 'out' label.
7) at this moment, skb A turns out to be the last one in this send
   syscall, and miss the following tcp_bpf_tx_timestamp() opportunity
   before the final tcp_push()
8) BPF script fails to see any timestamps this time

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c603b90057f6..7d030a11d004 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 wait_for_space:
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		tcp_remove_empty_skb(sk);
-		if (copied)
+		if (copied) {
+			tcp_bpf_tx_timestamp(sk);
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
 				 TCP_NAGLE_PUSH, size_goal);
+		}
 
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err != 0)
-- 
2.41.3

