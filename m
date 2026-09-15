Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4734D8D98;
	Tue, 15 Sep 2026 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511272; cv=fail; b=LRCYlPMlwaP0exgC76mz2X/mNDOLB8iuc/SVx0xjFSQlvid+77HuJeaOtwrv4vDXERn7/SE8KFTKS7vCDplCg98bvXTUFU1sV/JFDw7Jo9B7qO4CfBweSZE7MQMwClEA8872EwKpqUpAIpg5/yMZAUuxS2whKtSc7misS1NFUQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511272; c=relaxed/simple;
	bh=ISlBHnvDTb7om0mUDJY626aw5ycnCuX9g8Z0DlQ9e2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JbGmfZkep9M46gACV63ZRa2b6+L7XuC99mFJTqNWnJT6uLGg6J15snAx5SjXSsMoSgUchagHJaAd/VakmQMdR+fupUZV9N9y3hxbDipIIZC0GniQu5kn+r2krtPZuYK6JgUIiTTEJ+FzXXOxU+OFAqs3f2mj5HiNvUpCKRzlSwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TfyXuOZq; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TfyXuOZq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpXWJMES5lb91ECHd4VINiwXzgKmyBg1XR4l2sZT4hwiebJwUNU+VuBKZaUoDKTMN+saG5NtC7assmluwzTSu4Dw6PEitHQvvwBoibgc98J5qBDoK0O3/c8SMp4J15yYdGgX2COyuz/vr7juhjSPlSf/3GCrJFf5XyWsVWGNoBfiiWqUcK5GDHizdVxgFEpdy1h9oZij8V2IdK6mjtAtzidpdJa+cqR9dL0NBU5sIlOr0nft8bKRdvRGZD0+Xl4YC6nJuWbqSfaVrD2L4iAApPR41IPUZaDNSxkyqXKsLxNBYP0NeMvJanEAwmMrY5Y+gneYobFhk2pvRQ0ls5EtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFgTMNhTRhGkRAa9FDrYSsVKcjgVTSmgM3YI/+U02Cc=;
 b=gWrDz4s7xIjRSZosXmm3aMbtO5CSte3FJEHMSm8EPYguzLfaCbPAppkRjr7GWKmVqVCg6QzSDqHys6t+qCSxFLMy8rDyQ+A7H3hBgwfdh7TzF3a0dwPNG1S156aas3ycwamfui3RfaXkSRy6sCrjsxcaqb7V25VKFs+nuRxUakx06GJctCmCmGOlx4sp4/5CSO5Y3YclLyaabw62Crv86NbME1Jqv2YkFbS6rshnEXG+gqoanAgTCM86x6Rg7Ti6yN2MqLZMCrkf085iS2e3wA411P4MFgQmyzjAVenRRNqs5Os0tlkvHl3vHbdmfk7BOBaDDyesGkx+GnoFYgLkWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFgTMNhTRhGkRAa9FDrYSsVKcjgVTSmgM3YI/+U02Cc=;
 b=TfyXuOZqh9bOVIfDgu4GY4yKv5QFF0xZ1mXquVg+hgOT3Fsg+Lwf1JHq4keqvSMX719YNSspobpC6ya9mvAO6qXwzRIqYXhx4rz3AtNyPdmwB5xt92uL0T5ki2ugzW7l6fC1sZxbJz9oqy6ng3AQ7xQqdKvw8ZS8Uq7Tq66GfHBaI3eOxPLpdrFP7ns4jrKAlYxso36SjTuhJ9qk+JiBtGMxexWvBNZYOliFYOuU/w3IgmZpJKwDSlqp0i4aD+XZLmmXfSu9dKA10IdRic+T9k+XyebNENBlIRnWoklfO3Bkll7X19iMK9bXIkahsK6+ix9exKIF5mtJSmb/Geilgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:44 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:44 +0000
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
Subject: [PATCH v3 net 4/7] net: enetc: pad short frames in software
Date: Wed, 16 Sep 2026 01:27:31 +0300
Message-ID: <20260915222735.1016937-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9380:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ee2eb1-b802-4be5-8b00-08df13789040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	psSpJEyuqCKIBxAe6ZrG9+SntwLyO0/GhYh0MaeOF2EUde3BZ8Sc09Pvb22a/Nu/Fj311fEHpiIqvyvRfDZRQIBGHr251or0jBumH5vqD4cx76Bh69DYo3s6z1/ymLQ+XAIasCN5Y9pMplwzFcVMaCSQp6Xy4OaP5LDG8yfdfpD1CyxjEpjYbI7yukHbsRooKoPsJLqdEsEKBSIx1gcFqR/1WY0e0UJ3CSNFbzmIarRCNVa32FxVZZWgz0O/HpUN6b0kQVzrdguePM73E1s+b1XLoGR0IWKqYRvY5w1zrNqw13uKFRSqvHSbar48g3CDz+QnhcKLj/KYeAieLGdDZskVpSfw2N3QgHcrotkZc8xHg8t+lUZJGYL+KMYHick4R45R1X4vqVoRSgEslDKfBSawrf7zCuduO8tETK84wjJ8yMwq4v6sF1Vyjh4HFvsxSPrnumxATPTExbxhsAALCmyllYBPE+7pYI4iYewaxM1ODgN3Qus3/70KR0yW2NsD7Idf5YtCZok359HcsvWw3MOCZulkFBWYtno/DugJ3T1skpU+3T7wbSLRAI9mTwOeAU5xNKXvbkr1L1wR1Yfb1ksx6ngmyxwrpKtHQBL4+pOfM1u2pWTuDUyWMHQdeqEpuZOugnJpajABWE2r6s5ce3dIUKtc02ctt/rJAFKMF8g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U7UdYHUpcCpGVgdx+MFjcWE6ZWKU5uSBXXmmlB+1fac2F8/A86enpwYsvcYd?=
 =?us-ascii?Q?FKXO9bHNVEfdoKnlPrSBB3BVBh2/KH51o0fcwDTkupgFEtai3J8bZ7gPYaWr?=
 =?us-ascii?Q?ddDi9oh3fa4HPkZezLnrYDx9+fSJbbkPxzFnq3G76bHBlOPOMMLdj5uYfrLp?=
 =?us-ascii?Q?6CrohGWI5hNj24STlD6fSgBWLtiommNZQbf7Q5hPF7qv1M5geAX/VAR4CLup?=
 =?us-ascii?Q?LUklJhKJ7NK8Vq7TMck4XAhcAadTjVMuqS1AuuQxf0bVdnvKlbPWmeezddn4?=
 =?us-ascii?Q?HQA/VZdPNFmITSLf/eOSR/754NYe6PbwFEPIXjkZv23z3+l6ZrTaKhXP13/w?=
 =?us-ascii?Q?eZxglVK7P3W+hvyeelzIYPGwtArRkI6ot1qMEcTDrcx5fwVV0oVi8dO9/oHk?=
 =?us-ascii?Q?42BVphXEPv+BTw0NR59n4I7Ej74gZsN//siTiyXHy8tvDPZ4yKM4dxsT018q?=
 =?us-ascii?Q?0j2IpOLVudZFzBlZIAvolFzHdN+iO2zeD/bI8I/9Z8s4hpYBqybsiv/83QuS?=
 =?us-ascii?Q?EjlaIehAZsjZQ8boLeZSndNPpuezFGPeHcaRn+WqR35XWcYVWeUqxa80ZBYx?=
 =?us-ascii?Q?uyzfyOCqrmFcv9sllD/fWF++QKUBCEuob11JC1LqKqISqYv88ZKG/ESPTimC?=
 =?us-ascii?Q?hYvZRlZl9u6eIggOfzs1mBmt3ZrkppDHBWRwt8fsGDAFE+baytUzj4RzNawq?=
 =?us-ascii?Q?UaGtQHIoj6EOWolgz+1TJeWIB7hUucCPwfGMeEcuQlZAdK8RRnMYii3WmnGC?=
 =?us-ascii?Q?P3CTZ3vCo2y8tXV5zUKxPuZD2Cm+qPt4HhcwPA9HZ/MyXsL/Yi9rpTBsrYZg?=
 =?us-ascii?Q?wFRnOSSm8ZUKtP+Ni/QtZtrszZRtUsi19JY+lSa0LVly8ywuS7jP/qvGrblX?=
 =?us-ascii?Q?p3Ov4iUAsSPiU7tTCDJd1aNruq5T2zgX+SilEFTPwS3UWAJzp7UWdyeBtyod?=
 =?us-ascii?Q?oA57+YkHJDc7n3akEkkUnDiJpFWHVo/4i2Ph2RTDRjigpDxl6hOrBQbPTEnS?=
 =?us-ascii?Q?vBc26iPa6CPsg4KSTHQl12g9lEcPgs31jhjzuio5wocOtqW+GICPBfew5atL?=
 =?us-ascii?Q?tAGSQdJA53DWa7Hz4CZpNvAUvp7dCDKuAEF1ax+ejMV7lMStbyU6VS3X32YB?=
 =?us-ascii?Q?sim1iMYN8XoqGl2OIB6aMp85rfA8nJhM4YXpB8ECkMQkzHC2ZyAmNThbp437?=
 =?us-ascii?Q?MiNQNjyGrPcX4MbSMD5JWTV9mGQq10LaSgTMB/8bCIRFVMHlOjeV7ETDrVR+?=
 =?us-ascii?Q?zbu9XEPr28EcktkbYhjkYWuZ9c1X2dVRhatSmDVb4upMSA934oggGbPwz88b?=
 =?us-ascii?Q?VU/Vdn9sD/RXwsmlSUFEl9ke+b4w5iHzrmsDaOd11yKM2O8/J+hYWnB7YEeF?=
 =?us-ascii?Q?1+HcMUhRWXAgblMjqgGhQl0yBzhwCMFpyiWGsVU2mNaGqpCW85pJHc/d7MPW?=
 =?us-ascii?Q?dmDKTuZPwrCFFgI6HXBGdd2bqlDZCjheofgt/M+s8cv7Z67b6J8MR1giXwEU?=
 =?us-ascii?Q?Kvta+8zVLSYZCTm5uDh1/sPKCLnz8ePYnPqIq33fzIc1NxYa5rvmfC95lz8t?=
 =?us-ascii?Q?jQYqYTSb7T5jALHb8jsCxcc8ekVjof8EjtDskXYzDpPZM1jSnqZ6qilvjWJ8?=
 =?us-ascii?Q?nNAugp5djHp9h6x15SE6c8a+LK3K33jpWo8R0X20/Ep1rqmlV37r0wXmQQAK?=
 =?us-ascii?Q?f2qSgvfIPhgl/z5sGB/6n9+mz/l22HbtfqEd4D8uVCk+f3icqdD2Cc0xSbtE?=
 =?us-ascii?Q?rUCNKYzr3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ee2eb1-b802-4be5-8b00-08df13789040
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:44.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM3NKTfJSrT/YLCPelYe/1O1MOh41jU8QeTvEasf7krZk3/uxv4de2sNBZtJk6sj8iLIbWl9a4VOdIr+r9Schw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380

