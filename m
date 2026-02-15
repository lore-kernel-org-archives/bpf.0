Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E03054EE
	for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188244; cv=none; b=FX5TUD8OenffoI/6S4XrXBi8mCJ1txg/P5bz7FVeDSVfx2wzX41IWjVdLLwu/IAOItHjhbGh1d0rGS6YQr0o8WXpXK0j5QPUN8UNJNr3zK5ypiD/KH1mANgKWrEtttS5GTLIQbDOCiIGhFiUIzvgrkv8Sq6dJ0M4pnYPzpNozlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188244; c=relaxed/simple;
	bh=MkAF6NrOoDIjmjTurHR5Pb6sxyEpSSoVIdDhEBK0kcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nrZJxHSYlT7tVkKiHeFjZWntznk3z7OuxRPFeoQ0szLcq4c5JTWHkmGgqdebhQAZ4GAZq2KGEBjmQ4xLZuEg/zTBA7icNg9u8d1am1aEr36ZgzAlRwowz+nJc9lh1yLuPlaq7NqpYXi1VC77Jw41OHE70p7s/uSuGMoaZfexzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIwa8ccY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIwa8ccY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35842aa350fso6411579a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Feb 2026 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771188242; x=1771793042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BT5YOjf9XtzKKAlrK8bU47/cOZRZChjPVpJTvbg7E4=;
        b=OIwa8ccYDiV8LLp/sslakXCmy4rDoLLysoxqMzyZTJgFrPGhKgon9NXR8hdkQq/HVB
         zlKabaefdQSsv7Kz1vs84r1HBtueIAhkhBCyo8n/vzueUQyUBxHgQ80Kr5w+FTLqbYFe
         oCrY2Ow77mnwl001WuJywoturXSh68PpSRh1Pz2rC81c/Hr4fLoTAnI5tJnRDy+wNHqP
         da4QbexO+dLOAIsxttZWCv9/ubnTGsvheqdx0e0V3F7C/fybsXO6NK9uxLLFG7T2rsQh
         ki8M5zuJ6TGN653qamu40HWW0R5DOzUY+X3NVLKVI4Sm9cJXVvHIQ2a3jJHG6JqNbdzE
         Fp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188242; x=1771793042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BT5YOjf9XtzKKAlrK8bU47/cOZRZChjPVpJTvbg7E4=;
        b=EL96zl1S+KtMsSjv58Y0aboR/TfHQG7ThAGmONBwWV3lo3L4sq9giB+iVja0wSH/fX
         Ub+KlZbAtUV3LO0jmuOO8h94J6/MSpCg5UJGUweKXDeJ8BeT1v6YyGV6/iKnnvAyx6Pp
         88ui/QWwMsyxpmHnPz/8urmrarMBZD/Ojjffhi3LEGOKnocB2oYcN9h153bk8cvR3UQh
         2mIBDnqpuHxgdWMl6ynDGj8tByaXgAViSM9YR2HfpEL9NE53ilGCNzUkFYyGq5Pn+vrH
         kZGs8A79CJr9er1dMvCnwdECMrj2cWjhcweSEEch0om7cIniIPtjcaSoK9B7gDoEBQXr
         9pgw==
X-Forwarded-Encrypted: i=1; AJvYcCUBt/Qcd7Lx+A3JUHKspQezQAcQ/k5eeVZ3OuOSFtXLhakA6Exjkk6AuKj9Ka7A/rqzmpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkJD9Iz0lB8dE6jNLJs7ELowoOBIspYYWiQODgVOtRHdtTLSQ
	TVa+cb08HxdSdwVHvWrpwzmoKvMerFkFAYWZcpyPfvPVXUFRUs3gkKUDjH7TemoX973c/w2D6HC
	NM8CP/w==
X-Received: from pjbei12.prod.google.com ([2002:a17:90a:e54c:b0:340:bd8e:458f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5345:b0:354:a57c:65ec
 with SMTP id 98e67ed59e1d1-356a7a43faemr9852892a91.20.1771188242392; Sun, 15
 Feb 2026 12:44:02 -0800 (PST)
Date: Sun, 15 Feb 2026 20:41:39 +0000
In-Reply-To: <20260215204353.3645744-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215204353.3645744-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215204353.3645744-5-kuniyu@google.com>
Subject: [PATCH v1 bpf/net 4/6] sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
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

