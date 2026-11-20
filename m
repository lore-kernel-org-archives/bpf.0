Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162352;
	b=da3K/BkP2jHXxT3Vzo6ZDULwfxaeTObPF1KoXK1paGa8p1q+GC8ujC1igFKEzxIsLzoq
	 v+kFkUq3TS1h59IV63cme4gMb2n7J06XiXPNY/0Hjb94ND+trgb7aSovL+rziL+qG2iKo
	 3UDcnXXpBs4X01E61e4smlXglBJKDC+KvEO2tlimSd0Evy6rkwe72MxjL3YaflYDidg6F
	 RxSJP7nBOxtZKa1xFBYmSwlzki86Izx2CtTwgFl1RiudDrq7uVRGTY61unlncNy077fqG
	 hOvvO2fj5pnyBLcRZ5DxAo+CzzS5eg7ex6p8GGLTTfC8zO2kQDppPEJKRBHpzHmjwqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162352;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RayAVl9jRDorNag003n9jiEFDbblFyZHKIf3z3UokQU=;
	b=uh8L8jZ/vcGDLMsdjTAdL1zAKS1wLNMihZX5CT3GvdMkvw5zZ4N/R2+/aNZg3EHN91sf
	 fFGyTLN3wpkyPCBd9/KOhse94fPDmp/dz1OeAMZKv4ejF+wbi/12zY4ZA3SnfXUm3RxEi
	 C8PUmRsaaPpv7+DbdBmUJEv71XTEokGM8a/GHfcfM0jwaCj8qeSklu61FTpgHxNghQSpy
	 bu+J6GdTWu+vX2pFaUxWaCsr4QujkmxGpKEwBdzMhe0EAv2Y4o7MyyOkEA4FgRsvcy3Az
	 0P1JdUlqrNxvdZzgbTC7tfT/MsnQvkP/VlCr6ITY+d7rib95OWbDqcgoJ7A97aT481Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YdEz7Aml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.65
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B087606A339;
	Fri, 20 Nov 2026 08:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B087606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YdEz7Aml
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkJlhuuGPSQot2YH+P/aC6k7FHKmHo4jZ8npik6cnE3VV7JyB991b0lefKSd4Pw8IBsi9k0WWVJw9xJHTlHNoJhiDq6HsY8KyJ8ZqQOCROgz2Nf+k8BVHm+toEP8/vgrV1zCaJAE4/hrJW++wI9CVQ96FhXTdlf8lL0esgvH+AATtozlaRrQtJaCL8FC8vmmSslJGG5QYHVjrEA9RpHG6fiBFGUt7iGezUr3G7PgigppjKCcWJ5ByRWSKI+nKsYK4zXlzg5ZpKCZzA+gsdROI1wgNaenI4FsT9p3vbkpWAyboaQ/lfuB2j6ICXp1M6B/tNitcoRb3vLfIfPzabM4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RayAVl9jRDorNag003n9jiEFDbblFyZHKIf3z3UokQU=;
 b=l38nXuBDHnmihsM3f2hCDByd7bV4gdKpTkx6MfojHVk5ny5ufXJ6e63zbBGhyRseoqd1fJmqBNg0VeWA/UDfLO//278W0XlVOxCk8VvwkwZ5bILRJgD4PEcgaKDCt4/jFxOdZLwl0NIuI92S0kUi6+VzKCTMfwUWNNEiJyPqDszIEv1HsLmy6p4PFQkx01YGKzOLh4ubg7S1FiLGw9nDfGj9YXwnmRT+D9qCuYvGgtagTuw+0YMeqlqlBBertOBfAkuj6Rx/g7rID5Nq368+NF25aXEjNNvMKhQC2nUSHl/iQRjONnZLyzpmFrRuGzWs5zm+EDndFaJLKyzSExDkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RayAVl9jRDorNag003n9jiEFDbblFyZHKIf3z3UokQU=;
 b=YdEz7AmlcBd9jHoUukzYjRfSxAdppOMb1OYwW+79p95hsJZwKin1FHb1DzWfJ6cT0otIeDMSM+kMMFGLkK797kKT1HBeFtbcfstWY+KOKxZmLmUB+2Vlrhkm0r8ag7H3Fh6FoHtVQK9fvar9lBnnpGKeQee0uEurpibdLrPXr08ukZAcQ86F9GYE5/b7yGJ4TpakhfxXm2yPzO6MysBeNur2XiqJkXn+uWTkRr1CyjbbpPliIG4fueftkFEVKpBFlrlAk84nuamx12fWo+WR1xB3jP2AmlqHZ/l02NIBUX7ZSdSJM9itVi7KpDZkaGd4Y+UW5eh0JbA1VeOvehbuuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by DS5PPFF2923D4C1.namprd12.prod.outlook.com (2603:10b6:f:fc00::669) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 20 Nov
 2026 08:12:18 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 08:12:16 +0000
