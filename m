Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57647988B;
	Tue, 15 Sep 2026 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511267; cv=fail; b=HMDmQJy8vzZPxXdV0fPYyzpUvwZLgG7U/d9Az98ef+WhNAGDPIe5LKFIQGUEck1KnQZdobbk8Sls/tduGKDktpC978bvV+j0O+Y4XgKCe924i6ECGUxjvyy0yJ2VELoH6NhNk6Ddz4hr3UKf9N/ITFbgbq9u31eFvKC4kt/cBlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511267; c=relaxed/simple;
	bh=yJCC7ONmLgv9lgT+V04OXG65I0WKgJ6dKlimDoaIpCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DYXQvdnq44BegJZdi4N/5pwK2L/2tPQtIfSPyigC9BY+DnmSeRAsDa62ZhAdraG0mS4VL/88gyj0cYsPIz9awJkQfSAiJJsZCvhsmvPYATcTXF6FtfDwgY0v3X583Gnii12jsWyc5QuRHWwECNTPeyBlVkqYuhR9mrNJn4ZAySs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uc7a2Rqj; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uc7a2Rqj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgvKp2b+bl4+Yq6ALQoBA5FO//FnGboUTCjIMTp9IXBLmEVwzEmIl7Y5hpINjRSYoRzBX//WgmwtzfGXnwkoUlqya/g+X/8o/scb3ZlneZKQMM/vQZUFdyzhel9oqJL/L/+/NicdE/Zixu2djz0jF1JuhMdcwMD3DhSOuMo3AmsejOkKCrGPSFRjgC9OAGzEcqcqvAAtiqDf74P601A54hXduv5YGmMYq0DJobNEqt4sw6EQRD62ISy5kGqZ++7UCxS7qvKbY0TnGIlQzJMGYjXQIe4oIPW1CObXD/EvQSzDRqlgN14m1MPyiUckbpzfh7oH0AEHuM2QUJJOKuf5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ49xIsfaEAMoBUftFV2rtsZG0WDNYNhUdm7cLU9Fho=;
 b=VPrL8VWh8kXXHyNNn4TXtKwOFCOhdC4FpPwxCS0KdbSztq0Vy7M66k2dUqxPohUgYJHbbQYUAIRsPI2hIYLDzllNHC2zwTUdjmozM1joxpq+Uh8scmOLCvQSNFL4dPC3NTdOt2rm8YF/a7bGLiPX8XuNeR58hv301lI9RXVxCW0xGoZjFjVwMWk6nZFnQwy9UTZHxHkzCyle5jhc5H+uDVrXrneAb9T2DsnWh5Pt9BAlwpKCl81M0seMAQeN8QgaNwSa7WnbDDN/zNnHPf8kJvpch4aWsi5/a7/eEQBp5HbZrem2mT+5Q72dQwjM+dybCtRvmfakPfQiY6lTmkbfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ49xIsfaEAMoBUftFV2rtsZG0WDNYNhUdm7cLU9Fho=;
 b=Uc7a2RqjGKyeNhHs1Hw+/ePa/uey3DOOEtSFUMbz1E3Neb+WqbiE4b67Ijg/e/a4ogZUhMxQ9k/eFXNO3MlBPPZYd3mepUdnotFZXY6UbGutJddPq4kkYC1iKrcBqx9X78hwk3SKi4GM+WzW0ajwHJQM7gX3cga/yZnLLgKZ+D5mHzEfcxnXrnrp7rVp3bXF1m8PsIU5xv4X78SuY3Qc3mirdcsOq/kQyEnvYJrh+oqCVcbCI4+EmJP5rTxkKtgDOpTeUYwThOnKAcaWaJKGyaHAJPjC+7R/oDAqxikYaBmr3sWPKooDHanbECWqthYizK3/ffEzz99SsAeY+snw0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB8448.eurprd04.prod.outlook.com (2603:10a6:10:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:41 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:39 +0000
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
Subject: [PATCH v3 net 1/7] net: enetc: consistenly track dropped frames in enetc_xdp_xmit()
Date: Wed, 16 Sep 2026 01:27:28 +0300
Message-ID: <20260915222735.1016937-2-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8deb0a-2b5d-4351-33f1-08df13788ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|19092799006|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	6EaUcXKwduZOAc2145AZ0g9v0qW3pLhIWV2lw6TImK9/sx4KLWRffOGifvBSQT6B0ogNfqP7pNBVY5J/EH8U5NyNVKA5+z87gEYvMIHSnpTKIJY9tUT5QkmVeguPsm4CLlrRFXr4X7KYEVooedDyxZBLZmPVIbn38pHm7fpIxoZli5CtcLWZQLDLALzpo1AdoVpV1qfdL+rpcSACCyeoABZK7kcw+0p49zBwNc+QeuUeT6Plhc95Fw2INB1joCFCTmoF+WnkT9WUUW1+nS0efyTtTXihjNd4GPmK5BMfe63P8INvZcxJ7ngJTijTiuDN3OFZcZ2Bl1cs1V9o+bkGP7vHh27Ft+pVh73eHZ3BFIC8B+rjvIWAgTXHqLKLJ+BpH6OuBt8t2k9Hu+OSiAb398YNG08qD82MpRNgtJqoTebvOGWjMtuZVKGxdFGr04MfrBgADMTyIE475kd89jSHCG8lKt0LMpdRUWl1HYAnXtFUt2by6iyOQ+a5hEKv7NCxGckKnYUXTFhYXpqcR9OfDa5iIz3GrESx0eZAcAkfKOpEeKH/E8mLkG8s4Qixg6MObzzLnJI3+5iMhx22DzChDan3f0mLiaaS/pjSIB1ing33sdM8dzlTL+DCOtHwkbXE7gROp+F7mHIV/45rMi5cpmyzwP3kE6qxSUkHxlUXPsk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(19092799006)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q+/z8/W6z7GWEaqUBKSgDsrUbZN7CakiHB6Va4YngBwdr4Hdw1RtUvJ2Kfwg?=
 =?us-ascii?Q?LTXoPvo5D7CGFRdl+Kjky3MEX3KleL3aIemG3UHXDER3sd0SVkOrEmbrAIVB?=
 =?us-ascii?Q?7ERhgEfmNBuPqTd6CHP2C14BwXFdb5rXDR3Urtn8IbrKeksZpwfepx+NP4Dq?=
 =?us-ascii?Q?s0RD7LD38WzzpKW/kiDdj8VNnLNRVXRndtMnzmLto/0lfZEM3GAnzj4frh0j?=
 =?us-ascii?Q?j0574Tw6WFxM0Mcsmz2ARg3JTLdtlze9D5u60ZbLraJzpiDm+Uazhpp7U265?=
 =?us-ascii?Q?j78CeIiyKmzoqYFZPcdYgLFVd8gUjjlqZrkJkQgivwudWfM3RddXj7ktgJI2?=
 =?us-ascii?Q?3v5yAvElARz8qgaICOytZkhwYxrkbZaeRK8x37ZK76cqVNn7zjz6eDIYlGf5?=
 =?us-ascii?Q?68T6YnNz60wZaptF0TeAS6UNU8ulUJsQ9J5kXp/lbH4feXHFb6+TSwwD6j8I?=
 =?us-ascii?Q?72M4rDS4+vVRPlNWh/SDiEwtbAcsUAC9dy72Y1O+OpRspuw95fCVcocNO3O/?=
 =?us-ascii?Q?H3171ZZZR4dlE4p5p4+SZj/FwBmc2SyKj8xiTKAUwG/zkEigs25EPkjADcqj?=
 =?us-ascii?Q?5M04YTAJLCYr9e+3VCZM5HFBGWLKzIcpSTQpR+cQIAgxzfmOoGroG1Ebhru8?=
 =?us-ascii?Q?SRCsCMW3DA+jWKG/MdLrYHFbBBmKNJG0PXuXJLWXw3BjHKDzlXS6YX7WcvFh?=
 =?us-ascii?Q?RbilwhbW+K5+MntDNEGlrSGtbCI2PZmUk+9kv66C+I4SSbOxC63qz+ZC2sRR?=
 =?us-ascii?Q?CQihxid66xkVwzSK1TqHNsvdiVdmeZr5f0ouD8H5+pAuiy1JN5bwgFOZzhNP?=
 =?us-ascii?Q?tBe5impAs9HDSCsSiFq8NjrWtNAwWAYy2hhHvvk0CWuQ2xrNh4FpDACsmAFq?=
 =?us-ascii?Q?X9s34W353wdlVJAnGRJ6z4qzmGJlhv4d9CNCR6n1r9fAeOrTyaCmxi3MAwKJ?=
 =?us-ascii?Q?xT1WYSOcPUUI+ub7E4dm4U1PTGoqGh98yfx5gf+MgvK1rpeTNzNiif6wnVIO?=
 =?us-ascii?Q?TwEEbmUU+gDpR7ostMcyox+UgpO8qkaTO1z1Z/2OK3iii0eOFOxHJgRiAA//?=
 =?us-ascii?Q?9sJ/lD2kBXCrZEmf0ZSsA3qDORi7Mvxr6aHSIJlEHy1nwzD0wW2wZQEPUpxS?=
 =?us-ascii?Q?qSQzNY/CQIJprelsq2S/6JUq1BfZgzgnSdnpZcbBdYDpzAfeyG+4prPp7LP1?=
 =?us-ascii?Q?CziPZA1S6C/zha12a03yu6PE0LXAQpUUp5d6VzgshD7+UB8GKsasbn8vJPep?=
 =?us-ascii?Q?gmJLcssbqZKkLQp8tsQ1KOHUrdfxJ9moiZxRoh+JLuSbNZOglst8iNMB54lT?=
 =?us-ascii?Q?9IpHj/RN83KnStZwljgEylgfHlx4joDRsYoqP4aRGPL41ox/Fc1mdfmJL4lB?=
 =?us-ascii?Q?mXNwzxWN+X5ZejhnMB4nJXPeSRRsDsWebO4dzHFbKjTYw5aR75n86YKyZKr/?=
 =?us-ascii?Q?HISsrdv3TSs6nHTcUSP1I5zzo3jOESq1sD9EmD6jHBjYxGNVTCV8x4SVwSp1?=
 =?us-ascii?Q?peLxXt4CApapJY2XYeFLDxN1Hl1LGYiB5Z2VMy5Qru8A6o2txE9dlS3D4xN8?=
 =?us-ascii?Q?K5H2TdrYTPdhxGLOXYeDJwGhNQl0tJrbb1YQ92ytrFg2pVgGRWIbqrpx6jGD?=
 =?us-ascii?Q?Usz8OHf6NtU/os1YiNXSH36mgyKnG7d4vzS28zvjBBouhJtlyw/cqDB/8Y/X?=
 =?us-ascii?Q?CO2vCexuuvDWr9x9YH51cJPkIy5FtbcV24VTcdaMvK9nXBhopI0OrVnv6CO9?=
 =?us-ascii?Q?XuSDrP+4ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8deb0a-2b5d-4351-33f1-08df13788ce3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:39.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVWeBTkf4CcBsngtEaM0GY3Ih8Sl6XrfkcuG6fRxbTzh7tr1D4ieObDlXzwDhUPdNo7KA6y/e4OlBJuAnZtqYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8448

2 distinct classes of problems:
(a) failures in enetc_xdp_frame_to_xdp_tx_swbd(), as well as frames
    split across too many buffers, should be tracked by some drop
    counters, as they will not be transmitted. This is similar to how
    enetc_xdp_tx() increments xdp_tx_drops.
(b) enetc_xdp_tx() failures increment xdp_tx_drops by 1, but that is not
    necessarily correct. Wei Fang points out that on .ndo_xdp_xmit()
    failure, bq_xmit_all() drops all remaining frames from the batch,
    not just the current one. So we should in any case increment the
    xdp_tx_drops counter by the remainder, not just by 1.

A limitation that remains is that the xdp_tx_drops ethtool statistics
counter tracks XDP_TX and XDP_REDIRECT drops in the same value. We
should distinguish between these at some point, but that is an ABI
change and is out of scope for a bug fix.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: patch is new; replaces:
https://lore.kernel.org/netdev/20260406204122.167237-2-vladimir.oltean@nxp.com/
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 80f0082f6c63..e7ecdf8ef67c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1843,7 +1843,6 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 			for (i = 0; i < xdp_tx_bd_cnt; i++)
 				enetc_unmap_tx_buff(tx_ring,
 						    &xdp_redirect_arr[i]);
-			tx_ring->stats.xdp_tx_drops++;
 			break;
 		}
 
@@ -1854,6 +1853,7 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 		enetc_update_tx_ring_tail(tx_ring);
 
 	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
+	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
 
 	enetc_unlock_mdio();
 
-- 
2.43.0

