Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF654AE12C;
	Tue, 15 Sep 2026 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511274; cv=fail; b=Y/lkqRFbDnLwqbE2NyVFvOnzTk+yBqXYcL6teFw5NsKTVlc+cumPnwwIVn0Do8o7NmyMm/jgfjtskzZrwmZE1vUp/62vaRzSuaE+kGHvZUTrSwSVirDTG9lh3Mz2Fk2OeI9kYNLWlE5xsbzeZzPEIDZoL+6pOaFiKhUx+dAtQ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511274; c=relaxed/simple;
	bh=Xf48Kfy741qIVwvD72mmB83cEbj61t4N6qrUF4CLV04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOZRS4mr4iUVJVgRmyqI4FxxJOfDSvHGlGlxw2hCWAL2JrV+mDeL97rJUWJuFY60wvdn9rSEjHfhlQpe2jalWY3G/Ss2+GMq1En23Vj4T1JD6+4XanBW4dPfKyCFd+lEbZe3O7iEHf0emJNEU8iIgpN29vNxRJy4mOjEsbOW4XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JGs3aQx/; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JGs3aQx/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxno3gQpupv3dJkGf992NrckZPMConDWkn3QGZeAt45nEtQkl9bHqaQ5gNAhXt0t3nyl4JpPQX4zXm8Itkba4xAZtXwwqhZEFWD7vBdTlk4D/GzEgY+GKAPl274X1icpRSoWnUVXD6i0P8hB8gPjIb5eG8S19xdP0t9mTuOZe99ioEkBAqyGl3/rJKGAL1D3c3N5gDPKH+ajW4XWqTVgTwdKehGt/RoDXlK2UwpChDF0rd8A6LVlXHu5t9XBDvb8MViRBV7ksfk1B+qCI4QbbSnEENL8QKwH0PKKnLXBJMi1kJKfIcdrSU9kpkQHzgTKsTnErp5yok9rxInkapq0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xYyBxotID8EIiXoChhbm81Gitmm/J011zwlGYFFCBA=;
 b=LQ66PLiMmE/VLLu8KtaxYQI8ftF5nQfwZvD4PWPO7xPGhAAt696BJJKKVaJ4BmmWS79Jysr3iqsV8qTm07EqnunZ6hq5vpPrwmpCethStFg6ZCih2ZXKC1xlDCxp8ED3+vOuQGhe+1wUUgOmiaxJjIG5dxtb1TIazsQBwAONqqPduN2b1x3JaEGurPxIXAR+YOdsVn68m/q6F+86zCKfUfJaJZ03J+j6C79XrJ467rblBEJH+08BRyFQ2ki5pAq7cNv//IEEpCJuN1Vqe8AUNxuPtn/CxrWbtdRLffPaMx1IyDaLwxv3M7cOB8k5SHTTvf4762AxZOp6VMaZvYFMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xYyBxotID8EIiXoChhbm81Gitmm/J011zwlGYFFCBA=;
 b=JGs3aQx/wH586oj1NpCrxWg8FSJi0vqlkgKO6xl9mmz+a6+Q6rPiMHWllOzlir7ICP5P0/NbfmSW9lmRH7PPVQJbB+LXJwhxJg62w/GdfSdJJiofIZLYn71E5VW1W0y0mYWpPGGZyMt+euIYWYhX6Fyb8GTr/fZZBRrxiKyMVMHlJ7p3vHp/hN6VoWS0aKFeS3nd8n3kHpV7ORSH/qV/wrebwMuFmbXOAJW4DrYEmQBJ7Q4n+eFhZ/sifo1PrgAsEq/klM6fi61B7E3ahDXAyWUuuWG1SmV11+PtWnRPu9H7CT0ktk1SznhfrP0kt6wJVEHBKm6ihMvwji2iSEbaFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:46 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:46 +0000
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
Subject: [PATCH v3 net 5/7] net: enetc: pad short XDP frames coming from devmap
Date: Wed, 16 Sep 2026 01:27:32 +0300
Message-ID: <20260915222735.1016937-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::10) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9380:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b3a246-3aca-4dd2-338b-08df1378913f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	54B/A2t8Xe0paepLOvJ6c6pMvNkraC/1CsKvTwpGp1PboufsmxAUKZHJcZepJDXUDvXKTn8uS7682yf0vMWwRNcn8AYXNv9hAQIiPwkf2zF5He1Jk3qV1yvlaf5RuLIfvUfeJbiRHcL08WTrFYPG8oMUZoMIeCxR4IMalaJhtWVjaAm82ryZWMfJ04y8L0qNnJtv9GoU75t4YDK3JjK23tuGycv5fuJGCcf0ILDtEJmDjEmw+YKSAqun+TQRnd5UL5Ez7KuAKKsKe7BXFCtmIZKaKSZ5gejq1TdCz88EHTRv5gDcKQZRCPYD8c55GlUWgNSRanwDOotx2G8Ztiw2v9nHbp6fh5dJ0mzeNy0jyK+5ucXnXKY8RldgoapFOmUJupLAEUWGd2SLvdaRlG1v6KUdDo7Cpgei7eoqgERgXiPi2wD6furt7FNKIhKX673dEBKtB4P+PZZGPG1j0OEV81LJQA+0MLR0h2Bf6ZIll9WSgJCZWlYhLUgUavYc20j4qXTlg+u++K87OYSlcYYLMCfIL+C6zr8bNJ9YPpC50jUpoC4rh2ZwRp3iZpiHKP6eMOGgd/ZMz/GDZZ4zuSi6ZuIAt8/1hKK+bi4uTsz8vJWRCqbWXEfJ/2fFEgtWGxSVCrS4GAslyX1QiutYUf8Wx2v0rwUjUpLz8b1wYvEdzG8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O576wQFrgSGsRvcmxzTMFglHK3WkYJZhWAEZyVGuwipkdNA9vPr91YpSY/ga?=
 =?us-ascii?Q?yjI2hgSCf8jxeM2GW+Xxd4lAsMsGe00j08OBBA/mOGV9bTyD4qAG7YXodd+T?=
 =?us-ascii?Q?PbkzRDeV5e2leDeDZzUmAREac3PLU+6WU48IS3Q2AIiVDuYoLauR8PY5+A34?=
 =?us-ascii?Q?uYN7e/ebSXhJ2V50A2/AApVNQA2DP/c+BaIRMPi+HfjalINgbD8+89MzUHWy?=
 =?us-ascii?Q?8+nXS2l91mLpqjW/EiBwgFg9wFEjw9xhAjbYixilz/0wusuwjvFIKXtKCHpo?=
 =?us-ascii?Q?pIR/XwWsTIU7oz4GZbhJJs//flFf7922c1T4y0YUqmy9f0MowGM/T+jQCfIO?=
 =?us-ascii?Q?57hRVNfe2UXmLTjBqeijt0IP1tS9VaErOyIBpDezK4p5mV97Vy+wI/yzPEdf?=
 =?us-ascii?Q?TGYSikmJEcO+Cwo3pPaIAE2miJJ+ycUBrjI/Xv5JngOLDtafnCdoa06UJffT?=
 =?us-ascii?Q?RUz/W6y5QmuVxstpS0j3BL0w409DSTfYXw5aNX9X6LOwG6u2iOkMaX0sT3tt?=
 =?us-ascii?Q?woGurTuaU+FM0NW79mE0IGWJ0EZ/bLiCv9TT0xi7Pae92Vufs7VLWkEjtcrd?=
 =?us-ascii?Q?M52Z2P0yKeSzFV2vX4dkVwOL2mA03BrfMLPknv5HP4gIpEx9+NYLdAEQG+D6?=
 =?us-ascii?Q?ZNw653myQbuxp8VLo+rCIwLqF5NSssqYNoRP/k5+4I07ljARi31edCDdrbV/?=
 =?us-ascii?Q?REHZoLVcELTv69intjjRglCzww8QeuAdUefmgLFD4jFhwzsRd0nc+BUKP86d?=
 =?us-ascii?Q?UNlDHTFJMj/O9Q7sNAanXNrYY9LIbDYAhXuhZrzB6OPfecyvFN/sHklcBv4/?=
 =?us-ascii?Q?7AYdNs4thq/QIGgk3TkRzWP/t2mhAsdcqvuZA+7tL91iaufvM0REtvKpMlnq?=
 =?us-ascii?Q?k8Z+CSwCHQNAzTtMFJ9wMmnfh/eBl9ZRoWWr8pFhpRtO2lTni9KsKTqd+Awe?=
 =?us-ascii?Q?mtCcuTE5N/ynRSDlmF7utghLzJgztbLLODgmgfjMCmy/Z0oK5LtAp+pGP2HH?=
 =?us-ascii?Q?Fmxa/kLmP+8Jb61EigY99VPxh2/B6vTpz6DMnNOlObjw7DGZD6xpi6qDl9R2?=
 =?us-ascii?Q?YulLpIwYkQSrc2mSnMrO18s3V7KYttIr4nLslvbKTSx9fgSgKpQ76a9BA+yq?=
 =?us-ascii?Q?+xLeuF0wNQmlgHTb2wHf8d12veRfFeGXpjBA+eQTxDNdsRJ6NjqTDlmER8fn?=
 =?us-ascii?Q?F149NtAp7kXQanVkzrASrZmLHqo/8/FxkwNXr0ISaylDWdbovJuN3yXEAytR?=
 =?us-ascii?Q?1bXv+6e84g0TM5LvLwn0GejrfSY0T135OHJ3yiNgVuYZobPks74rLDqZsX9l?=
 =?us-ascii?Q?lVDtQ8/XIWIzsxDhviMVp1geqdy340gmiuNJyorZZh9ldK1Lo7He15Vkt4pA?=
 =?us-ascii?Q?9lunfMjPhl/IfUDo8LPukS7Tgq32bCOGHY8vRe3vB3LmG4SOqXoXdK67hseQ?=
 =?us-ascii?Q?NdPKotV/j7eUwPlTtzTQ8+iU9EzR0woRpvnN7B3CwOmZQ1X7LehSICoSh3oR?=
 =?us-ascii?Q?KPApTqJRZPSyFKEQ0ui6tTGO7FvLXNLiBeBBu63lrQQR97x7e8iZQJcPL0tJ?=
 =?us-ascii?Q?vvbTi1W1B387FuGEhSGbhZBWI3oIz+rSUstIJ4rxhq/T3OelMIDNdyVQ+2g3?=
 =?us-ascii?Q?Mdx7G3ke5MlpW88sHLsyQqnrRSFbZBjMXCHqiV2axX5YJ0OYOkgUY/ZoMsAE?=
 =?us-ascii?Q?jUmrPZTGemT0QbixcquTUbhx9guwuAU5552RFI4Q1R/yP1cnS3mkzwddptHV?=
 =?us-ascii?Q?s5w6Rr0mGQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b3a246-3aca-4dd2-338b-08df1378913f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:46.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDsjwHdgt7rX2kwMdVAKCIcfRwB8wfiPuNfRtqKI8EFncxd0AFg723ODB0gyGhCfeGSpoo1RNz/dUr7Mv4jnQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380