Date: Fri, 20 Nov 2026 09:12:08 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	haoluo@google.com, brho@google.com, joshdon@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: reject oversized dispatch_max_batch
Message-ID: <awAA2OSJnYDBURqo@gpd4>
References: <20261120065559.3979434-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120065559.3979434-1-rhkrqnwk98@gmail.com>
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|DS5PPFF2923D4C1:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f94540e-5ee2-4e25-199d-08df46ddfcef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|6133799003|261009223027099003|10067099003|261022075727099003|56012099006|261021123027099003|261102123227099003|261021121427099003|261022105027099003|261028144727099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	i4zD1754RlgAzCiNWUHslfs/a0yibUEVDz/oumQdd1QcI8hneNBPtJbCiRrp/oUD9yngv537pgWI9F94A8BLn4qouHbbAtxHxO+d/0zRm45j4Dck1Ew0yrXc4AEg8l9dpXa+e5vcpxzCHKc7Vk9Bxi/+Esy89ZpfFpM2FF9zB4K4l8qx6n85y8d8H1o5ZwImFvwln6PsfzSAvHA/NG4gG6WNDMExn9urMR8Jq+2IAh/llQy6KPYygsKYS7J1IQRt4uSNhe/cH0Kk9YcitgcCjomcS8Py2LNbXO3mda/vjFM0SqpJq8Nxb7FYL58q+SnIq8+Ahq3olWg9dAg9jmgwFS+bwziGghrMvHZW5tELpZQUM02RXzBSjkszNS0BIfhFEEdOqNgmYnB2yQu8kXWh63LiANxUcSiou86N4MknwVrcm2N6DCVgZSe7SOX+TAxnTuRkeePGixmtOFyLhaWNPyAmgAlm+dxEuL8XCrbQuTqGvqC/iu9TZUzlbRHZ2TG5UkTCaEXQLbla0LZKuKDGWn2Edh5yYRnoX1FvCqygokuHqGmKcPi1XV/7ftL6NoFHJ07Ur3DdJrN3RjfOD9aF4ozuDbehAwV6UTgZi6mY46uizpKmBdTzj45Tnq6ZNSiH/k42RmmhQFUDAkn86DyKUOj7KJ6kC5RbZ5DSDs4TiKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003)(261022075727099003)(56012099006)(261021123027099003)(261102123227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nxLX8BkhW15Y3MrqZkVDx3mmyke6BRncJtHa24vRZ0WS2XN/s+0CqEr0z75l?=
 =?us-ascii?Q?yTRSXFz4AQoyV6nSqYenTlfKk+4J9Pgv6fqQfttxfsIULZRL9PEPkNsJKwaz?=
 =?us-ascii?Q?T6YNc3abu51myOOxWFSZWwrfxwbx93Z6KEgrVx01Na2UxHHU1BGn2BHDscxO?=
 =?us-ascii?Q?wGxv+cneIW0AAyYXPZev/HE5mnT8qqksdifI7Nu+ljKqHfIJwRrYHVIJ0c/Z?=
 =?us-ascii?Q?uD0JCAqxodB1Ng79HQ1pK+HFS6WumhbTliwx64MbCRLGp67YNgvOcchfiZ72?=
 =?us-ascii?Q?0l9NK92n3sZZIWw1I4OBH52xO2P7j2RFMM93CUpTB3jDdS9lGP56m59d9Wt9?=
 =?us-ascii?Q?zuNpCa46GltWkWVEHWiJWtIeeZNEIZtXTw2JskrCvg2v3Y1sHHSwG5f2o/Zc?=
 =?us-ascii?Q?O1K91ndbTlt/qHYJ0WaX570Z+4Jf34YWwSmCtxVeERu6cj5qHtdyFk/U/RGU?=
 =?us-ascii?Q?lZsQGiRVhN1GQUVyTy5L+xZHe5MavJxWWyjg4nKaHj6APgGrVAqOMuXiBVab?=
 =?us-ascii?Q?GzNkSzKnfiRV0q2/13NugUbBwXE9ryyb5BI6D3B3Fx901yUwvoOVXZFVZtk+?=
 =?us-ascii?Q?Abm8EIA5h1twmGU8RoPWtB8pTIu9sg85+oYZjqvAQchWPczFtoid0sY26Gq4?=
 =?us-ascii?Q?7uD/xdOjqKUEVkTRk6QjwywX9bHX2PUdtiRAcRCOQdz2QmXrrMOspFWzyJnC?=
 =?us-ascii?Q?sakWgOvKDmAqwa2t7+6VekTclq4XUergS4ataKG+TtRZCwsuPSSe2M+wmJSx?=
 =?us-ascii?Q?13JTDzLi5AN7KHb+iIif96eGFOlRbaMCpRclZIDRSx2n1Uoadg+HOaAi+9/T?=
 =?us-ascii?Q?/sfKKJHaIQc4hE+eS4aWOu+vGwdPLEoLkoGvmcyQSaxf0mKfXplEil5Skmr8?=
 =?us-ascii?Q?FSe7MoWmNq25aMu63COUdclrZW1uCxC1REWDwtCKqP9yB+zMmhUbM1NNNkMk?=
 =?us-ascii?Q?XGVEcLj6VjixuAT3vef2xiRhlrG8hFmyTBO709kVKnoKCVdNqnYYZonHVLDZ?=
 =?us-ascii?Q?+ue/pAfd8zAba1VcolN5vSmei4G8ZRtGNdxGDznM5/G/2ApjRY/qJK2iptvA?=
 =?us-ascii?Q?/973qlaCk7x9fqrtJrwnItmQDRKm/doBop+61Opmj4r3piApDoeFlGqaPUtz?=
 =?us-ascii?Q?jKCGqfpLnUTgHp2WtzN8pXobmw3hlYSyTNF3b/lHKjUQk5PeTWTjpllSqqAP?=
 =?us-ascii?Q?oh+KMDeWPb4QXXm+WhgOnxxYUXV+p1K9tEiSx81UuWYaUVXrZSK40Vtdoohc?=
 =?us-ascii?Q?/3o3ey2xtz/3/9qgvZr3k87bHDfnAz562aiJnE3651Aw2rPZ+26JOuaEvwn0?=
 =?us-ascii?Q?dv+YSDotkIKfEsBWehgOeBsXvhPdiMEFXAGMC1LsBiCTqktQHlPBnzk1no/p?=
 =?us-ascii?Q?X07GIs6Sq11wsR8bsIY+pv3q3vsjagKuj81fOQTyJ1HnposS2qeRM5eUercK?=
 =?us-ascii?Q?gWEJP5/8LvKoPZk/oCiI7R3yPzC0VMspM5VxSZObyik5HGpJQoZWjd5gw18y?=
 =?us-ascii?Q?yV5Z+wZua52XBIb9Kll9s+N2kDRZIpjnkFW9f3H3zKJIwE545SuDv0haPMtE?=
 =?us-ascii?Q?kjSqvb8WwEmQ5Y9ojztKsZTCAaw9RwSL4MOsTQ7nBz+PLrgDctLW1lgGqI9g?=
 =?us-ascii?Q?Wm8FXj5EdXPKBEHTeto1QoRSB32zxvv74/4HNop97fbtOfNK2XJChWbcVWgW?=
 =?us-ascii?Q?NmnNovjyR7S8fZih3KvrN4LTKyJBPDLnIZ0nSwYvVwCWO4psMYOFFQIY6XfP?=
 =?us-ascii?Q?pGyZQcrH+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f94540e-5ee2-4e25-199d-08df46ddfcef
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:12:15.9374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSmcEfpx+953fIrKwIFvtC4Do8EjnfGOSvcagQRkwGRiXl0U5HB1Zv2GAEWlaRlt2Xj+v6htKcAjTR6MT9Dyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF2923D4C1

On Fri, Nov 20, 2026 at 06:55:54AM +0000, Sechang Lim wrote:
> bpf_scx_init_member() accepts dispatch_max_batch values up to INT_MAX.
> The value determines the size of the per-CPU dispatch buffer, but
> __alloc_percpu() rejects allocations larger than PCPU_MIN_UNIT_SIZE.
> With BPF_F_LINK, an oversized value passes the struct_ops map update
> and triggers an illegal-size warning during link creation before the
> allocation fails with -ENOMEM.
> 
> Calculate the buffer size using the effective batch count, including
> the default used when dispatch_max_batch is zero. Reject values above
> the per-CPU allocation limit with -E2BIG during the map update, before
> the allocator is called. This also covers registration without a link.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> v2:
>  - add braces (Andrea Righi)
> 
> v1:
>  - https://lore.kernel.org/sched-ext/20261120054913.3795562-1-rhkrqnwk98@gmail.com/T/#u
> 
> 
>  kernel/sched/ext/ext.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10de6bd865e8..56d75d179822 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9196,11 +9196,17 @@ static int bpf_scx_init_member(const struct btf_type *t,
>  	int ret;
>  
>  	switch (moff) {
> -	case offsetof(struct sched_ext_ops, dispatch_max_batch):
> -		if (*(u32 *)(udata + moff) > INT_MAX)
> +	case offsetof(struct sched_ext_ops, dispatch_max_batch): {
> +		u32 batch = *(u32 *)(udata + moff);
> +		u32 nr = batch ?: SCX_DSP_DFL_MAX_BATCH;
> +
> +		if (struct_size_t(struct scx_sched_pcpu, dsp_ctx.buf, nr) >
> +				PCPU_MIN_UNIT_SIZE)
>  			return -E2BIG;
> -		ops->dispatch_max_batch = *(u32 *)(udata + moff);
> +
> +		ops->dispatch_max_batch = batch;
>  		return 1;
> +	}
>  	case offsetof(struct sched_ext_ops, flags):
>  		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
>  			return -EINVAL;
> -- 
> 2.56.1
> 
