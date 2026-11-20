Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795156026;
	b=rMbey4sZnsyNynkT96QKZUT+6Kdvn6b/fWnsSTyhwa2rIAvDBfr3f6Efem6qRvycIy41
	 7VSrbvZ6OpQBI5vcX0uhT1ZRrt1UGqETs3o3UxIctYqXi667hWcL2C5vudRqbO7N9eFNd
	 lr1rtUmft7nJqtC9zguKdGoleN2EF3kvTtOLZ3FPmrB70y2KUAopdNEAhvLtTBCtA+n5B
	 4VIU6REH6lkeRUr5uzkw8GYT6AY6i5t8y7oZnznXwaGgEI1UN+hiHX1LxGi1V8A8L0VTq
	 LJ/CAz685QnpXtdC2cXszSAL7YQGFnS61VmnqrPf2wNB92qLjKVZ7Hm9fIjDG7DzYWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156026;
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
	bh=DxH4JHM06o8/H7CLAb3ZJvx3B+UrcQfFxBEh/cVScK0=;
	b=1lrgr9clss35CvkFbeZBAxqwvqwVEGq26ORelk/SIzeXmsowvcgPtLjr0LnpJ2ktmA0D
	 6IO5Y7dY4XpzB3OJ13ZBCC+co8zAjTehAVu69Yhv0RJJf+ApvQRt9iADNuCSLUs/9TfHY
	 4s+2g/Iod8o0EgYUxdhDh6pl+GI6S2FTJi/+y+og4eD0HSQBoS2P00nXQiVSr5GXyFbEG
	 j/C4IGaGJbf6SuQo5aiw6a4jQpfqRBERL4pSbCapiX8WlpHCA3iDCQ/x5pGOPZ4uB0jaS
	 whwF7bPSVTv1Of1v8rQQZik/ddu5PlaoQ3T8GA1khyDq2i9tlmGAS8xIm9Xwv2/eM+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f5FFAss8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.61
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFEF606A32A;
	Fri, 20 Nov 2026 06:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DFEF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f5FFAss8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNzw4bf+kfra+PnUdhW/iotAxZCHRb201U5yxfzhZ96TL5E1EiuA4GUKLPzjP/W7rh+3a7266eaoectXgGT67jAQWi+XpGTt2rT2X1YIFbdjpYDaEYw85e/7Gn+mKPbxwwIGUe7m1sizlfStLE28/iBlcpGE/1B0V/Q47LlH87q86BWNacPAuV9Fd9DJwRNFLjhlo16W+NK1s6gKlNkiyqMwWAND+UWP/ngtdZL/02hADPC2bZnTIdmWUwiKIh+jxGvGwRvBe/uCx6HhvMWgpW/BYNmllSP9tn/3O/FQfe4upwn9eLTurbvVTo9gTgQZ3X/mF4GEri4vhGjpbrctsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxH4JHM06o8/H7CLAb3ZJvx3B+UrcQfFxBEh/cVScK0=;
 b=Y3ZVjPmGcLjV9U+nmLPOFK3XCFieapBpnuQdpLfscwCbgXe6o/fzq7tTqImZ1EI8HVkXRmK+t4gMbCvq5H3DmHmQXGehzrkQxo8H2jmdSVHvtyIvqz7Cz43Qj1BGjKXE+E2Vm+4REBPfnDANbamjgOEYOzYXl0I+MXvRZV/MPN1lwlVC8+7ZG9YHDge42n1TDuzx/xOKKg9F+IKWV2v+605UmjV4UZqj32xZEFPreJAGvy0fkIcUpfHwbDvchZYypWhSWCoLFTc43CrKedvrpVpyD5nUaZFTMGTIgRJzBiTZeEkea/YLQT5ICxl5zPY5OxfbnSxA/P2OMjr5KbHtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxH4JHM06o8/H7CLAb3ZJvx3B+UrcQfFxBEh/cVScK0=;
 b=f5FFAss8/WYdNJsdWjgWwA/WUcXcpfOgU53OPuofqHRwEeu1vmOrSvlCDAElGeUE5HYBrGRKDny52qk+7M3TeGrrztbGNlJLB9mQkpye+tDXg/ZSySvvRbBtQ4VeUBx6iAucxju0JCkj949dCeqAo4ybGXGO2lXxhzMV4hEvDNNJCNfmcsdx2PIrfpx3wY1+fS4Vq7Iur7vjA84iZ3hjePh73jyuLpqnmxxqmpvjUzc2tAy+Gbrf7dq+oEvDU9ZixJo2wK7U4X4UAh08DdXjoM/Xtj8Y0vXQOZNZeH5VUXRdIfw1AbC0BRXNSRAxwkJSYZCsvp0QU6ZPIRNS0DT6cA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 06:27:00 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 06:27:00 +0000
