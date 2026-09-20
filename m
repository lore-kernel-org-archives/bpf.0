Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19F23E334;
	Sun, 20 Sep 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789884467; cv=fail; b=XNXj6fb0oorG/hqtgE4G41ixew725Ssc+IWt62JJBj+22++E45yNoDu1QFKaAj9LnD+4GzOXQ8b6WqoLIgCSls/LpBbZUv1x7ld7SsA+fRnAk+nq/FkncmwsAhZIRNZQr4SpSwefJcrDHK1d5A7ucy9Vv0w+CeSsATG2FjW7PEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789884467; c=relaxed/simple;
	bh=nEF5LJW+S1FzHuqfBZuEAPLGt2rA7gRhgBQ500D7IoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=isTMpWPTuZYTQoZbdrYCWavDZZtXFqPcwJCTkSteSxUGUdGAlffgGDoetOU/Lf561QYI4nIK1FnR5QM7/B/Wtqj5MddTXSMJhCcZ9OxPip2giEYQ0YIn+3ygTNp8V+Ay32/G79Skhhp1BKW+nTPlC6mWBDHCgQQSGq5+CKl7E6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQs5iYoR; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQs5iYoR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlVkvCx8Mmv0rxZpyVicy55vcXDJwqnAU6QuDRH7IXN52A7AVCkt8BdbiHYsQTg4yUKDSOOZUbTT+NLQuK0hM+w/YupicD0ZfQgRttIFcDaW3MC1nak8d77pPR3NIMosv00PpCJskHjL0EI5XRWgLXG0qpS6YnAW6forl7YfOEn55/3Z5ZzUmwnke8FeG8kl/+Mh24r61KnsoHuagcSzWppDd6jJjqW4rOQutT2JtHaW6KwG72UT3xq7Y3tQvp7SMIE2pbZ0GqiZkRF2xbKmD0GhiKi7S0tBbqtBMPE7qjSR8D27xfR1T03ycgNoI32Lb+Rs/LFpR9LPGPRs36NZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thVBHdCBSZ0P47TkNTx0eWBs8bK5Njkz3aFiAoJypyg=;
 b=LKyMbUVnZDCbAwDOOHlILl1TAfyb1xhethlcuzEIvLwKXbUoluj6ZGLeZYDwRUW1lkdLrsJVn0x98jL+2nLfXS8QBdXLFUZocvFhoUG5/TcCVfYXXmRy8cdKSZHqUQEJ03uaFKA7TkHhnk48/6F5hZ19N2ibbLndFkLHrBSi5B6CFRlwC9b5pNhuKXUOr4sQUvX98hTpEbu0HDCq+R7lBS+NO8/fGVyCmAHMrygmRAtr6XXspihhiUqoOFMMT3WNN6ZMYnSbTjBkYZ/b1KbANeY9+0sOI+jfORGu5mE+jGhGWYdNFyjFWeixXUicQvrZf0EyLQFX5hX5juLXw1D36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thVBHdCBSZ0P47TkNTx0eWBs8bK5Njkz3aFiAoJypyg=;
 b=pQs5iYoRgaVT6CiQCWqzU7rjIShF+4ejaHko/Qmpc9uwsNDzazQ4yX4knXCAVZ/aKWG8l++MuLJgMNYBaRHrgPv951CTsqoV95dTshtTqh4ZirALirelgXQivkA/hfF0QqDGI/V3x20YN169T5biBV44kgzj3A9azHfAZZbstVFafwwSuLxAWRCDWPihRvLqngJWy+0Hxeyvy4AuU3PJnhL388GfCnJC2HcJ7iQNkESUKDwanzICvYh3ffPv7BR79eTwe8M4R/XOj9mWZlACNSpVNzh8SgAad5oB17tWNxtmzRoIxT4xSupUBbXv9+JY+G3koDDygWgGAgy9Cp16Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 06:07:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 06:07:42 +0000
