Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2033D6FD
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225659; cv=none; b=cu+Nwr0YSojT6REz/bY3Oi0hWHXFMTTXoCrUt4PIvYDhacMrWTbi1mDcyaSb5+UOMYHmJc7cW5/+k16EUtFrnUW80zaPWj9BTfd3CbITmtmbAVKtgn+R950RANu2EMLED1H3mzuZ0p2WSXzOKJMjK6LNKLcahmNFC29yQUwjYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225659; c=relaxed/simple;
	bh=s8bD6rb7h4TwOEWUGOjSQ901sPb7pih4kQoepBzQ3KM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tGTvMG1zw57A+Ut3tU7Rouu/9LSwJVnKgD4eGeNgqiCwuzu0JwZRFdsDiDbsEd7nZg2p0RlXOKDDvRqnCNu/YAcj/Kef5hE9gfIYKuefRx6ZjpXSnUri7NisFV75YDunrRCXJQ+ylN5JhGH9GVCfLbf2j0oGZVfLw05WRr3WC/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wr8D3XN6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wr8D3XN6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so1020464a12.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225657; x=1778830457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HIMwkd5dvtYZCcYXQgZqrva7xhDMHdet8a8IQNVFpY=;
        b=Wr8D3XN64M13HeBGUhOg0/Z4lpNHWQrKzwLgRlVAOsurMvvqJLGJ+Oj19BVPPnIkXX
         QsomP5FjKnn5YI8H9nyDAH/umT3qCP7lVsFDvEK4Ej0SFK9u/GYH75vwiqQzvyHAHxMy
         LNShgUS6264gr95uxaPVWvoXodP8SlJY8IJj5+zRzglQeMTCesyUeqckRGBLtNCRmbBo
         zpUngU/H5FndjwhU/j98EobL7El7rlWkFjLBsVI+P5y7qRkjk3dYqogAp385aF6mJOT8
         ZPXvqDust2rtWaQr0ZGKzN3EHa2iUWpDRL7Las7vTC9WJuKnxA7fxuKy/6/fpsK7K53Z
         XLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225657; x=1778830457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HIMwkd5dvtYZCcYXQgZqrva7xhDMHdet8a8IQNVFpY=;
        b=rYCsmPKscDzICDyRcJDU+lfbXefztFRJSGLQYnA87pOsR6uBZqA4s5PGAFlUZPR3bz
         5+wNi+0ev6tHUtmNrd3LqELgb8Mqa9k4cKVF61LM0WXZxLsZOi05AzsFmy+gjsu7ccwR
         epQBJrA/HqhGd7NdmCJwRqf5SWmtk8Uf5SZwFye4xDTBD+5jYTQnslqzVV05Q52IkbT8
         7hCSjQrpsLYtlt1Zh61yux9yN8DqbdQmr5OE5Kox7mLn5W2gfhegC7yqD4jYKdq+KqH8
         KkvM52CsDqRDCJUp2pjzqct9qJpLfOSGyR2tnnEbYBMTn27uSHRxVFiOQuTxT1b/ozN7
         kUow==
X-Forwarded-Encrypted: i=1; AFNElJ/fwWZeqJ67Pn/cBw+HoTHNS+FHmUfkXLPdI0QLN3LkAHNITcje280LrHxZGaltLPzHkJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ykgiVreReAmImMqDaf6MbdzNt3Ttfei/C6u9KSVjLLEL5HGH
	/Y4BTDPodCm+TtV7DJvjfdbUZlDbdo04vKa5Gp+1iwyRn1hGdZ9OXjUAKUMo4zwa1j0ST4vioDb
	XPIiIiA==
X-Received: from pgbdo6.prod.google.com ([2002:a05:6a02:e86:b0:c76:669e:8145])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94c7:b0:39f:477c:441f
 with SMTP id adf61e73a8af0-3aa8c20c680mr6030024637.36.1778225656532; Fri, 08
 May 2026 00:34:16 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:23 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-3-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 2/8] bpf: tcp: Introduce BPF_SOCK_OPS_RCVLOWAT_CB.
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

  int flag = BPF_SOCK_OPS_RCVLOWAT_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the SOCK_OPS specific helper:

  bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RCVLOWAT_CB_FLAG);

Once activated, the BPF prog will be invoked with bpf_sock_ops.op
set to BPF_SOCK_OPS_RCVLOWAT_CB upon the following events:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

This will allow the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
(e.g., a full RPC frame) is available in the receive queue.

Note that is_locked_tcp_sock_ops() is left unchanged not to enable
bpf_setsockopt() unnecessarily.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/uapi/linux/bpf.h       | 18 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 18 +++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..e139a4e94ffd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6952,6 +6952,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVLOWAT_CB : No header included.  The payload is only
+	 *			      accessible by passing bpf_sock_ops to
+	 *			      bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7023,8 +7026,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVLOWAT_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVLOWAT_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7168,6 +7179,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVLOWAT_CB,	/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..b5268a66ecb4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6952,6 +6952,9 @@ struct bpf_sock_ops {
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
 	 *					the 3WHS.
+	 * BPF_SOCK_OPS_RCVLOWAT_CB : No header included.  The payload is only
+	 *			      accessible by passing bpf_sock_ops to
+	 *			      bpf_skb_load_bytes().
 	 *
 	 * bpf_load_hdr_opt() can also be used to read a particular option.
 	 */
@@ -7023,8 +7026,16 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when TCP payload is queued to sk->sk_receive_queue
+	 * and after recvmsg().  The bpf prog will be called under
+	 * sock_ops->op == BPF_SOCK_OPS_RCVLOWAT_CB.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVLOWAT_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7168,6 +7179,11 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_RCVLOWAT_CB,	/* Called when TCP payload is queued to
+					 * sk->sk_receive_queue and after recvmsg()
+					 * to allow adjusting sk->sk_rcvlowat and
+					 * to suppress early wakeups.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.54.0.563.g4f69b47b94-goog

