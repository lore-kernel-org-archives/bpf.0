Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685E27AC48;
	Tue, 24 Mar 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364171; cv=fail; b=nbv9hCGx+tlOiL2q9CdYi3CUWJQkK1Aky+XrP7wNZTAgdVz5X9RFR+bksmeeXU20SK+z7Nz1lvSmgwI3CqYqRtlWkFVoaQ9dDzSmBZ6/KjQr4I6y0uAA9F7Z4poXC6mGJSgX2N/ljRPRAEcI9r/j82tbd5uo28S5zJoNhs49+ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364171; c=relaxed/simple;
	bh=fRi+Pq5/0IaVCX79rSffyovUNxPCd/+qcxcVg/8L2EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j78VuS3UYNfPzgVFpxFK0A1s5NcIe7T3kbZcUdpMT0v94AhbczgPQgAOoILEmunw9B+BTUxGSua1JyU+uhvcRncfy2sBAUZsswhBgL5H8FJc1Zgnift16r78wdRacaW5e1WIH9zjLG1XVghAyHorWzMD4r0GqykErTjSlmvvhL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHIkeeC8; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHIkeeC8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnF2HKiaP0CQA3/5br6QtuMcdymv57pAV7CRQhweQsvVd/nK5P4uV/+8yzTPdisk0QGD6po/3TX+MAfMzFVcabHVKvTcEM5lN2ZFvRW22XxPpVzISdg7NltUYaAxGSJbfpjrVc3L0VB+Tt2M3sHnqZiei+pU3wT8HswoDNeU7UGWb8f+4MA1I5D95Fh1BcpbcqyO8o6Av8t+MskCRynEPF53u/UOw1rfDuyzOM03E72ZT8AZJr17Wz4MNh9FfLdtwdKTtaE8e4UNhkb+gFBkGocBmKD7ltgJNA73TVASPbGl/08ANXB0vTk9rEVFwO7DtIECIf6HCF1gzMIl+0546A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ+ojWMYkevJfSrvpmZTmT/XiGK0/EFZYqgk7bJDrOk=;
 b=bTODubsRHXdHapI1tqySxswnqgI3dKzEPX7eCbPjm8o0BwYBYLEVmHDvAOx6RYThjScykl1ci5/Gb7zTxiNHMNkj6eZvarFfA26K7q+p3UfHwFdYtxm1NRF7iTaSGzK4N9A6bcfNTywKJHbw7f7MrA99VKMNZr+Ct5Qv7oJFpplsWpciV+ZxxcZmG3DfwyUGwdvUjla7HZXuudfiJsjXjPBDVnS1DAtBGEDV1uzoj0HbDhw0SgcnYJ9PSR+CNGOjH9yj6lE971YAT6tIQuBxlVmLlJ8sb3FbW9HapwBKPGBTSBDqnjgt9PUkCkvrZ7ptzzcapt15f9jXFReAYNUiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ+ojWMYkevJfSrvpmZTmT/XiGK0/EFZYqgk7bJDrOk=;
 b=pHIkeeC8GDOgZ4BUkwgviK0BYRFAPkx3P7flnigxmomgxnZ/6OXZjjTib5l2wjtKQWVC9EGgPIEj1jid7+s6xhxB/WcsT1ROXnmwAo6rZ+niS0av1KM1l6yMYVfZSTLetfQSpTlIqJ+l58a/wj/i9W87yaC6315Fdyf7e/hF5oiIkzqJaDqmMJUQHmPT551TzX4z7mH7R/9HASzHmvUVZ7jQi5kpPwUYDDBNraeKUSh6bh5wMO4UBO9gonOVtvZNpHD4nkfaolUethG/jeNW0xqRyIRhm4R1cyOyOZjy/qTFdNsXFb+w6vWgRNzGstLt7rDihv2D+tFjjcaKK7V7iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 14:56:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 14:56:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Uladzislau Rezki <urezki@gmail.com>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Vishal Moola <vishal.moola@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v3 2/3] vmalloc: Optimize vfree