Date: Sun, 20 Sep 2026 08:07:30 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: arena: Flush stale TLB entries before reusing ranges
Message-ID: <aq94IibsdiJpcvSg@gpd4>
References: <20260919224616.3123513-1-arighi@nvidia.com>
 <DLJOGC7M106N.33I0V3YRNYB8E@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLJOGC7M106N.33I0V3YRNYB8E@gmail.com>
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 993c4a5c-d7be-41ce-24a6-08df16dd7af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	bkd0jVJfLy+s6Qhe7xleKN6NIYw40OA2TlN0CzX7zJlbwuB1V2kE7N1poMsBmrRc75lDi8oyXWyhGQqqqF5iWxGp66ned2HNdzpwgVRiBQX84uTX4JnFkSsmXd2VbkJ/RF5859bKCvT/MdFwvT9oTvBY1sS0FAFX3uFqeVVNhWRoEgI/WnUrpDEfe74yUUhKHfbYqDGwbzQWyJAgGdqjj+ZbPwgQqraTcifRmNGv0Vch6Ya5C/JqPn76wUIivG8d7MebaDLjcMfHljeUQTGKg4BdT9l8iIsz29x5FIsS8lvV/ZL3pCUDVMTYf0d13oBseSCytRvitw9q5oPf9BsCHy4TTIw0Uhqc4paV3/qI+iif4Spamc7pw44VcTooVddFMWAZjrZVD60+Oms4fVl9o+LKf17ZXIaLxSFXLQfQxoweD1jAbFcy6tQR5yTfx2N6mpimWHk++hE4K/ye10tZp+QpNpQfW8QNh8nd2I0wMKOOYs44CtWJFwASEihkFkHTozHj4mY9loULp6CkbbPknRCknzVsdDUN5GMDAwAqfEUuexeTzQ5SYVvyL61G2DmpyfSH8lfsI/ZgGRmh5LjIVM8JaAjASZininvLJ9HcIZS5qNVMo90hbx35GsQm2m4qdhYovBfHA5ZrS5tOwJCnfa+FDcL1li+a824+0/YXFak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4b41NSJfxbtkVQb8InaHoQu4rA7edmssad+TAE5PR/5ddoEeEcxfnKStLk6Y?=
 =?us-ascii?Q?CAgVIyYWw79d0jAvdOXgHnpJ1svPzI7dKeHPnNOgPkaHcVrDjbeXRySMsTHv?=
 =?us-ascii?Q?hj4akWXW9L3xkeflSpNh6Hpf1WGDMNzzKjppoaX/KS+LROyZhN8VpWaVFjeh?=
 =?us-ascii?Q?LCk2mSqe/fvYqzMS4YFQsI+z0DsbnTAv0wCvwn3atgh6txFpmyHXvg6kvmr0?=
 =?us-ascii?Q?p4P3HvbcQg0EgxkfAWxZxcnNpeu0K5VNe0yjtbW7//93z5vTOP3QUtqolRKx?=
 =?us-ascii?Q?4S7P91WR1YkOIZlzhjCCEwrp2Y0E3ErgJP5uQqAKug9snetNfP8MjaWgDqci?=
 =?us-ascii?Q?/pP2nT8892KulQlArQPg8PyuOD67D8pA7LvOuaPDjeV7Jos6cecYP814RLxS?=
 =?us-ascii?Q?xvi92hoAUmC99QW4m3rb0QO5Z2atvPPu3QNP4+5ysvvo5+Za1bVkRVtjU4lo?=
 =?us-ascii?Q?4goCh+cve1fslkImoOy1c7wEZujap3YOvhqEFuxmobhzWWCnGtuAwM1DC6Qd?=
 =?us-ascii?Q?xHEXnDtm8hqGLfmAzHhS1/pbufhGLhvI7TCL4jTNBOLxaMrtkBP47MQ57rAt?=
 =?us-ascii?Q?SmYCqx9gSMyHiBYXgBH3EkxAHfCOXKM/HUS/JipwindDcyOEq6RSVgCCZSW8?=
 =?us-ascii?Q?HO2BHsAwLe8TnrILSI/8GMmVjGEaWhlZSx7DtxJC1fxSccSWvTmOGNaacuRW?=
 =?us-ascii?Q?5PIRXIsKZOKWxdHjmvdmkES/p6ERxnIaDI9umLTZdIT6V+2wOyDxsaba48rG?=
 =?us-ascii?Q?kYXDYqWxy7YK+zUa4aWM524s1CCkWm9czlDveHUFXMz0z7AyouCOVLgdbFwl?=
 =?us-ascii?Q?QS7baSlG3MiteF3JUIObmsaqAfK7M1evyHkPFazzscm7HMjNs7Ch0uFyY4Hd?=
 =?us-ascii?Q?2QFi5e5BcnjeatWxz+C1WLsJh6w4Oo8uXLm/SvL4GAnvZdMoYj2NElqFzomY?=
 =?us-ascii?Q?rJb7zReWt0IFrq5OtwYeg+xejawY4aqZRudtj/vJCaTOU6DCk5HkOy7RvLPD?=
 =?us-ascii?Q?xPqtkTO21fh5wRepzHP9q9lqu5TAkuOI1Q0bzWx1m6xiEHx5xnN07dEzBGhl?=
 =?us-ascii?Q?WQasYClyN79O+oY53HO5QnjE/ETmWG+ccIZifPg8UmO2ozOVj1GnVZe2dfxv?=
 =?us-ascii?Q?25g8Y2brQS78ae9eKB9rlx3gW72ayfUXQM54GoB8vUX7F82djNkuqGMqVBbY?=
 =?us-ascii?Q?Fevt4X9iXpdsTb5t4Glln3HPWuIosbY1LVfbIXPeoi//imrpDfKK7z1go+oz?=
 =?us-ascii?Q?TsesAGzg2Ov6zwNnMyASoH3ws+hWX3hSs1PRVKvzPmtDltOP0k/phaAZGovE?=
 =?us-ascii?Q?v3WpkknT1N3Vr6z4TjghT0ZoKEcv8N9pE6VgsyxkI1r83oz1splEEEhwc6BR?=
 =?us-ascii?Q?oX8ZytJqMm5Ai57n175LB8nkEjCKpHnpNi1oJp5UNcFU8HBDljr7xHUN9fBq?=
 =?us-ascii?Q?uLmjFMBn3bEf2DOQ+YMgl/aSfaO9WcnAcpa1C/5Hq8fw9KoUMk7ZK5LYVigr?=
 =?us-ascii?Q?uHMliJV+QQdaSD2SUJkzm0i8ctPpHQXdinR/0VQc7J/JW94nunSeMongZU6n?=
 =?us-ascii?Q?VBQREQAI4Zed1hPYXyeZJq4dk+8uiXifPuwGc1vEoz+mm9Z2+2bHyqHMaHIO?=
 =?us-ascii?Q?5TV1I+YbPHiYOmZBWukZhYpkDt/YiqaGiX6vjq/+IZ0eqareA0FM3IEptRmp?=
 =?us-ascii?Q?v878LJhzg0cJ90qdatLpRBsF8SXtGwXNacZTUL2N2YLdPHl6Tpb3CWwqlzuN?=
 =?us-ascii?Q?IVCyxkoI6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993c4a5c-d7be-41ce-24a6-08df16dd7af4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 06:07:42.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzyFTnLhEQgraVWCmEOT808PkS9YO0IynH6MQWq0eLH0ZmQaXZae9PFQ5g6fi/7aiOvYU6phJOTV6K2yKgm8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794

