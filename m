Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2F426432;
	Mon, 10 Aug 2026 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375429; cv=fail; b=UOXuN/UMXeVU89bkWNc71d0lgqacpavtb61fw0ENMg5pZHjCuBZhZTGOpMp2LKr7fDz2k5/VweB2e5RR5a4/tAhKTql7KhFEP2mPiveLYbBPA3OxbLPRkMoz+H1xXTVYaXHj8xXVGi8GPNZuwYhAQH/IrSNKIOWDvpMbEK+eFlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375429; c=relaxed/simple;
	bh=YSnfFQ3CfkrKytLR10hBQTdbKbHoTmAJDXts5TIoN7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gfsdplAMQt5mWsZ2GWGHmaF9puNJV5pa1m0Vw5kLGUcijo+mLdiIiW43OYchUUhxCaxSFGGz/lYZO57YB9ITQslOq33j6yPFsfWsPLHjYC+Xc1YSK0CEdbMc/ZZ4gls1jfCI6ZqqgtVPEKl+Nfq8vSrpUM6ALOhQinVOdryJ6WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPSoXJ4J; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPSoXJ4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBDemz6HV7IsXovC7oPx7+fpINZWRqNtJvonkyKFMycFrfccxOwILqbtriY2elaetyaXgSXcAZ09CISeqqpoi+IEhQizlyENDCeZ2XqnP3ylkjjkuJ67IlUJ3BkPAteg2DUNaSrUK1Rm8g1Hx5Nvj4DIjxCzKJ8+N+Saa/+aPi6PrGgdGRnEY91yMm/e69GUddQhIp2UfFb8CR78B0J8qYMb4Q7b2oMLx9bdlJUHHCfX+fW3DsB9EYGIK47mNc1cPEhVvlowM3dOlyQoL0+hAMnKq3C0E0eEID1+dBQIzRZE0THjK1x35UMLSPG4U3j3lVHIJrzdGiiWM8yqguF0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZCe7Hyx7p051/Ar4NI5Ht8HTiVL6KBte0z5f/zNIXw=;
 b=D6t/Drcxwo5u+2w58YlxF2HS28cZbbAuj5EukGQY9l2DcYEFDeL33M9WB4OkXpav7MPX+wQRdIe9m4JUmP7unseFINlzBdN8grwrujaiz93LQQgRdHDEXTUMYKy7dS/i8aDM2myw+5mLfzXCQucpuue5pnog/NRT231hWycSO1Sq5HV5+AJ05OlWuToj8ysbSWb2grwdxcwtBS6gWVEkH8gGGh+vMYVOTlZQ00sZsch1Ao7QPGq+/YbBTv8z6Mk+GvIVNrL7d55x5ncMrgxh13nmgs1xxWo/UX1PSHLlGrOpljm23uYcyAcckCZKMkHBMr0CMCjlXlrD1OAVibDG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZCe7Hyx7p051/Ar4NI5Ht8HTiVL6KBte0z5f/zNIXw=;
 b=pPSoXJ4JF7SCE5WyPKtMtfFGeY0QN12WbC4zDpg/Y4/WQesfAou/MV0wMBzWTvHICEgl9EU5l/TbyAPteoMqFnpQcl3yS0GloCTxQpPm6MTuIKK7FjMtGQBbPA8CCckLjaGmS+Hxzu83vklE84UmGAMuKaaefCef1jzmduZkpK1V0gpUHisQn5n1CY1OlA6mnTlDQk/hmGoTv9PwOcgVZRfEue5f8ji9b662AoEEHxUJB3zMoNU3lVxnjXtRBFeHCpe0FuQCSrIdV24PZyG4uMbVUOsMN99gfvbK0Yv1lMU1vO5VqofM8cC91+q72z6FIutXDzcItinLQReRlpS+6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:23:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:23:35 +0000
Date: Mon, 10 Aug 2026 18:23:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, kafai@fb.com,
	joe@wand.net.nz, vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] ip: orphan prefetched skbs before multicast
 forwarding
