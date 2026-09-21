Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395748986E;
	Mon, 21 Sep 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990199; cv=fail; b=b6r59AP5DtIzjucgDEqnb3GxuRjFWiUIrXJUPbO/ZtRmZtG07/+C4wPhZ9/UDRiPeuIUMkam9vqHEKPTffkDr5b+DCgxcs0hHbKoCPv/jJQfqglnLn0d+qCfjVSq35cHG4cOI3WpFl7xmSvz+Incji1y29nDPgpPztlKovx8lYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990199; c=relaxed/simple;
	bh=xX22YuXjqr98aFI3s13sWdMIlR83n7aG7glnehC+Ak8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u1Nh0C9nUZUp371+DehABWkGbJJ16EREuq+sEh/a0KtEP6L3Xp0aNbqOARyeagZ1czftNiiv61D8plR3NuJg89T2yOu+vstythiN3tZEoRsn75mysy3CvZSyxU9IRvsU/2ILGS4qQ8PmfM+OH0pgjBqepPWW8AxaVXroeviuP/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B+vtpJEt; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B+vtpJEt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NY/AUOqGCKdP9xLxbP1D54Wyl5zz61Hjv+GhYDMJgHA3/3BMTLWMUEZNyb/UqaIl4ip9MqjHnBnvr/TLiOeobUFnw3gH5kiO/alFKGYflHKgDr4uObLlQ1280mY4ESArtOMkFNT4+QZUQAzdVxugXz+Tt5LbngY7GK5X0muFCg2Hkn7JiPXP4paIluBdbJA9Dk0SHVX6d08okDvgZPChBEqK3Oc/dLmOZq+TWi0g2N++nNGa5jkry9nsTx+vPYPis5/XHmrZ+9sqv0l2agAyl+BXwIS3A9amDGFPuwOimIlTVuGx4rwWH7rQgpXKUvTQM+ooa2WDlgzn10PY7OnfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvL7BG05ZeRq1GFvVRMx2BzjsZDoy573dvUJqt8HDtc=;
 b=nZJAuF+3oARjZmC2LZ/6MlxRGEggYzEgILsRdq0NDraThoQOwTBG8W4x67vltYyfFrK8hK02Tyq7+yg51OIyeUTNNEWZ3/hdF0a2ZRJC9fyZHmBgn6DkQsjm15GH8PkAPscp5qL2PjSj+9SypWboJqYmXYGzQybrVc2uTPKxtozDqPfYsNg3yQl+GMKHlf1P2GOgO6l+hlG2vI3xx3zlZ8I2g4nPongyDsSESMkX6PA07OaSfszy4cTK7EzkRphwugMhsn1M14HO1JMBaSW95k31NrA73bod4jNQwBHzatGFm/hTEHlL3s+S9mufe+FbAJQSYRGI179O0Es1xN0L7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvL7BG05ZeRq1GFvVRMx2BzjsZDoy573dvUJqt8HDtc=;
 b=B+vtpJEtT8ONeS4s9c9WCeqFtK7RR/aiN2lZX5oTxUpxdJBnKAiyC8PpfQeguCK1fi0A8Pfu+jeR1B1TyFhl6MohSUm+gOldq53gRCAVgRVdx386ESOEU4icuWdyGsFh62WKWsLQC/n1r8BLiamy4uEbafBtE7iGy6tjcoO0aEzPtamPyF9ErPUyIqHwS55jpSCX+k5M2eNN0SWvdvjVfLTT1XsshnTiKH9HjibN/K6zER6UbsTqKLJzOzl9+OqVHuaGcCG0j8g9MpaYUj2A3C8EZxknOR/wgtHrg0ueCMbJiYQIfyWRv8lQzq3Vx7USTql7n4slETF0CheTWmeAbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AMBPR04MB11811.eurprd04.prod.outlook.com (2603:10a6:20b:6f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:29:50 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:29:50 +0000
Date: Mon, 21 Sep 2026 14:29:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net 4/7] net: enetc: pad short frames in software
Message-ID: <20260921112946.edo5uw6cl7jx6oez@skbuf>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-5-vladimir.oltean@nxp.com>
 <20260917111127.577d344b@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917111127.577d344b@pumpkin>
