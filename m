Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307B74B7166;
	Tue, 15 Sep 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511277; cv=fail; b=SnXdYwvNvrIwM12ib9vUmfC/pbyllRRGysv2CTut1SGeIG458qQUf8RItNActZKUKwY4U12lxKaQ3H8wPSQl1lIxyWIgdc1n71eHIW3L2lGQh7SjMZAs3CDeJCmZ5zAdzRgTtI4MB/169/9iv9TMIsIOxiU94qmfQWhXnu3JBbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511277; c=relaxed/simple;
	bh=NLE4c53WtOGGkU1yPFgRILEGXtPy2sizyfc+qBvHdyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/FY/3szEPUMjesWjigkTssuV3N64dTl5NCkqUwGMcvMbBwFTladg1RLjppu6Wo/p/tDMYNPIhSjNfdkhFELrq/qyg4w8b2rDU0kh+HCeMvm8Ns68A+UQyU6LZy9xM2+QMR7tOMSWUPcX0bvbGBN+3sADDryZMH890vG+u/W5Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xb9UaV0X; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xb9UaV0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOC0V1lBqKWYN3q+fP63+Vm4WOmtSk6oq/8U82F7sZGLAu2Jz0b79oj7IFFBITUjj7IKFI3jDUs4s9Iy+ebWotKlInujQePUP13ENTxkBY8s0vvs3ODGT8QLhr4R8jbelAb14UCC7MCYVLLlm7dFsmqbhTL16iHaR9zY14lO2/8OKo1OspIMcH30on89ZQxyo4Q8Yyf7XDwOih5Mprkae5P/hboRI9MFmmrSDFQk3bY7mUwBelbeih88bGLuiFC0fmH//+ykrt2YXgC71Rba9nsrlv4wZrtPRuUcMDyik3++U++q6/pxs7SpfPIQIMoasolw9+UZrVhL9qBLtxvDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6p2VSiD4j6thoEutAQkWM4wLafFMLn9MsGPehqU/xw=;
 b=QL05LHPi4fHXJbJCGxxNCklajV8Nph0ExADAiGTcPblBd/phvgsQK03TEa3atRkFW8J5yA0KFDHHLEhQt09VNWkojq0H/FCeQxnulx/gBZxWmKKiTm0CyBWLTVJD8Iaalxf5AsHPzlioVgw5Jq0t5wObb3aKO97vrzuszZQBar/6yoJdj3hqIk6qodcOvTd9rRvXG2tKCVSo4cgyd1gzKf8gUeOfwQ3PBwzWILf1Dem1c4huxpMU9R9vAfay5xDA1dyXlBwbdRuFI0s9qXe8oPXbPX3HF6UYx4iL0PaSfQ2Cfs6UmyPqScRy2tzt+DQBuETWmVEHD/EmZcRNJrG8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6p2VSiD4j6thoEutAQkWM4wLafFMLn9MsGPehqU/xw=;
 b=Xb9UaV0XEDLnotpWaT/3mZulwO9uYzviKyGTqWqxn2uELvhkrorUFZ3gt+4MwyHirRuHMKn+KdMM41FACLq1fUPotCFpDg7rXkMqwWlUuICdh3pFAOaGRT0ZmNLyD6wdCnIL/B5cIcZs6AsfG5Cafw2hJNorp0RMgRKWrJGu2+2AjiDd+gPcDbAcdRrdREOaKTyGlUgRcqeGJ9XV4/NnIf+RFZAbwB1qaMH9uPf26m92veBVA2nt+m2K7wtfJ4sjwhyhZ2jH9vPaQQQwe+nt2MYWa2ZK45RqIu6UaGy41g0m8xLqSZSMuYCvx2yvld2y0tDmeAgNqu98PYGld1tkqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:48 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:48 +0000