Date: Fri, 20 Nov 2026 07:26:53 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	haoluo@google.com, brho@google.com, joshdon@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: reject oversized dispatch_max_batch
Message-ID: <av_oLZQzAtFe2vTr@gpd4>
References: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
X-ClientProxiedBy: FR2P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::6) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: aa630c09-708d-4ed0-9a26-08df46cf487d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261028144727099003|261102123227099003|261026140227099003|261102124527099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mki+iEGcdG1nm52Hz5H6pqz4I+70XJQcru9vKKRURZ5lo+NTJr6+7wv8phrhEjwe5QKO2bS2bFzP7VgmFVXTmTsj0T320b3Jp+T4rGJY7026TIgyKXivpbDgBqPKoMWyTVPwpU3sVFjzQoX5jXZLTfrkXxCA5n3wvmxEqv0FjbWqnA/LDU6CBG60RVe7J7PJjM6ivelCxarmDmQHWlOO+LzYaOKnib20z6XP26+cQDkLqx57otftAQYNENdWTZj7aWiLleOwgn82a3SClShpvushWsPyctgELTyvWmXBEYSvESLbU04YaRe+KJl35K5S7hv7uf9FLi6VxwCwrxE6C9WTpVBxtMMcWogJRMp8N1/Ry6xyCY0sbgBybuHk8rjYPCd/uyPXLo+rI+Gef0qKtRc/XAOV/uFKpWp/2uSkJ7r4EJI6M0GXKjoJr8bQt4EGjROSydTL0WXUjl80WpcI/PQvFQcnzLhI3GfU2nagUWNtPILhmAym6uhonKgackKpcbQK1JBAdmCLdT9XZXkC4eGfNeq+NbQrtFOzRsXrE8Oq0aj1kieAnW+Dl/0+/TahN0jlhpbi9vcLLQuYBEjE6RXb5B64d16D5los+5mc93H6WLhVoG+oUTjsgzKyNTCH9O81p4EsgIbYOa66+ZDI7Tr9go5DxuInH2PjYTD7Zgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261102124527099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IqoTg7E6gVTkjglOaCs9vnscT3nQ1zesKIhn3tu2E69IqUBuWzDHKhtqb7FP?=
 =?us-ascii?Q?eimgxKFTWm2KGE4qDhrb4G1nE7OXznLuh6K2wEjpO5JXQQroivgw/w2w575S?=
 =?us-ascii?Q?bZSVKOcSWcjRNon9I2G2SZfRtS93yRtdR4+bc3UyZDe/dv8XBlroNRQ8O+hl?=
 =?us-ascii?Q?D6DCohYw5bCMOI2mcXg3wf5g3Qpi/9QU6WMR2gX1xYz5eID0vCjaD4bqMWLz?=
 =?us-ascii?Q?FhJZOn1x6vGkPaYdAI7xlLDqbmnN2EEFc0c2kxJAqBjdoJ/gsC0CJW/XtVN2?=
 =?us-ascii?Q?oWrbg18EploJnqGF3KjQROyHr8PK+UDehpbFV/epEZHUjpn8b97pak5jmtyU?=
 =?us-ascii?Q?57+zjMUXOVdKEtK3dIymFk8Sc31dRF2DhmCpxZDTz1EqAhg2AdMwUVjNStj/?=
 =?us-ascii?Q?lZwt9GgdzxPbL+pwpfk7y2h7zg3RxYNuBrY8BVHlTROg5bYLbnJlQCfcwnxG?=
 =?us-ascii?Q?P+EzdqOmNa68mi4ApWMRBY7bbTTjSj011/kUwMOWT8Zr8yUlw0+7QF8+p0ap?=
 =?us-ascii?Q?lGCc4o5aERUPLiinFX0A8MHxGAWsCg7Et+bKnohSQNW19bA+o1ykhQ4v98/E?=
 =?us-ascii?Q?woEZ3rK5v9TUbARCbajXszSTmFhj7wDwsy5zFFjX4sEAtnJzU2THY45BcX3J?=
 =?us-ascii?Q?xMHYS3Pe4N7fTvGqe7TJIPpscXygYlv6msF9zX4NLHsTDSP/koiHDD0Jd8kP?=
 =?us-ascii?Q?jt1xm24XgRmSfwhVQlMKLWuzkvIvGgv1vO4xOHOAzwtET+FbjP+kv2jhwMgO?=
 =?us-ascii?Q?GHD0g4VkMDJivUMaadrKwzvKRkW8WfquT1fcTlL575yj+YBlHj5wKuL3b8I0?=
 =?us-ascii?Q?cKSke3A/gXxSwtKh7g7M8h+crALmhgPUbGqpJrqdPW3h6fTMWQOs2vCZS9ID?=
 =?us-ascii?Q?PdOhGj/E4kLGC2f+bZtKS6g2lMabsVF0QJRqJGA6EiOSooulCXLCTK4wYIiO?=
 =?us-ascii?Q?lwYs+eEm+Vjg35uU/1yrs+i6CY2MkHp7yl7mTTLT+mQvp8d8MwQWfdR5OATD?=
 =?us-ascii?Q?Tfv0aTD3UegLUj7E7lmOxmL737NcDcoan2BbY54H9qrDXf/WY6Rs9lH66lUr?=
 =?us-ascii?Q?p96+GZB684e0wNcp5KPTj2z7c2XXNFQ9+8rFetNhE5v4i68nNF3vsvvXg0zl?=
 =?us-ascii?Q?GrdKr8DOnmv/sAf3O1uOT5QtD22EpnSac27ffX6eXWIzlYiryuSyu4PoyoF/?=
 =?us-ascii?Q?bN5MaxQii0Qgoro99QcPpj88Y5BpRDkqny1rZIAKlkhMcvr/cKtyAbjcKUic?=
 =?us-ascii?Q?NFsDljBkv3X0/0ISQfCddWYJD8019TanTpRshrjEH38goMtPc3PHpqwYgDsk?=
 =?us-ascii?Q?pCOCG35j+4VtNFRtZ60vFDQ0J7YVekU4q6hpKlqQtoCNTjWRbIKey9O6mdTf?=
 =?us-ascii?Q?pPa7HvPqVSmT0VBjNBe7JCrWMEgDjiNIizAEv2o6S0sSJMpfp4LJ8ASCmnMm?=
 =?us-ascii?Q?yugE2cTvFidrdhtXHo1XnGtiQkhZcZFRrh33u8FvsSaUIoLhEQTRpemUnTJG?=
 =?us-ascii?Q?Hsh0u+yPlQqM0Dv2JzmvqXFP1lckhhasUCFQgN1LCW8qPpFCZNJ5MoziAMU2?=
 =?us-ascii?Q?rK88JQZxBnlYUOKWr9uN96gn/HelzTEydzzH+FWXRRpCzySJ+pOF1FU+rUmj?=
 =?us-ascii?Q?lS60A+V3TWd+iOICPHQkyQjTloHKg/zr/ULzAqB5YfuVoH3mzBivxrncF8OA?=
 =?us-ascii?Q?5XkHg8Hj5Wz6hp6pPCPrwsr77BjFsg/cQ9uhslgDM0XepUoTw1Vf2MH2Yr53?=
 =?us-ascii?Q?2IaUZfW82w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa630c09-708d-4ed0-9a26-08df46cf487d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:26:59.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN0OSfWlQ5gFccGkWF3VDxPkze7ti0ksYALFAs7nI5YUuxcx9m6042o1K91ip5yKDS01i1MX9Oj2jVep5sF6wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267

