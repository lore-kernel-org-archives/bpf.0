Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C238CFE4;
	Mon, 31 Aug 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195176; cv=fail; b=BZZI63yso31FiL9ah8jYW4j41z104EYd7wa/7r1t3urLL0LvFeMM41PJjl/nfVwFS52+Uyc636W8lpuR5WmOf71eLfeDfYqGxaEobCFWfOjHujozJt0Bb4/rDFErQuMdfsdn+FqIbPzTJKu29JGR0g4YNtVqM89ImpDRchKmFWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195176; c=relaxed/simple;
	bh=yVloy1FfLsodevR0YO1d5la5xEMdM9mWYDNao72zqVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYk8HTkidaLadtQL7ObMHlM1NLkE/lAQgcMTOx1tJ4nDsg+kViLcfndW9HM0kAn5e6qgovBZOYaWWVvZdYIcnT2HvNLUq5iuaq0CCb3jWiu3V+Km2pCh23X+pSEx3WzApwwXwxQPyRaU6umzYF2YS0K1H+JaDkWklPWc8zTObuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IrqhbMWG; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IrqhbMWG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUVY56POUJFKk+DcUjghZSo5d2l1A00M/qFVDFxOBp0gs1xvYcu0b0jueOuMVogXrxW/q+n3Wk1Z3SYpXqJVQJMyoXjPFBklqnwGGEiBB066HVeu6KtcFsye9TjYwI3RBUbz7Lg9zL4Nd9Yp7jQRALl1jBGCmTzuchbMSTYUlZZgsuL3LWUmRub5hUU1dgeRkXxoWP7J1CMUXRNWwC3Ju76IU1kFTZCwAJ2DRrwRnnn6Io7nq7EzEBsHFQUpKMxYtaX6d2cAoRjn2kczzZCmINV87x/nKQwh8Mdmts/pUt1Sc33m6+uS1z47yywD2QRDKgX65yPU3DQkHWsYyk66ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06Nuou8WQFhROL2ZFKzLoTZCDFCYKN++RN4HF44zpSU=;
 b=v/3psXrRsRjG5zrONLcP5r7/Kh4Y5IXcv1fpGO66FlTgvN1+4qdV+YZeHqktkJBz+IYkA8AdY3E3qLS2Q8W9VILnys9+Aez8OxBh/aXWdM5RNbHFMHA1jp/hWBOlSdyiraa1Y/nCaqEjDk6xiT1oLAhNGxkzI0tjPLSzNHrUlXhR4gQ1edLIjPUFcfIh611QDbusMby1SOFQs+EpYRvAqLuU2TSYIBnznmh3BvIjoZ2S6v6oOz3a8RRl1J+/FzykPfc+8TPZwpeJyn/hxSODlkHoEtruWqDjzRr94PzneP2965f9vDQUlDJH79yOr+vW/1ySqrJgh4l0fSFTaFOo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Nuou8WQFhROL2ZFKzLoTZCDFCYKN++RN4HF44zpSU=;
 b=IrqhbMWG3b6Qm6phdl1NgosZhXVEQELe8yJmmhl+1C88YnULJhkkbOd4IiJmtUA6nrgxVWWQLhhLEnuHDO50A5iv8e1Y/OeQYGLfguBz9JsXOIYjI7rKMyDnGYxz5ZkGD9XtDX0eaov1JOyS8naXmimWu7pckh2z50Q3dImtmGxG3hURRj30Uq2xF4bjsrYEL3deGVz7aQfxbo0rJP+YywTBLFvPdaexpsXsNXn7fZfEFf3/83GFr96O5fSe/G1Fbhi4pUWZuz/5WJhiSWD7agjs4SiHeqtq06CmKnLeymKSlCfDKt+sX72hwJWwLlmZ2xar67HVs9iMh+bWAiB7OQ==
Received: from DU6P191CA0057.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::15)
 by VI1PR07MB9851.eurprd07.prod.outlook.com (2603:10a6:800:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:52:45 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::76) by DU6P191CA0057.outlook.office365.com
 (2603:10a6:10:53e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 16:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Mon, 31 Aug 2026 16:52:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 663E62010E;
	Mon, 31 Aug 2026 19:52:43 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
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
	vidhi_goel@apple.com,
	Mike_Rudolph@comcast.com,
	Jeff_Howe@comcast.com,
	srichard@netapp.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next v9 1/2] tcp: Replace min_tso_segs() with tso_segs() CC callback
