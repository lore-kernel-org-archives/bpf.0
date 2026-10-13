Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E6469852
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887958; cv=none; b=rNDMPVSJZIiLRHwYcC/H79TFiw3CTqFi4JhM/HsIA/i3nYFJXto52ombezVA8PeStErRXZpqxVTo5HGVixVQGbKf2gtCKGEnYm6CwuMOwP0YAygPTtlKEbgPcrcgH9g0dRnn7CP27pR2K9dIDt7lIYOpXPtGeElby+jSzREenoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887958; c=relaxed/simple;
	bh=w9QH/JAIsKBEVmNi5I6KxCW77+2NA+UFpUSdSJIF1uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVYEqfvWZzXmoWBEXB3CdN0wzrk3sK4gtHOY8bWD+xaUV+309wv7+LBnxLdzqn8zLIL9KM+5wXeorVCTjkgXI5X15ts25TSFeM9FN0aYwHUABhvEDq/5FvQfbQDcTKl+SIICqPCSybF/cXszWZLmW4+ALy1CTlKDNi4/cJ3+vkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LoquxLdA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LoquxLdA"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so460458266b.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791887953; x=1792492753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dD9vxbl/sHXqhnK7IgJ6rvDJPYQpN5SF7ByAS3t3LnE=;
        b=LoquxLdA6Vf0q4QJSs8MdCnmrR1qUSG0Yf/EOPSvH8oxfpBOkAlySs6OZFZ9Ac/5Li
         8DEigZoRnY8UwOaul1OtP3HlnWVce8k+KcMpZlAc3/nZVrTNbkKKsVqGNUkdsLNxpQhs
         R9xliyh0tCW2gO7fHp58KI+rBrdnHD5XiHmzkikAZKx3bVhsNLWXiRBtvlIfbbHDJwT2
         wU5CrxLBTbQ3nDQKT/wUujBspF0/YKeRS2DUyGfV3RiJ2PmlQ1TATsI/g8u9hxRSvhz9
         rQvCVIUIcMG5FQZ0HHyjNit8ckux8YRTOaf82fkjR9/1X/CTaJp9wJov/HTopHhhlfjM
         hxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887953; x=1792492753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dD9vxbl/sHXqhnK7IgJ6rvDJPYQpN5SF7ByAS3t3LnE=;
        b=zPbSYoGKyR6bLflvtsCMKTqQSuloR+KtQGgvdBpcnd8ah+yAi8g5wrnurNIdett2Y5
         V+hY6emhiBYupIDaHv08xKHagGWy2yNSuzh2Mw2uM38UTN3EDSPoGqnpartasBJ4zaz1
         eP1ism9mYetXPnEczSol5w9wNB4inMGC2ee12jDEa29uNBUmkOQAc0T2fxtYzt8akScJ
         2KD+jqcG7pTGUX+wKCfmHHtB/KeoWykho0QE2Avc3+bQz/Kl/Odtenfyi/sqZ68nSWEE
         i85Dis/XG3YQ+5yf2UdVIe4YUYKLz2gDILqH99at9elkP46fNHRbII1pVA46bU9ZLi8J
         64qw==
X-Forwarded-Encrypted: i=1; AKwUvBytvnFLrUmu2lErZ4dYVoT4CywJ+1yQOmuEPbkZhLLckivolruqTaL3ByRS3vPF5QQKn1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf4yI0UfhGMYLHboA32Sgm1s/vkHhGHrK2tcG9brBs+vrOB/So
	s+GPI+7UAGliAlxMYxSiKM3DMbVK5TrGuAdRr41iBZdEo94ATKQCime7z31FZpW9gWE=
X-Gm-Gg: AYBFou2dheCDp68J1Pk2tKmnM9t6dV21fBJye2hQNmx99CIBqrmtgnL+aoihKGnCpjK
	qZBesLy7vU5DJVboGcqHKqyzMX26xZt7vdYzcwg2rdlZFJtHWstfuuWaC2PMPn2DkWqP2bUqqly
	roPdR3nDZ7a/KjSI/mWALIQQpuue+fvPNY5MnXnM1QJMLB3+eFNVJRgzR7y4X6pQ1TkQTw81pMo
	iVnh+ixCI2x3Y/oWGasjkUgNO6fySz8ksuCMfC3kS4Qv6se384aSVd6PKgna/Y+UhHSN3isrCeE
	Ru7LCqWNGk5A2YVoakWx8zdQm0e4ObST4BoGPaiG+EawvnuZO/+4QsT8PX7Qlgdbep4GWPxPsFD
	w1WPwRBzuAtv849QuEYmbW7LAd1G67P++ydR1k+QIXtAPRfRJfAHKGdB9ycGzOwlOAqWw8iu0aM
	xl+v72ftm22YeVC/gIX7BT+XFWOIUAfZbsrjmdfhlTHldUx8F5NrqOkgURuA28BUxmBRnlL6gU+
	LFI4mv1MkdnISKdIumQgbiU3A==
