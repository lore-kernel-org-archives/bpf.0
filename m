Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560916;
	b=YlxH343mpQpon2erQ0bzpl2J0nHpJWp1uvpsnvomP27nTfSbmolTnhTK5G4Da5yL5oXs
	 eadhxsTxxNTs0pDQbSGFpIdNP+WJi2mfOsDxrFlMwB78SMsP26/oYtCR6Vcv43HyEUXO4
	 Pg18foTD3r3OaOkWKWyg1U94+IECchMn4NpbOywB9EqFw/66ddSTLvaZpXiRKAx5H7uzB
	 qdM4IUiWdJbLKeGd3Frv1MlozQhNJLcp2C8Wl4R70Ucfj7a/miozqJ4a899paf/GtERGI
	 8lMwKc6iA1QjgRZ94mRFcwYNoKUgzNdDAfWGqUSV1uud5IE8nT/vmTjd/SRVU6qs1UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
	b=F7l973pTR41wc18i8/ruDa58DIR8pkM+c2Z2O+sXP3tFOsM6fqfJB9hSIdOJeHlxs7rp
	 7YKXQu9s+AtvOxRz0o72aRJfXPmMMwfztGP/7hFTmiVnz0ngSqE1TpPqs0P7yI3mTT/v2
	 qJJFZZOuwlj4H4F3sB1ii5hVL2YeVlwP3EB1UU56pwJq+HPsNgFLteLRnDTu9mCGKtyJo
	 9lWtAkoTy3SAMwLEv4qZNeYRGV71lwS+bjLKKD8cDDQErGJ6il2jlAdbJ+cZ1Z/cZxFOW
	 eQg75qv0slg4Zisqy7lbSoUPw+ZL6fVYe9dv6nImiC4YyOB0FeGDyV+Kmsm/+2OUHJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KGkdRIyO;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C97606A325
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C97606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KGkdRIyO
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1811186a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560916; x=1794165716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
        b=KGkdRIyOVTNIFEqxmnOgCEMdttl/Ya277iv4MbVxowwHC/nKur/m7RLM5g5l9a19AL
         3Et6EXzjS+h9hCj4WS8yDaaIaY7uzqjGgY2h0GdMxnH0MZ5Vz/vvloux4gGrFamqX4/X
         S//qLiiJjVvd6g5IXZ5CKMbJN3YqUMsU1DFUd7uzh5V0EZJNKnFTO3TJEcIpRNWx4Du/
         pRmTAxrQSJQ9Fuynbd31oFgZJLIFpnJ/JhoQJO2rl4tcAwFK2EXYBpd9+pVGEuFP3V6l
         GUHczH5p8hhCLYqAnZC9xWQVPWtZ2Iuu+x3fwKUmBTy4ouhVBT6g9LEEf7YxAm5WHVkK
         hgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560916; x=1794165716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
        b=yQ1sJYdZDCcnu4vyDJ/mVV5qWd5EuqmFjNC22kdSSD+LsQahG3E1wMI3brBEBHdtL+
         pGKb4uaOBYHpBg4FidSYuxtMsVerdE+n/kLE+rgbu8ZLokZiJIPhTKf/PmlnEN0rz/1H
         5pAyWFiGLAXAHoKYn/wA3B7523lJeQttB8VBW+RZrru1oDSbDfagbFH/pFZpkYWgO37A
         rSTnQPk+A2x2Vx3WrLkiRLHrp7iqs929NVGBYHLBYynyA3FrQwfNpqH2JQeYRq42moUs
         4cXySP5pvQXWu0ExvCsuyHxoV8WMapMMpejJX3GeNVhCrlGAVVTV5HeXcMqfIbBwQbOa
         V0gQ==
X-Gm-Message-State: APuU4Z8rD/yx08yg72GH70g2gFK79LQt4ayXyHFHxI8P5i1KQ2U9au0r
	GoTKegIW5QLe/Ws4kYGYgtLtYs/Yuiy74kyBUei0dzrQWumT1G0qguhBYyoo3w==
