Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB63D3309;
	Sun, 18 Oct 2026 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358132; cv=fail; b=pwqOhOI6zT/Ihnbban3xDEDSapz1SJP2Xrk+9FswXJjdqa7O1GwNdyMVF0rfX2E/bfpwkUoZCmZqDgzeBuJu2JMqXhSUMXXcdVfohBRg3BuKWDRwVmJFK39BorrrhPNpHAoKbaPkP9z855uOGHd26Xofy4uL57pBraM06Lir6Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358132; c=relaxed/simple;
	bh=/Brj2p35BU4PrwyB9kMnHRAhkkMU8ZQgpt0dnO/ZtyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOz3fp7lpVZDDS8ofZxedO9fXUFO5VmHRiXBp47UYpU/XgppEVwdeQiaWLRf6+PF1CxpY1O8hpezn0Vc0Bh2278iS+AbghPivw1jxgZJQpKwpZRL7ZOQfctlSzNUtjVK30Gv+HZNoz+B+RRd9XL6dKSe1CVzOmJDXImPZsLdb0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iXeLfShr; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iXeLfShr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIWPhbmp4OW1ltb4njnxdGuT1UkmeQAuMZdpMaJYb7/vKjeY8+zYy+edCWEO3AjYOxGT3KNEPnYoZT5hbemM3qQT5yn0L5j9r1sirlMk7UsfTTjyVE/1WglE9qeViYM6n3KofcQ6sTwDhqjHUNBSCZjBmEauNY4OxTMcdqY5x748MMnXapcxCOFJWtOkDj5wxI3cGBwBa7GV7r6hTsgOm11Dn/Yr4XNHLRFdBbkrkk0+PmGe5sx8HA+qCJFLDv0N+gTWPa/HeEQIvk/k1S78peBiv2HAoz8xqdF8f9MAvYW+aq5n7qpWsSo45qNMdKadAKNJkaQxyFYgLEV7xpcHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoQxRfheub54oa9bM1462/S7Qovlg3deRP/BrExfWPk=;
 b=N7PQxcALkHC3mLJhSezfJgvmY3+cOu/trnY9YtAPzqm4GO/Y1En535hpsqQExBIBCvZc+hwpgS6q8AFpBJskPt23ua7x4lXwpRMiZ3k3J2tsaP5pWCtrYXvjoK733LqT5MlGKEtd3KpFDJCkQnsIW9vU/03BP7J1X5wahhTd9trZ1QV+TsoCQACI/gakPucadHkC86niVIzEc+R1N744QoET6Vh4t3jQGMYjmb5r/bYaP89Rl7+0T/XIG93e3TBkHAfSCmTl7fOG/LLnZFdZPdMDpPvX3lZNBq1D+3QWg2yfYWs9X7/DZPDplPz1aXHnu95GMfu7+nUvJRePRCwjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.1) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoQxRfheub54oa9bM1462/S7Qovlg3deRP/BrExfWPk=;
 b=iXeLfShrdGit+s9MtcmCVDyv6rQp/T/GfjPcfk4iBGmiwZuc5JUSJbh0g1LslXlT7KB5FHIzMA6eeVI+p5YgeqaG4oCmv+Akr9INWbQBBMF9AG3HF7C65VihT+NOh852ntVJLk+CbAADowm9xByl8J2hYGCCrKC+wI5mbH+PPbblHqUd7UI8RsDnKQOX9UYFjFfGwSOKy1wKWZM8AY9Vesj2lck/fHgLwqPHpZeFu9lqxrmuMLRQwcFXIXvCLSbdUPmbCtSRYOvTZX2rj2AewGExYsPU2z0M2ad56wsL3auAbIuVMjZ9MejXH1VMN5uhOmACh+8Ege9KBeEQTS/QzQ==