X-Received: by 2002:a17:907:3d4f:b0:c2d:d408:5d9c with SMTP id a640c23a62f3a-c31aa024423mr1098397266b.48.1791887952780;
        Tue, 13 Oct 2026 03:39:12 -0700 (PDT)
Received: from 8951987238ab.arnhem.chello.nl ([104.28.187.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ac62a7sm552462166b.63.2026.10.13.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:39:12 -0700 (PDT)
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
Subject: [RFC PATCH net-next 2/4] tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to assign a TSval identifier
Date: Tue, 13 Oct 2026 10:39:04 +0000
Message-ID: <20261013103906.2660384-3-wferguson@cloudflare.com>
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

Let a sock_ops program pick the identifier that the previous patch
encodes in the low bits of TSval, for passively opened connections.

The width is set per network namespace by the new tcp_ts_id_bits sysctl
(0 to 8, default 0). A listener opts in by setting
BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG, typically from BPF_SOCK_OPS_TCP_LISTEN_CB.
tcp_conn_request() then runs BPF_SOCK_OPS_TCP_TS_ID_CB once the request
socket exists and before the SYN-ACK is built, so the SYN-ACK already
carries the identifier. The program sees the request socket, the SYN
(bpf_load_hdr_opt() works on it) and the available width in args[1]. A
reply that fits in that width is stored with the width in the request
socket and is inherited by the child, including Fast Open children; any
other reply leaves the connection unencoded.

The callback is not run for SYN cookies, which have nowhere to keep the
identifier, or when the peer did not negotiate timestamps. It is skipped
for connections using microsecond timestamps and while the sysctl is 0.
The width is captured per connection, so changing the sysctl does not
affect existing connections.

New /proc/net/netstat counters report how often an identifier was
assigned, declined by the program or skipped. TCPTSIdEchoMismatch counts
third ACKs whose TSecr no longer carries the identifier, which shows the
echo was rewritten in flight.

BPF_SOCK_OPS_ALL_CB_FLAGS grows from 0x7f to 0xff. The tcpbpf selftest
used 0x80 as an example of an unsupported flag, so move it to 0x100.

Encoding makes the timestamp clock appear 2^bits times faster to the
peer. That shrinks the real-time span of the peer's PAWS window, and
peers that keep ts_recent for the RFC 7323 24 days stall connections
idle for longer than 24.8/2^bits days. ip-sysctl.rst documents both,
along with the lack of TCP_REPAIR support.

Signed-off-by: Willem Ferguson <wferguson@cloudflare.com>
---
 Documentation/networking/ip-sysctl.rst        | 37 ++++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             |  8 +++
 include/uapi/linux/bpf.h                      | 15 +++++-
 include/uapi/linux/snmp.h                     |  4 ++
 net/ipv4/proc.c                               |  4 ++
 net/ipv4/sysctl_net_ipv4.c                    | 10 ++++
 net/ipv4/tcp_input.c                          | 50 +++++++++++++++++++
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  9 ++++
 tools/include/uapi/linux/bpf.h                | 15 +++++-
 .../selftests/bpf/prog_tests/tcpbpf_user.c    |  2 +-
 .../selftests/bpf/progs/test_tcpbpf_kern.c    |  2 +-
 14 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 685c84cf543d..ce669f282250 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1096,6 +1096,43 @@ tcp_timestamps - INTEGER
 
 	Default: 1
 
+tcp_ts_id_bits - INTEGER
+	Number of low bits in locally generated TCP timestamp values that may
+	contain an identifier selected by BPF_SOCK_OPS_TCP_TS_ID_CB. The upper
+	bits contain the millisecond timestamp clock. Valid values are 0 to 8.
+	A value of 0 disables the callback and timestamp identifier encoding.
+
+	The value is captured when the callback selects an identifier. Changing
+	it does not alter existing connections. Identifier encoding is disabled
+	for connections using microsecond timestamps and for SYN cookies.
+
+	Encoding shifts the timestamp clock up by this many bits, so the TSval
+	wrap time falls from 49.7 days to 49.7/2^bits days and peers see an
+	apparently faster clock. Peers that size their PAWS replay window in
+	timestamp units (Linux does) therefore tolerate less real time before
+	rejecting a reordered pure ACK. The window shrinks with every extra
+	bit, so use the narrowest width that holds the identifiers needed.
+
+	The faster clock also limits how long a connection may stay idle.
+	TSval advances by 2^31 after 24.8/2^bits days (about 2.3 hours at 8
+	bits, 37 hours at 4 bits). Linux peers stop enforcing PAWS after 2147
+	seconds of idle, so they are unaffected. Peers that follow RFC 7323 and
+	keep ts_recent for 24 days (e.g. FreeBSD, macOS) will drop every
+	segment once that point is passed. The connection then stalls until it
+	times out. Traffic in either direction, including TCP keepalives, more
+	often than this interval prevents it.
+
+	Progress is visible through the TCPTSId* counters in
+	/proc/net/netstat.
+
+	Checkpoint/restore is not supported. The identifier is selected by BPF
+	when the SYN arrives and cannot be restored onto a new socket, so a
+	connection carrying one will emit unencoded timestamp values after a
+	TCP_REPAIR restore and be rejected by the peer's PAWS check. Leave
+	this at 0 on hosts that migrate established connections.
+
+	Default: 0 (disabled)
+
 tcp_min_tso_segs - INTEGER
 	Minimal number of segments per TSO frame.
 
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 3dc03bff739e..cbb6e6f85f17 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -87,6 +87,7 @@ unsigned_int                    sysctl_tcp_notsent_lowat                     rea
 u8                              sysctl_tcp_sack                                                                      tcp_syn_options
 u8                              sysctl_tcp_window_scaling                                                            tcp_syn_options,tcp_parse_options
 u8                              sysctl_tcp_timestamps
+u8                              sysctl_tcp_ts_id_bits                                                               bpf_skops_tcp_ts_id
 u8                              sysctl_tcp_early_retrans                     read_mostly                             tcp_schedule_loss_probe(tcp_write_xmit)
 u32                             sysctl_tcp_rto_max_ms
 u8                              sysctl_tcp_recovery                                                                  tcp_fastretrans_alert
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index cb7f8bf15671..4806906276c2 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -204,6 +204,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_sack;
 	u8 sysctl_tcp_window_scaling;
 	u8 sysctl_tcp_timestamps;
+	u8 sysctl_tcp_ts_id_bits;
 	int sysctl_tcp_rto_min_us;
 	int sysctl_tcp_rto_max_ms;
 	u8 sysctl_tcp_recovery;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 85d3038f41af..970757eccf25 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1105,6 +1105,14 @@ static inline u32 tcp_tsecr_decode(u32 tsecr, u32 tsoffset, u8 ts_id_bits,
 	return now + sign_extend32(tsecr - now, 31 - ts_id_bits);
 }
 
+/* A TSecr echoing one of our TSvals must still carry our identifier in its
+ * low bits; anything else means the echo was rewritten in flight.
+ */
+static inline bool tcp_tsecr_id_ok(u32 tsecr, u8 ts_id, u8 ts_id_bits)
+{
+	return (tsecr & tcp_ts_id_mask(ts_id_bits)) == ts_id;
+}
+
 /* Keeps the timestamp clock read behind the branch: it is only needed to
  * re-center an echo that was truncated to make room for an identifier.
  */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc08d1..b440a3fd96d0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7062,6 +7062,7 @@ struct bpf_sock_ops {
 	 *                                header has not been written.
 	 * BPF_SOCK_OPS_WRITE_HDR_OPT_CB: The header and options have
 	 *				  been written so far.
+	 * BPF_SOCK_OPS_TCP_TS_ID_CB:     The SYN received by a listener.
 	 * BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:  The SYNACK that concludes
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
@@ -7137,8 +7138,12 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf to select a TCP timestamp connection ID for a passive
+	 * connection before sending the SYN-ACK.
+	 */
+	BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG = (1 << 7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7282,6 +7287,14 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_TCP_TS_ID_CB,	/* Called after a passive SYN created a
+					 * request socket and before the SYN-ACK is
+					 * sent. Not called for SYN cookies. Arg2 is
+					 * the number of low timestamp bits available
+					 * for an identifier. Set reply to an identifier
+					 * that fits in Arg2 bits. Replies are ignored
+					 * for usec timestamps.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 49f5640092a0..b214dcc38736 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -306,6 +306,10 @@ enum
 	LINUX_MIB_TCPAOKEYNOTFOUND,		/* TCPAOKeyNotFound */
 	LINUX_MIB_TCPAOGOOD,			/* TCPAOGood */
 	LINUX_MIB_TCPAODROPPEDICMPS,		/* TCPAODroppedIcmps */
+	LINUX_MIB_TCPTSIDASSIGNED,		/* TCPTSIdAssigned */
+	LINUX_MIB_TCPTSIDDECLINED,		/* TCPTSIdDeclined */
+	LINUX_MIB_TCPTSIDSKIPPED,		/* TCPTSIdSkipped */
+	LINUX_MIB_TCPTSIDECHOMISMATCH,		/* TCPTSIdEchoMismatch */
 	__LINUX_MIB_MAX
 };
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index bfc06d1713ec..6f92714693aa 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -302,6 +302,10 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
 	SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
 	SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
+	SNMP_MIB_ITEM("TCPTSIdAssigned", LINUX_MIB_TCPTSIDASSIGNED),
+	SNMP_MIB_ITEM("TCPTSIdDeclined", LINUX_MIB_TCPTSIDDECLINED),
+	SNMP_MIB_ITEM("TCPTSIdSkipped", LINUX_MIB_TCPTSIDSKIPPED),
+	SNMP_MIB_ITEM("TCPTSIdEchoMismatch", LINUX_MIB_TCPTSIDECHOMISMATCH),
 };
 
 static void icmpmsg_put_line(struct seq_file *seq, unsigned long *vals,
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e3760daa3470..ce9bad196795 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -55,6 +55,7 @@ static int tcp_min_rcvbuf = 4096;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
+static const unsigned int tcp_ts_id_bits_max = TCP_TS_ID_BITS_MAX;
 
 /* Update system visible IP port range */
 static void set_local_port_range(struct net *net, unsigned int low, unsigned int high)
@@ -1227,6 +1228,15 @@ static const struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
+	{
+		.procname	= "tcp_ts_id_bits",
+		.data		= &init_net.ipv4.sysctl_tcp_ts_id_bits,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&tcp_ts_id_bits_max,
+	},
 	{
 		.procname	= "tcp_early_retrans",
 		.data		= &init_net.ipv4.sysctl_tcp_early_retrans,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 68af0283742e..9ec48b9ca01f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -144,6 +144,49 @@ EXPORT_SYMBOL_GPL(clean_acked_data_flush);
 #endif
 
 #ifdef CONFIG_CGROUP_BPF
+static void bpf_skops_tcp_ts_id(struct sock *sk, struct request_sock *req,
+				struct sk_buff *skb)
+{
+	struct bpf_sock_ops_kern sock_ops;
+	u8 ts_id_bits;
+	int err;
+
+	/* Cheapest and most selective test first: it keeps the netns sysctl
+	 * out of the SYN path for listeners that never opted in.
+	 */
+	if (!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
+				    BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG))
+		return;
+
+	if (tcp_rsk(req)->req_usec_ts) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTSIDSKIPPED);
+		return;
+	}
+
+	ts_id_bits = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ts_id_bits);
+	if (!ts_id_bits) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTSIDSKIPPED);
+		return;
+	}
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = BPF_SOCK_OPS_TCP_TS_ID_CB;
+	sock_ops.sk = req_to_sk(req);
+	sock_ops.syn_skb = skb;
+	sock_ops.args[1] = ts_id_bits;
+	sock_ops.reply = U32_MAX;
+	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
+
+	err = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+	if (!err && sock_ops.reply <= tcp_ts_id_mask(ts_id_bits)) {
+		tcp_rsk(req)->ts_id = sock_ops.reply;
+		tcp_rsk(req)->ts_id_bits = ts_id_bits;
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTSIDASSIGNED);
+	} else {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTSIDDECLINED);
+	}
+}
+
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
 	bool unknown_opt = tcp_sk(sk)->rx_opt.saw_unknown &&
