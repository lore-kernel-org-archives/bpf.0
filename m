Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB546D0B0;
	Mon, 24 Aug 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589116; cv=fail; b=orFKNdwDXN/oyxGZkHesIWlXmH4vixf7gYRKiRzxd1/0PXi33/fifcJv/jS/pOSlTDYrONqI0dFOaY/Z5sPyASu3RChKRWrLGcLN0jzH1x5m5JovBU1w+NHuXV5KR88UoSLmskaqVvBicehYIBlHq2Mq3ntcFssl9by4qpD3Mzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589116; c=relaxed/simple;
	bh=1O04oNyzlQ5F81p0pRSvN87n27RDb6CXEWTGeHUvbrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdI46orhVcunZKc4p9C/ZMPK+Za8gxogov+Omxn3pKBElJEGbMwdvT3BJcxyau3ps9M3WhMDEX0VpZXGSbigH1eCYsIzGnJE4g+nghz/GG1Ih5rdfGeRoFb2iB1O9PoJPlN6YnyLVd/E7RMnEZNE8loQKueT6Y7WSvaAuJN55jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=o1xqYbyR; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="o1xqYbyR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syMZLU5GktBYgci2Gx+ByNQ3c+Tgk1B9s2eln7/D9p2H/xdF8O3N3c15HTQX5gpwXOLnWCZYK0KsI/RKfhH/bHAwY/CPaKGEURTQhclriZL4I0lipnF/nifBdZkPLFrpAHGcpGOJHghsv4iGmVKWEXP7t7+bi0bQJUNbmLMkbHGlF+5XZ9MVg/HLBWmuSz5q78ggocFAKU6QuJyd25ico78GwJI23pFe5yGq6Ro0N2Gq0AEkj2MuAXBerCvpZaU47ek3hjMvPBrQCHUHZb1j8N+8+2JaacXMtdHnBFNgBtggUePSOHJ2edo0eKrcVh/+9Uboqu+LRp9Ecje282NsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRCUXlrdDspXx21k31Kb+MZyfeMRajpCZUrudOUU1y8=;
 b=Ts7dqLj8YjAx+jJm/hNMx0TfkGVVSnfQuN9yidU7Jm2YVVKNW1FimCAvKny6YzvFP3UyNFP7P2x9xk+bWRWPAecRiGiXhqpX+ovG+y0CEUn1fUSiiZlpuw7+b2Vxy64rxZKHwDwQ80gUqHX4rkjM8sOLyY1O9u53VqwKv5tsE7QmW8/SJJvgXhR1jHyF9TKUdrshpDA5OBfnX3Ia/Dd5X5IblE8pn/M14NgHPyDdtqM2fVseNn+BARk/IZP2dY47T4PjkkvlxT5e3/gXeHNRGWHBdbG2oJyF0G/VBSSQMo4tddG9kksWiE4qMzs9XJlbQY35Z6XGydacA2fZMO3AFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.85) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRCUXlrdDspXx21k31Kb+MZyfeMRajpCZUrudOUU1y8=;
 b=o1xqYbyRpfoxyKPw9UBL1FFUeXMnpzBLCRzjrlIMqrKp1Y7SUDaaKHQOpQ84M2G3kP/APDkFL8lclVbAVNREZj98LjtMNN3694bkn6JruACK1KDlDpoVena+cmzRrvgYnOIx3+Me4iHX8n73nam6TdYftaQH3xBDf/QHK3BCu4MHBUsW9GVl4QiK2LuL8PylwiAW5JblXFtDbpsTcYU6TR5yUta/XK71WbudQrVPByKoWqmwJaKoZQ2lw54FQRleL5PN3LPt7C6TZ1bB7Oe6RI+sV6qy7mPPHaWu1drUZ2d2yBjatRP5aDYH50Nl25pttpWxwWoFNQxm+gQxyaBE6Q==
Received: from AS9PR0301CA0057.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::11) by PAXPR07MB7936.eurprd07.prod.outlook.com
 (2603:10a6:102:139::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 16:31:46 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::66) by AS9PR0301CA0057.outlook.office365.com
 (2603:10a6:20b:469::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Mon,
 24 Aug 2026 16:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.85)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.85; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.85) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 16:31:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 88EFA800009D;
	Mon, 24 Aug 2026 19:31:43 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
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
	vidhi_goel@apple.com,
	Mike_Rudolph@comcast.com,
	Jeff_Howe@comcast.com,
	srichard@netapp.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v8 net-next 1/2] tcp: Replace min_tso_segs() with tso_segs() CC callback
