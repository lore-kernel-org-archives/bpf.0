Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B738C42F;
	Sun, 16 Aug 2026 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786876457; cv=fail; b=h3kgd5titDkqefTBsk2UNKHfhuz/jMr8D50EVSIxQQrMeIMKesZy++pSVP4gseEb/dA5HNxur9gZKQxD4hhpDbG775UZv/Nnkntkaelat/xJk7B11X1+jjnQDG0GFEOSmg9QIKUrzaMsYsZfai0iZdqwbUmtMIxR7IvnqKrjLnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786876457; c=relaxed/simple;
	bh=/z/R09VINV0FaIrKifNqrUaWkXAPpIeSr9CXRs8u1Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAGZ53pOM4yLBaDcihx4p5ghUox4zMPAUVkQ6G0n2p1vGz12mfpP4mVAiV9L86IQjGphmxkfAcnZxUgdT5sDA0JG6+N2g3Ld5nr8Jzq2AjXRpJdfOzQzBKD04JK3oFT9nSpK4CsOtyLBQdN6RcRW9tXC2IrvB8RHMRkuGLpk2qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HbrxAic0; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HbrxAic0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U949EQooBVUtFW5AjACRIvQfHAwQpMZNvYsTE4VOY1AEuGRv+BKaNHNBQN8cvU/tkCp+/i/QVl3mCTnASzwkHHG+RlWU8U30NDOptFi3E3wLdh/XNDPamgqcURwoygOVnlyfuZT2G940xyRt8N4OdKv3eFDF4HfSLUGWmVEIDKj/0GyGZjmGB6oohEdcAYXql5BmUfzDkAeoxwmLe6oqMGU3SH2GkbgNXZelJoFVeAc0d9Mda1bR88zYUPJ6Pesq4s0L5TeFz7QBspXGsjENTiC680QuwSiH+TEhZx5D70NUUA5pDNMf3L1HyQpaNPZTTLWcsWYJpbLVQ0E5Sla6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j81LDg/VETF69A33MtDsTcCGbHsT646YQvdsDI0tTZ0=;
 b=fW/MFfdXsFG1+5xaa5ku0mC/EMZGndIkTTZR+3K5bRxyPfTp6g0VvhlpyPEhlvLuW5/mqKwhJJE97MVo9JwmHvXVcwVijV7zvwj6lI5R+xDJOFw5y3YKzwkAoA2pJOz+VKP0fhy84noEJsuIBuS+Yiei2XnKYqsOF7EKz/HnNjJcOziEE/R7tJoik3USUfMnWvl9snHCzEXqKt72q4MBEf2UCwZOTE1XWUEHyKCCrkj85SH2Qaul7/8uQV/y73kkbRp+kzXR2pYkwoMv+mIjITjHI/ET4leacgVrKAmhBpvs9Uvi3Lo2PdA3hSNbbT4/9RSQQ11w6mhH7KOgAdJEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j81LDg/VETF69A33MtDsTcCGbHsT646YQvdsDI0tTZ0=;
 b=HbrxAic0iR61fV/tSRiJYZHYzKW0mwtt4p7HUzzaCWvN9urjGTbcfVCj3vSTiKzy8+x584eZFOK8mOhKlGSWNhXtCxIzKfatNoxmC28IYW5+x6fist0oA3+5wUhozCB/S1lzCJf2EqC67quOJKGwWJc7bWrV5/ZRY8T92hjIHrJb3STa7TK0/rjIiqeg/9nCwDAffXGSdTpvgMzQxWS/VkJOMhBWQkg7DcLje80d/rMaUzdrYJHtNn90ntk7NdyQtZDEbWKwU2zLWIGU9N3/v05SbRj6pBdlWs/plbPqSXFZC1OW4QoHlAVGjx8WFjVJmGmrVvGnEezb630uO82XRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 10:34:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 10:34:10 +0000
Date: Sun, 16 Aug 2026 13:34:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, kafai@fb.com,
	joe@wand.net.nz, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ip: orphan prefetched skbs before multicast
 forwarding