X-ClientProxiedBy: WA1PEPF00005B7F.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::607) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AMBPR04MB11811:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a4183a-9305-40de-bcfe-08df17d3a60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|1800799024|366016|10070799003|11063799006|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pWOhlHDc+yMm8PVaWo7yRVtuZk9mO7yJ6x9JRa95TQom344WomSMeUFPpt3LrsumPapZclowoQ/XATyPGhleAIcOTHFErNPbmh9zVuPjeIeuxSk5eEAlk9djYPElmUpt+gV8NBnc5k0ESraRxhTdhQaMV9QYrCpxRMtB01QDvxN09nKNgIa+6h6VYNfaY+joH4CyTggi4n6grgQx+Hw2TeQAVhR6U+8h2vX8d9lw01llSdkIz8jz2rzD3OXmVCpP8U15LsNOJg5C1Ihh0KfjfkVyQjmYh11DG4nQ6I4dBNslrs4iaydDzeQo22xAIYKKho39F79oaehn1huSSWqgUB+KOWZEC1rZmNclqRu822UuB1nupAPPCokLiexXwd0YdFnt4TNkPJtsZ4IMEjEkSFIiQtb96jiQ49SPHMcAhA4wtrnz7bUN/7xS9yBl4o3hVLG/60xQfquFCZOv4gqCeB6MWRNU8w2VehFBkyLLbpYjfMFeTUQKhUcMP5H/WPt9hkvnnt43Jd2OXXsWfoNQI+RLCYTSgnN2mtiJe3V7J6M3xPklSqjAs5wXFEaAl41X6OikDIsEe/bZyjUYtyFd1JvvCgYSen9aWUkTLxRLePbdXblkuqG5kwVSZ5TqA5JC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(1800799024)(366016)(10070799003)(11063799006)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/chdVW1XdAA3etp0WF5WrQOiuSHgpFBqz3E79BRcc2SjXasWQIq4r70ee82F?=
 =?us-ascii?Q?XQ4Mg+jVOcNH5exR8x+z5hTMQPYPVWAqx7P8THF4tM7yGxflyZJAyyqFBBCm?=
 =?us-ascii?Q?OF5MLLxRsLZCbtuwyYubFiCyKw+ni1FFym6FnbN1P4+j91+6VeRHHM6Z2rAa?=
 =?us-ascii?Q?GobNWB8oBUgzRhIb4TbWv880f6UXwqAjLeCo/7C7fVYXGtkECv2Lvkncxyep?=
 =?us-ascii?Q?ni4hCEV+jrIPD1woyVT1VQ/Bi4Kxj5zQuTTUvNm9RgbQntuWbal3D1GZF7rX?=
 =?us-ascii?Q?7LNQzoSSMgRE0+NrKFgtQv1sXsMmzuT6kELcCXmC/1CDU/i72L4cwIBPp8Va?=
 =?us-ascii?Q?Zga25kymxa1W5/wYz08qWMIoJRMgXx0fYE+WJRss+YYJvHXBHn3FnYQhiTwt?=
 =?us-ascii?Q?VkRRvNtW19KlXsigbdron9HPiDPHFIzc2olpQQPzKzJdl1wXijD5OJGGILkh?=
 =?us-ascii?Q?wNjqq1iqWTv0SUXAF3K8UPsNAEHfKH+1WFhJ+UgHc6NMrNnKJlQYizwgGchI?=
 =?us-ascii?Q?hgRPMkH5aqNY6VbbFngZH2/TMtFK9Q863sbZe/odcmt3ob8/svvwpV533748?=
 =?us-ascii?Q?GegYqyooglJR0BBYqBpCtgCtHbm/zYVMQISDVNH+A2QJtePNLQK2Xy940hzt?=
 =?us-ascii?Q?9Vg75Lb3Vi29OcRgcjP4xVvegItZK8OSgfqMj87k8Nv12ilJr2hazd41llZv?=
 =?us-ascii?Q?Ri6UoDhq+MZHE6u8G59iiwaTGZMM6sPWZy+IlHD2qpQ5+5ixKBSMrM6vjEwg?=
 =?us-ascii?Q?y39RYHDqVrus7Oti6C9qCp9I+9HDNCxgeGoJf/1LIMtmoIH4YKUd/CBP/xcX?=
 =?us-ascii?Q?ougZ6hsGSj2pQYMIJp9Kc67EjSBtuoWQqmRovkrWqrjbB6mwSftDyj0iD1da?=
 =?us-ascii?Q?BkykulX39KBXVxwDII+PhEGLGeOKgkPyUFG9saHnsofehxBi+pvNlrZJ62UF?=
 =?us-ascii?Q?FxXyktHNc1f3si6wTA9NfNTGHHrJ6g/kq10t90rw/V4P5UIvDWHUYw/jeypn?=
 =?us-ascii?Q?Pd/t4Y7uEODpFRJQ8YP7/G5hS+xKU52+2Cmm0VT7SinGbwWk09rZzMGe+20h?=
 =?us-ascii?Q?aRgnAzSmI9l0bhuvtwNx9cr2uhuhzlOZ9FwNiiPfHFN9yGsxSsRW7yL0u9Dg?=
 =?us-ascii?Q?LxLEzqxW96MaPRKaE6qm1oKjKGmJuv8cGeVzKgnFxgMnG1o/iSvTESOGwNQR?=
 =?us-ascii?Q?KEy8Gm3FnuQfGf0EzkR5dXKNVUy7DBVumY0tQurSGmc17gR9saXAyYkx5Smj?=
 =?us-ascii?Q?X7tnKyywEQ2NmH9pB6yS8U1YQG4/kDRNVQWY7uhSjSjAi10ImnkIabWTyBEN?=
 =?us-ascii?Q?Zuyt5QmZ+8nceyboTJUl9ypWg+1u+MSPc+Ppjn1q2a/yufPKumcNfGlgJByE?=
 =?us-ascii?Q?pDJCRnxAfBw3CGN+OWUNSnteT+hhkSmp++ZCa9flbNBUkE8KM13F7WVVS5FY?=
 =?us-ascii?Q?TLhS8dVJQNfT46bmRlqj0/akY0SQzcldvwEIx9kdHFyrgcEkNAMi3eDj4mNQ?=
 =?us-ascii?Q?n/dotnvYJK24vyUnNexQPqGeyYrwvw3/lhK+RWyiBMmcaOPDFC2bqsp5q0xx?=
 =?us-ascii?Q?M9fV9VLCRHcsHR/sd+DJwsXV21p266WJMI+VaN2P5sL2xVw4LVsTAoQd20kW?=
 =?us-ascii?Q?qwnuh5ukqH9DbYvZsGT4DAx6EV8zDCAZnTk8FLn+ORBsC+OFm1a3Vn9QOGDd?=
 =?us-ascii?Q?cr+JNR7CIr+3vluZxD115wppPrBfubK+bf0rriH9o3N0gRc6tF/CZ8fPRdHp?=
 =?us-ascii?Q?iQPgiAAFUS7gElp5PD4+UnSaonXW3WV1OMIbD8sfd+GzNjDmxa3SfIlMntJD?=
