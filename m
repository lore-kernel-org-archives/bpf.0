Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348434DCD2;
	Fri,  7 Aug 2026 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084234; cv=fail; b=L3K5JrJBmK9Jfv0+Ab29VmeMBnMO1j5n3YWXEVED2JS9nc/03dF4GmwDClxTTTlJGvR+hwyCooIJKg287UmQ02kSwZUVTMK4PMol3Za0X/SbcpWO8mEOF4LUKCBTuwub8f047rjJXd2bh60R2BrpOKlTE0t++KitzoXFhu5Srgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084234; c=relaxed/simple;
	bh=mBe/kcgcg9rn2dCk1xRZEfSjWo2Zayqsk8UDuqgNa9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LoGbP3POIVgCZ0GjJMfCwiRcYEdXF7Vx8xvZJzctznon47jjFAh3x8kLKSqn9iP39jFNVEFTjDCSLf82YpZ271LFG/+zb/MH0+bqjTQmJqbnPPa54x8olFxWBZ0Nz7hEvP+GCIJqUXruOf5OGApZ2UeRfHmCTi3cuw2TJT7ibxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m4sbKFqi; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m4sbKFqi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQ0W37/p6RygqMiXRuvTQTbIe4DEvW0WlRwLNBuuSyBssPG66KKyHJ13VRi8vChEyfseWSNZq9tXM35WfSoahQhVKY2DpsYrsdPrI0yeEHWWqHow5IuhoefCcu6aA5qLGvv+QZYAy3RlyL3QzBaxGKyk6NcATSYrK/2KFqOOP1Z7oDwlfxmBr9BLX5tIpPgXzfPQ2qfjCKGh73jLPfL65Jm27iYYMTGgFfw1Vhq/Tl99HULB9qZX2GAkcFth+mvgN3vZCiJ2OtcTcZOU9ThHnUk8B97ltokQmkaQqNSYrhbTnBlAsigPZjTRG/px8yINhwZ0viuRo8vsmxB9wUWerw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQHKGw/Dp0v2CCpXpUeugVAOeYCBq4H6Fk3HFHTnmkk=;
 b=pmPhsS5C/H1ihPLeK59nQvIYlVT/p0E0qmr5sxZWDfV5Xf0hCga0ialYNy9c8CgRID8eGiei5n9wJfN8B3F0XJB0AoYmnsqGLhjW4IDfYBO/54dECrQnLZXzNKy3H0NSoku74YX/XhXWbxcDRqZk77Vuh/s4Os03/okVroG3mnN5rxN7QNlmDeUUzG4joywr8ojuMRw1UxlcZR+fcM9iAi5y1LLckJcBS9Taad5svZgmByje3F3lPi8UYwoJfU38QOGplaBd8BnB59YK42zmGBRjoXqxaPxo2VAX48e9dhxc9Y7WonSPL5NJgHf/pVj6cFuCn3lau5busSKwVcyb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQHKGw/Dp0v2CCpXpUeugVAOeYCBq4H6Fk3HFHTnmkk=;
 b=m4sbKFqiny7ae4j5xUhOs8XS071/5G9oBumCUaAg/EYhMZX+GS89L8l1bKLm8W7HI0SCuW8lz3F9bEMIaMyTpG4b/1hdgFuqqxh3Tqupnl+2UO89iS7UL2KBj/9DZlG5wkzh5LElgXjRDFl9ZxPGZeMm6d4glqEMkJN5ozToNQsDV2aMeiO0uYGoEP40R4wnXdH3oF5IiFB4BhcLO6AiSrcdSPQmDEjJ+a9sxuKVuG14QvKWQNhlub/T+JJB3YwSGg5KPK1oi8tLobqyJXrUxR4I5dpt/A95sR2aqieX72gZ9HHlxGMocOdlHNxzQ0ZWBMWuxD/21Kq0HrbIYuxm2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 06:30:30 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 06:30:30 +0000
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
Subject: [PATCH v2 net 2/2] net: tap: fix wrong transport_header when sending VLAN-tagged frame
Date: Fri,  7 Aug 2026 14:34:05 +0800
Message-Id: <20260807063405.688780-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807063405.688780-1-wei.fang@oss.nxp.com>
References: <20260807063405.688780-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|AM0PR04MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 366590fe-761b-4771-16e3-08def44d6084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|11063799006|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	T88CCFNqnYQ+0WAJQGSt0dOUXTDZU0gzdrxIJ7UAHUu4yGWNdrBawhge/fqqfKfNC/bbmL03P8O+dDwUPHo/kRODIo4hZV3EXzDQdHdUJwqMk9uZExP5BpwKm6f9vgcpzt/AW8GlnVaT0RZKqo7W3h+U9qJyV8kLnH69qMkMPE0EixeKXC+7UsW03xd9qPcbqTWDue1ctGkycoUcOjdmz61IcqHanW5DJ2qTHwdRllp3AH3zuLoTI7avbYckjSw+u5LWQHap8scgpWaSdPFtXLSZogztzjhfnEtHUF0MH04TZhvu3ZoD/J5tyIzFKR0gcjMcSVyzlrhoPg3wfsMvUHaXuZ1F1fjWploBxhuEtW3I/qkUEpng6NnJuA1jFEOF4BNdqbNSw2jKhJopyZ1fGIBrCXjc/jdM80u/z4aic1yjq7SmwHM2MwaVdg07pDrXMaon6PTnbNdTpzEvzpGFXmekH083NJpUg4IqSidRTxU0jaJSlJXeJO7FN179FURmAi8QBIY5ofuMmdKg6j2T0isET80m/dEqpuzpQVNMf79RUAEDADheUbRW4qZLvnXeRVJ+/kRgO7iSZ+qmZMWiHylrRFaLYYKFPQ2P0kJnszuJHtjYhxp2ViAL3oWyV7AIE4Z6IY6EL5BDuBMsJSt2HIOy0FBERh79GTjFs3n/K+80GrOOvqzPCbJc7N38NSz67lzIkg2VOohr9W3ForUnBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?10t8x3fKJOX0xhHazOANhmEQFk+ashOnsZFfa/7E23BOwASe2WNsG99AhXsU?=
 =?us-ascii?Q?yWxrwbqekNRVdOHHkEYY3pqb6abmpx2/hJaiY6tQItwnQYjXLZZR/XUKrg1Y?=
 =?us-ascii?Q?yHw3R90MJTpTY0ELW4ncT6srBI/nNLfGiso0OlFeafhLO1M1bGfZ2nF9EpBE?=
 =?us-ascii?Q?3gi0Ej4MU88YwnnqwR0Q0ZZURf1YR6FIOgPEfPw5w5H8ytkEYFnO1MFXKGS9?=
 =?us-ascii?Q?sCrT54r+tF0NAlGHZ3L6N545WgxdxVJlsdQvHQhamljG0nAtSIJzKLVxX4lo?=
 =?us-ascii?Q?xr5QWcJCW118QBbsJbwhqKvtxp2sT3MLsLHvxnnmkvTkUikfPQqM/8pkstXa?=
 =?us-ascii?Q?jKxO6f0Z1QUloNT9R7N8AP9pbgJ4tUauJJYR9xfx/0JcPERLqdZRIQatNX4k?=
 =?us-ascii?Q?DsITC3RS02YZ73Q/cR8ab9daigcDstIgl/Vs8qi4HeYSj6/qEB3HGhneE8wg?=
 =?us-ascii?Q?aKSkJptBp+iPQOd1DD30n/mDSA9ABS90K5VxrMIoHjy5CxzL5hLDci6SquQs?=
 =?us-ascii?Q?ZsdGyhtjBwb9SbF8yEYHsvq7UrrS/FoVn005SErr+Qw56aDkMhA2mrkTQkGW?=
 =?us-ascii?Q?t+EJOF3bogehb4DKM8ekUwR3/z3rukkMioKBmiQFNUUvK4rrzvqSK18Oug3w?=
 =?us-ascii?Q?eq3uhPTHYVRUu3bo36vbrx1vhfDCdxxF+nud82E8duvKO4KZ22a9FWcyeU2q?=
 =?us-ascii?Q?ChoUyRWeFikjKp9BDJNnUWB5uwKlBr71Wpu6NqvzZk1xfUHV2RSvUn5XbRJh?=
 =?us-ascii?Q?TwxQunLdg/JG8o+VazHnERj+rEdk7nDFcjNNF9YC1XN2/lYUELAmiqQJAk6+?=
 =?us-ascii?Q?o3z8OJL4aYjW8sYZq/xND/hARlXwfkXTgdMEkdtUusrQZdCMXsGV/UyX7dZ5?=
 =?us-ascii?Q?jubhUjif/Zc3K8dt7rTo99eF35d1zwOqQ7FtWW0Aka731Rl5clflFMLV3HYT?=
 =?us-ascii?Q?6n6SQwjOsS9KSQh8LI/bGfC8SccWnOu6A4YoeSl9vcguZxlNCIGZoQxzh2Cg?=
 =?us-ascii?Q?WCRTf4FVLrrj4elnX9UnOs4njvUMzr1lJld5bAUovxbPDUN7G0o8Sy55mX8K?=
 =?us-ascii?Q?XJLGZ8Aju6sLeFDfnicVj60sYtxuaazj4sZiyS9Emfp0J42PsC5E+LFrkgHT?=
 =?us-ascii?Q?TEmf5XtlgNrftS4t8Q4usSgbvJ8QOhVXrmYS5PhbilGrjvJjQRYDtfw83SLv?=
 =?us-ascii?Q?cVqVoqBfvZdD5Uh4e4gJkwaMkI+o+dtnhxonS9QrzrQploNdT0NF5M5ronp8?=
 =?us-ascii?Q?Pu7DK+wWW0CqX7+ls2l/9FDJnjpDwEz0Hc9r3l6xSDCOonMSzfeW5aujQj9/?=
 =?us-ascii?Q?WdPc6PH3cpwUdeX9hOGFNjfQdyQZWV9Jgg1A0jVDZ1ODfh2bjFTJAcugRMiT?=
 =?us-ascii?Q?nu+CbuO9qDg2ARk2q+cp9cofOsdffxxDjOxo8RNGCNQuQ/6HlRJ7/BPQJ2qf?=
 =?us-ascii?Q?1yg190dswSbzqICRYFcNUMB5rjDortAVuMlg7UL7O1sF4K1doRmZ19shMSTi?=
 =?us-ascii?Q?8+sEIHFCGJQ+XttgMmwZ/h0Yq/iaHmqAKlUniN1UKJrwVhDnU1OBFZK/vDGu?=
 =?us-ascii?Q?Pdk7ni1PdRPN7ddsZ5PpaHPMNyCSl3aY8v3nqWwqKtbx9mwPSpRGGwBqw4sg?=
 =?us-ascii?Q?63I1l6DQ/BvzCZN92Es2ovO9FmDQyrWzDKcKJL7WVA0BDlEKKKtU1z3DbrmI?=
 =?us-ascii?Q?FMCoAkd2gohLGRAd3ac2jdD7r1R+xo97c3ZZ18LMNjwxbF0ks54yYXCAgSkR?=
 =?us-ascii?Q?H31fxrBpPrZeVlfTb953w0yLqumd2Py5Cm1x7KClGIwAvuZXd7io?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366590fe-761b-4771-16e3-08def44d6084
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:30:30.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W78ofsxaNyz10qsVYMxSW/pSASEIzQf0+Z7lDauCy70RjP27Zw7CJE/54ULjX9/xYB0ON34SLvMvYFSBIv8cVKezuGo2SuEyOljtpMPFt+gg6HHyxXYumUHaTpiLK6r9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6817

