Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB13A640B
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435975; cv=none; b=MR3uT5udsXaBIvj68yQxWaSBvMT6LSIbCbzQ6gF5EdLurnw2HIc1BFLiJT7KDbhCNkOy9CJtqQ3yy8krtJRSPnZioUFEqKUuBqJrnEAVlxtmTXH05zZrDVCMTMCavVqeYjKOzlCBJn18tT85Z341E9TqPsfLvyPgLwtbo7zRBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435975; c=relaxed/simple;
	bh=+5GEaFORM3CoO66NoVlYA8VVb4EA1WWdjNHNFWPqlUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cTlmkVDVlXcQPxCou+82dYCzKI9WrDaFr127LeJX7Ue26Hqseb1FElPQE0d11g8nYH0gxdRxlBUKNkBnNMsQTklY7gTC2dXN1FOBwDUAz9ZYyEulU25CzzYc3yCp58y1rrJEKzdGx7SUK3kQEGV4G/N2row3A9wEX6qE+OZBdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMbMZnXK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMbMZnXK"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so3823566b3a.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435971; x=1780040771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/991ouznbFu5/3KXjBVWt2WaMNDY7Z6agicqW95vk74=;
        b=EMbMZnXKnVPAt+a5efqyZiweV54RcpeGprXbZJssxC/a0RoQv44GVTWxoRTBRGEWcO
         V+3DZBIdtLBXKhhDjBQoek0JIHEf4lJCyFTshXlAyEJ8jfQZwaO1/L7ZGzYzjBVEpID9
         MB11TmmQeI51/gwGvc5SvHBS0SO74qgJGfkfbhDjUg+GVAXmynjrhJglSLUOH+/uN9j3
         M/Mly7se2+//8xiB2HEHx84Q0q5ONCqfHDlbu7xzJTOLtIEGHYKq2BNt2fOxaZXSPeHU
         bMpiNBHwV5mtOFFd9H/82N4xmbp/28XT0YI1WeBJPMDgjQDsLvoYSyfGHpZokRPSF2RO
         aGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435971; x=1780040771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/991ouznbFu5/3KXjBVWt2WaMNDY7Z6agicqW95vk74=;
        b=tIAT/vnleYUSutnJmA9tcqHU03kmjGA4Ckc5oySPDVhpyfHmCS113E0YGus67OSiEY
         QySBFMiDkHviCogd3NbAmA2fiGbpE5CSZiz0waBgOVdwa8jZ5BSQ0efRHvmPHtPzxGjb
         HXQ2br/Kkten2gVwF4jAoyAVTASi6PTQP2WPu+6Ugn2NjzoLJ0gLr7mZtVpJDzXcvUsZ
         cCdRZycdpoJrbg92MEZ2o5zWbklHWWquCOAS+3E1Z9mSZUnZyBma8Z2kC8Yz4mT2qMxT
         qy62UUXx7vlIutd8S4jJWVBBaOOewpyjSwaxpIYAuHnQ4dAh0Q0Yo0cASZ+QlrLWUKfK
         EPtA==
X-Forwarded-Encrypted: i=1; AFNElJ8LRor9hYw2JK92kKpfpSPEU9rfZBtIZmFe4PqxLZXVRSlDAN3Lz9goHPn8SvYuqxzAzxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggsUXPvoB4hMeHuZyLDa++xV6e9tj7WXwNPnBuXSYQWPEofCo
	ylU6nm/KxuVw9mXEniAMbhnt99T9204TQB7BfsWFzCgwRtkFDz5zOwNcKlUVAGXajF/J49CHrjS
	/Mac8vw==
X-Received: from pfbmu8.prod.google.com ([2002:a05:6a00:6e88:b0:83f:2ce7:48ce])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:140e:b0:82f:4cc9:1854
 with SMTP id d2e1a72fcca58-8415f3c5737mr2620309b3a.49.1779435970499; Fri, 22
 May 2026 00:46:10 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:57 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-7-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and
 SOCKMAP mutually exclusive.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Both BPF_SOCK_OPS_RCVQ_CB and SOCKMAP can intercept and handle
socket receive queues, leading to overlapping use cases.

While BPF_SOCK_OPS_RCVQ_CB focuses on optimizing single-socket
performance by reducing EPOLLIN wakeups and fully preserves TCP
zerocopy support, SOCKMAP is designed to facilitate multi-socket
routing at the cost of higher overhead and no zerocopy support.

Enabling both features on the same socket makes no sense and
results in unexpected interference between them.

For instance, SOCKMAP calls __tcp_cleanup_rbuf(), where we will
add a BPF_SOCK_OPS_RCVQ_CB hook, and bpf_sock_ops_tcp_set_rcvlowat()
calls sk->sk_data_ready(), which would trigger SOCKMAP.

Let's make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.

Both bpf_sol_tcp_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS) and
bpf_sock_ops_cb_flags_set() now check if sk->sk_prot is
&tcp_prot or tcpv6_prot, while tcp_bpf_update_proto() checks
if BPF_SOCK_OPS_RCVQ_CB_FLAG is already set.  Both checks are
performed under lock_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c  | 29 +++++++++++++++++++++++++++--
 net/ipv4/tcp_bpf.c |  2 ++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3608036632a8..ff7fd415486a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5382,12 +5382,27 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
 	return 0;
 }
 
+static int bpf_sock_ops_check_rcvq_cb(struct sock *sk, int val)
+{
+	if (val & BPF_SOCK_OPS_RCVQ_CB_FLAG) {
+		bool not_tcp_prot = sk->sk_prot != &tcp_prot;
+
+#if IS_ENABLED(CONFIG_IPV6)
+		not_tcp_prot &= sk->sk_prot != &tcpv6_prot;
+#endif
+		if (not_tcp_prot)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 				  char *optval, int optlen)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned long timeout;
-	int val;
+	int val, err;
 
 	if (optlen != sizeof(int))
 		return -EINVAL;
@@ -5424,6 +5439,11 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 	case TCP_BPF_SOCK_OPS_CB_FLAGS:
 		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
 			return -EINVAL;
+
+		err = bpf_sock_ops_check_rcvq_cb(sk, val);
+		if (err)
+			return err;
+
 		tp->bpf_sock_ops_cb_flags = val;
 		break;
 	default:
@@ -5999,8 +6019,9 @@ static const struct bpf_func_proto bpf_sock_ops_getsockopt_proto = {
 BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, argval)
 {
-	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+	struct sock *sk = bpf_sock->sk;
+	int err;
 
 	if (!is_locked_tcp_sock_ops(bpf_sock) &&
 	    bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB)
@@ -6009,6 +6030,10 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
+	err = bpf_sock_ops_check_rcvq_cb(sk, val);
+	if (err)
+		return err;
+
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
 
 	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..5c5c67080740 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -729,6 +729,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 			sock_replace_proto(sk, psock->sk_proto);
 		}
 		return 0;
+	} else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG)) {
+		return -EBUSY;
 	}
 
 	if (sk->sk_family == AF_INET6) {
-- 
2.54.0.746.g67dd491aae-goog

