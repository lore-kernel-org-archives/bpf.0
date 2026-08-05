Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CA40B6E5;
	Wed,  5 Aug 2026 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926996; cv=fail; b=afffnGZVEz/sENO1Xf0dxi86/JBT0fd1/HaPhmEqxKps5ntZQzwEtKKezYpogv8Nf5OiCnKl2iVs7aduShuJD1QRbuOGIfu8Wjoo6XmJEhnWmbE8cgokmC5h7wRJZmMaf2Mb0P40d5Ilbj8rcj9X/gWSagq7kSC4Kg8r9QEVCxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926996; c=relaxed/simple;
	bh=gZ20yP4wKdTLKVyFNUu5OAlZIO2ioejUgSg9GypHipc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+bCFEq5S2T3g09WW5J6yr9OxasV2DjdugaQfCVl3wWRF+yPoLsQXsmrqLh4qRDUy3/SMmrkuc4gNvoewSZ14bHQ1pVb+ta1clT7QchHcANYcrTVvg1/cdx7auGLZgV0U4VNSuEdIOwLKhzUS8pkH5MlJy4+3gNg8+gGCQ045q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CPgiFsca; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CPgiFsca"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnBAPclBElvB3mVpNlKvTEbf1/sDK/1PfpqOFy1IZjvzBloKMSoh1AwM0g1BeDyxj4uSvTABGg95En9lFGeWxp685VnfwUzSRzbhpXUrGU8N7c9Q1lJE2rnElGwfnpZpZK3Svx0KaicCUdWknUBqsNLGIDmL8il92GRbNm2CMD9YmBdTuD/1hwEPjVxlkzcLyJsVOJHFvhnjFTf3LE4ng2ul9edeTkIL+kCgyzy1V5P4bDNIrwh+fl+pQFXpnCTTlHkUyje0UcaUPpBfgmm0dntV/GXH4ipHPvUjMbZwUmVJX/hj5UO3jS/8q/qoy+bPWgcpCP6I2Cy4NuGLP7UBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmNhbTYZenIvDCFI5POx8GS0B3F+Y2b5WtRYVUvI1Q0=;
 b=hRrphaVxCSFM5aIZrz1DBXVgWLxdfc6EFKsbno4TKmvFGwIgJ9k1pV5077dYrUBPY1sfh8ya7l+OAsjxZBK8BaLTsf6FrX19QDxbwQy4mQN3pnJ68wqW2+9nNWGoVSTe1VSDQS7bTTjFsaaOpe0ciWBTHsL3P/0nJV+vg50YurvgPdGFbt9k7pgDJwpgJyxTXgRakdnDFqSTIGTYhF/HOT7tUYpMf8a0UNlU1rqqxKqvW9hHAXAPfovRa5VLOCL6Z5Q/hoCrI5wZMLjn/TRAII6Sm651R6wBDUGdtEqPdKww4BvEpZfERzbspWUP9BnoE0qzphWa1pMwN2Sjy5Iitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmNhbTYZenIvDCFI5POx8GS0B3F+Y2b5WtRYVUvI1Q0=;
 b=CPgiFsca7FVS5cRQ+cXLILvffA14qIdlUevPl5Cj4T4va0D/vgUt4q5OdmFKqAZKHhFu6zxfKSkip1L7CDcFc/fM2u+4/3bYTpugOj5Z1GkZsXLAo/l1QuShK02HOEcJOXXYJrKWegexYmyY0pOBtA2iCmWtD6Msa4ANG/vAosG6yHBycK3mzvbHiEFK0tp22E6Q3tDb05b4GnoRtTi4EmDr6WHS9riFnyxdnW8cKv9wzLDJ4u/s6Di2KthlVyP2wrPFTtX8kgtoxaaRh9QO84puVt2gzrrA5QJZ/cDjUMB03AdjfgzupinYr723NUHovU/hxTEMfWkxq2uYWeugJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 10:49:46 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 10:49:46 +0000