Hi Sechang,

On Fri, Nov 20, 2026 at 05:49:08AM +0000, Sechang Lim wrote:
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
> the allocator is called.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  kernel/sched/ext/ext.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10de6bd865e8..93128da6b126 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9197,9 +9197,14 @@ static int bpf_scx_init_member(const struct btf_type *t,
>  
>  	switch (moff) {
>  	case offsetof(struct sched_ext_ops, dispatch_max_batch):
> -		if (*(u32 *)(udata + moff) > INT_MAX)
> +		u32 batch = *(u32 *)(udata + moff);
> +		u32 nr = batch ?: SCX_DSP_DFL_MAX_BATCH;

The fix makes sense, but with clang:

In file included from kernel/sched/build_policy.c:71:
kernel/sched/ext/ext.c:9214:3: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
 9214 |                 u32 batch = *(u32 *)(udata + moff);
      |                 ^
1 error generated.

(also reported by sashiko)

Can you wrap that case in braces, matching the nearby cases?

Thanks,
-Andrea

> +
> +		if (struct_size_t(struct scx_sched_pcpu, dsp_ctx.buf, nr) >
> +				PCPU_MIN_UNIT_SIZE)
>  			return -E2BIG;
> -		ops->dispatch_max_batch = *(u32 *)(udata + moff);
> +
> +		ops->dispatch_max_batch = batch;
>  		return 1;
>  	case offsetof(struct sched_ext_ops, flags):
>  		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
> -- 
> 2.56.1
> 
