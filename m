Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A337F753;
	Wed, 21 Jan 2026 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966501; cv=fail; b=tacWbc0uWXYFyQOtoghgiBHk7St2ESQtK158K4jyQjQ7aCxE/kkUrGyp/CAmTb76JoNeqBMI8Lcgfuv69pInHoqq23pCX7ON38K5Xv6GmO8whTz/6Wh+w35KLFB68uKE3gewt4cbL6qF/xcf/BOFL3tkvho4sobsmUN4y54A9CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966501; c=relaxed/simple;
	bh=bmMmh0w4BOq31WRsij3wZJGEP/E6AduAZ1d6wUNQjlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lVNJdx9+/YUrH3fzolgMvauyn4jF/PjtKX582qr9tsUdGEjNGZd+k/f3kt2iLE9nLOfsMVNN1XaRCzWJPK7kLn1cOskLO0q9ULJJ5vAxNIQiIBygESaghUbYx3prRe9kmX5vPuuVKw7Km1SrajGKtb3m5bLtbJA2AOnoOzTVCsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nw0eu18u; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nw0eu18u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMmVeug2/wM77e7qJ/htOD81rUswh8a1deigt5ttAPgEbcq75A0WtGl1XnQwCdAJTK1f6n2t2jPXL8c80D+cVGRPBeXSbwHt9NLKeyrcKXCbhaLSJmpAzAMOXYyPhzMMbd1AlcB7mOKRsfQnVJ6WBb1QNYkT4ZVNKQ3PMkLVfviEjAK1cMCqxPEC7Zxd5yg9yyv5eLv4iCnXtS1EOMnGp96hOvAezhMob6x51228NuT/gjIWNOAVrv6kV7Ox30ueLm2tOUbcUbD1hFvklTvxgOlEOqh7k66SOfxY9mwUvdyty6FI1MiidGnit8v2ilJLaE/08BBdVS+TllcBG/Qz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joEZ/nfjW9irnpZXF1HLILnWOm7c8nlWmhV78GDgWlI=;
 b=CVVlptrX2H/8UcqbmqFqx/CNFVKsLWMlUKNXDMeBiZJ+qijDF3oOjosszrpnwgp3LS41Up/6PdrN0Eaktm6IG8bWULDQbL5gyad0ZIK4OUStM9t3o7oKr4it/Nn6iA5vdDXXKAhQ1dB693rH9Hx2FXRisT6IfyU+FcOiJosptJoTZkOugVU3mo+Cp3WAoKSDDMJ+D6onnP6Zt91wguWlebWz57/FU+2TVSYbL7g7Vn/QiOAdOhq2Za0ux7wqO16ahsMP6FrMoB78IKgP6Gml/8wDvbi3j+VqQgn3IsolfANDKUExE7xCH38Ir6VlSSaJUwsPxoEfxRBMQik50TKCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joEZ/nfjW9irnpZXF1HLILnWOm7c8nlWmhV78GDgWlI=;
 b=Nw0eu18uPW/fckVnjj9EcAyNC6uJISAQSDhUxr/9m3lPosTmAcAdH9F2RQSsoM0ONRlclLPxqecbUIsoLp6sgQVaCAJDRZyivMim+yQdlGjKuyfFvHeN4FZ8TAv81uRLmyMqCLvxIDV9G0n3L7aXf+YP5Q6LjHKINtXeqRaTZtS1dCS7CEmV8b8ErcIsRWhAZTC1DwnAx/sCMTLtz26s938VHyN5NYc2M5mIXxrBfJZFLQmG4yPZ+oSEjpbgwX+y8VNf+opq4pIOkKA/LevaC6p2tqMduCc3XZtIe0rFMhdPtDh/cVn9p977ZlGhQR+cKJ+PoqqFrhwcRMU9SAgNuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:34:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 21 Jan 2026
 03:34:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v3 net-next 08/15] net: fec: transmit XDP frames in bulk