Date: Tue, 24 Mar 2026 10:55:55 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <1D88CFF0-8A74-413F-9A6A-39E27B760AE1@nvidia.com>
In-Reply-To: <20260324133538.497616-3-usama.anjum@arm.com>
References: <20260324133538.497616-1-usama.anjum@arm.com>
 <20260324133538.497616-3-usama.anjum@arm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: c733d380-87d3-4680-9a4e-08de89b5767e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	a/5GBBNiPDV8PpcrBkKroQX7mk2LqChdN350/TtH53h884DtF/ccwhJvQeMOSDjbVXySdGLyTRqnLd4eyP/4gfSkwm4SVuLCfhlZSHCX5X9Dt/hw7Y+tLOJAQoIqO8XsJNjXA77JE2Ks2eZbmk7/feYWm71EEyrE4mU1kSnTM1kWpeuFV547S0iWfGpOxvmG+pheTFk1IoWn6w8idHwDZg8nUYv2IUvjikQUXDbwHUQv+LGZ/BCe4xZKOAYbqawGS2B1ymHmepQItimeTxuiOr1Vd7VJ0i+1FUJILHCeUEKLK1x1rjkyzg++rNTbzUzrg9Bbw/OFaUSZsODFnu6IuqKloL0jKCb/ru+t8AG87hMPF9x3yoxZFRsOtBq8uRYDM527/KJX/oKqOEoT/vzzEr5eFB0UD/MExMeob5SEVRf/oMRF1qJL1d+7ZNb20tAeIES1xxlKiPWmultbzd2DloWcay5roSw6qQXqQfsBaxMhnLLNLdhkRtCUiWMfNNmsxRx+G3QdxUHcX98eOI7gOsshj022QXueLzJ7QrIcx8KIKh32bvaUUTnhNUbQ933qQGaNDcoU+AyiBtiUA2cV6nrS8JQ/QAxAfLyRpVPiQIAYbL9377I+e8Ijnxz61iAidlzCp9mNAV65vyZGv1ndGXuJmwohcvWWx2plx66G2EqQ9pF8sU60i3DuxPNlWxB7yj7KWzCxkK699i0SEMC5+Nbtrm1qoUCk9l1TTJo0blI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Koj7Ls8bipygUOfjL37Mu+s4gan+JnbKo8VPYaf+Kf8rQnggxWTT6DOO6up3?=
 =?us-ascii?Q?LmUcW2G2Jg8hyVrsuShKwTUNlN+XQTuKWVkOAZeDvhfoj6CDFwTuy8xi+KPN?=
 =?us-ascii?Q?PmAMW9Qtp3r533FG3dPN4dARYmjn+l0N6/CYIU88SZkpVZMSjlNeQvb26EY/?=
 =?us-ascii?Q?8LrY/tEb8nUf3Etin3GjwSh47lnKsU3NTvUKsNf4XM7xPKtOoijZT00+q43r?=
 =?us-ascii?Q?Q5GglT9TxGiFFMqfI5XNkXlsSlhprwXVVjlRRWFMMovuMdxyztW0l5PDZTk8?=
 =?us-ascii?Q?6zg6JTb5V2Z2as/JZs/PZFkA+4DWVjPzVrthZPinU0VTPlW8vVvv7m4Y9A3Y?=
 =?us-ascii?Q?T1CjvtymL8yW8ZyAT5wdzID5jXQIVhqz9jrJv763WJIyElPMJoZqIaXd+pEG?=
 =?us-ascii?Q?OvgT1SRtK52w4TURqOgjdyW9s2JyyAINYMuJV+bMFArQWJhKprG3axrOZSbY?=
 =?us-ascii?Q?T6Wq6z4V4R4UBBxUlGpLJSaN5dZk2eVz+IpK5uhqt0e1DBMHowZkTN2rmyEn?=
 =?us-ascii?Q?zDV9NQfBNIA/bY49QKY95Qy2q0sWLAS3Fqt8DagNVEYNGN6qc0Hq/ejWIWHq?=
 =?us-ascii?Q?/JyFQkdjRTprIYGoYo5nMAEeKhWk88Plj1Uka+ZQmgAP+rcixAw7y/53ToXY?=
 =?us-ascii?Q?JZJGsq1vqRbOLCVZwurQCMFlF2TlvcQ9UPb6fGbl6Vxj74sqKUwD7FiCFgVX?=
 =?us-ascii?Q?c+jmemDMns0F2tXkZWMFVJVqifLhxy/iWgMgIBOlXLcuc8a2Gyot4VBAQ2J5?=
 =?us-ascii?Q?D4/LvzhE75wNaUGOaYg+z3peOMFV36fG8UgDlmzGYEDu3wwclQ6yoOkrAjR9?=
 =?us-ascii?Q?uHslkTJ4iN9lGJJuV6O+z7A4BxhviNjQGAdQR+mFmA00bXpHwDHBis6p5Zb7?=
 =?us-ascii?Q?ZzIGrnXncadHrWmQ7zVRzD/nQfzhOqedvBy1b7OoKFHF8PEUQlVSrb/TuR8X?=
 =?us-ascii?Q?KQ1RC0jzc81h+1SH+M9Rw0NcOpHJFTa6Ki5HpNGR0D6lFUjXVVH4kQta/3Rh?=
 =?us-ascii?Q?BopSKx+wsQK7wOug5Z4Na6Y8uEfjTsqt/oWe0rDTlZMqJ723VntThLloK9S0?=
 =?us-ascii?Q?PvMThnmvlQXsT1J2sjvDI/xwY5GtlIj/n6clFhJ4Zgw8c2U1h1r55ene8ri6?=
 =?us-ascii?Q?Cu856gD6pGmtfbq/mVZLBD75mLJHsYn0CcwIvyqOVFksle9XiS0Twz2c8tCn?=
 =?us-ascii?Q?ohVtqpRwlW0oZ2RAxtf9iQ00DzcxSIzmIEl2XcL/B+E/QiYGlZMU0GQUP+c7?=
 =?us-ascii?Q?K4p8zyTBHMieTcg0GbGe6L9VEDnUOEwd6MdSL+vktWFw4S6eAwpzWk0QjnWO?=
 =?us-ascii?Q?S8dhM1v/33Xbj0pJDB/a8Xfj+5z6nWgNFcZQq1whhr/hyii5SGrJNaBLTWX2?=
 =?us-ascii?Q?S9c6ChOi/fhNkyWKP+WKT/55vrSIs6J7nuVqMdnv7hcI6aFNj4iEF4biiVwE?=
 =?us-ascii?Q?6vCqOwpMelgbz9Z75E9WAqQ+gBn5LP3AnaZGk7KmmZeS1firJdISFdH+iTFt?=
 =?us-ascii?Q?8r3m1QNufkp0auMlP1KBXmNJ6kFAd77F49mKQsjyysl17WVvWipBxAwEWsty?=
 =?us-ascii?Q?EvuYNqaoRehg6AOaxBsVmY3f4bnJbaf7EDBclef+J8n3wJTn89ZfjiqZRuRu?=
 =?us-ascii?Q?93SOp/NYRcwTgeOcth0TriA9ieR08YjhhUgpmW0TXfwI11XS7NjoT4E7MqPo?=
 =?us-ascii?Q?Izu92ZzVmVUs3Lnfi1HHnjZyMnUKvAjnJUlkGkg2XsLP+iqwHNHkshbd0qe5?=
 =?us-ascii?Q?h7hQx46f1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c733d380-87d3-4680-9a4e-08de89b5767e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:56:00.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obv/PRJF0WD6ROLT/cORWo9o8tFCM9BK9mNP8fTiYVOpIQpNFFarWdfRUBbVBIyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

