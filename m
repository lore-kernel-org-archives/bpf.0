Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AD4192E8
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653005; cv=none; b=gkj2t2sHSiRS4pFxn3rh/ZTz8Ni8JKQe7AMEnRhW+Podmazf8k3rdTCUNW9dYNKDb8eaeOrUBzW4NrtYD555b2eaIhPmcyff3ygPx2+9I/BBScog8uHqHlGCB2IXOFj7os1hBX1tmua4yv0WU5w+GNKDPsYPUHTTSQll5HvtEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653005; c=relaxed/simple;
	bh=G4+yJM6zWYuFGgB8T+z7rO6dkHqePIEw7sogic09p8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNdfmMOMQD1HzANbjF/TTmWIVkYt6XKCH3fD6xzA5NVCq4QlWtsye3d5Pyh41p+2SCVgor/MfsWzGiADzxfFxc9KAiq98t/T1fN13UpXTDANkZQitSWEzZi5L4WaJ1KkxVbX2BwB0KCQyZAjwkHDdWXiR2gJ5tp/MAx3wKEVtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFruvWfo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFruvWfo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf18c30bb2so11758115ad.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780653004; x=1781257804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCw22FSssd23IT7H44f6S6FFYK8geV9IkF2RFmfa8jU=;
        b=GFruvWfo+dp7EsRy4+nRSnuq74EZN6Ha1zJSmsbBP35U1Yf2FuytBzFrg8cfB8l2TP
         p3V8c6PGIhgJSEzOdaAse8eVxHHWZKu0v7dmZqf44hejGbU+eHwfobF0UczXS5WvgWC3
         DuASqOxZ2THzC24qKdQfccjyiMTON4v+94KIWECcDYsqQ+SrzP/kvIks+9hxfJ5WFuvy
         DbhT6DeXz1ttovBhGQb2osb92VD/AtVj+WYNqQdUl6HzJUVsgwFJS2qDf1PKZZT3esBT
         TNrNUZBwXefw5gLYh7XgLHgPRkePH6fQUoj4QK9iY2cW4jD4rhCIMntDR16whrWw1TP7
         XBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653004; x=1781257804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCw22FSssd23IT7H44f6S6FFYK8geV9IkF2RFmfa8jU=;
        b=C0ODJr5uFX+cDf6mD2kHb/Hno7FLrUOUoyCMUs+X/GJRuXk0W/TzhyG/dStCs8V5hY
         to0/9j1cttkqeifzfcs8EmGWYLLeI3mky49vrVbQ/SzjIR1W/wPtlj7bvVqd7eayitgJ
         n5Gpxgkg2Y755Df0Ki0cu/YqQYvvdLeZotjBq5wV/gI4d7+Mo8T3yFskxqLuyyyI25Xf
         DBW/i0693k6GNGsmwjLeG7tPKlp8qzTnjSLBqFqV++9fgg2sT0c7Ih1hnIWaSCzyt5v+
         qZ6ZkCG1a1A8W/y9ndOhMsda8BhWy3kntoqNIuLtAzdP9bZYRwh9fmOHARP4y58xLlJ/
         2gGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ky0k4BYxHIUC0NNDkTspCLPZbBnPWy+r9ZfizbQNS2FF+Gqtj+/b4CdkVI4lVyrVFRBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXPqdwg2IsHMtWfMTq2VuDbrtHnOKTRm3PJxF/vpO9CgHW5S4
	usrLyj3c6KyTwavDNxzw97lWZuTohjExTCqaESjbvfsKXueRhjXol2Md
X-Gm-Gg: Acq92OGVSLMX8UBfrU9SpVdzv4LOLj1e8F17HXj3wco9zRr8WCKMLQWT6ntQ7lF9mWS
	LkbxjeMNFsqape4qYT+bwkQJtXLwJ71jRESpWbBzRA1bGLW6RmqhhDer86Hup6EXMCUg3LArlSC
	id5ia0R04jjLiAbWH7GxohCXhTc+nwZf6RifGTlAhEm7S2CeHZuL284541he/+Ehxh2AEbbWPzs
	7VijyALqTk0YCqLwn3o4L7A8d2T/TK+TJiaI91RPqZVqAWLpYRL5q/nHJgEJlVd7vaT/FUHqT9C
	9uKhesNB4sTPBEWfbIRevOj66YsTC2Qr92FjTp180TobEbzxRLe49OGdi3VdZtZV6Yh/kf584Il
	Z8uF2NkN8SPOqHY9z+IdBSy6PytLR9c7o1AW5CTtyyuJOGn2YNFjEMS+JRa/7fX0qRtCXremi58
	lf0WY7FaJuuk1SgRJlET2lSeYCA7mQ8BSzXgAauLR9sUVuz1fJvE+PXAqJ8KJD6YV8PHkadh49
X-Received: by 2002:a17:903:18c:b0:2c0:e5ee:f56c with SMTP id d9443c01a7336-2c1e881fefemr29151715ad.20.1780653003681;
        Fri, 05 Jun 2026 02:50:03 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm115871285ad.65.2026.06.05.02.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:50:03 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Lawrence Brakmo <brakmo@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Fri,  5 Jun 2026 09:49:46 +0000
Message-ID: <20260605094954.1374489-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child socket inherits the listener's bpf_sock_ops_cb_flags via
sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
without it.

If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():

  WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
  RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
  Call Trace:
   <IRQ>
   tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
   tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
   tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
   tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
   </IRQ>

The child is freed before it is ever established, so it should run no
sock_ops callback. Clear its cb flags before the forced close.

Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 include/net/tcp.h   | 7 +++++++
 net/ipv4/tcp_ipv4.c | 1 +
 net/ipv6/tcp_ipv6.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 98848db62894..97eac5fa341c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fdc81150ff6c..7748668dba82 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1783,6 +1783,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	return NULL;
 put_and_exit:
 	newinet->inet_opt = NULL;
+	tcp_clear_sock_ops_cb_flags(newsk);
 	inet_csk_prepare_forced_close(newsk);
 	tcp_done(newsk);
 	goto exit;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 36d75fb50a70..493477b786db 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1531,6 +1531,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_listendrop(sk);
 	return NULL;
 put_and_exit:
+	tcp_clear_sock_ops_cb_flags(newsk);
 	inet_csk_prepare_forced_close(newsk);
 	tcp_done(newsk);
 	goto exit;
-- 
2.43.0

