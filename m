Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AFF374745;
	Mon, 19 Oct 2026 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397859; cv=fail; b=hvoV4IIs3uvz0VU2ScDb7flVD0Ms2a57TI11wH1TZU+HcGnnyj7W7VzgF2/X0CSCUaASuIxdxhSXP7ZzxRX5/qriDsXv0KTXssjG0dFrLctZP315O2IfsVroYAtXhFtfo0nSojjv6xZcbzQbY3mEfaWPItwbVgc2NTox4HrN9g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397859; c=relaxed/simple;
	bh=jQuAGzgAfKQHrnfeIgIRNCZBIGQKwl7gdV9zAN6fBK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tph72lzo/Yg8oBDOQJX+776gABa3wHM6wS0qYkEj/S0FTaZXaIws+JaEAAYPFBNK44e/sWndMOWY6XsuvV/7Mmgsg5MFX4BIWPqrmfoKS6FrDUIcxvklOuDoyqnEeZJ5q68CLCY1YFGEQRmJCq/xLgr4Wcii2alA4Ve1qFmJ2h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p35W4jWL; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p35W4jWL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgO0FDS69P5zOTM3ZvLFNQEU3JBB/6EmoNbXlehxa46WuYC2g2jy3r0fsimHekYfVxZKoyyhVy18B8KUv8afL+QHSbMLXQd9kI07ZXbA6BRVim4NiuGnHiUJiLWDh3sONyL8mRlILGsvUXKBA0IJ3GP2GRxQZVgw22LR60w7EAiXUyHp46jWnPYTiRR5+I46jYc1Go5XpPG7Z4RNWQWnPksyYXutS+RStY8uFIZKfsOrdJKEmPejEZpy35xWkq3d5g2yZJXTO4udCOn5M7K03nQuFyePO8+skczja/hAuPbMQTfTb0dqmb36ujne79kSY2361Uw+HUvIJmPZxV5WkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW3NAufHQn9aiiFJ8wnFbWin6R69VwbJW/HRBuyCOHQ=;
 b=uuGARWM74paeYBm71FggB9KKffb16DP6KfaFP9DSMuVIZ/gE797T/oV/VsehnbBO0TVjAz8PCL7VTU0rV6EoSLBts8V/ko0YMJslzhnJFb1OQp/RZFQsXtzY7ZzBGV+YBL0MkM6S9WX7/teoy85FP4wDjYkNmNNrMo/TZY7e3VfGSbd+r0o/A6atUbiDDI5OR0ngslMtHXuygMdLoLk2RuR6ppFUDxtrhMwvxjhSeBOsaM9BDF5vTYp8P2LwhlF0ipAiSdthTEK/3FF4tdRmOX+BlUw6jEC4mVr5QjjYqwBH1WK8uJtgPB9SJecIvm1/SxUFO35BWcd2ybB4VXoPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW3NAufHQn9aiiFJ8wnFbWin6R69VwbJW/HRBuyCOHQ=;
 b=p35W4jWLHq3pfAOKDT5btcxzzSMVWlV5s/PtYDaPc2+pkfUAUpN8eI/xxZ5zLinVxEp+lck6akwLorGP8jJMdbXUbbk4BL5qS/J4ldQW8p8s3+ZllKC0oE9ChW281JEGWna0GTtkEwPais9v/5dAcVW1D/upddJZnk6by1Zv5DcP8ju7Tc4PCwh7t14Kvbddqi77TN0/cRr6lC87U0q0+C1BDQMs3j2bC1WUpNRHuh8DNkV0YGE5D4ueF1jgMjiQfXXbCEsLeSb9u60/8yqLHaU7F3R7K9TvABlJ+fnekdxTAYXB+XGqrjfs0Qs3gPxovNpOVek/OLcxnMgf1sPS7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 08:17:33 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:17:33 +0000
Date: Mon, 19 Oct 2026 10:17:24 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Josh Don <joshdon@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Vineeth Pillai <vineethrp@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peilin Ye <yepeilin@google.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs
 files
