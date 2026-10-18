Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83E4DE735;
	Sun, 18 Oct 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358137; cv=fail; b=TnKnxXR9Qt/fX5qb6mno7EzqfrhIM0DO360qEBwcgNEF87G8aaPcHYH6pX5894pfgnJYkUUql9dbJ/9UrVey6wYP5CtxmVeqcl5Hs/a5fhvtP2DCYPD95VqZmIDVID1x2Lp10EKHtsOZU9cW6cdI874AP+H3yylo+XGA94bLdi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358137; c=relaxed/simple;
	bh=bqp0j/4DrKEYJxKvS/GBuerMJRhtthuMa307fFVHC80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVs3+04xakV0xemMCYtb5A5EhVP8vfiIx8I4ReJlvXuPeUbeY/ZU9i5y4pttXgyrvTWU3KEeZM4EjKBnMln12sbEwclFykTfcc6F3mZQOVlD4CS9xYFIIqqOi246jIBnsLqmQX7hPs3yUqJWAnGdWgz2+bCxOY0YGcc3lCUTmPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=h5LBQfwo; arc=fail smtp.client-ip=52.101.72.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="h5LBQfwo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuuT84+e7BKa7yHQXtXfz2lhMbzpaOHczp6wNtPvRlGE1AbPoezUY+BWPgp5ykEv2dLYBbOvReKMUA0mu5vjigoevTEgoxFs4w3XOLpw97OE0yMHSDFiG4+E+brJEBMs9bWB/201/tUCf+2xapCy7nkDPVhJjYG1IaFLf6r8g86n7IDpvoP6KU9cLpbWqpHHO9ZbtQf4aX6g393NVEipt7SPuoTmGG31zzZE9iNPlN/rZ+LlStXOM/fPCHl3c+E0joAgzNxeAEpK8NsM7aqj+Os8O77RmI+Ux5hdBl9lbwWOEv6ogpLViyh1EtEGFexr7pcHARXJbjtCeEWYur4oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBghBmgst/t/7ZM7m2kptd4ZiPwXn8CksvKtH5IMzT8=;
 b=vt+E7EDkymEtzca1sIRTx07Wr/jSl+NmavfQjlEU/w83m3ae674ghLk70tpU5H7+f78ffSYGn0XphI+E6W2Ke0G0psvx4NAyyiLr0m7ICO9FT5ybRVIlhqgRA+Ug7goqMiYp8WaOxSVUfnIrx9UoD2wjDEgyftWteOgZYiarMx+wsP5x5olGllmdprtZKJ+zLbJQzcPpf0yAvGdIADTbDy4DGqu5cxwrGJh3wVI3siu22IvexkUSB/p/Gob+8mFJxwVOgV0WnsZQuaDC91yZtBcCkmrrh6vK3SBrpDnvfqwRe6+hA/YjbKAeytzb3phMvKFiSYtg9qpwrOojLJAryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.1) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBghBmgst/t/7ZM7m2kptd4ZiPwXn8CksvKtH5IMzT8=;
 b=h5LBQfworK66bhAmfLgjwEDGkb2sGiQfkcWLwlviZDlUG4GVyM68ToyWHJQGJwt1D3iVr64YIVsoqr44JY42Ey2iRF5jmQC7zLKRwdn/ppbA/uhZ5dlBuz4P1Z1jZq9eaF8RNJos5c87DAi085Wb8VzfIqoZOEUYDVKjmNv+0ZCSL8mJ66LKQg++o2ab2dsgjA86BezSC/jhzc1hNxSdBMVq/8pnMDg5IBPpHoZhDzKQNNWrAug8mNCd+aybPlvjqMv6MlWPNhy3oLfIMlxLuFW7+kxeYxhsY0pQC5GB/+/yW5Lh4gvf0S0ImdFKw9jCdffvxMOjca7bnFACCAzLFw==
