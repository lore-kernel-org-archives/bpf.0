Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F23A5E81
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435974; cv=none; b=oh/fxQDTEKiABUZNaBAL00zvPLAi7QqfGc6Mp1WpMzZtdfVu8wUVGlESP0++vJ8YTy1UD2K7BtKyZsz175nFx8eiH4oUU5iK+T7gt8uAoqNJa5pivvfznUaTM/PN7T/w1T8kTsbqO/aDdtmioa9j9NSMeulCjMmbCuTjED5mMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435974; c=relaxed/simple;
	bh=ZyD9AQscuylwqpRs04xemnKsI72mnSLQlWHwuv5SjUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MNxyseOFMH+S8kspCIqQDGRXiAznT03EhGEw2SGaXaj3K2yFSrklmCJk4i2/KKQzD1Uz7RO6bCyiupq/f6TWmQYUFE0XLo/3OzYO0oU1atwmABVTgx1lvT5G66/JOC5ZFAD9hl48DIUuu6gaMZjZI2Z2htUkVpbWJmgJ9P+EbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dl/2HTwM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dl/2HTwM"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82751074c8so11199287a12.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435970; x=1780040770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXW60/1sU7ehwE+s4YZIIMUDlvA6FNdHZ/Kq8opfaUQ=;
        b=Dl/2HTwMPnUkG1rrt4Kc88/y0qFr9NeOLFKMRdm+m+mLr7qB8PhmoKpPwoaW/McPPY
         jngdl/zKFppcdA6A/GfgboQpXYcpvKmCmIgdCVGXBSK86D1xbGeF+craYwx8AiZL3ls7
         kF9vf+Y3kyQYlIOrwF/v0vMT/y55POO83lv4pC0/ZH/sdOLOeBvaCHtAM2zsvYm+Rb46
         GXiXy+jBpDkVpZl9HHszG0ewZ6cyPgGcUWVSuscPfyRJIrrHETBYLJ0cZjqvgT/M2wiO
         LeMwoYtgcVfaC4bCxEXSHrw0lKCMWcyhL2BbpS9bFq/Su6Axe7wSsFhevG2UySNwT6J1
         C0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435970; x=1780040770;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXW60/1sU7ehwE+s4YZIIMUDlvA6FNdHZ/Kq8opfaUQ=;
        b=QHmWGnj47YCR2U9/jZYdyPqWJl76TNBnkuMJNMu92KMlVfECDYW5SQ32rNTkAsaA3r
         fhJ8GBBPeEXItWn51VCLHBsz9eC2z+9OcBKKHz9O0NF6Ezv8hw3igZ/EjUTxquv28/Ln
         iP6WjtEbJ+3RP+tG0PUtq/5oqY5fIzkVQ4pmyHVyi+DG73YAORHn+xij6FMz2nS9L1Uo
         tScEtKiPYUOVBnti0Qhyd7PPU2EW1gBbEfPwN4VEVhuWAgcbQYfi4YH983ChZ8DBCMko
         OgeT7lsEolc5vlF2+ML7A8HrIeIPmQfdM1DKCxmG/TetifD+kyvcKbNRr7ZEUPWlkXx+
         eF+g==
X-Forwarded-Encrypted: i=1; AFNElJ+wHAmd7hJKJu/Ou7dyRvJBa+XI/GnKQxqyBpghR2AV5y5yIFUerKA/9gW660ThS+WnB0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjwr0ereaT5/b7puIPNgY78cafSxkJpkCAttXZlt8abqi8gKeN
	Y8CWNARFaguCNPcGVVQVzgiONfrDtPOsKh0Wp+wg7R+Rncjln/0bHcZyo+r1N4yTc7r24BFyzDq
	l2qZofA==
X-Received: from pfbea10.prod.google.com ([2002:a05:6a00:4c0a:b0:82c:70d1:f303])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:391e:b0:837:27f4:ffe5
 with SMTP id d2e1a72fcca58-8415f18266dmr2605287b3a.19.1779435969517; Fri, 22
 May 2026 00:46:09 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:56 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-6-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 05/11] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
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

We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVQ_CB
to adjust sk->sk_rcvlowat when

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

Let's provide a kfunc to set sk->sk_rcvlowat.

Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.

The wakeup flag is determined based on bpf_sock_ops_kern.skb:

  * For the enqueue hook, skb is always non-NULL, and wakeup is
    set to false because

    * tcp_data_ready() is always called after the hooks in
       tcp_queue_rcv() and tcp_ofo_queue().

    * when tcp_fastopen_add_skb() is called for TFO SYN,
       the socket is not yet accept()ed, and when called
       for TFO SYN+ACK, the socket is woken up by
       sk->sk_state_change() anyway.

  * For the recvmsg() hook, skb is always NULL, and wakeup is set
    to true because tcp_data_ready() is not called in the path.

An alternative would be to support bpf_setsockopt() by adding
BPF_SOCK_OPS_RCVQ_CB to is_locked_tcp_sock_ops().

However, that approach involves excessive conditionals and an
unnecessary memcpy(), costs we do not want to pay for every skb
in the TCP fast path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fa8a7c7d86eb..3608036632a8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12388,6 +12388,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops,
+					      int rcvlowat)
+{
+#ifdef CONFIG_INET
+	if (skops->op != BPF_SOCK_OPS_RCVQ_CB)
+		return -EOPNOTSUPP;
+
+	if (rcvlowat < 0)
+		rcvlowat = INT_MAX;
+
+	return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 					      u64 flags)
 {
@@ -12539,6 +12555,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_sock_ops_tcp_set_rcvlowat)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
-- 
2.54.0.746.g67dd491aae-goog

