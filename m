Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777017BCA;
	Tue, 15 Sep 2026 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511266; cv=fail; b=jST47YmY8yi2dCLA7VOoWy1CjLFd8IDeXsfAboqk/fCH6WEhMQ1P0WXCh/qoerhfCeHzBCyZuJMKdpyvyfiHSd5/o4HywSFVF+KCp+xwUY/e+1e0Z/w12I9qoHBeTFdY1aOkgG1Qx61Wq4cr5X27BlmqnbXqCZbfGmgMNszIzHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511266; c=relaxed/simple;
	bh=WMM08nhvPDdjc2AAx1kX4bCgxzknYFy/ENLA7RUnwWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ohm9yKMQswGr7lZxCHPU9ws1wkxJHQnNUTrqH9lVabl/aILKAIA+BliKCrYLXzmZlFk33ISAXi/sUSc/4e6KnTnMCAmsKLsAg3uLKUXv79KQZqYwNZYcBSNs8SAtN/T7UHUOY5NurveWLkcn3cBG7VakkHOxujsAQx1tsJx/TCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FiWR9WjT; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FiWR9WjT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ3ytW8ImYID9YEgkth1mvPYvaYJamZu9mySP0XkVWo/PRzz1guFKDkArCNrOlp27B+O9kKwDdu8phddnznYHzyqDnd5DSsVdnwYxa97orVpTGr2CtD0vuhiOCH3d1nScB/9AnB3IeBUiX/gGssJ0GCsffT33AfJ0pfS4UfGcoyAbNeK3CDPvCqOVI2mzD3F92Jahla4fXv+iOSypvhGkRgipF4mvrAxxtPSU9FqOmrXsnAgb5Gr8V3uI12DeOUcTb0RIvPiwQGTtfGIQVZZLpv1t1IaICPDavrrRaYQV31KVTMdZOAmwVQos7QLLr8vLKSUYH1E5uuBoudc/JXjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI/5AZrPfnQJaDGg+WYF+yjAB6hXY/Ppa+EQFxTglkc=;
 b=R0wUzYTorFOMOrUht4AnwJkmlFpr2TJqKDfsgXPxzxWSIRJf3FMk0HFt1nLQE5D2nIY94Rsvw73+tOuhY8Xs0ztCJt/yDRHlleecmdmqDzMO+D7c7xReefDqNdru+sNnT4jiGesz7vCmeVRJHNmNgo0fdSG+zI77bqabgK5ciPxDcU2otNNMAnt3o0o905aLamwT3byoeEYYm7QiE/glRy0GHW24zWu/1LDtfQhfbVPBF4aOlVuQ3xkymtDbIqdR20vDd4wRpZ9M7CRwrYOEou2Wrg/wjQ74N3PqPtGymcwZnKSAUVs9gEQUWkH+OxidEu48B0/lvtPI3k2zOTHB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI/5AZrPfnQJaDGg+WYF+yjAB6hXY/Ppa+EQFxTglkc=;
 b=FiWR9WjT+iItl5Be4tvAKviLs1EEZo+HnHcAr8KVj+S331IKvbcQQc2ieltTWJypzG9y0J5vrs/s3em4j1cS87/DOo4nxG4hjNs+hFfrfxgxNbYbcnPFY5gbYwOisvXcLhr2z8aWsmyO+lEe+MjpFu9JOAkoQ/+0DDlVeB40MiAzxznvH9mnYBtTQV2XYF5sXvLpMQqqzAu8qAw7zZwvRY47Gx6RT76NmmWWj8Q2JTqEzebCX/xgOuuUmSlTGiuM/QJY1YUwJJ9acv0Ju+k7kKoLnsQ2T8+vgfORjfV+xVjd5ASkrVoCzo7ykif9kBNtrJDm/gOmu0jePER14g/gyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:41 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:41 +0000
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
Subject: [PATCH v3 net 2/7] net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
Date: Wed, 16 Sep 2026 01:27:29 +0300
Message-ID: <20260915222735.1016937-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::12) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9d4d45-c5c1-4eae-4df9-08df13788e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	nyvJHoeLBS5iOBnWY2B2CaLNV2cMYtpN03zI8e8CxBk0/ERcj6bzHmhojfTzimoq/P+3ixV4wCis4zaDqN5qfe2bE73Q0hnsgIlXLvdmPT8sTi68In7tMW5CdDvRJaEB7aqkxlB/lMJo1hf01erEbnNVpriS99tJy8TF05jCU607u3thtLYAAU94ENTVQDPwebxq7B5N+zyCUfX8HDAIlQGDp3kMtLaNOpBXs5Uppvc4GclYItNlmDftDfKplhT5aY/XcPjKVEri0z2w1KwORiNbwr1GTmULVwMD3+ECLl812cAgPxUI54l/9Pj+507S9OPqDujjrlKr5ohFQiJNiCp/tevrKkAmjh2jzlL2aZtVI8aVssgNBDjrq1DkNgWwwT9ldLkStu5tZ2GGLZYsd2Y4J1Vwu7YlPD0Mx4xegWf3zR90qUssUibF3KnQibAwXlRCVhpNlpAH1YHW3kAmuim2NR/b1I0bmgYWATaH0raoRCnyx3Z3cQOIdFXEw6bviIAKgZCB5Pc4jxqcKzMeQ24hK+B9arTQ2bIhlj6eX9SOEc8Rb9Q8aspW4ralOcDfSPblb1Jfa50vDENkwK+GLVYM6/iD6C9o498DQMWdQcdDLB316W0bDiCzpSK0epLdrUubLu8dm8M6Oy1iwmN5x2VePjoBu6qzeAFK5dsAufo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xB6tbt4fn73NmBpcwxQh2XQl7+UypxpU6ZEMmeVQy34JI5MFrRGBRyjtv6qF?=
 =?us-ascii?Q?TaEDLvbv+Ucd9F3XtoOuzDjdkZ77O1TYcqeOY5iB4RN9z4/qbagmyHjlZIzL?=
 =?us-ascii?Q?5IKukMtxittfXuRlRRFDUf4yzb8Il+AWieITkFIVXFW+dhZxMBeFCJ1vCTe2?=
 =?us-ascii?Q?0YzJaGwdf0y7KkX+dbyWHYnA9x+MWzGUjZP2khXD7JNsUIcNkc2mI2aCETkX?=
 =?us-ascii?Q?lydb0/L5BRN7GNehFsJwbXZ5t0Qy+WtHEhozCgAY4zmjX2xkVAZCrNdVOLRb?=
 =?us-ascii?Q?I87mfAZXZ41Nm7yL/BdFUCciqOeozsBBFYjfkfUq4mMTmaU5wX+L+eVfPdYi?=
 =?us-ascii?Q?V7R0tm4p96up+xrol+EoKFN9Ao1OLj9RYtTvxZnMnNZL5PS2tf4ST602Lcib?=
 =?us-ascii?Q?ToVGVXu3FQZPOMMshc/m6ddJpX/SxyN+ctUF2HgQnuRobSmV2+LKyq4hOYkn?=
 =?us-ascii?Q?+RBxFlApiLv+16n8Xia9u3/CuhtQ9AudM8MAoOtUUN/2fp457P49mR98Rkxk?=
 =?us-ascii?Q?XTHaDnkcLnjS3J2C/qW0dntU0QktDuQocU1tWVEApEWjAxYh3CsViDry9S0U?=
 =?us-ascii?Q?5Nx22feoCbInd6GFmfu+8RAqrYFnLjuDAQjo3yADzXl0DCiNzZ3zqDsXhNdd?=
 =?us-ascii?Q?mGT7Y+VWXa6iOJM9kv4dAPJLzTpy8aMhKq0LdetjB2WaDeYd9txCYCkj6b1l?=
 =?us-ascii?Q?fOejO8V8GeNrSD659V9HA7x6rE7FkNJ+PA3tIqYncFQNZ0PSa7erzijGLBXH?=
 =?us-ascii?Q?V7BJfyscUn28dZN993NjGO+FQAsH+M1fMKzzxjAeZN6Rr8KW1/pzu7du6CyJ?=
 =?us-ascii?Q?7VnwLPBBbGsix9IkGBnZGmoJj5MUF4Kc71Sv+F23VGbi5OJOt6UbwZkw0mB1?=
 =?us-ascii?Q?0RfSPH++kDRCqWf7W7tV9bJlWSD1Vo8tquGngTV8QOESdJr/wMLiScqiNaxp?=
 =?us-ascii?Q?V/9dDq4OhP19x1XhBSexTgrER3D5sWKamovYb8z+GRkaW3xKv5ObD4iTaqCr?=
 =?us-ascii?Q?wUkgvv7Fj9iL1g7vsuCQ8iyzHhzZQ5OagD6oCSm7+GqU//HfuRCX/9tI7Jpq?=
 =?us-ascii?Q?ExTs8hhu1exLOAxW0KxONp80Y6Z6QFgmugK6BOaKrtr4yuhd5fpSawYZDMim?=
 =?us-ascii?Q?cO2kxrgZqE4EBGevkiR6FH2Rh6thQmlm5yoNku729CpTB9Va5eKUN59aew6G?=
 =?us-ascii?Q?62bCYpYSoZU36TXgPs19EDl/MPGFKsLEhHOt4sBqc7IVImq0oC4+bvA+oGSE?=
 =?us-ascii?Q?CUuxcJUEaXWxMVgX0bS2Hv+RE75KPyRk0EKwQEtQrvsXPgcWkdL0T8N+E2tW?=
 =?us-ascii?Q?xEAGPssdlYKOUZ0pqq37UraPHk3Ti9EvWuvTBDKapuuY7b6XTDz0oGKq1qnj?=
 =?us-ascii?Q?WnzB9FE8n/lg35gCnA8FYIX6+p14WS64SC/KtfMlCQKKt2G4M9gQUsP98eJ+?=
 =?us-ascii?Q?5XH4ByNRqiJxpQzbAIEb+Gqbe/0WL7WtlcK1uSVtfnjXDVZgzvZwRrUszM5P?=
 =?us-ascii?Q?c0h9TbJmgEWHxhcwwcl8M1P9F3YS4NXKShX0FV1GuVF+rhia6N2HvZ3rEBfB?=
 =?us-ascii?Q?ilutPT9iEsW58020bEGliLUhlfdf0A0uC3Y6p6kMt81+MZzcfj4QXS/brA9F?=
 =?us-ascii?Q?3L1eUt+7v/SPZnr8Kt8CYRP7caRrku6RpDFpTTXPOeJA3UqwV6jDFs9gLhjC?=
 =?us-ascii?Q?JyvhzmTBM7GVVvKiHwFC2DPrCM2cMHIGs78XsbdXXrGxZ6Gda6sqtsNfzocW?=
 =?us-ascii?Q?LP6RPACgBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9d4d45-c5c1-4eae-4df9-08df13788e18
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:41.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HW0cWGMKSm4J0vJjhmyyEMWY2YTup4l1JhkeT/qrlt7fhOc4pYZ4Vu5XDbdkLvOweRYcXF9BamOJdTfQxtC/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380

