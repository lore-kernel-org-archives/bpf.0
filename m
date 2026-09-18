Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221554B8260;
	Fri, 18 Sep 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727282; cv=fail; b=rWEHStQor27fWS6tioqRfaPFw80t6+wqbOJz8C+og1x8AwTzctW+ALFx3sk93DD9SlhNHmO/w8f6QRejsCiG3uv5zE8bDY/+iYb6DgFMPcz89QjxhqrmDhmj5avHebOpfksk1DTLrIgikljUbV9ZgZ+9ByqYALO0avk/93nO6DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727282; c=relaxed/simple;
	bh=i5e4X0k80/c2oXVOuRnk9BVbrSAwXartdWC4PtoIt94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chHMrCAslYpe/JoaBdu2FJ9zuSE0rCbnW5JhMjpmqmBxT2WqAefSysBXs+/OizLbwAA28I+enpwz+lVcohOZkwOX7CREUyR85W/SaYIAtDrD1ApEqx6KnLhqL6eG8hZbqv+evJPQMAf2oHCxq6F0Eu9dewl5/y6TXYu0p2Rrzo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nT6uGigX; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nT6uGigX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtXorcjUfqeF1Do6KmOSF0LeIAarYoAEK5BFmQT6sEq2gbcFHWmvcDZ2WLVl7eSpSoMwtsOeeDRNYIz2iJAHSK7SqyxIBtAIiRB+hCBmim6Vtqs2n6br/3TnRBiLqQw0cv4q3YtUV2IJweSNpWCsTheFQ0pD60SNYlUQwjh1lWbQPdtGfYsaY61FYSwF0BRVkpWzh/E8ZRNl9gmtllgtlL/87rWH96wq1OOIINC/IDxfItQcy8jUq+bHChDgSAe9rH2tb7Z7DYrMeLKbVtFFB4LLeGO0+qbQAerUnGkj1TGpkYBPN1IwgWM1sihdFxvJhdX67bTq43Vg79bpStf3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1hHKRgr6ZGR2fBVBBRbv+RT7nII1T2pZjWiW64cWRY=;
 b=iT8q4F40fqkni0vL3hLjKjNkJIVE4xafFJGSN4FG+IvT3KRnkncXwGxK3tLT7F7eAJzcuQ5OP7f2Go6VtLaqSqXW20mYR/NZGV7M195qL6Of0Lz9uQxrMxtbpAikj8HnD/jOAcnu6SxDCixMzn49hVTfhb0KWSuAgT+36ZRdleX0XSVsiFK/hSa8qGBAJa6sVr07CYO13yQ5IA9IfWbIDkyVyLQjZVmHk19hsixeV4YHnaGpLlG8ZdwD2gmWIH0sjOpBjXu2AnXzPhsS4U1TCY+O7drTTcxdHynwhHqazNbFyfW7gZ/GP3Ut/5WojCDb1Yfzs1apnclImvd0xyLeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1hHKRgr6ZGR2fBVBBRbv+RT7nII1T2pZjWiW64cWRY=;
 b=nT6uGigXT5EXDoZr/4CSG1L/trJCrQbg/UQd6Ff68NOGIrmxiEFXdQgz7RHR0zefn/rcAXFqWc1A0Xke9yQbqetJriikOxf/lsiKRAXEBfxpRIULm59zYoUSr8qi0wKAy5UU2ohUjheF3gbJJhKVXyqdP/gcoKHEz8FQB9ym0kjrH4BcNmhLYfyv089ZR1WV4jdq7wxrvuIZIHnZxsKc2YdGo01xhiTq0nOJrrpZ8pO2SVUL1p+KdFo6TnQdtYAySgX6hBZGoEVCUp56fdg9DQ+Jks2fIXZKi8QZLOT1Cca6rIxF8sv494BCOsQlwlD4zguVFY0/1kpzHA1SZDxOHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 10:27:57 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 10:27:57 +0000
Date: Fri, 18 Sep 2026 13:27:53 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
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
	"Y.B. Lu" <yangbo.lu@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 net 1/7] net: enetc: consistenly track dropped frames
 in enetc_xdp_xmit()
