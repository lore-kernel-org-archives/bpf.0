Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B81E8826;
	Mon, 17 Aug 2026 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786932181; cv=fail; b=dOVlNF1W2ZwQk93gIo0+0QuH5BUXtcIcra7COrNMy6hPO+1ezWIEzGc/hD5iLx1KfRsMyzBZIJuzPOxFmo6974DnlA9ry6ydvyK2Iq2xQEILdxos3wf4JQ/dxINgn5pDt8WZkzb60EGM8YEsi1fA8OQk6Hs5A287wcxvWT3PmLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786932181; c=relaxed/simple;
	bh=hy6bhKgkMXhnCn6pJ8aIjx2oG7KSwmdnJtx68JgNo8Y=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=RzgvwE84TG17KObhZtc2iqT/kYB+pDz38HwIZ+AWp8wn/Xc3kVIk8FE2dR3qViCNEA/7NwQjt6ZOh3P1md9naQmVb4y/R6UlztEYgyxReJGpuX9kdhDXtWM1XtUwPLLC9HUMjmT0Mnj0f9vVs0VEjh37Xwry5szoG1/dqWj0BWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fZmwBe9V; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fZmwBe9V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQBqNX9bymfd4Dwc3OUq252aWVSmgLxHSNJl8Q8U1IPHz6yX0ceekbyoMqA//bukQHUrhEeiaoVOmrwtlR25srciP1tD/iomwn8oXRysVmZCUEk5aYJP8vxjOXLZbeQArJACdsV6fN2ziQmRQ/RRyHBoPyaI64LXf0cDBKb8ES+HuEYpxL9Ieh3/04qNPlXwHCMwgh5qidhKLburIhsPjR/3f/PieoIj0CBig+kW88pkp9myEU4ZfPo8v/xmZe6uGFvouaB+JhwUagjvDjvIMuU+OVnm5mBDam/NgfLFvieZlS7tc5a0Wpo35UznmMWfk/HhzA9i2Gud4d4r5x5w4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsQzv821ldIQC38YunE5+owAk4192BbWH3L+2jE4UME=;
 b=Zw+ZcOhyXMxEWUds8GpMpITuWkkVBph/DtCKZlCpWiUDGRTHOfGVc/Chz/LH9ANhjZVPJ355qLdaX0ZgC+D+kWIh5kWozLrpTCUfSBW56yOkhuCWKo+mQMAVluqLFrANn/ZrnRFgPmCW3ABteDttu2eW4MQeC/3WZih2vLFOqSE2xNEw0/EzC7viz1ng/mPCBar/mc10BHdXXwg3SmR2Mimw0bjYYbp3DUXejLihK97exXWuZ8lNQOIPpSSIMp1Y5+kr4D2PGAvufi02V/Mq9OOUE7Rm/uXy9PNbODN61BTDiMpHqxhOVZgn1rJhaHVLUcvt5ZeKLn6t221GCUSXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsQzv821ldIQC38YunE5+owAk4192BbWH3L+2jE4UME=;
 b=fZmwBe9VfQigYvSdN7D7++U33TthRDRlBgN0A1mm83nXz3AmDnJOO7/CBY8bMIQPJu3hBedwc7JfPDDdyTdV2dMDX2LPP4kct1F9Pstq9xBvUgH6CYVrHny78kIqj6YkQ68WTLwMavLTTHfoLnG2KpFs8AEW11OkIurYzGdsDvVUXru7orpn7gdS10A3yPlauzx5mtYCRA6Biwfi50CaWRS0+51ZCka8lP8Uq1mvJJAvSFsha3jLyRY63BYfMs3nT6IsAIlndsDx2xDJ4/Yr4VcEcGjaOZwItmP/XrHOeq1XaOC9Sx7+RNfaHbxeQRo+AIA1/B5v4AVJ+UI0gEuW7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:02:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 02:02:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Aug 2026 22:02:53 -0400
Message-Id: <DKQUL7RN5K3W.30VLVVWFPBRXZ@nvidia.com>
Cc: <baolin.wang@linux.alibaba.com>, <baohua@kernel.org>,
 <dev.jain@arm.com>, <hughd@google.com>, <lance.yang@linux.dev>,
 <liam@infradead.org>, <mhocko@suse.com>, <rppt@kernel.org>,
 <ryan.roberts@arm.com>, <shuah@kernel.org>, <surenb@google.com>,
 <usama.arif@linux.dev>, <vbabka@kernel.org>, <usama.anjum@arm.com>,
 <agordeev@linux.ibm.com>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kas@kernel.org>, <jannh@google.com>, <willy@infradead.org>,
 <pfalcato@suse.de>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
