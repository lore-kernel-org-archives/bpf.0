Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4F3C3428
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145361; cv=none; b=dDGuBQjZaxG7jF6zcS07ZpKY563W1o2+/pKFVTTZYHoPbAM6izHjBhubkEocEDaitguvXS7VkjE9FD9yXOPoZ3YCRDe6fZ85pkAvAfciD5W/sbpErjbHu+/xIQi+poSzhruUDNoN4FJ5ipAxmV8z8X8Eof1CpSqX3hLkXeX1fhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145361; c=relaxed/simple;
	bh=xccvdd6dp+rYBHeOk3zvCwTKvACYKO5kaQ3O1185ZMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=IwncOiW7FeFEeX8T1Ki40ziA4JDU4SkbgN+OzqxOtxScczqqPqNh5Cko3obPtSQjlFqBDyVPTlCe6/h2QRvWcTcX1/IC2OolLDkhUU24N7AwBCqHL170z2BYy1OKrK3hgCnzfCj5GrQws9ozQQnvhSRrByowlEt97sT3B/usG/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FS4xvm3R; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FS4xvm3R"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261016100915epoutp0358d6dde0b4fe0e1d90f0ef4f60945c2c~e_rSbYr100545305453epoutp03B
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:09:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261016100915epoutp0358d6dde0b4fe0e1d90f0ef4f60945c2c~e_rSbYr100545305453epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1792145355;
	bh=OowVhK9FsBA81AzLM0YpiJnsnCEiMOs6GeblL7Kb9yg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=FS4xvm3RhtUH9OIarVnU2MQWCueXQjuD4HcqFVyP6xDHLDE353O+LWYkDz3S2yii1
	 sN/tHZLP859dX3qfARWqf2YHNxMlgFEGPa62gfA/xpRXJFm3yv+UdVYvfK/1tgRA/a
	 yJ3hh5JOeI5uOhQ3RPCtxksbTbNpyH0lpk8/aXSc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261016100914epcas5p3196ed6103d419802976bea98ae8a21ef~e_rR3Xw9s1248712487epcas5p3N;
	Fri, 16 Oct 2026 10:09:14 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4j5gdk0BFtz6B9m5; Fri, 16 Oct
	2026 10:09:14 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261016100913epcas5p13a41d34ac5d203bff1d220b3d19dee67~e_rQty4_H0668806688epcas5p1k;
	Fri, 16 Oct 2026 10:09:13 +0000 (GMT)
