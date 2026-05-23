Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0A35675E
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525008; cv=none; b=WaY8dLScygDZqxb8mcvVqkVLDE5tHjwPVEIFmj4yUexBNc0DYyqVwAAHofXMTpyC+v07prrCl911uQK0kvBArzcjbeH21xoPSFlT93+qIENGOg8W8tRkoN7c2vkcYb47xWg6H0P9E9Nr3/igC5hwLkcg7elCxYa8D1jBJtD9H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525008; c=relaxed/simple;
	bh=wpfP9iaC4NcOUpR4U8log0eGACMjzwD9P5ShdZk1/Nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vq52pOL6/bxqyVFKxGdYdP2A+mTELjLlHNqDQZietkrWZs7YCx4quNxsvGx61HkD1dwethpaxBGv6XjelGy6OeVP/pu46mMA7nLzuridvcMpDL/nxQArEyB1g7uNYU2U8KfnXtdri0AZ4WC75Knk26buUEOcgXeN49S/HuhO7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jh1k61Og; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jh1k61Og"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso150969875ad.3
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525006; x=1780129806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=Jh1k61Ognl4nKPK6gNRbO3Tl9ISBZdpYQiAxZXGNFi+WzVbp0rhGRVaj3gwar6lGMA
         +I6x81AhQkS1nF5hzIWGnjIDGwOY4+mR+DDa97xTInqcjntnL1ZAqn0TlfftXS0pzc5r
         zO/QpKFrxfIRj9glvM9BqMc3qPWoPgzhKBBV5V5sogtPwdQyDguCJzusXPxmB++DzDik
         rbElVzJbkK0VyYaAvIynCKnEoeegVjb8GPVu6XuUDHV2N9PKKXTw9C80lYCqL4QwGAYB
         OdN4QTelzUG1n3HtuYlxS7l6Dko5B/XB1APhwEBTc6kumBbuu6KWVq3QPAifa0c4WWql
         2d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525006; x=1780129806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6Da+zB+tQ14oHQfrt2FvNqy1zoi5M1iY7vb9vKFTs=;
        b=JIAgz+2vBVi6Tw5x/hOnmS/8zE9ppLv4d+lprh5fXCyM9FvxYNO4lSjZxxBLdiLWpx
         Y4DHdBrrC2/6X7XmALII/B8oa2M6foo7fdKSf62wzecCGjYU0c0uT60YD6VcUvO/0/dG
         N1eLNgRFtgvJXqxyei/Lfbe31h+rwyo/WKvIUBhKAF78rJ7x3Ceb6bdIE9/kMOaVbLoq
         lrno7wZ1SS/o3rDH1CbeJS2QMyBmG3En0RIhPGnI8SJmeCYtGVahZwPM+ajh9fmcT1Zl
         ZS+n1kP94goVzEZC8wfBXuKnVZbgh7yxfk4jfhcEuRU1Egg4/z45fXpYti66uNX4asj0
         hNUw==
X-Forwarded-Encrypted: i=1; AFNElJ/nibh7SA8njbWYlskW6Y19ji2UqKf4BpI4Mpbal9zr60ZJ56o/lsXhWCoqoxfkzibsHPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9yfWXLnQIgwATRJ9LsH8jgkdqQlfaLCjoL93LKtt/ZlRwBX1
	ijJI8ZYOfQZbqaix97AunErK0MyXHDICoep6IVGkQifyrbElbftGybDgKWs3scmdxtzLo0y/bma
	v5b/PKg==
X-Received: from plll13.prod.google.com ([2002:a17:902:d04d:b0:2b0:c9c5:109b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e885:b0:2bc:e62a:979b
 with SMTP id d9443c01a7336-2beb0699cdemr77192945ad.30.1779525005751; Sat, 23
 May 2026 01:30:05 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:31 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-3-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 02/11] bpf: tcp: Introduce BPF_SOCK_OPS_RCVQ_CB.
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

