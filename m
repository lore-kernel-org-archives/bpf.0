Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A143242A4
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029808; cv=none; b=eRbp1oU0NfQU+T2a1HzjKqMbBe+e6fbYMTRphvbduvZvf1dRXrHS3zOaadQrYWa94gTgS/e3rIah+hl6DEIXSrtpSqte2cjebX5XsUjwTBUVSgeoAWccjHgYaSpoiFRH9Uxy1yBWkF/khpMqa5rHimkQzUaDiSGB/wJh1eUGV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029808; c=relaxed/simple;
	bh=Rycoo0KXcrIGy0V6K13A51qgqDSsTtrcvUpgWndy/lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0QXqMjdAEiLIqLduYGWIwZrRUy+CVP75QV8ttJ2dlf8zoAOUVil6eTehHn3hXRVRgU0rVDdb4tjEuh5rUxH/zZP2T0eOUwrIt5nNCLgqYK3w0jBbNEdmkLpTjo5Aw/GxRDQ3WXhh84viTvj1SBMhdxHPivPNfBNDVqnSV8Ai1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THJx1t0p; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THJx1t0p"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-366330b6751so1164332a91.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029804; x=1779634604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv623DRABOPMrYJwnAldTbL6HQ8FVgC1eRszl+kDjzM=;
        b=THJx1t0podhPnwZ32/8k+6Ifwo91Z+re8AJJdoO2aYIbsleN7lHBq1jPygdWLDO/JK
         /IZzCBnXbE3AFGezoERPoqbBZRQekvcBhSw5Jj4vwxvjSa+p93oDWtvuS6sL4ustWkzz
         aTVTkSgBXKJn/94g+79SRoqUdkL+e9JnEM6iGCfZz11dOv1WR37CRvynH3IpFmjZ4v8f
         hvnPyYzhVUPIUr+XiAd+1D3jKvAnX0crVWY1UWsWinCQLV0v+lOhhTWMoDaWb8bBSiqb
         dSB126Le+kDaGv/xtG0U7aeFNZ9SKtA/7Rl9TmAZOjkAeL1c2kzAYCvVSbAIcpQyPfen
         jgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029804; x=1779634604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cv623DRABOPMrYJwnAldTbL6HQ8FVgC1eRszl+kDjzM=;
        b=hYckbfmKS0d/U0L2rKLfACh7mxeyN7qnZg+w3L936/VJKBCYaBvXQMTWTNqhOC3Ykt
         SGUbxAVSeuXJWjolAsYgaOmA/vblKR9V8oTLIeW2iJZWhfY7js2nH1RHRgYI9tuT0xia
         2hgHjmxDbx1UvzlSBAaAIx273JcMZqQqVVfSgEAn73ZTUM5Bie4geU/GL3X1dG5aSRgT
         04f6Ug0eeG4RUqWu2QCcqfOJdFk3zrPtfc3j8Va13briWpnnK3YIrzUC4NIHuFK5bgSg
         9dksGbcrTazjiu+trJqj5PdSxry9Nzkaoo/D0EPSHHx2uNK9/InkOrMLwOQ93M5CHtkO
         3EDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Jg96nVq4JuW+UJbDEUe0pCxtpui5ivLbSW3qgdGG61HRirhZdRNJibtRgsN0iEZniAQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkN3XWQV6uedwV3kxb07yXw18Jcpu4n5RFdRB9kNgMWIm+xV9o
	EdiVEbyp2xEPACx/gSI8jQhcp3/Yd2ChJELVuRUAaSIRyRK+eMggMNCx
X-Gm-Gg: Acq92OFOHwi+71CDflSGYechyWtTTQ8+X04akJECyyTG59Ftbik4RWIUz4KEMcPimpM
	dCfeYvfHt8jkZ3bi1i+Eno96dMpNQRH5EQT60CK69ECl3L6a3TAAjB5m9QkyuSXVrmTNXUHc8Kb
	uwWxYdOHTc2e8scHJRGiz4bZ1TXyPb3XwgxjRS10SQUdsovS09FcdooZoEiZE9BvTatcQvnmIld
	fUESdRNyzlPU9okCcANnBVKyP0kW+e+zaCGw5QMqoFveQ6lseUuhBaxn08OEC5KtRR0+eJ0xOTk
	zb7P+nkQrSJCpRD+kABLR/HkW84hywv87AhxYuXIkRGuq5kFsiYDehLqEWhLOQKxpVbcYXf3Ce6
	sO/qEHFr96qNOD3Wthqrx91zzzfMyVPeg00sPTTUpVa6bG6XU0J2yBU/V460jRivkrqO10QGTD4
	bAwhXbpu2o6yjoetW/PQ7Ztgi51CqVozpajfYNnLwtnVItTQ==
X-Received: by 2002:a17:90b:5904:b0:369:1dcf:4a56 with SMTP id 98e67ed59e1d1-36951ca8d1amr11826037a91.21.1779029804514;
        Sun, 17 May 2026 07:56:44 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm10392522a12.21.2026.05.17.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:56:44 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	mrpre@163.com
Cc: jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v5 1/2] bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
Date: Sun, 17 May 2026 23:56:26 +0900
Message-ID: <20260517145630.20521-2-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
References: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_psock_strp_data_ready() already checks tls_sw_has_ctx_rx() and
defers to psock->saved_data_ready when a TLS RX context is present,
avoiding a conflict with the TLS strparser's ownership of the receive
queue (commit e91de6afa81c, "bpf: Fix running sk_skb program types
with ktls").

sk_psock_verdict_data_ready() has no equivalent guard.  When a socket
is inserted into a sockmap (BPF_SK_SKB_VERDICT) before TLS RX is
configured, tls_sw_strparser_arm() saves sk_psock_verdict_data_ready
as rx_ctx->saved_data_ready.  On data arrival:

  tls_data_ready -> tls_strp_data_ready -> tls_rx_msg_ready
    -> saved_data_ready() = sk_psock_verdict_data_ready()
      -> tcp_read_skb() drains sk_receive_queue via __skb_unlink()
         without calling tcp_eat_skb(), so copied_seq is not advanced.

tls_strp_msg_load() then finds tcp_inq() >= full_len (stale), calls
tcp_recv_skb() on the now-empty queue, hits WARN_ON_ONCE(!first), and
returns with rx_ctx->strp.anchor.frag_list pointing at a psock-owned
(potentially freed) skb.  tls_decrypt_sg() subsequently walks that
frag_list: use-after-free.

Apply the same fix as sk_psock_strp_data_ready(): if a TLS RX context
is present, call psock->saved_data_ready (sock_def_readable) to wake
recv() waiters and return immediately, leaving the receive queue
untouched.  TLS retains sole ownership of the queue and decrypts the
record normally through tls_sw_recvmsg().

Signed-off-by: Xingwang Xiang <v3rdant.xiang@gmail.com>
---
 net/core/skmsg.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6187a83bd..e1850caf1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1268,12 +1268,19 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
 	const struct proto_ops *ops = NULL;
+	struct sk_psock *psock;
 	struct socket *sock;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
 	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (psock && tls_sw_has_ctx_rx(sk)) {
+		psock->saved_data_ready(sk);
+		rcu_read_unlock();
+		return;
+	}
 	sock = READ_ONCE(sk->sk_socket);
 	if (likely(sock))
 		ops = READ_ONCE(sock->ops);
@@ -1283,8 +1290,6 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
-		struct sk_psock *psock;
-
 		rcu_read_lock();
 		psock = sk_psock(sk);
 		if (psock)