@@ -198,6 +241,11 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 #else
+static void bpf_skops_tcp_ts_id(struct sock *sk, struct request_sock *req,
+				struct sk_buff *skb)
+{
+}
+
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
 }
@@ -7781,6 +7829,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	sk_rx_queue_set(req_to_sk(req), skb);
 	if (!want_cookie) {
 		tcp_reqsk_record_syn(sk, req, skb);
+		if (inet_rsk(req)->tstamp_ok)
+			bpf_skops_tcp_ts_id(sk, req, skb);
 		fastopen_sk = tcp_try_fastopen(sk, skb, req, &foc, dst);
 	}
 	if (fastopen_sk) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ebe5aa70374a..4987f6b4bfc3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3473,6 +3473,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_sack = 1;
 	net->ipv4.sysctl_tcp_window_scaling = 1;
 	net->ipv4.sysctl_tcp_timestamps = 1;
+	net->ipv4.sysctl_tcp_ts_id_bits = 0; /* Disabled by default */
 	net->ipv4.sysctl_tcp_early_retrans = 3;
 	net->ipv4.sysctl_tcp_recovery = TCP_RACK_LOSS_DETECTION;
 	net->ipv4.sysctl_tcp_slow_start_after_idle = 1; /* By default, RFC2861 behavior.  */
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 43580b395bff..79fd943c6a1d 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -719,6 +719,15 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 					tsecr_reject = !between(tmp_opt.rcv_tsecr,
 							tcp_rsk(req)->snt_tsval_first,
 							READ_ONCE(tcp_rsk(req)->snt_tsval_last));
