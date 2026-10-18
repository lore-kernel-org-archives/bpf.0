Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F137E5FE;
	Sun, 18 Oct 2026 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358135; cv=fail; b=BSKE9Ors8yP3CfPoN+aqMz0sSvcvb9p+XS86DiAzOXDoTl+9NeVJIepTIsw0qYlxpIhdz7tMw9qVyPVqsRyBIVYvTwATb2zvrKaLKkL0+QimHdIRQkL7QrOrJD53jVIOpWGmuh2H84INe1mSYFnTi2G/oFlhT7S3DioPbPw/U30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358135; c=relaxed/simple;
	bh=M5OiX5/eeNM5NqUIK+vCYcFQEMmH0IRC+BoPur0WWiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6SFZYE8ma0yExKN11+JL0e4uFkpWM/b8SE3Gn76C9no+EsFF0YjUdAXrmjMJTrmu+3nGxsBcp73AfXGGDCDH2VDPey8nrhpUU8FObUyzDt4gFn0pOQTE7IpHdyDrxRCzeD56khYJMXlsNIpOPLuiaE2aYaamZQfyRYNsSwR4YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=P26iXbCK; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="P26iXbCK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCp1rPp2a23sAg5EiidGKIrvmbYSHTCJJsUcOmbQ4AgriKFnkKbR6fORg2yKK7Ve1tFFeqs2xggMl2BBrd5xSCBSe0YGTtusfcWPysyrus7l/2m0rmLm5Z66Jk5QCCJjdyqaf8XkWlTZ0nNWKoLhMb6t2haG4BeXTFFXkcjjs0SCMdX3OErszFY9XbTIbdX9tNPITtibiUx1nzn6yNjowu/bY6NyWSeRzJvz//IUwifT/oLbNXRGZ4kPQiYGf4VSfIa0cmg5+yHP+mEQF3wgvRchDqO2Vgt/QpvSwFzS7U7Dr3KAO8+f+KmaDGfY5/b/Q+a5L+r6m3ZAr6OunoiAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bL8A39GT0BCuUffnIQcZzEVg8FTvK47AAJUTarOGSJE=;
 b=SGAd8IjZzCJMrJehBx/LGgDLwW32N9b7gY9s2YiEkWpTduQKxlt5KnDWY5hptt1ZdX7CTpRjFncdUlPodV/x5x0irossCwz4geew+pijmCn/70uSHWCUrX2eWvJB8/k9CJ2erzCshI9DrRcMUpgIJdIwnl1rZal6LelB65NSoDJIABzXTFEd4/eWN+N/VEuU/nYd7c98V5YJCCv7WAFJhhdEuKz66rpH7OjDVALpNNiDLe1GPA2TXVvzOTRupElaFyNZ2JURfNIoPjQyqbxIhvL5gI/0T//S38Mo16KuOKGG6KR+AzTk7GLLQNhx++Ghz2VADXb15OMdd4UNYv0yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.1) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL8A39GT0BCuUffnIQcZzEVg8FTvK47AAJUTarOGSJE=;
 b=P26iXbCKe4EoYB7dJIBqi6GY80fFOu7vXdmno9BnxI59ZH3EFU0BdzFAQENxHHRzZ1YFJCWtIgrTXbRVChnv81dUfU3KoptQtBuR8909iaF9YMqq6zEMRCRHHHpTTBS3CZNAfDU2LF4LiQDfzRl+y/dw5b7RXQNiq2lGcWr5CvH8XNxUtc/7nGGuM8cMpUS8uKQ4yFaxas7VUAntHqH7eAGN1w2dbJoTZ7C0/utGDZwR8wBgo72tBYPW6n548lcrwliQQzso5ng1mp/dbpY4PsnlpFHIVkjbm9hAkyxxnY8qLGa535N7AbN5KCEvAw2ho5zZjkDjeNolH/JbrwbXCQ==
