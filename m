Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA0D35E1B7;
	Sun, 26 Jul 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785094693; cv=fail; b=N52n3r+3r6EREbKsoD3lk4lu7TQi+/0YzOSIXZ9gSxdcnoC2Bgi5dvGWTNwr1v+k6/0PBKHvMpQ25u+uxTHMj2jNV2V9LSX6ome4CSXuhvU0AhnP2aMBMx4qdVVCRRxYvZp0j5kmV70KAGFYL8XSTmKQFCCoWWWevVLy0lkw+Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785094693; c=relaxed/simple;
	bh=pGjhNCD013GUgdrUvaN4OHJY4AbmbSUqJjTbh+yRk2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gfAYvEY1IvOfDZoqNk0rlF/krnQ4LuoGBAEQb/vgSHI8V0swouuisV7036XCg2LSlMTVONIdQKufOxzqPSnbJBVPfBx6xudlw7wnP7GqVy+hAxFy3gs7tvu/UY6nlujokEjEKCm0CkwpD0I0d9ferU3Zh+63ZwheL+DbtxDZdko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LGZw2njp; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LGZw2njp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQyBPYs8Ypf4zbLqZ1ArjUDXUKkF+yHIWt+zu1Km1fWiPAC9jjdtYNHxEHRoef50IVYr2VbNHQoHvcJXwqJjj+NPkhEwYHNFOjjJh6zjwTNQL6I7wfvovGQnei2Fj+cimmuxeLtnTppQxR9ZwyTXy+kmfrldaIIshMDr4yhWXfJ8B92u1EBkFnTvL0N4bz7ncWTmf+JJHPt5VNyVZeg9tJn7hE/6xj8xfnin0n8++RWAArpynaclUCepEh/1GUrIP4dnHMAtwzwY1GhmjZz/TCkzmaG/JFZRP/+2RqtmABTUIdytcfa9GDPJy8Onaii4pPAJcy0KbavzDghHOq3hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jl5SuJYD1y41ZvM0TXJQ9JJ48s9LeRLmilIb5EDsNw=;
 b=Qp6lON04KZD/9l+gqhzTtckiCfuUqk94IddJT94lni+yOZ/ct2ouKmLrcEvxQYTwpNsZ2pntXe6n5uh95JjXlQ/Sqffcl59zCH7qD3Znft/ZZ/l+it0Ge/bDy74zUiCWXW14RValOoJnj+iDJkilMVxk+aelow20K/FdiD2+2Mj2JqWuUk/NZ7uA3soGIw5lGoXGTmSRD5uCMbXfWJnlaLMR0WBGW0FEwvPJF65jf87arASn+lufh0nVw9NztusTfqb7s5G+b0+AQu5TfnrGkMKj9Mml/tB4HEoeT2mLBbK+GwptEMbvAbL/r2zC9uBMtQ2CV4IJp5AEj7l2ezuTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jl5SuJYD1y41ZvM0TXJQ9JJ48s9LeRLmilIb5EDsNw=;
 b=LGZw2njpwro+L0CQIBap62qj4YEjezBgmN4WrZ1oYo3o3xJnhG/6+vRPPjtbL/QIGTguYEI5I8Jlv/AkeZiHmt9FdQNyFk/qLvblci897RqKSInLWwNjc8V69a1i2Od0EwJb87RDF6kLL1zFYsGq8qpl7WRSso9G68l9WgYIOHsjp6dXPgIuqK+u2G8ObJW46XM6S0hzyZAjJ47jhfqK8luSD2xfuFiwJw16mhi+HAFAFuwX0Ex4XRMt3JluZehNbU+kEkhyYQyQ3/kqyGr49jljibObA5rL5u8nfubvhR3ROTfu4+XCbPz6zU/stZ+/5QRY80upLnZnK2YIoryucw==
Received: from AS4P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::10)
 by PA1PR07MB10414.eurprd07.prod.outlook.com (2603:10a6:102:4f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.9; Sun, 26 Jul
 2026 19:38:06 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::86) by AS4P195CA0014.outlook.office365.com
 (2603:10a6:20b:5e2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Sun,
 26 Jul 2026 19:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Sun, 26 Jul 2026 19:38:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id DA6688000096;
	Sun, 26 Jul 2026 22:38:04 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v4 net-next 1/1] tcp: allow congestion controls to override TSO autosizing
