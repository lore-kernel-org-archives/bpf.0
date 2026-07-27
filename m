Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE43BE62A;
	Mon, 27 Jul 2026 03:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785121610; cv=fail; b=BSTzqNaDaf//02nuFR4xWRZtloRB+N4fBkPb2N7y5zGkFMSW8ifPd68KAmORwlxXlaVXfPoKUseb9IYMHyuHKgs+Kq0cPp0BLaS298q29NoihtWs5IZDrHhFTpNwO5iEPDaQT4fKpZ3lxENm2c2QXgtWIL8wTNxQOcybmDMwRgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785121610; c=relaxed/simple;
	bh=Hi3ozbyHD/Sj4b7S0QrRRH518t+Nx41WsueReYTyQlA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LQoJ0rqWYsRxNb8lIfMOxEpXH16qpWEMiNUQ/taPbtWQVeOl3ffxJlMUL5/XZeAQmyzPt2Ne5uW+r4NvgquW9jyy2JHBef9QCOsgMa5fWzQUXA9V2AeFSfjwB3OMGmyBbmpQXGjHHTrgjlZAHC7XyIt+nsRw742Q2BOJhyahdaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DKPucqjC; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DKPucqjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1cc4qpHi2tUw3iCB4xWsG7KBCcCSn80jkpjbG6PATBq6n0Bw/9X0pDB/Xjlm/2ivsfPpxftjcnSn/hrPcQ4bpO9lBBbJDSi3I2ZOWQg7qPbep/3tG/AFe8dfPlitWmDuiL86fv7Z65r1jA3/CIICF+AROrELJP0s6eDfRhwfKzHD+jQyXN+zn/a35M/IZjJsZYgMyFbLkwXYK5u7N7BY1gMOOPI5gdQewve7j7rQiix+fJUHC7Nb204q/aZYfsg2eThTbnGqOwYSFAJLAJc872DTaf5GHnls28SMWh24kCHlFv00Obka21IMAbyovSMaZTZGnxxUB0eq8GKP/JFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhHziu2sy5jBQHkshTnLnnEL2oMAVdslInTxEMS26LA=;
 b=GHjDqkwh7n0FGF9LZQTQi66a64qzBbkipGh3k7Un3ixUlhePNiL1duQt/0phw7ARVxCmZY6q46/CqQZC7FQlY8UP2DouiSSwPdD2c7KV2O+FTw+wI4eGMxam1Zgp2kYWoI8dXferO5/KtyOKORf7Gdj4JR0BlHjo6UwqXE0Tjf0f2Qh3GQcjm8fGxT8sabOwSlOwmP/yC7Qu6V0OU+6NN6AhwiHN0O5YzLZkmSYxDNIhH5a7wQ2TecfM/D6ZOj3qjCcCni27CTslZEVREDVxod1gOyhgJY/KCrfuBUrCzBteNaiE40ETJXy0Ro0FxD5HyBLJr5Qu1nGzT+kLqSYXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhHziu2sy5jBQHkshTnLnnEL2oMAVdslInTxEMS26LA=;
 b=DKPucqjCnmO/8MZ38SOqueNZgUfkYJSHVCFaq5ZNS5Issy6TqICzwV8vBEYlL20BZfrAan4kWwF2vpuvLCuA2MJJDXvxwQqowfumHK2EhWX+ewNAhWM9O5L/3n1+gbshE9+yG6gIe3Y+Cc3KICoe28wNOrpNAjFDZoqFVgZ3Kkjsju39pi03mh6StWCdCifBolXkNYvjSJ2ia9LleC2YZNz83sb5008oLQRhh4NgWTDuV4voLZNGlNPt3Zkq/hYtM8tIcE9UVcp9oGLZNMwppcJvdALYbgWsf7DOrOZM0yaYWKxBuYZ2ASiAD5Ib82KLVrOVHBP/Lu76GWCLZ8OjtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by CO1PR03MB7819.namprd03.prod.outlook.com (2603:10b6:303:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 03:06:46 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 03:06:46 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net] net: stmmac: Disable queues before netif_tx_disable in xdp_release