Date: Wed, 21 Jan 2026 11:33:50 +0800
Message-Id: <20260121033357.3261464-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: eae92e02-3cb5-47a4-12fe-08de589e0bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxc7eRSKpA686w9KkvkPUZVK1WzEevBaK3R+i2TY3nFoOnpT3LLT1thRDzTw?=
 =?us-ascii?Q?Z5FFj+fqDWQ15WfqKhRq3a37sgDu874b4dSRB/6EyXLXFWWW3XwBl76htvzy?=
 =?us-ascii?Q?g1LXtnQ9lqTnnDXXvDCNqT7v72BHEb4c5CtrswRAbZHJ6zXlL1xpUvWz+Qov?=
 =?us-ascii?Q?v9Udl9RcsQhPHQAAj3uAUuj/NLHlHPkvP4lZXcTj72bdLswdjBIed9FVHcdM?=
 =?us-ascii?Q?e/JHIWhEd4n4rT7RCcrPhGER7HcHB/nAkTTZL5bUGVNUzRsJCdflg6UvF46i?=
 =?us-ascii?Q?yinkeHkA82cxRnFFrNyoGz9E/tjg/loK8HIUaXDPnJBuvLBEVABDgg0cj8e7?=
 =?us-ascii?Q?XIhJ9DoxNnD5VRMt0IZvpoEr0i7+MJXp2RS3yj7v+NsJN/mVUTk004UIR90V?=
 =?us-ascii?Q?fu2tlSNx9UHQjPQPNgw+1XHQKdLyWri1TqxosWQayvehJnu8haNyR2OyPWaY?=
 =?us-ascii?Q?C+mq3ZdyXobgb1PlLMyZNq3CJXVun/VzkPDOLrC8G5k+v5buh34qJ53tVCio?=
 =?us-ascii?Q?5WubR+vDJCeDDDGWQzuZ5QXtVNWKjx1w+1fx22vMbhDyXdMlcXU+WSoaPo2W?=
 =?us-ascii?Q?rzByNVvpa8VcV3wGSCIE7hcqKGRTvxP9A33P8dmKnbEuB36DFD/XpoPMo3YQ?=
 =?us-ascii?Q?cm+YAkd486LccSFm6xeKj3wH4yMwhu+NOGpfLKsLysmrndrpQwZjKywvHuA8?=
 =?us-ascii?Q?K4SIzwI0PGWp0akUz2kKPXRo0CxQgZfWSXi6Z/pgj2qkxFmROuM2V39itFqq?=
 =?us-ascii?Q?p3NCRmn+FhZrm5k3y0n+hsOEECz5e1QlmBpA8hrTv3zRsZ6TcQnDupt2AAz5?=
 =?us-ascii?Q?K/uzUwas0nFpx2D6qLagH6TMEkR02OzI7OmjaIFTgPhpmlqCTDsN+LTMJHTO?=
 =?us-ascii?Q?WOE9PoFf5M/aIVdxkPiAPPJh+dMpPnOR+PBKOvhyuQrmODCqyqvoFmlETiOy?=
 =?us-ascii?Q?slPHhwgMxa2K9u5mrpzAGmleajRr+NBT3YwD1mFdoT5UPCyc0G2GgAWMFKdR?=
 =?us-ascii?Q?n7LRY7x0zONoqAIdUF1kbKFeHK1oHDWu5CB/iJR4MFU4zhk/u6VauuHQdqQ/?=
 =?us-ascii?Q?iG0OnAHb2+X6dOZkXBWHed2rNnVymzAGLTpSxZBzLBFc5Usy+uZNGY+bOL/r?=
 =?us-ascii?Q?2slQQwvEvoIO9sd3EMTz/x27od5eu5CejfXCrx9osI8VUTvV4sqTRhVJXjSC?=
 =?us-ascii?Q?rSPgtB+88dRULRVH3Gjk+rWwGcMPQjWNqvy8CZChIlUUkg1z1syTMPsC5XC4?=
 =?us-ascii?Q?IEaM5kWxbwZSI99eWU6pWR+F5qXqFB9myEK2mFGOh3jG4qT9PNf4nqeqg+rM?=
 =?us-ascii?Q?oIsklv6nBbqPy+TBUBIRZGXHWOk+jL7zJ2bVO34wpF0OqzfMOAQ8g+N/D4eb?=
 =?us-ascii?Q?MH+7b9+ciPaiJOfV2L6cMGmf19PC4pGT/peEW+ZC3IZtnoWiP5zBs/1AAS43?=
 =?us-ascii?Q?YJnTZukEe84xaIjWA2+5Qnv+PvCSAspYTMx/G0AsrNYKPsoUM8NuGtwG/mxE?=
 =?us-ascii?Q?hdm1I1VsK7eAgD1+w64ytCDdqTUGP05a/qIgN8N4ZPOuwTnsjhl1oevcbDMQ?=
 =?us-ascii?Q?2V8OpPUTnSrcZ8sZ4G4x/vmeXxNZ1Gx51m8UjwRaAgNS/fptyNUy7pVFP2MQ?=
 =?us-ascii?Q?0PE7Y53UEfvL6WxjbumtA+LegWs9np7exck0b4u53xmc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+CnCXdI3L0U8PdTU6FvEFxqz+MvZhLaRtDlsm8FZTj17u8zTvZLcbRJqwKp0?=
 =?us-ascii?Q?7KeMkOs2ZsEzihcQoPpTdFUped7e3Z5CYOHoAEkNKPGuQUbiuJnTJvA7N8bS?=
 =?us-ascii?Q?kQaC4KFcJcRQRgljGyt/x/vYSoweSVohcSWMYD/ySMjnrVctr16trgZ5G4+1?=
 =?us-ascii?Q?CGlXHPzTQDHM+o0D7njmCMZzalYVVM9allEu9G2o08zw78yEXlxcYrzdhDmr?=
 =?us-ascii?Q?dsWbE7eI1ryaOBttEKWcWH1aVhc8l9GnQiumIGVRMoKHsWZMOG3kuQxHbaSJ?=
 =?us-ascii?Q?UhF3tbmfWoS8QFVgbCFtoGSSwsQQU9uCSFs9BejoWb7McFTjmCNSDKtVFjec?=
 =?us-ascii?Q?uZ4RItFLH5gAWKDJ44n2LOk16lL/Z1cslUNet+2nOL5o5vKaky9QtHDgVkQ3?=
 =?us-ascii?Q?nhC5ENMSxxLG2+aYZjhnHEL4sFtjczcyJQn1OoiH/y29GXJ6GzWt+IaTUA7f?=
 =?us-ascii?Q?Rr1ohqzo/EC0DQ/kSsAqeSJj2ZMd1JGxquqnAIW3G/XO5QUu/vWP1h1vNyZt?=
 =?us-ascii?Q?GN1CCVKszjdLFmizrSV4rNnreW8jp2vNLSl7HOxxuCK0v8qZfmnEqyVCW4Ra?=
 =?us-ascii?Q?KWDJgxvlHUOuAXhwr9ZXI8hIhLiBu2Ui8xbj8wIYHTuUg2P7p0GPTVpkdhVP?=
 =?us-ascii?Q?aJo4e+MHwCz4FpcQo36ZHhBCbfsPP8QNDC/iiJfVTr+xJInMt6Bm9sOQUm7D?=
 =?us-ascii?Q?J10ReQ4oYk+v9o1AoMVuSJJ0sT2+F3aNAJqNUTEo8PD4Afe1Xf4T3SXt0Df3?=
 =?us-ascii?Q?LSMsW35Q91lo42sPNwlITioP40gUT6aghxhP1oi8SiYtVC0n7qKxm9128cSt?=
 =?us-ascii?Q?ZrzZe28Cgi/fWbz4V4FskxcWi3WrNSLIO9rWWFp6kjfz2fnzmG70EyecpLSI?=
 =?us-ascii?Q?MESnFvVJygiX58ac/97fFlo+y8aJVsOgRswpz1HV/qNjllOKOa2Vka2nHEoq?=
 =?us-ascii?Q?5ieaj9heUTbAhjC7jWnPz1B8hXawAmkiEh1Lh7jz4GQdn+de/Kk9yFymtQCk?=
 =?us-ascii?Q?9IMZrtXkqCVEAoUhpe5PoVQEtRoECKYECC8EexKbu6aHUR8FhBqavogFOEUO?=
 =?us-ascii?Q?sXR3yNOqM7JsozXEVeOFXkTcZP//tNU5UOLh2x9xOiCtla7zBAf5QfqLzYFx?=
 =?us-ascii?Q?VLPP0chzWVvJqcme7cxWGHwbkkzsZ80OdEN7Bk6aJ1/eLr9QpfsiVPNJTdtA?=
 =?us-ascii?Q?AtqdHF5Pzs9p0kVS08v1dSU/9LaCoZI9bwEC8e7hP3LNK8S+e5ac4xFJa4ZE?=
 =?us-ascii?Q?p3+K8dzXGRVhC59Q1j6FXMfeNcuo2DWA7qurTBC12Va0bkbs9dQe4zbSjQ3j?=
 =?us-ascii?Q?+Ac/3wCuFBcTIKSQycq3tj8zC26yf8u18Itr2PoVldlNZT0uS/Jphj9goQxG?=
 =?us-ascii?Q?OsCAe5JY158y0rjWq6mH2BIxxyG9Fb+tEVytnH7hhn4mWVIjFE4TGYhFSLzG?=
 =?us-ascii?Q?UR8Q4M7WzFUv2Om6WXzAVZRbNrsZwO/ErQoFkT/fZDmgyoNxxK0hCI48sZF1?=
 =?us-ascii?Q?1dK4qOkRs5YV9ZCOYMHJ8CajkIIowbNNpgm/hw3QzWOU5cEoK7VzL7VLzW5E?=
 =?us-ascii?Q?Zc3MWwYLzw1A8qjH04uPcXOkLThg0TYljOtniSMTb1znohzJmv/hKOaHe9WJ?=
 =?us-ascii?Q?bHbGqqf4SzNKbqO+I6hkiq5qGXj/lpvZXo3NxHpkzdrroUXqne0jrOH5rTEJ?=
 =?us-ascii?Q?EjyYFOyejA2hpCwjXbdcHfAcLlS2A83EFUulcmAIotUS8pG1iPYqjOTObICr?=
 =?us-ascii?Q?ekO89nBqTw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae92e02-3cb5-47a4-12fe-08de589e0bd9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:34:56.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9XOi79/w/A8GAPtQ2nL/GCp4GeMo8dAj2oN7AdmWNwbbM+LnmzhqPz0Q91uQM1SJQTnpAFDuZZA8rQO+ilaIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773

Currently, the driver writes the ENET_TDAR register for every XDP frame
to trigger transmit start. Frequent MMIO writes consume more CPU cycles
and may reduce XDP TX performance, so transmit XDP frames in bulk.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index b60c736da027..c927ab5ad8a8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2006,6 +2006,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
 				trace_xdp_exception(ndev, prog, XDP_TX);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
 			}
 			break;
 		default:
@@ -2055,6 +2057,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
+	if (xdp_res & FEC_ENET_XDP_TX)
+		/* Trigger transmission start */
+		fec_txq_trigger_xmit(fep, fep->tx_queue[tx_qid]);
+
 	return pkt_received;
 }
 
@@ -4036,9 +4042,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	txq->bd.cur = bdp;
 
-	/* Trigger transmission start */
-	fec_txq_trigger_xmit(fep, txq);
-
 	return 0;
 }
 
@@ -4088,6 +4091,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 		sent_frames++;
 	}
 
+	if (sent_frames)
+		fec_txq_trigger_xmit(fep, txq);
+
 	__netif_tx_unlock(nq);
 
 	return sent_frames;
-- 
2.34.1