enetc_xdp_xmit() keeps track of 3 numbers:
- num_frames: total length of passed struct xdp_frame **frames array
- xdp_tx_frm_cnt: number of frames successfully sent
- k: index of currently sent frame from array

With "k != xdp_tx_frm_cnt", the intention was to detect an early break
due to an inability to send a frame, and to trigger a TX doorbell
anyway.

However, that doesn't work because every time when the loop breaks,
k and xdp_tx_frm_cnt are mathematically equal.

The correct condition on which we should ring the doorbell is when at
least one frame was sent, and either the caller required us to flush, or
we couldn't enqueue the entire passed array.

After updating the enetc_update_tx_ring_tail() calling condition, we can
delete the 'xdp_tx_frm_cnt' variable, since it is equal to 'k' after the
loop exits.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: delete redundant xdp_tx_frm_cnt variable
v1->v2: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e7ecdf8ef67c..c9c23e994f6d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1813,7 +1813,6 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	struct skb_shared_info *shinfo;
 	struct enetc_bdr *tx_ring;
 	int xdp_tx_bd_cnt, i, k;
-	int xdp_tx_frm_cnt = 0;
 
 	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
 		     !netif_carrier_ok(ndev)))
@@ -1845,19 +1844,17 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 						    &xdp_redirect_arr[i]);
 			break;
 		}
-
-		xdp_tx_frm_cnt++;
 	}
 
-	if (unlikely((flags & XDP_XMIT_FLUSH) || k != xdp_tx_frm_cnt))
+	if (unlikely(k && ((flags & XDP_XMIT_FLUSH) || k < num_frames)))
 		enetc_update_tx_ring_tail(tx_ring);
 
-	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
-	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
+	tx_ring->stats.xdp_tx += k;
+	tx_ring->stats.xdp_tx_drops += num_frames - k;
 
 	enetc_unlock_mdio();
 
-	return xdp_tx_frm_cnt;
+	return k;
 }
 EXPORT_SYMBOL_GPL(enetc_xdp_xmit);
 
-- 
2.43.0

