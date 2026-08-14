Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD848D879;
	Fri, 14 Aug 2026 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728658; cv=fail; b=Qq8v6T7hWws13sBXN+jJC+fDgVGy22o8uGetxVV1bmoZHCKwx3nhb+epDsjZq2l2OEDia63j4dffM9eymY8iGzw+OW9N8lQG0gSL3DvJrvDLQRDrbZfImvEQLoufCZ5RyvEt7C7m5BWj6Y3wmpOpY6g9eKav8luuAzqAXrDsWWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728658; c=relaxed/simple;
	bh=tBwbnxFIR0sap4z/RkDqBpuxCTRuXHavhyPRXHFHUl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLmEm2uAYoRq1rs1N9ezXvWSaHoA1cj4H8c0c424RP9O/MvXAGTqcULpcbElL7aD6Nx30HnfiUWqKsuGFg8tbETAvXL0khk2ZGjaZ3M7o7Ykd8uOGFRnGilgClR+ZMYLvOngMsu1mXgeavBCENFj6tsUsqMeHXsyl7cHUqRnwAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EgnUAvDZ; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EgnUAvDZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3UWEt7Ze7kHQUNk07hpjUcAWKCOU5fgYCcPAsv4NmerKKhugx8C9GOuKg5cAffyirPV96wNh+IL9YXWOBj3h9DlkDcpJ8K/FDtmjuYDiYSj38NBkcMySYn70Vl9ancGvg2D2cqF3pzCx98zqWFzbSp7iK0aPXMuUrOLUp56iIQI7j9Af+XYOZbpfvHQiQ66de9wjwdQKcWTCS4vWvUya9y3T4yaqdby7eYuFIbumHmtEv3o+dxtjqReL+RmezBjinbE1fUaBaIN1Cl5DlpUtTuVR2OpdJ2McpG1lKCbSq5ZJ9j4SrhBBWEakBA7EIt6GzpOZDWbtKyjX3E+ONM9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEV8jrPdv/Qy5J3dSKrHld/MyGu4F0VoE6OkduAWogY=;
 b=oqQjR1Paq9mBZF1lXcyoK7rMpB3kSvxLSEbLQqN1pUeiZhTwK6Dnc8U7voFIL0giURu5kIec/Na5W+9ZJ1BmOzKuVs6zqf1OtcYc2kYfdDC+gp+j2XhEpWINz7joFRLwFGMLTEuEMgofbAyCK6xwkPoK8DkveTJtzc2yUPHNDvZl4eRlOe45Y5DFJp2RsGKJpbsINGcovSz19KYP2auTIo4gjHPdbP7fTFWHbbq99jnmD7vjdhIQQoZEe0HUsJ2fkXphvmuFXeC3c0RSXjDvacfldhCUPgDpdnmwVhGudmKvMP2em8qYuNoR3hrYlde7Pb7RG9oCcSwvj57b6IaMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEV8jrPdv/Qy5J3dSKrHld/MyGu4F0VoE6OkduAWogY=;
 b=EgnUAvDZmTbx7a9ZrocrwVAQk5iCw3VhgLUwnz6CLCPUvJZSP+fdU66ieDO9V8k6gtPiR/vpNWzs3zwonPvjTaR/s4fOGB3vQhM22P0RfbiMoXxW5zBMmF/waO8dWnPwN93G46w/D/00s5pCJxA3Syn/50y7UnbV1Rs8uCgr4Q5mI4OJD00rCTEV5Mn1WerE0IH+c3fsQyEbDcp0m5aLIXx30lraU5XvmgIGUo+P1QVak3wurEvdkJkK2xNiPoPyNZI5C3pjsfGUJHXvYQgKw8MZwxIhewHDkPNnC3I4nPHZObWbixJ0MhGNhnQlzIoqRwhK5+L6GqwxTGaVplEd8Q==
