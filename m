Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF40350A18
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522685; cv=none; b=SPL90t5nd16Or9cjOHzFKIwb7z69o8VijFO3gUmRFcmhbWo7UmeuuKZIZ64b829O8R/gil4DkGRrDfBPIOckjZ77PzK6VgDIqBQZbJ54GgPVPelkJGW+wXz4VIX/mET8ypKoygE7Bd7t7CFg6OZ7KuFU7EB4zuiFZerK5IDI9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522685; c=relaxed/simple;
	bh=dB+9E3nzrtjd/qOUOXpfC24bJqJPvXgodPCr0tXF/YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KaJAFdOZk+Tmv3kExDIfAMwW+VG6uImYL2mQAxnC9H9Qn7Tt9HZcPvNnqncn4YUKAu8j/TaRqZ/fb7AAJE3PsRNklqlCMGNev590UJhAc8Ob9y8LTiSY5BOJJwguwnXbKJYlgvsrqLCKrHWkJ3DkgLlJ08HeuXkvJxa8U+u1mOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VO89z3rE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VO89z3rE"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a75ed2f89dso12112795ad.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522682; x=1772127482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfMCvv9NsIrSIhsq2/2xVHVJbDQutQhyzFzjPn4hlTE=;
        b=VO89z3rEGSV2S0+YMXQ02umrETA7RDOPUAgpgZVSQRlduqaK6uPArhjfKIWshyf78q
         rzrrLe9Umf+4wS8hIOOw/0FUe0KHlJrGQ12Hg7DlQZ2Sfc9+t2CuApDR6hac6WHZaUla
         Jkmuhe2x4B8+WMvDEQlqIC/58qLwy7Hu7/rQKNtLyqCr/2DOoX7R6BNp99aTdaPfGJfR
         qENnZ3U96FXUkhYadNGhoyE1opIQSPq8QlbyrZOJf7EY4NFXMg/q57WVICv3bfU/7Lav
         J+1H0qFu7iZM+JzxWmQNhxKEfFf9BiOE39G5VXXi/FXfqtXaE4+JrclfhEVRHYvdWEEo
         iK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522682; x=1772127482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfMCvv9NsIrSIhsq2/2xVHVJbDQutQhyzFzjPn4hlTE=;
        b=wfJ9cccTAt6ru5edmXfIb/iQJIrxyXWImPrGOQl5V3igKwdpkkFbgQ0MVhttYDK26P
         /YXlAG1Z/TQBrB6DfNO0Y6VkiGo9jai+g6vQF1dw6cLZsnIt6oi8Pf74JodXYFiD+2F9
         msTqxKC7NHxKegph7lZRY/mh3+qvmrJYG7Lqa5ANkdUooY/N0Nawzt6TDg2cQR2cKBuj
         i68TdjM/K5iXKEK289nGGB8pADRbCqgtzKRTKx662YGCxFPBzC18yPVgo+fUqlLXDZmP
         cACuJ/z05U68ADQe4GLSurDR2IFfyMMh3Fsrm5pTdIJOLyAug7Za01UCQlEo54sFfhJF
         +ciA==
X-Forwarded-Encrypted: i=1; AJvYcCUV5bJibRliMOnNpxml56c9FJrJz7rJ5wQTI2O2UTGT/KU+XdW+FvQZ9yg+ciMa8JQ2mmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJxKpeDBLzpyevzrG8hHnhM69fp0ydaerpd0SdloPwWVZPtxJ
	gS2tIGYa09LuTGYlKnKg2//aYx8diyfb6lti8OvVKgFEQHZNxtmQanPTrf8xH4MJpd0/r5CLW+J
	+OL+I+w==
X-Received: from plch7.prod.google.com ([2002:a17:902:f2c7:b0:2aa:d7bd:1139])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b10:b0:2aa:e843:ab11
 with SMTP id d9443c01a7336-2ad174dd3c2mr156687835ad.28.1771522682201; Thu, 19
 Feb 2026 09:38:02 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:25 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-3-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
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
2.53.0.345.g96ddfc5eaa-goog

