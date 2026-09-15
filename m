Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD6476CDE;
	Tue, 15 Sep 2026 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511265; cv=fail; b=knnbctjlApxlqWS1/29ARwGPJuUbYPKH8X++BuMMxsYRaw6NBn8+N6A/MaFELIYAX0z6tkwfS3ldhPPjgOqe+RfKX3+IK7mFLxiSR2hOuCHy6KTkQE7xAUHB8FT8MbbG9k39bNoqq50IfvPy00HSKS14jgVsSw4vNGsQlEGinZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511265; c=relaxed/simple;
	bh=w1ni5emANTQO8mBHfo3byyYIA8E5fQhjutroPtaqrh8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lM+/iiIq/8pEa3lBgqJkenoa4DFe9kRIA83RTNDNYb+gNHzWKQkq8Hf38cXcayKdlgD89EogeBTUxeP7xzpSOPprw9cptqgljn84b0Rf1p8wNbO07VkDJVLokMtTseFfn53xTa9UdT93HLCC3fYbn6XCSgjpFT4f8rJuMTxM4ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HB3lXvLv; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HB3lXvLv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2M5SCZWFvtmRllO+cjQRF+UnuP5Oz8XTpsUSoDM92hFAmLCiHcfoDTLqL3Ced08uix0ZOrQGfOISvjMez4t5YPjL8i3m11USvqh+K3kHbcFeN/LV79oN1z1JGIsIuIK4ib0h1B3QcMFdYZKOSQ3Z8Hc+PgsLKMFuSqhlSPdWL32akgeqqSpYs2e4qES/V2eWjpfhukXKpgzyZaQFnQXJBLxg21YL7FUDabNJuhUj+kWEIulQzf1TlWmGCyEB1jSBWyf+EV7mNqOFoC7nRj2YxJNKM0m+H7rrrOg/oZuidPQnpvH1cw63ZU+vZ3rFUIUTitNEK+ewHjd/frrxJc+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovg/PNuZDUHXOR5La694dQ4Kaxcr28xJHkL4bO+Ys3M=;
 b=psWqwUsWkA9LA+LFSbyL4/90u3etOsNwXhB/jCtGDOEyR3HqkGSJVA2bi9cZTw+BSfBg/1IzHEdRT+ouqlHwweyv8YD9uQQNd9ezPOp520yuMrT8RRhiGFtMiGVDlTt14CmHgtQRv/0kVr0SutAJ4fK3thFlgTok9+qczTaKifYNfT6bwydz5EA7EiZKe5QCbZmMIqjKt/vocYDav7EC0OPEGCQk4+sOwR9Om3Qv2CyN3V46nh+UZanBBGXV2Zv81jZJO3R8wmcxGB6Td8oj+oIby1GIariJg/PXH2OYR/3CSCAdsnDcLiK58CWfnXQEQiWvvmM8tZKJeC4gYq7rbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovg/PNuZDUHXOR5La694dQ4Kaxcr28xJHkL4bO+Ys3M=;
 b=HB3lXvLvGpqgyk4tAnAdNDN7J4X7eK6zVGtckDQyDGqi5h6AQ6/J1PYG78Y/gzv28g+e4boTrtVdOOQYrhfWZwCc2Do2Aj+ge4qn99Ax0m+bBfdtiY3cpPKDEnX3/ELlBg/EMBWzp+ExpZyJ8LtfG+VL+de7KMYBIsYHJSqVZRJLhIGTAai2ZmTYadBvSTvhqSgxl7rupFlgod3v18T4PEr3qLjtkHVe0n71KOpscCtHMj65RtrD46VWzPgCgqMx+0xzn5VDPzjoj/mN0kk+F3eE3XBVvvzbrdAjvp3Go6SwyY+FMiqXSkMOABpBimNOTWrVxJ8mkfqVc4/vOaKZJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB8448.eurprd04.prod.outlook.com (2603:10a6:10:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:37 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:37 +0000
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
Subject: [PATCH v3 net 0/7] Fix short frame transmission in enetc
Date: Wed, 16 Sep 2026 01:27:27 +0300
Message-ID: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::9) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cee219-7bd4-4b25-5292-08df13788bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|19092799006|366016|6133799003|18002099003|10067099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	GIgXmEiL4lctVRfd+xReQFPMmK1jz0hcb7djNs9UTMODQWswBuvFsu3rZYL1MP8hMD1iPRSocJYFfXff+dytcZWPl5hlCyJkaRHYnKOSejg2GodecUJSq6pw2B7mo0LJhsc6SgA/LYZ1C/TTvF1vC7iO6CLuu7PFfoyS+wFcszuFsLHhu2NSz4rWBnmVaEVluzqcF5ikpGwMx0d5tT11zlIwZtCpt8hHEMUP99+J+TAYOWO1wr18JyUpDcZdnky5fOXoUtp3ItyJnwBLpG9vxYg1Hozzs6mxyufgGPJmn6epiBazrT8Bw4I8Obna1xmz2dqmtLyhdLRzmyj7nQtUt/HQGumzFl+k5hgb0sMc+uns9aFcavKBSM3K6vx4cw6yhs+VoATOCLwyNxv3pkVs3RAW3vhPSS1FGSb5G5FuGi5DyBRqnt+BGYo0g/5vRPNDULRSkSzlsruWzhkv9xPFZCu/uyjadBLa4lXFoKmjBrXW7EmF3BZYpZQguCCfQikoD2wmKNBmHbEpvOc650y67SXj++F3p6b6dLVASOAjvJvK7d+DHib91toOr28dQVQYpJxR5Y7lqg38j73/FVki58GiIp0C8/rnu+SMWTLVSbX9opp3mHbed3YlkyIPlAku/39AuAeD5qJ8SuihhnGmQ6fKbRrbfckqjV4mwncWmmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(19092799006)(366016)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?89MK9o71EP5tuO8h97Q8I397wRciIlCwSGpa/tOj7Ix2DchP5vknsHteFt2t?=
 =?us-ascii?Q?XxWZEHmNFpcLCZ2w0h+9eeNpNBUGoZ0vwrQxYAJ2bQRsnIut8LVVX7nI5GUa?=
 =?us-ascii?Q?kOSZ8IUD9JMpSouhhyuVs+DdXAniz//zfE8tdnUGoYrEE5tlGoyLAx2uz4eR?=
 =?us-ascii?Q?RqQf2tny12cLA9uzRsqcaSy+PGjFfVTcIqbZC0T20KHdzxO1KZ4M9vdURUCt?=
 =?us-ascii?Q?I+Y7Q2qpJ/CKr2zr067KbEB2olMlfGyv7h+Y9/lFQ9Q3cWGB+gRMcg3NvgzV?=
 =?us-ascii?Q?Me4DJuGNk7ybH11tWqSf6jIkjBWM5r/MT2bZDoUEs/fWhOTYOJAwDsCamTEQ?=
 =?us-ascii?Q?GuuFa/LllAa93LAifpMuv9c6PaaIuLpuE/M8vEqYpeKxR2SOG0B927eRuJcV?=
 =?us-ascii?Q?VFtN7ulOV/JobV1XP90Xv+shetXRBzsSFC/YeHdwCESGve2MYuO7PmMT+AIz?=
 =?us-ascii?Q?BOMUExFjQlF7YqajwIxbj+8zfli3UKMNHemkpppZvz7VTcMpGNPKdSfCoy5H?=
 =?us-ascii?Q?h1XwFTEXE11YGKhHi9PRmRxWWH8yQshz8j5vmMCEldyfVeEPfKPesozfOMzj?=
 =?us-ascii?Q?u2xY3w+vVPXyyOvKwmcqRD9+4LV87Ps0A6FDXKIWBymgC6hrLi+hmpl/qmAR?=
 =?us-ascii?Q?Wg32QHCeLpP/SCFTXdtrI0WUYWjVA4c/LLtrE46aRgJRcnV0AlUFOUsUea5v?=
 =?us-ascii?Q?l9J2U8c4f1wUWGCOoV3zbXvVEwJxllE2c3V4GMr3i0z6u3b414N8fIju0nDk?=
 =?us-ascii?Q?r2KkSaYJo6dHqYHcSn0Ns/7w74sT+L6lfKESS95RiD6WR/cHJEQQEPcjY/Nr?=
 =?us-ascii?Q?G76qCqv8+2AUG93XwFgoLz2/5/ZY3ZDat5DThBzY0ZhvNH25X1XE7FxMl7NG?=
 =?us-ascii?Q?R5lrUVVg5+dQMB+e3DF4RS1pxORv0WGqZe0ixA+9uqA9qdsJsvx9H28jSg+g?=
 =?us-ascii?Q?yBNsj2AfXJa2r2iCalMNMTXYmhh2n2vJGL+Oba+X/Swj5iPNxVHAM6fu5d8H?=
 =?us-ascii?Q?xPAlzN5fW3udLtz8dsQzz5Hem5lVo6itoU3EMdQzmMke8fiT5aOHr5UugxcB?=
 =?us-ascii?Q?mn09LKKH3Wwe2gZqd26wU+4kHLycEybT8LNlAeDwIjRt84d6BeZvdVjUKRol?=
 =?us-ascii?Q?z9W7xxvQhFVGYoIoLCZoKsAdwcZ/XvWaSb9VvzyypLBiXvXKUOFGbSy7FGGU?=
 =?us-ascii?Q?EfY0Er3OP548ZY/6wOlvBZ98jNPAJ3OOVT7MLJ/fWyTs0nXCth16cDsj7PEQ?=
 =?us-ascii?Q?1noY/0BwoENUP0Q7GKaQ+7kgRP5u4X/7m4QV4lQDSVOd0Dss69u+pib84dzT?=
 =?us-ascii?Q?jzfmoFPQLpMkDObrmVqMDU9Mtx94bN3Z6fPIzGCeFh7W4Dzx6dOeB/2kBVRj?=
 =?us-ascii?Q?SQTiEsld2W0epKfXsJ6dvhSp77+llO33K+EVwVNSfS1zm4UJOnT6FUVdOE2p?=
 =?us-ascii?Q?yGOzr7f7Xw9gJVSPsjNbBtI+G7sGOSLBL9dSjcaXOpevMjoNRSAEMQmcJ/5e?=
 =?us-ascii?Q?quPnu3NuZvFtHem7dNEx64HyT/HstJOXtDzV/SFiEM7fFdlDF5weAYUTiY4n?=
 =?us-ascii?Q?MAdbJUSgbJgYWJO+csYrAQuTn8ERYUqeuWG1JahrWClthWZTYOApaoQNBmNL?=
 =?us-ascii?Q?7WXtfVXmX5iIrZNEvKUi5k7WgHjmb2sprVioVK3LaN+JoZX9134PAsWKpYXY?=
 =?us-ascii?Q?kJe3ThIbpI9VeZRheEVC9p/RLG5OL8RWMW9cqTnbnQXXkYJFt0QmUG30/AyV?=
 =?us-ascii?Q?QrDucXMHKw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cee219-7bd4-4b25-5292-08df13788bdd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:37.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4dLAgFi+zFR1pcgtLQtYk7wnIPnuiJFCyo3jIVyPzFzb/Dxoz8XIF21SI54d+aI8uBfnL7dVfcYl//uJGXL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8448

