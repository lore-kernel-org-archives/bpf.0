Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E063502A3
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522687; cv=none; b=MW8t2Uq7NYN354XTxYGavfB6ZHFLVLCZ6w7J78MQ8z7AXLOOCw9CSyyQHm/Xx5Cf3qUdsu+TjZIxsPhEkN5FWLRoU5rcy8YC9L0MzrRAFoZPz+c2+Sgc+DWieC1QbveRDxpacZ+9zErTjzQbjUfpPY16HboujA2wSjJAMPPw0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522687; c=relaxed/simple;
	bh=YrNSu/qk2Q0MBb/9sHDUNtgXzdLzHD/vjDuNbxue3cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpenROgJFIxCAdfMxYg9ImAQeRS74cR82i1qa+9mlnQ2ScnUOopF1iyMv8pqvJSVlg6VxcKyiD2IhW6jn5mDMuKahYmAECZ1lLjDZRAzBJqsbubaIAE7fF65GUwkShoymJ/o7F78BfsrQkvWA+VL3lJpetaNDfh5u64HvxRrehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEf5v9u2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEf5v9u2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad3380076so13272925ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522686; x=1772127486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOxsXg7G9eurQWLN7+TFPprvlYX5DCWquut4adI+7LM=;
        b=iEf5v9u2h9KZugr33QMWzFyG4CCzza4BJ7/20HF7z5uLcOgaZjf7yXB+B671zjzmyU
         MvEwxTKRSZJg4mR2uxkx2Oy/sNH56NRnUlSNQAvBdjK0OGycP86TTRAGJCb/7ANGlZ2q
         p4mSYnOtc1WT0reDJGB0zPb1KOURD4SijI6+3LcTDKSTtMTPW1/yubwGOorildnXWYIC
         W+L3SKhkcT02a5h+bOYJnyMr/2bv8vouKy9/ttZN5TxBGiIW9khz85RdBA5VEBJC3Us5
         PERgUjKyh9h3JS8hVSJKQBcyNw1oB+l6h4HNJbwK7MsLTmhFbFU2EEdb9fcvPSQqDXfL
         qjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522686; x=1772127486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOxsXg7G9eurQWLN7+TFPprvlYX5DCWquut4adI+7LM=;
        b=rh0I3VT3i9ghFfeC4+cWzFucOCPNIMVeZjmEmfLuOeD8bQgDLmyINYHOO/rFwVRm/B
         hczp8zBIaFtTdfvb5hob0mS87wlf5xwYvv59KZv3jjjrFJzayvn+PGeIHOcxzslgdGzi
         G92EhPFqjLQbbxpM2MYSzSN+S8CLd1yn3IBAoy4mglPjxrC5C4T6xRCOpxHca6PeLJ8D
         nKRic+4VdFl4JqyTo9at9H822McvRMpnLpeCwVqn/FZqqAgnQg1lp11eh+pZesFTsNV5
         UBKpFJmYosnsHzHpGOBy69ivIBuUdl9/ckeFLL0tZ+NKDSnn/KAqFmpDgk6yglVLh/OJ
         53Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV6MAHFidriFUWs88VuaXM+Y4RasEZfMmS0wd6uMbgpGlE74kmd5ZAiSRfUO7hCjp7ftpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydgu0SXPhV6SJgJIUf7080NnqLeEYkvRHjaTi9ksRj0xC58W/9
	mADDXLi7zjHsWoCAnaSjnUKaY5/WxTBKFEBOfRkmA7MrmfIaC9nzUmzbGgdbcZsIp2eWG4OwjSX
	HIgwSVQ==
X-Received: from plef4.prod.google.com ([2002:a17:902:f384:b0:298:1151:5f6d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec7:b0:2aa:e817:1bda
 with SMTP id d9443c01a7336-2ad5f94011fmr24398745ad.12.1771522685547; Thu, 19
 Feb 2026 09:38:05 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:27 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-5-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 4/6] sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
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
2.53.0.345.g96ddfc5eaa-goog