To: "Kiryl Shutsemau" <kirill@shutemov.name>, <akpm@linux-foundation.org>,
 <david@kernel.org>, <ljs@kernel.org>, <nico.pache@linux.dev>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
X-Mailer: aerc 0.21.0
References: <20260816224609.308019-1-kirill@shutemov.name>
In-Reply-To: <20260816224609.308019-1-kirill@shutemov.name>
X-ClientProxiedBy: YQBPR0101CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::18) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 041db405-18f2-494d-2da6-08defc03a787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	ft/wKU5K4qyOxji+w4hWNX6sj8LJekekanPuNzUbYyI0KnHabFilIRlJOIKC0HQCZTap2qGlRCNGEATTwVQyib7BpcTjs5dyYwwqbcI5eBAwq98SEANR8Htam4q0bnoKCmUAXJ/R6J/A9Y+Lx+1fGwKt9CXj7G6beRBsF2gqA2DTaVr25JVCZWkIpQ9yNbJ7cUhRfJVkxAk3aMlnGNZOhrmOHjimN5HlEqKswu7qbJVq7Eu7N6t9fUKrEr6u6B0pXEv/G4w/w5EPOrEpcVOdfajSQLXsQFqfeHyjIH/1+Kh0Z2C7cG/Y0H7lTp/pGCRzv22Zu1PjcdBCVvdq6xKVgpK+vp42FdOZNx26ErdVB8nzoXY2TH67XBEjJlnii3IDAPhugcmOrMOUWL6eOU43FV87YvkTUOT/k1iIbOxilIaz/BoNgsj9uo4d4Wrah3VOgGL9+rvVdMLFAa+ovveQMwa6+PDAmeaNnQWPf4YMIXyvQZbcxqIG55t74DDq8VK6ROMwjG2Rin9JEORD9yIbiBGwy8DGRpN8Cj61WBVoxeeFRpi2g5VcueRPxqyPzsJEIzz4+fKdUaxrExHdcnlVppzYy/nHCYk2bkR32fptko+KcOWTQTtDAroVf0YQ/pEdl7UZ47geiROfred23lTVkEHbT+1v81Kqyo5h/a0dKHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ais5ZzUzcnNNOHo1TVR3TExnTmlKalVUM1RHK0l4MnRTZjFDVDdSOEM0eWx0?=
 =?utf-8?B?UzhFanRwUlVsTEVONVc0V29aaDlqTzVlYjk4QURYTDhENkkxNElMdng0RDBP?=
 =?utf-8?B?MG13ZEYxQzRQR05UcEhqTEk1SHUxOWEwZzFOQm1yNmI0OGtLVkJnNWNZd3c0?=
 =?utf-8?B?RUhQaDJpam1KZHY4Q3EyNUVlcVk1a0tlSEJ6Mjh3N2tPdVgzSXgxWjZsYy9z?=
 =?utf-8?B?NnVVVTc3dGsxN21QTjdrdXJOQ0I2bWRISXlZMkVjT1ZVRlhiam51Y3QzV1ky?=
 =?utf-8?B?N0dxKzNpNFgrWDBsR1Jvc1JWY2krbnhqN0JOVHl0aE1Oam1BTnZoK1NES05v?=
 =?utf-8?B?R1RMd0dRT0t5dTRNOUNWaWZ0K0lFejRjRk1uZHIzMWtEM2U0UjJVYWJOR0c1?=
 =?utf-8?B?a1FTZVE0azRWdkhkNW92TFQycVZ0Zk9PSWUzcGQzM2sydHlpN0pxZU1GZTdt?=
 =?utf-8?B?OVU0UTlPM0pQb3pHMURpemgzUjMxNlZVeGE5ZzQ3OTh4cXlWaWdrRWdybnEx?=
 =?utf-8?B?aGdUTnQ5VFZ1a1hJcm1tTi9LaGZFZmF2ZWNzS2Y0ZU01VFdzT1NDeDdlMUpX?=
 =?utf-8?B?cjVONE9rbGVZTHE1bDhiNysvb242VkxDQ3g2NDhON0VyaVljRGRFTFFzY1lx?=
 =?utf-8?B?ZThnVldpOEx0Tkt3cHZjRU1JcDVqV250MklaUEpJKytwSnlvMmQybUNpdTRX?=
 =?utf-8?B?OTFXNzB1SFQzOFZRVG5UVTkyVzdod0RBZHVEbkZkOVk5ZXlyN3VGZGxFQW04?=
 =?utf-8?B?a2htditPKzcwVk1IN1B0MURFTmFDZE1HS2ZYQjJGOENRTDNjbnhpNEo5QVNO?=
 =?utf-8?B?djl6L0RkdVJNVithR2lXdlByS09wV0ZRSzU3cUZCQm5qRERvbzJ6T01TYW5h?=
 =?utf-8?B?L0hSVFoyc3ZrN0tMUGJzb2podjI2b3JlSVpuTE1qMnZ2dFI1VWdsVmluRzVp?=
 =?utf-8?B?Y0FTR3dReFN6NnNjM3k1aFoxdXYxQ3d4aEpsNHVtWjEyTjc0OEJFcXpLSkNX?=
 =?utf-8?B?M0NsdFRVVHBJd2VFaUQ5Y09jVUpkUWtYUC9YUUtqYy83NkNDUzFVa0l6Szc5?=
 =?utf-8?B?Z1RjSnJOKzE5bXorT2JBRWJNTytlOGpmTXMvdEFISmVPcGJDaUhVQWRLQTlx?=
 =?utf-8?B?aFpyZnB4SmNYUkNxV082VGxPclpENHRqUXA1ZXM5Y3NUbHd0LzRTWDJ5bVhI?=
 =?utf-8?B?ajlyd0g4VUpTUENxL0pxZUlMaGJBUDhuSEI2VjhkeFA0dHk4ck0rN21pTmd6?=
 =?utf-8?B?emZneUVBZ2NQVHFQZzgwbzV0S01xdjA1VFkrQWxWKzIrd2ZuNDVYbVZFWGJJ?=
 =?utf-8?B?QzdYKzFwTW1TS2VFSkg2cmx4RVBvRVdvcStOSGlMMVIwVCt0Ri9tK0c4Ynl6?=
 =?utf-8?B?bGdLUmUxZktNUEI1ZXY0K1NwREJWQ0xJNFFrY2hwVnRQL1ZxMDlMUkU0OHdy?=
 =?utf-8?B?L1BDV3FPYjRpTzRiODMvQytRamRVSUVIUzkydlF5THZ6bDdMYkFyWWdGNmpQ?=
 =?utf-8?B?R2tHNVQxL2w2UnU2Tm5Ma2JPclhmQVZ6QVZrV1Y1cC9PZEpGQ0RSQWFHeFg4?=
 =?utf-8?B?Z1FIbWxJZENPRDVPNC90Nk9xVEQyQlN3ZEZwNjR3R2dvSy9DanFlcm5JYmdi?=
 =?utf-8?B?aHlLdWpxUjYxNGpCTVM3c1MwQ0x4Y3l2SWpPSjlYRUlKcmRvejVwQ2grWktF?=
 =?utf-8?B?cXFyazc0eC9Ea1FMV3FWcUZIRkxsRGF3TWNTREpPdGdkQWw0S09pMmpXamVZ?=
 =?utf-8?B?RzMwd2VZQVZWbDgzT253TzA2YmZNQ2hkalNkRTJjRS8rS2huRU8vWDIyWUwr?=
 =?utf-8?B?OCt5RWZRUXo0ckQ2OExNZ0xGZWZva0R3QmxDYWVMNmlPdko4bWpodUZkWHRs?=
 =?utf-8?B?TENvTldUeVkvN3QzclVJdml4ekZOcTFPK0czTlk2a0VHZ05sTU96YWx0bTll?=
 =?utf-8?B?ZTA0dzllYThrUDg3N01aRGp0a0ZvRmQ4MHJjc3BnbVdoM21ueWtvVHhSWGI2?=
 =?utf-8?B?cnlrMEsrT2NSM1cxeVZtNHJ2cUFCV2VtYmN6dHZvQXZZM0VDYUtETUZ0MUFy?=
 =?utf-8?B?MUNLNVVwempWbklDeEhBa0d6K0h0SkpwR0xsSmZXU1dSTFlyMlhIU0JNRnBM?=
 =?utf-8?B?Vm9LYmQrSHVKU3FOa2hZcnM4enZHQWd2UHhnZGFaWWZJK2lMYlRPUE5NMGdH?=
 =?utf-8?B?eldRLzVzNkFnNlRkNzZoNEFSVkI4dW9QUGRmOEdPa0FheE5lT3VodldsV0F1?=
 =?utf-8?B?SWdCSjJORDlVRC9JeEdLUUlwaElqQzVadmwvb2RqUk9uZTNmZzhNb0hhSDhJ?=
 =?utf-8?Q?jPCOkPwG65VAwvfKRL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041db405-18f2-494d-2da6-08defc03a787
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 02:02:56.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjJWne1kmh48ocXtGYULIGJONuzPxUB3uca6JSEeprfca7A7RE3f9o4X4RXH16h6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