The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
less than 16. This is written in the reference manual of all SoCs
supported by the driver: LS1028A, i.MX943, i.MX95 etc.

  Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
  0-15 bytes are not supported.
  (...)
  The first descriptor in a chain must not have a BUFF_LEN that is less
  than 16 bytes.

I don't think proper attention was paid to this during development, we
found the text at the end of a bug investigation. Therefore, the driver
does not enforce this.

But the frame length is out of the driver's control, and the network
stack can actually send packets with skb->len smaller than that. The
result is unpleasant, as will be explained below, so for simplicity
sake, we just pad anything shorter than ETH_ZLEN.

Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
through ENETC would soft-lockup the host through an IRQ storm. He later
distilled this into a small enetc-killer.c user space program which
sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
length) through an AF_PACKET raw socket.

The IRQ storm is actually a curious effect of a chain of events.

The hardware behaviour, when an invalid BD is put in its TX ring, is
that it would transmit the packet as normal, update counters, raise
completion interrupt as normal, but it would just not advance the
consumer index of the ring (TBaCIR) to signify that the BD has been
consumed and is available for software to free. The ring will also get
its TBaSR[BUSY] bit persistently set to 1 afterwards.

It deserves an explanation why the behaviour above would lead to an
IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
unhandled interrupt would typically just be lost rather than retrigger
itself as a wired interrupt would.

