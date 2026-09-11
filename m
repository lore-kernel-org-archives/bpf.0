Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854746A607
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117836; cv=none; b=G5moexaC+wIEaIbBbAZmvjuWrV4yqSsaUsYcZHAGRjwPBXKsrU7/TUgYYh3DC5Fhn7SIDiD1/WwChusRt5gnYpH2SQUvEan5NXr/0Ya93FOchlFYqZ7fF/pR2Gnr/kxFU7oDbrKH7uCY9BjWxM5bIOxru9B3I2XkXL+gikITOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117836; c=relaxed/simple;
	bh=hUQFcz2KnN3N9q1dT4oEejz+cWXeAp9wvitorKdCeck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=WwNirPAQlTc4y4Gy96q/P1HFVNRR6npAElcd5sAs4hs9jI18sdHbuY6UvPrHuLvuwcjEzDQxILCaYDUKaQOe2HuebYOFabkbAE6YUApwtpnZcp74hFHP3QyMDZbk2ME0cP1jo33jld3jZKqli3+mzC6W5y7zFhyri8b+fdHeLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pe2O+VUD; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pe2O+VUD"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260911091028epoutp03e674056cbf9d3cbe13960e10098b0d2f~UOS_aPap12705827058epoutp03L
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:10:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260911091028epoutp03e674056cbf9d3cbe13960e10098b0d2f~UOS_aPap12705827058epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789117828;
	bh=MOn3XWdY1AJT+FOl4ChAg5gAv0neVX4cbQq7KTwQdDA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pe2O+VUDApt3KeOlmzHKo9cND86NKQ9kE0ID5W5PbHPKq8/UFUYFqV3tZRjNcYo80
	 ilKa1c97ip9OcZMcirO9pxrYdB4E6ZJlmpe3eDObZs8WWONAApgtnh+2qkhLWlJ9+V
	 e7bH57+Kqna9i9S4GPBozEeeoDYXXJsBpCJM87LA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260911091027epcas5p25be1c1d591e25f5fec08000aedcd46e7~UOS9zuxHv2016820168epcas5p23;
	Fri, 11 Sep 2026 09:10:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hh8031gp3z2SSKb; Fri, 11 Sep
	2026 09:10:27 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260911091026epcas5p35873551b66ec0a50e20ada6e26d2b056~UOS8fBQm22955729557epcas5p3U;
	Fri, 11 Sep 2026 09:10:26 +0000 (GMT)
