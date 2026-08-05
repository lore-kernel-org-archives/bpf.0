Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437543DD849;
	Wed,  5 Aug 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926985; cv=fail; b=KYh+GbJEaY2jAyFraAEN8jvFNAP83HB2J9RRxVfx+Bm4iuQuCUvg5b8Kzedg2L4WQqoX5JClxbhSJIt3Z7Snn/t6k7MIScirl165INIQXVqJeSNq0XTpLq3SvnpNKNsGlVaCOIc9LSLHRq4Hn2t1L80XoxB9R4VzYtUGqJxCNww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926985; c=relaxed/simple;
	bh=SqkwZra/xWDM94IGtLZGUGdTQNge2j5NjVrldIQjePI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bp9JoFUGLqT5hzvZjvvY/CahtfpyAGx6xn8A6Azv/A7VqyXJAZwOrdgPCHSdpCgf2JQQ1rZAxREeScEeh+gmVjC1gw0LMmVEEs64CqsVyR3pFBRDyTv8lb95SckZGrZ+1BQDYviOljff+QRNkR1wRYuO3KvPaMHCfFnkcJco+2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fjg19woQ; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fjg19woQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPOeAOOgEeZBYULYdwybRDF4sCe06naGi/vhrqT0X/W5gXd29cMrbRuuPPDWLsjDIWcNTVhemQnzJ/+krTrBBtNm6IxJI9K5y+ElETIdhDSqf2DEQ2qe3p+oe4s8UhYU0vq3x9cHhRGYEKXnYZQ72wIGtu/I3kIe6uqhK8rPNJjUzZsH00OFnGEina7QbENv58nF7Pb1yXX4uBK4plkjvvt+IkckMFAwfwKR38AihwzCy4cUzMLt5w7jBBGOdWJKarXMpFcy3YBuQq1S85JiurGh7pVxUZDtJvNuKk9PV5rqykKhnKS+QpHtvLgv42UN/uy/jFhi13idnZxPaRCfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDvstL+3eDJepcRNuWyeIT7c8p43ikcSkWpz4MDVqJ8=;
 b=JVkqyGnsGf2ToKlktLiPDGIZAwPyayd6twg9gh0vf4AgioAEZBnsutEAk4obMiZZ+RdLgHS7v/ETMaPN4POiNyV8gX0KEyL4Ak3mlK9QfSBZdfZO4ZVvBk0mB+M6dbLqDHfMSY8eE7X0Scb5KHwXvPw7LV7HoydYK1US/X/jZ8tGynl7kepWXtmdnsaIYzTWLoTgnRzkI37lYdZZ+dsT7JVGz1F5+fTC10ZFQw4shlyXkf+AAgD7Dd8QqQ54eZrH5m1kUKbGdmSxODimmE5tEhtPKWqyCZKN0F+Ho3oZZVmsjQjB8di49zh3uUbn7k0iifgtFit4gjgql7jeKjEWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDvstL+3eDJepcRNuWyeIT7c8p43ikcSkWpz4MDVqJ8=;
 b=fjg19woQTFO+6rxSDX3ElmgmgXaV2haPBBhF6FUoaYJJmJSXU2qFq642oD/968rNEzW4XdIrwAnrjgmKqwuzcvpYb5LXNZjmdAo8I2hIAOhzP+WxSZ/dletAeOWfgEt9YWp6bgYzf3GTYN43pLS/wP/XnBZ4883dbW1Y8Qb/p5j/sBcJzD5RD0mkjjLHGyCSuBsh7osZC5hP1yLZOZLs65QxEMxMTjynBJKQ3+YQysIoqUcgn2fwD5nGoJsiJJyUy86DJ2Q1TaYz+NEh2NU7CNJ23LFVMfHnFmzRg7UFTbL4xqqrPSGVT4iHAoYIv1odOFnQ7ouzGbckMW+VSXxA/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 10:49:39 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 10:49:39 +0000
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
Subject: [PATCH net 1/2] net: packet: fix skb->protocol not updated after VLAN network header adjustment
Date: Wed,  5 Aug 2026 18:53:13 +0800
Message-Id: <20260805105314.3882595-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 218f3d54-5175-48a0-396f-08def2df3fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|3023799007|6133799003|5023799004|10067099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	ZI4uSlLDb5UOdQA7XQhB4Q78Xus8OHxgrRfHOQU5vFsy55X+YyEZ4yUXYsCCpVCjy6qq66eE1GyEilqpIr/Y/qS1A9TqaVuw0sn6NZTPSs42kK2+EERXRD3dChKkm68nFPeAh46sCHLdnvISyQnsIfIgNX4BvkaqLc4dBOtIlTDoQGCNjAV/XqbvHeN4V5hyY72Zd4+BSvHZmGDNvTBZVfi0pJjbH3ayCPbYTOoK3FZBS7bFuxAPIU3VM9IWdqUc31KwMBftBHuNiU2mWfPYKrCGgv8yrdhog6yuTufQs68vJlDSS2B7D4zm9xr5x9+qIPnvPOUdmSdZMeEbUG+1fu3w7I2nNibgq95EXPbeiq6+303Dv//1k6KFkJ0f0/18aAt4fFnZE3WoMK9b9ohO3bYNBD8w7Ehj6NQpWcNmFnmhzOz50/9fTsGAGkd69fXup0Fsfjb0X4fT+UCty/oQ8yH4XB3NF3aQRXyfsZr3evPXjlohbC70egbfmgF7jh9ZkisGO62VLLlFJb1t0CLQjs6Siplf6v2L39i6FagS6Y8bIPrDAwMUxUfpbQu76t+QmuUaFdhwwW4ghto8DOAHvOwg1eE4ysRRLAaUplg/JcLZhvYjC6JJq61tVUMqLl0t2HXftEQwjbuLnNk/SY7+IeFE3HAY1Ci550xQFLlZmDGqgoWZZkA06h0CA2ikoFpVYK0OKAcXaQOrtg++6VCFPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(5023799004)(10067099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zoQnnj1m3FXggfLpj4q4yuXZ0F1OFmK83VwEqIxuK+QPrN126gMP5uOw/rq2?=
 =?us-ascii?Q?km3+lClE0Xphug1ntApK0cLb8lkKxhrGu9rp0a/4bPyzRbnSAElbdwEwXduN?=
 =?us-ascii?Q?KURqyI+JarMH7xsPkLvwyPa4PJGAAkOeKd0NJAvDSVMFa+4BMMySzzJoKR+e?=
 =?us-ascii?Q?5N/LHVzdR6VsRR6rEldpmqaDwI1TXK/CWFvXdu8Jo7Djy3Dr0B68vc7ZSbEn?=
 =?us-ascii?Q?14FQrLDpDfmOvbIT1KT+Phl9CUijrn/cmZuX+nl0wujDx9yCX3t667DpCYDP?=
 =?us-ascii?Q?oC8ptgJF43LccyyQU8kXjIJdbSgCczTcewmrDCJtj6KN2TpEgqFJkZKRzPDS?=
 =?us-ascii?Q?nUguMYUXcWxxlw495bLgvHZAcb2tupXexNRLZn9DbZzUPKZbQ4heuh86GJFW?=
 =?us-ascii?Q?/sRrdsi3vQ+x73l8rzrBnTC83HUEQQ2oyp7GTs91pMPZNTca1OFfJv/pBr7J?=
 =?us-ascii?Q?gfzkpUgM3iI2Zg10EQJ0xihUCwaU7i7s4E3C9oFrwOQqd7lMOuGACDzwWJ6s?=
 =?us-ascii?Q?nJg6Vm6E6r+COejGdsfnvMriBrLqoIclWpwzyXSsbO4LiKKOgB7C/NGY11h9?=
 =?us-ascii?Q?2J1MaB9+ORyVBWSpHhrMErVtZgTTQt/Q2UwxRWBtSS73HTVwOTI1tUwOnkfY?=
 =?us-ascii?Q?0mTEPoXftR6JjV3X6GV/4LPLrACEaGcDxagdP4w0K4my+mslHisSQC4Agea+?=
 =?us-ascii?Q?kJte0ov83Oowk0ctW6XpYC3I/zOvwLFqf0txNUu3yfOuI5IQwiCFZyK/tIRv?=
 =?us-ascii?Q?tfqM60dBWAGzIsyfLv7KZWcm+sWi29l4CUll7JA6FPySjBDoqLu+JsfenRkl?=
 =?us-ascii?Q?3Tjcn+5dyFKy4mPHEfQfB+CcNUjSVDhWbDzF7uPDzUHOeICJpd28GZ0tE0FY?=
 =?us-ascii?Q?0Ugu78+7c9aJvPxxmr0988Kgba7IQ9OkMAyUmnFhUVaemcr5Vn39MtN6J/05?=
 =?us-ascii?Q?GgacgiwJE7lltNCAIfcZyhLPgIS0z4uwxF4Yyt59p/gLP8c635alV3hFfPNO?=
 =?us-ascii?Q?yHgxNk5LScg4keqSIC49PAjhoQzaQeR5C1ysir9AK3bBGH3sedYJKU9mcE00?=
 =?us-ascii?Q?h71bsgW5SKi2dYpvIiAhlyN/TLc227r2VrDlYMIwKZUHUr/mciQ5wFQpEH0N?=
 =?us-ascii?Q?UWduSs/fvC9eUExQxlK2igoFAsTE/SR3QRdC5YeOrR6Fzmn6gaQP8N0jfu3C?=
 =?us-ascii?Q?RfyEqXUBUJUwyMuuxBNHna5hfZMtJ35FFlinbVRwC222njLYquSBYbHvxZXL?=
 =?us-ascii?Q?Zza84+xGjoaT8tNBXb0cJYkQ5D4gPSzx0eBfbPuM1ZfPDe4sho8I7g0lRPw2?=
 =?us-ascii?Q?fmRhvBPmzp5JFTNPM2RHFD+1uLf3o06z7+P/Et5aucdjIbstSx5Yicq2cwJQ?=
 =?us-ascii?Q?xAo0AOlWt8Xf5HFj0E03mPo9yPgiYncmfOZHAc2o54JUPrVY58YOKUaSpOEx?=
 =?us-ascii?Q?z1odbvpdj75AY3QSo1DXwHXRXc8QfupSnuUAL4AFMA6NZV+OtPfzQYK8uaaf?=
 =?us-ascii?Q?LcNQqI4Hh0/PjhIFQSWjD2Jw2ChnWQGtlZc7Jjn4NcQzV54kl2btafWklwMo?=
 =?us-ascii?Q?/cGvxsICk5OZ5QImCsxuNAamlYYW4THaxBIfeGWXrVhMBLjLTW5CD0uD6n33?=
 =?us-ascii?Q?fCRlvW1ZW0tULt84g323/rkPywsp2aSAdkqe9Xo3hAbZpHyB+iKFCrK4AgF4?=
 =?us-ascii?Q?yKk3znezOdmCwywEq1Ym33y0H321bvv7OWMwu6p0I4ZRTIE41kjlCbImODRM?=
 =?us-ascii?Q?ZSOr4AVgMzXmHwjP7o55veKlQjfs34pj2q2rgnLI0d4vheb56Yr3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218f3d54-5175-48a0-396f-08def2df3fc0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:49:39.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 794Ez3PIDXBzGqJjsvlQNMvklO3f+Mo/Ba81PodJkQKm0NFyGyfXWbSvxS1+yqu6ls4RIzlqJzoYRXo8B/tDv25zctHxRn76dkEswkf16rZNx6kqlZEnHq+3fUUE3YrF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