Date: Mon, 24 Aug 2026 18:31:38 +0200
Message-Id: <20260824163139.990734-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|PAXPR07MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d35a9a5-6d02-4fc3-acf5-08df01fd301c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|10067099003|3023799007|56012099006|11063799006|921020|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8tg6TkyhmiDTHTnbVxn/m15bx4WP2NVxxNZgcbnackGO8aUKXrod5tlTF5hQp6NGHqMT8VCwwi+OuM067Oo675kHjs0sUQW5s2WiClWv6Cj/kD1OKEOtwnWl3c89khV6Ejo6UNHaLihy5wTEFkyqyP1s8ep+EtQiA+wSHzoimzKVhc9IWn/RYQnKVGQmqi214e2iBbaTNd1x9fU7NMSLC5yuDQibMl/Suu/FV3JtQaN+8qhtpkcvK7Bx/AGYljzwxaVGfZpud3TCNT5isS6ODwQGkgjzrXEc5Z2k7J8Khhc7cQN76PLcFikJrXUJk+0B1nh0uJdOflPlP/kdDDprbW8V8V/lnYgq/eoLcmjHRuJlZtgYTNBi/VuASXoFES8/yjlbQiMGRmEDtEvfsF15AdBvOEBz1LMCbvc97OKfbDpUUW0loPwopiKJ6xZD8YskQ+hcM+CmxY0I9zUdDOmVlgVwKSObxi3xWby0dtagVVvOq71f3xs3m20hkTd6tG0XXvPbVCKSLqffvvm0SKdfTvVUEF93w6WdUAnA9ARjeFOfTpkHoUinbxKjLx1tsJZ0NTwg6bft/+UjZPdO2KBw/1syppFW8wAiZ8Sm/eERrxBAfzFJf59sfiNPgSjVzwcIQVx7Mwg/exeHqL2lj9mpl9w5zqxkq+3EGk0Z5e20Cvxq/09ZicFcaYqg8sGenMFdTjrgG+34FU0YlOyFtdgIcO4YQ2ZTE9PftcAdhL2LibsBJx0r1euq2eENoQsQr6SB
X-Forefront-Antispam-Report:
	CIP:131.228.2.85;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(10067099003)(3023799007)(56012099006)(11063799006)(921020)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wRjf1vVQo0RHFG4Xl7Qo9Z1BFFsUCVLId5zWOU8e1uTO/ixHup1Oxv5PR3+W0CS5+Aj/FQ0A9kavQwzsLcGXEoHIVD2E8hH5EY8+VVlpiYjXcus52xT93ESw6OH5HebyRs4KuU1KONdBTUu/IA+3WUc2b0/RcK14rxTsM5jJ6+LNELr7F7nF6AR6CaDE0vrpX1q8p81l7AoAvOxbOvEuyOlG2pxXVOA1o6V+EJcUqb8QuCHq9xJbeXjZBU9kKGvBI+3V/oa9UhpZEzNqF/8laT68qtPAMNHOw3qrA1YuY7mwCu/LUgO5q/vRnan1QdKcDR+sXb8usSuHdsu3msKH2u9hhUJYI+41pSFBavpFgZ17eaboCeDOhwwNh5LzK5i4qDsq95jSE/h/97crSuz9PWNMEe4H5Zxs9eShTYdQgdaz6T45xBas8RAgC/S7s8vS
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:31:45.4684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d35a9a5-6d02-4fc3-acf5-08df01fd301c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.85];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7936

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
 net/ipv4/tcp_bbr.c                             | 12 ++++++++++--
 net/ipv4/tcp_output.c                          | 18 +++++++++---------
 .../testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..7ae91e59dd6b 100644
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
index 82378a2bfd1e..c92d904b13be 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -302,6 +302,13 @@ __bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
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
@@ -1163,7 +1170,8 @@ BTF_ID_FLAGS(func, bbr_sndbuf_expand)
 BTF_ID_FLAGS(func, bbr_undo_cwnd)
 BTF_ID_FLAGS(func, bbr_cwnd_event_tx_start)
 BTF_ID_FLAGS(func, bbr_ssthresh)
-BTF_ID_FLAGS(func, bbr_min_tso_segs)
+BTF_ID_FLAGS(func, bbr_min_tso_segs, KF_DEPRECATED)
+BTF_ID_FLAGS(func, bbr_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
 BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fcaa04e65189..7d3e0e715c4b 100644
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

