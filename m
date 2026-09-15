Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59F4BD79B;
	Tue, 15 Sep 2026 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511281; cv=fail; b=FD4Qvp2Knd7e1sJvbTwT++uLRqfvpxe+sf9r0ynbzA4lPVpp0An5mGIZqfOv9JYVZdIAErD+ph0kyH/XUyYgtBedgSSprWoc+GjRyR9UNoYMSguu0zQvQZT1LQAPqWccgW+1pumG8lOi1u0yCJFjIZ8NL0AsHk+w+f/bBuVxbgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511281; c=relaxed/simple;
	bh=+A6+qn8lFqpEXTIC0vRs6hYvfxyc87CqMpqJ48xYKiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NauaK15kHHapQtm/m4x5c6mP4MGw6Je6j2Y/lpeQq7Q7j49H65plpYxO9AIrxPlQEMpuDQY02bNyOWUovCNND0jHtBAc7qzdA0ZQEhGIFv/ev+ubU+x4MZ6rAJb9IQE11okyATlhdW3B0nzZgs6Vw4aS6SoQ9ERj1xqoiL8UvcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VeSRO4Nl; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VeSRO4Nl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiNiNd4z92bjxTdyTWCSVN/Lu6BipXnfLjWINdZQfPs7VVwk9mgX4C4RSAC3WpxPcrSFy8iIA9mk9aVOYrF6Hb7b6AV3ujRmbpDfaLgIU8+TDguiw5e46mDJP1Kjj/h8/UUFUKs62K8biV9uFhtxkU4vvn8LIoM6OhQxCjqjhbDFNtsvctCPaEzwz0FElVGK39pNJIM6+1w2YxW/+V3j+U/IyP1pWvwFAbejGJW5INej6DqUyXhMkFSmxB5ujkqLuQydzfdYbgpru8MH+4qA8H6AWn7CjcOmnrf60hMcxSbwLBE4NZmwPyUR0coOAiGcCMeu1YuRuoDKpKx9jf8TDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqEr2OuKigcHCvTxoki228jJPC0WZty4KscNXq5bJTI=;
 b=FE0JutKwL9RpaVAytkYgKNYYcwRg4GBqb1EG7dennCYsdFyZYQPSlRc7vKX/2qfwreziuTQDWgJj0yqLq4KsTZyX7HYt43csthzFzF/AeE9DwMPHDsFN+k8tBgbBpei0yhIC8fkketXzVF4s8l+2RGxwGdhaQZQ4bbRl4I4TyASuI6qjnFzKIuYFCqI+e6cFaFqMWyuj7pxrLhXe93hw9oPSAuvsvJbQlQIRD15Q8K/3CpazMWGYW5eVjYNAjxzT0ZuN/p6j5Fbl9XinsdpTI4S1ae3KpoI+6outVOH3zZ29Vr4yvdiT7LCtD8LExudbC7W2KZqcb+qnQL4OBDBrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqEr2OuKigcHCvTxoki228jJPC0WZty4KscNXq5bJTI=;
 b=VeSRO4NlYTJSfXknQWn7VGHgRy/7NAg/77hwrYbBxWc1myzPkUy4JgGd9DLD6kBs5J9lFRCVDw+pivSDTO32ZlkI8MdC3zC/2EH37D/P3UuGrM1/PNGd5UHk8SX21QvF2PYSG3mn/rNTe5YY3b7VcfNE3kJDDT8YHV7+AwzXAKAJYORBxhErezfLbpvxSYYxIde+ZLQFQCd2jUrOsLqRtQGs9wC4MDwKOcak7jlAdq+HIOFIMxgDIykZVcCNFtE2dhkZXFoIR+ZR2PG7PrT+Uvg0M1kPw2ADriSYzf1wCFANejj1SPdCE3NPsTZ1jl8THGypSp04PuPeKEgEWdhdtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 22:27:50 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 22:27:49 +0000
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
Subject: [PATCH v3 net 7/7] net: enetc: drain and cancel one-step TX tstamp queue when going down
Date: Wed, 16 Sep 2026 01:27:34 +0300
Message-ID: <20260915222735.1016937-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::19) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DB9PR04MB9380:EE_
X-MS-Office365-Filtering-Correlation-Id: e26e8598-e198-4863-49c1-08df1378933b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|6133799003|18002099003|22082099003|10067099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VkHUlRwVRPAKsoBsjeZ3nfaPezizMstXjJWs4mpBdEvDls2SGLojEcbTdLmOG19rNo6945luTh6CIy5gmmEekA9m9fFDLO1IEVD1atE7LeKaegCArxEyk+/H3cecx6lAEIzT7LGIq5fkGrzHTMywru85W/E7AUipNKIkydIpWbTuToD98dUw7R8dwanUiNKzlg8+Q/agWf8zg+4J9ReOcLpNGv3Q13XQPlfp4tqMXI/5MU9ozrJs4k5Fxi6B0ZtZGQRCrz3ntEcG5yPNFEfZcm0157mDPpzoR6oOlkyjJC5noMwNo+nw24TOZJszAzSw/Z3aCo/pLKRMUQG/VSTgx+kxcQ1QVk7wYHMSo1RLfXrl5evd1TydZCHFOAekohVcoIvUE+27tR41IYwWhI6bFP6Wy4Ez9AV02MaYfQE22aBBkO5Kswvqy5sE5iukuyruAIyIaEEfLgW9LTgbHspGlFWqXsqLCOQYNLiQ8mOgLF1SA/bW59iE/UiVYBALKbABKWzIXQA0Ub8chhH/cArf7G6nkd4kM3VJeNzYyTHf7Gmqy/dldkOezLRsBF3DZ4ElsE5foHqVYaCPWvvAiEn5U97gE0PpaEvwrK6kgeyUWIimMnkG6RRviezgoXGPeplKfAZO6PMOdPybhHmpuvRU96TY3iIDRWxlrPBdV7infxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?toaOoJVJE3W9YYQIGxKwJIdNAB24oM/fC3HcAc8Og/UgvBIkLYTWbWtBz1YA?=
 =?us-ascii?Q?PLSE6gDvAqdt6qB9tlRg/ggrSmddJaiv4T0ko3X0/Acec15kgUOB1OIMvwf1?=
 =?us-ascii?Q?yxJUMaIunBNIpmI4tfnko4T6ifUxBXuE4dUcBkl+tH9DGGwqUpy4pL0cXqzN?=
 =?us-ascii?Q?Pa46nGK/qfMlV/xbJro+3dxCybSviyCnv6Tg97lS/CBufF5vDlcNMLQCPnIY?=
 =?us-ascii?Q?VC+e75zQJkKCkKidODvPwJydr8D4Dry/X1wvwYcNz++z2BBqh5YDbGorfIMi?=
 =?us-ascii?Q?J7FWnobprjyJFHyfcD3hz6WK3QRrhZ9Er/NCrbICXjSMnLgL7+LHO0Lz+K9H?=
 =?us-ascii?Q?kAoOj+R/I+hzMLE2kWjiHb8BntKQRuIkFxqPE9++Ih397sqBj07hWj4ltfSX?=
 =?us-ascii?Q?Y+nWtxgKW+MZgiklK1bzBz6YOISVlEbrrvHpVxHomWqV1ev245fli7Fe24LI?=
 =?us-ascii?Q?N/oiOa+4Hryod2HJtIg2HeapFhWzHJdQVN3zpN5n9HJYp2qHsUtWPItI7brq?=
 =?us-ascii?Q?Hx4Ctvak/cF+X+2rKns4orbpAh+/eJ9FTk1nw5vRxvv+uqPdLtkFWM1c4BSY?=
 =?us-ascii?Q?EtddVMATlMD7r35XDqg9qCwrPIjOmPr1PFmFXSs4FzaMMT/mddNhV23AeciD?=
 =?us-ascii?Q?nvPbk+Tfy1PrVj3Q4w/hnA3rquZjyBapuXaV3UnlxyjL6O7YLPqjituFJx8Q?=
 =?us-ascii?Q?NKMCCi93usXcf1jy4CJnKTe397wWKXNF90uoT37V6xw/3WjH1tt3g1Jwc6Ea?=
 =?us-ascii?Q?ZHnJcSa8h7wRpxt5z6hJzByQRPRxfUz9+bGK+cwLE0CwVi5nkzFK7ZVt5Zuy?=
 =?us-ascii?Q?CE6Sf5fluolPyniwkUxR7h3KVsGWJK42q7iorQfgwqPMnMwKzP1mPFSl9sfl?=
 =?us-ascii?Q?ZcwhsCrpniEflCesQmDMxrm/rM7fI/qXvN9CIYyGiS9FNYYRGMWlbtH6cGAs?=
 =?us-ascii?Q?mvi0mspRphYvF2vF8fcNtHas9O3OBHMAHJksOq34OTRi6taMYm8Y1G6rT1cC?=
 =?us-ascii?Q?TrxAk8qGgYXdswuuKa1SJLH7SOcYXcEwyJ3o1lurKptzjkJL7ipDJ4g/duO2?=
 =?us-ascii?Q?tjpjnxdl92X2NFtw+5Pa3iLJ4aa4mbcZoH/tOGIUSahbiIPbVf7uuPu7g2Yx?=
 =?us-ascii?Q?yf2kXASPOhr2X0ApFvycMO1ir9mDQ94l5bhadeUc0uS2q6viuOuJUrBvKimb?=
 =?us-ascii?Q?QzSuO5tiRUJiNl9WHQ7xWnhiKMYBN95EdcqJeDrpc3X+cn20kpKKCgJwBedU?=
 =?us-ascii?Q?XHcHgZcdOy6xgav7jZuJSGSo66ObGmf38hgvbNuqqJOUV4o2FksHZUpZZcAy?=
 =?us-ascii?Q?ZoEnXZyrc/tKxJ8VLse4oXtsnwhJzzRCkdfqK8aBL5rtJHIjWGMHPDMK/USr?=
 =?us-ascii?Q?x2QC9GgntvhSXrcXPHEZnNSnGx3fTKeupVXXoiExkSiLvTBvAaHFcDnNfBD2?=
 =?us-ascii?Q?nf5G+WwH/DDl7azf+XxWGTvxEsC5lm5M3rmO056ZzEg6d9sL0RRCWzLrKuXN?=
 =?us-ascii?Q?AK2e9y0+lhKXjLYnVvpGdoBKykDOI5pyeDIJN3f+NDPiYjk1/polgy1HuDSB?=
 =?us-ascii?Q?oiRcKBRjmQ4pWZ3nFMBck/nLGNiQA8UkP7M9dATed3jdPBTN/EBgoBCPIG0/?=
 =?us-ascii?Q?9tfbdqc53AQ8Lgn7Jm6IyCH9LP+6hXpftjrbbd3CFUTZz31ZIthwTOjJqNcU?=
 =?us-ascii?Q?WfgW7bFVDo1mclSeA7q5PMLrV3LKxaoWrcBeQXiVuBoQqfZXKFqGcjIKSilW?=
 =?us-ascii?Q?8TUGTX6bCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26e8598-e198-4863-49c1-08df1378933b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 22:27:49.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt9zMySilmP/bFFIbQlNloWu98PUiM0YWs3jsioTb5GLXdCGFowGAKFau+LkzQEfHw+lqItN/EKKs0yB+TcG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380

