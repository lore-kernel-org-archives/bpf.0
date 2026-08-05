Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FF395240;
	Wed,  5 Aug 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926979; cv=fail; b=iCGCKBqth5Zu3UGRq9vxfnIN/nuN2bSHMy0qnH5viSg42uS/Hh66rZ86oje1+edcDEtvgrpsmai5G2VWGl0wz0rNUTqGrunsp3jhArrRDHHzwIC0X3Y+uK+6A0FQ0slae4N/92ylgwB4UAn2ljO5eaUKHIX2gm6rPkb8k5C0e9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926979; c=relaxed/simple;
	bh=5ZSh9Z6YO25knW5joyid5mRHw1QQceXl6LeC1hmSLAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X617Rz/zpIrOxTqwS23loXZpW+w6+Ue3A0OuvweHeSUqBf0509zCZ3Q+VHY7IiVVpULyzxbHlT38Y/b19fQf562ZdZ0cE6e9n0utx2xX46zbgZt8oJ5hTnKCxV+kMmbCp0iQceC5Hn63WG+m0xQDgZCHCCxPBclf3YA488AfZo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mAGllS04; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mAGllS04"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shmKX3WtTVi9SCzTxU2kie784VQDNQFSnfvJCZPJoFX2buPEiv3uqqdvc5hnjtMxdgutLqLFUtxj1Jv+oOx3YDQmAvrp1/0abM7HQr2BqW6Y66BMtbrZS1n9dhBGrVnly0/SVaKFEkRQ/9j30MwMm5CmZ1QGHazOaIIcguEEdNHkvgv/hmbCb+6obzAvHGfB0gzFcIM8eLVWtfWRTvbKJUvv/0cEu0ged8kPxGaxGIz7Z1oD6x+od4RBsDpHOqAhYWd6xGIqkx8Qn2tmbBBZOyBPI7htmfVMu1Fm3NvPRDQfN3knSdVA9rnh2WDuvyrnZmrOV/aOqxHGTWlQsgLfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnsf91SBByUVad//uiwQ75j/g9f3RrCPI0GGoOJjUoU=;
 b=HvUBEygOJvNFxRpQQXYgyaQ98liRmVzni43ycyuhjaupEPZAQwCQVR5dx4fxJQfTGPaQApyzIl1aMXFNxKg8cVlLxkCXR7NEPxvq6NYKL076gGSSW/xj5jd5G5sBrcL3xwSq9dnHG2fkjWSIJOEM4gV7laQ9GugT3qfEbnMdcZugtU4m6E7JLlKrozNY8WT+j+o7UbJV48doxO77oLJSGNNi2H6GRwZQCg6q26dmc6rprWdYT99yvnDLC8HcGe4aesv1f6j1t7CO4V1mZ+NtngFBZ9T4TtZLZTt3L4ph/5hN469bvmdgoKdcwcEQrirXXXkfGRdH4g36L1qMIvVw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hnsf91SBByUVad//uiwQ75j/g9f3RrCPI0GGoOJjUoU=;
 b=mAGllS042/26gzE495GeLwMVUesXoHSG6vysL5I0eT+2cFbmyXWa1p7o2WhIyBamCl2U9IkH4Try1+FW+UDM54Dl0jojgg4C3lfoJkVnmuGky4lF8G0MJpT9jjgktmQmvF6qIHLgzUAy9wdG0SUMVl7zBTTurLugOO3CAcVY8WdYGFadyigWHPmUuVh+4S0WRIxbSc4P5YSqwq12bkcjXwnh+tDe2ZuPF1zFUGi05QcqkiFHqX36RMhQ/5dLaCatEii6WjdEMm0uocIFxnCgP5azj3dkWywiMItu/AMcNQUVSCSc30QYwGcvabXyOrsI1WXzu7AWCH9HpMwD0cjUuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PA4PR04MB7870.eurprd04.prod.outlook.com (2603:10a6:102:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 10:49:34 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 10:49:34 +0000
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
Subject: [PATCH net 0/2] net: fix skb->protocol not updated after VLAN network header adjustment
Date: Wed,  5 Aug 2026 18:53:12 +0800
Message-Id: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PA4PR04MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ecada2-9544-4080-f227-08def2df3c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|23010399003|18002099003|3023799007|10067099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	8JQBopwtLMs7ihMahA3bjSvToYsI5ZNPawv3cT7ARbcz9Zr5MZHjArY88k5OZw+RTq2v8GJ7nEgWOa2jgL1C3VQtZ8s+Zd32F8GdM8k3mzBAF5arbGgwHm2Umc2KZ7ybJ/UAjSU8CgUOVuZ+jK+ILd08Y6A9AV02vSKr0G1wP4SXSWVwRgfeOE3/vRdASMlGC7Ze82qgWi41PBfcjXN+APUEy+lCP8WccOULID/bvLE+0m5peqs3hIkLXGvgwntoa1/1NzFzoAhi75LuBzoPF6IKvGyg4lvvIWwC/2oejzDwq1vLpSK7CgUIeMWZlj2F8b/NAPznlc5AQEkoFnVqU9771kRPjzaiFJ8bWgsD9rIj97oAD3G/oa3KTAoDkVSkh4hVAGn+4a7XE+sBlXGM0yChoynP3DMtN36RC5mREttp5jawBycQgSeeGyYjQmTBaBDieGfXao7QhO0VRSQIeKRDDmVo4fNI8XkFYWbzfW7QN68XG8zMa9poisiWHLiWjVd8MKzI8zBniCAYokWeNCXvI4iv/mW/CEzx39RqvTuV00ps5c7OOSP95hQRppJVOvgdf95ZFzQyKfs9vblVfOrZyOz5059+qE3eENbOKlnkNwcMoZ+Ma883Sn4akl1g8k+eWuXKfuMdkWZFlwAE4z7JFg1JFSGAXNfdoHzZVoiIMGvaRZnuMrlEWDyKsfZsxIz1bFhpW5CSI1CblvG1TQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YbSkwsh7vrJ1gvq9GcaNWbFSkoibBvvPMZcJY1RV24QR7ylB5Dj7tpHTVoUv?=
 =?us-ascii?Q?om00bkppoH8Sa0xUKp8d6fKMLw/7lO6tXHWCBHheNOYDOqZLbKt107SPvFJw?=
 =?us-ascii?Q?bjm2DnaqbdPFQTcsjxqZNRZsYmsHS83LX6OS1hGbQ+yguiysYBaqgXaXAN/H?=
 =?us-ascii?Q?daSFHLYTEcvB0ge/CAUcpK0FruB5hYs0laHv4xyniNcoyPP8F96ykmwlZ3es?=
 =?us-ascii?Q?jkqfWvC2XC5kp9GdO6PoXb3vc3rGFm1izVAEAfnUGF+/3SaiMcBzoAtuP2qv?=
 =?us-ascii?Q?rzzmjNygi7mzLMUeZk5mb3Il9yp2ksaWucacI0ZZffZIcQgMlXVqkcdZuqsz?=
 =?us-ascii?Q?JOD/Mv6P1TkHM9FecA60w/tqK4S/wnsff3k703LcSFM6Wp9+9+zpOQQ9CFHy?=
 =?us-ascii?Q?pN8hapivosBJXnaLSDArOcAdWNoao5uxjvJ84a+3YHLjZfZYKD7IUmWMTLpj?=
 =?us-ascii?Q?jn1X0oOSpYDUmDW3eIy0yDgcsoojQG6HhkQ0+4lN/sQAI8bK7dCttebYxJwp?=
 =?us-ascii?Q?R+0V6oi9kqKcNzUUm3Sw9Oa60sgOEJJqkbs3QWXQsajMENCA+YsTkRf39hLW?=
 =?us-ascii?Q?XsX0QfLgOhTAK+QdZ2JdpfYhLr8u9Htoxcxz88bVe4wK/t6CW4+o1vhSNE4v?=
 =?us-ascii?Q?cTigV4FZxiM85AcBXxsbAaxmNkVULEgqvjxxUzcyEI/5KHLtSG0W6Un7clya?=
 =?us-ascii?Q?DFVz9r1kJ3PxYCEp+8yLyeaLZcASt/qocrYULD104h3LzKCHytsTZlFfMkZN?=
 =?us-ascii?Q?7rcrw/MMer9uAAVrRLYoAsv3vJbivTKGV4iRShhOidV6X6AlKwBz4ryf3wRn?=
 =?us-ascii?Q?om+gbjMEfgvqBanFZmSqAp1SL6tikbGh5Ii26zAeV4Umudw2dsYbPOSI5YLf?=
 =?us-ascii?Q?bS4cBdxTwGxVViwmvIEr0HWmVNrJ5GSGdGo+g9U67sxKOkfhQ0AS0BuU5ERN?=
 =?us-ascii?Q?tU1hNZs9DAqVpcibNHXIYBD6kGM3eYk9jKhBnV74gDrXYCT1y4coPwnjhY9p?=
 =?us-ascii?Q?swbQ6PRMj45uV1tphqVAUQJAiOjsXQiVLfQORPcK7FdwLILNmM6oDJOP0Fip?=
 =?us-ascii?Q?VjeZrziX5wouz3nRi7vexqqTsYomdewE21x+Sjemf/Fu5SMYmgSXqtottiCK?=
 =?us-ascii?Q?2p1BZtSuFrVFGnvsQCCtRm62Rre/TSkf4UWwf+/38DrCr4luc4n9TrpyhjnW?=
 =?us-ascii?Q?BWXb6BeL7jC8F22RY35SwXV9H1u0uNp4reIjSidBAFAU+ndgdR+WAOqbyWlg?=
 =?us-ascii?Q?LdvRA7gbfblngzLDM4/CmuxSRKJ4RLK6DCQBCca9G6oTY9xx+lXuoKpw5Gml?=
 =?us-ascii?Q?KTo3+QgszwoLICfDF7fMqTjs2mIYG+ipmdgPOIQr93XwE9OlI99pniSJPAM0?=
 =?us-ascii?Q?/u1yHJDzM0FPln+A4mGlekqNQYJMQgcV4tRHc0fpegAwLAKekmc070swJLvl?=
 =?us-ascii?Q?m6AFH2C3wm9jan75RNLf9UlD334OpMnunsOwp/FqQGweRvKlzfMlw19MEgMr?=
 =?us-ascii?Q?FNkO+BMewZ7AU2fOP+rWGQfsOBITIplCiU0viFSM0whBqbA16LoC0Fw42Qkf?=
 =?us-ascii?Q?22AbeC0Gcu4IFr2rz/BkqOfxEgpc5XPZOgI0KG/GLmE9VSEzWa8tZxTDPpa8?=
 =?us-ascii?Q?PWKwQ8e5F7mR54TD9sVkJcRkQyCd2CthPBozKfPTsXLBOKmyeJxdteLrHfg/?=
 =?us-ascii?Q?Y2LQl2iru8RjjZ1MlJP9QjdQe4PUsaMNfNVvaH6XRztTApN0YUGXPRoTrJld?=
 =?us-ascii?Q?fkYi5xmLjxQkLyHUIjM0rzVisJJYxChP7Gl+mcGyJbQg1ZjLC2Q5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ecada2-9544-4080-f227-08def2df3c3a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:49:34.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWvM3U+peEHmR1IKnEdXKtXSzjM7pE2fSDXPjkU8RlqL1ix1hdHqd2LdjtSghNj8qKTyMIN8V028ii89/CbOiUq4XvHni9eMCebTW/eLaplH42wd2tkik4gANDRUGpFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7870

From: Wei Fang <wei.fang@nxp.com>

After calling skb_set_network_header() to skip past the VLAN tag,
skb->protocol still points to the outer VLAN EtherType. If
skb_probe_transport_header() is then called without updating
skb->protocol to the inner protocol, the flow dissector will misparse
the inner header as a VLAN header and fail to set transport_header,
leaving it at its uninitialized sentinel value (~0U).

This series fixes two instances of this bug in packet_parse_headers()
and tap_get_user_xdp() by assigning the return value of
vlan_get_protocol_and_depth() to skb->protocol after
skb_set_network_header().

Wei Fang (2):
  net: packet: fix skb->protocol not updated after VLAN network header
    adjustment
  net: tap: fix skb->protocol not updated after VLAN network header
    adjustment

 drivers/net/tap.c      | 12 +++++++++---
 net/packet/af_packet.c | 12 +++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.34.1