Received: from ws2030076956.sa.corp.samsungelectronics.net (unknown
	[107.99.235.31]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260911091023epsmtip12391330ac53a883f631a2573b70abad2~UOS5vI-8t1549715497epsmtip1C;
	Fri, 11 Sep 2026 09:10:23 +0000 (GMT)
From: Irlanki Sandeep <irlanki.s@samsung.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ncardwell@google.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org, lorenzo@google.com, maze@google.com,
	sporeba@google.com, motomuman@google.com, srihari.k@samsung.com,
	g.pokhra@samsung.com, r.kumawat@samsung.com, raj.kumars@samsung.com,
	ts413.lee@samsung.com, Irlanki Sandeep <irlanki.s@samsung.com>
Subject: [PATCH net-next v3] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Date: Fri, 11 Sep 2026 14:41:48 +0530
Message-Id: <20260911091148.456834-1-irlanki.s@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260911091026epcas5p35873551b66ec0a50e20ada6e26d2b056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260911091026epcas5p35873551b66ec0a50e20ada6e26d2b056
References: <CGME20260911091026epcas5p35873551b66ec0a50e20ada6e26d2b056@epcas5p3.samsung.com>

Currently, ECN and Accurate ECN (AccECN) configurations in the Linux
kernel are controlled globally via the net.ipv4.tcp_ecn and
net.ipv4.tcp_ecn_option sysctl variables. This global approach lacks the
granularity required for modern multi-application runtimes.

In diverse network environments (such as mobile operating systems like
Android), different applications route their traffic over distinct
physical and virtual interfaces (cellular, Wi-Fi, VPNs, etc.). In the
wild, certain legacy network paths or misconfigured middleboxes (such as
routers, DPIs, or firewalls) are known to blackhole packets with ECN
negotiation flags in the SYN, or silently drop packets containing AccECN
option headers during active sessions.

If ECN or AccECN options are disabled globally to prevent connection
failures on a single broken path, the system loses the low-latency and
throughput benefits of L4S across all other compliant network paths.
Conversely, if enabled globally, connections on broken paths will suffer
severe packet loss and timeout regressions.

Introduce two new TCP socket options to enable granular, per-connection
dynamic adaptation based on runtime network metrics and diagnostics:

1. TCP_ECN: Exposes per-socket configuration of ECN negotiation modes
   (0-5, corresponding to existing sysctl modes, or 255/UNSPEC to
   revert to the global sysctl default). This allows an application or
   framework to selectively disable ECN negotiation on sockets where
   path anomalies are detected.
2. TCP_ECN_OPTION: Exposes per-socket control of AccECN option sending
   frequency (0-3, or 255/UNSPEC to revert to the global sysctl default).
   This allows disabling the option headers on active sockets if
   middlebox dropping behavior is observed after session establishment.

Provide helper functions tcp_ecn_mode_eff() and tcp_accecn_option_eff()
to dynamically evaluate per-socket overrides with transparent fallback
to system sysctl defaults. Also expose these options via BPF sockops
and update documentation and BPF selftests accordingly.

Signed-off-by: Irlanki Sandeep <irlanki.s@samsung.com>
---
v2 -> v3:
 - Use READ_ONCE() when reading ecn_mode and ecn_option in tcp_ecn_mode_eff()
   and tcp_accecn_option_eff() to prevent compiler double-fetches (sashiko-bot).
 - Move cookie_ecn_ok() to include/net/tcp_ecn.h and update syncookies verification
   to respect the listener socket's effective ECN configuration instead of the
   global sysctl (sashiko-bot).
v1 -> v2:
 - Remove unused variable 'net' in tcp_ecn_create_request() reported
   by kernel test robot.

 Documentation/networking/ip-sysctl.rst        | 37 +++++++++++++++++++
 include/linux/tcp.h                           |  7 ++++
 include/net/tcp.h                             |  6 ---
 include/net/tcp_ecn.h                         | 31 +++++++++++++++-
 include/uapi/linux/bpf.h                      |  3 +-
 include/uapi/linux/tcp.h                      |  2 +
 net/core/filter.c                             |  2 +
 net/ipv4/syncookies.c                         |  2 +-
 net/ipv4/tcp.c                                | 22 +++++++++++
 net/ipv4/tcp_input.c                          |  5 +--
 net/ipv4/tcp_output.c                         |  6 +--
 net/ipv6/syncookies.c                         |  2 +-
 tools/include/uapi/linux/bpf.h                |  3 +-
 tools/include/uapi/linux/tcp.h                |  3 +-
 .../selftests/bpf/progs/setget_sockopt.c      |  2 +
 15 files changed, 115 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 208f46967..2e55d9e2e 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -528,6 +528,43 @@ tcp_ecn_fallback - BOOLEAN
 
 	Default: 1 (enabled)
 
+tcp_ecn (socket option) - TCP_ECN
+	Per-socket control of ECN mode, allowing per-connection override of the
+	tcp_ecn sysctl setting. This enables L4S (Low Latency, Low Loss, Scalable
+	Throughput) configuration on a per-socket basis.
+
+	Setting this socket option to any value except 255 will override the
+	system-wide tcp_ecn sysctl for that particular socket. A value of 255
+	(TCP_ECN_MODE_UNSPEC) means use the system default sysctl value.
+
+	Possible values: 0-5 (see tcp_ecn sysctl description above), or 255 to
+	use the system default (sysctl_tcp_ecn).
+
+	Example::
+
+		int val = 3;  /* AccECN mode */
+		setsockopt(fd, SOL_TCP, TCP_ECN, &val, sizeof(val));
+
+	Default: 255 (unspecified - uses tcp_ecn sysctl value)
+
+tcp_ecn_option (socket option) - TCP_ECN_OPTION
+	Per-socket control of Accurate ECN (AccECN) option sending behavior,
+	allowing per-connection override of the tcp_ecn_option sysctl setting.
+
+	Setting this socket option to any value except 255 will override the
+	system-wide tcp_ecn_option sysctl for that particular socket. A value of
+	255 (TCP_ACCECN_OPTION_UNSPEC) means use the system default sysctl value.
+
+	Possible values: 0-3 (see tcp_ecn_option sysctl description above), or 255
+	to use the system default (sysctl_tcp_ecn_option).
+
+	Example::
+
+		int val = 2;  /* Send AccECN option on every packet */
+		setsockopt(fd, SOL_TCP, TCP_ECN_OPTION, &val, sizeof(val));
+
+	Default: 255 (unspecified - uses tcp_ecn_option sysctl value)
+
 tcp_fack - BOOLEAN
 	This is a legacy option, it has no effect anymore.
 
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a8c77719..7cb1e765f 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -289,6 +289,13 @@ struct tcp_sock {
 					 * sacked_out > 0)
 					 */
 	u8	ecn_flags;	/* ECN status bits.			*/
+	u8	ecn_mode;	/* Per-socket ECN mode override
+				 * (TCP_ECN_MODE_UNSPEC = use sysctl)
+				 */
+	u8	ecn_option;	/* Per-socket AccECN option override
+				 * (TCP_ACCECN_OPTION_UNSPEC = use sysctl)
+				 */
+
 	__cacheline_group_end(tcp_sock_write_tx);
 
 	/* TXRX read-write hotpath cache lines */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e5f5f9b8..b7c0b519a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -707,12 +707,6 @@ u64 cookie_init_timestamp(struct request_sock *req, u64 now);
 bool cookie_timestamp_decode(const struct net *net,
 			     struct tcp_options_received *opt);
 
-static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *dst)
-{
-	return READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
-		dst_feature(dst, RTAX_FEATURE_ECN);
-}
-
 #if IS_ENABLED(CONFIG_BPF)
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 865d5c5a7..48e364c45 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -22,6 +22,7 @@ enum tcp_ecn_mode {
 	TCP_ECN_IN_ACCECN_OUT_ACCECN = 3,
 	TCP_ECN_IN_ACCECN_OUT_ECN = 4,
 	TCP_ECN_IN_ACCECN_OUT_NOECN = 5,
+	TCP_ECN_MODE_UNSPEC = 255,	/* Use sysctl default (per-socket) */
 };
 
 /* AccECN option sending when AccECN has been successfully negotiated */