Message-ID: <atXSFGAa8sfc5sRW@gpd4>
References: <20261010224902.1232178-1-arighi@nvidia.com>
 <CABk29NuGMO+HUQzegh6mvy2zjQRD=-rOkiroeCwyTEAeTTsEZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABk29NuGMO+HUQzegh6mvy2zjQRD=-rOkiroeCwyTEAeTTsEZA@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0195.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::11) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d78d684-68fa-4ed5-9509-08df2db96cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|6133799003|18002099003|22082099003|10067099003|3023799007|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	eMGjgOiRm2XfL4ptV8v1iGOOGgUM+MZ3l0kJGow+ybrB+rNbzHxrZHq924nd+utaAVjnmuG+OQ7ItoLYSUF6Fj6251Mp9LP5rza6dbcX8IcLSFFeKYPBU/VAgUMZQlxIZ+OhGr/KQpE7EIbbWhUSFKquJrEhLOf5P04qUG3oZ0nEh+OraNCo6rBZjif2gP/AKt3opt/XOIcx+vgVow7v3GKb+Nxy5c+ik+V13wcGXkNsBbB1Ye5+W+boZ+g740zYIHoqWfYSyII2j6ZcZIOmFc5iPMua+hTag9Nvh9ipL/MsX6KlZVCF8jTmYVzfflVTa5OHj8UKZsL5YYaaw2dd3+eCPwku9LBpTIEbWptXHhDQjNfbFn5jmG+T5OR36SyfGwg+pzLox3CD7oAvBTrLo4n6IM3NohzrrIy/RyzevU6OL35D/ibSIIQ53SEItKlDlbQyrI+Znr5nYO6f0nti2/piO2xBsxnhHjNVnpVoPKgD8jFCkYf8TDKFjrDio+NaxSMiedp1CCmYFqqYWDDSiB8qbX/a0y+TRSzwoaN5Jtb1ww06o8YizDLSqCnSxKbQQ7umUyAfB+2JpbXuECEU3E/Y9puq//t0Anqks42R0HEHrTEfBulkQWT2dXIasAS/2F47IECUGCSLKqseuunz5ybra5ZcezR00JuGeYbDvQM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUR2SGoydHo0VDFxeHNGeVg2Qno2cUJDOExtNUhsWmI0VHlSWUxSOThYUEpq?=
 =?utf-8?B?MjlhNm1JSVpsWEpUeWY3T3IxU2ppYWRxYUxMUDVLQXFyc0tqNWJWVHBKQ0h0?=
 =?utf-8?B?dHpFTWJjYkpLNXgrL0JJT1oyMUFJbW1vTlRCaGhGUTlKWTY5dHFSTDZFUU9n?=
 =?utf-8?B?SVplVDR1cmJRNWhxVm13Mzl5UklFak9LVVVZa1FHOEpNSXJKZUQzdmJ0dldu?=
 =?utf-8?B?VFBJT0kwNXlLalJsNEI0QTlGYUJzODM2ek50Sjlxd0V6SFNyZzVYbW43cjFi?=
 =?utf-8?B?ZFptRmZWdFE2N0RvV2NtS2RrM3UxejVrWEovNWJ0TmllREJjNmFISXFWYVc3?=
 =?utf-8?B?dUtFYjNWTXhIdTNleVEzaURNM2ovVDhMc2ZQNFoycFE3dFJLb1JSZGptZUxI?=
 =?utf-8?B?VnRPVGQ3NFlMOEdMTkNYWWk3YlRWNkJSaUtXRjExT3IwZ3JqeVVhaTVORS9D?=
 =?utf-8?B?ZWFUS05kcXNpMFJQMjVoL2N4MnFqQy9RYXJabVVzNXBNbUV6WVQ3b0F5Y2p2?=
 =?utf-8?B?eit1bzlqdFNZbVo5WXo4Zi9obkdhNjdWZUJqT1lqeGdvM0l3aDZBeGlDUXdF?=
 =?utf-8?B?dnM2S012WWEyQWFnOXN6K1VuNWxFZE4yZmJZWVI1NllpQkh2UzVyZ3pvUGt2?=
 =?utf-8?B?Qng1eDdjeElsa0RDNjE4NzMvNWc3YVVnNmtmM1lUVDVsTmI1eDNIczFCUmo0?=
 =?utf-8?B?MHVJNU5pMlB0QkxJODk0QmY4RGNrK1BTR2J5Wmp4azdKbCtBN0JiekRUdXll?=
 =?utf-8?B?a0xrZFk1UmJDak5EOWJmNzhORDZyOFJSZnBwTlQzUGRESEZncU9COVlnQWNx?=
 =?utf-8?B?VTFnMEJZVmRPcitrWVhobXJoZFRQVkVxRHlxSk9pd2ZQTmI5V3h5TjZwOTlB?=
 =?utf-8?B?ZlFhTVdxb0RHS1ErdHRoTSs2Q1dzSTd4aldUU3BPZHBKb1ozUUtyVFJGamds?=
 =?utf-8?B?T3VCV0JCeTAxQ2FFUUNXVVhVZWUzS20wYTRlMlczYmJ4Z3Rsb1FkYmd5NTJU?=
 =?utf-8?B?djlIZElLeXFJRGFxbjFSUFpYVkR0eTVaa1FzM1VIa0RtQW5qaHZIbm1vQXR4?=
 =?utf-8?B?QTAySmE5MExUVlphZUdIeVNtaWFXaitwQ3pIZE5BWGtFRlM4NkJOVGlKc2lE?=
 =?utf-8?B?THd0S3BNcWRYSnJQa3pzb0xiaTZacFpxWlozOG9Gc2ROcW1lYzNjdWN0SUNJ?=
 =?utf-8?B?NGVkSWxOaXROYmljS2wyR2hZZVQwMzV2U1ZDRzZlUFJ3UFNnbUZpV3VEWDNM?=
 =?utf-8?B?VlRRMVRXZWVPZ09TTXRPOTVnMHB3OVQ5OEdpbnlVdFkrSEhNL3FQRnZBQUN1?=
 =?utf-8?B?Vmo1ZGp5UGdSWlFQNk1BSVd1bEwra1NhalJmYnFMY09LQklhOXRDeEovMHIx?=
 =?utf-8?B?eFVZeDlBYmhTbjcxbzJaUk5mWFl3NitOQVFLYlpyeXBFWWgwZ0YweHdsS3By?=
 =?utf-8?B?M0NNd3dHOEJHQ09rSFU1V05QUHVHUGFKKytVczVLTWN5SzE5M2ZMNy9rY05x?=
 =?utf-8?B?Q0R1NjdyWXNqak5wa0tMM3ZadTRCNzlHelB2YmM3ZmpldHpTTTJLY3hJblYr?=
 =?utf-8?B?RlFjd2ZPdVRXdzhGbmZabGo1MlMveW9VRDZ5TWJRMlUra3l1dVUrMDN5WUoy?=
 =?utf-8?B?WXlkMlBHZllVb0lUaVg5TFBlZDJsNWVDcDRYaWU3aWU0TmMyRGRPdjFEZzMy?=
 =?utf-8?B?N1EvUWVDSHpUVmFPdFhWa1h5TzJuS2JMeU1ZenZPY2RoN3dvNHVNR2dVSUhJ?=
 =?utf-8?B?WDRXNm90cUtQNU1lb05CbzNXQ1ZsRkpxQm44clBuWFFGY1l6WEZDQUpZbGZa?=
 =?utf-8?B?NGp6YjZtemV6TTBsOThkU2JkOHEvUG9CUGV1Z3lITTFhLzlCY1F3N0FoWmxw?=
 =?utf-8?B?blpwTTh6NWJhUmUyOXlWQ05XUjJPdjI5Uk1sWDBvaVJoQ1ZaVDRwRFU2L0hZ?=
 =?utf-8?B?L2xxRHNROURwU1UvWG9EYjRkRytxb2tIQnRxZkpmSnZxUU4zRzczZVNNSElX?=
 =?utf-8?B?MW9keDZJRXRQdG9SN1RMV2kwTU5LaWY1QmVYdittbU16K2gydXVXQzRDZDdq?=
 =?utf-8?B?dGpIMHN5QmxqWlplbVdieVFjQ1FUSDJlNktLV3BMRUFtWTUxaW40cUxkZkFO?=
 =?utf-8?B?RHFnNTA0bGcvaHpIQVBMUnpORnhQMDZXMll2VTN1QzlOKzQyYis3K05DejR1?=
 =?utf-8?B?U2dDR1dOcmZMdUhPZm1kQ29SeU52UUc2S095a2JVOWVhUjJ4UnVEamcvbHUr?=
 =?utf-8?B?U3JVYlhWVlphaDV1dk1SWVQyRlVUZCtYdkZMdlRMMDZDU242WlJ6NWJVSlVy?=
 =?utf-8?Q?GZdqJQGtDJOSKdYuhi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d78d684-68fa-4ed5-9509-08df2db96cfb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:17:33.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1BRwFf5vcGkrgLkC4hwXd8s7FXENNRkF9xbtoLBuUSNPQZo0s2bprGvLO0bYq79EDhm+rRGkCAltg2lmA/A7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