Message-ID: <20260810152327.GA2779332@shredder>
References: <f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 277adcab-0acc-408d-9611-08def6f3587e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kJdTRY69zPHJASQg7eFXAIGH4p09+ejLVoE3YPGB0MOSZh3HwUXYmN7cqeGyJxjMkiR8ILYrWR40T84f/sktrqAT9QxL7YdqS5Mgntn1tDCWkvmmm1atg0zw1o4aAFgdvCukvlPKOuLehrUwSAXRkfuWSWTY4gJ0myOZKy/X1A5lJxyXTAkWnz2BOJ2aU/7+I7MlM+vKlM5Ha7QCjNEmBkdffHYCqZz75mlb0kGmAPVQyqbm7cAxVZp1T8uO7VGUgiJxCpl3QotFnatog8Px2nq0SOa+Dq569mSO0mxkkHN+zjtodNMeOmCAG6/j0vIxP0+VpK0/p/aJLTm1RIIGIWFbDxPP5HQfZi/mFkpQ5xPIEA7x0wc7gyVNBY+oBtO3cx3A1aOc5aeSoAxmQyo36iLEp4KG+jbJBWjIXwQCM7L/qh6In1sAFqmFRaqwgNHW0YIkg91K2XxfPj/yRXCCdUaPen3Ci+81KLfn829bXjX33kZPk+Q4bWr80XDBUgNA+LTZQ66nW5lKhJHXNQojaDswUx+9ew0eh/psUhb8UFNpLm9U3eJ5iywZxIDcSyb+XVdWrUFJENdNSGfrISmZokUhfMz8cJqp0INRCiw5uEgRZBhmBJDdh3BJx/2feg8kk2YMmS7OaQS/OJuf2YGV55XYJwHoS6nsYMU3epDjA9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iG33qfem2yw82frYWse1JshvmYD4ZLgnsI+L6JRg1a6eTo4PavncfPsAlp+q?=
 =?us-ascii?Q?u7tWcj3iiuSxJUQ6Dx5AiaM4dOYtE3qti0HMDgYNvUN0mR4oNWPJGn3bChsC?=
 =?us-ascii?Q?LC5i+iHXDu7UbxckrqY/w959vqAreJppEweROY8sMiaa7hl9CTlb1JkA+pZ3?=
 =?us-ascii?Q?2Ku2x/BG471Qfp1t3yTi8PyB48S2jy9jioxwC7168M2m3qjWjyJ1OeZg+uqt?=
 =?us-ascii?Q?2sxjP174zB6ceXMs2S4FXxjW7obGu1PeldEAc7Akmq2cqfj8M6eZ64JJSueU?=
 =?us-ascii?Q?Bs8Fy79qcTWLMkXbfHVkfnESMwx76i/B6Rr2pnjZj7hiWV+9Ik/AKpxpnoVY?=
 =?us-ascii?Q?ulySFolmeFjlP3wCaCKqCcHHcw5+tPBKFsR8yO8it/K17vdNhmesnl9CyGo6?=
 =?us-ascii?Q?kAyD7fgetk/2AWnsQSo2IolTzj2HqXgM5P1R2CFfJCmOMw+ZPdMap8dLCma9?=
 =?us-ascii?Q?5OKOnfwtJASRpXvzoWrCJQNKfRnPN6QlS7uJjWZbldZ3/6AOvi0cRsxJNAtY?=
 =?us-ascii?Q?rJxkEbTYyrg9yqUYImKOTqAsjWL33o//LKX4BISbwFfHduyxaOkNEoO0MM/z?=
 =?us-ascii?Q?oMOmCXH0t3IggiZU9dbBVjladlaew0eFzVtP4RfDQlDJTsbIbr83xuyF9lim?=
 =?us-ascii?Q?d10RLDonvstx4bn+MZvNoy8IFqdfksqerykWZgav2llGiA8pVCPIxsBPwpgl?=
 =?us-ascii?Q?8WSoNNlZOnrhlP7D9KVaDvtVqWEoiuq1HvzgWjyTnCXNG7UcgzkejOipra9t?=
 =?us-ascii?Q?4ad/37r0RaQJdEzIxidLzcpsIt43KlYQgSBHTOK+Yi56/NzEj1bNZ9ete2vE?=
 =?us-ascii?Q?8AcFj7Vys8/kggZ2eGc3/rLmSWUcynb/qMqp1iFKRzp8JDMCMeuoGeEVbpyt?=
 =?us-ascii?Q?nBDEF2SKcN33o2nnE8Z6QTBx5BkxL6LOEupMQ6awLGPyPe0tbeYd5Ux83jEO?=
 =?us-ascii?Q?vvycNyn68vFuonHv0DjcP5vvtkRvha7UxN3fGC/8M6a2JBlodsKehB0fPpet?=
 =?us-ascii?Q?Nb0m6bpBlj+hC16ErWtEojfSVWsz6dBWLb1c/w5b6ulbC3hs7TGnt7HOyVx3?=
 =?us-ascii?Q?tkuWKnnd2bNe7EqP2cuRzGJryC6jRctgsDJvyUhhytphD5b9fihuX2gVGOvY?=
 =?us-ascii?Q?poJBtvQkqSFbFa6H6jB6Lc1GtNgh09lwtG7JjwnIvhyJJGY8oap1efyEzz7P?=
 =?us-ascii?Q?c4sgelDaTSj4h9UMZqUFg2yEvS5S0GIo/TK6jejxB6mwxueM3EgXAd89immA?=
 =?us-ascii?Q?/qVQqimF5wIeXcAR+qrCg6VqHJK4d72Hy10Q5yJm8s+zdEreYfGkMSqgvDE7?=
 =?us-ascii?Q?W8mTH4DYvRBoV9h+Xy706+cJvdswWcGLmDZvN7obmn0ieikDFcrt/2L1CeTZ?=
 =?us-ascii?Q?u7rvFElQYYiM9lqzHA1dzEr1YXm+PYvS2W6VM+TqkMpHbDfekAY6POarxDBv?=
 =?us-ascii?Q?1HrK4bk0CEMbc3cHhn5p79G1P4P35ra6SwQOJriyESYBoiB9FukPKS57l4Kd?=
 =?us-ascii?Q?zPrsncB3+ZzeBZ7HDu6c5wYh/GNQnc/dWMr5IPElVzYLm6KyGiNIN5Z8gcJ1?=
 =?us-ascii?Q?9xBMarTqrVsub3bGP3vry2X9O3qEF5XX6TDXqp7G7GML5CGSMhlyJpdRyeXT?=
 =?us-ascii?Q?C698O8/v1EUiG60Ix9v1G2B3hfhMr5JICW14dItPMImlMcNXVuIUH3STM/ue?=
 =?us-ascii?Q?VOtIXqFou8AOH8RQUfH+xSjGgvlc0IbE9cYM1zd1vfDEWggo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277adcab-0acc-408d-9611-08def6f3587e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:23:35.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7RgZ9fRLRr1OvGUW2YBmCl50KNh0Q/iGTgvOMdNQsp0HePd1aU/TXhtLU2qyMpNWJg7H4ip71rceXf0Z5xsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