X-MS-Exchange-AntiSpam-MessageData-1: 4FoMVe6u4vGjOUWA6z1VMwItQ7Qtqm3y2Hw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a4183a-9305-40de-bcfe-08df17d3a60b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:29:50.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVDwxNvhmbCGMrFMcqYxiMBx48d+MmzhPog34XbSBymvyJRI3353/Xjp806KjP8NwxRrVJNHOeS1SYOJ4LW0Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11811

On Thu, Sep 17, 2026 at 11:11:27AM +0100, David Laight wrote:
> On Wed, 16 Sep 2026 01:27:31 +0300
> vladimir.oltean@nxp.com wrote:
> 
> > The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
> > less than 16. This is written in the reference manual of all SoCs
> > supported by the driver: LS1028A, i.MX943, i.MX95 etc.
> >
> >   Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
> >   0-15 bytes are not supported.
> >   (...)
> >   The first descriptor in a chain must not have a BUFF_LEN that is less
> >   than 16 bytes.
> >
> > I don't think proper attention was paid to this during development, we
> > found the text at the end of a bug investigation. Therefore, the driver
> > does not enforce this.
> >
> > But the frame length is out of the driver's control, and the network
> > stack can actually send packets with skb->len smaller than that. The
> > result is unpleasant, as will be explained below, so for simplicity
> > sake, we just pad anything shorter than ETH_ZLEN.
> >
> > Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
> > through ENETC would soft-lockup the host through an IRQ storm. He later
> > distilled this into a small enetc-killer.c user space program which
> > sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
> > length) through an AF_PACKET raw socket.
> >
> > The IRQ storm is actually a curious effect of a chain of events.
> >
> > The hardware behaviour, when an invalid BD is put in its TX ring, is
> > that it would transmit the packet as normal, update counters, raise
> > completion interrupt as normal, but it would just not advance the
> > consumer index of the ring (TBaCIR) to signify that the BD has been
> > consumed and is available for software to free. The ring will also get
> > its TBaSR[BUSY] bit persistently set to 1 afterwards.
> >
> > It deserves an explanation why the behaviour above would lead to an
> > IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
> > unhandled interrupt would typically just be lost rather than retrigger
> > itself as a wired interrupt would.
> >
> > NAPI processing in ENETC has 3 steps:
> >
> > I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
> >    softirq processing to the 'pending' state.
> >
> > II. the enetc_poll() softirq handler for the IRQ vector walks through
> >     the TX rings affine to that vector, checks which ones have a TBCIR
> >     updated since last time - enetc_bd_ready_count() - processes those
> >     completed frames, and clears pending interrupts in these updated TX
> >     rings by writing to TBaIDR. (I've excluded RX processing due to it
> >     being irrelevant).
> >
> > III. After the softirq handler does its round of checking all RX and TX
> >      rings for updates, it re-enables all interrupts in RBaIER and
> >      TBaIER that were previously disabled by the hardirq handler, and
> >      exits.
> >
> > Because the TX ring with the short frame is skipped at step II (TBCIR
> > wasn't updated as part of HW malfunction), its pending IRQ is not
> > cleared in TBaIDR by enetc_clean_tx_ring().
> >
> > But because enetc_msix() disables TBaIER at step I and re-enables it at
> > step III, another MSI will be fired upon re-enabling it. This is what
> > completes the cycle and the driver goes back to step I.
> >
> > So the driver misinterprets the mixed signals it's getting from the
> > hardware, and ends up causing a software-amplified IRQ storm.
> >
> > Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> > Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> > Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/
> > Tested-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> > Reviewed-by: Wei Fang <wei.fang@nxp.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > v1->v3: none
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 13 +++++++++++++
> >  drivers/net/ethernet/freescale/enetc/enetc.h |  2 ++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 0216f7d08e19..bbad942041f5 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -1077,6 +1077,19 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
> >       u8 udp, msgtype, twostep;
> >       u16 offset1, offset2;
> >
> > +     /* Hardware does not support transmit buffer descriptors with a total
> > +      * length of less than 16 bytes, or a first buffer size of less than
> > +      * 16 bytes.
> > +      */
> > +     if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
> > +                  skb_linearize(skb))) {
> 
> Isn't it only necessary to pull a few bytes into the linear region?

It looks like pskb_may_pull() is an adequate improvement over
skb_linearize(), so I'll use that, thanks.

> > +             dev_kfree_skb_any(skb);
> > +             return NETDEV_TX_OK;
> > +     }
> > +
> > +     if (eth_skb_pad(skb))
> > +             return NETDEV_TX_OK;
> 
> That could be inside the (skb_headlen(skb) < ENETC_MIN_BUFF_SIZE) test.

There was an undocumented reason why it's done unconditionally for any
packet < ETH_ZLEN and not just < ENETC_MIN_BUFF_SIZE. It is to avoid a
separate potential erratum. I'll make sure to mention that in the commit
message.