Message-ID: <20260918102753.kjxfgmediwq5erba@skbuf>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-2-vladimir.oltean@nxp.com>
 <GV2PR04MB11739B011069410AB4B517A6188B92@GV2PR04MB11739.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB11739B011069410AB4B517A6188B92@GV2PR04MB11739.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VIVP296CA0139.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:359::10) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9f4a18-c1b8-4d6e-0ae1-08df156f8184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|10070799003|4143699003|10067099003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FEHYZwN1G6iKDlbQI6/T9N4KkCjZpZxcv1eU6dkSZIRFYIaneil3O78BKprZNF2kDxGYfLe8XfmHcBQ5I8QZa5vfG3iyB2Xf7wXotpYPEd7C4AawuMfAFWc1/Zst6Bm5WvInLKOvA71Tib4QGp+8hp+trJeARv3/9RVPUExS65t53EubsIaKHPt6N6KpmYHJ5nei9xfU6OLod8H7Jnif+TtU70q9ReKVeJ+ST+YHkcvPT+vJvW7Nl0CWslkGI+B6c8Fs2+dST93lEvaxsOLZcfKFsZBll/lPlp4fb+fj82tB/GFALSenhpAMTBlOjPgLRJ5SCTEOBik75Zeg0RmTMG3hMl6OMRJY92oaFmkx+CyMgqT7ieVes5TQgCyzGhymR9T4MSwaWSv45FlGvNOX4Slsphd3CY9d7RMuXnzy3w54gR78kVQv89kMD+p7t4VsxyPZ3xmrpJBRcRU4/oM+W2KSKDVjmmrGiOa9pwqBUbBrTppHlTjcA8xnbcGYsHM8csOtGF8jKxKO9bC9u2ORVOw4VcBEoABm0KWckzRh0jlTbSaKKaM872qUPgrlbk3VIktYpuWKGCwhM6BlEZ4AJblJnQIgfK4u0kyUPARp7gZvg0cX73wHGuFeRFf5fl9z7451THndDX+xNUCei9Yn5qI4d3nc44oxZgQtuzJtbMk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(10070799003)(4143699003)(10067099003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HDpgM75qazLtCaHBent5o/+ecIi0yNcimfFFHxKsR6jk6+EXm2/lvT2X+qH?=
 =?us-ascii?Q?rQTv1aTZfKo6V+MkAneXkGGvZbSJGQtQcMPFtiKjLIOUcQ1XQRJyrh0Oi+uX?=
 =?us-ascii?Q?3LnH4EY+MqQDscWm1gan+OhJFsYhgMbcaiRWFAFqMWKDn10+tjIzgNfTMHhJ?=
 =?us-ascii?Q?E+bpNYy+vj7s6vYkx/LP4uQAS6u61GzmCulFfZUeYWw1xT+82I1hzYsyeaPI?=
 =?us-ascii?Q?TwF8S6N4Hcza6BwHYlpmbXtkdPGdM+j6nkyXrPMED41n2HaLW9qE3BlPIuIC?=
 =?us-ascii?Q?W3GfeEOISrrKqvmprPUvAPUP3ySQ4L6m3WDYBa8SqfmFt7ektJ9tW0dIH/M5?=
 =?us-ascii?Q?XraVm8CF+71iGe+VAuF4dSgGeBGVLgQdo1Q3U5QziCSmr+H6LARySWNrbUnT?=
 =?us-ascii?Q?D8PI4gUUuGNnCxj95TDPef9mwSQ6UxF7gkuQSVISJvArNjNCI7tb6UlN4eu+?=
 =?us-ascii?Q?tKJxM/8/SzaX+ZlDq9KJyp/o37wrdnbHXyT36sEfjnxlWqGUt0rOG68YDWTW?=
 =?us-ascii?Q?CDpodkug7F9CWiEpMEL4FVKILLMTP7o5GC4R6ojwBlmQ/LWD4aMJaIA7grdX?=
 =?us-ascii?Q?bmrkaPyCZSwoz07xsCS8WU8JOYo8HH/MqPTUSSsCdLx/2rS7z8iSpvCpbua9?=
 =?us-ascii?Q?vblDzEaZlpP9k4l9PrWnV6uoFGM2q+nOT48UcyBPkAtYQwVZu0TuqnQ6qisk?=
 =?us-ascii?Q?YF3IhCWPBJiaoT9/HX0ejr888Q2ve52HGefKw2JDpx2/LNyTZFcgUExXLMTl?=
 =?us-ascii?Q?yyWEfTUAEd7ZgxH/7RIpnltAK5F4hPqjQ+qnfUhiHXM/lZlHJGkEgTkxCjao?=
 =?us-ascii?Q?I1fANAZ2AGeTK5JBY0akWPj27tWcmDkA3AuIDJSatrXDK1wYaF/a2ujz0Zt7?=
 =?us-ascii?Q?Ul+u0JwQdMs5Qnbsk8q0aA2p2/eGx+ZbkxR2a0Q1AiegYRUmxE6e/x+d5izE?=
 =?us-ascii?Q?GT5jVsB26OoPaIhWx+CLFDBgvoTLts5q/mNs8Mtl396NoVIDLBChLBfKYcqK?=
 =?us-ascii?Q?+kN/EjsGkRatgSd7WVuAEcBrRm03gufHiWVdyDeE0pA/2Cm+mFt4G4o1zfYI?=
 =?us-ascii?Q?Vy0zH/JI5er7p1T/ezPWappVYTpFTkniYvYSOxkNl+FpcjXTQ6DRWeAIAydC?=
 =?us-ascii?Q?e9CMedClsXtZZfluHC+wpAdT+7Ts6S8ilEqymKdmkHmecQ74orNdogmgWFZg?=
 =?us-ascii?Q?SL9mrkEyx9MQAy038VIlm0ndge8MyyYHufE8JY6O+rJWk9RzwOEA17Vx3Ie+?=
 =?us-ascii?Q?c8t1tHl+M95GpRwdZ3W71nMrX2nMuUW9DEWq9wpvLSYn9hNofSJCwo671qo5?=
 =?us-ascii?Q?5N0fkaSID7vNERf8J3mv37Vk965ZKpvMP6YQoARLdUDlh+1B5YKqGxaVFOkR?=
 =?us-ascii?Q?tkEjsVwbEYsHKQSlWQvUpilcTmU2YYOUkZXO1RjWwnjHDhPWsuFGvJkvl//c?=
 =?us-ascii?Q?k2YaaTztbZHyC/o1i0E/ZWKlfR4bu/NPml38p8GLdWPg0YuzRCVn8DILCgX+?=
 =?us-ascii?Q?lufVl71pr19Mlw+yB6A5He3ZMiprb3yyVZ8r9WDR7BZz0xryHuGyZfx/RAE5?=
 =?us-ascii?Q?lmhSPx0iRvJLAKjkv2xwVL1Y3BFwZstIxnGVOUczO+MuLX//kb5w0MxlvfHv?=
 =?us-ascii?Q?5XoOsx8WfkcL/xs1Z5vHLjBj+t/ph5Q2T67KAjt13j5nhSCEke8FgM4iPypW?=
 =?us-ascii?Q?B1KhZ408H+xoyi5EeTdhTRCI588IUEKCmbTyfzMKoozK8OdonrjcHHac6QQP?=
 =?us-ascii?Q?eLWC3ga0/4zzB7woZtTCO+Cn7CV6iGqOIYAEcGytnPoNFT8GSkzmGh9HtE0M?=
X-MS-Exchange-AntiSpam-MessageData-1: RaDnngzSun6YISP+I5lFMwpE/4IsKJ2OgY8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f4a18-c1b8-4d6e-0ae1-08df156f8184
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:27:57.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1emmFyhzB+k/vUQqVcgTYHjkmsyN4ywkPHw8LJ4efYx2u4xHHr4+VnFqtLinZlpZfM8W5BdF7K5xty8GSn08Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

On Wed, Sep 16, 2026 at 05:16:28AM +0300, Wei Fang wrote:
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 80f0082f6c63..e7ecdf8ef67c 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -1843,7 +1843,6 @@ int enetc_xdp_xmit(struct net_device *ndev, int
> > num_frames,
> >  			for (i = 0; i < xdp_tx_bd_cnt; i++)
> >  				enetc_unmap_tx_buff(tx_ring,
> >  						    &xdp_redirect_arr[i]);
> > -			tx_ring->stats.xdp_tx_drops++;
> >  			break;
> >  		}
> > 
> > @@ -1854,6 +1853,7 @@ int enetc_xdp_xmit(struct net_device *ndev, int
> > num_frames,
> >  		enetc_update_tx_ring_tail(tx_ring);
> > 
> >  	tx_ring->stats.xdp_tx += xdp_tx_frm_cnt;
> > +	tx_ring->stats.xdp_tx_drops += num_frames - xdp_tx_frm_cnt;
> > 
> >  	enetc_unlock_mdio();
> > 
> > --
> > 2.43.0
> 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>
>

Thanks for the review, but I'm not picking up your tag because I need to
expand the patch to also cover the situation uncovered by Sashiko (the
-ENETDOWN case not incrementing the drop counters).