NAPI processing in ENETC has 3 steps:

I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
   softirq processing to the 'pending' state.

II. the enetc_poll() softirq handler for the IRQ vector walks through
    the TX rings affine to that vector, checks which ones have a TBCIR
    updated since last time - enetc_bd_ready_count() - processes those
    completed frames, and clears pending interrupts in these updated TX
    rings by writing to TBaIDR. (I've excluded RX processing due to it
    being irrelevant).

III. After the softirq handler does its round of checking all RX and TX
     rings for updates, it re-enables all interrupts in RBaIER and
     TBaIER that were previously disabled by the hardirq handler, and
     exits.

Because the TX ring with the short frame is skipped at step II (TBCIR
wasn't updated as part of HW malfunction), its pending IRQ is not
cleared in TBaIDR by enetc_clean_tx_ring().

But because enetc_msix() disables TBaIER at step I and re-enables it at
step III, another MSI will be fired upon re-enabling it. This is what
completes the cycle and the driver goes back to step I.

So the driver misinterprets the mixed signals it's getting from the
hardware, and ends up causing a software-amplified IRQ storm.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/
Tested-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 +++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0216f7d08e19..bbad942041f5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1077,6 +1077,19 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
+	/* Hardware does not support transmit buffer descriptors with a total
+	 * length of less than 16 bytes, or a first buffer size of less than
+	 * 16 bytes.
+	 */
+	if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
+		     skb_linearize(skb))) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (eth_skb_pad(skb))
+		return NETDEV_TX_OK;
+
 	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index d1e9d9130057..a4e76060e94b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -22,6 +22,8 @@
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
 				(ETH_FCS_LEN + ETH_HLEN + VLAN_HLEN))
 
+#define ENETC_MIN_BUFF_SIZE	16
+
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
-- 
2.43.0