From: wei.fang@oss.nxp.com
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	liuhangbin@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 2/2] net: tap: fix skb->protocol not updated after VLAN network header adjustment
Date: Wed,  5 Aug 2026 18:53:14 +0800
Message-Id: <20260805105314.3882595-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 099bb309-2298-4f92-f7c2-08def2df43ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|3023799007|10067099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	PupRndUR9tIOx4ZH6POFIainJhFs6QlnPxBOEXSDooz6ZlaWKvf0AUthcL/sYTbjiynPvZv9PMKM3zkVsw0zjIDGTE1wUB7fynMna6efIal9k+RqNW2vmVpCSBrrwmO+OUuqYrjI1GafNYZdGEK/4DpPDYBu8hbFg6bqWF/jDud16Uf7/pTvKjtqmaVEleaa237Ll0tIAmqSLxKigXV4zOni4mgszX22/R1IzYKBNGxeYEF4TcXwiMC/vKUFtDBSWBGDZ3Edfqgup9oWKkv3t6iYdObwaZUJt2/oltk8PYNiKNdL5NfQTGKYI/GxaUlMzSJ2jGJ7JzE2TzKsSiTPUbDAlwqtbfj2vcIXtY65WLNaISxYFrQbFSGekqJS7+PrAYzy/lyaD7CbtmRyM1T/osp6dRd8VZUu/OAD9KuxW9KecPLxRQfvO4AKhxWeQJm3n+GVD5Bd1/AsHOHXFI0x4RZr879v2p+g0tq1Zc/ezerRWed6pjzqZkxKbnTnTAAn3AqV/r9N/8d7dmJY+V3NtsxJoLBYdS6kchOnIFqg0QS2pI66/KPmqSLa1olJlALSPXc39KYlCqmqzyZq4TgEfNdYn+aVln0y0lFVcRHZt87JhNAKNtmmE6X5MxxtSobK+tPZIi7ypjR86+gzgI6VMxO7Eeyh/e4NHqyAy2PTaGGW4v2/XTnPJrRMACLifK6TCmgM9t1mLmlZ2tuEZCewYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8GDmI1J00MfQ2qflnIiY4mVpH6YZkvlsALd/8OlyaVvmfYzhUWUWA9Vfrl+Z?=
 =?us-ascii?Q?qZaFs8EOhfR19mHN9HRdH94Y5rpJit777/CljhP0wyDckdQc4QjOTyC5sbAa?=
 =?us-ascii?Q?valSpVLWVaZCdoeorwJwyJrTGki88eZXLCEjn/R6XzSWZT/3ZOTt4IzCmj4/?=
 =?us-ascii?Q?pjpeCgG2AjsXFNLwl2YxIFgWE0jfdWpwPRtU0IsAIFuA00/BBLVo22Vcyhsy?=
 =?us-ascii?Q?Wq8G9ZhdHD/KaS3VVUQucVfRnoFt1ikI+aiKRxhdGgc1sFzAu8sIkPM3CILv?=
 =?us-ascii?Q?1WOflcJMkIN6GC3W21prHo5omDw1Qx+mvtW+/Z/VRc9Z2I/3587mTnjzXz8h?=
 =?us-ascii?Q?itqcSug+uxTlCqvSoaWb3DQJjGyiVQU3cSbTQo7Y26KQ36M6DoxGyyEX5vTN?=
 =?us-ascii?Q?Ouarn1rG/46Fy3c6lbcl+rZbJF53h78yyGmqQAhQUQmb6WzAp6qq2a3UY7l5?=
 =?us-ascii?Q?DCTCYSWcD3BISfusbrFs8Fjf6w+ceN/Pvw7sF7CEVbgUdq6HwfbyIh59r7Mf?=
 =?us-ascii?Q?OggHQvl9Yw9olG8a1uKwKJ6uqfGHKr5k6ItDOQwPsKHuD6YyYBnyYVyPZAVR?=
 =?us-ascii?Q?xT4sEEkEim2TPi+Q/jV6d0lnu4iRrhnT5AjUOYH/R3z8c4zuxyaJvlKGAFwF?=
 =?us-ascii?Q?pprP4VUeOO0DgNwXufmCyw3poAs8TjK8fI9WZaQcPQkbfQ6vvtzNRjW5jFDg?=
 =?us-ascii?Q?jARK4AM8N8yC3XpUCN0lqHLSVzNhlYyzIVf6qgyqEMyytbm6zO9OOLZlmFIE?=
 =?us-ascii?Q?vztSqV90CcMdA4N1BBEOcgXxjp5o+wWFt8bOQfO5cUvtnshyE9wJNyFl4Flo?=
 =?us-ascii?Q?z+4OBXqRCwaJcbfp+wDJSdVp14msqcCEsFP0NuxEK+zYpS1wJ4Bz6lL5IASN?=
 =?us-ascii?Q?YZuDES3zere5gYgR8UOo/LarB/62yMh5AB7fKyrLjh5y+kaTw9rEXdfZC71M?=
 =?us-ascii?Q?o0obwf0tpp+qZP3PaxbZnLOtx2jNfyOpBDm41RK0Nn7rOe9PI0FOQxU3SbFJ?=
 =?us-ascii?Q?kyCNmN4QN1rxukKa6sbPLg6eSx0d/Qh0tVen6dWRCEo3Jb6QasSCqH6UU4ja?=
 =?us-ascii?Q?iiwAtriu890FlD1gV/V23vdYhBRXTIMg82h2fwLIzY3WHbIOx5yf6UkTglce?=
 =?us-ascii?Q?fSkBdEyvR0PKyhSIioKM1DjO2mj+Enzyuv5s7kAPXOteD+fOYn4hMQakMq8S?=
 =?us-ascii?Q?2dny/D0OU29wMZeJJ7M0D1mjyvUpEgF66+D3pqAWYAO98fbOlmNgYhcvL3bW?=
 =?us-ascii?Q?dVmMBdgcAZDxB9QeKmfB8mhE4F/aQBNk2ZB71kKPajddooS+nI3BfSq/LejY?=
 =?us-ascii?Q?4f7Pwqd2fP/n1WNVeOSRMEv9s2aSWyMLksz7oiSSQyHnjEucZutIEUwSaJ8a?=
 =?us-ascii?Q?3/Fb29c874egJo+igzRZAbqbmJztizeWt/yHvrPuR2vwdzCVKcgxMGVGQL6E?=
 =?us-ascii?Q?B6rHqFN2vKD2tahdTthhGd8PfWHRizOBi8Ijrt5zUIqJHFU6RrjlJWGcivQt?=
 =?us-ascii?Q?jg2c6ZgHWPQqXtX4V/UZHJYu0bG/gYzi9DAuPKdQjBkKAList5jjzO7vDKB1?=
 =?us-ascii?Q?2Ow+bU4EJ9b3DVsqx1I8xWv20HcF4HfJqqHSxTDygp77j6ya0SGokDMJHkgv?=
 =?us-ascii?Q?I0HRN5c440IldEjbVLH11HuOBFCuvvWrQQW4zC7k9C+29XcCzGM7MjmF6Gel?=
 =?us-ascii?Q?OXDZmojiffR2oc8GkoJuoduq6F9PueuNd9AVq5JIQDRYRviR/HjVJ/l367zo?=
 =?us-ascii?Q?8r+NxI4FGU2Q5Fw9GtwLxe59hk2rzT7ODKwHkf1XJaJrss0MZkXr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099bb309-2298-4f92-f7c2-08def2df43ae
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:49:46.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxEClNbYUWrYcsidFLhL7I35yweAW018fSD22e4MQQd67m5jdZAZL3/YbfEswAPxFDqURQrnF4QCg5py3Yn4d/Frhn1SbwzE/gzKRALeLrGBrWOAMY3Tyd6C9BTVtRct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