Date: Mon, 31 Aug 2026 18:52:29 +0200
Message-Id: <20260831165230.2696893-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|VI1PR07MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8a4957-6c56-4424-7df8-08df078047e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|22082099003|18002099003|3023799007|11063799006|6133799003|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	qsSEmN5Bl95FIxJo/D4k8NK0TJdss0hyWUdPxLjBsCfuepU3+nW4YZeeZx5k7d+ZG7b2dKYPzrY2Q2h7k5r45/Kx3kdSsF0CMpn8lu2mjvw+Px7OefRBz8wGy3ttHZpdjGDoseav+upoOOtgJ+lwUMcOQ5UPSs4180onMJc8MDL2mS5+ch3dlTZHWLNhkyTwF6AzRf8j+kB4ZAperKSwP6dsbGINDIVoOSSH77yXugNZIqdUv8UYzZgK9Humc03lNrwT/mF1Xbj8/7WhfZ2uwcoFUXhFm6gAbpgfh7dXLow17HZxNjWS7Wzf2AhPaRF1eiwibXC/fJHFayJ6CLvOqmeT/9Zt3LXKFUrekhLgRT/K2UtjuBALhjUC8L+2KtNDWEvxL1ok8sRHZp2dZ3XbELLSKjErn8Jl8pHe+FP/n+NG7pZXzhW5CQKw7MjyHerW+YyVWhghYllXYuEyRpLQb9gCiNoVrYKL7lgVQ6N34ksWaOsPehQMaYrBAH0fqnWUkcNvmXyp+r/VhKRXyysUAdyGaLKZqgnmVTvtv+trUpC5G2VrMXMETpv7df89S8nUTlXRKKpaa4/sdGyG8roO2DlDz0GJQ8sdWfFfbHF7Xq3Xw8VVBYnnxfTJTEm9sR9Fso/B8CbVq9zv/Pc0Vob2VnX6j9syPW6qZz6ItSm7ix4WV2uNs/3dITAiKho/0E+qyCyfkPaVO/SJkL24pdKTphAEduY4kZy48CfM7ig96+TYjvVqc5H+/ipdjpi6pzBI
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(6133799003)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hZkIMTj6yUTeIF8kzVJPDKPAcwdAzCLaEzVA2mooS22NdlcmyHVeUOi6JSMTS1+Z4Vl/bojvC3u4a2k1Ki3grYz4qZa/DnWXSd5hmuhC8yaGL4TyjyM0Cvcj867EA+3z4wmYp8w/0BFPUhK1qHe4xQp2pUQQlNs2Clt1FRnT07AL7W8Zx5lfBdIspZkn8aCFp7wLoXpDi/aV5ojm607soyua0E2YHM/+4U5l8v0ffGdGIUlUjXCmNRYSEW/doI9QqNCRuPVrfp6vOvndX2LtdcytCYi3O5IoeUB/GHaMztXvM6m19hrrqXtux0HZ6FRrEuW+cKdvrw5rJKT5PCL00l4+Lmr/GS18rUBV1j+W9S8heKG+alBIlOs+TfK+DhbDgyqZKQn+Jft0KSOP1853HyUNDxL2c7MsKD/Pa7X/tW6GVtvvjRCK9MejBrjvIoqj
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:52:45.2678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8a4957-6c56-4424-7df8-08df078047e9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9851

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch replaces the existing min_tso_segs() callback with a new
tso_segs() callback, allowing congestion control algorithms to provide
an explicit TSO segment count for each data burst and bypass
tcp_tso_autosize(). The resulting tso_segs value is clamped to
[1, sk->sk_gso_max_segs], preventing congestion-control implementations
from returning an invalid zero-segment value.

This change has the following impacts on BPF struct_ops users:
- The callback is renamed from min_tso_segs() to tso_segs()
- The signature gains an extra u32 mss_now argument
- The return value semantics is changed from "floor value passed into
  tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing

As a result, existing BPF programs must be updated, because returning a
small constant will now directly limit the final tso_segs value instead
of specifying the minimum value passed to tcp_tso_autosize().

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

---
v9:
- Remove deprecated flag on bbr_min_tso_segs()

v8:
- Deprecate bbr_min_tso_segs() kfunc instead of removing it
- Add bbr_tso_segs() kfunc
- Update tso_segs() callback documentation
- Document tso_segs value clamping
- Update commit messages

v7:
- Update the comments for tso_segs()
- Restore bpf_tcp_ca_tso_segs() to return 0
- Move READ_ONCE() to the else branch if ca_ops->tso_segs() is undefined
- Update tcp_tso_autosize() to use EXPORT_SYMBOL_GPL

v6:
- Add clamp_t to avoid returning 0 by ca_ops->tso_segs()
- Update commit message

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
 include/net/tcp.h                              | 15 +++++++++++++--
 net/ipv4/bpf_tcp_ca.c                          |  4 ++--
 net/ipv4/tcp_bbr.c                             | 13 ++++++++++---
 net/ipv4/tcp_output.c                          | 18 +++++++++---------
 .../testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 670c20876f26..79f27ac9e963 100644
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
@@ -1361,8 +1364,16 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs (optional) */
-	u32 (*min_tso_segs)(struct sock *sk);
+	/* Override tcp_tso_autosize() (optional)
+	 *
+	 * If provided, this callback supplies the TSO segment target count
+	 * instead of using tcp_tso_autosize(). The returned value is
+	 * subsequently clamped to [1, sk->sk_gso_max_segs] by the caller.
+	 *
+	 * For the kernel callback path, mss_now originates from
+	 * tcp_current_mss() and should never be zero.
+	 */
+	u32 (*tso_segs)(struct sock *sk, u32 mss_now);
 
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..ed4fea98dfde 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -284,7 +284,7 @@ static void bpf_tcp_ca_pkts_acked(struct sock *sk, const struct ack_sample *samp
 {
 }
 
-static u32 bpf_tcp_ca_min_tso_segs(struct sock *sk)
+static u32 bpf_tcp_ca_tso_segs(struct sock *sk, u32 mss_now)
 {
 	return 0;
 }
@@ -320,7 +320,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
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
index 6f4dca4a4de9..b1b493d46b9c 100644
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
+EXPORT_SYMBOL_GPL(tcp_tso_autosize);
 
 /* Return the number of segments we want in the skb we are transmitting.
  * See if congestion control module wants to decide; otherwise, autosize.
@@ -2276,14 +2277,13 @@ static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
 static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 {
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
-	u32 min_tso, tso_segs;
+	u32 tso_segs;
 
-	min_tso = ca_ops->min_tso_segs ?
-			ca_ops->min_tso_segs(sk) :
-			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
-
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
-	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
+	tso_segs = ca_ops->tso_segs ?
+			ca_ops->tso_segs(sk, mss_now) :
+			tcp_tso_autosize(sk, mss_now,
+					 READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs));
+	return clamp_t(u32, tso_segs, 1, sk->sk_gso_max_segs);
 }
 
 /* Returns the portion of skb which can be sent right away */
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

