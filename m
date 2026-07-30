Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43141D65A;
	Thu, 30 Jul 2026 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412173; cv=fail; b=me41XiFWQpvqWpQhSEXKuMg8zmer1HaRlOYWaxhxaaNiFUDT2HMVexUVjaomYVAqkEkSVcqKB4PtXboEEv1AyTIv4IZ4THKzllJavywWOOkzVAuSXJs9nZtDR+nI0y6nRKFZ41j1DRzQGHVLfzXBba1Sot8qEoSCKx5U1oU3kRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412173; c=relaxed/simple;
	bh=H1Lv9HU41N3YYhUOlvw7wBWmsUxJRS/aAXeppduA0h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Wi5S3zk5LonTpsmuZm3y0dVJmqEW7VnU0oYjS8gO5siiw2kXKmmJuB2FQD/9gUbz+y1hCAZ1JoP+xodpBkio/pxPKDwVgsdvFSJ4F6W87fnlR8f+8Lwr34Om0u08lpCYvYNj6oKJLXxUNBjxJIIL2EsTxhBkwmvzWq58ME7/lJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eMrYthax; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eMrYthax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6GP9d6RaPxdbYK1WxBTI7lrFmEJDTrBWDbAmNfaSM3atObl5T6ZE7urfjSkFJuMXN3HPVdcMRnugUsLifV7FBWiROtY/EUDkno6KcomNvLykwTSw4ZG7vsE6QnlrNrlqyEHE1OQyYKL9Y0Zb0GKMhHdBjtdLSNu8KE47hB6WT3BzZgc4eIJsFfFeqBwjRx6PrS2fUI0PZpkbye5YlxqClAjeoq+irfzbeB/Hji9d2T+1kLCXKhMJGa28sMNR7CN65vBEWXBJPK+3yzYL+VQYKZ9id8gNUhq/3Hsv8EwC06C1++mdsG9R7/BeLR4NuvRsTyPyjSVHno/wDmHZfFwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN51P9BAThpUTjOdDAE0bSTlQVxHi3BDwS7ZFlSzx3Y=;
 b=xY/hs8LvEPkkpr2nSE91GYmh1AClaS8+ybx4XtssCwAsv3w/TPsIuPhL8l9PksFW79G7krEBjzYSY3Gf7LKuhsGpQGsFmb1P5PS7qqv//rwqjbawaC0tZ1OkW2r4wfe7KYqqK1x3eTX8Vuula6gsE6a0e4FtiQ8itjEEd8p0+IdPSDe0HfeDHKOFiJHUjPuwkqIomMU5nTlsmVHdaFJ9YNvWG2UecnWLWuSTR8XcJp443WxCqUSFDREyGFSchVRLD6nQGriKT2gVQq67BSOxzhVh2DTcnWpnyZv8B4+CnJK8bHaLzXDraX7CTnYXjt+8mWaAbMgxWW7SKu0LWN+S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN51P9BAThpUTjOdDAE0bSTlQVxHi3BDwS7ZFlSzx3Y=;
 b=eMrYthaxiz1SBIrG3r4/+YLrTJq+TKARIlBVMiKsS0bNGk/oDW8hqwxL8Az6Ch+eWSZLd4x1TIKmrEnk7Nf30dUJxVmaKb9AdoDS89C0meqN9oIgQD8lkY7t1Et1KHKLOv1gR3YH5ffNZnoLo8EJxGw3/Q9pUHOyncfsilbKheyeJoGjHotVrUThOO1J22NASR4++PRKwbo1NrOUj/H8okMZh/z4CeTfq8RKdu05U3qWxaA9SFRaTVFXRftUgpRAAKrBD5jfvtYd1P14cfkQtl0YJJZDWyVXrFyatOP/F+C5hwNSAUzbUAAMzAdKNIuXVkVlg+l8zYxg5M7Rh9F4ZQ==
