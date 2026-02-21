Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C536307AF4
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716770; cv=none; b=cPTYK5hNIunTCUEu8mUmYiAIEeCwFvGrMXqO0sesPjiTumWd9ohGLESgd+UVB2LREgKsQxESb8yQQj5aNVDpm9MyGjfAbgg9eck7RdfxmqlFyQ9/LYz0t3MJ2+hHcyyt2Gss+BE8ehCwh1GvFgw4A9yZCKRROeE72v7+G9o3nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716770; c=relaxed/simple;
	bh=5qIeLn0udmUQ0lAH7ymvh4bwzedo3+XdQggsGBEBQeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iz6GhUQEdkaN8VxqEh9sa6jUugLyfZ1QtAnDo7CxXVbOx7jBGJrhSMBPI1qkV7m2fckxy5XMemZNE4U23PMS3Zw/AiNRoQ+fnVcyHM2rB0o4iTnjOhBaLd+pAx3hyGvR0UGIfUit/9Mytqw4g3Xiw+gZnvVeoh2LraTdbG3N3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdyrYand; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdyrYand"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so3266634a91.0
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 15:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716766; x=1772321566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRZJLtlywpr8r14Jsy3Lpf4GPuEEfot66fEIP/mfghw=;
        b=NdyrYandaoDBcBdreAM+tl+s+0egVZ+FNp7LW3OF6u0Y2cQBsLBgdjyaPIU+4YLBOw
         SW5t+11osgGcopFPuB8YsPZe0e8JCVO08Fen8AMTPtciLtw4YWwqC/qcFyhJQyzBUDFq
         Gz5/6aQtdSwwEutPF/HUpWwggJCyVWq/V5UT6yuEgkG679BvLahUFPQ9H7vxzthTMCZG
         fBOe7W8oT43RFjTXBzfyadxPtD+2QWh9fld2+OmMkTrgkFc1yoiCBetqJI+YL214IIEr
         hlGjum+yHQKJG91mti6Kg1cF3M11ESliI8Tlx8hHgZnkzR+ZR+yqjSMM7qV+diBE1u2v
         cB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716766; x=1772321566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRZJLtlywpr8r14Jsy3Lpf4GPuEEfot66fEIP/mfghw=;
        b=siX/ExNafUbTD+8Mee2/9bDH06rB3+ObI3vLTxiek0BnfTlSBkdc3QJBfVPuIpLOpR
         uuzJouxOFWBoM9XxSJun+7dYZQ6A7UPk8t5ALr1KYf9fpeiU0gng+5ik1wFKAC1TMUDt
         Wmvtuad2GyCtpZXMqJVu15Yu4YLXsb5rXsIPDDBLuz2oIZ4yQExMa5LUIPd5zDSeRF4X
         1doxf1Tql6ltsPvSeicn4B861W0ktK5aLizmD0aKQHnS5r6c/czQurSVEse609/PnJac
         /NqUugQdf1BSxRBqpv2w9fqVY4ThCV9fzRvgTvQnpWXwBW5C50UdVMg3dRH7mn1FPThn
         44MA==
X-Forwarded-Encrypted: i=1; AJvYcCVIZ+ZWW5eb4oc51L0cMNrIN5iL36GXBf1ELBrslzEGTJolIz1Y8D3jWrTtYjZXXUT4QmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNmIPKCmYNNi2dZcSdsn9i72EfuANrErICO78OLqmycu7D1QR
	ivK6kF2SfJEKQa8AIdGD07zZ0ProqVDQFcu449dZu3Q8BQQ5abxYIMZnX2+r1baP70d0TN80p9I
	VYGn0sQ==
X-Received: from pjm13.prod.google.com ([2002:a17:90b:2fcd:b0:354:bde2:b529])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5112:b0:356:2eac:b649
 with SMTP id 98e67ed59e1d1-358ae7bc5efmr3691684a91.7.1771716765435; Sat, 21
 Feb 2026 15:32:45 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:52 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-6-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SOCKMAP memory accounting for UDP is broken, and
sk_psock_skb_ingress_self() should not be used for UDP.

Let's consolidate sk_psock_skb_ingress_self() to
sk_psock_skb_ingress() so we can centralise the fix.

Note that now sk_psock_skb_ingress() always use GFP_KERNEL
if called from sk_psock_backlog().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4: Fix memory accounting condition from (skb->sk != sk) to
    (skb->sk != sk && take_ref), the cause of selftest failure
v2: Keep msg->sk assignment
---
 net/core/skmsg.c | 62 +++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6b1fef6ef85b..96f43e0dbb17 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -572,32 +572,30 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	return copied;
 }
 
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
-
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len)
+				u32 off, u32 len, bool take_ref)
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
-	msg = alloc_sk_msg(GFP_KERNEL);
+	msg = alloc_sk_msg(take_ref ? GFP_KERNEL : GFP_ATOMIC);
 	if (!msg)
 		goto out;
 
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		goto free;
+	if (skb->sk != sk && take_ref) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+			goto free;
 
-	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		goto free;
+		if (!sk_rmem_schedule(sk, skb, skb->truesize))
+			goto free;
+	} else {
+		/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+		 * data originates from the socket's own protocol stack. No need to
+		 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+		 */
+		msg->sk = sk;
+	}
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -606,7 +604,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
@@ -616,32 +614,6 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
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
@@ -651,7 +623,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	return sk_psock_skb_ingress(psock, skb, off, len, true);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1058,7 +1030,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress(psock, skb, off, len, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.53.0.371.g1d285c8824-goog