Hi Josh,

On Thu, Oct 15, 2026 at 10:50:02AM -0700, Josh Don wrote:
> Hi Andrea,
> 
> Thanks for sending this out, I'd really like to converge on a shared
> memory model that will work for both the goals of phantom tracker and
> for pvsched :) Been thinking about the tradeoffs of this vs the
> current structure of shared memory that we have in pvsched v3. I think
> this definitely brings some nice properties, but I have some
> questions/suggestions inline below.

Same here, thanks for the detailed feedback. As mentioned at LPC, I
think having a generic BPF arena based channel would be nice, but it
doesn't exclude pvsched / phantom tracker: they can coexist, and ideally
they'd share the same underlying mechanism to expose the memory to BPF
as an arena.

That said, given your points and Alexei's follow-up, I'm going to drop
the NUMA node / sized bpffs file approach and rework the series around
arena importing external pages Some comments inline anyway, since I
think a few of them still matter for the next version.

> 
> On Sat, Oct 10, 2026 at 3:49 PM Andrea Righi <arighi@nvidia.com> wrote:
> >
> > As discussed in the BPF track and the sched_ext microconference at Linux
> > Plumbers 2026 [1][2], shared BPF arenas can provide a generic channel
> > for bidirectional zero-copy communication between BPF programs running
> > on a host and its guests. One potential use is to exchange scheduling
> > hints between host and guest sched_ext schedulers through shared memory.
> >
> > The goal is to let both schedulers access the same underlying pages as
> > BPF arena memory. Exchanging hints then requires no copies between
> > separate host and guest buffers. With the arena file interface proposed
> > here, the setup uses existing QEMU/KVM memory backends and guest NUMA
> > interfaces, without further kernel or hypervisor changes to implement
> > the communication channel.
> 
> Seems this relies on QEMU support for supplying offset+size for a
> virtual NUMA node; looking quickly this would seem to need additional
> work to support on other VMMs like CHV (and especially crosvm). Not a
> showstopper but just a comment that I think the PCI device model is
> easier to integrate in other VMMs.