The driver uses a work item on the system workqueue
(priv->tx_onestep_tstamp) for deferred transmission of packets with
one-step TX timestamping requests. The reason is that the MAC supports
a single such packet in flight, but we cannot block the rate at which
user space enqueues them.

The problem is that the skb queue is never explicitly drained, and it
can hold packets even after the interface goes down or (worse) the
driver is unbound from the device. Especially the last point is
critical, because the work item will attempt to use freed data
structures of the netdev.

The priv->tx_onestep_tstamp work item (enetc_tx_onestep_tstamp)
processes one item from the priv->tx_skbs queue at a time, and gets
rescheduled on each one-step PTP packet TX completion.

If we cancelled the work item while NAPI was still enabled, there would
be no guarantee that NAPI would not reenable it. So the cancellation
needs to be after napi_disable().

Cancelling the work item waits for enetc_tx_onestep_tstamp() to finish
sending the current packet if already scheduled. The packet will be put
in the disabled TX BD ring, where nothing will happen with it until
enetc_free_rxtx_rings() later reclaims its memory (*).

However, priv->tx_skbs may contain more packets than just this one, and
because NAPI is disabled, enetc_clean_tx_ring() is unable to take care
of the rest. So we still have to clean up the remainder from the queue
and reset the ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS flag back for use.

