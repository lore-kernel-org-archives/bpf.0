Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9813F9F45
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887957; cv=none; b=cis4BvHAO96aCLwgfbV8ABHUQseSSeRMtt3/eKDV24SO9ZfqOZMXojprOJCnbrZCSqNFFfmhZl9ilofNS2iSmRoUteLPEMQk4IH/glHjc5MFi1bksidYCHgYHqzWtHJ0H5YjsRKuEYBFyOHHeALlPn6HwpqnIyLuRPUJfmfZV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887957; c=relaxed/simple;
	bh=rdxX9JWiJCz56g3RXrIsC57x7SZkT34oPjrdRMZCo8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdLTo/DfmqbGXXECdOcuDbfJsx7Z/9bW8VcTbf6/fqxqI8QEAEqwlFRkQP5PUf3cIZdSZxglVfv+yFTRJ8HfJZGxvlPvlq0OmXK+rLYetfiwUZ5FPBfx6hcWPUwVpN6ZZu6230SMAPRKMInO1I7OR9Lmtwj5MIF6/H8zH0BMJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VdmdlkiV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VdmdlkiV"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c34bff61551so307218366b.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791887951; x=1792492751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyKvG/UsN9GvqpGc7SZmiuGWM6lyPp30SlFVhoegAfI=;
        b=VdmdlkiVguHphn2VfNrO2Ks53q4oL+ZOo02xPSaOZaqjOqsVKIhawuwNPoE0eZFCot
         4luJb352x7oRsfrInWh3Yiv79ngHCCXQWqfNAcgvWyG54TNgECqLIY/MR+7a6wIwTA0S
         gtUvi4WViIYpwPYTIBkKsGd0/bwtm0473Z1tl0seXgwGy8v6/j+IWu1/jaYcIzCMhAwd
         hsZKJGW96LeMKDQqYtlI0Lzul7QEHJwIJCGgwIS9kDfwpG4EdUbhoaVUMKo/Ie5w/63v
         SL7tJ/m2Vr5CF766BUpBBnf5JLzx7S/Xmq9aWAMQc2uHopncSmly9smTdR4+lEbQVzTx
         p2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887951; x=1792492751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WyKvG/UsN9GvqpGc7SZmiuGWM6lyPp30SlFVhoegAfI=;
        b=JXempHdCAA0LCoG9acaIl5XWbfiXnZl/WCnSVKPrpXAtnwNS4O8ulYy8EI6TPuNeBp
         MOS8VIR6KKRzsoMSNuQ+cWP66A7hmBlL+XJ+wT+cEXRMANGwhRu490XATLiwVuRTA1Y7
         bkrIbPcWlK29nw/zT1mIF3BwbFTOuzGjFiA8wyWYd4TZMbwXd4Y1eyK0s9khsXQQvu6U
         yusJqXlMIZcnii05ZdMNtJYMIIh21/GcgBnBJUvMEVOQRRxWMbs6BHKenQ2fbC+O2m/j
         0Z7yVRHL77CM8FmwPcJ18MSzInnv+QKjqBWNe2CFgRSfLIcSj7UKpoieI5ZoEI8yadH2
         XcZA==
X-Forwarded-Encrypted: i=1; AKwUvBydkARAnAtgiKb13PY4P7oDKM1mCA63ptV+W8r6+8SsuNJ0GFm1UqK2DrDM1bMBAfBOb2w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIve+8QxGAilblWcPMdKhYIW/1JiEKfquAVz8M46mU3JTZI5WKu
	bIGgIp9Vk5mC9Dvl59WHvsjaxBQ5prXrSe8w9L4SjdxAXJ9Uc7hbryIXrOtI9HYDpL0=
