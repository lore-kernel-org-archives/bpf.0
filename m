Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0661A9FA0
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286833; cv=none; b=Nhu6KvCTxGjKcQCiKnU7GWefQnh5mR425tUOW7Yp4TCcMXGUG5eVbS99gLs+c676XiJjJpNJBn4gHWPWZMUISkvZeUA5lfX9aYOff2Tcd7B7bzqYX0/yKu7QA/CAQL93uTZ9MvPq5Q5B8CH5XSZzdViW7U6nzApQer+SEVhBC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286833; c=relaxed/simple;
	bh=MkAF6NrOoDIjmjTurHR5Pb6sxyEpSSoVIdDhEBK0kcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V4MujqHVR6ZQ9d1ZrbnUGBHNfMg1aPSSvzjw8JI691d/riSsv3uvKQS2h9TKCEwpenmLahf0ruJ8120gzMfM2xTVJNp95gn157xmEzftRChSHnda9gjCN0SXbraIgB9rbbUANB/YmElHPcZeN2dg6rY1mb4P9F/csvzbtOx3sBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xob2DPoZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xob2DPoZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad60525deso187113995ad.1
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 16:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286831; x=1771891631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BT5YOjf9XtzKKAlrK8bU47/cOZRZChjPVpJTvbg7E4=;
        b=xob2DPoZiBWVkC+DDxR/lAPrjKmE54iJfOw/P5IXkTuQx2mIJU4o5MrZfaL1xCfXza
         08NCc9CFRQlIFD94ODD3eKHYLE2D1NUtduR05JwGNlVadlCrTxDTep765godKs4I1YQ3
         DRaVPVxRICfQ6YOOjWd24tGyZ64aSRgJYJkTCy0+SG0HNdEMvAtMeUlyIi8gVB4ir9aQ
         rX4I7FXtQAK+CxC6IVsFh11i5hLE2j1puBD4PFlvg839WKv8+/zby/3nmrPYANjR/DzI
         0SdEwrBilYsOGKINH1khqF6On20cfRco5gMSiThQNfWywnspKLvbvnKPSlVgC1Y8yPx/
         zFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286831; x=1771891631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BT5YOjf9XtzKKAlrK8bU47/cOZRZChjPVpJTvbg7E4=;
        b=tyA3/qbrvXcq7w4dOPB0ddKTYLOyGneTvEy2cSr8A0qcmceWEpQfk64ppvO0pTh5Yx
         rJfy/fli8Nd/NHQG00SThgczjcBqAX+5iwMUV86oQtGq+dMf2yQ5OWErbhHIjHFNLoPe
         H9yGqTQHGUQidB43w05TV9Pg2VkxnEdYGHk2Zj39y66THGzC22yetp2up20JYmAwUeDg
         92n+XEgKbx7Sw97tShC4t+R1wdJFcyR4j7yLfeoZXudKagXLW3jDRA1u0gbGVl20Ceh1
         v09UAw5jVI8zFaTvYW+BQwb8FdVyi6Ou1du4WZp2BfrodrsVk5GpGufK2QtmcvrGtHX6
         m53g==
X-Forwarded-Encrypted: i=1; AJvYcCUB3+DUN75VbqmJF8fYXBVNfsoh1uS8WMrwMYWQo/Yqc2fOpRswwkgPmP8seos/982Jm3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLeXfh86pUiHRyprh7P5fq3twZPQ27L9OLVzQuX8X8KIohb5+
	blD/wwavOjeXz4Usj4smc2AUFYr8N9WdV7AQPOycUVa2ZJ3IWi7MeYL0D3l7DFWP0DWo1nKT4Ab
	S7+4jOA==
X-Received: from pllt10.prod.google.com ([2002:a17:902:dcca:b0:2a9:48e5:ca1b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124d:b0:2aa:d0ff:c3a3
 with SMTP id d9443c01a7336-2ab4d06d4e7mr124408385ad.47.1771286830552; Mon, 16
 Feb 2026 16:07:10 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:16 +0000
In-Reply-To: <20260217000701.791189-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217000701.791189-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-5-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 4/6] sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SOCKMAP memory accounting for UDP is broken for two reasons:

  1. sk->sk_forward_alloc must be changed under
     spin_lock_bh(&sk->sk_receive_queue.lock)

  2. sk_psock_skb_ingress_self() should not be used for UDP
     since UDP may reclaim sk->sk_forward_alloc partially
     before passing skb to sockmap, resulting in a negative
     sk->sk_forward_alloc

This is a prep commit to consolidate sk_psock_skb_ingress_self()
and centralise the fix to sk_psock_skb_ingress().

Let's pass gfp_t flag to sk_psock_skb_ingress() and inline
sk_psock_create_ingress_msg().

Note that now alloc_sk_msg() is called first.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/skmsg.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 3d7eb2f4ac98..57845b0d8a71 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -529,18 +529,6 @@ static struct sk_msg *alloc_sk_msg(gfp_t gfp)
 	return msg;
 }
 
-static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
-						  struct sk_buff *skb)
-{
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		return NULL;
-
-	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		return NULL;
-
-	return alloc_sk_msg(GFP_KERNEL);
-}
-
 static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 					u32 off, u32 len,
 					struct sk_psock *psock,
@@ -588,11 +576,11 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 				     u32 off, u32 len, bool take_ref);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len)
+				u32 off, u32 len, gfp_t gfp_flags)
 {
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
-	int err;
+	int err = -EAGAIN;
 
 	/* If we are receiving on the same sock skb->sk is already assigned,
 	 * skip memory accounting and owner transition seeing it already set
@@ -600,9 +588,16 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 */
 	if (unlikely(skb->sk == sk))
 		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
-	msg = sk_psock_create_ingress_msg(sk, skb);
+
+	msg = alloc_sk_msg(gfp_flags);
 	if (!msg)
-		return -EAGAIN;
+		goto out;
+
+	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+		goto free;
+
+	if (!sk_rmem_schedule(sk, skb, skb->truesize))
+		goto free;
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -613,8 +608,12 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
-		kfree(msg);
+		goto free;
+out:
 	return err;
+free:
+	kfree(msg);
+	goto out;
 }
 
 /* Puts an skb on the ingress queue of the socket already assigned to the
@@ -652,7 +651,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
-- 
2.53.0.310.g728cabbaf7-goog

