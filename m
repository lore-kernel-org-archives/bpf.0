Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626635B123;
	Fri, 23 Jan 2026 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162879; cv=fail; b=JzDaqFo5NYvq+1FsnLznZ2wleMNV0eIdosZriSgFTVZDOg113HtY/16gQ/43lzdpGAqAirYMGyLdjBPZwvb90YDc3OeXrspH7YAXkQl/nXHk+iyFjT9kqQ5bJnUotSJ6o930g4JkJtr2ItLb61bZwd9raca6UJPZJnqegFP5dWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162879; c=relaxed/simple;
	bh=skAe4Eig05qrSGsPuASEySBoj6IO5ZPSjLuoeIXdbu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpdWAUArhqtgX63ER2D0y+0CUB4+XtFH3ebs01n6TjR5qkazF5S1KgRcrS2oYVbEnCE6yE0zFLMvrw3zYlvki7Hvl/P/+JQ9Z0e4L9kJX2S9Ga050F+hlwKeS0IcDtdARLsVS1deK/Ht+AvGEC4bJKDd3WI7Fk4gvyWNkxVZJj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iW6zbIXj; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iW6zbIXj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khO75kjRZQ8L6aNp/mwU1u0h8k4lVsiV+K7CzFzQmhNY1HtuZB1mqhkw5UmLOcx4bVEfxpSTxqvahooO5ZBkCrDXD75OfJvzyQU9Emq9cYTIZbEPePoux0UScy2EJYhUbagVY0BJTJWiegjakSA3HP7plcEYnPL1bS3DFjP2fHnHLzmTX8eOCfgI2/EKMi5HAmr++besBFBeS4PAGOIsN8jNlVlYfdLNd6CwuRogJf9XOLq0Z4RRN2tCzq03Q8z+hZ6/HSxtl/QM/IQibg2+qY4n9jwdQpNhsZ3HN9JZ0gfVFoYrSUjd2OTAFsYPu6bYJc6HX3VD33eOHODoGHSZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrFkXZhoFhHZ72DZrzUgWg3JEAA1q5bUCttYIIi6bPo=;
 b=Ykq+a0b5CP8H5bUyemOTZ7J5lIBSrjP+iyMTuY/xD+W6RzAAhIMvX7VbjoxjqAfU0VUOAI+msKb+psVaJjMYM6XOpPtiLjOcnq3bjfsX6Ms3YNndrcRDMiRtL4H8afbCT61vol4OqOMszARW4dVtgKkjYZUFBrCiaY+WaDGz9z7queo++uEFxAmQPntQX0Nkjggh7Iqbn/cxTQffYFcM2MXSZeEzHzLB/PxbRYQmFfVeyfVTfY2u3R4zStkzdSH8gbAdSd86Qr84hZ2N1iVBZ4w6WTvf1m3cUKdK3Z8CwtkJbNjeorHSPJy0/N2uqUKWjku2gKcMtxRK9IRzueBmNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrFkXZhoFhHZ72DZrzUgWg3JEAA1q5bUCttYIIi6bPo=;
 b=iW6zbIXjCyA6a1uWk8cbhGQzc0JjZ79q43Ngcf4733zxXLbRAdffokajFapi/vKDvSA1RR+cLrQ6wvC78kQvL7l2jglepYfjIQl21mNOzKquC4oX0OyWrCr45Oa/pHHlbUXdxbNyuQw5pLaNsQ+ao/TDmuh7l+W9IiHwgNMIuX50Yksm+o5gibWafTnT2cqzHfWGWbDfgrIBLc1e12mS3bcBFlzwNjIJfkrklQgKjqAW7q2hc3oBiJ0WGmlY8f6R3eF3PlNC77tOsqfjI+lmo5MteBYsqQFUiZaXVGhMOId4iYPOYy6u1ysF0jUk5pL1qgKCN0f4IR42Z/esr1sHnQ==