X-Gm-Gg: AYBFou1GJcgWjQ5NqrkaVgGfO9wMEpp+rw4s/igwNI5skXrcdhY969a7EfDEfWN24I8
	itsrexbyzdKEv1zf0IGDej/T+2vLIy5jM4ORMw20Er5w/VlblhK4OV5dtpNwvOmZK0bk7+g0mwq
	O7E/lvmYzMuIYoGUWSCwWZUoz8vE/RflxXImRDZs3z+oZxVGs5JkUuNbeQoFh5XoEh5UEPTW/qo
	MTQ3VCwQTMW+JVcCbEFD8YFIq59qtbIZYD/y25fq8yAZ5jbirHWDXfpIYZrneqagi23x2zr2GTc
	olmyjlkYwK+MSklRtAIQRvX150Q9g73dFh10izX0PPnu5bF84FAFVsOHPHHJwZIvfx6GRqKyaty
	G6GQyj7VNqjYQaWV5ho2CxaIzlY3sFj2rJVq31trNAuiCkL6HLe5ZrzPwbA7VJGlnj9dygj+ZsZ
	OFqcz/UcIu1ZmYuHaX3yfnfoezYJa157QtUU0Nvy2qGmTQd9L3dPhR+WGoWKCL/z02MCzxkkiF5
	L8MpzIiKyGq71hmvyeuovgCaktmpv9nehxX
X-Received: by 2002:a17:907:3eaa:b0:c2b:4142:2db1 with SMTP id a640c23a62f3a-c31aa0d82b6mr1290703466b.40.1791887951171;
        Tue, 13 Oct 2026 03:39:11 -0700 (PDT)
