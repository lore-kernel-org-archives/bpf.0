Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C2328616
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716762; cv=none; b=Crh4224zqE2QSCLM6BBylcpYGmlMhJN7nLGJX5LOAyquRjPeFoZdxPrjU3E/2fZy467qc9COVyFYuiPQb9WQw1KUBA9tYhXnRC5wj53jAil4GWEfDb3tjywai6OEoPAvSYf94I2EoBxuOi7fx9JBey9WdBj7AXj+saxrDjolFhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716762; c=relaxed/simple;
	bh=w8IxoBaZ/ych/LK46ivskIm0/MyrSrBDhhNVaW/Di8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDVWI0J4OTtBeoU3+k0kJdZQKQUXNvcHGPOwBFWufNECpR5N9Q3xtigAImm8OhfCZ+mt07Pow6blrzehoBUZsDjUGYZmMz+qW2we7TWKyR/gtKvTgTxlihXZB9vMEVRBIq2O0RQUwDGbaC+YBGEnNQAkTtV1pqFPUPkmedvOX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShYvXn2k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShYvXn2k"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad5fc5b2fso27476025ad.1
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716760; x=1772321560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1LCPL/qUtE8WHjYpGieZEgldrqDUcwGczoEoM5uQNo=;
        b=ShYvXn2kqejz7EA33Qqs8wvDwYJxdTcjhMNl2cEmTsK79noYZQlWxdsqz18zcoIehh
         Wuk1tfio4WDDI7IrYVzviTyb+lWDJVDwt1iPJqPxuLoZSz0/afX80IChnxmb8koFSm9Q
         INuQZU5LoSmgESLK/A0BV02fKUgu+2Ucn0tzJ5w0tI9szDDJFgvyLiOMVumw/z5lLjYe
         o5FDQWssHKInqMwbyyNmM6TKQ8o5HHkWapGLj/Ky0H/iAyNNefUBiDn1fFwg4Akow4y/
         WsESwwrAJVT3jjHRgsPjVRgHaY7cSk32y0xtutthp/u1M8FyseCrUCrzN4VMfTvmJjLg
         q3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716760; x=1772321560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1LCPL/qUtE8WHjYpGieZEgldrqDUcwGczoEoM5uQNo=;
        b=FIiErWhmAc/trZ4WQeIf0lE1r6As1jPnmVkr5OhfhsD3E8SJLcN3fLh9ZgVd8ruY9b
         sKbhsqS6nXlZqPblu7Q6Ww9Qm1hEslsLByUwDvScbElJ0bGDpL2Fl9vURcZdgwi4mr6E
         cvcTdt9K/46xKZuaYHuhJ6z4OgKB8x5Mip6da8GDlfcyrLLyR2xn5D3yglwOKYbE1dkL
         TchbWbazFSjFS2I5RcQAyRJMwcGEy/wCcI3wJ7ambeykNr/6amtrJbBD8a1ll3Zq1AJc
         sNEVBaDMibaXa7tPOOfzgA7Z3Ph0lUEvRzfUNi1jBSrvCuEV4fnxMdgcCke5ejDZlh71
         msVw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+J+BCOMSq31XkWUQpi7ygzdNtdXAeYY1zrcK3zDOU27syHQ8uVa2Q4B/oeX6WzmO5D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWVctRlR14p+f3DcHDnrcSFXVP7Lh/NuQVI9nE3cDrvluPJOH
	WRFOzzIP+MVO6Bol1iMBBZm94Hu+OKYQi0GaB+KOqC2TdoVpPcT1vUS8WYLy+J2K2QN5GZ7n5k7
	DNAD2Xw==
X-Received: from plxm17.prod.google.com ([2002:a17:902:db11:b0:2a9:633f:4a0f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4d:b0:295:b46f:a6c2
 with SMTP id d9443c01a7336-2ad744e0f5cmr40005565ad.37.1771716760373; Sat, 21
 Feb 2026 15:32:40 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:49 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-3-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

UDP TX skb->destructor() is sock_wfree(), and UDP only
holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() is read locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Use WRITE_ONCE() in udp_bpf_update_proto()
v2: Cache sk->sk_write_space in sock_wfree()
---
 net/core/skmsg.c   | 2 +-
 net/core/sock.c    | 8 ++++++--
 net/ipv4/udp_bpf.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

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
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 91233e37cd97..779a3a03762f 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
 
 	if (restore) {
-		sk->sk_write_space = psock->saved_write_space;
+		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
-- 
2.53.0.371.g1d285c8824-goog