Received: from ws2030076956.sa.corp.samsungelectronics.net (unknown
	[107.99.235.31]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261016100910epsmtip1aab2ff19d0c30107ff4ca943258cde10~e_rNmc_KE2554925549epsmtip1-;
	Fri, 16 Oct 2026 10:09:10 +0000 (GMT)
From: Irlanki Sandeep <irlanki.s@samsung.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org
Cc: edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
	ncardwell@google.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
	lorenzo@google.com, maze@google.com, sporeba@google.com,
	motomuman@google.com, madhan.raj@samsung.com, srihari.k@samsung.com,
	g.pokhra@samsung.com, r.kumawat@samsung.com, raj.kumars@samsung.com,
	ts413.lee@samsung.com, ramyashree.s@samsung.com, daeil2.hwang@samsung.com,
	irlanki.s@samsung.com
Subject: [PATCH net-next v7] tcp: add BPF kfuncs to set per-socket ECN mode
 and AccECN option
Date: Fri, 16 Oct 2026 15:40:07 +0530
Message-Id: <20261016101007.2044546-1-irlanki.s@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261016100913epcas5p13a41d34ac5d203bff1d220b3d19dee67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261016100913epcas5p13a41d34ac5d203bff1d220b3d19dee67
References: <CGME20261016100913epcas5p13a41d34ac5d203bff1d220b3d19dee67@epcas5p1.samsung.com>

Currently, ECN and Accurate ECN (AccECN) configurations in the Linux
kernel are controlled globally via the net.ipv4.tcp_ecn and
net.ipv4.tcp_ecn_option sysctl variables. This global approach lacks the
granularity required for per-connection ECN configuration in modern
multi-application runtimes.

In diverse network environments, such as mobile operating systems like
Android, different applications route their traffic over distinct
physical and virtual interfaces. Certain legacy network paths or
misconfigured middleboxes are known to blackhole packets with ECN
negotiation flags or AccECN option headers.

To provide granular control, introduce two new BPF kfuncs that can be
called from sockops programs:

1. bpf_sock_ops_set_ecn_mode(): Overrides the ECN negotiation mode for
   a socket.

2. bpf_sock_ops_set_accecn_option(): Overrides the AccECN option
   sending frequency for a socket, allowing for dynamic runtime
   adaptation if middlebox dropping is observed.

New helpers tcp_ecn_mode_eff() and tcp_accecn_option_eff() resolve the
effective per-socket value, transparently falling back to the global
sysctl defaults when no per-socket override is set.

The ECN mode kfunc is restricted to the CONNECT_CB and LISTEN_CB
callbacks since the mode is only consulted during connection
establishment, while the AccECN option kfunc may be called from any
callback on a full TCP socket to allow runtime adaptation. Both kfuncs
reject non-TCP sockets, as sockops programs also run for the TX
timestamping callbacks of other socket types.

Values set on a listener socket are consulted for each incoming handshake,
including SYN cookie validation, and, like other per-socket settings, are
inherited by the accepted child sockets. Note that a listener is already
hashed before the LISTEN_CB callback runs, so connections accepted in that
window follow the sysctl defaults: for the AccECN option this is transient,
as the program can update the value at runtime, while the ECN mode decision
made at SYN time is final for the connection.

Signed-off-by: Irlanki Sandeep <irlanki.s@samsung.com>
---
v6 -> v7:
 - Document BPF_SOCK_OPS_TCP_LISTEN_CB timing window in kernel-doc
   for both kfuncs: connections arriving before the callback runs
   will use the sysctl value rather than per-socket overrides.
 - Add fallback behavior note to commit message.
 - Remove Suggested-by tag per maintainer guidance.

v5 -> v6:
 - Reject non-TCP sockets in both kfuncs with sk_is_tcp(). The TX
   timestamping sockops callbacks run with is_fullsock set for UDP
   sockets too, so tcp_sk() on them was an out-of-bounds write (sashiko).
 - Fix selftest and comments: accepted children are cloned from the
   listener and inherit ecn_mode/ecn_option (sashiko).
 - Use standard multi-line comment style in the BPF selftests (sashiko).
 - Document per-socket kfunc override precedence for tcp_ecn and
   tcp_ecn_option in ip-sysctl.rst.
 - Reword subject: the TCP_ECN/TCP_ECN_OPTION optnames no longer exist.

v4 -> v5:
 - Replaced setsockopt implementation with BPF kfuncs.
 - Placed ecn_mode/ecn_option in the cold section of tcp_sock to avoid
   polluting hot cachelines (suggested by Eric Dumazet).
 - Updated Documentation/networking/net_cachelines/tcp_sock.rst.
 - Removed userspace UAPI and documentation for the sockopt.
 - Added new selftest for the kfunc implementation.

v3 -> v4:
 - Define TCP_ECN and TCP_ECN_OPTION in bpf_tracing_net.h to fix
   BPF selftest compilation failure in progs/setget_sockopt.c (bpf-ci).

v2 -> v3:
 - Use READ_ONCE() when reading ecn_mode and ecn_option in tcp_ecn_mode_eff()
   and tcp_accecn_option_eff() to prevent compiler double-fetches (sashiko-bot).
 - Move cookie_ecn_ok() to include/net/tcp_ecn.h and update syncookies.

v1 -> v2:
 - Remove unused variable 'net' in tcp_ecn_create_request() reported
   by kernel test robot.
---
 Documentation/networking/ip-sysctl.rst        |   6 +
 .../networking/net_cachelines/tcp_sock.rst    |   2 +
 include/linux/tcp.h                           |   6 +
 include/net/tcp.h                             |   6 -
 include/net/tcp_ecn.h                         |  31 ++++-
 net/core/filter.c                             |  75 ++++++++++++
 net/ipv4/syncookies.c                         |   2 +-
 net/ipv4/tcp.c                                |   2 +
 net/ipv4/tcp_input.c                          |   5 +-
 net/ipv4/tcp_output.c                         |   6 +-
 net/ipv6/syncookies.c                         |   2 +-
 .../bpf/prog_tests/sockops_ecn_kfunc.c        |  91 +++++++++++++++
 .../selftests/bpf/progs/sockops_ecn_kfunc.c   | 110 ++++++++++++++++++
 13 files changed, 329 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockops_ecn_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/sockops_ecn_kfunc.c

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index f7af0286341c..0dc5d1d09f6a 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -469,6 +469,9 @@ tcp_ecn - INTEGER
 	that both peers support is chosen by the ECN negotiation (Accurate ECN,
 	ECN, or no ECN).
 
+	Note that a per-socket mode set by a BPF sockops program via the
+	bpf_sock_ops_set_ecn_mode() kfunc has higher precedence.
+
 	The highest negotiated variant for incoming connection requests
 	and the highest variant requested by outgoing connection
 	attempts:
@@ -492,6 +495,9 @@ tcp_ecn_option - INTEGER
 	sending AccECN options regardless of this setting when no AccECN
 	option has been seen for the reverse direction.
 
+	Note that a per-socket value set by a BPF sockops program via the
+	bpf_sock_ops_set_accecn_option() kfunc has higher precedence.
+
 	Possible values are:
 
 	= ============================================================
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 0f6088c4ab8b..b12cc823b601 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -114,6 +114,8 @@ u8:2                          accecn_opt_demand       read_mostly         read_w
 u8:2                          prev_ecnfield                               read_write
 u64                           accecn_opt_tstamp       read_write
 u8:4                          accecn_fail_mode
+u8                            ecn_mode
+u8                            ecn_option
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u64                           first_tx_mstamp         read_write                              tcp_rate_skb_sent
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a8c77719322..c9be37c01ac2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -412,6 +412,12 @@ struct tcp_sock {
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u8	accecn_fail_mode:4,	/* AccECN failure handling */
 		saw_accecn_opt:2;	/* An AccECN option was seen */
+	u8	ecn_mode;	/* Per-socket ECN mode set via BPF
+				 * (TCP_ECN_MODE_UNSPEC = use sysctl)
+				 */
+	u8	ecn_option;	/* Per-socket AccECN option set via BPF
+				 * (TCP_ACCECN_OPTION_UNSPEC = use sysctl)
+				 */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 96a1a23e47fa..0aa74ac92058 100644
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
index 865d5c5a7718..48e364c458b2 100644
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
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..9dbbccd4e0ea 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -56,6 +56,7 @@
 #include <net/sock_reuseport.h>
 #include <net/busy_poll.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/gre.h>
 #include <net/xfrm.h>
 #include <net/udp.h>
@@ -12609,6 +12610,78 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+/**
+ * bpf_sock_ops_set_ecn_mode() - Set the per-socket TCP ECN negotiation mode.
+ * @skops: &bpf_sock_ops_kern context of the sockops program
+ * @mode: value in the range accepted by the tcp_ecn sysctl (0-5), or
+ *	TCP_ECN_MODE_UNSPEC to defer to the sysctl
+ *
+ * Overrides net.ipv4.tcp_ecn for this socket only. The mode is consulted
+ * during connection establishment, so the kfunc may only be called from
+ * BPF_SOCK_OPS_TCP_CONNECT_CB (before the SYN is built) or from
+ * BPF_SOCK_OPS_TCP_LISTEN_CB, in which case the mode is consulted for each
+ * incoming connection to decide ECN negotiation during the handshake.
+ *
+ * Note that the listener is already hashed before BPF_SOCK_OPS_TCP_LISTEN_CB
+ * runs, so connections arriving in that window negotiate ECN using the
+ * sysctl value rather than the per-socket override, since ECN negotiation
+ * happens at SYN time and cannot be changed afterwards.
+ *
+ * Return: 0 on success, -EOPNOTSUPP when called from any other sockops
+ *	callback or if @skops is not a full TCP socket, -EINVAL if @mode is
+ *	out of range.
+ */
+__bpf_kfunc int bpf_sock_ops_set_ecn_mode(struct bpf_sock_ops_kern *skops,
+					  u32 mode)
+{
+	if (skops->op != BPF_SOCK_OPS_TCP_CONNECT_CB &&
+	    skops->op != BPF_SOCK_OPS_TCP_LISTEN_CB)
+		return -EOPNOTSUPP;
+
+	if (!skops->is_fullsock || !sk_is_tcp(skops->sk))
+		return -EOPNOTSUPP;
+
+	if (mode != TCP_ECN_MODE_UNSPEC && mode > TCP_ECN_IN_ACCECN_OUT_NOECN)
+		return -EINVAL;
+
+	WRITE_ONCE(tcp_sk(skops->sk)->ecn_mode, mode);
+	return 0;
+}
+
+/**
+ * bpf_sock_ops_set_accecn_option() - Set the per-socket AccECN option mode.
+ * @skops: &bpf_sock_ops_kern context of the sockops program
+ * @opt: value in the range accepted by the tcp_ecn_option sysctl (0-3), or
+ *	TCP_ACCECN_OPTION_UNSPEC to defer to the sysctl
+ *
+ * Overrides net.ipv4.tcp_ecn_option for this socket only. Unlike the ECN
+ * mode, the option setting is consulted for the whole lifetime of an AccECN
+ * connection, so it may be changed from any sockops callback that runs on a
+ * full TCP socket, e.g. to stop sending the option once a middlebox is
+ * observed to drop segments carrying it. Like other per-socket settings, a
+ * value set on a listener is inherited by the sockets it accepts.
+ *
+ * Note that the listener is already hashed before BPF_SOCK_OPS_TCP_LISTEN_CB
+ * runs, so connections accepted in that window follow the sysctl defaults
+ * until the sockops program updates the option at runtime, which it may do
+ * from any callback on the full socket.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if @skops is not a full TCP socket,
+ *	-EINVAL if @opt is out of range.
+ */
+__bpf_kfunc int bpf_sock_ops_set_accecn_option(struct bpf_sock_ops_kern *skops,
+					       u32 opt)
+{
+	if (!skops->is_fullsock || !sk_is_tcp(skops->sk))
+		return -EOPNOTSUPP;
+
+	if (opt != TCP_ACCECN_OPTION_UNSPEC && opt > TCP_ACCECN_OPTION_PERSIST)
+		return -EINVAL;
+
+	WRITE_ONCE(tcp_sk(skops->sk)->ecn_option, opt);
+	return 0;
+}
+
 /**
  * bpf_xdp_pull_data() - Pull in non-linear xdp data.
  * @x: &xdp_md associated with the XDP buffer
@@ -12822,6 +12895,8 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_sock_ops_set_ecn_mode)
+BTF_ID_FLAGS(func, bpf_sock_ops_set_accecn_option)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e129768184..ebc438bc6a46 100644
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
index 3ac485685279..0303f7c2ec18 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -463,6 +463,8 @@ void tcp_init_sock(struct sock *sk)
 
 	tp->tsoffset = 0;
 	tp->rack.reo_wnd_steps = 1;
+	tp->ecn_mode = TCP_ECN_MODE_UNSPEC;
+	tp->ecn_option = TCP_ACCECN_OPTION_UNSPEC;
 
 	sk->sk_write_space = sk_stream_write_space;
 	sock_set_flag(sk, SOCK_USE_WRITE_QUEUE);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 892ff256e235..78603f68bc5a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7453,13 +7453,12 @@ static void tcp_ecn_create_request(struct request_sock *req,
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
@@ -7473,7 +7472,7 @@ static void tcp_ecn_create_request(struct request_sock *req,
 
 	ect = !INET_ECN_is_not_ect(TCP_SKB_CB(skb)->ip_dsfield);
 	ecn_ok_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
-	ecn_ok = READ_ONCE(net->ipv4.sysctl_tcp_ecn) || ecn_ok_dst;
+	ecn_ok = tcp_ecn_mode_eff(listen_sk) || ecn_ok_dst;
 
 	if (((!ect || th->res1 || th->ae) && ecn_ok) ||
 	    tcp_ca_needs_ecn(listen_sk) ||
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c8865205cdc8..8833578bbd84 100644
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
index b581cb1ee2e8..06efcbf46346 100644
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
diff --git a/tools/testing/selftests/bpf/prog_tests/sockops_ecn_kfunc.c b/tools/testing/selftests/bpf/prog_tests/sockops_ecn_kfunc.c
new file mode 100644
index 000000000000..6c6f046a1dc5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockops_ecn_kfunc.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+#include "sockops_ecn_kfunc.skel.h"
+
+/* From include/net/tcp_ecn.h */
+#define TCP_ECN_IN_ACCECN_OUT_ACCECN	3
+#define TCP_ECN_IN_ACCECN_OUT_ECN	4
+#define TCP_ECN_MODE_UNSPEC		255
+#define TCP_ACCECN_OPTION_MINIMUM	1
+#define TCP_ACCECN_OPTION_FULL		2
+#define TCP_ACCECN_OPTION_PERSIST	3
+
+void test_sockops_ecn_kfunc(void)
+{
+	struct sockops_ecn_kfunc__bss *bss;
+	struct sockops_ecn_kfunc *skel;
+	int cg_fd, sfd = -1, cfd = -1, afd = -1;
+
+	cg_fd = test__join_cgroup("/sockops_ecn_kfunc");
+	if (!ASSERT_OK_FD(cg_fd, "join_cgroup"))
+		return;
+
+	skel = sockops_ecn_kfunc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out;
+	bss = skel->bss;
+
+	skel->links.skops_ecn =
+		bpf_program__attach_cgroup(skel->progs.skops_ecn, cg_fd);
+	if (!ASSERT_OK_PTR(skel->links.skops_ecn, "attach_cgroup"))
+		goto out;
+
+	sfd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, 0);
+	if (!ASSERT_OK_FD(sfd, "start_server"))
+		goto out;
+
+	cfd = connect_to_fd(sfd, 0);
+	if (!ASSERT_OK_FD(cfd, "connect_to_fd"))
+		goto out;
+
+	/* accept() returning guarantees PASSIVE_ESTABLISHED_CB has run. */
+	afd = accept(sfd, NULL, NULL);
+	if (!ASSERT_OK_FD(afd, "accept"))
+		goto out;
+
+	/* BPF_SOCK_OPS_TCP_CONNECT_CB */
+	ASSERT_EQ(bss->connect_bad_mode_ret, -EINVAL, "connect_bad_mode_ret");
+	ASSERT_EQ(bss->connect_bad_opt_ret, -EINVAL, "connect_bad_opt_ret");
+	ASSERT_EQ(bss->connect_set_mode_ret, 0, "connect_set_mode_ret");
+	ASSERT_EQ(bss->connect_mode_read, TCP_ECN_IN_ACCECN_OUT_ACCECN,
+		  "connect_mode_read");
+	ASSERT_EQ(bss->connect_set_opt_ret, 0, "connect_set_opt_ret");
+	ASSERT_EQ(bss->connect_opt_read, TCP_ACCECN_OPTION_FULL,
+		  "connect_opt_read");
+	ASSERT_EQ(bss->connect_unspec_mode_ret, 0, "connect_unspec_mode_ret");
+	ASSERT_EQ(bss->connect_unspec_mode_read, TCP_ECN_MODE_UNSPEC,
+		  "connect_unspec_mode_read");
+
+	/* BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB */
+	ASSERT_EQ(bss->estab_set_mode_ret, -EOPNOTSUPP, "estab_set_mode_ret");
+	ASSERT_EQ(bss->estab_set_opt_ret, 0, "estab_set_opt_ret");
+	ASSERT_EQ(bss->estab_opt_read, TCP_ACCECN_OPTION_MINIMUM,
+		  "estab_opt_read");
+
+	/*
+	 * BPF_SOCK_OPS_TCP_LISTEN_CB -> BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
+	 * The listener's values are consulted for SYN negotiation and, like
+	 * other per-socket settings, inherited by the accepted child.
+	 */
+	ASSERT_EQ(bss->listen_set_mode_ret, 0, "listen_set_mode_ret");
+	ASSERT_EQ(bss->listen_set_opt_ret, 0, "listen_set_opt_ret");
+	ASSERT_EQ(bss->passive_mode_read, TCP_ECN_IN_ACCECN_OUT_ECN,
+		  "passive_mode_read");
+	ASSERT_EQ(bss->passive_opt_read, TCP_ACCECN_OPTION_PERSIST,
+		  "passive_opt_read");
+
+out:
+	if (afd >= 0)
+		close(afd);
+	if (cfd >= 0)
+		close(cfd);
+	if (sfd >= 0)
+		close(sfd);
+	sockops_ecn_kfunc__destroy(skel);
+	close(cg_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/sockops_ecn_kfunc.c b/tools/testing/selftests/bpf/progs/sockops_ecn_kfunc.c
new file mode 100644
index 000000000000..17c874f66b9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sockops_ecn_kfunc.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+
+/* From include/net/tcp_ecn.h */
+#define TCP_ECN_IN_ACCECN_OUT_ACCECN	3
+#define TCP_ECN_IN_ACCECN_OUT_ECN	4
+#define TCP_ECN_IN_ACCECN_OUT_NOECN	5
+#define TCP_ECN_MODE_UNSPEC		255
+#define TCP_ACCECN_OPTION_MINIMUM	1
+#define TCP_ACCECN_OPTION_FULL		2
+#define TCP_ACCECN_OPTION_PERSIST	3
+#define TCP_ACCECN_OPTION_UNSPEC	255
+
+extern int bpf_sock_ops_set_ecn_mode(struct bpf_sock_ops_kern *skops,
+				     u32 mode) __ksym;
+extern int bpf_sock_ops_set_accecn_option(struct bpf_sock_ops_kern *skops,
+					  u32 opt) __ksym;
+
+int connect_bad_mode_ret;
+int connect_bad_opt_ret;
+int connect_set_mode_ret;
+int connect_mode_read;
+int connect_set_opt_ret;
+int connect_opt_read;
+int connect_unspec_mode_ret;
+int connect_unspec_mode_read;
+int estab_set_mode_ret;
+int estab_set_opt_ret;
+int estab_opt_read;
+int listen_set_mode_ret;
+int listen_set_opt_ret;
+int passive_mode_read;
+int passive_opt_read;
+
+SEC("sockops")
+int skops_ecn(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock_ops_kern *skops_kern;
+	struct bpf_sock *sk = skops->sk;
+	struct tcp_sock *tp;
+
+	if (!sk)
+		return 1;
+
+	tp = bpf_skc_to_tcp_sock(sk);
+	if (!tp)
+		return 1;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_TCP_CONNECT_CB:
+		connect_bad_mode_ret =
+			bpf_sock_ops_set_ecn_mode(skops_kern,
+						  TCP_ECN_IN_ACCECN_OUT_NOECN + 1);
+		connect_bad_opt_ret =
+			bpf_sock_ops_set_accecn_option(skops_kern,
+						       TCP_ACCECN_OPTION_PERSIST + 1);
+
+		connect_set_mode_ret =
+			bpf_sock_ops_set_ecn_mode(skops_kern,
+						  TCP_ECN_IN_ACCECN_OUT_ACCECN);
+		connect_mode_read = tp->ecn_mode;
+
+		connect_set_opt_ret =
+			bpf_sock_ops_set_accecn_option(skops_kern,
+						       TCP_ACCECN_OPTION_FULL);
+		connect_opt_read = tp->ecn_option;
+
+		/*
+		 * Leave the socket on the sysctl defaults so the loopback
+		 * handshake driven by the test is not altered.
+		 */
+		connect_unspec_mode_ret =
+			bpf_sock_ops_set_ecn_mode(skops_kern, TCP_ECN_MODE_UNSPEC);
+		connect_unspec_mode_read = tp->ecn_mode;
+		bpf_sock_ops_set_accecn_option(skops_kern,
+					       TCP_ACCECN_OPTION_UNSPEC);
+		break;
+	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
+		/* The mode is handshake-only; the option is not. */
+		estab_set_mode_ret =
+			bpf_sock_ops_set_ecn_mode(skops_kern,
+						  TCP_ECN_IN_ACCECN_OUT_ACCECN);
+		estab_set_opt_ret =
+			bpf_sock_ops_set_accecn_option(skops_kern,
+						       TCP_ACCECN_OPTION_MINIMUM);
+		estab_opt_read = tp->ecn_option;
+		break;
+	case BPF_SOCK_OPS_TCP_LISTEN_CB:
+		listen_set_mode_ret =
+			bpf_sock_ops_set_ecn_mode(skops_kern,
+						  TCP_ECN_IN_ACCECN_OUT_ECN);
+		listen_set_opt_ret =
+			bpf_sock_ops_set_accecn_option(skops_kern,
+						       TCP_ACCECN_OPTION_PERSIST);
+		break;
+	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
+		/* The accepted child inherits the values set on the listener. */
+		passive_mode_read = tp->ecn_mode;
+		passive_opt_read = tp->ecn_option;
+		break;
+	}
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

