Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD7403B1E;
	Mon, 19 Oct 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399756; cv=fail; b=g7cfNNKilbSe23ptn2HiNXIH6Ma8nYpm6vB6vu/CiWk+AP1HLbZiN1XcRShsM98X9MI2Pm+Y9zjO+VF47tt66mq9s01nRMtWW5B3ojdqf8zWaKEORHNn9TycFjk8sn+D/vCa/UX5DzB2QQ4C+n50snCxurPlpZGJrolbOWQoG7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399756; c=relaxed/simple;
	bh=cWQuO7XN8B7utgS3KDqPN2wHEgaWFdfkKwqPLiV7GY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r5danHBuiMgA8tBEPqGTWhEiu0bDUVh8dEYkeRd8TBwQUzegaP+8O116knQ2geiy5jeCc/Bsb/8onfMYxZsTwFrZYsjjhvO+JYq1h/UT8JvZET4P1+9Op9JoW6mt1Br2jBNwkNDe/CEw4TitAM4xlaPcYHSbejXxaL0FkCPs4j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXC9CiJn; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXC9CiJn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux2dzVKsm0ll0arVAwRteYFQUkXJ7h4vbz2s1vJW/eKWb0QSavCiost21pNuNwsbi/iBEjwJDMFN6WF0LqKjf83VVjhFb8AsVKYU7M4VrlQmb1PCrzbkcAQJOMHVrFXZfi/8J3YFbnFqdQWrZhyldkFo0igzgchMUEo5/TeyYa2SENsBHT4xWHJpVUxd2o7I4/K7nryKQJeVDR53HHUZiB2nwrLCWPMp9uWApjlNr01+hoDNsiWEcAZbgCllovPQxCWaGnlx1hePNbxICxUPX0UkA7Z9Wey5OATryB+HeceIIJaCTjxi8ODQnRkNlEwyRTvk9eUc3OkhQ7VegI9Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H/GjYHbJ8ODpkeg/Fhg6CLRDun78jwPzlg+cyej/oU=;
 b=XvCEOnWUMioSZNU0N65QmS89cwNgCh0VllBBiYQlxddwhCoSdn2gKmXVIG4ncV6ojL84Lh2A88b2cv5lR3uDMxZKjkq1n1wCsT2Iw/YTqxzNz4wKUQYTDF5ZG8b0vXtXo51N0Db0lQA49MMz8nIp328TGFZKydizlXpOnukLVslJ5DFJJUdryKoFi1Fy/El6X1sXTguAVrfiEw3Agzm+F6dVD5z6Uy3EWvMABXK8oUDwRewErZ+S2Vh0tXCRI1GaejF95eexlxyod1a4zrVsSglpxN9GGP4I7ns6yB3c/xCha4EabOU5M/C8xdrDIi5sc1LzRw2adL149EMtsWqfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H/GjYHbJ8ODpkeg/Fhg6CLRDun78jwPzlg+cyej/oU=;
 b=UXC9CiJnetCMoQcEvigYw10gLrliQvtfkNkHl0ZpUl9HU391cesfLcpMA5tNn6J41IcsvEx+PkbCzumjmXnsozxOfLq1ssfwB2ecZwXlorF86OUgsFTiqnFc4hBX1mYySPuYvXTX4roQx9Hz2HxSxP2mAb60blzpI6PnACPtgr8erJ2dent6wd+yUk4fiO4iHjwrNnoK2n0QE6Bb/HsLlfXgJNUpne4f+OkdMIREGVk76f+XcTad3aM85aBkVOMgN7B9052eRNznilfA/hSdz83tS/wS8PfRDpVUQ7Oe6TKRpCRLXG6k5emyp088CbUG62vBFI8IQBhKkJMYbE54yw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:49:10 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:49:10 +0000
Date: Mon, 19 Oct 2026 10:49:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Josh Don <joshdon@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs
 files
Message-ID: <atXZf_TmHk7VkLDv@gpd4>
References: <20261010224902.1232178-1-arighi@nvidia.com>
 <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
 <CAEf4BzZZRrD86ZswsB2r-swqNi7D1p52Vs=fQ9MXSgGATN31Jg@mail.gmail.com>
 <DM7JXB4PREVH.1BHG31CCNRXF1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM7JXB4PREVH.1BHG31CCNRXF1@gmail.com>