From: vladimir.oltean@nxp.com
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 net 6/7] net: enetc: linearize PTP event packets with one-step TX timestamping
Date: Wed, 16 Sep 2026 01:27:33 +0300
Message-ID: <20260915222735.1016937-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::7) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9380:EE_
X-MS-Office365-Filtering-Correlation-Id: f181763a-295d-4057-0d8e-08df1378923e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FvRFZ0vxLmrBfIoQJGDaAI7PdIAZqePNQHYQjSAY+Mtbzmlkmz4qkyg5X3mOkODqnHqVzcXWXVX9k720rF2y0BXxVzhs17aMJFKO85qCiq8po5OjwegwZ3751bLlydMbbJFuIqL7nugtb2eRTLwPUai2SYRRGot2kZr5AtLZ8UVmYJsV5YCxZjTBCV776wprfhF2Cevqbf58Aa/bovkLsqnUAFyaQgsmt2EFDRfq8pvAh3axLXXUOkngiEtxlKZXKXz5cfRfaAoj6xsKv7ZK5jOOUOnrweczvi72uKXV9k47HdR98YjkLNDaOZ0cYrcZHdImhqkLw/W+nrM50FR4o1EvjcpVIpcs5YI3TBqEx3jcO7srWvVntm6Nv2fNVRF+idiXrHjW7N+nWJPrX35tibuwAHTuKJDvg7xB+jLiIPq3dn1QmRSJm14CRU4ehK3ccA327IuHWGqNr3CpFAUZ2psTo7xHclJrw71oFOFRsG61EEA+bV3nN/s65Q5I45SOtsT1HrAuIYp7vPZ3i1ShZn+wdxjV7K8GlSHyzHuT1qDN8efv+9q5aBIldpvwjv/jVDcoCCI3XAGQe/fFbjZemSm5fmsyebq+hjU+J9CU6Ws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pd+kNYOypS7q3EUTgP6I0m6iprSWdydZekCbdk7knDXCvHxd9LdFNLkP/LfL?=
 =?us-ascii?Q?E7AM16qLO8qjCfTkR7dxb05xJiY3Ff5Mpazn2myS8AwBlnFFh8aGKvO9zClK?=
 =?us-ascii?Q?3eLVngx0ELaYfbdxWYtAdjpWQVxCJJcpPOzsS+c1vBQgPUkaTike+w07yrBJ?=
 =?us-ascii?Q?zAZhgTcG2B5x8pcXb/m/qKC3Kznyy8Csk5MQqyiiWGRv2rTOIcajMAd29hvQ?=
 =?us-ascii?Q?ZRpbokyZ7Cic9uV7Ca+a792ZldnuMvlDN2Xg9bmkiy7TdY9cILk4sKm5469g?=
 =?us-ascii?Q?SuyIku1fq+YqM0JoyMeCu0CbHPHhoNYdNFN9YISZsK28F6aFjf5Ol/T2EC+t?=
 =?us-ascii?Q?xtYTluuPcBMoEDXCkz3aNGANv6Mo3QTF05IY9gp11Tx1/TfeXsDzWrsyxfFi?=
 =?us-ascii?Q?Ve1PakqrybzTBVytPVXKsf58pRAkZuxFlYoALBPGBuD3qNxZkku/VtZwK4zz?=
 =?us-ascii?Q?HBBrphPmpZ8x6opHg4v8oK2PAPOS1vVDQMPG/SOOmK3wfjdDwM1Dq8ajCQfo?=
 =?us-ascii?Q?UQv+vyhDs9iRDY8N+gUOyWHYxiV7spaz8xRdxGwgK6q6JqQIF4d8BoemZ+JL?=
 =?us-ascii?Q?R/CyKDgvbdZt5X3IIc8LQAUo1KVc6JVnPtE6ButhtWDpgLmX/+dbMRddTNwf?=
 =?us-ascii?Q?DgjniwOMydPKV7dEyUKb/poCbYG6ky17n6HV6hj67hJ+wKsTwKFHnvJfEFax?=
 =?us-ascii?Q?qXzEm1UaOk48vJgC36y0tepFbDUtq1wPEbMaiX0p9XrajJr3cXw6AbUQB8Pi?=
 =?us-ascii?Q?vHW+EuNVSpcxfqaV4c1rVHm/RhaVBiFXJ0C6lnHtqqLCkhFuooPlQ+Nz1h/O?=
 =?us-ascii?Q?FKtaTNAm/CnDzkMBBZRWmICvl7U138ScM+1FJ2CQKxNunZLpD8RuK5ixEBK0?=
 =?us-ascii?Q?6jzFitqHWjMTIOJrgD8EE3dIH1pWU1YZQzTMma03LhJBnyFqNHjMQHEnllxK?=
 =?us-ascii?Q?y1yg21RHbINnXZbAIrI+aReyrwn2UYdaIecFYVl48qJ2GEi/gW+MP0dyZb9N?=
 =?us-ascii?Q?nKEbIYbHe23PbBN5lYUDsCWr50CztpzvJEpeYCu5L5RSSLxbQxNccrxJxGIv?=
 =?us-ascii?Q?TX1vjwECOCm8IpNmt+/OoxsaSeFP1LsbWM1CRbVdPwavwNQvJvs35Q7ApBJk?=
 =?us-ascii?Q?EpcBL88EAMVtNcveh1Aa9aOmlw7vjLhdtikcVOy0c+RMJ9klGvBe/Upetewc?=
 =?us-ascii?Q?PqYkohJynibldEEn5Je4V+s+zjLmhRAnGRnd+n/d7Dm8i3DuqGE+9WjYOi9j?=
 =?us-ascii?Q?W4e+VJ66juan89fb4qpkygsnwXpoD1ovquA1RXJAeSDlZDA8AOrHQSLnCX8V?=
 =?us-ascii?Q?gSpdjvVVLAmce7XGC8LVJI726hRAnjNXdBzn+8/BICJpDborUsSG+Qy+LhvZ?=
 =?us-ascii?Q?j1Lvow0V3DjCkZP4NV52YenI2sIT+1Dm3l83BmVtuns6lEGHhoAZHi+z33w1?=
 =?us-ascii?Q?9AFiANdu6EtDVGvgDgIwTLkap7Tku91CGIQiksg9cOr9f5Gyd69NCT7VXJ2d?=
 =?us-ascii?Q?b9aBX802H5/zEVluCh+Z4I+4VOn3VFarAxPItwiODdSP/sIZPVZbTuQ0gx2q?=
 =?us-ascii?Q?0glNv+itUELlLjlbydmCR6gjqKfD2oR/wiBdugyabKTckBaVhX0S1BzJirIs?=
 =?us-ascii?Q?5dqtR4zbIemCzxvQgeGhvm+O+3hliqRxth6RDn+Dp+IQnPHHGmN/ad+r1xTq?=
 =?us-ascii?Q?qNTt2I1pfnEviAFxYBJ7M+4OujMTsT2fTN4ECMspJXeBtn/Nx0g9ZfyvKJDA?=
 =?us-ascii?Q?pDBc7bZmgQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f181763a-295d-4057-0d8e-08df1378923e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:48.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnsvH9etdtOXxnQywgplLp9RNbPYnUO7itjSzxPQ8NAZyS0vUUCm9KvgyvmchBcAuyCKW03WZF/JPX4nKhN0cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380