On Sun Aug 16, 2026 at 6:45 PM EDT, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> Yes, I know, this is a lot of changes. But I'm happy with the overall sta=
te
> of the patchset and the only reason I tag it as RFC is that it is tricky
> to get 57 patches upstream.
>
> I wanted to give a view of the end state first. I will suggest a possible
> way to split it below.
>
> I would appreciate any feedback.
>
> TL;DR
> =3D=3D=3D=3D=3D
>
> This replaces khugepaged's anonymous collapse with an engine that
> can collapse sub-PMD ranges. It is built around migration entries and
> frozen folios instead of heavy locking and isolation, aiming for better
> scalability and less disruption to the workload being collapsed.
>
> Why
> =3D=3D=3D
>
> mTHP collapse landed in khugepaged in 7.2 and I was glad to see it.  We
> at Meta run arm64 with 64K base pages, where a PMD is 512M: PMD-order THP
> is of limited use at that size, and mTHP is exactly what we want.
>
> It turned out not to help us.
>
> khugepaged only ever looks at PMD-aligned windows, and it is not an easy
> limitation to lift.
>
> Fixing the alignment is a one-line change, but what it feeds assumes the
> PMD everywhere that matters: collapse_huge_page() clears and flushes the
> whole PMD whatever order it is collapsing, installs a PMD leaf because
> that is the only thing it can produce, and keeps everyone out with
> mmap_write_lock, anon_vma_lock_write() and an IPI broadcast while it
> does.
>
> Which is why hugepage_vma_revalidate() demands that the VMA span the
> whole PMD even for an mTHP order -- "we'd need to lock all VMAs in the
> PMD range to support this", as the comment there puts it.  A PMD-granular
> operation is only safe when one VMA owns the PMD, and that is exactly the
> restriction in the way.  The alignment is the symptom; the PMD is the
> design.
>
> So both roots have to go.