On driver unbind, the problem should be solved by virtue of the fact
that unregister_netdev() calls netif_close_many() and that triggers this
same code path.

(*) Even if we add a check for ENETC_TX_DOWN in enetc_tx_onestep_tstamp(),
it is unavoidable that racing one-step PTP packets will be enqueued in a
disabled TX ring. This is because the work item runs asynchronously and
can miss that flag getting set. Think below:

CPU A                                CPU B
enetc_tx_onestep_tstamp()
-> test_bit(ENETC_TX_DOWN)
   // says not down
                                     enetc_stop()
                                     -> set_bit(ENETC_TX_DOWN)
                                     -> enetc_wait_bdrs()
                                        // waits for the BDs in the
                                        // ring to be transmitted,
                                        // but the PTP frame is
                                        // still queued in software
                                     -> enetc_disable_tx_bdrs()
-> enetc_start_xmit()

So I don't see any point in adding an ENETC_TX_DOWN test in the work
item.

Fixes: 7294380c5211 ("enetc: support PTP Sync packet one-step timestamping")
Reported-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 62cdcaab3f3f..892490ff1ebe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3110,6 +3110,10 @@ void enetc_stop(struct net_device *ndev)
 		napi_disable(&priv->int_vector[i]->napi);
 	}
 
+	cancel_work_sync(&priv->tx_onestep_tstamp);
+	skb_queue_purge(&priv->tx_skbs);
+	clear_bit_unlock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS, &priv->flags);
+
 	enetc_clear_interrupts(priv);
 }
 EXPORT_SYMBOL_GPL(enetc_stop);
-- 
2.43.0

