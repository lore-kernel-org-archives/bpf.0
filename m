Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012035.outbound.protection.outlook.com [52.101.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA32EC0A2;
	Tue, 28 Jul 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252298; cv=fail; b=B16Xhohp5B2eUx9k9QFX/UBnT7yw7NYWwBt3JdhEafkzQGWQ8kF5eb3Iu854WjSGjEA0gZGtG1so6QRLIHNqRt4FTm6qNjMBqeTJ+fH17SVqQBApKYUXPv+cyvbBCFmttCMRAgSv7jsSrD79zd3WETibfDc7kDGVIa83XH2RJeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252298; c=relaxed/simple;
	bh=+yH3764ucBPyjZjjfAB2r7tkwq/ki3bV7C2QakeoL68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qbsbFWorT2rIJ+s5FNTn046HSJ6TTva/IzKL+7xJc0gsqSZ9yQvfzQQvgBgnnLFeCJgU5TDvhs+kZJvpvSlNAEfpgy0i7MXF9Dzwn5yyy7Y4i7LXq9WDEKVVcThF1bOFRLzB+hMnWXeNgFL5YOyaC9SxEUVV8VziPeexNwdhGoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JHOyt3rP; arc=fail smtp.client-ip=52.101.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JHOyt3rP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpzR1u1BGr8CO4+tuQHz6JeCKHLM2hHi5saJOaHeGkHF+3zC9R2iKVRl7FaUgR7f9QEIltW8F1/na3Oxi6SmP00wJcZM/x2IMMhQlQjQxZuth42j/DBA6F5HQ/eYXyUYG1COBwusKnAwrzZ5+pIrg+8UUICeayVfC8+fN9FVHBPortUSfNc5pn0mVmjbmRIW2o/4/u1gwNUE/AQeqT75OqXUeLNb+o+lGkwHOf4CYvVPT/k9DhB/qNOWVbl4XHi9ZYoaeQQoc8G9AEzVRsloeZglu4DfJ7aZe8IkAS8cgI12/C/yoN46/hQKkCoDNd6JurL3VXq7qLgGrcdY5S0XXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yokbjOEQnGAim1a9xTZ5+Fx5GBw8lyA0w+DiAbwKa8=;
 b=cSczhHthWEu8/+shXslAELiKx9iGADyDJfaDzVcC3QLf6jZoWGoEOmrNQO/X5jfOzGN0T+EhTUd1nYfpXmYwXY48Ilv3JwIFVKuoox+vNQa5Zp0egckONftAWiVx3B4M5vD7WMiVjBpxbKwPP69GuYkN7GIP8CMiYAYmR68eAPvVt2Srg7nXY1tfEWQzXbQW5Bo14372/S2UTUEH5v3+nxiQcEiszXHI65LKzEyJQCoUDtAwdG/LLmrjpYctZXb2k+mY9+krqyUg9Ahej2ylKVcPS3TtWREcAlH0HuhU6qof+IaydH6LvJPddRZ2XSp9gJiVLitoJYRFfW2iTiqsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yokbjOEQnGAim1a9xTZ5+Fx5GBw8lyA0w+DiAbwKa8=;
 b=JHOyt3rPZH8dyDBfsipc+iwm0DCvLGJJuQSv0QKBW80LnlcSM5ATY+2CvsR1Ndhm/eOg0L0HYKcyJNz4UZhWzpVHgjvN41m3PqVD4ah9m18Ce9J5rUnwN/DuOGhiEpvYnIAbbjQrD3q4A9R/UuLKO8TXO4wgdUSifdTXBTw6MiTL3ORt5Zxo1iel31vOyL6QhV5Z9btarb2M1nwjxcE7l63K9ayUzCGn7TpotopC3Rvr3UfkEjMAsaUHHZ1jLRHYHCkrJC1eubgnR+bcx2vien7od/sP8wlxk0x1vr/rA8smF/ONsiN4s4lspH3r1SpOP/tXejcUMufSR33z4YIR3Q==
Received: from DUZP191CA0052.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::15)
 by PA1PR07MB10879.eurprd07.prod.outlook.com (2603:10a6:102:4fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 15:24:51 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::9d) by DUZP191CA0052.outlook.office365.com
 (2603:10a6:10:4fa::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 15:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Tue, 28 Jul 2026 15:24:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 95ABF236C0;
	Tue, 28 Jul 2026 18:24:48 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: emil@etsalapatis.com,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	linux-kselftest@vger.kernel.org,
	memxor@gmail.com,
	shuah@kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v5 net-next 1/1] tcp: Replace min_tso_segs() with tso_segs() CC callback
