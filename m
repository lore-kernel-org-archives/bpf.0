Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B544749EF
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934202; cv=none; b=C8kdcQen25/G7ly3NJvOsB3IOoTo55Yxd3JVHC5MZbWCabj/M6qsdxnJS0SOxJFMhlURQ7y5ePuC3EVj4QMSqXBkpMcB9BkzLzNl0tOsCSTpHsOrrkm0MihdJOdtsLqwMYBzdn3zvXfXDKGyewiu7IjE7MqoG8MledawuPSSwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934202; c=relaxed/simple;
	bh=UP9fQyC3zZxpD5BEpG4Dq+tAokMvkOz8t8obkBBe1yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HrLYsxhTrgvaHD00qUCzmrY7fLaL6NgLNOertcZia1yRkFYtpLQ99PouSZYGDX70IGOovDsNYjZFq4HTnB9o4blk7M6hSAmENDEKeBPhcIiyIyrnIs+tYXI4gjRdMi2GWFw03oaeYZLPFmHxTCKVhuRFDkDzitQ60+piM2Rg1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9XQRvEQ; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9XQRvEQ"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3734d06dso42323985ad.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934199; x=1790538999; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LWgJQZqTxwTLfqGYLXJkeUUTVdNz7OzdjYdPbN8yxs=;
        b=A9XQRvEQAj1iqTh2ThISY/fh+bRXGW0J/cmPh4lzHlWo0fc6UCfkvg6XgUd/SbfvZm
         EEo4snJdxi/dqwKhNYn+9bTDWl5bx0ddfb4ygl5YCZpcxHEv8pLq0WMtcmwKXrMrwy6E
         iBMOzqLwd1v8Ww/K+PGiBBQGf4JQGGpU+kcAOmI+VlM2M7nooPkwpRq9+AD6VQBbKbma
         8MPkKTEbZczIaVIoy/zKmOWa7eyKQLVIYOMpXQCcFU4mF63ufvmoNnhhODEFYL2x1wUN
         1hVHaB1cAcXUg5n0IWw/goso8XUI+noQvDtBWPfVPM7g16T6CjrUBcIuiJh+qzJ9X04k
         acsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934199; x=1790538999;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LWgJQZqTxwTLfqGYLXJkeUUTVdNz7OzdjYdPbN8yxs=;
        b=EIqRepc4fF7xCtn+znGPNe3ufRpyRH+64gxzbDq7oqR/HBW8byWOPNh53g2lRrSnSv
         +7vYy6fubQ31m+/oJvlK2rxEPWRd9pL36nCDuerPYILs04P6qiywcassNkhr31vap0Bn
         ISPIu+o0QovC6lWFcuAsAAL6w407WFYdQBNd5DdGQuENEMR4W1rHvuIF/I4zt4Z8vIyj
         qCz6GEgADjCVgZ3eifIIRpDCWXtNjbCDzkyrYaTckQ4g6drmhOoPnT0CuKGhA+ime0Jf
         Ems9LvtbMG6y0QCe2QTgfsTqzw9XGg4lYOiY+8QJquxix2+R6o4uwCdxY9a9jWlHhMKg
         LOmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVTCffybQnWw7tLqO1Tjbt88nT6oxL5wVMQKnEEr8pNRx/Qpy8ethwbuQTrv5YhM2ptfc=@vger.kernel.org
X-Gm-Message-State: AFuF++kAvS3U8xOYXw6F/ix/Z365jUkJHrCq5rWIrhZAYYGvIFoL6NZ0
	fXCBLwM/0dEYk4JNYG0AAAa5n++O5C/+xf8z406bFn1fFhSzEwEfgKELpAY7kmVAlH1nboaMsJJ
	UWgNaog==
X-Received: from plrr2.prod.google.com ([2002:a17:902:c602:b0:2df:4071:690d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:2dd:c053:c20b
 with SMTP id d9443c01a7336-2ddc053c2acmr84532705ad.39.1789934199356; Sun, 20
 Sep 2026 12:56:39 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:14 +0000
In-Reply-To: <20260920195633.3033620-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-6-kuniyu@google.com>
Subject: [PATCH bpf-next 5/7] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
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
index 6d0452441b6c..b0e14b54917e 100644
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
2.55.0.1082.g2b9226bbc0-goog

