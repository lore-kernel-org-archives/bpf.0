Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4424ACC9E;
	Wed, 16 Sep 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552230; cv=fail; b=eEqMboR+LXYaq5Mi305GW0O3QT7Agm0ahfND1gV31O6FOW+6eDpmRNevNH/7fUGS68XnsI8I+mcrJGIUd5Au8Rb4Es6uIXMdcPe6YVD6kxJvwB2FB/tywy7Ym54vFu2oUisDB9a5Id30FLb0bk+QMxf4zzSoi6/AbesGKRs82Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552230; c=relaxed/simple;
	bh=jo5VWYWQfh9X1CmHTV2oq2dQXbnKQcpjWuKaHyZ2Ysc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KS5jZVAAWh2TguagKH2x/DwLEoHCzIKUHyAgL6AgXJdZ3g5uVcAJiaRXMRRKLFGGmxBdUk8vtOe373XpgzwzqhM+iR+KhoWqcCYx12vjJdjNI7eDI98AV7b6u5rheW2ohaXSmE5mMfJb0JlndQcjlRmEO4hPZLznZQ4m4cvOQTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QhEwhFY2; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QhEwhFY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln4IQU2If6MKG6Fyzhn3DHeYGVVzCQ99hZGJOxdGPaXLyXe4ujf0A612dKODvOu6UnMbA51uTxa4IyTQiWUzxRS3SocwlWWPWiXdOFqmQ8cL65BH6X02Ua449Em8eGMehVRXDKZZ2NfwkTvRTjwkt/TP9cHX7WN7w2nEb8VcVJy4Ai6Ijg6nC47+QNzy4r0BE9I0oim6IG4kXwWlLtaUY2T9VbA9T3aJR5F57ZYtTGdps9bWwbRZetIhHpyn5tNC93iPK6xC0Oyx9rlUWZ/kDzU4LBi0Q3MVaaLaCZ1KqNvlnDqdziAKHMqoVHKVe1qdfxPkyi02TjjfvraeNcuXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+ONQNIXnZqEFz0HGqTuJo8oKP1yaa6WikAVQrF15Rg=;
 b=wRpomZqGUdgiec6q07YXt01HwFYm2FnevJ59qiGBE17Wys8DKYS/wjN2lg6qC9+/jQ06fKn8X4vGUj1CZfxnlnU0MvlIrp+DspBbdw972wInXMd+rFsCmXjZqJYn3VMWWR2BLEGuI46n1eEOud+FlzQlToe77V0vXCZJ1yqYcp/28g+WdOvsnjyhyQx6pPpAHEaWrABRHH7bXymGvGV5atUlth6OcZgSlUjkKWy3xoLYJpzu5RCzBTpmkSeOCcjoszVkwq2SEJudC1Rn8459RajKzSKIFF+n9mcXBv0qucjm4pi4sNbZ9vSMzio9ASvyjzrlEtkVBDbfsvy+bbMSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+ONQNIXnZqEFz0HGqTuJo8oKP1yaa6WikAVQrF15Rg=;
 b=QhEwhFY2/VRHkUWWKLqyKB8JHRNlaDNkdqM9pfoO1kBKwDQIf4ZHjfTx2+0AaH6FH9/bxlM+jthrgTCKUhAhsxo0K0qZAQAgIDFPbWtfqI1V4k6iTglPrKyxvYgD6bXkzKvFArRsKZ9QHSAEgLU6yrflS8tO9Qu+9nFRdEa1QwSAWPSOv8bjq67PMXayfSuReGlDWPg5HeuZwal9FQ0yL/A4P7YHR3g+dbobQtKWveb2NElhtM51tMRS9aDUtjYgU99JbbHEmgamPdOSO/sHlipQlqIpycQyiWLHG2KXGYGon4j2ciFNXvQpDKhJ80fflLhOhwtV8BHFuwVWqz9CMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB10140.eurprd04.prod.outlook.com (2603:10a6:800:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 09:50:10 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 09:50:09 +0000
Date: Wed, 16 Sep 2026 12:50:05 +0300
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
Subject: Re: [PATCH v3 net 6/7] net: enetc: linearize PTP event packets with
 one-step TX timestamping
Message-ID: <20260916095005.qe7ka5asu3e526cf@skbuf>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-7-vladimir.oltean@nxp.com>
 <GV2PR04MB1173959323D0661626527F64988B92@GV2PR04MB11739.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB1173959323D0661626527F64988B92@GV2PR04MB11739.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB10140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1719ceb3-d26c-4798-c746-08df13d7e561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|19092799006|366016|376014|7416014|10067099003|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HT0RJPpsYunO0uxoATCVXZ1wSiTCXsDULasDpj/TIWmNTeMMMvB+5XQ0KCk3YxqH6ddYeB4DaivDHIczbsLkA5QCvvf0ABwt2hJ2X2CpRCVzg2Lq5wm99rFOmGVdJWMPleOv2lf9E3Qj2/7Knl1KD4p4rm24xGVQd4dgpVyEo4rBa5QHixpJynWgr4pft2xcLBJRgbp8n2mPqQHxpwZlMmNNacBJYQxJl3zXq4eX/3TkF3EyXOBQAfK61C2VkjPyw/nSSicfO+EducLfwgPI0mhNmSxfX8wlaySx9ckbotOgwOhZU4yqTHetHWAO/E6YX1vHEis+KE5gIT2GPRWPFXh+m0OROrKLWN5IjeTM05E49P8QH3D+1VJ5xHVpeprJy0GKaIFGEa1f7nHuksnh9Azvm4JbUwvY01iqUaNy+s9jjrQ/Xu3mujdLsXMj/S1ZeLYjtGFlTEaSsyDK7qKnoYLZARlaQz5ITGK9ANITLwUQY2HYJVnFfAnZ+xMLxjmYBan6k2+0trrF1JO041DU5+fUBf2uJxdwlWcEuBhuN7+gd1Wre+PsTpsri4SAVHY7Ara0U2Jz6LYtpRHusdlm/ba6qZsP4HjX9BNBdtnoADAybQeYjXS1INrwoPqoW0Tn6YIE+QT7senZG/4QNTFB9mtVY5nlQNbaBJWBQ8klCDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(19092799006)(366016)(376014)(7416014)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JR5r3KUvQ7/r7mWSyuLjqDvNvmm5DHRFhO66KAZ0fJbMDm5V4Aazuvhj2eMv?=
 =?us-ascii?Q?gDtnOueBqnx4Pn40PvhctOMuGlJsh85s7sPBN9BdEmGJNdoJOcs4sqyK8Fy6?=
 =?us-ascii?Q?JPbsC8t45vg3GbQDx6SCkVyCzkKZPLezx+tAp2eAVM3tlqjNCnAG94ANMlEF?=
 =?us-ascii?Q?GJ0vvhZAYEZRVtezo5mS3ZEps7aeRQMl1XiTNaSd60J8g97sYwItyvTb0K89?=
 =?us-ascii?Q?36d/qH8thJfawMkLEco6C6g8cqKgwfdo4f4XNqRrToFWcqPAJDp5SLu2jq7L?=
 =?us-ascii?Q?BV3C5l3r4yZlkLG474hvSELxPDNqrO+bVb/LMA0jEwo/MENf30sR78cyVp2H?=
 =?us-ascii?Q?8oDbTpzfAWMHm/2XPfHWIOS4EuQyjmO1yIVLbr/uzeXNzngBzyeL5YcME7Ag?=
 =?us-ascii?Q?8hqFwHAgi20ffxES5nDOVYlDarZ21De5hD3JfAEaSv1ZiVsU9JEVJJCKxhgP?=
 =?us-ascii?Q?qrYdGGQN1D+ztrvymkHIqd59geow0V67Iwu23cArRjJH6LfWthgDftgU1BvV?=
 =?us-ascii?Q?PJ+ZTMYC2sHLe3Gm5/qAnOwj9Ook34Hid1/Wl3tQAtN04DiH1afzNccv5tuy?=
 =?us-ascii?Q?ABqW8S0hLckM7ANDde+NZU6EG6O3JaEkGAtH2yLcIhvyZaZLyiDnUfaVLmAo?=
 =?us-ascii?Q?fr+yoiULTuHI6nEogKdKu2pwAPv8XW7WEDwU46oiK2BnS1ejPfEKvZ2jUF4f?=
 =?us-ascii?Q?9lP95QkgHKnxoGL7vIiCheMb0TzSHkI5hH0uJVd9qwkWEG68ctpVNcMrHrLc?=
 =?us-ascii?Q?NYqrwAZOMzX0/i7te9MTbj/s7t4a3XbjA8mjXDvRPVR743LuWlnu0aWFNEck?=
 =?us-ascii?Q?WewJtmL5w9Pi032ZG/9b1kqnMxHeN9Fydozj9gnKhALULulMYH84CAIYsv8Y?=
 =?us-ascii?Q?sSGkQG6lGICYBspxUOjRC1IuERXMNpcdDNApPP+Zxr/nA2VGpNqH2hmYqPiX?=
 =?us-ascii?Q?64IzDOIGfzDpqN6+DmDfsTyPe+LBqtkvg8BpA07dDtPd04eUxHVwD4YeLwMl?=
 =?us-ascii?Q?ubZWofs8Y8I2PXxc8yk8GqfSPk36FeDyB+PhU1co1bMJYxpkVSKz2d9VEF5H?=
 =?us-ascii?Q?fsIxvKd9I4aUC6oenlI8rdqies2RD38uu+Oi8+47j32eMSkxxj9bQZRUqidW?=
 =?us-ascii?Q?OSRXBiYlcmBE+3iE8T1wh++2lNrEgUqQPTNZIYoVqGWeEeyibe8XCdD9yWJP?=
 =?us-ascii?Q?NA/lKXnt/XTH5nbe0MzY6CVzuU/9v5aUgXdJf6fXy/z9uNAbMrM3xQxPidH7?=
 =?us-ascii?Q?W0ZVsUsO9UwjBfg9U2phmiR3hNDraTM3RX8QBROxMrw7VVpE5+bO6yMPnLhU?=
 =?us-ascii?Q?ZSi1/JO4Vg46aMqIYiuEWjjm14B0+gHx74F4wWttz0+1sdDgHJfxGHjhfrwz?=
 =?us-ascii?Q?sGyt3CTrgp0FWzpHvGdmyuqqhscUvJ8CxTL6KTr7JNMDKvMCvFmIwFJ1zWtF?=
 =?us-ascii?Q?I+7wM/qBLhUyCXbrk/q5wuFPRb7XLU1iZl+hcyo02yEFXDKy7rrJxNa/QCQ4?=
 =?us-ascii?Q?5B+uGLexhRjw2ZXV/paqA88EmoWBD680hrc5jlq1pKA1dyl6mxJpd+OdugYV?=
 =?us-ascii?Q?Q1yf8h9oMbzG6QPFvMOjli6Ybiw4puMdyDgRixwQiQZcfSWBkbstKjO51Nav?=
 =?us-ascii?Q?ZeloIjvSTl26dCcToUjaRPqaBhXjmFIm4fCCR6IrR2CFS4igPLpCg6o4fr5v?=
 =?us-ascii?Q?ni/0qgYSlpmAmmC9eC4UpMCnfAn1AjKEfAMiMaYuq+SX4LAIDoLaoqWfhfe2?=
 =?us-ascii?Q?qT6iO8yppV2Oi0rXRFdV/NHunSm+CRACheydAH+BFuXT2JP8Yk9jw5ha2Sjr?=
X-MS-Exchange-AntiSpam-MessageData-1: 7PeFM6qBS3tFbmBYvsqkcIC2fIcFVSoq0F0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1719ceb3-d26c-4798-c746-08df13d7e561
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:50:09.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ7RziUxTZuJc4szpUcjbc5TFAhjuREplTxUzIKBEg5T4cWoV+r1caCprgmFmoAoTB5ZaflHcdS7zsvbQ6I+OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10140

On Wed, Sep 16, 2026 at 04:59:47AM +0300, Wei Fang wrote:
> > ---
> > v2->v3:
> > - replace skb_linearize() with skb_linearize_cow(),
> 
> This is not true, this patch still use skb_linearize().

Yeah, sorry, I ran a bunch of tests in 'git rebase -i' to reproduce the
issues with this patch unapplied (this is why it's reordered to 6/7 in
this series while it was 2/6 in the previous one), and I then updated
the commit message with the conclusions, but apparently forgot to fold
the actual code change as well :-/

I'll make this change together with other feedback for v4.

Thanks for noticing.