Date: Tue, 28 Jul 2026 17:24:25 +0200
Message-Id: <20260728152425.649600-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|PA1PR07MB10879:EE_
X-MS-Office365-Filtering-Correlation-Id: cf82d1b4-ba72-4d63-843f-08deecbc5dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|921020|3023799007|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yZOyfyRHY0Zpmorb0xqb8U3AS5JxGI7NnrOCQwqMHtaGSTxXNbEzuisfZR/MxqcUphTj9ke13JkzxOQo5peF79ofrp2IaDD3s7uwlSiZ4ZKtWum63Q2Hl1IB7QCaqZ3k63fudgGfu2UTUIU8W0nLZ1mLFb9T3P0GQfEYdcfsup5pg5W4kXfYv5OkPPG0G4gLyoZQKkdWvLJjmicgIuXCgt25OiySyTTb79RULNbHWREMIOc0KvAVuUQZ+K4AMP5RWbtEYxWwsc92tSm3FaATECqCMgMi5ztfaVk6bfwH6wNZUZt+WOH8XimK3oNHx7GK6OSl+2LTGt6wSqO+KX8dUbdVTODnDWmuASoZJXcWR5P7yt9F9sZsBJTc28NAGnanCY1vCg/RBPvHSFBGCUeQW9HP667yzbKe+QmJQq0NaBohnqFleWebS25s+SldNsLh6F6IiWb4b2DYrXH20Ok8HN+o2N7A52NCDbiFp0MA0ej7NxSpQnYOAZecmD8yGbSyiDHd0YYysuA9Fx7a3k6SUY4pEv2X1MG0RacDVL1wrMfdIslhBUNVvyjAWK+K/LlWA64KR+WTY0b2unLCd+B5+8Sfncnr6VrnbRe+hTiitG9M7xSVKOlpQmO9VXYzvmekeU/AQYB0SepzVa4twiNreRjcQmGQnCOgpogBFCTyr07wBjL/+Wu3ZMdLPKE+g4L5hMEMClokJLMzokQShgFLAtHmoTUxzNjL47VMMsLlREpqkUaLfl++Q+WCBWh/eW0t
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(3023799007)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JgWYDFWlYLSk5+nFCK7aePOP5a6vXCPr/zHVIbyQ/QNxMGYpcjQZCgo02nGAW7Sc0eblFi0epk6+aTrwhLRb+JkBtCnE8QGS4nuJDd+W1Ot5vbdH9XRZXjQMtovKABwGpYddaF4HBlXytS9BjuBJypFY1nz3MZSmdoLw8ID8wu6Rls5B/RRQaNGkQuFppBw0uzyb/cqLYLCzJRGk1NwI23bzJ8gD5XWFaF2ZzpDCbM3+bLQeGEEDw8acA6025blZ9axqTOhuWk5XSucyRkW7pQAW4kaRloch01NFZZdm6SL90uvHNU8H/KjVKXiiAzd6/3dMFDSbLYWoKTuMek1wruzd02YkN89mVgSfGzqAyROroXZXbdk9B1qKU/mSCOS1n/kpCbHmwyvfjiXSj0ihcy5Q2ERv4DVeV/RKKc0LZ0Z0ngeu5B6jJjzWHtV5nwHK
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:24:50.2752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf82d1b4-ba72-4d63-843f-08deecbc5dbb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10879

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch replaces existing min_tso_segs() with tso_segs() CC callback
for CC algorithm to provide explicit tso segment number of each data
burst and overrides tcp_tso_autosize().

This change provides below impacts on BPF struct_ops users:
- The callback is renamed from min_tso_segs to tso_segs
- The signature gains an extra u32 mss_now argument
- The return value semantics is changed from "floor value passed into
  tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing

As a result, BPF programs shall be updated, because retuning a small
constan will now directly limit tso_segs instead of the minimum.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

---
v5:
- Revert back to v3 and add Reviewed-by tag

v4:
- Use union for both min_tso_segs() and tso_segs() and a

v3:
- Update bpf_tcp_ca_tso_segs() to use tcp_tso_autosize()
- Add divide by 0 protection in case of mss_now=0

v2:
- Export tcp_tso_autosize()
---
 include/net/tcp.h                                | 12 ++++++++++--
 net/ipv4/bpf_tcp_ca.c                            |  9 ++++++---
 net/ipv4/tcp_bbr.c                               | 13 ++++++++++---
 net/ipv4/tcp_output.c                            | 13 +++++++------
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..ef9975112f15 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -824,6 +824,9 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu);
 unsigned int tcp_current_mss(struct sock *sk);
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when);
 