Agreed. The "no VMM changes" argument only really holds for QEMU. A BAR
is a more portable contract between VMMs, and in QEMU it can still be
done without new code via ivshmem-plain with a memfd memory backend,
which is a nice fit with the memfd import Alexei proposed.

> 
> > A host scheduler's userspace component can create and pin an arena map,
> > then use an arena allocator to partition it into per-guest chunks.
> > Userspace passes each chunk to QEMU as a shared file-backed memory
> > backend, using a bounded offset and length in the sized bpffs file.
> > QEMU exposes only that chunk as a NUMA node inside the corresponding
> > guest; the rest of the host arena is not mapped into guest RAM.
> 
> So this is the host allocates, guest uses model. Contrasted with
> pvsched v3's guest allocate, host pins.
> 
> Guest still needs some way of communicating back to the host which
> pages correspond to which data. Ie. a mapping of VCPU -> address
> within this arena memory that the host can then use to lookup per-VCPU
> info written by the guest. This comes for free with the guest
> allocation model in pvsched. I see you allude to this requirement
> below.

I think the vCPU -> address mapping should be a protocol between the
host and guest schedulers and should stay out of the kernel. What's
missing in this version is a fixed rendezvous point: with the NUMA node
the guest allocator decides where pages land, so the first offset has to
be reported out of band (the selftest uses /proc/self/pagemap in the
guest for that). With the slice mapped linearly into the guest arena
from a BAR, offset 0 is known to both sides, and any per-vCPU layout can
be negotiated in-band, either decided by the host or published by the
guest in a directory at a known offset.

> 
> Another thing missing here is a doorbell, so this approach doesn't
> obviate the need for at least one guest BAR. If we have that, it's not
> a stretch to use an additional BAR for communicating the mappings (as
> pvsched does in v3).