@@ -30,8 +31,36 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
 	TCP_ACCECN_OPTION_PERSIST = 3,
+	TCP_ACCECN_OPTION_UNSPEC = 255,	/* Use sysctl default (per-socket) */
 };
 
+/* Resolve the effective ECN mode: per-socket override or sysctl fallback */
+static inline u8 tcp_ecn_mode_eff(const struct sock *sk)
+{
+	u8 mode = READ_ONCE(tcp_sk(sk)->ecn_mode);
+
+	if (mode == TCP_ECN_MODE_UNSPEC)
+		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
+	return mode;
+}
+
+/* Resolve the effective AccECN option: per-socket override or sysctl fallback */
+static inline u8 tcp_accecn_option_eff(const struct sock *sk)
+{
+	u8 opt = READ_ONCE(tcp_sk(sk)->ecn_option);
+
+	if (opt == TCP_ACCECN_OPTION_UNSPEC)
+		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
+	return opt;
+}
+
+/* ECN support for SYN cookies: per-socket override or route feature */
+static inline bool cookie_ecn_ok(const struct sock *sk, const struct dst_entry *dst)
+{
+	return tcp_ecn_mode_eff(sk) ||
+		dst_feature(dst, RTAX_FEATURE_ECN);
+}
+
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
 static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
 {
@@ -599,7 +628,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool bpf_needs_ecn = tcp_bpf_ca_needs_ecn(sk);
 	bool use_ecn, use_accecn;
-	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
+	u8 tcp_ecn = tcp_ecn_mode_eff(sk);
 
 	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
 		     tcp_ca_needs_accecn(sk);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc0..c58b1633b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2985,7 +2985,8 @@ union bpf_attr {
  * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
  * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
  * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
- *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
+ *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**,
+ *		  **TCP_ECN**, **TCP_ECN_OPTION**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
  * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
  * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 03772dd4d..01ebb348b 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -142,6 +142,8 @@ enum {
 #define TCP_RTO_MAX_MS		44	/* max rto time in ms */
 #define TCP_RTO_MIN_US		45	/* min rto time in us */
 #define TCP_DELACK_MAX_US	46	/* max delayed ack time in us */
+#define TCP_ECN			47	/* Per-socket ECN mode (0-5, 255=use sysctl) */
+#define TCP_ECN_OPTION		48	/* Per-socket AccECN option (0-3, 255=use sysctl) */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753..993b31e10 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5670,6 +5670,8 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 	case TCP_NOTSENT_LOWAT:
 	case TCP_SAVE_SYN:
 	case TCP_RTO_MAX_MS:
+	case TCP_ECN:
+	case TCP_ECN_OPTION:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
 		break;
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e129768..ebc438bc6 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -490,7 +490,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
-	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
+	ireq->ecn_ok &= cookie_ecn_ok(sk, &rt->dst);
 	treq->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1c867a302..fb376a97f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -463,6 +463,8 @@ void tcp_init_sock(struct sock *sk)
 
 	tp->tsoffset = 0;
 	tp->rack.reo_wnd_steps = 1;
+	tp->ecn_mode = TCP_ECN_MODE_UNSPEC;
+	tp->ecn_option = TCP_ACCECN_OPTION_UNSPEC;
 
 	sk->sk_write_space = sk_stream_write_space;
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
@@ -4160,6 +4162,18 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		tcp_enable_tx_delay(sk, val);
 		WRITE_ONCE(tp->tcp_tx_delay, val);
 		break;
+	case TCP_ECN:
+		if (val != TCP_ECN_MODE_UNSPEC && (val < 0 || val > TCP_ECN_IN_ACCECN_OUT_NOECN))
+			err = -EINVAL;
+		else
+			WRITE_ONCE(tp->ecn_mode, val);
+		break;
+	case TCP_ECN_OPTION:
+		if (val != TCP_ACCECN_OPTION_UNSPEC && (val < 0 || val > TCP_ACCECN_OPTION_PERSIST))
+			err = -EINVAL;
+		else
+			WRITE_ONCE(tp->ecn_option, val);
+		break;
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -4842,6 +4856,12 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	case TCP_DELACK_MAX_US:
 		val = jiffies_to_usecs(READ_ONCE(inet_csk(sk)->icsk_delack_max));
 		break;
+	case TCP_ECN:
+		val = READ_ONCE(tp->ecn_mode);
+		break;
+	case TCP_ECN_OPTION:
+		val = READ_ONCE(tp->ecn_option);
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -5256,6 +5276,8 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_mode);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_option);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf..0043b4b2b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7457,13 +7457,12 @@ static void tcp_ecn_create_request(struct request_sock *req,
 				   const struct dst_entry *dst)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
-	const struct net *net = sock_net(listen_sk);
 	bool th_ecn = th->ece && th->cwr;
 	bool ect, ecn_ok;
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	    (tcp_ecn_mode_eff(listen_sk) >= 3 ||
 	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
@@ -7477,7 +7476,7 @@ static void tcp_ecn_create_request(struct request_sock *req,
 
 	ect = !INET_ECN_is_not_ect(TCP_SKB_CB(skb)->ip_dsfield);
 	ecn_ok_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
-	ecn_ok = READ_ONCE(net->ipv4.sysctl_tcp_ecn) || ecn_ok_dst;
+	ecn_ok = tcp_ecn_mode_eff(listen_sk) || ecn_ok_dst;
 
 	if (((!ect || th->res1 || th->ae) && ecn_ok) ||
 	    tcp_ca_needs_ecn(listen_sk) ||
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 00417a429..82b96c401 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1045,7 +1045,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
 		     inet_csk(sk)->icsk_retransmits < 2 &&
-		     READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+		     tcp_accecn_option_eff(sk) &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
@@ -1133,7 +1133,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+	    tcp_accecn_option_eff(sk) &&
 	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
@@ -1221,7 +1221,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
+		int ecn_opt = tcp_accecn_option_eff(sk);
 
 		if (ecn_opt && tp->saw_accecn_opt &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index b581cb1ee..06efcbf46 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -271,7 +271,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
-	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
+	ireq->ecn_ok &= cookie_ecn_ok(sk, dst);
 	tcp_rsk(req)->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc0..c58b1633b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2985,7 +2985,8 @@ union bpf_attr {
  * 		  **TCP_SYNCNT**, **TCP_USER_TIMEOUT**, **TCP_NOTSENT_LOWAT**,
  * 		  **TCP_NODELAY**, **TCP_MAXSEG**, **TCP_WINDOW_CLAMP**,
  * 		  **TCP_THIN_LINEAR_TIMEOUTS**, **TCP_BPF_DELACK_MAX**,
- *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**.
+ *		  **TCP_BPF_RTO_MIN**, **TCP_BPF_SOCK_OPS_CB_FLAGS**,
+ *		  **TCP_ECN**, **TCP_ECN_OPTION**.
  * 		* **IPPROTO_IP**, which supports *optname* **IP_TOS**.
  * 		* **IPPROTO_IPV6**, which supports the following *optname*\ s:
  * 		  **IPV6_TCLASS**, **IPV6_AUTOFLOWLABEL**.
diff --git a/tools/include/uapi/linux/tcp.h b/tools/include/uapi/linux/tcp.h
index 13ceeb395..4f52b9df4 100644
--- a/tools/include/uapi/linux/tcp.h
+++ b/tools/include/uapi/linux/tcp.h
@@ -128,7 +128,8 @@ enum {
 #define TCP_CM_INQ		TCP_INQ
 
 #define TCP_TX_DELAY		37	/* delay outgoing packets by XX usec */
-
+#define TCP_ECN			47	/* Per-socket ECN mode (0-5, 255=use sysctl) */
+#define TCP_ECN_OPTION		48	/* Per-socket AccECN option (0-3, 255=use sysctl) */
 
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index d96e99b67..fb97fa0bc 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -64,6 +64,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_BPF_DELACK_MAX, .new = 30000, .expected = 30000, },
 	{ .opt = TCP_BPF_RTO_MIN, .new = 30000, .expected = 30000, },
 	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
+	{ .opt = TCP_ECN, .new = 3, .expected = 3, .restore = 255, },
+	{ .opt = TCP_ECN_OPTION, .new = 2, .expected = 2, .restore = 255, },
 	{ .opt = 0, },
 };
 

base-commit: 548b86839f7fb819a4d6c83b71c73ec378d24275
-- 
2.34.1