+				/* First echo of a TSval we encoded: a mismatch
+				 * here means TSecr was rewritten in flight.
+				 */
+				if (tcp_rsk(req)->ts_id_bits &&
+				    !tcp_tsecr_id_ok(tmp_opt.rcv_tsecr,
+						     tcp_rsk(req)->ts_id,
+						     tcp_rsk(req)->ts_id_bits))
+					NET_INC_STATS(sock_net(sk),
+						      LINUX_MIB_TCPTSIDECHOMISMATCH);
 				tmp_opt.rcv_tsecr =
 					tcp_tsecr_decode(tmp_opt.rcv_tsecr,
 							 tcp_rsk(req)->ts_off,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc08d1..b440a3fd96d0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7062,6 +7062,7 @@ struct bpf_sock_ops {
 	 *                                header has not been written.
 	 * BPF_SOCK_OPS_WRITE_HDR_OPT_CB: The header and options have
 	 *				  been written so far.
+	 * BPF_SOCK_OPS_TCP_TS_ID_CB:     The SYN received by a listener.
 	 * BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:  The SYNACK that concludes
 	 *					the 3WHS.
 	 * BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: The ACK that concludes
@@ -7137,8 +7138,12 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf to select a TCP timestamp connection ID for a passive
+	 * connection before sending the SYN-ACK.
+	 */
+	BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG = (1 << 7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
@@ -7282,6 +7287,14 @@ enum {
 					 * sendmsg timestamp with corresponding
 					 * tskey.
 					 */
+	BPF_SOCK_OPS_TCP_TS_ID_CB,	/* Called after a passive SYN created a
+					 * request socket and before the SYN-ACK is
+					 * sent. Not called for SYN cookies. Arg2 is
+					 * the number of low timestamp bits available
+					 * for an identifier. Set reply to an identifier
+					 * that fits in Arg2 bits. Replies are ignored
+					 * for usec timestamps.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
index 7e8fe1bad03f..08f667705291 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
@@ -26,7 +26,7 @@ static void verify_result(struct tcpbpf_globals *result)
 	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
 	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
 	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
-	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
+	ASSERT_EQ(result->bad_cb_test_rv, 0x100, "bad_cb_test_rv");
 	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
 	ASSERT_EQ(result->num_listen, 1, "num_listen");
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 6935f32eeb8f..3c011f4684c4 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -92,7 +92,7 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 		break;
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		/* Test failure to set largest cb flag (assumes not defined) */
-		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x80);
+		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x100);
 		/* Set callback */
 		global.good_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
 						 BPF_SOCK_OPS_STATE_CB_FLAG);
-- 
2.47.3

