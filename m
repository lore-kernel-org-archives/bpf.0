Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61F2641FC;
	Fri,  6 Mar 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808026; cv=fail; b=G5daesILPpZzpu3KWgmB13anISZSTiteV5FqgLWIrGHLWcmLyBUMqdtrFT5x/1FPhyw/nJ+qqzF+kUwH8W4io6LJERhfTHk0bJoMm005g5PndJTFF+8y3TPkbd/zfXXt1jvT8rQ8SmNgNqCuYSuz+Mqyt95NcYQztN9OSpVudPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808026; c=relaxed/simple;
	bh=+6X93C7Ghm8m6KNGRfs+vPddIuFp8cZ4mj4/jBqpZxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ipf6PPZnoG+oRK311PBJiGT9DMGlx4YeU3wcH/f2cGbK83MdTIm2v86TTVL74gVqwe9BK9CAb5zvR7AzbnCvmTTTesj7o07TggL57lT/dG7zRSG6FlE7iyXv4XtRmuOKVRWPy+1J+J8Mf6Sto0fTGXca1oc8onNjEv0arzqBvPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QKdP2DzL; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QKdP2DzL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYHYyAcxuBwIGQRkOPY/3BSYcLfY395vsDtAjA0eZs5hHsO6mZtQPK+zHvOVHdOnSNS2qLQvH4WVUH6nmiNyLDyMU4JvDUyBMOqfsOePYxrPFclSLwvaBxJf1YlT4ea1fOq0tndXtS+VWf09AkQ7S7DgDb2K1O5J5Wd9Mim6EI8emnKxCyQi6qCr2turA6p3oap2t2ns8ZsA+Kw2LWf8PaIJmzyS/kOf5fGinlaf6q2E2/ZQUBmf1vyk/Ne0uZT37+cIWhekbf3ZWVNNAGxVn+Xmda1joP7I4R/RkGB4qpIfC+iUq8B7dfkt0HIgZo6G9CI21qTj4taQvS2y3ZnMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCRtSxNIdoGhu8RTBuPUgutQIrmix8zMANOMWc0XQ5E=;
 b=PxflKsqGqffviDg26oodEqJlolyBbI4Ww2Bj2BCLoP75cOkkEUmvvl3EyooVCjeS3DEEJZEQ2BsjCz6wzJlGK/+klZ6ZSGw3VuT8+SJ75aoocH4qdu7hsLu27sbhlOoeSioGvjNVxQ4r+VHyvcZGEmhgHIlRwJ7h6w5rA+dgoe1BCAYD8IKK9HswWijJUzXc+pkqIgjeeI2AOOAxzJhbn2wMPY3Zzbdo5v6ing2PHaOTM2eQGQOnStuUK4J4z7zmSW42vhxoChM7IO8fPZAOLWzPbFqRKA8jkd3RirG07lP4Q4K1M0bkTFdVjknakT2O4jqXZTGJ4WvAQwMed/AUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCRtSxNIdoGhu8RTBuPUgutQIrmix8zMANOMWc0XQ5E=;
 b=QKdP2DzLXt2rj7AAtrFu1BTuSO2tPPpm5X6os6S/lB9BQCll64HftqHk6oUPafOkmaH994zeCEcKw28fAAvf2feOYvOXjNZj5CN3ZslzQtkLI1wtRRQlU7gEYbCjNn84PQKfgWEJE4k7ZeRZfv8UYqYnBD6UnWuhzU/HwhRz/WmlDhTntLJ2jfhtdn6Cmpi6H7os57AlnRJb4VV7WJOICyLeh9GJ5ejMW9YZnB8Czv5q3Pp+1m3QWd+PX5aeZI4WMOYxwnkNlNppBYR5RsbSTPeYpGopcqzNz6gcHo/X++Z46n3sQ7ddq9FRKHbe+6rj/W/dpB3t7Wnd/46KiDOoAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 14:40:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 14:40:22 +0000
