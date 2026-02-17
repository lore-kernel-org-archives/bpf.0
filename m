Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00A1B87C0
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286837; cv=none; b=bNEkonM7/8RTPj70bVGWZsML1z7uKU3qlEjzJsl0yrgUmZG3s+yfBMW+0No2Nm1hW1kw4ChA7rpoY/wkJpToVUzq38lLx+lawc7otfilhUdLzLR//fJfSvrz+1poMQ/fWg0WBeNWz1LSSoZz3o+nops7d5tqiA41J8MkCBWS64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286837; c=relaxed/simple;
	bh=ZqoEGUwkgOjkNMykBkGRV+enmkZyBleyNoh/QI2Ii04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZUEdnodJ9TUIzNKW6ZTuAVQOKsxG0Of6bG3yAmYxULreU5p0j5458weMSMqWDrx4e6hFaircXSPBUhI/2TtX8mWDNvQmav2FhwSuUe5kNJbK35ULBXjiqXTVWQSOuHmOOYkKFPioAnUE01m1Iv1vl48r4gIqmUPZGPzc2xdFing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tROiPN+j; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tROiPN+j"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3545dbb7f14so3525274a91.0
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 16:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286832; x=1771891632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXkOpCMh8SxTrfC2IWENxO6f2nAwVIkrgIkGC463PV4=;
        b=tROiPN+jKFgbwtEFvaBfBT47Zv1VNuYJt1LhgN62ar3b1incN5f+I1oNYxo93lnaF9
         NziH6h2CVpbk5YylclWdbAtZ6oDtPguJkCIgE0kF02gnb09VUCxo2w3NQg8p6DbmkXFx
         I2Rf/OHSZWrKw/qkg2mvjR17fFnc4DC+61chlfYuCsan9wvSPBTf41plzubgnbxyUmmd
         sHwCRY59WLcTYXEfTQmTIHANvHzSqZHcElhBYad5/yBT7Md9C9Oc7+Zd0cdazeWeJ/eg
         JeporMy3UqpHHgDk9F7vnEnw6JNEdfNHLmMK2TFRXA93x2sgqVnLPRPWhRDqb/rcDiXc
         RpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286833; x=1771891633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXkOpCMh8SxTrfC2IWENxO6f2nAwVIkrgIkGC463PV4=;
        b=SAAqZwJDAp07ZuTZrYrfSlce0xItv7PMTKU3ZN/eJgZavtzr8sZlBjYndlGeNChMpV
         7dhlk9rE6XcBNiPybgkY2kT90DkdeVCcwp4yMfGUPKVV3P/PQTmqn1zUryP5aa4cf2C1
         +mdNrgjts+DeI7/tCoo7+43AnTV+4Y0kzv+LsyEwT+5e7K8mfoUYBq+p5LWaERgFMjfR
         OkTpk3lhUloznpbqoUFdXSIt5FWN5CAJEIBolz5RkwotjMlYH6Z6Go2mE5EFEHTtzFvI
         1LnocL8gOltJkgn+DBzCjJ+GecPTtVkjdU3pGkseWXJul3Cs7nhMnFIPxjhxlNvSOQ9h
         N/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0RYY3p2Ocwv1BI+/Bqu2jBSg184qzTztmW3CKypf18wDmmkYOphRaVfLVybDJEtRgIHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lWiNILrVDnKUn3CVlkAmFjnH0WJOcYtxk2KiUPESgWI5MEON
	7psfe8SmwtCdzzwnU0Z4xUdbuUgba6LsBseaeHwsut7eyEjhrpaccjkRCH8pY8rj34daaukNqJn
	DLnfBBQ==
X-Received: from pgbfe5.prod.google.com ([2002:a05:6a02:2885:b0:c61:3a0e:23ea])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1f:b0:341:d5f3:f1ac
 with SMTP id adf61e73a8af0-3946c8bf8b3mr10721048637.41.1771286832287; Mon, 16
 Feb 2026 16:07:12 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:17 +0000
In-Reply-To: <20260217000701.791189-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217000701.791189-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-6-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
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
2.53.0.310.g728cabbaf7-goog