This is a belated follow-up to Zefir Kurtisi's report:
https://lore.kernel.org/netdev/20260220132930.2521155-1-zefir.kurtisi@gmail.com/

which is that the ENETC misbehaves when transmitting packets smaller
than 16 octets sans FCS: it sends them but does not update the completed
index in the transmit BD ring. I did find a sentence in the reference
manual explicitly stating these short frames are not supported.

The original series (patches 4, 5) were focused on handling the invalid
frame geometries. However, review pointed out further issues in annex
code. The other patches handle those.

The original patch is 4/7, which Zefir already tested (in a simpler
form) and confirmed working in the thread from February. The code path
should be identical for his issue, so I've preserved the tag despite the
additions.

I've CCed the BPF/XDP folks for the new xdp_frame_pad() helper in patch
5/7.

v1 at:
https://lore.kernel.org/netdev/20260401172246.1075883-1-vladimir.oltean@nxp.com/

v2 at:
https://lore.kernel.org/netdev/20260406204122.167237-1-vladimir.oltean@nxp.com/

Change log in individual patches.

Vladimir Oltean (7):
  net: enetc: consistenly track dropped frames in enetc_xdp_xmit()
  net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
  net: enetc: fix bogus TX ring consumer index after reinitialization
  net: enetc: pad short frames in software
  net: enetc: pad short XDP frames coming from devmap
  net: enetc: linearize PTP event packets with one-step TX timestamping
  net: enetc: drain and cancel one-step TX tstamp queue when going down

 drivers/net/ethernet/freescale/enetc/enetc.c | 50 +++++++++++++++-----
 drivers/net/ethernet/freescale/enetc/enetc.h |  2 +
 include/net/xdp.h                            | 23 +++++++++
 3 files changed, 64 insertions(+), 11 deletions(-)

-- 
2.43.0

