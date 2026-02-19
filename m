Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB75350A22
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522690; cv=none; b=OvCUaV4muDZKLBqy7giCQcH1JnHlo1ZFj7Ce0N1QDaXUnLn7iU2yicBZslM19j4DfErznxypG9aey63BYhSoVNy+oXi6kbBatstWq/mrpYu6KFUaPboOSSLRIMfV5FC83iZHbBaD7wAIz766hhzs3r1tX4Smya9dbDKoUcXwlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522690; c=relaxed/simple;
	bh=hTOswAMXHTuN2JzLlryVh5QhkbQMDEvZecaju/nabc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HixLUZezoT3DgwmfFkVcfgRCekMpeCA5cShbqmKeZtw3RKLy3fX4Y88nC7uGaNeq9MU0+dY9m4qWYV7yDzRm+pj+65Tay7+tW6DXlO+FktjwG3bggLAlW89tz95Ywp0cxPIsa09+tU8E6VRpuZGuX5iVLLuSZ7ToKKFUHG9Jojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqqL7uTC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqqL7uTC"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ab4de9580dso92176845ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522687; x=1772127487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkxeSRNozphRkvDz8e4X2zTXkvoc+MBpE+qTf+2BUww=;
        b=kqqL7uTC6Z+7+DEj4mu1m0zgbAQw37/7e2zq+U3yTilhy69BUTy4xjeo1NgyeffP7u
         z4Qr+I/ccELdMCthKvhpVlHYPW3FpuY+m1y9OVR4rU6BHpA9gbT04dhFA6jCdx+o/5pk
         BBFdQknyo293GVdy/XMgsMWuU0pGhFsCR5g7bCpuQE+pLSUi3l8ApkaanrdPnCHAvWil
         2uofaui+/6jt73zSAeymyhzVH9xhlEN6Sz3imVVTlbtMdRx/M2MLsn2G8j+cJ5ekBMs9
         DW1U+vmtels/EJQAK7z6qQIyhPvAaX4GALgKJzvx43frJJ/rcda2l1/wOASVG7xdYxVK
         YpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522687; x=1772127487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkxeSRNozphRkvDz8e4X2zTXkvoc+MBpE+qTf+2BUww=;
        b=Cvzsw+eS1J2oAEbLnpDEpWgBjQWWyqfDLgtupQBQ4vTPrZjp91nmgioE2ZyK9pXNv1
         h5yxGGPxjF6ShKi38x/phSoLbFRNsc2vUeuregSzV0fUngyghi7qPHy2ThTLRJd98uB3
         9l0b6RBGxMkR5g06GNjse+UbGMtG1ECm3qHMum6nf2BM6z0S/XJjQaF/uz0IBXq1tL8z
         4PuKx5/VFPNOk6hw5/driXiJ7keiCDA9VDreBmADPc8pNL3jGjgvv/EBMSMUDefu2xbl
         hI+RJ0B7C/HemlsLdkZGjTK/fpONW2agnRbSUWnXpMKBVJGUMxuiKVKeWgRzgTDl/2Ks
         JxTw==
X-Forwarded-Encrypted: i=1; AJvYcCUzOJwj7/kUJkhSXV6WmMNpMLtHLTtdRDK20gKsAwfVJ0zA+wyX0ox3ntwnS2RJq57CE54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbnoSZ8ZNxSW5GUVaJ81y0yjrtUDsYkC6uJ+arc/ysCGJ/5+A
	NPMR3uVXXub6IafmKyq2E4Nr12hVbWCxOw7MJMpTdYzOBedCF8wbJhfRtaL3oi1UffSs+NpQL8x
	YVTglJA==
X-Received: from plev10.prod.google.com ([2002:a17:903:31ca:b0:2aa:d604:fb13])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f46:b0:2a9:6414:719c
 with SMTP id d9443c01a7336-2ad1746a592mr174430595ad.16.1771522687223; Thu, 19
 Feb 2026 09:38:07 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:28 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-6-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SOCKMAP memory accounting for UDP is broken, and
sk_psock_skb_ingress_self() should not be used for UDP.

Let's consolidate sk_psock_skb_ingress_self() to
sk_psock_skb_ingress() so we can centralise the fix.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Keep msg->sk assignment
---
 net/core/skmsg.c | 62 ++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 57845b0d8a71..6bf3c517dbd2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -572,32 +572,31 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	return copied;
 }
 
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
-
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len, gfp_t gfp_flags)
+				u32 off, u32 len, gfp_t gfp_flags, bool take_ref)
 {
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
 	int err = -EAGAIN;
 
-	/* If we are receiving on the same sock skb->sk is already assigned,
-	 * skip memory accounting and owner transition seeing it already set
-	 * correctly.
-	 */
-	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
-
 	msg = alloc_sk_msg(gfp_flags);
 	if (!msg)
 		goto out;
 
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		goto free;
+	if (skb->sk != sk) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+			goto free;
 
-	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		goto free;
+		if (!sk_rmem_schedule(sk, skb, skb->truesize))
+			goto free;
+	}
+
+	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+	 * data originates from the socket's own protocol stack. No need to
+	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+	 */
+	if (skb->sk == sk || !take_ref)
+		msg->sk = sk;
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -606,7 +605,8 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
+
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
@@ -616,32 +616,6 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	goto out;
 }
 
-/* Puts an skb on the ingress queue of the socket already assigned to the
- * skb. In this case we do not need to check memory limits or skb_set_owner_r
- * because the skb is already accounted for here.
- */
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref)
-{
-	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
-	struct sock *sk = psock->sk;
-	int err;
-
-	if (unlikely(!msg))
-		return -EAGAIN;
-	skb_set_owner_r(skb, sk);
-
-	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
-	 * data originates from the socket's own protocol stack. No need to
-	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
-	 */
-	msg->sk = sk;
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
-	if (err < 0)
-		kfree(msg);
-	return err;
-}
-
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
@@ -651,7 +625,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL);
+	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL, true);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1058,7 +1032,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress(psock, skb, off, len, GFP_ATOMIC, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.53.0.345.g96ddfc5eaa-goog