Received: from DUZPR01CA0332.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::18) by AS4PR07MB9629.eurprd07.prod.outlook.com
 (2603:10a6:20b:4fa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 21:15:27 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::42) by DUZPR01CA0332.outlook.office365.com
 (2603:10a6:10:4b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Sun,
 18 Oct 2026 21:15:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.1) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.1 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.1; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.1) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 18 Oct 2026 21:15:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 85C24800008E;
	Mon, 19 Oct 2026 00:15:25 +0300 (EEST)
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
Subject: [PATCH net-next v2 3/3] tcp: Add mss_cache_set_by_cca for CC algorithm to set MSS
Date: Sun, 18 Oct 2026 23:15:14 +0200
Message-Id: <20261018211514.2817293-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|AS4PR07MB9629:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1842089d-f093-497c-dda8-08df2d5ceead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|921020|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8n2zzVya/jD2X/Zv1Nko1oxRKjCskoofqe1G6vy/0QODLOStElR5V5RuG2jhGg2k6sCoK5A035XN2ypU1RHjPxzDBGrzZqevQ8vLCZAmIqg47zsuKl+ytObO2WTGjcrJ/iTiNkdTPOUIDOefpwnJcAqVyi9SiBte19Ir7wD8/Wla4v7M9CQO9Km5+QKWxYWVxOLtizEJZVobYDDDV6dRQVvCPWPU42/0A8+4yr+KWtYQ8PA94BuP/tZawyTpb8OTfr3n7CfAm+UfrCGxYt/5WssOQTtRKm+j4BExbB1uofy8n2Ixj+J0zIPkVWO0PwXMkMpRIs8CZr5lhfQwxNVxY0XDsuM631NzbwXHBU7+CsyG32KECt5A4rCDj6lmQL2fXIjfgQyWEgIjRc5L+idoSnKSkWN45SWOZNWWQShQaoXF/GdymhF6/wQ+F9P0oniXa3Vx7rHuLntRr8XiJtWO9NFHbG7QAzfMSegrWR3Fhrj/+VhIsyx1IZHIgo7KjhUbgzyKX6G0GLflRjHHIEJk7gjD2tgiYw5ZwriYxqkSgANn93u4RkpWc3jcs/jbvvb88tnsVddAuTUrEaWVhCT5q2KgavYQxQd9YzJyr+6Q1XaC8aUn56D/6oY4Q8lcMf6iKA114udHk0eHqU5JkvDqBnpvXGqwUQgAaU73qcXA32/u/v8BYVpQraQxGAV11Wsfrth0cX0GRcDxJWwI6LvDM5ibrAOeaRSOXJn8Tl/WSb9xuEGgM2+wFKr3ZiTR125D
X-Forefront-Antispam-Report:
	CIP:131.228.2.1;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zAE9RRXMUXgHeLLEG2YmIZ1XroFWcHIJ6XE0ErzMY6byAjpcLe4+YAK7wQT8h2cWVViosSBKFwjY6MsU8VU0YY4/yREMoG68T1NokBUbu4imSpHO8IjmvpdsePlk6In67U7Ob6Rg1a8uV2anesbK5X3gfPbho7QfNG3jzF8zvy9jQgBRMm0XQAIwJGpxdakoINghSNwVxyD+e96y67RaRBG7cEOOl77DrLeKo0XA25hFQ3z0D+t4WLniQ7NVWIc+uLmzrVkUL4mTgC0GAogxZTJj9LJYw+zldyhEWg92f646W3pAYHsfgxVOawpXGRMqJAWuXdiZofhukiM923mG4L1bdqp0F4dAW1QGKyIIFSDIAumHUIJMESnTkPBCjogYdn291S9H2NhE7/qurU7xKLpwXvVJ0XDTim59GpK167+y5q4Xs9E4/d3yIVwIfSwk
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 21:15:27.3648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1842089d-f093-497c-dda8-08df2d5ceead
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.1];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9629

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Make the CC module set the mss_cache smaller than path mtu. This is useful
for a CC module that maintains an internal fractional cwnd less than 2 at
very low speed (<100kbps) and very low RTT (<1ms). In this case, the
minimum snd_cwnd for the stack remains at 2, but the CC module will limit
the pacing rate to ensure that its internal fractional cwnd takes effect.
Therefore, the CC algorithm can enable fine-grained control without
causing big rate saw-tooth and delay jitter.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   | 3 ++-
 net/ipv4/tcp.c        | 1 +
 net/ipv4/tcp_output.c | 5 +++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e4d1720f49f0..428d63e46206 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -232,7 +232,8 @@ struct tcp_sock {
 		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
 		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
-		recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
+		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
+		mss_cache_set_by_cca:1;/* mss_cache set by CCA */
 	__cacheline_group_end(tcp_sock_read_txrx);
 
 	/* RX read-mostly hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f4c9101e5996..708e1830227b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -457,6 +457,7 @@ void tcp_init_sock(struct sock *sk)
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tp->snd_cwnd_clamp = ~0;
 	tp->mss_cache = TCP_MSS_DEFAULT;
+	tp->mss_cache_set_by_cca = false;
 
 	tp->reordering = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reordering);
 	tcp_assign_congestion_control(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3248f3895b15..c53d70718830 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2082,7 +2082,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	int mss_now;
 
-	if (icsk->icsk_mtup.search_high > pmtu)
+	if (icsk->icsk_mtup.search_high > pmtu && !tp->mss_cache_set_by_cca)
 		icsk->icsk_mtup.search_high = pmtu;
 
 	mss_now = tcp_mtu_to_mss(sk, pmtu);
@@ -2096,6 +2096,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu)
 
 	return mss_now;
 }
+EXPORT_SYMBOL(tcp_sync_mss);
 
 /* Compute the current effective MSS, taking SACKs and IP options,
  * and even PMTU discovery events into account.
@@ -2111,7 +2112,7 @@ unsigned int tcp_current_mss(struct sock *sk)
 
 	mss_now = tp->mss_cache;
 
-	if (dst) {
+	if (dst && !tp->mss_cache_set_by_cca) {
 		u32 mtu = dst_mtu(dst);
 		if (mtu != inet_csk(sk)->icsk_pmtu_cookie)
 			mss_now = tcp_sync_mss(sk, mtu);
-- 
2.34.1