On Thu, Aug 06, 2026 at 11:18:56PM +0800, Zhiling Zou wrote:
> IPv4 and IPv6 input preserve an skb->sk association installed by
> bpf_sk_assign() so that local delivery can use the selected socket under
> RCU. IPv6 can also get such an association from udp_v6_early_demux(),
> which runs in ip6_rcv_finish_core(), after ip6_rcv_core().

Last sentence is not accurate since it doesn't cover IPv4 which is also
fixed here. I suggest something like:

"Both address families can also prefetch a socket in UDP early demux. In
both paths (BPF and UDP early demux) a reference is not guaranteed to be
held on the socket."

> 
> The reproduced UDPv6 packet has a multicast IP destination but a unicast
> destination MAC address. It is therefore classified as PACKET_HOST and
> passes the UDP early-demux check.

This is again specific to IPv6 although IPv4 suffers from the same
problem. I think we can drop this paragraph.

> 
> When the multicast packet is not locally deliverable, IPv6 hands the

s/When the/When a/

> original skb to ip6_mr_input(). IPv4's ip_mr_input() similarly keeps the
> original skb when local delivery is not needed. Either path can put the
> skb on an unresolved multicast route queue or forward it after the
> receive-side RCU section ends.
> 
> After the prefetched socket is destroyed, a later skb free invokes
> sock_pfree() and dereferences the stale skb->sk. Orphan the skb before
> each non-local multicast forwarding path. Local delivery retains the
> original skb; the existing skb_clone() calls provide multicast forwarding
> with a socket-free clone.
> 
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

The rest looks fine to me.

Both sashikos mention other possible instances of the bug, but I believe
they require bpf_sk_assign(), unlike UDP early demux which is used here.
Assuming these issues are real and reproducible, they should be fixed in
a separate patchset.