From: Wei Fang <wei.fang@nxp.com>

In tap_get_user_xdp(), when processing a VLAN-tagged frame (e.g.
ETH_P_8021Q), skb_set_network_header() is called first to advance
network_header past the VLAN tag to the inner protocol header.
skb_probe_transport_header() is then called with skb->protocol still
set to ETH_P_8021Q, while nhoff (derived from skb_network_offset())
already points past the VLAN tag to the inner protocol header.

In __skb_flow_dissect(), proto is initialized to ETH_P_8021Q and nhoff
points past the VLAN tag. When the dissector hits case ETH_P_8021Q, it
reads a struct vlan_hdr at the current nhoff via __skb_header_pointer(),
but that offset contains the inner protocol header (e.g. an IP header).
The bytes are misinterpreted as a VLAN header, yielding a garbage
encapsulated EtherType that matches no known protocol. The dissector
returns false, so skb_probe_transport_header() never calls
skb_set_transport_header(), leaving transport_header at its uninitialized
sentinel value (~0U).

Move skb_set_network_header() to after skb_probe_transport_header(). At
the time skb_probe_transport_header() is called, network_header still
points to the VLAN header (offset ETH_HLEN), so nhoff is correct and the
flow dissector can parse the VLAN header, extract the inner EtherType,
and advance nhoff to the inner protocol header, allowing transport_header
to be set correctly.

Fixes: 8c76e77f9069 ("tap: call skb_probe_transport_header after setting skb->dev")
Assisted-by: WChat:claude-opus-4-8
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5d2d34d24ce8..9b5af08cdd47 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1091,12 +1091,13 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 		}
 	}
 
+	skb_probe_transport_header(skb);
+
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
-	skb_probe_transport_header(skb);
 	dev_queue_xmit(skb);
 	rcu_read_unlock();
 
-- 
2.34.1