+u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+		     int min_tso_segs);
+
 /* Bound MSS / TSO packet size with the half of the window */
 static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 {
@@ -1361,8 +1364,13 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs (optional) */
-	u32 (*min_tso_segs)(struct sock *sk);
+	/* Override tcp_tso_autosize (optional)
+	 *
+	 * If provided, this callback returns the final TSO segment number
+	 * and will bypass tcp_tso_autosize() entirely. The implementation
+	 * must derive an appropriate value and ensure the result is valid.
+	 */
+	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
 
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..e5faa38bdd25 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -284,9 +284,12 @@ static void bpf_tcp_ca_pkts_acked(struct sock *sk, const struct ack_sample *samp
 {
 }
 
-static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
+static u32 bpf_tcp_ca_tso_segs(struct sock *sk, u32 mss_now)
 {
-	return 0;
+	if (unlikely(!mss_now))
+		/* No TSO sizing decision. Let caller apply its limits. */
+		return U32_MAX;
+	return tcp_tso_autosize(sk, mss_now, 0);
 }
 
 static void bpf_tcp_ca_cong_control(struct sock *sk, u32 ack, int flag,
@@ -320,7 +323,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.cwnd_event_tx_start = bpf_tcp_ca_cwnd_event_tx_start,
 	.in_ack_event = bpf_tcp_ca_in_ack_event,
 	.pkts_acked = bpf_tcp_ca_pkts_acked,
-	.min_tso_segs = bpf_tcp_ca_min_tso_segs,
+	.tso_segs = bpf_tcp_ca_tso_segs,
 	.cong_control = bpf_tcp_ca_cong_control,
 	.undo_cwnd = bpf_tcp_ca_undo_cwnd,
 	.sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 82378a2bfd1e..ecf11be46f38 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -297,11 +297,18 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 }
 
 /* override sysctl_tcp_min_tso_segs */
-__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
+static u32 bbr_min_tso_segs(struct sock *sk)
 {
 	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
 }
 
+__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
+{
+	if (unlikely(!mss_now))
+		return bbr_min_tso_segs(sk);
+	return tcp_tso_autosize(sk, mss_now, bbr_min_tso_segs(sk));
+}
+
 static u32 bbr_tso_segs_goal(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1151,7 +1158,7 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 	.undo_cwnd	= bbr_undo_cwnd,
 	.cwnd_event_tx_start	= bbr_cwnd_event_tx_start,
 	.ssthresh	= bbr_ssthresh,
-	.min_tso_segs	= bbr_min_tso_segs,
+	.tso_segs	= bbr_tso_segs,
 	.get_info	= bbr_get_info,
 	.set_state	= bbr_set_state,
 };
@@ -1163,7 +1170,7 @@ BTF_ID_FLAGS(func, bbr_sndbuf_expand)
 BTF_ID_FLAGS(func, bbr_undo_cwnd)
 BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, bbr_ssthresh)
-BTF_ID_FLAGS(func, bbr_min_tso_segs)
+BTF_ID_FLAGS(func, bbr_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
 BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5e30..101ca765a7a9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2253,8 +2253,8 @@ static bool tcp_nagle_check(bool partial, const struct tcp_sock *tp,
  * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowance
  * is below 1500 bytes after 6 * ~500 usec = 3ms.
  */
-static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
-			    int min_tso_segs)
+u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
+		     int min_tso_segs)
 {
 	unsigned long bytes;
 	u32 r;
@@ -2269,6 +2269,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
 
 	return max_t(u32, bytes / mss_now, min_tso_segs);
 }
+EXPORT_SYMBOL(tcp_tso_autosize);
 
 /* Return the number of segments we want in the skb we are transmitting.
  * See if congestion control module wants to decide; otherwise, autosize.
@@ -2278,11 +2279,11 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
 	u32 min_tso, tso_segs;
 
-	min_tso = ca_ops->min_tso_segs ?
-			ca_ops->min_tso_segs(sk) :
-			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+	min_tso = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+	tso_segs = ca_ops->tso_segs ?
+			ca_ops->tso_segs(sk, mss_now) :
+			tcp_tso_autosize(sk, mss_now, min_tso);
 	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
index 0a3e9d35bf6f..58262e490336 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -10,7 +10,7 @@ extern u32 bbr_sndbuf_expand(struct sock *sk) __ksym;
 extern u32 bbr_undo_cwnd(struct sock *sk) __ksym;
 extern void bbr_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern u32 bbr_ssthresh(struct sock *sk) __ksym;
-extern u32 bbr_min_tso_segs(struct sock *sk) __ksym;
+extern u32 bbr_tso_segs(struct sock *sk, u32 mss_now) __ksym;
 extern void bbr_set_state(struct sock *sk, u8 new_state) __ksym;
 
 extern void dctcp_init(struct sock *sk) __ksym;
@@ -90,9 +90,9 @@ u32 BPF_PROG(ssthresh, struct sock *sk)
 }
 
 SEC("struct_ops")
-u32 BPF_PROG(min_tso_segs, struct sock *sk)
+u32 BPF_PROG(tso_segs, struct sock *sk, u32 mss_now)
 {
-	return bbr_min_tso_segs(sk);
+	return bbr_tso_segs(sk, mss_now);
 }
 
 SEC("struct_ops")
@@ -120,7 +120,7 @@ struct tcp_congestion_ops tcp_ca_kfunc = {
 	.cwnd_event	= (void *)cwnd_event,
 	.cwnd_event_tx_start = (void *)cwnd_event_tx_start,
 	.ssthresh	= (void *)ssthresh,
-	.min_tso_segs	= (void *)min_tso_segs,
+	.tso_segs	= (void *)tso_segs,
 	.set_state	= (void *)set_state,
 	.pkts_acked     = (void *)pkts_acked,
 	.name		= "tcp_ca_kfunc",
-- 
2.34.1