X-ClientProxiedBy: GV0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::19) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d9612a-2e0b-410d-a961-08df2dbdd7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|22082099003|18002099003|10067099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9vkGjmAz+IfwVHrdj0PlD7kOMzI9QnFfD1Wd1k69TcUkRN7wPpzgHbTFvDmk0abeJc7bBtEGCfJ++x0tMgnzDyDNiM53COlErwYtHTIQc8ikle7PGqsGWZY0DRs0cc9+LLcTeHlnGA4IHybsH8jD2vXXlDXarsm0rjuUSbchPKain9VcjZHkQdWFoomHWROcAOkaFucj5bOgcmPv7BOE4T03pcMCT9nBnpCQbWlw42551syKE0bLSJEIbOkEIgmuJyagx697H8FfEPZWuG0YdYys8DJLHzwKL6c4pGj10Kc5FHf/qKhXRpcb3zCExlJg6PByksibJnHUbWa0q0U2btRyHepEdWD9/gbdj+8lypGMBCd+3Zc4zbD1LKBNlnWAc7zmi6ScCRsCW9C/P8cSmFzwl7HZWyGV5wMXnq9OR1ySKdEmdjWW/VDZ6oFdK9O0e5XWUsEru+0XOXNDPubkFWMpRJ0xgAwvQ1BMkIZgtKE+TN9kY4hCgdgfzBeGYLA0Th0yk5YNN1MXTTKKHP8S6jqS7jTMdLo+zEuwSezMkCq7+jo3evp8Un83pg/45i+FMyE4S5aI6FUtsmElwk1OdFj7AbFDIAf6ZsG0zBuXVa1pJvXS55EJmcwshdjHu3jjANJxbGgwtX/ks0WC6uTKERmfC6AqnOpZu36EA7onCbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yv5dEB7kdesbNkjm6/ybfssKJfrkgjAiXYSmLJrr6I/7e+FSgMHzDJyFhOS/?=
 =?us-ascii?Q?WxgYnCLPy6iJi3wu256ytMcBXS4VjpQgyjiLY8vkiQKy5YXDdzdkZ0tQ1uSM?=
 =?us-ascii?Q?9RvehSyeIRmKwPE7KmbUH4Kmxh7cyQ9NMAw4LsWVVQkeqPoo9yEuE0Qz/y1+?=
 =?us-ascii?Q?rvLUZ4HwLhhbOSuvutBzjnqCID/gJ5sjNWx7X+XLxxmyFoxzPNtJAGS+eYIp?=
 =?us-ascii?Q?fdjcFjDg0VktiJr0k3yQLHxndzOdkaw6mIR8UnPYu2Iza0kCXOzfNqPgrQmz?=
 =?us-ascii?Q?OkVU/+kVkPnj86QH0gykvFESSN0ktGJ133CBpu7dJMyvjfkW9gXAfSeBR3IG?=
 =?us-ascii?Q?BGRL3EFC/4IYD6X7DaTRO+NKliuzSgZ+ENy1j3KYd/+3ZvcWFGp/T/qeDkAY?=
 =?us-ascii?Q?vCqXgp1efuVi/bMV/RLh1gq9WqnnsgfDAM+pXV+gnG4ufX6DKyEE9FeswRwN?=
 =?us-ascii?Q?Yb1MCJGqmkBybncMYM2jYEE/8fpKSakpikiWWBwgOEiI9SZ6GtCFOuI5ELfW?=
 =?us-ascii?Q?XMnnOCMSwBvJLoZYYNjYETFTLHHtD1sz7ud6XXgxdrX5X28Mp722M9B8mMOZ?=
 =?us-ascii?Q?zQ+UdYOdSUj3MgW8bC2R1/7uRr4ZMw0dIF8wHSA65TxjHSSDcIoCKJX4tyeq?=
 =?us-ascii?Q?l/voA1h/zo9Dk9czQrVkHb3nylNwNPOg+eg+oVgvMmt/DYiomaLwpRA0cJtY?=
 =?us-ascii?Q?lAU0axLnBYu14+eVLDMrtSaggsb5s8PzrXcUuBIBYkb8rQGzA/7ZAmymcgXa?=
 =?us-ascii?Q?PplHJiovFr50BqDJl57z3i3DKOxW2tgbUBYmXtXBhOMU7Dfi8Gp5/TGCsi/J?=
 =?us-ascii?Q?S0h3O3C6LVn/h2beoMyoeWFHzN2nKkoRqWHtGv289UhiczZHeS1xg3Q437Em?=
 =?us-ascii?Q?J4N+L/gNR/yIRXX5tp1VslCOg4O2kz8ZZ5yNER/bifvK/C0LcmCBKZyUguuK?=
 =?us-ascii?Q?qvzdxme0rixDF5zpQ+b1MCTMTb+pWRLbJZITRJBWiDakBXZpBb31ZfOawrro?=
 =?us-ascii?Q?VwVPSZT4xCv6eOLFXcE6q03dEc3jUN+Rn1kaMiT+43ZoxPY3L3xdtezebQv+?=
 =?us-ascii?Q?G5ueZHtIMDX2HarK8ETOphjnJGycFLaJZCLm8SdZmMhw93ncdnWZGDidTZYg?=
 =?us-ascii?Q?Xbt2iLLcxdnCsor9Zm1y2F7MxBMaO9SaPXKBJ+MUF4fTKobco8iReUK300ur?=
 =?us-ascii?Q?HE1ejwDCze/geF3YxYO/9oR1/rpQ8J+PQ79NcXg97o6m6sYv6x3yXwc13+6S?=
 =?us-ascii?Q?GlKgfPzjzKjReT8GPZbj6ieh5y0Dk+GNgmnfhPZ3QOBPjWmsodxj4vY5uGSE?=
 =?us-ascii?Q?c8MiStRACw2syUoGTZST853/L3gQKY15XhrppM+FqU6Pa710Ew5fq0+oegXG?=
 =?us-ascii?Q?s4G2U2L5syg0l1dTULh4+z2G197lbA+t0HH2Ze3TeLiaAa38RiepXaOKRKwg?=
 =?us-ascii?Q?DquwBlMH63N43ubd0DadVylY0VKRhffUjFX8pkhg3PiFoe22TCglTIRTZD/D?=
 =?us-ascii?Q?RgMPG2j21kQKXBPPdiY72t5T4yDzzcLVS4U4IGvyewbedodN1700xFHMfZ4s?=
 =?us-ascii?Q?nWj0s8MKzyT1qjyuMhnLh3UZsA4l3KBQ6g6AwWYivAznwNQ2e2Cry3acBSEJ?=
 =?us-ascii?Q?c5vm4t34068buFynBQcSHsDfYp7LF8iN7VA8wxTJJRpZgTwrEeP6nPxtp6xu?=
 =?us-ascii?Q?ywrn0Acl80wgX/yd5xDN3s9lgjYjMRUAWvlq+bcGEsKr/5vF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d9612a-2e0b-410d-a961-08df2dbdd7c5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:49:10.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lPPmOzWpERL90/UBN2WHLs98RUPLmA2ncW+qhJLk87B/tc+SOQuiqWOazBvl/d8CkOmydY0fDncaSLloADnrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807

On Sun, Oct 18, 2026 at 12:52:46AM +0000, Alexei Starovoitov wrote:
> On Fri, Oct 16, 2026 at 12:52 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > kernel to do that. But once we have the ability to create ARRAY from a
> > bunch of pre-existing memory (e.g., from memfd), this can be used both
> > in a guest and in the host, and both models, guest allocates or host
> > allocates, could be supported with the same model.
> 
> I don't think it will work for their use case.
> With array of maps scx needs two lookups and two NULL checks
> on every access, and the result cannot be kept in the task ctx
> which is in arena today, since ptr_to_map_value becomes scalar.
> unless everything is converted to magically bounded array, but...

Agreed, from a sched_ext perspective, arena is really what we need. Most
of the new schedulers already keep their per-task and per-CPU state in
the arena, and an idea could be to link that state directly to the
shared hints, e.g., keep a pointer to the vCPU's hint slot in the
per-CPU context and dereference it in the hot paths, without any lookup.

Andrii, about the 4G / single arena limitation: for this use case I
don't think it's not a concern, the shared part is a few pages per vCPU.
Having the shared pages in the same arena as the rest of the scheduler
state is exactly the property we want.

Thanks,
-Andrea