Similar to the skb path issue explained in the previous change, ENETC
could end up transmitting short frames coming from XDP.

The way in which this could happen is a bit contrived, but it involves
XDP_REDIRECT from a veth interface pair.

As for enetc_xmit(), there are two separate limitations for the overall
FRM_LEN and for the head BUFF_LEN. For the head BUFF_LEN, we add a
direct restriction in enetc_xdp_xmit(), and for the overall FRM_LEN, we
introduce a xdp_frame_pad() best-effort generic helper which we call
from the same place.

This helper alters the frame, but that should be safe, because
ndo_xdp_xmit() is the hand-off function where the XDP frames become the
responsibility of the driver. AFAIU, struct xdp_frame doesn't have
multiple copies.

I say best-effort because xdp_frame_pad() can only expand the head
buffer of an XDP frame. It cannot expand the last fragment of a
multi-buffer XDP frame, because, unlike bpf_xdp_frags_increase_tail(),
it lacks access to the rxq->frag_size, aka the capacity of the chunk of
memory being pointed to by the fragment.

So, if the frame happens to be less than minimum Ethernet size, but
fragmented, callers of this function will have to drop it.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2:
- handle multi-buffer frames instead of being unaware of their
  multi-buffer quality
- add separate restriction for BUFF_LEN
- increment drop counter
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 14 +++++++++---
 include/net/xdp.h                            | 23 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index bbad942041f5..8a9ba168eab1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1838,15 +1838,23 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	prefetchw(ENETC_TXBD(*tx_ring, tx_ring->next_to_use));
 
 	for (k = 0; k < num_frames; k++) {
-		if (xdp_frame_has_frags(frames[k])) {
-			shinfo = xdp_get_shared_info_from_frame(frames[k]);
+		struct xdp_frame *xdpf = frames[k];
+
+		if (xdp_frame_has_frags(xdpf)) {
+			shinfo = xdp_get_shared_info_from_frame(xdpf);
 			if (unlikely((shinfo->nr_frags + 1) > ENETC_MAX_SKB_FRAGS))
 				break;
 		}
 
+		if (unlikely(xdp_frame_pad(xdpf) ||
+			     xdpf->len < ENETC_MIN_BUFF_SIZE)) {
+			tx_ring->stats.xdp_tx_drops++;
+			break;
+		}
+
 		xdp_tx_bd_cnt = enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,
 							       xdp_redirect_arr,
-							       frames[k]);
+							       xdpf);
 		if (unlikely(xdp_tx_bd_cnt < 0))
 			break;
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..276afc9aa21d 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -477,6 +477,29 @@ xdp_get_frame_len(const struct xdp_frame *xdpf)
 	return len;
 }
 
+static inline int xdp_frame_pad(struct xdp_frame *xdpf)
+{
+	unsigned int total_len, pad;
+	void *sinfo;
+
+	total_len = xdp_get_frame_len(xdpf);
+	if (likely(total_len >= ETH_ZLEN))
+		return 0;
+
+	if (unlikely(xdp_frame_has_frags(xdpf)))
+		return -EOPNOTSUPP;
+
+	pad = ETH_ZLEN - total_len;
+	sinfo = xdp_get_shared_info_from_frame(xdpf);
+	if (unlikely(xdpf->data + xdpf->len + pad > sinfo))
+		return -ENOMEM;
+
+	memset(xdpf->data + xdpf->len, 0, pad);
+	xdpf->len += pad;
+
+	return 0;
+}
+
 int __xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
 		       struct net_device *dev, u32 queue_index,
 		       unsigned int napi_id, u32 frag_size);
-- 
2.43.0