X-Gm-Gg: AYBFou1V5xgr44ZrjwmBohjHTGtKYmQQ7+TsCJ9B1z3j0Asebyovwd9oVygmtcZw3GT
	hQxRjXKfJGQJE/rHg5cVZV4ym9CmKWfh8E93mWtB+PrF2RVpyrpr5D0GipDxkhFtLP/pAbvXM5d
	DsmLbE/wab0WG74lUYBp9kaUF0+JA/HuCGP1vRfgW+4JHRGJoEOvIQd4i7RmhGIUTJqzOcv0ijh
	oRwNDh1U4j5SYHy6MdvbmkXQfk5btqfoYe5fqVDd1bVAR6+RsxEJ70i75v40/hTAsjKuu4T719F
	am0XLszsa5Dc0LTbSG9rN4l3vVyIVcs5oCPZwK8OEI5xZkUx7tXh/8kO9kLyIHNcWEVyvMG+RtT
	ZUbZbBbPO8ecctUZGlxSlj+c4dy80nEJxvFBoLq02lQa621xCk1nkN5k2lTU2gJ6euHuT/GwhxY
	59LQ2/HF36c9jDe7KalWikvKCSoy42xt+WPKHM2m6UNe+VJaFMQLk+A6W/renz0C89cS24OH5G4
	blKFnZYwX4MWyc/W9SKm0vY+I09i8x3+lmTh5e+WalCqJl1s3gCmL6FaNVh7k4kBjIFCbebPnT6
	T7ljSVd73oWTqKPKS1ecSTgzJjAMi7dgwyjZRHlTZT9DB7ZuOux8uTcsSZHnDAtKJ5ONxSaBZvN
	/VtEucjnc0Zx/LZnTky2/upti+VP3C8TuVxvrZrQbExDWXUfPxLqeSHpIgmN4ykfXT9mASx2QKg
	==
X-Received: by 2002:a17:90b:2641:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ae8974b804mr6354294a91.31.1793560915674;
        Sun, 01 Nov 2026 11:21:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm6851876a91.4.2026.11.01.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 09/15] bpf, sockmap: Check the TCP state in recvmsg()
Date: Sun,  1 Nov 2026 19:20:51 +0000
Message-ID: <20261101192057.2296489-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

With an sk_skb verdict prog, tcp_bpf_recvmsg_parser() copies data from the
psock. Then it calls __tcp_cleanup_rbuf() to calculate the receive window
and to send an ACK. The window and the ACK need a connection on the socket.
But tcp_disconnect() keeps the socket in the sockmap and the data on the
psock. For a TCP socket sock_map_redirect_allowed() rejects only
TCP_LISTEN. Thus the psock can also get data after tcp_disconnect().

__tcp_select_window() divides by icsk_ack.rcv_mss, which can be 0 in
TCP_CLOSE. In TCP_SYN_SENT the new peer can get an ACK with the sequence
numbers of the old connection.

Call __tcp_cleanup_rbuf() only when tcp_can_send_ack() returns true.
recvmsg() returns the data as before. Move tcp_can_send_ack() from MPTCP to
tcp.h. It also returns false for a fastopen child in TCP_SYN_RECV. From its
peer the child has only the SYN data, and the SYN-ACK acknowledges it.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/net/tcp.h    | 6 ++++++
 net/ipv4/tcp_bpf.c   | 3 ++-
 net/mptcp/protocol.c | 6 ------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf821..23a22d70718e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1845,6 +1845,12 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
 void __tcp_cleanup_rbuf(struct sock *sk, int copied);
 
+/* Is the socket in a state in which TCP may send an ACK? */
+static inline bool tcp_can_send_ack(const struct sock *sk)
+{
+	return !((1 << inet_sk_state_load(sk)) &
+	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
+}
 
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
  * If 87.5 % (7/8) of the space has been consumed, we want to override
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b635d3ebf4fb..9848c8e5a2cd 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -343,7 +343,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	if (!peek)
 		WRITE_ONCE(tcp->copied_seq, seq);
 	tcp_rcv_space_adjust(sk);
-	if (copied > 0)
+	/* Data on the psock outlives the connection that it came in on */
+	if (copied > 0 && tcp_can_send_ack(sk))
 		__tcp_cleanup_rbuf(sk, copied);
 
 unlock:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..d62cfbf2d490 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -619,12 +619,6 @@ static void mptcp_set_timeout(struct sock *sk)
 	__mptcp_set_timeout(sk, tout);
 }
 
-static inline bool tcp_can_send_ack(const struct sock *ssk)
-{
-	return !((1 << inet_sk_state_load(ssk)) &
-	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
-}
-
 void __mptcp_subflow_send_ack(struct sock *ssk)
 {
 	if (tcp_can_send_ack(ssk))
-- 
2.55.0