I agree that khugepaged is designed for PMD-aligned collapse and this is
a limitation we want to get rid of. It is great you are looking at them.

>
> Design
> =3D=3D=3D=3D=3D=3D
>
> The old mechanism holds the address space still because it has nothing
> else stopping the sources from moving under the copy.  The new engine
> makes the sources themselves inert instead, with the two barriers
> migration already uses, raised in that order:
>
>   1. migration entries replace the source PTEs.  Faults and GUP-slow
>      now wait on the source folio's lock, which is taken before the
>      first entry becomes visible.
>   2. the source folio's refcount is frozen to its expected value.
>      GUP-fast, pfn walkers, reclaim, compaction and memory-failure all
>      fail folio_try_get() and back off.
>
> Between the two, nothing can reach a source, so the copy runs with no
> lock held at all -- and the address space is left alone while it does.
>
> What that removes from every collapse path:
>
>   mmap_write_lock              -> mmap_read
>   anon_vma_lock_write()        -> nothing: an rmap walk needs the folio
>                                   locked, and the engine holds that lock
>                                   from freeze to putback
>   tlb_remove_table_sync_one()  -> nothing: one ranged flush per round
>   LRU isolation                -> nothing: sources are inert in place

I remember we were discussing using migration entry and the issue with
mmap_write_lock() in the context of in-place THP promotion and the
conclusion was that because MADV_DONTNEED (maybe MADV_REMOVE or
MADV_PAGEOUT) works on page table and does not change VMAs,
mmap_write_lock() is needed to prevent things being changed under
khugepaged. Anything different in normal khugepaged collapse process, so
that it is OK to use mmap_read_lock? Let me know if I misremember it.

Thanks.

--=20
Best Regards,
Yan, Zi