Date: Sun, 26 Jul 2026 20:06:45 -0700
Message-ID: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::11) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|CO1PR03MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0d74ac-b46b-41e7-27d6-08deeb8c17f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|10067099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	d5FX1oEy8T9QN7u/PG44RjMeXQqMG3d6v2WMxSMA2E9g8mNUpm7Vygfnu0Yy2CLWbB0ZKq/8nJMcxCTlE4Rc0hlfAwF1XBb+28V9BTOfAkle/3Ky4g+IX7gv9P4tEwBNJ/Wch1IBglP5T8yNXHgelHEsK8Q4RMMc9Rxs+5GCJbyN8Y0/RRy21DEDAsfw7/LghmkUekAhp5o5NuWLmhu3SpE0yzqSTaB33QuyUnuJei0GL3pm9jPtn35iG5dMx0zmpDi8K/9ajWUioHCkzn42Jqw82a/aQGma/9Ph+WEm8WYcRDvseamuTGU5nGo7I6AYaxzcKLhKqu3momCF3I+1dCP2T3zIb4EJVvbyEdkySfa+UQwvnYTWi4tY+hCuV1AiYz36nf7WhtO1Cv7Ca0jVAVpzbo8uPAUjZ70363IpaJV1tzBtiNHX/akFWjzaiAG6CFPsDS8/62AyP/JHbEeNl/icJH+NqYjITD7uShQtzCO96ejl59H9Z+jRFmslK9GmN7jnYpGrhjuvObyM2GREgCuzLMhfJJKD1HyjqWJLV+X0RevNF4xDBqauGaaNjGhZEWij5QeE9dLBFm6S0X6JZHpP/ZxdhanZrLHNlVCiS+73UPWhno0VhLo4UVj7awJ+mdtqB7Lu6fwD7aXCWgn2u9f3EpRtxImOlUs9hxxDTsU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfRQqf9cgrxn6fTT+LAujSQnDpqmYFTDNYR/kjdaYOOSc3zTv6iMECTl+FdM?=
 =?us-ascii?Q?Mo0ZapoG5ey1wvpWLe64yYUYFmpJtLo6pgobbTZ1SPzFTu8BzRpNsFljANm8?=
 =?us-ascii?Q?5FqmOXuhSY5bUUtioEyXUWO6brdENQBEih7WVR+MIsxXJ/X9LIXdxKt9gxWM?=
 =?us-ascii?Q?sKxm/RCy2pfFpJuoTpRjrFA/UPyNPqlAIxqQtr8rDLtSG99l3OtUUd/RmvcO?=
 =?us-ascii?Q?iTc6iyItX1XRWwgPD092LdbFfVoVrh2VSDM3N+2/WQ4QNYZSvMslyRep+VwK?=
 =?us-ascii?Q?lcUuTi8aOf3RI/XCfxjIGcrzb40RWZUirZjJHCNjqTm0IGBZgumje2Tbx/D3?=
 =?us-ascii?Q?LE+tR7A4XPDvWd7xq+OrJv3pfeLKinxcuI9/XlnqlyoRNZxvJ0ZL+/eDuYQA?=
 =?us-ascii?Q?uezxm6a0CU03zduhNHmI6M6eOWOnUdvnxvb5ZGOfc0L0+geB+a+msr1fOt5I?=
 =?us-ascii?Q?HJGag5qEzsnya1C4dF9IfbzcUTO89sPBL18tapPz2m+wqpMrcLBxx8KjYBOF?=
 =?us-ascii?Q?O3nentk3NuA0LqZedvkB3eGq/YGuL2UOqAKx8FSVTHA0I29XdLtw7FC9iNoo?=
 =?us-ascii?Q?lxXMHCMEN1ZTnTScI0F3PA/Kv6XFdLsGhbkA4290h/ddOFrUY1KMy8xlNuet?=
 =?us-ascii?Q?1HqMZKJGNFN7jv4KJNctVSqtJfRkWAoH8zyiSIpeNKSEdN/h3kgK4bWyblbg?=
 =?us-ascii?Q?HnRrmF7zynRzg0Sduqd3kIF97agJQgkY6ZrhWwgQltRsxT+QLik47gXMHako?=
 =?us-ascii?Q?IAbKP7xdvGUozEHS4jATsclfQPTbMGtnyaFPHKqWFI5m3pu1CDQMKheUG6qY?=
 =?us-ascii?Q?be2Q+EaBT7sXCTm82m4FERvU4pUmNzh31IQoA6cDnA2i7Ljac+3pun7UCO53?=
 =?us-ascii?Q?kBExukjnAnhUz+0MGxUYjdPC9p6AViB7nMw9WxtEXHXcSrolgbFu4NqJ/wcZ?=
 =?us-ascii?Q?EZHZav88MG4/VXNJP4PLM+cJFIqLGL0QKXTg8fWzI0FQuGQ2HElBGeJOpWlX?=
 =?us-ascii?Q?ACDUP7nMenwk5HCTLnfbHrlmzxkqbhur92mIcL9Zr8yBZYYkl2XM9EmtgHea?=
 =?us-ascii?Q?VzZ3vhgKPxJ+qEJp5BNaZB1GCuxZffMBFJ5q53jwKO0G/u0D6ITbWYPBcnGG?=
 =?us-ascii?Q?M6XsXnGpOV6RB10BKM5DDo4Jti8InbNw+KokSN8vZ8Xv+HI0kYAIvSjIevhL?=
 =?us-ascii?Q?EFBPNzsHfdBRYDrUbLd8bbo+6WrJwxh32vGVRHju4JZxOMSiDwJ1/UgjfhU8?=
 =?us-ascii?Q?rs4mY3wGa1Z8PeAx1O2p/KiykShaH12bu/LIS4as66p3c4PuPOZmwNHimiGs?=
 =?us-ascii?Q?pJUsAujO97ioEKyBpAxEUtBKSpjjd4w6Lmd06byYmVtWTF9XHHzA2WL/BUEf?=
 =?us-ascii?Q?xlzBHOI7KjLrwoLpGezWNktRV4mJYI63grikzXNSqsUYKKsZAn/JJFlUZUwf?=
 =?us-ascii?Q?YmwDbFLSGbIKspYleNCe95pgdElNT2YxD7azEzxsagi1tF86X5LUWGa/l7AD?=
 =?us-ascii?Q?60O3uH66HUIPwMFSYGpQ+saopokiB2NnCzO62iw3dhAO5izw1vCjQMu8ru56?=
 =?us-ascii?Q?cD3dD1c7zZrRPhwdT5h82/Xwc4yHmE5BLqQi8mus+sJDxhPwfQDuLT6/ZQC2?=
 =?us-ascii?Q?aqqAyn+QVj7HVdmmzE3lA5+DitGMdnCAvjdI7ER5+/iTsWYPerfwWWfFD+Jp?=
 =?us-ascii?Q?HMiEFP5KmBkENyRFBoPKRqp0eB4ZJ2kjNAtfOwxffTRdmiyi6zInvrcZ234/?=
 =?us-ascii?Q?OhygYPvibv0SxdeOgydntrkvVn2eiPGp/CrxGApmNXQQ7sf6OvTtG+gkudPa?=
