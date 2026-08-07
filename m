Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D27448BB6;
	Fri,  7 Aug 2026 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084224; cv=fail; b=hUtheCdffmt4xBslazgyAQM4Lfgo9cZ2Eps+aPPls9ovkbm3B7g817AWy33+RzwSskQvRGwvHd3CucsS8sm66FHHsHz8teKedZIu06cEqTVMMX6A/HxFQY49ZWKBoFx1yw9OBfHDi8D7QdNk+RBmzb3uZCl5+m175LmHbsy7324=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084224; c=relaxed/simple;
	bh=uPvSwpqei9ZkPRcBBuWoAPop4Ja8oEz1zmIzD0CsdMc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nXTEbG8apIkradpMiGgU6uK4Wos9tgYiej0l2aDNNqAnQ90Cwzen8H8vvpj4aL54rgDblHgGQnMlc7SElZ6XGbogXUCgwLECAGsH+WE9n/eSrDMcc6Ui8UVecPD83YRsbbxAVpH6QnWcAH2/qaH+wOEBt7MzRDKR35StKIvAB4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vmthuATK; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vmthuATK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvBwAfrOap9tkvrf4zN7/4DTVtBYsEnA5Jna2Ud1wjlD+mqxCG0W+b71Aa3lT2A3hbeNjx87Y8pcq7YFmpQDpFWOPE4JquHpkoSh7hFNn7wqDPlgBk5BuM8tB/+khZ8WMzTPH5zaHuc8cMor61cnRBvi2SLYjUlCqRQBSxSo3OxZPbSrTltf1waP0AcDhVPisxNT23X3XWMvA61c/AzfTbONV/dxtxdYMR3oD5/yZl9iibJhhcKIDjrSrU5ETSOoD+TSo8bOyRYEiwiHQ2B2rFbZja/vj75zIhrGOagBzJ85nHE3FSO8iEPUct5cL8Byf5KLiXLlz8V4S/3GU/w5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3L4JV+nDwEyhkcY2porMtYptVGfz8d7cLrUEKPIjXo=;
 b=hdO+moP1TpQ9va4JTIKohBsaUGl1av6fJGz+sRN4J28BpKQ0Q/68T/4U3chtAa9FYntQARSGZIAhmvrhCfV6SQa052+lpxmDo3i1wYiAj8FvNpCddwpIQLRFCsSOsUThDHK4s4y1IwIwlS4R9mBB4wHuXJuk5cVZa/kwRAzw3z7R1AGm3sUrC1DEGAjvMLUJmQh/fclOxvmKXFBnichqNQXR2BFgU/2V/32FZRg/nInp1dH9Q41/ut6SwhD20mT1JhO4i5JXsEyPYmvLjZCr7QFCYlqZ3iHbMnAadaZBXo1MyNQTxjUblpnza1V+eJCT9fwycEK61C5dTBk7EoeTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3L4JV+nDwEyhkcY2porMtYptVGfz8d7cLrUEKPIjXo=;
 b=vmthuATK1xgMlgsuiO8GppXL3r47Z2zmaIyg9AmWPHRlVnfCr6mJrsqZPMPca6chz5qfXxuZp9KYWDJpyyMvOi2rPH+K4J2c1C06N2q6W6sG5ic1nnV9VhikeOr9spBFnsxpFK9BAJRTS/54A4xFvP5n9ys9i6pJauFIxgJJQb4tuGMRPdjS9AzeXwFz6z46eGyemxzUgooBttntkwSzT3INFc7Iefh2g3AcRgP+diECdbN1ZNY04KwypBSzcNp3Pz1i09M9n9x203mIb6zWJOm91d+bStYyYfoSSsHN9RQc0Lrfii1bX/gZESokr5VDfHld+M/MWrqm80rmle0i0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by AM8PR04MB7954.eurprd04.prod.outlook.com (2603:10a6:20b:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.22; Fri, 7 Aug
 2026 06:30:18 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 06:30:18 +0000
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
Subject: [PATCH v2 net 0/2] Fix wrong transport_header when sending VLAN-tagged frames
Date: Fri,  7 Aug 2026 14:34:03 +0800
Message-Id: <20260807063405.688780-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:4:297::8) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|AM8PR04MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 003ecc18-20b9-4425-30aa-08def44d58e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|7416014|11063799006|56012099006|10067099003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	OD2wIqj9T/FadANsnqt38g1QZO3qBHXfXSMDfrU1YPMilcu4vDP7+11tu/RZtHKCDf9ETT/mhgdzv9nMWq4Gg9Wi608XLeRemQCRqlebfLmEy9rl2LASOi57f0QueBUckWNSaOQskaGpX/ICNK7fbV0O6F6lWN0JbMqVGN5J664VjudH9isBQvLjUnaLUecJyE4Uk/1Rm1exEGNMSozb+1U9odr9fA4ppVzzLlzhtz1sG23OBOXQcyLFLuoNGu/S/kFFm0oJwy2uy34V7gWBLcp/cL2zoBZ02wBVKJ1IGNQTBGbIzZ7YD3UGGfhYF4dylXrCvgNDNv2ImoQnsC1kmHDH7HTKXq4Oz90YcwuO/OckOz5qZuuHgpqTzOlx14Qr+ZK1z3QCFhqHOmm7eBXOOrJ7c9PJqwLJ2EZ605Nwn4WOejVL+utqD94duiABMYpTX2hBTVBuxD5I8WI4rJV4awsRwyfXkQYeX7rtnQ3ltxVc9AIFf5a6mriDmJ8ukjRCQJdvIfVFLXC2WHOJlxBopUOOCJC1JcHSki3PryhXIDIfqH9+gQOGzqTgA9v8aIICD75pcKhMoglwFCOWrJwls6JiIgkqnjoOK+j1FHNEmOXx2g3l3TTuuuprw7eD2o6QbsshRZZFxHb/YyHXzEShynAU37LwGYvKOq2GH0BFxE6uKYdV5mwWasaAe4ClIhrboUy2Wjf5BM7L3LZsUu0BNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A4pZczPH/rIYO+TDCaccdxRHv6cVH9iH91nKfdrkO2ixo/ApLn5IISuAH5wl?=
 =?us-ascii?Q?Z37a3JMLnF1pFif7HWi53dFzRb0UpQZIKA+lC9fVhqGZCaNu6EXILopQDish?=
 =?us-ascii?Q?lRZ61JJyQ37DlFYVG2nU9krn9gxMt9XqNOXr6TZevADJ9IHK0agwRoa2ENCV?=
 =?us-ascii?Q?6FidQHghbHIou4k3Ug5MohASJNOKqMfSHk3Cfk70v2NIk8QmuJIOpvfYYRrk?=
 =?us-ascii?Q?JvRFLlmhYd0GlpJJQg/QxOVvJdoHAAooXD1LZQtpykLR+4L7JcQstUsoIw3z?=
 =?us-ascii?Q?Gxsq9r3VkRvEa+oPnPSTZQxIyG2zKSd93qIYejOI2BvUPITUPEpGOt/ea7JO?=
 =?us-ascii?Q?LQeWZwk4fFTK52CPVOR65w7ZKw2sKmDr01O3eqfNaA3+h5OhHQ3dRfxo8xih?=
 =?us-ascii?Q?0brRam14IsRz59kqDdu0FyFxhzstg+5ro64rk7fPHiNZcaC23IbG3MsGSSsa?=
 =?us-ascii?Q?m37EkAy9pLhlIoba9Qvp3pPxsYBBoE8A9jnL9LNIALIBpzQ7K/bZEv/ZOAg4?=
 =?us-ascii?Q?WIue1cIxlj8XY930oDL4RWVpvb2LiUTw+ZuubEclb0kPAD9dXESHAhCX0hGz?=
 =?us-ascii?Q?F7FQsL7k981H1V7AtiGJ6JvOYhLzku/T1HfLxwtEFtTPqxAnouM0R0li7+nb?=
 =?us-ascii?Q?Chd9KmbKuS3ToACS6gc98szwac/yooFkimWMH40zrMQMEQA2b1PNH+0oN8ZA?=
 =?us-ascii?Q?cr18mHNTzuN5rAdd039Us1V3ktGCt6zSM/lQccoJTeYeOrBRxWhQWRn+bl5m?=
 =?us-ascii?Q?If1B2zImOoLkVS2CBukRb/1fvYvCmsROlrbqd2TFwULC4zKWv1nkGt+GmEL5?=
 =?us-ascii?Q?1Z6jBDtz1ZQx4g1LQUb74bQQkGHIPUpcHgXW46GyDKt9XhEEi169jhyfze2X?=
 =?us-ascii?Q?qkBWELAQuNgIwMoV2a1m0GSWzCCWmRIW25ZnyjSVCaltsH8eWJlQpkCGb8Jo?=
 =?us-ascii?Q?KY98UCKgmcO248CJKyqiHbLXFtjrrh0axlNG6JJqZWG+4sogwdklvBS0g4NN?=
 =?us-ascii?Q?R7dy3TBqKyoPn0I7U3zZO0uP4Vm7JOiLraVgAda3n9F7nl3VrRmVUN9joZj1?=
 =?us-ascii?Q?9cfEs3obGs+cr071Zij0kRt37EuOZYARF5o9QEjWSL5qzNVHAo9m3n8PCSjZ?=
 =?us-ascii?Q?WsN/6/sOuWQcbXIVZFWjI7EYh51fqWI67TYaSgicJYl3HXlfgppLeVjVJCGS?=
 =?us-ascii?Q?ZbCQDRPq+L9pj8d6gQtmAm6q1NbjYYlWjSOn9OqdooSrhTR2BkLhUxnF/QFb?=
 =?us-ascii?Q?h4UhcoX1fKqhuP5Km4ryvokyh4ZfiWr7I8lUGgEiSVP56pUR2M8qftjyPsxB?=
 =?us-ascii?Q?slf2MrbAaGboY3ZZ3b7jB2mC/bAOwmPPWUx8TVNlVx9AvIE+5KEYWqWvlVFW?=
 =?us-ascii?Q?nBz1ib4S9OC3h28yAk5wEfJZfieIzNnasMO5f5fSa3Ccy4n5icwEkmq3+jz5?=
 =?us-ascii?Q?CJ0hGHFCKgL7XeOqZMD6C44dZEk0xkNM9el268DqhYPf4qG8NBJ3Qin6YohG?=
 =?us-ascii?Q?Ps1dS2+31K4y0aLmKO8mbebwPoEp1/o8NV48Z/bb+JQAVFfLaYWmXJlIcMDi?=
 =?us-ascii?Q?qCZsRsu/YHDei+65r61A9WYZjYiMV+jD7UUcep1RXc69SS0F9BIwipLBx7J7?=
 =?us-ascii?Q?RZqFrx2/f8t6tRCaAVYthKKlPA3iz92pYy7hTvPydYQbxdq8RQj32qv+CQ2C?=
 =?us-ascii?Q?0TXBu6L/Xm+umaCdwORWR7WSQPC7CZjWrdmlU34A2MBDvsGvE5A1N7u2OMTh?=
 =?us-ascii?Q?Lni9t8h2XopF/PZFdTlC7hIMrVc7b43ImqA1VOm43PVHjahohlEM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003ecc18-20b9-4425-30aa-08def44d58e7
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:30:18.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OBsFFc3K/3ZjGGSgoG85BfsMtSFYjiKM5TjWjSUtKcmFkRweBKN52Wi4x9tSy9uhdesBdIP9q4GHrn+2W4fpHNGmzV4CW8LhDSFXECOJ/CnnyxwLQwI0PAZyRMPs7JV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7954

From: Wei Fang <wei.fang@nxp.com>

When sending a VLAN-tagged frame via AF_PACKET or tap, calling
skb_set_network_header() before skb_probe_transport_header() causes
the flow dissector to misinterpret the inner protocol header as a
VLAN header. As a result, transport_header is never set and remains
at its uninitialized sentinel value (~0U).

Move skb_probe_transport_header() to before skb_set_network_header()
so the flow dissector sees network_header still pointing to the VLAN
header and can correctly identify the transport layer.

---
v2 changes:
1. Move skb_probe_transport_header() to before skb_set_network_header()
2. Change the commit messages and titles
v1 link: https://lore.kernel.org/imx/20260805105314.3882595-1-wei.fang@oss.nxp.com/
---

Wei Fang (2):
  net: packet: fix wrong transport_header when sending VLAN-tagged frame
  net: tap: fix wrong transport_header when sending VLAN-tagged frame

 drivers/net/tap.c      | 3 ++-
 net/packet/af_packet.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1