From: Wei Fang <wei.fang@nxp.com>

In tap_get_user_xdp(), when processing a VLAN-tagged frame,
skb_set_network_header() is called with the depth returned by
vlan_get_protocol_and_depth() to advance network_header past the VLAN
tag to the inner protocol header. However, skb->protocol was not updated
to reflect the inner EtherType, leaving it pointing to the outer VLAN
EtherType (e.g. ETH_P_8021Q).

This mismatch has two consequences. First, skb_probe_transport_header()
is called after the VLAN adjustment with proto=ETH_P_8021Q but nhoff
already pointing past the VLAN tag to the inner header. The flow
dissector interprets the inner header bytes as a VLAN header, fails to
find a recognizable encapsulated protocol, and returns false.
Consequently, transport_header is never set and remains at its
uninitialized sentinel value (~0U), causing any subsequent
skb_transport_header() or udp_hdr() call to dereference a pointer
65535 bytes past skb->head, potentially corrupting arbitrary kernel
memory. Second, TC egress and eBPF programs that inspect skb->protocol
directly (e.g. bpf_skb_net_base_len(), bpf_skb_net_grow(),
__bpf_redirect_neigh()) will see ETH_P_8021Q instead of the inner
protocol and behave incorrectly.

Save the return value of vlan_get_protocol_and_depth(), which already
resolves the inner EtherType, and assign it to skb->protocol after
skb_set_network_header(). This keeps skb->protocol and network_header
consistent for all subsequent processing.

Fixes: 8c76e77f9069 ("tap: call skb_probe_transport_header after setting skb->dev")
Assisted-by: WChat:claude-opus-4-8
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/tap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index fae115915c8e..afcc4919bd04 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1081,9 +1081,15 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	}
 
 	/* Move network header to the right position for VLAN tagged packets */
-	if (eth_type_vlan(skb->protocol) &&
-	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
-		skb_set_network_header(skb, depth);
+	if (eth_type_vlan(skb->protocol)) {
+		__be16 proto = vlan_get_protocol_and_depth(skb, skb->protocol,
+							   &depth);
+
+		if (proto != 0) {
+			skb_set_network_header(skb, depth);
+			skb->protocol = proto;
+		}
+	}
 
 	rcu_read_lock();
 	tap = rcu_dereference(q->tap);
-- 
2.34.1