Received: from DU2P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::19)
 by AS8PR07MB9306.eurprd07.prod.outlook.com (2603:10a6:20b:61d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 21:15:23 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::2f) by DU2P251CA0015.outlook.office365.com
 (2603:10a6:10:230::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Sun,
 18 Oct 2026 21:15:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.1) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.1 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.1; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.1) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 18 Oct 2026 21:15:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 37905800008E;
	Mon, 19 Oct 2026 00:15:21 +0300 (EEST)
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next v2 1/3] tcp: accecn: Add ece_delta to rate_sample
Date: Sun, 18 Oct 2026 23:15:12 +0200
Message-Id: <20261018211514.2817293-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|AS8PR07MB9306:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ab88d9-337d-4ff1-6443-08df2d5cec1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	Xdzs84wmav2M42oftX0dIR8KHQniErj0735Bl7bjxi/FcnVNObSKCn1FNxGfLJI4Fz9fB0H++4+NPGPtpsDX0NLkI5HdvEsMJznmdgs0Z+2z3DPZmjwmGzmVdles4cYHjCyvM8MV5djlbnSoS9J3BbcMhlj5aBt/t3eEJ8oID8uLIwjhnghL9EzbuJRoE/hp7wd05hsb4Jp6TPoOcK6gClSK9VNdNLfx49N8s9gEFaFmcs08rYOvUOFBEjqtZ4SDCE2ViX+GtVY+RUTCSJevR0cY5+trJQtt21yfgFKct5dZOmj7l4mhxm7ae+Al/qriEe5EYcM1tOmQDhuoP4edeOUjcMazg0UU3lDCI7ZEsQLMmCycBpN9Dr38al4eHb3R29gBSWmDwL57omZ9XDe3NPJATPvQr5Z7gts32AvOQzYtuGqQjrlRvCDCjE1NSAXkn9Ok+V1YGrivmTGZBYlPN06xSQnTnW8kPPAW2NjwUnAVrKQyICbXzVI5DauCfq10gBMIkX9vEx/MlkAt+DKW7axxDlSbheHQGC5r96ErO8P4/D+HzRuFAfTGYaZqp20umpMlPzTfvq8ku2eJeZfn9eNvzMOIapVijPIje8G4xvgdRT/Pe6IgxUzS+KhwO9tEl6Ax4uYaTlSsRi5CBGIxsNVtZXygHkPZPWPSR+/Z6YCvSbWhFr1QqMH0+YsEZhq62O+2Vei8/XB8xaqMVl7R/7G42XR+zXyAzlhoxc7jFURLZyc6mHEMvyJ41DtZmhhc
X-Forefront-Antispam-Report:
	CIP:131.228.2.1;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PnbeMA4HkBpCR6pJpuRlR4MlqbmFavYGRm2Z6nxn92YVQ7v3pusIFXYCa1RTjCO0zQYJKDgWMr8GP23sGJt1pbIdTDVi29y3CHPm0a1iIhNAbJVrln2CHkPz1iRtP1+jUgyQNHhU2D9RcoPuv4M5lvbwVv7DppuAqK9tk6jQw6uZPDKeVKhA4unlATR19qt1JYI2y+sF6kqfxA+Re8T99wU+poLQ/p1T8aGRRccIAowhzwdiXtSzjc4/YNZsF4/QQDedTNkQQYShcMzit6vYQSXQFu9tgpaHHVgXvk9t81+9FyB5ckynvs6MTnXn1xl4jQqy6lTv95M+AtCCAzN6ZS61bXZTpkkxIvZjTZ63pANeBGWsBb0ko7VVLdoUT+4HF9fcORDWWSTkz5MdnDbKfA+JOWzK63vXnnqFIZ2s2dKZiEUNu9ITJib2dcrZda2y
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 21:15:23.0739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ab88d9-337d-4ff1-6443-08df2d5cec1f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.1];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9306

From: Ilpo Järvinen <ij@kernel.org>

Include echoed CE count into rate_sample. Replace local ecn_count
variable with it.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 41 +++++++++++++++++++----------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0265c27a5fd7..1838389a9d8a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1346,6 +1346,7 @@ struct rate_sample {
 	int  losses;		/* number of packets marked lost upon ACK */
 	u32  acked_sacked;	/* number of packets newly (S)ACKed upon ACK */
 	u32  prior_in_flight;	/* in flight before this ACK */
+	u32  ece_delta;		/* is this ACK echoing some received CE? */
 	u32  last_end_seq;	/* end_seq of most recently ACKed packet */
 	bool is_app_limited;	/* is sample from packet with bubble in pipe? */
 	bool is_retrans;	/* is sample from retransmission? */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 02ec0b0116d1..a5a7302050c4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -588,9 +588,10 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	return safe_delta;
 }
 
-static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, u32 delivered_bytes,
-			      u64 prior_bytes_acked, int *flag)
+static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
+			       const struct sk_buff *skb, u32 delivered_pkts,
+			       u32 delivered_bytes, u64 prior_bytes_acked,
+			       int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
@@ -600,11 +601,11 @@ static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
+		rs->ece_delta = delta;
 		/* Recalculate header predictor */
 		if (tp->pred_flags)
 			tcp_fast_path_on(tp);
 	}
-	return delta;
 }
 
 /* Buffer size and advertised window tuning.
@@ -4220,8 +4221,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
-			       u32 ecn_count, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, struct rate_sample *rs,
+			       u32 prior_delivered, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -4232,8 +4233,8 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
 
 	if (flag & FLAG_ECE) {
 		if (tcp_ecn_mode_rfc3168(tp))
-			ecn_count = delivered;
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+			rs->ece_delta = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, rs->ece_delta);
 	}
 
 	return delivered;
@@ -4288,7 +4289,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_sacktag_state sack_state;
-	struct rate_sample rs = { .prior_delivered = 0 };
+	struct rate_sample rs = { .prior_delivered = 0, .ece_delta = 0 };
 	u64 prior_bytes_acked = tp->bytes_acked;
 	u32 prior_snd_una = tp->snd_una;
 	bool is_sack_reneg = tp->is_sack_reneg;
@@ -4299,7 +4300,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
-	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4414,10 +4414,9 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	tcp_rack_update_reo_wnd(sk, &rs);
 
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       prior_bytes_acked, &flag);
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4443,7 +4442,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+	delivered = tcp_newly_delivered(sk, &rs, delivered, flag);
 
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
@@ -4454,17 +4453,15 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       prior_bytes_acked, &flag);
-
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4491,7 +4488,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
-- 
2.34.1