On 24 Mar 2026, at 9:35, Muhammad Usama Anjum wrote:

> From: Ryan Roberts <ryan.roberts@arm.com>
>
> Whenever vmalloc allocates high order pages (e.g. for a huge mapping) i=
t
> must immediately split_page() to order-0 so that it remains compatible
> with users that want to access the underlying struct page.
> Commit a06157804399 ("mm/vmalloc: request large order pages from buddy
> allocator") recently made it much more likely for vmalloc to allocate
> high order pages which are subsequently split to order-0.
>
> Unfortunately this had the side effect of causing performance
> regressions for tight vmalloc/vfree loops (e.g. test_vmalloc.ko
> benchmarks). See Closes: tag. This happens because the high order pages=

> must be gotten from the buddy but then because they are split to
> order-0, when they are freed they are freed to the order-0 pcp.
> Previously allocation was for order-0 pages so they were recycled from
> the pcp.
>
> It would be preferable if when vmalloc allocates an (e.g.) order-3 page=

> that it also frees that order-3 page to the order-3 pcp, then the
> regression could be removed.
>
> So let's do exactly that; use the new __free_contig_range() API to
> batch-free contiguous ranges of pfns. This not only removes the
> regression, but significantly improves performance of vfree beyond the
> baseline.
>
> A selection of test_vmalloc benchmarks running on arm64 server class
> system. mm-new is the baseline. Commit a06157804399 ("mm/vmalloc: reque=
st
> large order pages from buddy allocator") was added in v6.19-rc1 where w=
e
> see regressions. Then with this change performance is much better. (>0
> is faster, <0 is slower, (R)/(I) =3D statistically significant
> Regression/Improvement):
>
> +-----------------+----------------------------------------------------=
------+-------------------+--------------------+
> | Benchmark       | Result Class                                       =
      |   mm-new          |  this series       |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | micromm/vmalloc | fix_align_alloc_test: p:1, h:0, l:500000 (usec)    =
      |        1331843.33 |         (I) 67.17% |
> |                 | fix_size_alloc_test: p:1, h:0, l:500000 (usec)     =
      |         415907.33 |             -5.14% |
> |                 | fix_size_alloc_test: p:4, h:0, l:500000 (usec)     =
      |         755448.00 |         (I) 53.55% |
> |                 | fix_size_alloc_test: p:16, h:0, l:500000 (usec)    =
      |        1591331.33 |         (I) 57.26% |
> |                 | fix_size_alloc_test: p:16, h:1, l:500000 (usec)    =
      |        1594345.67 |         (I) 68.46% |
> |                 | fix_size_alloc_test: p:64, h:0, l:100000 (usec)    =
      |        1071826.00 |         (I) 79.27% |
> |                 | fix_size_alloc_test: p:64, h:1, l:100000 (usec)    =
      |        1018385.00 |         (I) 84.17% |
> |                 | fix_size_alloc_test: p:256, h:0, l:100000 (usec)   =
      |        3970899.67 |         (I) 77.01% |
> |                 | fix_size_alloc_test: p:256, h:1, l:100000 (usec)   =
      |        3821788.67 |         (I) 89.44% |
> |                 | fix_size_alloc_test: p:512, h:0, l:100000 (usec)   =
      |        7795968.00 |         (I) 82.67% |
> |                 | fix_size_alloc_test: p:512, h:1, l:100000 (usec)   =
      |        6530169.67 |        (I) 118.09% |
> |                 | full_fit_alloc_test: p:1, h:0, l:500000 (usec)     =
      |         626808.33 |             -0.98% |
> |                 | kvfree_rcu_1_arg_vmalloc_test: p:1, h:0, l:500000 (=
usec) |         532145.67 |             -1.68% |
> |                 | kvfree_rcu_2_arg_vmalloc_test: p:1, h:0, l:500000 (=
usec) |         537032.67 |             -0.96% |
> |                 | long_busy_list_alloc_test: p:1, h:0, l:500000 (usec=
)     |        8805069.00 |         (I) 74.58% |
> |                 | pcpu_alloc_test: p:1, h:0, l:500000 (usec)         =
      |         500824.67 |              4.35% |
> |                 | random_size_align_alloc_test: p:1, h:0, l:500000 (u=
sec)  |        1637554.67 |         (I) 76.99% |
> |                 | random_size_alloc_test: p:1, h:0, l:500000 (usec)  =
      |        4556288.67 |         (I) 72.23% |
> |                 | vm_map_ram_test: p:1, h:0, l:500000 (usec)         =
      |         107371.00 |             -0.70% |
> +-----------------+----------------------------------------------------=
------+-------------------+--------------------+
>
> Fixes: a06157804399 ("mm/vmalloc: request large order pages from buddy =
allocator")
> Closes: https://lore.kernel.org/all/66919a28-bc81-49c9-b68f-dd7c73395a0=
d@arm.com/
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v2:
> - Remove BUG_ON in favour of simple implementation as this has never
>   been seen to output any bug in the past as well
> - Move the free loop to separate function, free_pages_bulk()
> - Update stats, lruvec_stat in separate loop
>
> Changes since v1:
> - Rebase on mm-new
> - Rerun benchmarks
>
> Made-with: Cursor
> ---
>  include/linux/gfp.h |  2 ++
>  mm/page_alloc.c     | 23 +++++++++++++++++++++++
>  mm/vmalloc.c        | 16 +++++-----------
>  3 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 7c1f9da7c8e56..71f9097ab99a0 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -239,6 +239,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, in=
t preferred_nid,
>  				struct page **page_array);
>  #define __alloc_pages_bulk(...)			alloc_hooks(alloc_pages_bulk_noprof(=
__VA_ARGS__))
>
> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages)=
;
> +
>  unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
>  				unsigned long nr_pages,
>  				struct page **page_array);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eedce9a30eb7e..250cc07e547b8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5175,6 +5175,29 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp,=
 int preferred_nid,