X-MS-Exchange-AntiSpam-MessageData-1: fZZ2Jgv9LmUqyg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0d74ac-b46b-41e7-27d6-08deeb8c17f2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 03:06:46.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9mfNHrW3CJgNmLChDepCnVXXG6hPBLIzfz/jM6LCC1MtwS94b919uhwELGLhZa9wAHzBTge4ENqf1zHcxqKtYXTnxJDtSSJSwIjV375wtm4x+DdM6z+lrUO1LhiSfe+OaCvkmZtTFc/iK2FtLwtRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7819

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

stmmac_xdp_release() calls netif_tx_disable() before
stmmac_disable_all_queues(), which creates a race window where NAPI
is still running while TX is being disabled. If a packet is still
queued at that point, it can be processed after TX is stopped,
leading to a kernel panic.

Fix this by calling stmmac_disable_all_queues() first to stop NAPI
processing before disabling TX, matching the order already used in
stmmac_release() since 7028471edb64.

Fixes: 7028471edb64 ("net: ethernet: stmicro: stmmac: first disable all queues and disconnect in release")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..75cb53938519 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7099,15 +7099,15 @@ void stmmac_xdp_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
-	/* Ensure tx function is not running */
-	netif_tx_disable(dev);
-
 	/* Disable NAPI process */
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
+	/* Ensure tx function is not running */
+	netif_tx_disable(dev);
+
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-- 
2.43.7