For the sched_ext use case I had in mind (hints consumed
opportunistically at scheduling events), polling was enough, so I didn't
need a doorbell. But I agree that a generic channel will eventually need
one, once there's a BAR it makes sense to use it for the shared memory
as well.

> 
> > The guest scheduler can create its own arena and allocate pages from
> > that NUMA node. Those guest physical pages are backed by the host arena,
> > so host and guest BPF programs can access the same memory through their
> > respective arenas.
> 
> Two nice things here that we don't currently have with pvsched. One is
> that the host BPF programs can directly read/write the arena memory
> without needing an additional special kfunc to grab the right pointer
> (for pvsched specific BPF hooks in the host we intend to pass the
> pointer in the BPF context, but for sched_ext programs we intended to
> add a kfunc to e.g. lookup the pointer by VCPU).  Second, the memory
> here is arena memory, which is quite nice. Currently pvsched just
> interprets it as a struct with a large data blob. Ideally we'd like to
> convert the pvsched model to use an arena.
> 
> Some additional drawbacks of the guest arena allocation you describe here:
> - The extra NUMA node can presumably be used for unrelated
> allocations; there's no way to isolate it for just the purposes of our
> arena? Guest kernel and other guest userspace could allocate on that
> node.
> - Memory allocations targeting that NUMA node (for the arena) could
> fail to find free space and fall back to another NUMA node; that at
> least seems solvable by forcing allocations to only come from the
> targetted node though

Agreed on both. There's also a worse problem that Alexei pointed out:
when the guest arena goes away the pages return to the guest buddy
allocator while the host can still write to them. The NUMA node was an
early prototype solution to avoid teaching arena to use pages it didn't
allocate, so that's what I'm going to address next.

> - This removes flexiblity of the guest to allocate memory how it
> likes. For example, with pvsched the guest can allocate the per-VCPU
> pages from the guest virtual nodes where those VCPUs reside.

Fair point. With a "map external pages into an arena" primitive both
directions should be possible: host-allocated pages coming from a BAR in
the guest, or guest-allocated pages pinned by the host and mapped into
the host arena.

> - I don't think this works for confidential VMs? You'd end up needing
> the guest to share the pages back with the host, which is essentially
> what the guest-allocates model already does

Right, with the NUMA node approach those pages would be private guest
memory, so it doesn't work for CoCo guests as is. I think any model
needs the memory to be explicitly shared with the host; I haven't looked
at the details of how a BAR backed by struct pages would be mapped in a
CoCo guest yet, so I'll keep this in mind for the rework.

> 
> I would definitely like to have the memory come to BPF via an arena
> for the flexibility of use, but I'm still a bit hung up on the host
> allocation part. I had been thinking about how to make the arena work
> using guest allocations, but nothing super concrete. Essentially the
> guest would create an arena and allocate pages, and stash the GPAs in
> the pvsched BAR. The host would need to pull those pages into its
> arena and deterministically allow access to them.
> 
> > After identifying the corresponding arena offsets,
> > both sides exchange data through direct BPF loads and stores. Arena
> > pointers are not relocated between mappings; a shared protocol can use
> > validated slice-relative offsets instead.
> >
> > QEMU is one potential consumer. The interface is generic: it exposes a
> > pinned BPF arena as a sized bpffs file that ordinary userspace consumers
> > can open and mmap, including consumers that require a file size when
> > setting up shared memory.
> >
> > The series separates page retention from file export:
> >
> > * BPF_F_ARENA_NO_FREE makes BPF page-free operations no-ops, retaining
> >   allocated pages until the map is destroyed. This flag alone preserves
> >   ordinary arena pin behavior.
> 
> Does this imply that the arena remains allocated at its highest
> watermark, regardless if we have VMs leave the system (and thus the
> host attempt to free the arena pages that corresponded to the departed
> VMs)?

Yes, with this series memory stays at the high watermark: userspace
could reuse a departed VM's chunk for a new VM, but pages are never
returned until the arena is destroyed. That's not great, and I think the
import model needs an explicit "release" operation per imported range
for this exact reason.

> 
> Smaller note: we probably want to at least make the free operation
> zero out the page so that no data is leftover when we reuse that page
> (ie. for a new VM).

Ack.

Thanks,
-Andrea