From: Wei Fang <wei.fang@nxp.com>

In packet_parse_headers(), when processing a VLAN-tagged frame on a
SOCK_RAW AF_PACKET socket, skb_set_network_header() is called with the
depth returned by vlan_get_protocol_and_depth() to advance network_header
past the VLAN tag to the inner protocol header. However, skb->protocol
was not updated to reflect the inner EtherType resolved by
vlan_get_protocol_and_depth(), leaving it pointing to the outer VLAN
EtherType (e.g. ETH_P_8021Q).

This mismatch causes skb_probe_transport_header() to invoke the flow
dissector with proto=ETH_P_8021Q but nhoff already pointing past the
VLAN tag to the inner header. The dissector interprets the inner header
bytes as a VLAN header, fails to find a recognizable encapsulated
protocol, and returns false. Consequently, transport_header is never
set and remains at its uninitialized sentinel value (~0U = 0xFFFF).

Any subsequent code that calls skb_transport_header() or udp_hdr() on
such an skb will dereference a pointer 65535 bytes past skb->head,
potentially corrupting arbitrary kernel memory.

Save the return value of vlan_get_protocol_and_depth(), which already
resolves the inner EtherType, and assign it to skb->protocol after
skb_set_network_header(). This keeps skb->protocol and network_header
consistent when skb_probe_transport_header() is called, allowing the
flow dissector to correctly identify the transport layer header.

Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
Assisted-by: WChat:claude-opus-4-8
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 net/packet/af_packet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0e1355be89f6..a62d445047c0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1945,9 +1945,15 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
-	    eth_type_vlan(skb->protocol) &&
-	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
-		skb_set_network_header(skb, depth);
+	    eth_type_vlan(skb->protocol)) {
+		__be16 proto = vlan_get_protocol_and_depth(skb, skb->protocol,
+							   &depth);
+
+		if (proto != 0) {
+			skb_set_network_header(skb, depth);
+			skb->protocol = proto;
+		}
+	}
 
 	skb_probe_transport_header(skb);
 }
-- 
2.34.1

