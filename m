Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C132ED21
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716765; cv=none; b=SLEeq97yVgE/Fc/iNJtgcCH0MeMR3BP+h4YpAe+M65YSwkhfoWVDWcysUeaNlDv/jOpMqYkBOMD67/aTur45X5tyNQhNmEceDRfAAsVrZxSIlzuKCyNSKUIoUqacKwVJc2wnp3Kjof0DvU6zmmqMtDtVezZfhNkDCvTJS0AtjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716765; c=relaxed/simple;
	bh=lbr0oz9VB2Qec0V22a2KHympkfWK71OquJ5rBqmDKTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g3aYPWd4RhfYV3uQh2TVUUvnj/yaNy+LaETHwEiF+i+6nzHcnL4O8piqA2TR78y+SXxGou0YvjhjG0ros/5VuF8T/FwGJxQDP3sOUuj+1T0h2lJXJhyYxPq6t2T3NBnOkfOskzoK9ExkxKM5DdvZMY4CCmkmRd81aWKm/X3s0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kh9szXvb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kh9szXvb"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35626b11c51so2651736a91.1
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 15:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716764; x=1772321564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJLW7oIznD/TEG27ZVpx0y0TCWyIGsFNIEuzZagdUw8=;
        b=Kh9szXvbKAS2yM9KDJNVWiG+OVubkmt7AAFUR9uqPrD05PqpvSUIIqMoFvhXvl5fno
         0W/iWff+TYHwclLPx5Th8JfMYnYT9cu++1nam3SQ8PBP/AH/fX2MrjoA2KkQPjBHSFxV
         rpHddM8k0DIQrYIQZF8NzYtbpvcCK+w+RUeuzRADQ75RycXILG8IDjXVEMjTWfJE/vbr
         FRIQ02cWntH2yCZFrKju7/uyrz9yDvPi6RZkQ0h4xtS6USP+XFEU3vn+PnamJitXPZfv
         FCWWWdKSWux8L3bbONyiOz60IExwGKD7FwHygjOpnJLkLY7iitH1f43U7dihX6LCBFJ7
         +0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716764; x=1772321564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJLW7oIznD/TEG27ZVpx0y0TCWyIGsFNIEuzZagdUw8=;
        b=aoHS8oJ6/qHI0nCixrTqQJM6Ndplk6H1b6AvGAuYa70LH18OgaA5APeG7TnWkREtTd
         3/goYniUoKP12rtu1IITYcUbQrX4TbJYly1cLtJiL4rF74mwXGO+Xf5nCoga2dqbWmzo
         qg3RjpNlFrFEiXP4RUK7CHnJAWpE8H95VDgUWKKSHL4mBCUpwJkyPLDMSPYVC/FZ6fgV
         UZKBZuHHTFXaYtgoQeHNJl/0cn6aFfpKyEncgfQndB05ZV8TrAOfia7yfwdCtUW29PY0
         zQD6TWuIfioZSsyt9ntiP7oGEqIrO9huMzdXXYIxX+hYCTSDc8RtZQPt7c1/WFtck+Ow
         GdMg==
X-Forwarded-Encrypted: i=1; AJvYcCWq1jhPLp4bkLA0320m5I7ZBjMZiNmgJbSmVL5VU8vU4Vv347Fjj+5OOwbvmkVjMJYdgMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJNX4bxZz1s/nD9kjIIxU1xnLKhCJGhJUComg+40343J80FbL
	pO6iK0ug14dJbeTntWviUWEGrmZ+EPYdXwHx1X7ubNGC0KqAtfuDHGp7gk52EeCKL1c7dEbZ7A5
	t8OKWYA==
X-Received: from pjqc8.prod.google.com ([2002:a17:90a:a608:b0:34c:cc12:1613])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c:b0:354:aee0:cab7
 with SMTP id 98e67ed59e1d1-358ae6b1096mr3229006a91.0.1771716763762; Sat, 21
 Feb 2026 15:32:43 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:51 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-5-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 4/6] sockmap: Inline sk_psock_create_ingress_msg().
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

Let's inline sk_psock_create_ingress_msg().

Note that now alloc_sk_msg() is called first.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4: Don't pass gfp_flags and instead change it based on
    take_ref in the next patch
---
 net/core/skmsg.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 3d7eb2f4ac98..6b1fef6ef85b 100644
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
@@ -592,7 +580,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
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
+	msg = alloc_sk_msg(GFP_KERNEL);
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
-- 
2.53.0.371.g1d285c8824-goog