Date: Fri, 6 Mar 2026 15:40:18 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com, emil@etsalapatis.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev, zhaomengmeng@kylinos.cn
Subject: Re: [PATCH 2/3] tools/sched_ext: Update scx enum autogens
Message-ID: <aarnUtBe2klutXLm@gpd4>
References: <20260306073110.229595-1-zhaomzhao@126.com>
 <20260306073110.229595-3-zhaomzhao@126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306073110.229595-3-zhaomzhao@126.com>
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d88cc20-03d1-4b48-8a11-08de7b8e4bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	drThFBpVFQZZJkZrbvCZGXzK6yBcqigSivMVEPFq46tDBuHAq0sHamOtykiNsuMYX/sRrF45iarub5P0hNANU2wzpcgo7sCVFVJbtWkYZszdZaxQxu1TbqznEm86uhHK1BlkwKC2OqwTD4QySWJgi5C3cf8f2ObZcCk4fmz6Lq2ECYiVK6NgHtIprpHh48O+EDeFh9fW1moQTGuNo0iEOKrHJlpFAffuDOpRy/WWE5DBGHnoMtgmuPEzaKTjHRxMLtbU2Dg/nAWsp0uEgwi8XGjsV5MKiNQbfbDbDW/dG4Cvwz/lhOcyaNvpCwsKxo/11eKQDFB/Ljvss2qu4mrvndzxIAf6FdNWp1X5XwRQFjzeV1wJ4+i0+Gc+muV8J+EDP3eSsV+ErhhlkoBLlTrW2V2IypXwydPwuHeOGg2i0gQtOVGNkiIiVUExSbft2uciXRMXlkqybtdMjjjkW2JFLJqaUiVVdXvqPpfg6uDAgVFqmEcGQxxdCH0aF63kecHBjiWI122K0qvl2ZjMz+y3cGRHX4tx5jZZt8K4Fbky3lNx/Aq4ZRilSPXawx7IrW0Vi5p2OEiumPYWyY6ieb/E5jwv6ogkvZq8alD53GFj2ENZ48F29MoaAhzvWhvq6DOKWCFeMCeaLI7CgtJwOqtLKJYH93JVX709IlrVawHzKJ05XvubR2ExmbZmXWLtm1mIL0LX0l3FkiaZfQg5Ff9mLlMQm5FMVP+um3tKl1zqFEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZC5zGQQh1xjuDjdVsqZP1D1xpFkn7aRSf/XGCx+77eSdx8UyT9Joe4jLMpuL?=
 =?us-ascii?Q?EZBdtliTUQotah8GLjDelGuZBV4qrF5tkZSze9qe7j+Yaxea5DAl8MYIv3Hk?=
 =?us-ascii?Q?jo4HyrIFAVB33clBcDdZmyohkQjaC3jUOo55xAZARKRrOK17TrKEbiY6TFFT?=
 =?us-ascii?Q?j7awxI9jTins1/86amTye9U5FQJNXfcjNoFJiQ3itgvyKgJ5WlzZz+tyrDKE?=
 =?us-ascii?Q?yK/0UryYMGui7XS1z0QKAFGoIqtU9uUv7ObbWNbRix4f5OMLRTCIoDLdlYpt?=
 =?us-ascii?Q?y42WnbvcaQzr7TTOmnoIk0/DWCBDrGEqS6ozfBWv4p8TKBtZDYdWOQcx2JUE?=
 =?us-ascii?Q?Prm+oP/V8DTevE4Z3yYphPeSTr+zow+k34LlVGnqqJ3M1KqPUNL+LiDfG4TC?=
 =?us-ascii?Q?vSAWUqIovkw3c2GuIIM6PMhKV8kROhfF1Nh+3ZTpTeVWz+tBOhVJRmqmQHex?=
 =?us-ascii?Q?ZCGGvmZ5/GlY+7pW9FTx4cEn7Kt8IGW+G1Uwil3WcpcmpLu3j1Mi8UAJSejh?=
 =?us-ascii?Q?DAUglcHOAvoctMhXIoZQeL1oKHnCOMMJIutYnzAyHCxNddGTPbUdU/xqi6Ph?=
 =?us-ascii?Q?ctNwplDhEiFjgEs6Fg4kmZ9IbB8PzU1BVZhX5ctNvR/sSgHiPyrQOX9yVB2X?=
 =?us-ascii?Q?juAQOWqSk8YN6BkUpHwI6vfYro8ZmsegIQBBrcszANzUdEdHcL8/wvyQkMFh?=
 =?us-ascii?Q?pR7JOx55M1Vo4u/LFfORVDtTA+lCSXORwgAKtBKU8JY2ohF8M06FjYL8lM6M?=
 =?us-ascii?Q?9BiANUJkfWjdUwP+w+VlHaPZhnHPyPA3qIUqB3uhhb90n5yEtgi5pkOogiBE?=
 =?us-ascii?Q?D20Ew3Q5fLksIV8clYxxrN2RD3DqhfT+YBcyg/sEiucyg/9tHAwuyEv1+rdc?=
 =?us-ascii?Q?7JBrpZMCRojvR0tfOfrt0OtQEbQfRf0j0FcNK9BpzYk5G0oKvEDIESvWfKws?=
 =?us-ascii?Q?bgJtGYBkulAkkcZWFfZrxCCE0SAZYkuSOAc0C/Dy8BH/vVHtYFTYkCvYHVkE?=
 =?us-ascii?Q?uv1BD05EwZPq5qv2xnSP41nKpZaf7aLtAk9bys4RmxVjEEFF+U2i4fBKzdHK?=
 =?us-ascii?Q?6TcBjT9wTYk4Cgk5NgY6cgwpj4xcnjkTwMq5USXw81YlBVzl0F3UcEdDMZQZ?=
 =?us-ascii?Q?eaVrUoyiEZP8ycoco4E+HGJ5m+1t4Jqitb53NuSvT/55P0O4kS8105J9NXha?=
 =?us-ascii?Q?myvdQxe4o3fVOJ9Bm9V1RtFscduKX9wFzoPsxbjqXRDtQjNaAkIVJxP1bzAE?=
 =?us-ascii?Q?MrplQc1wfg6EzeADxEpOrNmS9wC/jMsr85x7tmdmcDnFxm7iieda2K39X/TB?=
 =?us-ascii?Q?Phf9wCNl4Edn81mgCWbGX9/QgvvUbtm+r1Xasov2++Z03aqUKX2P1jC398nB?=
 =?us-ascii?Q?0uKlYkg6CMDbV0nAmLZcrJnvQLJqvA+4YCrazhx5V2TnUXdiOj5TpFr+ZKj2?=
 =?us-ascii?Q?FT02LOd9R2XfkazjP5sWeaDwsK/oNu/1rh7ekhR6zzUVCp315QFebVsNdQYO?=
 =?us-ascii?Q?D1f8A3w3OcGV1ALkump7VmMYhIBWdnkRXb8Ud3nmfvThntwVL/EDPtEMUYWW?=
 =?us-ascii?Q?30Y4+fJD7f/dfauP8moEYutIxFw1ZQgrlwWPgrKYW4fiK0CTientR509z4G+?=
 =?us-ascii?Q?hRsBkNpAzehjWxrG5n6QeZ5tGr2DXZCAgtAF3T7i/w+B1dWzHY0zblFH7xDt?=
 =?us-ascii?Q?ExZ0vQppXpHO/aQl8My60Titdl4K5X9jgXH5q8mnNjOBCjEi7uQ3H/zP2FfF?=
 =?us-ascii?Q?Z7qT+5m12w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d88cc20-03d1-4b48-8a11-08de7b8e4bd0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:40:22.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN5Oh4aodSOg8bnxzGKf5ewtBmTC14I2gTbtSWfCdI91ZLL1ItgTbF+EP57MiQFtY7giDG9whDQs6Q49HWnNgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471

On Fri, Mar 06, 2026 at 03:31:09PM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
...
> @@ -46,5 +45,5 @@
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
>  	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
> -	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
> +	SCX_ENUM_SET(skel, scx_enq_flags, SCX_DEQ_SCHED_CHANGE); \

This is wrong, SCX_DEQ_SCHED_CHANGE is moved from scx_deq_flags to
scx_enq_flags.

-Andrea