>  }
>  EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
>
> +void free_pages_bulk(struct page **page_array, unsigned long nr_pages)=

> +{
> +	unsigned long start_pfn =3D 0, pfn;
> +	unsigned long i, nr_contig =3D 0;
> +
> +	for (i =3D 0; i < nr_pages; i++) {
> +		pfn =3D page_to_pfn(page_array[i]);
> +		if (!nr_contig) {
> +			start_pfn =3D pfn;
> +			nr_contig =3D 1;
> +		} else if (start_pfn + nr_contig !=3D pfn) {
> +			__free_contig_range(start_pfn, nr_contig);
> +			start_pfn =3D pfn;
> +			nr_contig =3D 1;
> +			cond_resched();
> +		} else {
> +			nr_contig++;
> +		}
> +	}
> +	if (nr_contig)
> +		__free_contig_range(start_pfn, nr_contig);
> +}

free_pages_bulk() assumes pages in page_array are sorted in PFN ascending=
 order.
I think it is worth documenting it, since without sorting, it can degrade=

back to the original implementation.

> +
>  /*
>   * This is the 'heart' of the zoned buddy allocator.
>   */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c607307c657a6..e9b3d6451e48b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3459,19 +3459,13 @@ void vfree(const void *addr)
>
>  	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
>  		vm_reset_perms(vm);
> -	for (i =3D 0; i < vm->nr_pages; i++) {
> -		struct page *page =3D vm->pages[i];
>
> -		BUG_ON(!page);
> -		/*
> -		 * High-order allocs for huge vmallocs are split, so
> -		 * can be freed as an array of order-0 allocations
> -		 */
> -		if (!(vm->flags & VM_MAP_PUT_PAGES))
> -			mod_lruvec_page_state(page, NR_VMALLOC, -1);
> -		__free_page(page);
> -		cond_resched();
> +	if (!(vm->flags & VM_MAP_PUT_PAGES)) {
> +		for (i =3D 0; i < vm->nr_pages; i++)
> +			mod_lruvec_page_state(vm->pages[i], NR_VMALLOC, -1);
>  	}
> +	free_pages_bulk(vm->pages, vm->nr_pages);
> +

stats is updated before any page is freed. It is better to mention
it in the commit message.

>  	kvfree(vm->pages);
>  	kfree(vm);
>  }
> -- =

> 2.47.3

Otherwise, LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