Received: from AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38)
 by PA6PR07MB11317.eurprd07.prod.outlook.com (2603:10a6:102:521::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 10:07:40 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::10) by AM0P190CA0028.outlook.office365.com
 (2603:10a6:208:190::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 705161C003E;
	Fri, 23 Jan 2026 12:07:38 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
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
Subject: [PATCH v11 net-next 08/15] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Fri, 23 Jan 2026 11:07:14 +0100
Message-Id: <20260123100721.42451-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|PA6PR07MB11317:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 97d00288-ec8a-4d69-559a-08de5a673df7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ynLBqOJe5jAgKhkoHLnn/tPQdwBUucqP+ox+IzhxYad98sHTOXRE5gTuefby?=
 =?us-ascii?Q?yJkEN+gfNYuCP5/eQ3MhadNqk9rYx/jA2oAAGs/25ng7WXBwTRTN4D/dz6UO?=
 =?us-ascii?Q?YDOPTpmvX9OE2/ymTylBTpcdPMPkj55hVzt2ohbkqfPs+J2zxSjQEYNxrLxg?=
 =?us-ascii?Q?L5+TyC1ou3UL8JyfaIynZB7GN2fslv8F0cFWMsR2FNzBjrbzE+B6O61v012l?=
 =?us-ascii?Q?LuiQap8cpQHgD2IhQ7Ieghrl5rGtCY1ekyOWZanP+PsDKYGPCIuEbRJ3G3bv?=
 =?us-ascii?Q?fZwCQjtIMntTuO7PLJzSMaK93wVsoHtXNA9AUM57OJ7O2XtsjtcNGlz30+Up?=
 =?us-ascii?Q?FyLMGY67E9enLbN/9SSh3NX5Y/hzVHwxeztWs5vD8nVy4PU2sKG8yP4Y9LHh?=
 =?us-ascii?Q?6BhCogS0cj56RhdSn+/Dtr6eldYARhqWpC0szxj3gn1JHEoQbdCSxxtmeuTL?=
 =?us-ascii?Q?LVoZUaO4Vf4U56EiN0utHYB8OFR0mN5btjlSPMQwTMdX/GtlsdCiDAxG20zz?=
 =?us-ascii?Q?BqVnYDUGqbkxgHWq/HIVHGhXYwN/GFJYpOCafHdxQa5NawT1walCEL0h8T0A?=
 =?us-ascii?Q?+HP4MIy6MdAsNgM9ng7aYYmJ4IOk2NiBUQXflXWHtJ40zT2vb9o+VFeG/vBE?=
 =?us-ascii?Q?jRhUtJr/qeG3C74eng4F6mrd9OKQ9HZTMW1uTgM+i/NLxBPKUreAOZjo3v4J?=
 =?us-ascii?Q?hRwRZfxSoN5qVy+G79SsBvj3n6TXAxnZSjFZc+ydpmE0nRU3/Anki6iDcd0i?=
 =?us-ascii?Q?GuiOTP6CEpxI1WdZjtXpp61CCCRvnfenT+fP5RghRWutzYr/V7S7E6BVs/YH?=
 =?us-ascii?Q?3U54uQ7xXeHrsA9legGyq1y5mFNrMA52DeFxX8FSPQKHl0LiRkIA+e2JoxoI?=
 =?us-ascii?Q?Q0nhMYs6P2BmhgMfGNHJa212VM2B3zss6Rt9jWyoau+oLJpbWysrXpyN/Gsu?=
 =?us-ascii?Q?onlpGqYXlYDvr+QBJV2sTCPdT9jZ5oZYdJ5EIW3fWzIOWcXMj+BFqmRdO3ou?=
 =?us-ascii?Q?Kb6fSV+0UrX+pUpaeEQOw5XGWCTkBR+0eyEdhKGQ5h6MM15t3dKt+cM2Qi8b?=
 =?us-ascii?Q?q/Dd5R4W4MEilwhFMsaP8m81Jp6z6TbHP3IGpe3Fd0hP8nRtaOj02jQEbOB8?=
 =?us-ascii?Q?itNXOQqMFsXUSpFY6FTOlH4ieKlva0F8pKDMWcTxT0UUb6KMwYpwVP/5l2Yy?=
 =?us-ascii?Q?O6ervny0QiqHahOiBmfdsdZyizqmX3/8V0UPtOFooVlg+5kFWHf0iNS5j0+h?=
 =?us-ascii?Q?7NCzyj0mjoVJDsrWDClP7gfNQRgEE74I4M6hgF10rdNb19ipwo5Jc7nMtteZ?=
 =?us-ascii?Q?tPeGLOKmS9wpwtWXniaEoSQkpun2U5IzNUlmat1dLyk8ng+QrOvX+e63xIUD?=
 =?us-ascii?Q?QVbeT6cWmzNSmeTiaSsMnR9YxxH5SpgI4SuVdeIMK9v4MUcWEYO934Vb5MPT?=
 =?us-ascii?Q?CTEJ9TwkM0qndkBU9GfxUfVydP2kYB5tPyH/fQQEo2dzCpI1m4HTidmbMI68?=
 =?us-ascii?Q?1fJxA9bXBAl6SBcjdH/swJTw2+r5L5ZeE92qN3glFKD3mJtQyfWsKU7NGaYc?=
 =?us-ascii?Q?LhNFEDezYyTVFuES0DG9a4thniB08wEVw4JoiCCzBgqN0Gy+Q2mWiPIrtrhI?=
 =?us-ascii?Q?3jIt1teD9P9ae7f9GvDgW63kgv1m42CzGrVsOvcFnhbaUskQ4IRftwtPD6Ng?=
 =?us-ascii?Q?7ZKyUyWhdavdgE+CxHzVox2klUI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:40.0256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d00288-ec8a-4d69-559a-08de5a673df7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR07MB11317

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, retransmitted SYN/ACK did not have a specific
synack_type; however, the upcoming patch needs to distinguish between
retransmitted and non-retransmitted SYN/ACK for AccECN negotiation to
transmit the fallback SYN/ACK during AccECN negotiation. Therefore, this
patch introduces a new synack_type (TCP_SYNACK_RETRANS).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v6:
- Add new synack_type instead of moving the increment of num_retran.
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7965d4bfb4d7..1ef0450ecc2a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -541,6 +541,7 @@ enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
 	TCP_SYNACK_COOKIE,
+	TCP_SYNACK_RETRANS,
 };
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 				struct request_sock *req,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d5d695a501f8..329e7e461c52 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3956,6 +3956,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4641,7 +4642,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
-	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
+	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_RETRANS,
 				  NULL);
 	if (!res) {
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-- 
2.34.1