Received: from AS9PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:20b:465::22)
 by DB9PR07MB11089.eurprd07.prod.outlook.com (2603:10a6:10:5fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.5; Fri, 14 Aug
 2026 17:30:46 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:465:cafe::4b) by AS9PR06CA0093.outlook.office365.com
 (2603:10a6:20b:465::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 17:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 17:30:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id A8865800009B;
	Fri, 14 Aug 2026 20:30:44 +0300 (EEST)
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
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 1/2] tcp: Replace min_tso_segs() with tso_segs() CC callback
Date: Fri, 14 Aug 2026 19:30:33 +0200
Message-Id: <20260814173034.749151-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|DB9PR07MB11089:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd4ee73-709f-4404-51f1-08defa29c6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|921020|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tRTSyPNr7fe+qW4rh7E2dT0ozG0sbV24ZbpTXGFpSzAtZ6xGYqe5HPq3rllqT9RIB5Z+CbE0mlNtIY1SlwCNOhGKzBjUbuwfk3PotxH41Oz/XFVdUATKfNetbS4B56kfPQC++9C5EitBi2gKFSs0jOgi09uP+Xru1vNe/CB52YY8LF/wA1nVbuVihmhE1d1Hsjek9wPdVo5ApssN6wTpkAKv2sqruEJmnFLn+8zriT3VRAyk/ZIc+XgeeojlCPXlgOMREw3g3Bkx9yxESxsNFoiPXiII0IqZoG63KrrenJcNIsmhMzogIg6nsBLTuYlsvIWCGEa0S+29DwbhKhpwmnctHiqEGR867me4yHLpkW4zJkplrXfgQwmPUhyGJX771LMvQQHOisDjiUGF6p+tYbcV6jPHNaBzbMd9fMT85sCG2IseewMXgbqciiT8jlT4FS8ymmFWSOqBO2PD1YSDyu7o7bmr10UTrmeOeadRfqpEHWVFDPnE2fklEBDeLuYx/yTcS+kxg2Z6/6kZomAQf5Nf6N3wHz2nhAr2580dmmm65xV1f4MSWEBccdD1Udjvz7dYzkbvKOEGG5TJZDgJhlMWcptjA03DusRkyF3E/0rtD7mOP9IV0r9dhsZkSfp8AyriA3mRuocuySLCwO/EGF0Ik/fs/Z5r9m/MXcqZlKhhtbWObbHLYMsUmESGrTm9K9+S5c1a7LIJPNOBcEpJ3iDVCIgX1r4kNMlDxaxjtBSncClPujJiqnEv2ktYG6n/
X-Forefront-Antispam-Report:
	CIP:131.228.2.84;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe01smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(921020)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tj09O5ASt9QSpvRNfs+I49xPn04GH+v/NBAMumUkmUG0Z1o02TsHEan2CQ7NuaMEO235rRv+r6rkgCfuxhAHjBhd+0pLtZ35eXnNGATfF9ooTQmemheQYfZ5rMH5gyvRS/iMkqpKgv9e+D9iXO2mODsXvQVL1nNTJpbOK6Z3pO6TeIyju3e1pnehjYfwr/wsSHwc/3xZTby6Kx42bOyba6QmfIn9w61s/xr0t1/jPEVKjZqPoqtApBD0bT6GRdmagUu/2fkuzGPoAUSi7AJcOxfy1gHf9wfgkvQfq6NWE/3rLLwul2qAy1Byf16KN5sGGKX+6uAptGAXlOm3vGWothTmbIboSgujMMaxv79PQr48MKtFG9tCICJTGxUNeD8wyYKAV5XoqmL2+wlU2XtVXMOhRgCOz2oDHKXI03I8TwGd5pWs+wZODSAEz9IhDkV3
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:30:46.4459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd4ee73-709f-4404-51f1-08defa29c6a7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.84];Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11089

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
 include/net/tcp.h                              | 12 ++++++++++--
 net/ipv4/bpf_tcp_ca.c                          |  4 ++--
 net/ipv4/tcp_bbr.c                             | 13 ++++++++++---
 net/ipv4/tcp_output.c                          | 18 +++++++++---------
 .../testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
 5 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..37b95b98f9f9 100644
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
+	 * If provided, this callback returns the final TSO segment count
+	 * and bypasses tcp_tso_autosize() entirely. Implementations must
+	 * handle the mss_now==0 case and derive an appropriate value.
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