Received: from PAYP264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::21)
 by BR0PR07MB843483.eurprd07.prod.outlook.com (2603:10a6:2c8:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 21:15:26 +0000
Received: from MI3PEPF0000847E.eurprd02.prod.outlook.com
 (2603:10a6:102:11f:cafe::6e) by PAYP264CA0034.outlook.office365.com
 (2603:10a6:102:11f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Sun,
 18 Oct 2026 21:15:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.1) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.1 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.1; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.1) by
 MI3PEPF0000847E.mail.protection.outlook.com (10.167.240.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 18 Oct 2026 21:15:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 637CE800008F;
	Mon, 19 Oct 2026 00:15:23 +0300 (EEST)
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
Subject: [PATCH net-next v2 2/3] tcp: ECT_1_ESTABLISH identifier for CA
Date: Sun, 18 Oct 2026 23:15:13 +0200
Message-Id: <20261018211514.2817293-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847E:EE_|BR0PR07MB843483:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 059d8d91-0674-4a85-dbd7-08df2d5ced7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|18002099003|22082099003|3023799007|921020|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tX6Ssgu0DOx9H9Jmy6PZiKGyDz1DTQwKGpgjACv1W5L56nfrvra2l1eul9ZK1nikThmuV56l4i3v2E1giWDm7IB9lod0Sr/B5CmQR6Xi17ijmtJekpR5Pgp9M89DeZxYlsloAgwLEPFBz+JAuj+cYxlU/ZbVRlxs4ywbwgqL39ebdcSM3vBKoI+4FqTrLr6VF2sgIkoHtsXAKvM6RfW25KT/5ftINKTGCtj5Wj3uj8sLBr3HGVsAtXMmZoXssC3bfYxmbwbR4pehYkVMt4kWtIg8f5dsfywwvt4PQIZ+GxHdVLyXtWgzxoOY1+BQr67cDCkwt5K/wZnfel0ixLZ1c7gO04U/PU3/WVg8M+jaUa/uuudqfKy4+8pslB2lgh9lIu5/yyqEJl3eq5q9xo3x/YSUGtUj8axxrHsi4IFj5rfOvdITDFQeDwkdxvn+HyLc24Rphgo2qXiPW4VY3/x3lIaRHGpGgSGkc96TRdZxC910qMlCXFqz55vH/iD50W2CqfRtd99frI+v1oiWp8cFt0FhbD+PMuVRlukh1lKiopkyz4vhZlR3IYBPrUevst8nVNObqcm3BU+M2ftxwspLrICVy9LPeTuAt4w7vMDa6G6pIr0DWdesd3PvgMJIfo65feLej4JERgswVJsYKrfdNBw0sZUwoVb3NAE2j6hwkuJOicNcv1bAO2E+n3YZA/sbIcsWVvktNY7fMqbGNn+uR85tci7+X1vU++z93vlHmVIyqozQhS+PzO0nGCJJlt4+
X-Forefront-Antispam-Report:
	CIP:131.228.2.1;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(3023799007)(921020)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8EnIv6SIYyroXLqzwLFhZFfwX456711TaTWu9pniUWsDz416dtdn+DMGNP990SSlb6cfoPsUEIHOq28/cNiMKAcKHxt8Hh/lA1j7tK3orOaB/zeBtS4rhU2LVh8AOLLo9YJMlOsbU17o6T0CbcOXDboZUSPH/iAGvlxr7iCC+3WJkB7T49pSh3Jz0iaOhs2dDDaSKGzbOTRxuz381NZDV97PjUXf/OCZA+nxIbQZWbkNypO4V64RmhIhRDTQnwPdUuWmNX0k0M5zZzcYTNB1uqJ2kDo+xsaU0KTSymGy+3rtuL/5O2Kt3F3t31U0qpxLZjRJN5LrMfAESQjFlHtw2h76Tt3VfKUj0HwUo4eUmMkqmg7kpr/nylPEkmTa7ev/xCxV13FM7u4AZtfx5HiIF4aJ1JKIyRiCY37GCVsrlHXSXSE5xBDts7mpsvyg1TGS
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 21:15:25.2934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059d8d91-0674-4a85-dbd7-08df2d5ced7c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.1];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MI3PEPF0000847E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR07MB843483

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When connection is initialized after ECN negotiation, this patch
enables CA to control whether ECT(0) or ECT(1) should be used.
A new identiifer (TCP_CONG_ECT_1_ESTABLISH) defines the expected
ECT value in the IP header.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h     | 1 +
 include/net/tcp_ecn.h | 6 ++++++
 net/ipv4/tcp_cong.c   | 4 +++-
 net/ipv4/tcp_output.c | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 1838389a9d8a..b9def462479d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -428,6 +428,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1_ESTABLISH	BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 865d5c5a7718..210ec63538f8 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -38,6 +38,12 @@ static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
 	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
 }
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_ESTABLISH flag */
+static inline void INET_ECN_xmit_ect_1_establish(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1_ESTABLISH);
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 8e83ef81fc18..8da2a9a34b29 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -240,7 +240,9 @@ void tcp_init_congestion_control(struct sock *sk)
 	tcp_sk(sk)->prior_ssthresh = 0;
 	if (icsk->icsk_ca_ops->init)
 		icsk->icsk_ca_ops->init(sk);
-	if (tcp_ca_needs_ecn(sk))
+	if (tcp_ca_needs_accecn(sk))
+		INET_ECN_xmit_ect_1_establish(sk);
+	else if (tcp_ca_needs_ecn(sk))
 		INET_ECN_xmit(sk);
 	else
 		INET_ECN_dontxmit(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c8865205cdc8..3248f3895b15 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,7 +350,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 	if (tcp_ecn_mode_accecn(tp)) {
 		if (!tcp_accecn_ace_fail_recv(tp) &&
 		    !tcp_accecn_ace_fail_send(tp))
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_ect_1_establish(sk);
 		else
 			INET_ECN_dontxmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
-- 
2.34.1