Received: from PA7P264CA0123.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::18)
 by VI0PR07MB11665.eurprd07.prod.outlook.com (2603:10a6:800:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.9; Thu, 30 Jul
 2026 11:49:23 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:36e:cafe::81) by PA7P264CA0123.outlook.office365.com
 (2603:10a6:102:36e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 11:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.1
 via Frontend Transport; Thu, 30 Jul 2026 11:49:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id C6B231C003B;
	Thu, 30 Jul 2026 14:49:20 +0300 (EEST)
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
Subject: [PATCH v6 net-next 1/1] tcp: Replace min_tso_segs() with tso_segs() CC callback
Date: Thu, 30 Jul 2026 13:49:19 +0200
Message-Id: <20260730114919.658373-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|VI0PR07MB11665:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c81159-9576-4dc0-d461-08deee3098fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|921020|6133799003|56012099006|11063799006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	zZ+CVxmpcn+Ex715jXVa3tF183a2lmriVCaYHn58Dw9VLKIvKyEM913fwxh0p8T+bQejWkWt8lh9ieJQdpF7ff8foBafVSCcKC++i1NnG5Q+li+Hc4UE0+dXjaP5cRdSNwjgfvfzKxBp4D2eYGiQpLniqWULqTCqw+3nG2YZhy/VQpDoXL/gqXK6Ap7PVdb7yu4XgmLG92uG+f8BGUs3oP9AJZOvRHDTldfkrFexPdrsBEiEc8JU9Rk/4JQcN83lQ0HIpuBkHdIPpVzuR2LEaeQ1P3+l6vfYqXbxiCaDKjRazF0lt6DH8m8C+Knx3mkxtGlhxshRrbzso4lKyPrIB7pEYsop+95sive8K42PqU/WXheAF/Fk5HHR1yS7xuMSxGrZfKKHe2mYx6iYS++3Q6yMCdx+A/yx6hn3yaY0tKPqVyP4Qhj/qKKkDA8EAq3Scu79Qo8TyoEeQOp1lCwuyKUg1VflF4Kr/jnsRvQohVjp413NjVPtHOrVLJRZ19S/UCNww4pw6ay5l30W/laQpmYdnPxYO/h2NoPR5YtN7DsJf+X7LXN3I35/hp9XNY9OlKLufqNwS/1SbNEON2TiS6LcmpK5N05EeKPbAMf0N+AYXVyW/UU3twPeASD3Fa3LK3foX6uu9eBwJN9MXMFIsnrdmMx4CPC021WHjul8qPqrWW/Segw8OiJvUHqf/9iRASTJgCX/DlyurQbYpxxS4aHY9F8qJUZzCw8A12nXB+L+/D/fuVuVxGCcS1AhawjD
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fEDOf1IBd6IC0KR1KAh4aTZUv4LAiy+Bl/imVv+bQ5rKeLJS4o3fDgDjGdqM48d60mx31Rbxj2nR9CantxWrVtruWCGheC9Ova0dWUo1K6RHQFKca6TwlU8Vo6dENBMhSWsRAftpURk6JuAQKKgdO6NmN0cv24F3nrCdLu9AecLy2l44BYOmMPWkiOoq7LlCijeEiex+nEln0gkZEQeJymuQV5sdl5EW1NfsVWPDTwkS4LjK+bX0KRvJieGpsNnbD3SjbeT0Yp2JKukQ7toWbt6ZZXZ2tcU4FLHYX8JBEBXPg1i+paILob+YS/Bg3jK/LFyfIgyoO23IOYsbiHza1VaqP6iu32/xQU9Fwq878Pna1tU3mBaruFg4RDSX1jljikChHS2Nrrle/nde64I5ZYGKg2eAC+dOp1mgP+Ts4p+AEmxzXaegs6d25fRbf7yq
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 11:49:22.4454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c81159-9576-4dc0-d461-08deee3098fb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11665

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch replaces existing min_tso_segs() with tso_segs() CC callback
for CC algorithm to provide explicit tso segment number of each data
burst and overrides tcp_tso_autosize().

This change provides below impacts on BPF struct_ops users:
- The callback is renamed from min_tso_segs() to tso_segs()
- The signature gains an extra u32 mss_now argument
- The return value semantics is changed from "floor value passed into
  tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing

As a result, BPF programs shall be updated, because returning a small
constant will now directly limit the final tso_segs value instead of
specifying the minimum value passed to tcp_tso_autosize().

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

---
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
 include/net/tcp.h                                | 12 ++++++++++--
 net/ipv4/bpf_tcp_ca.c                            |  9 ++++++---
 net/ipv4/tcp_bbr.c                               | 13 ++++++++++---
 net/ipv4/tcp_output.c                            | 15 ++++++++-------
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 38 insertions(+), 19 deletions(-)

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
index d7c1444b5e30..d9bda3a84f26 100644
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
@@ -2278,12 +2279,12 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
 	u32 min_tso, tso_segs;
 
-	min_tso = ca_ops->min_tso_segs ?
-			ca_ops->min_tso_segs(sk) :
-			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+	min_tso = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
-	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
+	tso_segs = ca_ops->tso_segs ?
+			ca_ops->tso_segs(sk, mss_now) :
+			tcp_tso_autosize(sk, mss_now, min_tso);
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

