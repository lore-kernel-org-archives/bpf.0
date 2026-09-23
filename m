Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6F47534A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199450; cv=none; b=NQOuFIPUEObTyjkoGWGzaK8mQxxqe2CIXTAlOp4aEJmUR9pRoTGl6ZgVHo97mV4wUvKFLXWoSwdcAMgxtnHFcJC0qop0L7f1JqJdoSxq72r7Yvr7PLEcNaFg0apgsujSLhcpspdNnbQB8uQwnaf5fVgnvcfeswWsrOGYltOzVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199450; c=relaxed/simple;
	bh=gKYFBfLJVJUEpQ0adS/u0b8b2tFP7IzjSFz5nUXuXNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fL1XAEuWxdYuRjSGwGpe4xVe3jnQfgbQmev6qdk+oSgscvjoGa/eIIUxki0m5dXQ8sU12aM3eYIlRGyMWJKoc6IAkrfXfY7vmiDUYYAbyGIJ/uR/a4lsCfTk3Rlq6g4n0vg5tsJ3KQbpRIZdc/wMPYRVgtPrt3qTS6++OXzXB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhJgq+H1; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhJgq+H1"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc52c77089bso1558636a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199447; x=1790804247; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Y9MsF0lRPA5hIAPoWY4vCytE/2HcHQPyT3wBY48Wz4=;
        b=WhJgq+H1G+I0IenEi79K9rT7BHeR1NOXDVzf5UtJB4zurIjgF2TCcGphoDiPGXbAQG
         Q5Bt6MV3kSlWA5Zz8DooXwLgd+UkrA+9FYogTkq4ylesu+Fq+iA92c+MRpTZNS+glywW
         PbtoclfXITMVkFybjz3jwMR0HJ7VQNKcYvnruZGSWsTbI364lf6W9risUtMcAuCq3X5c
         QB6WuajqQF3FzzIYlzqwC+ByHubq0pySRuK7+pV/TPqE+2tkaLMErOwBGrikC/0OGcje
         lJUwchByEWPVKX2gxv2NRAvwcXcUZAFRkBouDKK/CrDOQCgv3jqBehFvU6S8FqT7JERv
         CpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199447; x=1790804247;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Y9MsF0lRPA5hIAPoWY4vCytE/2HcHQPyT3wBY48Wz4=;
        b=wTxdKgO5909eNGey5qWYzMMURmmahtNAp0VdnTRjoQpViAXdpcGkvc+G7f8VrjtOHg
         tPHjgK2dRtvxcIIiDhqkqhHBY5w/yNlnyS1w/nJkKt8tjaiW/7fPGd4UGV6aRB3UOCCI
         l245F0YRsUkfNdRC5EX19s83My2qoCViYs7duxsgco55xMGCO2mjTGYuc7t8c9pVUa9G
         4r2A82fwv5dlVqicrhCb8SU0kuQLa13H8nJ2QZk5u1sUlgvmCYheh7o2iUQr6LB30Uvb
         LELhT9I/VhA0Ec+CbtOKXoGfqxaZszPC8CyEc0KFB5sPBdDhLpxQSchb7c4S/BoPx+Ne
         usTw==
X-Forwarded-Encrypted: i=1; AKwUvBwdpRiNInz0+S3rXSjgEBxwnCFlw7Pnns7ns5HXOIhU53av70/MnAZcDpsBqLa70/HCXWg=@vger.kernel.org
X-Gm-Message-State: AFuF++myhYqc061OZjBMSJP5uFxx9D2wYPO+nXVjrOIHKsta9CxDmSVC
	EJcmwdg/9BLiti7eaekpRHyHgCtCgmc7Xbvfw4AVIX+IsD1Oej6+vW39nbRqyc5XGw0WF/L0T/6
	mrzPS6w==
X-Received: from pfbgm2.prod.google.com ([2002:a05:6a00:6402:b0:848:5740:db83])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c18:b0:878:34d7:6a28
 with SMTP id d2e1a72fcca58-87e9bb85c53mr326162b3a.42.1790199447095; Wed, 23
 Sep 2026 14:37:27 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:36 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-7-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 6/8] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
to bpf_tcp_ops.

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
so we should not allow calling __tcp_set_rcvlowat() on MPTCP
subflows.

Let's disable BPF_SOCK_OPS_RCVQ_CB_FLAG for MPTCP for now.

If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h      | 15 +++++++++++++++
 net/core/filter.c      | 10 ++++++----
 net/ipv4/bpf_tcp_ops.c |  5 ++++-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 07426e8641b7..d3cf655da9ec 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2932,6 +2932,16 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
+{
+	if (sk_is_mptcp(sk) &&
+	    (val & BPF_SOCK_OPS_RCVQ_CB_FLAG))
+		return -EOPNOTSUPP;
+
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+	return 0;
+}
+
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
@@ -2954,6 +2964,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 5feb99884682..f29c061bb066 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5588,8 +5588,7 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 	case TCP_BPF_SOCK_OPS_CB_FLAGS:
 		if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
 			return -EINVAL;
-		tp->bpf_sock_ops_cb_flags = val;
-		break;
+		return tcp_set_sock_ops_cb_flags(sk, val);
 	default:
 		return -EINVAL;
 	}
@@ -6178,8 +6177,9 @@ static const struct bpf_func_proto bpf_sock_ops_getsockopt_proto = {
 BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, argval)
 {
-	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+	struct sock *sk = bpf_sock->sk;
+	int err;
 
 	if (!is_locked_tcp_sock_ops(bpf_sock))
 		return -EOPNOTSUPP;
@@ -6187,7 +6187,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
-	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+	err = tcp_set_sock_ops_cb_flags(sk, val);
+	if (err)
+		return err;
 
 	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
 }
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 4b48711d92a2..b0cade34cce6 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -223,8 +223,11 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
 BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
 {
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+	int err;
 
-	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+	err = tcp_set_sock_ops_cb_flags(sk, val);
+	if (err)
+		return err;
 
 	return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

