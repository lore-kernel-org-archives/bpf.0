Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594C4B7166;
	Tue, 15 Sep 2026 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511269; cv=fail; b=IPGFyPdFOMpBNw6R3+YuGogoQKC+urWQq4QDL50D5R4XEkNkJPEa0pu3ih/X51HigrlnsaXebuvMM71Q9B8SaKrytuZxiYFMvn2Dok0Bu5f0Jz9oGSi7C9hUmF42yw+XZ0Qe6ksL92YjqQONdqift1ZgJe3HzgBcKs71tQJ2DPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511269; c=relaxed/simple;
	bh=G93rVy9iEK0E1BVJ+ZdkILulL0YfGVDVGNVinbKPnCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cx/UWCj1vZoBmJTHdJeQWULvufT801txgf1w303/8kRriV/aSA1E5LT8lN8y7Im2fso9qI/zwpxx90VDSkhzHFuq/OeLG+i4lKpb8bmbLyc0Vhj0KxdI+MBNypSliapi0nKBmqgruROJzPYhx3ucOaa3yoNZro8p+xLEZRPwizc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C/gpv3Ki; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C/gpv3Ki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f24cdCqmhPbmp5G2GIe3BryqMeUHWU8MEPDh4ec7ReO3r/v38YdOWbShGB77peqogz2etAKWo/5IBJfiNmGU6cuHeLK4emyUHyuhWJHT+ToiQ+oC4HsasuS9l1/NpVmizQHOdCMXQ/VgCEygGjEps2mp/1oN48+2z41jQzpAT/tRum9BgJP6AF50IvObHtsSBCYR2m+hbciQNVpR3M4Ric7AIzl2KbSWkEO0cZwzYrCanmQj3grAlFCVM8CjqWZDZBOoZ3hQVx5sk6QJqcfmTB5nZYH3bld0V24qO6ScUxoJz4jruzCCJXLp4lnZWD1J4qpzg09ft3zcKmj6qbejmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwMsz6iyqq9s7KXMsV65K8z4X3J1VJ7vWjQWuErQehk=;
 b=HIbScHi9xAW5PJLZcpqO1jdgUfpzOV4MaSB1kV3h94D2MfNAlom5xFAT+J43fbHsfkyDApHCgKzbOeDnrNPYubqMQb5amQ+l7mMYBNZex0S8Fl8RW9VhqOExt7kIzUOQWBKrUaRJvhFFQaHDymyF1qV4Ev637QHy9GwSeL+HMYq9CbXSQ9cSvLM46QjawbjXWrW2sP589R9Rfw1+b/gTJVOiTIFxPX68hVdE/QSF8MZzl6ie+4TCGFr4rXlo5WFliS/4sX5/s3EzWln59hyIMuGFwN+6AKI7mHFvyIhL8SarxPtaZGBetErIqKf+57s6NuugyW+r/lJvduKflzoRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwMsz6iyqq9s7KXMsV65K8z4X3J1VJ7vWjQWuErQehk=;
 b=C/gpv3KioPkXmnLIFwjF1pE+GUKLQ5aCejyiWxIVWUgjpajTPqyf+viEd7BIHOFSUTXh8vPEp3NOLD0XqkpnNam81cf5JyXAGXlhJF9uOSX3+HonbRAFFQQuOgj1trSSaNlozi1N/ihIblS+cS3jllXfb45wDwkOFR406KnBcNJowrN1OTzB7M4tpjrzy7zkF7v/QZxM5V8pULU+IUp+4RJQE4yN+isYtM5DY/K3D/Um4JueGulg0tK98/b6gDmeCHwe4+Sk+rIVlzF7FqDhPYS6x+wElDYhGZk60a24az0mV3dVJ3tJNsWOhoq51SeON+XRXGVCwaFbaQK2rEDhyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:43 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:42 +0000
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
Subject: [PATCH v3 net 3/7] net: enetc: fix bogus TX ring consumer index after reinitialization
Date: Wed, 16 Sep 2026 01:27:30 +0300
Message-ID: <20260915222735.1016937-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::16) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1345a6-20bf-4c44-7cad-08df13788f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|6133799003|18002099003|22082099003|3023799007|10067099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Yn0jttViagyG2vf2QpThClFUXC+SxsxJ7J2+a3npx1f8lSYj4uj1p+gLVmMqPPYDKMrUQ+Y6A3WPq0u+Pe6b6OsqW/4NzYNnXa6mIDtDJmTpDDKNVOQT+yHSxS6HnMaaUwLEmro0R1sctWg7ny7eqKIgKBa8k9TUNc5DaHzeiiuuzpu3/LuRVLAvWa+Z/hcY+Yt/x0YsEb+bRgXyIC5wkQSJlUY8vrEvPGYoUg0YUao1s++xt+0BBdzRehlC8Fu3cNGzuW6mdNWt3aEd2BEM1VrGeix7tljy3L44f4P6PCgQmmqqELCiDZNtFJtO1GCnLomIdE/1oKwF26JtWXiCsbKUdrXjQz6+xBXAfsBObhB0H7WSA+PXli/N7+dGhzjabI6LCDyivdhQxgelIFJ3AQdfQ/XW7Lo5iQBvDESOXYJIAQKtKAXRCwA2d+nFD7I0kWDrUiOAqhoIjVEhs1BNs8fmNZ9s9TgSGhlUI/r2hAgEQ/iaRHZ/iza0VWv285n8lJbHHoWioF6doEpZACWX9smuPwzkFW2Ba16px+sPWy0OLj6ofDHsCbZaXmgtQHoeNFLlTM7oAouDmwZY4Ro066VQTP3tDsB9oi023Xvln22vY1FDKUYSLt4O1GJu+vkT1+1q+mn7jGMfIUciApymtiyt3hHpr4bh3rrRCYpyLNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fw9jGiCs5XP9mqyV7vKpUHzQn4EAztNxuzNqBS4XccMTKMKX+OC/Na7w0ydX?=
 =?us-ascii?Q?0+urgGyJmIguwQNqgfoRdON5VytUk6oenY8uO4zaPhkYsPsklKqWwjDSxIsb?=
 =?us-ascii?Q?f/A2aRYMEe4yr+vQuSUy1Cy4EcOJCHutsA48B1chV7jpo+tn2jnSLnrQdXI9?=
 =?us-ascii?Q?I2Sp8C/1NWCkQWW0a+Ai+XEjoqoMu9MHwwHWTNtmP+9TJsth5M58AafvWDbv?=
 =?us-ascii?Q?Ca3D6F9Jx4nPc8HOujMruJdjl6tvRuEwevQw2Lnlb+OIqdRBNv1Cv1dX+fTa?=
 =?us-ascii?Q?ifwWbzN0NEL0NKVxCStkEtM+ietciSYhQlbrAgHRTJ3ioUiyXs3SfwgS/Oyy?=
 =?us-ascii?Q?45bTJtILjfxytiXZpsgPzUnwcBNxif3Jg0v/oh7NXj22Y2N2HK+vOQfMjtxl?=
 =?us-ascii?Q?3Z613TnoRRzvVxHr9AbZRAKEXPcU3qVN2yYA5IJ7nNiy2u7aWWwnLytJ1csD?=
 =?us-ascii?Q?OJf1pzS5TXuMnk1tLc6k9BlnW42olwo4uW623iIEND+xCqudNoOF/sA/6Q+o?=
 =?us-ascii?Q?E7BArus7UD3Qzn7w4nZoa8xUr1Zk0W2LyA8Y1+DvDWYjfbw6Lu1V7djLxJf4?=
 =?us-ascii?Q?LSeBiAWR6SbKAmTZ5HtDMG/cPuYden/xXSN3OzP2umoBINdjMEDOAaBVwcx2?=
 =?us-ascii?Q?K4x++ZWjIg0vS24fxuuXC6lqBFjGe5s5ZyXtniatOzubTljsspm2pcZtCPWc?=
 =?us-ascii?Q?ezrHKWlKu/zmTRbWXQFwcHR99wg0KfyaS5TUBAFVUlKJjOLktjiPv6KNJ3N+?=
 =?us-ascii?Q?NUhm7Kcvc4l59KstVGV5ZShOr/HbXSgV9HuvyuLd5ZdS1hXxL/tr5fvAMQb8?=
 =?us-ascii?Q?LNIz7ONHlncdXvQL1DLAbtWDF01YhsGaZSYg05Xf6egjq+yj7YAdp5kjCHm0?=
 =?us-ascii?Q?LhPUulegFQlqcHhrrfl18Ska1yo8oQ7g5FmThLZP5CtOzKXscZ0FipSE4hJT?=
 =?us-ascii?Q?rwt70duJYEbr5KRJrke9agln6yjh4SEWw1KkSDx9tP5P19ds/14J6iBMJcKn?=
 =?us-ascii?Q?TaE7undAbSfrfZkDdk8Ec6SYwG9CH4T6hKkJNZnqm2RS1skKkJM4d9+psobW?=
 =?us-ascii?Q?bYBbG+LPgBU9KZtNHIlt9kSYGllzSxpWPt8VYuZaWFgiplg3On/d13RlE5oC?=
 =?us-ascii?Q?m70r+nu/Yw61popcEFyMOmqPOsERuLOnUYq/PdtTKqRYOeMafRXu5+YwN63t?=
 =?us-ascii?Q?UQJhzPLMfXst6iThiq8PnrPgWVLzE1UJk9AhJkZIoPmdblyj1TAOvB27lAPy?=
 =?us-ascii?Q?10or1Fbw5xp9hAwWT+bPFIjJEe1zqZS0qbm5CjP7N/ZzWJ0LoFXVekyuIGgN?=
 =?us-ascii?Q?S/bTmVmEbfwVxgunlBx1pARP2/TGbRBOVZC9DaqqFJM8tOnxr4ruhL1aMVAn?=
 =?us-ascii?Q?RoacObFWDEubR/7OXmRgYP4wVnavyYTmcIU/555pfQUieckWFk6mnDtPaQnw?=
 =?us-ascii?Q?CPR5uxdZpicfkBmjcJ01JaGRRx8laaAYRNACv0dvJCEH7aj16JkEgfeG1NEk?=
 =?us-ascii?Q?QDpKfGGLl0/P3Vqy2BOvzOZJUB3tTUECzu+ahbZv/0WDvU4oSS8Tj8ULKD7K?=
 =?us-ascii?Q?plk0JI0UBzpO29fvXEgbOYHHm38iekgZOYzp+kxw5IbmioBYAWf64Jk2SQY4?=
 =?us-ascii?Q?FrGSfmDD9Sh40f3rr6taDaR+cH8jL2hfpa6x31yztwBLdxxbbs4j6tqeI4Q3?=
 =?us-ascii?Q?N0CPGLGAdpfFbbzTs0+KH3WSNa/yQk5agk2zzBE0oL+klPog9sggKlBjmIG5?=
 =?us-ascii?Q?Ez8+X1NEyQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1345a6-20bf-4c44-7cad-08df13788f20
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:42.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH2go9rdZ2+WZu6JDNu8C4q286wV/jbdAlAkY/x98ZKG58hr4GlRqUZl8MwqHX5Mt8cX1aSAXFqOwMTnnQJySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380

The TBCIR (Transmit Buffer Descriptor Ring Consumer Index) register has
the BD index as the lower 16 bits, but the upper 16 bits contain this
field:

  STAT_ID: Status identifier. Incremented each time the BDR_INDEX is
  updated and an error status bit was set for one of the processed BDs.
  Clears on read.

If there was any transmit error prior to the ring reinitialization and
this is the first time we re-read the TBCIR register, reading it will
give us a value with non-zero upper bits, which is saved in
bdr->next_to_clean.

If subsequently NAPI gets invoked and enetc_clean_tx_ring() runs, this
will dereference the &tx_ring->tx_swbd[] for the bogus (and huge)
next_to_clean index, and will result in an out-of-bounds memory access.

Other places like enetc_bd_ready_count() do mask out the upper bits, so
let's do that here as well.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c9c23e994f6d..0216f7d08e19 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2627,7 +2627,8 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	 * adjust sw indexes
 	 */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
-	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
+	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR) &
+				 ENETC_TBCIR_IDX_MASK;
 
 	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
 	    !is_enetc_rev1(si)) {
-- 
2.43.0