Message-ID: <20260816103400.GA4187591@shredder>
References: <cover.1786552223.git.zhilinz@nebusec.ai>
 <0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bd2c47-3d0c-4565-2d15-08defb81e85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|4143699003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yAmdX1Qne8OzO+SCNwUKFOZLI4QhHyYzmgkI9sDlPk8XQgI4itqnniytZDEtWnVo6s0LbtLCUA+2YTb5or5mZendVdciTXU/DRqxiqAYSRHeN8e2jlN4HSFHEITiy3afhIOTAbDhDDfgOE0nn6hf3kBCqgLYrUvfH727W9WnZ03FboKKU0DBp8Lz+AqnaIUZyYGETbnWm5/drEYVIGi/55CEDWo6WydkDjIYJ6/M/UxNofSESdzxTlhgskzbBCkfmsPWKtaj+aaht4udUBe/ASOisOjEy33ErF0jEBtP3lJnaTTxnCbUkrODAdfRD/9ByW1wALCwdU4smUFKcpXGYTL1iok2Ynk6WeAj1QJU6HT3FIqDHhZCAQqQwTsnfvfyOiy98SIued6CaLzQD1MJcUQ/TuVtPIEEpylKAElTDUGGrN+fHT0+5H49TSM3wdAeZM+DzGjExv6gwWi2HWZm+aTGXhCsH4CldxeMDBTCchuxMz052ClueBE16tKZB7G7BDaRjNOZDoBATb/gqi03oDC6NyQ4dAB23LzE0Bzz3Lx+QMZRGysYIDzYlBjPwIZCYvbhS+aR7kb/w0atIBN4XXnPiOhXGNRHiuL4x5YsyatACY4PY/PwoxFOLdb3MSaI5AwHWrl/d3FubVnM8Oi3i2YTJEiAXM1S8GghfUcqSSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IJjQdJEmN+JFxNOwfAWkhTFt5VGU+g0aC0a6msW7YUUiHIPvHpmdfw06gHqK?=
 =?us-ascii?Q?7P8nELkGrFlwKpEUqfQMVm+EMafYdtjt4mXzt2YeP/eEnRVjH2euvSBb6/p1?=
 =?us-ascii?Q?ipiQCMg1L8uI4SKCUkVVEF/69NtXX5LyjoXBzBV/FVGJity7Czd43C/vThqf?=
 =?us-ascii?Q?POPQc5J/p9ghSZA18ek8eZP0PfLIA3vdAFtdlQlKZ55lUy6Hq2neoCaPZpE4?=
 =?us-ascii?Q?gl5ngrmwStP4WrnMzQupn1YMBeYwNGBLgPDiqzpwVDX7XmdgaJSSK2olp+Ni?=
 =?us-ascii?Q?/bEJy0nMuOldZgGWIInpPq1YFNLlJrS9NGQYdWi6TCKNSoaLnaVZsHWXS4ye?=
 =?us-ascii?Q?/VYFL8qpsLxkqO7bfTDq6DbTTtKOy5SJ3C6RYrQobHLPPOLZVgzfQ6Xu0pET?=
 =?us-ascii?Q?dUCas4jtN0hJUfH3tfHaiUYcp7X+9MaMXObwxcEitFZx94b+MWBEydzxWMmd?=
 =?us-ascii?Q?uPB8OSRSs3YlmuKIRzL4plmIPvWT3lusSaH4vr5agbuMEIQ2SreVwQ6bbWU0?=
 =?us-ascii?Q?rb0n/ecW5JGN9rRjKGDsTRZqgjSt+D1s1wZv/JmYELCh5/usaPcxvJACjY5G?=
 =?us-ascii?Q?UvBQQe73C7kfuQ347iZQnRwChp1WU6T00RDJT6PBN/Fxe9fqBOfJlUqbBr5h?=
 =?us-ascii?Q?t7xTPVhx24nh9Vu3iZW4aSsbbzfDbgQkDfHm7XrRXUovPGD0/rMz9/mgkArM?=
 =?us-ascii?Q?NLawayeItJ8zDiRMol6UWQJXj/rI3O+J+4GS4AByHzjPHqTbnMSygHdmPh7Q?=
 =?us-ascii?Q?kelx+4SxbX6I4aRedFF9SWK4PJ8bdqoAVpIFWGDltAQDpXZ8/Knud9sJpbGf?=
 =?us-ascii?Q?OuMzhiCVgslhTbZcemjoQp3eGj1Wbf4TBMlWwjMBgvR+XEA/kAkHm25zBVYL?=
 =?us-ascii?Q?jGXnTc+b7ALssvpt+EcYDQEK7Gdvk+mYmPYdAAaLU9Cq2dcFZ/C3jCnhiY2q?=
 =?us-ascii?Q?4WFZmsR/KjtDHi673J+T5QVDaEi4l1L8/sv+y4eNDuFUKosUwwPvVPZVoLn0?=
 =?us-ascii?Q?lveXiypY+ptCzI/W7YNUXRgFNQC3DqxXqJvoYKx1SjvXcoqwT2BOB40ft98s?=
 =?us-ascii?Q?m+/F193uCjaE37lveqKyWhSgnOtW3wJ0zFTlryFCx7fhrn9xb1EZ7GR5p+fy?=
 =?us-ascii?Q?p9ftOAGP3FBuiIpDR+7tqProtBZnSFdU/Uen0AqXMC2cTHERXkBfMeUBfM0l?=
 =?us-ascii?Q?/0meVpPjt1ANj2GhGxlvd4pUFYV5tGm0xMWLXquB53OwLHLlQC+KIKsIS8ca?=
 =?us-ascii?Q?La1Y0iyvLHs6IBdGWqgwF+99NGEDJtI7NPBv3R6S2E09YL6MFqjHCU3mGdYT?=
 =?us-ascii?Q?iB56gmYUBYhKy2V/+WJFRMiso+tjncvwdF+IFr9BEcMDuFYeJoQSXaGjNu5+?=
 =?us-ascii?Q?rV9IsgKf0EWyA8shvBNjod4ZkuD8lCOzj2NW5GZgZ1V8DU+xQHoO/3Af8L9H?=
 =?us-ascii?Q?uxVLwQCKYRFuyfuK6mX/RuZ8oMhBfGngQCjNx2QCG0lHrnoUFWXHDvaJDB38?=
 =?us-ascii?Q?ikoczlDd8vMcRlkDK3Vgu26y3cX6OCGJG2pkkodJzhS1iqOmRmIw6Ml9Y1+i?=
 =?us-ascii?Q?Siryu0kdgryGcJjasAG1UKLpanpN1370jYriLpB4dQJGlL3MZwVPBl29N2sG?=
 =?us-ascii?Q?jdXQvUMbWIRqXl5d2pl480Hta1AfmsTn8tFuUzGM3o7GW5FvVQdW+tqNauX+?=
 =?us-ascii?Q?Dndd+O8jBY95IaMz7VJXp7gTYIi5o5P2UMQmJpkzPKypDu8j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bd2c47-3d0c-4565-2d15-08defb81e85c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 10:34:10.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buEVQasCDFsOj0NrZlgoBOoDbEmfw9s3AZoAV7RD1+YwAAob8DCjNuiFNkcCAOd6eVtewrU++BqVkwoEZ/h2wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Thu, Aug 13, 2026 at 12:36:38AM +0800, Zhiling Zou wrote:
> IPv4 and IPv6 input preserve an skb->sk association installed by
> bpf_sk_assign() so that local delivery can use the selected socket under
> RCU. Both address families can also prefetch a socket in UDP early demux.
> In both paths (BPF and UDP early demux) a reference is not guaranteed to
> be held on the socket.
> 
> When a multicast packet is not locally deliverable, IPv6 hands the
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

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I read the feedback from Sashiko [1], but calling skb_orphan() in
ip{,6}mr_cache_unresolved() will not cover the case where an skb with a
pre-fetched socket is multicast forwarded and ends up waiting in some
qdisc. This can be accomplished by an unprivileged user via UDP early
demux.

The case that Sashiko is referring to requires bpf_sk_assign() which is
not available to unprivileged users, AFAIU. It's also not specific to
ipmr.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz%40nebusec.ai