There are two distinct problems, solved with the same
skb_linearize_cow() call.

First, enetc_ptp_parse() uses ptp_parse_header(), which does not handle
fragmented headers, and expects the entire area between skb_mac_header()
and the end of the PTP header to be linear.

When the driver fails to parse a fragmented PTP frame to find the
offsets to the originTimestamp and correctionField, it falls back to
two-step timestamping, which is technically not what user space asked
for, and it may not be prepared to receive the timestamped packet
through the socket error queue.

The problem can be avoided relatively easily by linearizing packets with
one-step timestamping requests prior to calling enetc_ptp_parse(). These
are infrequent enough that this should not be a performance problem.

The second problem is that later in the TX path of these packets,
enetc_update_ptp_sync_msg() modifies them by writing to the
originTimestamp field of the PTP header. This is not safe from drivers
because they may not hold the only copy of the packet, unless something
along the lines of skb_unshare() is used.

Actually skb_linearize_cow() kills both birds with one stone, as it
ensures the skb is linear and writable.

Note that modifying ptp_parse_header() to tolerate nonlinear skbs was
considered, but it wouldn't have saved us of the need to make it
writable, so this is the simpler solution.

Fixes: 7294380c5211 ("enetc: support PTP Sync packet one-step timestamping")
Link: https://sashiko.dev/#/patchset/20260401172246.1075883-1-vladimir.oltean%40nxp.com
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3:
- replace skb_linearize() with skb_linearize_cow(),
- improve justification
v1->v2:
- patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 8a9ba168eab1..62cdcaab3f3f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1099,6 +1099,11 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+		if (unlikely(skb_linearize(skb))) {
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
 		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
-- 
2.43.0