Date: Sun, 26 Jul 2026 21:38:02 +0200
Message-Id: <20260726193802.397321-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|PA1PR07MB10414:EE_
X-MS-Office365-Filtering-Correlation-Id: 154753d0-fd88-4f89-aef5-08deeb4d6a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|921020|11063799006|10067099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	fEbO9hQBEsjEPos8ilJVvMEyBUxuVXL7cy9l8eFQfsRjSVJsFv5Kmcxox03XmRsRq2RZnbdT8N/X3Ud67ATy1IhQ/ZFBTCkX3sIYXlf2/kyDrh0qs3+NAl8GHpWdSY0woa32DYvLH0xa2QtX0vtiD3dEp7uC1Bwhj82xuZW+DALtshqgagUrP8oxzFBJINuvzrMAMRDxnE7ixtkvidvgXXk/kD8Z9yd59myD8G5wbYz13pkhbKJnUQHSRhYHKzZl49PwXFI7Jl/Jdx6VnzCah672WFNCr77v8tgjihvhDkQEGspaU16mTkMPrvlpkOFNHXvRdDjVbExWGRmWnz6/bKU+h2H8wwT/XLt3cwsUhkKcTPwxU+1SwINzFcIBk7H+snYPT6hEcjb0Q2YLWFLvpYgM9y50PE8ID5FEwl63dQOX+Mi9znHwzLp9gmvmA8OQvaq7VDTJGAj6h/+Ws5lBxnj2ScscBvE4vegsLtUBUA75a2PFaB0fVZm7lyzHIg2v+65Fio5KUu0MgpJKy8yCpr/vFt7P3lGgbpkZgmdcxS8k/v7FmRNaCLEH5Jz9ILtbN8B0T8B+grrYAHC2WV0fG1etWRC0bl8uBuwB/gzT0pgnlbFKa6C9cJ6Ob1Y6nVSZ5bXqft93zi/sofvMyBbl957ntAK00FHOTNhZ1xKMvwvFXnqhbkey9pZJFQ3h+BGsRn0SMlLCX7259Vlm5eATUl9CXp9YTERO7iZueIW+GxkPkzoz/dCQL0KEXoDZfonM
X-Forefront-Antispam-Report:
	CIP:131.228.2.84;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe01smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(921020)(11063799006)(10067099003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lKIJZcvkOrQtA9XrkdRukI2fTT3PWb/tIdkZEuSdIMqoygP/WVvu1rp4da/gjjCHo8HDuMh+YgGKuF0t9+gkQJgywYrU5Wtu0NQv9TTS2byq1WGIGhr6oX/XRkxauQ7QjiSKRgnX7DaYES3BmC4nmXA7e8HtMhlCcG5UE8JJsxII84UlPjb8tymFasXUUgQDXjJT1SGK3LLtUxas+RoSxQyimkt82soD4nC74Z8zK21Lyl42ZNLau1WOD8hem64uTScPM4LbCHJwB6GoOFBK4chEFkZ33MgilHW0djjl3cpDmAcPd2NwjEtzsQ5Z4ILtSxeeFLDYQQGWrPG/wdoukWoQVockJiUnaHrNHl9F9kg5zg+dlN2/UudFT0InAcCh3VHwsdWllbAOGnnnw8br/yF/8uyucsRZTHqZCvrZJcA/tdOFTpNSPYHu4ZT3HdW0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 19:38:06.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154753d0-fd88-4f89-aef5-08deeb4d6a4d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.84];Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10414

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Today, congestion control algorithms influence TSO sizing through the
min_tso_segs() callback, which provides the minimum number of segments
used by tcp_tso_autosize(). However, Prague congestion control requires
finer control and needs to determine the final TSO segment count
directly rather than only providing a minimum bound.
 
This patch introduces TCP_CONG_EXACT_TSO_SEGS flag and extends
tcp_congestion_ops with an alternative tso_segs() callback. When the
flag is set, the congestion control algorithm supplies the final TSO
segment count directly and bypasses tcp_tso_autosize(). Otherwise, the
existing min_tso_segs() callback continues to provide the minimum
segment count used by tcp_tso_autosize().

This preserves the existing behavior of current congestion control
algorithms without introducing additional callbacks while enabling
future algorithms to implement custom TSO sizing policies.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h     | 16 +++++++++++++---
 net/ipv4/tcp_output.c | 17 +++++++++++++----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..82cd82a19ff9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1283,9 +1283,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
 /* Cannot fallback to RFC3168 during AccECN negotiation */
 #define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
+/* Congestion cotnrol provides the exact TSO segment numbers  */
+#define TCP_CONG_EXACT_TSO_SEGS		BIT(5)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
 			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
-			TCP_CONG_NO_FALLBACK_RFC3168)
+			TCP_CONG_NO_FALLBACK_RFC3168 | TCP_CONG_EXACT_TSO_SEGS)
 
 union tcp_cc_info;
 
@@ -1361,8 +1363,16 @@ struct tcp_congestion_ops {
 	/* hook for packet ack accounting (optional) */
 	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
 
-	/* override sysctl_tcp_min_tso_segs (optional) */
-	u32 (*min_tso_segs)(struct sock *sk);
+	union {
+		/* Used when TCP_CONG_EXACT_TSO_SEGS is not set,
+		 * override sysctl_tcp_min_tso_segs (optional)
+		 */
+		u32 (*min_tso_segs)(struct sock *sk);
+		/* Used when TCP_CONG_EXACT_TSO_SEGS is set,
+		 * override tcp_tso_autosize (optional)
+		 */
+		u32 (*tso_segs)(struct sock *sk, u32 mss_now);
+	};
 
 	/* new value of cwnd after loss (required) */
 	u32  (*undo_cwnd)(struct sock *sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5e30..0de27a87c39e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2278,11 +2278,20 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned int mss_now)
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
 	u32 min_tso, tso_segs;
 
-	min_tso = ca_ops->min_tso_segs ?
-			ca_ops->min_tso_segs(sk) :
-			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+	min_tso = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+
+	if (ca_ops->flags & TCP_CONG_EXACT_TSO_SEGS) {
+		if (WARN_ON_ONCE(!ca_ops->tso_segs))
+			tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+		else
+			tso_segs = ca_ops->tso_segs(sk, mss_now);
+	} else {
+		if (ca_ops->min_tso_segs)
+			min_tso = ca_ops->min_tso_segs(sk);
+
+		tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
+	}
 
-	tso_segs = tcp_tso_autosize(sk, mss_now, min_tso);
 	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
-- 
2.34.1

