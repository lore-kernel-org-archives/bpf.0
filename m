Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF49399039
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435970; cv=none; b=LlaaiKiEmFpI3pw3+lwNU9KbMPFCupdZ9BzKoMI/Ukaj8u6Jr/SVxrr7cqxMGRSCGt21LQqH5QB6ubiu7a1Jg/k60yWolBfX3NCQ6neB6qE9l1tTwDRraecu7xBf2LeKJDldS4+zyhe4J+DVOOgBGLycNkLWG7K04zhaOdpmKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435970; c=relaxed/simple;
	bh=wpfP9iaC4NcOUpR4U8log0eGACMjzwD9P5ShdZk1/Nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hBBBPSrxG7iNQxPK6gWmaHHc430e0O4Dz0MjSTBuLsiAwpMK13RnT4ahY7MHu376ykKa7Ut9U4gYjBrfSHlEGXCyVyZyvj8AL49elACd6D/oGAFhffeXjzn7x/BC3URUh4sa+Y+VG3fvemiKo50zYdopkja7vGAsMwhHSWaae34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/fkue+O; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/fkue+O"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-835423c69ffso3714125b3a.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435968; x=1780040768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=k/fkue+O/dWBjTyqyDSZjz63hSEGn7PUvGy9RLccAESyyEWLx2B5MQmMXZ61NGvBCt
         /yF3I/Yd3JjbE5Fg7fhLXlhki0cUSZWWYD0kTSukzpCvQ4eH/xPXOgVQHK35p+COiTkm
         ratNvANwXQog4arA/BXdf2PoMfvv0Sl5GSgmC1l5UF+U79dWaSd9uOQutEz9BTHqKAQB
         dOmRyRQSqszYWTbZwdCjOyRu6wQ3XFmgZBjsvC9IgW3wqPpmn5iMqvIbxLnGTT7gyd34
         RATOIEBpPHEy/5fxRhihBOsq7/DZcHkUU6JTDktP0vHhNqoVi8sArz9+SKZYUIuuNy4o
         L0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435968; x=1780040768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=VoGQXjkILlOeMG7tdSJ7gqzRacM1MGpdRccRhH6GlJRtf9LEYChgRK8aAPh8QnbQXS
         m8isZkiO+nVNFmtFoO419ywLLv8Pi87/pN0FV+RqgiFCfn5Z3YMDrT+ChYCDj+ZdjSxM
         tCUM4h23xf52MANhuWOJlqPDsAywSXg+zAN6wWZ6ydpXdmFzHsF6arf9nT3WL7KLVR2I
         I8ZJzwLpXSWkYmaTU+5xgdIgb1s/ISnOb1P1kDtBEZ05WaSoi3s5b9uAnPNsHEM5apBN
         fnYzVUzpaQJQbfHk1/I9JwNrZ6lBlYjDF9pSOfDeIR62g5tqijsmLBHWmbKs/G9BGLa7
         AaTw==
X-Forwarded-Encrypted: i=1; AFNElJ+gX9z2kBIYlYXp7zb2xEbSH32U16Hr4P4sV9CQdS2LoqffoOY19AFfpmxYZMzXY3JMiDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBotNydUj7Uh66vZxFQYDZC96gHznczwQTzU15jBCuXOcJocv
	uEviAnsokN5D/Z+vFn6+2RuzLvpijEE4t79+UyexCW6DY2qVKTdckn1a4KP/SUMLY3Se8dFJmbP
	r69IhbQ==
X-Received: from pfbgu11.prod.google.com ([2002:a05:6a00:4e4b:b0:83a:58c1:f5e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3923:b0:82f:4a4d:3793
 with SMTP id d2e1a72fcca58-8415f407030mr2837303b3a.28.1779435966826; Fri, 22
 May 2026 00:46:06 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:53 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-3-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 02/11] bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
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

We will introduce a new type of opt-in hooks for BPF SOCK_OPS prog.

The hooks can be enabled on per-socket basis by bpf_setsockopt():

  int flag = BPF_SOCK_OPS_RCVQ_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVQ_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVQ_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This will allow the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
(e.g., a full RPC frame) is available in the receive queue.

Note that is_locked_tcp_sock_ops() is left unchanged not to enable
bpf_setsockopt() unnecessarily, but bpf_sock_ops_cb_flags_set() is
supported at BPF_SOCK_OPS_RCVQ_CB to disable by itself.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: s/BPF_SOCK_OPS_RCVLOWAT_CB/BPF_SOCK_OPS_RCVQ_CB/g
---
 include/uapi/linux/bpf.h       | 18 +++++++++++++++++-
 net/core/filter.c              |  3 ++-
 tools/include/uapi/linux/bpf.h | 18 +++++++++++++++++-
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aec171ccb6ef..31130e1b63ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6960,6 +6960,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVQ_CB : No header included.  The payload is only
+	 *			  accessible by passing bpf_sock_ops to
+	 *			  bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7031,8 +7034,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7176,6 +7187,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..4a50fe2cd863 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6002,7 +6002,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
-	if (!is_locked_tcp_sock_ops(bpf_sock))
+	if (!is_locked_tcp_sock_ops(bpf_sock) &&
+	    bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB)
 		return -EOPNOTSUPP;
 
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 37142e6d911a..3b8f392d8c69 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6960,6 +6960,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVQ_CB : No header included.  The payload is only
+	 *			  accessible by passing bpf_sock_ops to
+	 *			  bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7031,8 +7034,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVQ_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7176,6 +7187,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVQ_CB,		/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.54.0.746.g67dd491aae-goog