Hi Alexei,

On Sat, Sep 19, 2026 at 11:21:43PM +0000, Alexei Starovoitov wrote:
> On Sun, Sep 20, 2026 at 12:46 AM Andrea Righi <arighi@nvidia.com> wrote:
> > @@ -911,11 +910,17 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
> >  			zap_pages(arena, full_uaddr, 1);
> >  		__free_page(page);
> >  	}
> > +
> > +	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> > +	if (ret)
> > +		goto defer_publish;
> > +	range_tree_set(&arena->rt, pgoff, page_cnt);
> > +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> 
> Now the ptes are cleared in one locked section and the range is set in
> another, and arena_vm_fault() can get in between. It doesn't look at
> the range tree to decide. It does vmalloc_to_page(), sees no page,
> range_tree_clear() of an already clear range returns 0, so it allocates
> a page and installs it into the kernel pte. Then the code above marks
> that range free. The next bpf_arena_alloc_pages() that picks it hits
>   WARN_ON_ONCE(pte_page(old) != d->arena->scratch_page)
> in apply_range_set_cb(), returns NULL, puts t
> he range back into the
> tree, and the next call does the same. All it takes is user space
> touching the page while the prog frees it.

You're right, I missed that range_tree_clear() succeeds even when the range is
already clear, so arena_vm_fault() populates the range during the
teardown-to-publish window, leaving the range marked free with a valid PTE
installed.

> 
> iirc Emil has patches that address this issue differently.

Thanks for catching this! I'll sync with Emil.

-Andrea