Received: from 8951987238ab.arnhem.chello.nl ([104.28.187.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac62a7sm552462166b.63.2026.10.13.03.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:39:10 -0700 (PDT)
From: Willem Ferguson <wferguson@cloudflare.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ncardwell@google.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [RFC PATCH net-next 1/4] tcp: add plumbing to carry an identifier in TSval low bits
Date: Tue, 13 Oct 2026 10:39:03 +0000
Message-ID: <20261013103906.2660384-2-wferguson@cloudflare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013103906.2660384-1-wferguson@cloudflare.com>
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add per-connection state that lets the low bits of locally generated
TSvals carry a small identifier, and teach the receive side to strip it
from echoed TSecr values:

 - tcp_request_sock, tcp_sock and tcp_timewait_sock gain ts_id and
   ts_id_bits. They are copied from the request socket to the child and
   from the child to the timewait socket, and cleared on every path that
   creates a request socket without going through tcp_openreq_init()
   (SYN cookies and bpf_sk_assign_tcp_reqsk()).

 - tcp_tsval_encode() shifts the timestamp clock left by ts_id_bits and
   ORs in ts_id. It is used for SYN-ACK, established, request socket and
   timewait TSvals. The SYN-ACK path keeps the identifier when it
   replaces a zero TSval with ~0U.

 - tcp_tsecr_decode() undoes the encoding. The shift drops ts_id_bits of
   clock range, so the decoded echo is re-centred on the current clock
   with sign_extend32() before RTT estimation and PAWS consume it.

A BUILD_BUG_ON() checks that, at the widest identifier allowed, an
encoded TSval cannot advance by 2^31 within TCP_PAWS_WRAP, the idle
period after which Linux stops enforcing PAWS against ts_recent.

Nothing sets ts_id_bits yet, so this patch does not change behaviour.
With ts_id_bits == 0, tcp_tsval_encode() returns its input and the
established receive path adds a single likely() branch before the
existing tsoffset subtraction.

Signed-off-by: Willem Ferguson <wferguson@cloudflare.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  2 +
 include/linux/tcp.h                           |  8 +++
 include/net/tcp.h                             | 50 ++++++++++++++++++-
 net/core/filter.c                             |  2 +
 net/ipv4/syncookies.c                         |  2 +
 net/ipv4/tcp.c                                | 13 +++++
 net/ipv4/tcp_input.c                          | 11 ++--
 net/ipv4/tcp_minisocks.c                      | 18 ++++++-
 net/ipv4/tcp_output.c                         | 15 ++++--
 9 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 103328dc409e..91a00194ad3a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -32,6 +32,8 @@ u32                           lsndtime                read_write
 u32                           last_oow_ack_time
 u32                           compressed_ack_rcv_nxt
 u32                           tsoffset                read_mostly         read_mostly         tcp_established_options(tx);tcp_fast_parse_options(rx)
+u8                            ts_id                   read_mostly         read_mostly         tcp_established_options(tx);tcp_fast_parse_options(rx)
+u8                            ts_id_bits              read_mostly         read_mostly         tcp_established_options(tx);tcp_fast_parse_options(rx)
 struct list_head              tsq_node
 struct list_head              tsorted_sent_queue      read_write                              tcp_update_skb_after_send
 u32                           snd_wl1                                     read_mostly         tcp_may_update_window
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e4d1720f49f0..6de7ace4b016 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -145,6 +145,8 @@ static inline void tcp_clear_options(struct tcp_options_received *rx_opt)
  * only four options will fit in a standard TCP header */
 #define TCP_NUM_SACKS 4
 
+#define TCP_TS_ID_BITS_MAX	8
+
 struct tcp_request_sock_ops;
 
 struct tcp_request_sock {
@@ -154,6 +156,8 @@ struct tcp_request_sock {
 	bool				tfo_listener;
 	bool				is_mptcp;
 	bool				req_usec_ts;
+	u8				ts_id;
+	u8				ts_id_bits;
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool				drop_req;
 #endif
@@ -220,6 +224,8 @@ struct tcp_sock {
 	/* TXRX read-mostly hotpath cache lines */
 	__cacheline_group_begin(tcp_sock_read_txrx);
 	u32	tsoffset;	/* timestamp offset */
+	u8	ts_id;		/* identifier encoded in TSval low bits */
+	u8	ts_id_bits;	/* number of identifier bits in TSval */
 	u32	snd_wnd;	/* The window we expect to receive	*/
 	u32	mss_cache;	/* Cached effective mss, not including SACKS */
 	u32	snd_cwnd;	/* Sending congestion window		*/
@@ -575,6 +581,8 @@ struct tcp_timewait_sock {
 	u32			  tw_rcv_wnd;
 	u32			  tw_ts_offset;
 	u32			  tw_ts_recent;
+	u8			  tw_ts_id;
+	u8			  tw_ts_id_bits;
 
 	/* The time we sent the last out-of-window ACK: */
 	u32			  tw_last_oow_ack_time;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0265c27a5fd7..85d3038f41af 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1074,14 +1074,60 @@ static inline u32 tcp_skb_timestamp_ts(bool usec_ts, const struct sk_buff *skb)
 	return div_u64(skb->skb_mstamp_ns, NSEC_PER_MSEC);
 }
 
+static inline u32 tcp_ts_id_mask(u8 ts_id_bits)
+{
+	return BIT(ts_id_bits) - 1;
+}
+
+static inline u32 tcp_ts_clock_mask(u8 ts_id_bits)
+{
+	return U32_MAX >> ts_id_bits;
+}
+
+static inline u32 tcp_tsval_encode(u32 tsval, u8 ts_id, u8 ts_id_bits)
+{
+	if (!ts_id_bits)
+		return tsval;
+
+	return ((tsval & tcp_ts_clock_mask(ts_id_bits)) << ts_id_bits) |
+	       ts_id;
+}
+
+static inline u32 tcp_tsecr_decode(u32 tsecr, u32 tsoffset, u8 ts_id_bits,
+				   u32 now)
+{
+	if (!ts_id_bits)
+		return tsecr - tsoffset;
+
+	tsecr = ((tsecr >> ts_id_bits) - tsoffset) &
+		tcp_ts_clock_mask(ts_id_bits);
+
+	return now + sign_extend32(tsecr - now, 31 - ts_id_bits);
+}
+
+/* Keeps the timestamp clock read behind the branch: it is only needed to
+ * re-center an echo that was truncated to make room for an identifier.
+ */
+static inline u32 tcp_tsecr_decode_tp(u32 tsecr, const struct tcp_sock *tp)
+{
+	if (likely(!tp->ts_id_bits))
+		return tsecr - tp->tsoffset;
+
+	return tcp_tsecr_decode(tsecr, tp->tsoffset, tp->ts_id_bits,
+				tcp_time_stamp_ts(tp));
+}
+
 static inline u32 tcp_tw_tsval(const struct tcp_timewait_sock *tcptw)
 {
-	return tcp_clock_ts(tcptw->tw_sk.tw_usec_ts) + tcptw->tw_ts_offset;
+	return tcp_tsval_encode(tcp_clock_ts(tcptw->tw_sk.tw_usec_ts) +
+				tcptw->tw_ts_offset, tcptw->tw_ts_id,
+				tcptw->tw_ts_id_bits);
 }
 
 static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 {
-	return tcp_clock_ts(treq->req_usec_ts) + treq->ts_off;
+	return tcp_tsval_encode(tcp_clock_ts(treq->req_usec_ts) + treq->ts_off,
+				treq->ts_id, treq->ts_id_bits);
 }
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..a0a74c7e2e3d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12579,6 +12579,8 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 
 	treq->req_usec_ts = !!attrs->usec_ts_ok;
 	treq->ts_off = tsoff;
+	treq->ts_id = 0;
+	treq->ts_id_bits = 0;
 
 	skb_orphan(skb);
 	skb->sk = req_to_sk(req);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e129768184..f0d164846a5d 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -280,6 +280,8 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->snt_synack = 0;
 	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
+	treq->ts_id = 0;
+	treq->ts_id_bits = 0;
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
 	/* The request socket was freed after the SYN-ACK; use the cookie
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f4c9101e5996..af994edde7f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -462,6 +462,8 @@ void tcp_init_sock(struct sock *sk)
 	tcp_assign_congestion_control(sk);
 
 	tp->tsoffset = 0;
+	tp->ts_id = 0;
+	tp->ts_id_bits = 0;
 	tp->rack.reo_wnd_steps = 1;
 
 	sk->sk_write_space = sk_stream_write_space;
@@ -3429,6 +3431,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tp->ts_id = 0;
+	tp->ts_id_bits = 0;
 	tp->accecn_fail_mode = 0;
 	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
@@ -5212,6 +5216,8 @@ static void __init tcp_struct_check(void)
 
 	/* TXRX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, tsoffset);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, ts_id);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, ts_id_bits);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, snd_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, mss_cache);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, snd_cwnd);
@@ -5302,6 +5308,13 @@ void __init tcp_init(void)
 	BUILD_BUG_ON(sizeof(struct tcp_skb_cb) >
 		     sizeof_field(struct sk_buff, cb));
 
+	/* An encoded TSval must not advance by 2^31 within the window that
+	 * Linux PAWS keeps ts_recent valid; peers using RFC 7323's 24 day
+	 * window are not covered (see tcp_ts_id_bits in ip-sysctl.rst).
+	 */
+	BUILD_BUG_ON(((u64)TCP_PAWS_WRAP * MSEC_PER_SEC) <<
+		     TCP_TS_ID_BITS_MAX >= (1ULL << 31));
+
 	tcp_struct_check();
 
 	percpu_counter_init(&tcp_sockets_allocated, 0, GFP_KERNEL);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1ddce9c4b7e8..68af0283742e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4717,7 +4717,8 @@ static bool tcp_parse_aligned_timestamp(struct tcp_sock *tp, const struct tcphdr
 		tp->rx_opt.rcv_tsval = ntohl(*ptr);
 		++ptr;
 		if (*ptr)
-			tp->rx_opt.rcv_tsecr = ntohl(*ptr) - tp->tsoffset;
+			tp->rx_opt.rcv_tsecr = tcp_tsecr_decode_tp(ntohl(*ptr),
+								   tp);
 		else
 			tp->rx_opt.rcv_tsecr = 0;
 		return true;
@@ -4749,7 +4750,8 @@ static bool tcp_fast_parse_options(const struct net *net,
 
 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
-		tp->rx_opt.rcv_tsecr -= tp->tsoffset;
+		tp->rx_opt.rcv_tsecr =
+			tcp_tsecr_decode_tp(tp->rx_opt.rcv_tsecr, tp);
 
 	return true;
 }
@@ -6881,7 +6883,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 	tcp_parse_options(sock_net(sk), skb, &tp->rx_opt, 0, &foc);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
-		tp->rx_opt.rcv_tsecr -= tp->tsoffset;
+		tp->rx_opt.rcv_tsecr =
+			tcp_tsecr_decode_tp(tp->rx_opt.rcv_tsecr, tp);
 
 	if (th->ack) {
 		/* rfc793:
@@ -7512,6 +7515,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->rcv_nxt = TCP_SKB_CB(skb)->seq + 1;
 	tcp_rsk(req)->snt_synack = 0;
 	tcp_rsk(req)->snt_tsval_first = 0;
+	tcp_rsk(req)->ts_id = 0;
+	tcp_rsk(req)->ts_id_bits = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
 	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0ddfd5af6e58..43580b395bff 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -122,7 +122,11 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 
 		if (tmp_opt.saw_tstamp) {
 			if (tmp_opt.rcv_tsecr)
-				tmp_opt.rcv_tsecr -= tcptw->tw_ts_offset;
+				tmp_opt.rcv_tsecr =
+					tcp_tsecr_decode(tmp_opt.rcv_tsecr,
+							 tcptw->tw_ts_offset,
+							 tcptw->tw_ts_id_bits,
+							 tcp_clock_ts(tw->tw_usec_ts));
 			tmp_opt.ts_recent	= READ_ONCE(tcptw->tw_ts_recent);
 			tmp_opt.ts_recent_stamp	= ts_recent_stamp;
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
@@ -347,6 +351,8 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		tcptw->tw_ts_recent	= tp->rx_opt.ts_recent;
 		tcptw->tw_ts_recent_stamp = tp->rx_opt.ts_recent_stamp;
 		tcptw->tw_ts_offset	= tp->tsoffset;
+		tcptw->tw_ts_id		= tp->ts_id;
+		tcptw->tw_ts_id_bits	= tp->ts_id_bits;
 		tw->tw_usec_ts		= tp->tcp_usec_ts;
 		tcptw->tw_last_oow_ack_time = 0;
 		tcptw->tw_tx_delay	= tp->tcp_tx_delay;
@@ -639,6 +645,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 		newtp->total_rto_recoveries = 1;
 	}
 	newtp->tsoffset = treq->ts_off;
+	newtp->ts_id = treq->ts_id;
+	newtp->ts_id_bits = treq->ts_id_bits;
 #ifdef CONFIG_TCP_MD5SIG
 	newtp->md5sig_info = NULL;	/*XXX*/
 #endif
@@ -705,11 +713,17 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		if (tmp_opt.saw_tstamp) {
 			tmp_opt.ts_recent = req->ts_recent;
 			if (tmp_opt.rcv_tsecr) {
+				u32 now = tcp_clock_ts(tcp_rsk(req)->req_usec_ts);
+
 				if (inet_rsk(req)->tstamp_ok && !fastopen)
 					tsecr_reject = !between(tmp_opt.rcv_tsecr,
 							tcp_rsk(req)->snt_tsval_first,
 							READ_ONCE(tcp_rsk(req)->snt_tsval_last));
-				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
+				tmp_opt.rcv_tsecr =
+					tcp_tsecr_decode(tmp_opt.rcv_tsecr,
+							 tcp_rsk(req)->ts_off,
+							 tcp_rsk(req)->ts_id_bits,
+							 now);
 			}
 			/* We do not store true stamp, but it is not required,
 			 * it can be estimated (approximately)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c8865205cdc8..966adebc9154 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1101,11 +1101,15 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp_ts(tcp_rsk(req)->req_usec_ts, skb) +
 			      tcp_rsk(req)->ts_off;
-		if (!tcp_rsk(req)->snt_tsval_first) {
-			if (!opts->tsval)
-				opts->tsval = ~0U;
+		opts->tsval = tcp_tsval_encode(opts->tsval,
+					       tcp_rsk(req)->ts_id,
+					       tcp_rsk(req)->ts_id_bits);
+		if (!tcp_rsk(req)->snt_tsval_first && !opts->tsval)
+			opts->tsval = tcp_tsval_encode(~0U,
+						       tcp_rsk(req)->ts_id,
+						       tcp_rsk(req)->ts_id_bits);
+		if (!tcp_rsk(req)->snt_tsval_first)
 			tcp_rsk(req)->snt_tsval_first = opts->tsval;
-		}
 		WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
 		opts->tsecr = req->ts_recent;
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
@@ -1171,6 +1175,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->options |= OPTION_TS;
 		opts->tsval = skb ? tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) +
 				tp->tsoffset : 0;
+		if (skb)
+			opts->tsval = tcp_tsval_encode(opts->tsval, tp->ts_id,
+						       tp->ts_id_bits);
 		opts->tsecr = tp->rx_opt.ts_recent;
 		size += TCPOLEN_TSTAMP_ALIGNED;
 	}
-- 
2.47.3

