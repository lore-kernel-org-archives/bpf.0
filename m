Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3E1B87C0
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286829; cv=none; b=ExXZnXMzDP0mgPBRZqsXrJgubp+RV+P5EO14sTfx15HnbEVTmqedp0I4MMirN2i3kzKiLwKEMf8Bf81cvcBNJ7wN2uDEPAO0xlKiGWOJiuYOqtdfhTUQn3MGFW8UoVe3tuWdjEWvuVdZo+Lk+i7r4Fgtn1563u0s6KZWxN8g8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286829; c=relaxed/simple;
	bh=fXTR6x5eUroimUQBomddgE/3LVW7RGwbWy3GPmAvBdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMtfiEt2PKAYabWGkowU4oMB1DYbF2d1fyM1AaSGWDSSmJ0f3zoO7Yu/hbNvOVfIhPA4AZxVtPce2Ji3Qv8dybnUATROgXNOIyOBi+PBJrtNK+IhfvR/hAGU7QO5+pTv8pfmqurXOZthrqRBmHPXVBYOtD2E7D1SRzrQhKj5q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcWuoSyJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcWuoSyJ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e74e55d35so717119a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 16:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286828; x=1771891628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkfVzCVTZnvHD8hLgyrAKSJhuenzVoEE09W4TgLMOkc=;
        b=TcWuoSyJprq1MujFKLMJBvdL5as0sUzKooUjYxxomP1n78QLKwM0QNtIZ3Uia9k93s
         RF8I9WeBYE1A2yLyB8Jtan+QGTWEOaVUo+Z9UnGYuvEdIsF4dkCRTEcx2ZWsWidwbWMS
         mFLJ6ZkVDrtpRQ3ikVECvhECVE0u3pBgn2VcXN5g50A1hWhqPkE3BgMBVV7BiE4m8SkI
         gNFd9yYEZ2IPTlI++QQKMWoZmS6f7xvWdy05swofGaBoksNwYv/qsB5+PnrT+sFmP35e
         FysPE1ksKrztU13oimIXzJbzU0epFEDqcePd9/xWd7Ldhe+Ryg8I0Wh6JHZXm6y/NLMr
         GQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286828; x=1771891628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkfVzCVTZnvHD8hLgyrAKSJhuenzVoEE09W4TgLMOkc=;
        b=QDXJrFRYXcpkBuXzfXhZLOiZoyzjMpZChNXgVHlrB0R1p1GWJEFrcJgLWo0TBtf0Qx
         zeZHTnlCOcakhR6UtwrjlL1+oMbIYbEqIOQPNrSMNMJazvH8GCaKUyYuUI5rgWHwcFPs
         h4lm94ZPZzMPwISXGmK13N7ljH4EI6tkzd69Q/ktQmuQgGdM6Lbv7KWpgx5Ma3O7EOFO
         uF447RrVLFD84AAuAyUeugx10ZmiXre8jG1HeyDk8i/AkKTkRxWOhfjP4GR1WLdFV/yp
         fc28Bg752RDPrgU99ztwooqs10RZeVGR34/GRBGbb1MCB22u3brLslF1XFn9v9BZO3vh
         ogow==
X-Forwarded-Encrypted: i=1; AJvYcCXcZmLfvuqmZdFsM9g8QYjCPtGosU+cN8QUIU4ImqepWTBaBdO4yyxhZrpUvzfTbIDfq6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPpu9+fPg4M3TmTbe/kxYSR3tZrBcGGSmGNWD6zi/jHPlYdJc
	C2kuQQq4QWD+4G/+8GcBLXQv+toXWV20HvvnyAHtbinZ3RFUWtIDwtjC3lzq5DkRbtjsE7lTdT2
	knSydcg==
X-Received: from pfiu8.prod.google.com ([2002:a05:6a00:1248:b0:824:c9a6:b9a5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1bc7:b0:823:3078:f684
 with SMTP id d2e1a72fcca58-824c963e378mr10382357b3a.32.1771286827380; Mon, 16
 Feb 2026 16:07:07 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:14 +0000
In-Reply-To: <20260217000701.791189-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217000701.791189-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-3-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

UDP TX skb->destructor() is sock_wfree(), and UDP only
holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() is read locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Cache sk->sk_write_space in sock_wfree()
---
 net/core/skmsg.c | 2 +-
 net/core/sock.c  | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 75fa94217e1e..3d7eb2f4ac98 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 
 	psock->saved_data_ready = sk->sk_data_ready;
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
diff --git a/net/core/sock.c b/net/core/sock.c
index 693e6d80f501..710f57ff3768 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
 	int old;
 
 	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
+		void (*sk_write_space)(struct sock *sk);
+
+		sk_write_space = READ_ONCE(sk->sk_write_space);
+
 		if (sock_flag(sk, SOCK_RCU_FREE) &&
-		    sk->sk_write_space == sock_def_write_space) {
+		    sk_write_space == sock_def_write_space) {
 			rcu_read_lock();
 			free = __refcount_sub_and_test(len, &sk->sk_wmem_alloc,
 						       &old);
@@ -2690,7 +2694,7 @@ void sock_wfree(struct sk_buff *skb)
 		 * after sk_write_space() call
 		 */
 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
-		sk->sk_write_space(sk);
+		sk_write_space(sk);
 		len = 1;
 	}
 	/*
-- 
2.53.0.310.g728cabbaf7-goog

