Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795155280;
	b=a3HeiqXqY7PaQb/TsPaWt3lIjiElK5BkFrgTTjS9Bidex5RCEgzLFJyNJuJAeoChPZHo
	 y2vLJrd5MNftUoeT/H6ruE7Ya1GBXC8RLXQq5eue5BQ1QgJVnGNkEZByDw4mgejXk4zOq
	 j7z9Ml3lNTphAs0MQaNGCgBzgGhRgK7gTBypxdqyCUIbTZ3oQ+ikP7YglYSzDazpRLp50
	 hidVy5GEc8nsotHgb6y8revYIxcCOOOnLAIGKr3Gea+zGyxNxVDp3lqHQMu5gFC7QBRLo
	 lXEkG+aL+0rh++lyxhW1A1b8h3OCpzCj/GeNXhwiK94zYFHoy4NRTNDyYJKIyDkKuNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155280;
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
	bh=aDKpHyIyxefgnyG8aHwo3Fil/ENv7ok/3Ux3smuRC9U=;
	b=ctWqYLBn+XNNMmZh8UjHj89B1vLi652verW1u3fFNeq/GnKvlSn4dV1YwW4DwQCYct8c
	 AkAVUIs9NB9ovHzZr+j6SsRnZqqi8qpiPGoRbHDYSBK9CSOG6TnRRmpulBZmI9XUXD6hN
	 9kJoT/yTEmdXokjFKycbqqkVh4HEmCqYRJeSq9boMtr0zGA1lcH4jgoTyHR/T777COr0Z
	 mMQEG27LRYvB2qk0UFgCaoA2l5jwCjDDSA8+y8yhyogxZCn7XortXqFeDLE5rADtQm4cC
	 4UyfNrHVX3d0vkbcettYHKD4s1DDY7bhVs97//LmEWUBcbJlStyyOWp0mnaKhWPLkdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qz47c9Ea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.67
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529BE606A50A;
	Fri, 20 Nov 2026 06:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 529BE606A50A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qz47c9Ea
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfWUSW/TV29QMuEKaSyYeCd8xO5YGuR+myOIiDdB9Vq4qEy0k3Mav1MeFgqzkEZK7ieULpD1qrL+Ufeap1KGnrjjJPzywRhMSgiMOzKdir47MGKlGAoQHsThHoIYKJ6+ytaPaJiRV2mX7GI55TOJhyDoK20ndEnuGUSCTyvRHJdNMBpS6rP0j5gdXwfzoGaq417P3JRHtzCIW4k9SZHAkhpy1UZid0nCjZFwh5fmtugWjWsCQkIGaCSKu7rlQ5L78gy0Brbkr/qEqRi+d4VbUL0M2jbzwIqHyGhIwsbroxWU1cI/D7GM47dLM2LWW8Ml9MfvFl+49DCtrUKTHcRKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDKpHyIyxefgnyG8aHwo3Fil/ENv7ok/3Ux3smuRC9U=;
 b=PlPYuHGo4SbZ8NIJmFdAT/2aubpQSvPSt3MISgpsfoP+VsLRcGaSocP1VHJGigvP0WUSfApUB3bgfP0vB3IK4tkKm8q7xOm0x9cqxPtgF11EZ2ELEwRoXFVK+IUrmY3LvjfwrN9qufZLjYPbZGW8QnINyhvPkI6MSHptwBo1bPxoCBdETyZWybf8qorcu6s8LkBZd/RQYWpIoocsplVj+nLm3Q1ncpz/HFrHYi7qGW4x0odTvxQHKXD76gcup/CMnmdpNW9BTFyITBW8Oh7IDgwQ+P7/hBjG5t2ohOQzLRNFaPEyTgzZrdTb6u9Q5kpeRFIRLv6JAN8F2M2P2ja3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDKpHyIyxefgnyG8aHwo3Fil/ENv7ok/3Ux3smuRC9U=;
 b=Qz47c9Ea1U3gmrYFd44FJ/A+iu3LOPobKEY6lxnsi2GeFw43ef5zEEkwBn8wE5l59l7sBgj5DzG4vQMeSdjDGtS/c5InUOMGjQuDLhzo39LwGb9ubWslqKdoREdpIS9GEHyKH+6o0yxSBFOtJjsBaRX28YTYDOmgQcJ/BM5md+kDjo+uI4k8r4FEWc/Ueo0xfkluPu2u1s65b0pqQjfTPoVeHpNWV7v5jMXyh0Hl69oDXUAehzvGt72u++dAwljWuDbtKSin6KszdoMBTGP+Y4oAB0t4cJWeABp5micwvfejO3EqgeA9G6KXIrftPz/hp7BQLy4kcjpyYbSjCAA3eA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CHBPR12MB475823.namprd12.prod.outlook.com (2603:10b6:610:404::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 06:14:36 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 06:14:35 +0000
Date: Fri, 20 Nov 2026 07:14:26 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Shaojie Sun <sunshaojie@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: Add "arena" BTF type tag to the __arena
 qualifier
Message-ID: <av_lQuuL5lgbW1BW@gpd4>
References: <20261119102613.811845-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119102613.811845-1-sunshaojie@kylinos.cn>
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CHBPR12MB475823:EE_
X-MS-Office365-Filtering-Correlation-Id: 688b92e5-ce7f-46dd-1c0f-08df46cd8cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|261009223027099003|261021121427099003|261102123227099003|56012099006|261022075727099003|261026121527099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/8UfVGXI5rydQYSMc0eazXNuDaGS81YB0x/niWS3VTuTlZl82vTOvn3uvKN4HaNch81Gf9Q+p5TxB89A17XPPjc6c6FmzWxDOV9MahgW4d9zlN91gg6WPQO6J3OZBVex9d93Ap+LRarTfVRtfOfaQ2BFDOxPFprWMgGozpkONooIP3Twdz3m73OYLy5ZQM9MTGT0jiQ7KYd2BbzgZOHReoVR//SJVRSamss+rBS/m2AUhquA8oEPwcLrgUcWKUhFmhk8ppZ6gF9qh15fWzjuEaKMrPaGP+pXEleqO2hoInZ1TwuNoaFv5SV7xuZdHh+bVSM9a66Qk5kyCqmBpaLvmHQ7wrny+QsXNlBna9LuDWQTmZXP03DAjN9B4FHH6dM2XB32vBJs5QmVLs7rlc4x++B6pEcKv3fo8x4jrdzx4D5yl2GXfx+IZdzcU9kOiUP1clYey0/vonD9jMdYDBNfUDBSawcgGE0YWp3Qb/Q3pAaSQ+Zn8B7OJBDUxrux16xBksin4fdPAXBBIzsgjPQJj8z9uLJLiN9p4vlDvmc4ohurGV+UtFU9s3zlnBSqlDpCPhIZP59sCZlzArD25dx6Xk38BeIy8Pl/LjmggivwTzC/oxXaAxF37p+plx6oht/KlzF8N5f+ZV3WBddtP7ecCOA6xAaHXldePEeSq/Nlpp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(261022075727099003)(261026121527099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vyrX4vUT5Hldwl8bfOLl8P34KIa+HFD4QK9S9clQoG901eACwWjh9bhcV2A6?=
 =?us-ascii?Q?wVhMn8aXdB0gjg4oRBDdl0wHyorfkhE5AJBM+VmG8UYQyDTh/5iCb7nLQNkq?=
 =?us-ascii?Q?9aqQ5iMaKLbt5EulucYjO49PYza1g9njDQ0oB2MuW+r1+dBdWj6YWt3QIq7v?=
 =?us-ascii?Q?XANERBm9GeovB6BxDMqFjvDz4hNq8oRsYvxmV+qdvAorMUkpU884PzCtoiWA?=
 =?us-ascii?Q?7/qZcWfJlVdT2IMYnzxJ7fDqwsmifDutyx2aMvLmIQJ22kf9QR6P7GqQofka?=
 =?us-ascii?Q?U7gZPX3XazuDZ9rLMjDTDvU0s88fNBa60aXRl1Ap2cO/56ZnhJxhDlaYp2eH?=
 =?us-ascii?Q?xAKk3o60FH2vxOJLPMREB41PhlWFgpnkXpv6FoGvHFMWXw3nx9FygiTMWTy9?=
 =?us-ascii?Q?747YCpPIfzRj3mC1QtRPP3pDuMMYhgFJLqLYK8PH6TwbfPCpD2FitC7To14L?=
 =?us-ascii?Q?oaBYNDgi4JrLdoOfrBjHGLLaaAP9SX24IU2EjmknRPDDCLCwFxgbsdPv7g4p?=
 =?us-ascii?Q?Nn/f4hSHgwhbDF8W7FsKEKbmjbjcBsxtPlMpk3jQASUaObPMf13wpzRiKOZy?=
 =?us-ascii?Q?krjQmsYfbb6JgjnQ19CMKZugzDgwzK/u4DQ5l0yamANmPi33LqFgJuFW63Va?=
 =?us-ascii?Q?ITyfVHBvjz4tU2NpZBnif8vQ9vzeBwh0v7BY/MD01X/oIIJMtaRdWzOyVHYb?=
 =?us-ascii?Q?I/SPSQdLWx7DLI5e7qoHjdgb3HTLKAj2RAalotyeGQOgF8fin8fUEp1T+r4l?=
 =?us-ascii?Q?0eh/v1GfqkH/olf4LostRdl7DCPpM5ksQbFyeJi0XNNPWpBQ3BK5paZAYmQp?=
 =?us-ascii?Q?W/SJ1jtt7l2MJy1IdbhJAqhmNSSKDr3lFn8dJo92BNbkDTBUfkcxjIURIaN1?=
 =?us-ascii?Q?lHRi4q+hUCdZcipNi12pDsUfhMB9s7O6xOF1Ys4YohLhnI6C/htN1xXaFcXv?=
 =?us-ascii?Q?8MjqP6sc9EMimorvCmsLZICbclmGiO/4ajUvC+MRcIPmcxKx+gKrk98AnvZd?=
 =?us-ascii?Q?pcTPMwB3RBNt4txvGbG8Z3cfiHKvDk5cj1x5KfZE4VDSK7ONjXDAqtstwrtM?=
 =?us-ascii?Q?QMy70rtSMeDsMyTL1RAldD2X8q8PSNP+m8nOa/daA7MzQBRRr0kr3EjmwUWt?=
 =?us-ascii?Q?4JyPKMrg4rgXYrIp6DBARcs7nJDG8ifkyNb2nl/6vkzfGeXLYGaCLq9U5hU2?=
 =?us-ascii?Q?ScyyJU5A2vPMSmT6cGodk7Jhje41PgtOb3Qgo+dRT2SWR/OS8K1vFvBF4Aq/?=
 =?us-ascii?Q?leEjf3jh7+fGhhuWpKRMOAJQJZMVZtHFXvWHdgQMk5vdPjOdb5aW3aQ74Acz?=
 =?us-ascii?Q?gmtltIw2kE6G8me5TQAMQ5Ge6dE7VKBbRS2vDzPUbJ5frVFmBUOvd5635JfO?=
 =?us-ascii?Q?LlOFKRxh2ofP2BfNsVmF/lhuoYYg0mKn/oYGRAz0pzRgnISsK9RaHMugiFfn?=
 =?us-ascii?Q?tGlpVhEWRyJqSs2mjpPKYz+S0wbYODJASJ3wrsUDlAQErQS0m2NntoplNuNy?=
 =?us-ascii?Q?Txz8ww3vCC29Y3hWXOphxDlGfn+254HoIQrl7JKwVWkN22RO+PrxLjfRhJj/?=
 =?us-ascii?Q?8dn3p/HCk0liMZGiQ8RunE8aOAuF5Ut9cEnRx316u8XhNiTKaguRdkBm6F9n?=
 =?us-ascii?Q?jl/resTapBhixjeLiOud8OnhWD7iQlYJojz5tTmb1JyYTKIZEVzfrXE0daLO?=
 =?us-ascii?Q?L9f1Afy8Xy08DUd1UE6W2qqDKhyrHW1x49WXjwBaVgP1wOBHHKARHRvFS0xj?=
 =?us-ascii?Q?vS/PLXCl4w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688b92e5-ce7f-46dd-1c0f-08df46cd8cd7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:14:35.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwDAYiYKa091dOYjtIHgXX86hTfz+Anw2Y9TzKBxBmG/f1R7OM61P5RouM91A2LW4xmF+opFUpmyUHBVpRtTLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB475823

Hi Shaojie,

On Thu, Nov 19, 2026 at 06:26:13PM +0800, Shaojie Sun wrote:
> tools/testing/selftests/bpf/libarena marks __arena types with
> btf_type_tag("arena") so that whether a type belongs to an arena can be
> determined from BTF alone:
> 
>   commit a0fa68d8ce75 ("selftests/bpf: libarena: Add "arena" BTF type
>   tag to __arena qualifier")
> 
> tools/sched_ext defines the same __arena qualifier but without the
> "arena" BTF type tag.  Add the tag so that both describe arena types the
> same way.
> 
> checkpatch reports a false positive on the new definition:
> 
>   ERROR: Macros with complex values should be enclosed in parentheses
> 
> The macro value is a sequence of declaration attributes, not an
> expression, so it can neither be parenthesized nor wrapped in a
> do-while loop.  The selftests copy of the qualifier has the very same
> definition and triggers the same warning.
> 
> Signed-off-by: Shaojie Sun <sunshaojie@kylinos.cn>
> ---
>  tools/sched_ext/include/scx/bpf_arena_common.bpf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
> index 2043d66940ea..fb796b356f86 100644
> --- a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
> +++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
> @@ -16,7 +16,7 @@
>  
>  #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
>  #ifndef __arena
> -#define __arena __attribute__((address_space(1)))
> +#define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))

Can you add the BTF type tag also to the fallback of __arena, so that it
covers older LLVM versions and BPF_ARENA_FORCE_ASM as well? (see below)

Longer term (not for this patch), we should probably move these
definitions into a shared BPF header used by both sched_ext and
libarena, to avoid keeping duplicate copies in sync. That can be a
separate cleanup.

With the change below:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

 tools/sched_ext/include/scx/bpf_arena_common.bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
index fb796b356f864..9f63732181065 100644
--- a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
+++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
@@ -74,7 +74,7 @@
 		     , [as]"i"((dst_as << 16) | src_as));
 #endif
 
-#define __arena
+#define __arena __attribute__((btf_type_tag("arena")))
 #define __arena_global SEC(".addr_space.1")
 #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
 #define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)

>  #endif
>  #define __arena_global __attribute__((address_space(1)))
>  #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
> -- 
> 2.50.1
> 
