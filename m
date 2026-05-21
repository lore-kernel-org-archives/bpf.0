Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E3395AE5;
	Thu, 21 May 2026 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346857; cv=fail; b=SbfAMOmNUM7KNFUKZEHKzSnWvNQiTPkfP7bAp4GgAvtqiUPXKzRq85bE/oWWZC6lrU57nOJZztRKN6zF6Vf16cfSUB30/2+WhfVtfV5Sg2MVDgSvzmwVWeZEaf1iyJFQFRxFB+ne0UP+pX+3KXrYMG7pwjSETHZR3e+8qO50iIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346857; c=relaxed/simple;
	bh=kdIsyZr26jBY7lAfoKo+8MejijipAR6imFdD7+4Ryf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XAoKIo7Thpr3ye2buB9sGA8iAssjIUwB2h2xqsOcHjfo/jiMGwKQ6OVruQlrbCMQlBqYlQ/uSQFAqmlZ5O4ehtWLjeHRLoYX8+XyzPdlbelJsZGelcg8SDW+ThmhHhoTng1xhuB61ZUAs1wT583WLekPOSAcfqCD+hdsrdvdD0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gOGcn/X5; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gOGcn/X5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5no6JEL9awQMgPLk8PD0fjEGgH/Hvk9SlX6W3oo5p1TVHQVN1vX8jSR+ijYPTS0mC/p11HfRWyWdOoyA3Pa8vh4y/dS3TbrTmVBo9PM/slbgNcU4FiCNb54hQpFgIGkwuT74f5LlSiHBS8458Mm2509mdhjXZ1J7JsOuZgZRRb80XSKOSyt37Uhp8CWwMkLuDJRIDX49/hM5QmkBLa9i0o9yzFf3wCqnEr7WYZYhVtSeQR/H5EoIsSPffnBlMH1YenxTb/LAOdPv7xonGpPgDz7SfOlF8JwuD98+3mKRRvM3+km9HsYhbsMO6HLLVCLYQBVaESv35MreA0ttX4gRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieF9yw/GSVJ2SDIz62jCug1iEvzwvC7gAvc348sGhpg=;
 b=Lx8VeLqa76v1/nnR8+BS1DPE7YOFTXomcgtCFm1x8ZkPs9L/ypYL59hb3TXcB8er0AGmBQm1sqGFomdQHlwsbwLpwFSGbuQHbhgBF40iY7ITKWfyTnstWGHIqDnSfjfWQ9yyhrmx5DY6JpzcrVr6gmeKLsLEhIDrCFx+Z5/UGu/r4XYmgoiqaceR9T74B/WR1Cn+iW0yQEa3FJ74DeW9rWB2lIRIRY2FKDX7/NksMBzZXsvIitz1KQHxH3vkIduvPeOmQvvGti8afrAJROkpUjXdH9BmYbxK59ofbw4HkMxbUCQ8ysEbyKZQonyk35kBKBt9J1kj+ZEc3PX59LuJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieF9yw/GSVJ2SDIz62jCug1iEvzwvC7gAvc348sGhpg=;
 b=gOGcn/X5eFzVf5Kd2jufYz179IhdT80DB3x32/oCPAVzqFhl0N103ctNwoh6x5VO3rWeSsKIrwZ5offiTh2ZkKZl+PsJo0OzOgvrHJQBMkEehLf//LDbiHGHHIVXQwWd1dOgRQyuw2a30O5FkP+mD2Ga5H/dRyrINPU4DztTfYy7D+aa+KdnzwTt1lIYDMwNrux3mxQ65mMMug7Kh39K1nqhWseUlu9tAmIbbpu4S9ZOf5LD60zsoJ0ivWYQIslgUkM4QT/6nNvNXEuTxmTubn+AZTg0WV77hKKubtW2joT8ude9VGtIcTBF5gXHsAogPd5zxlbjxnog6ELoyw75UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 07:00:38 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 07:00:38 +0000
Date: Thu, 21 May 2026 09:00:26 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: Add ptep_try_set() for lockless empty-slot
 installs
Message-ID: <ag6tihzwPxXO-2yf@gpd4>
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-2-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520235052.4180316-2-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::11) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e608b9-9721-43c3-5a41-08deb706a997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|11063799006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	FIbpA3PC6B4Za8eU8HRQiJ0oAIbvHBVWOTzlLZEW/Ii2lW9FqgYn3McySBqZPRUJ8NXV+zih/EFIZ01TH+m8d/oBLHHLOGDqsQze1MC118BYUbsDsSOtM0Nv2XjYMFQB9hd5vyN7xtcjJsb/0zYchS8gkgMWXUypqEW0MEZ1Zrbd2jmGIkXnLzmDHL90zPm0sOJJ9PQT+YjN4LtR72CemNKNgMe50IdCPhrs2hYX3zoMol9gIIIYkEhgQVwwwp24XlioiudiCyhE1+6Btmjf7inZDLv3xYhpiJzyfZErlPmOfFo9vRT9T3/jIbIoyVNLTwSxcYegFHO4ngRN+9JIEzxFXX2lz1yMOCtTFN2eFx6Lpq2a25YN50UMb1Ti2PL5ze9OBixWB2cROwXdc3ccxSMoAxwAvWYEIHSp1wrZqX9pq/nykS6fnjBOPiBPCx2VpP7z3xYuj2K1f/oXgGp2MQOpzsJnTWYAgv47uMF+pnFTkWvT9i7ZNf61RB2Z37QZrj6SynslyGG5GzFU21RDjtk2bjEiKWfDiD2L/k57+Pr72q1cJKnjVHhVYcZ0L7R53UEKd6FjvQj/soaaFEhQpdrS16up1ohenAhDmIuUw6zlzlLE0oTJludzLvr5wCRhTskFbgG467hOiHP7eQ/Qh+ENwv8nL7v7kszzx3ZvXmrZl2TKChDzG/mFG+iP07gp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(11063799006)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spukkrsQ4X40uKakOMC34YE21YSrmmim9I8tKV5wQ1+SHR2DyYIlO4WJIyJH?=
 =?us-ascii?Q?xCTesLEa0OWTT5cBN6HJmau7zY9E58O12Ghw5vMiXq40Hb8Ib+usrK405h7D?=
 =?us-ascii?Q?TGpEj0zuYk4sEbU+Kx2fLxW1WXKrqIFu81u1I3ksfNZlHiuknzZTzAnVZwgw?=
 =?us-ascii?Q?RUw4sSHUaEgSUDOd5Azyzpxz7nVa1zTQ77PDW/G1tjs9gQojsLcKKDn6y5Xy?=
 =?us-ascii?Q?v0d60KCgovv7TK7WzjFlP4amvrljrI9vNK0SdyvfGRBpKuP9Si0z0RDK/WBt?=
 =?us-ascii?Q?a2jy822fyXuDusmkgwSC6CeomFGLB8oqZ0PC9ba4NRn4p/oA4PSkLa2eV9s2?=
 =?us-ascii?Q?DLUJsljGU4DB4/GfNYfrXMnjSvK1lDWVvisTIwSfQVIriq1M5y/s4dvc/Puq?=
 =?us-ascii?Q?p5RCGMGndaKtGeK7NNes8wwoTSMmf7/4BqUEItc+MTGMXVl7GFYE/AG6zr9+?=
 =?us-ascii?Q?s5ijAbK+y+f50RzprUWytibh3VQ6qvv9GGPcJTTcNCIpGRN6hX8f9Kp3KqNr?=
 =?us-ascii?Q?Dpz/BZ2QCKJKphzBvyM5Mg7a2III4Zd37yEmt+8EJK3y7AbSrhy82MZuc+8P?=
 =?us-ascii?Q?aR4XuUyFwh0nn7FrGs9PRC7P74aRV5+D927fMD2qCEqvTAF6xjeKQ0xZ0aH0?=
 =?us-ascii?Q?5sAlGElJiALV0WWrF7R4UtSCNy6RA+4EDYXPWSor1OuwW25AxuztJmZhq08y?=
 =?us-ascii?Q?j/JOtON5lzRz17qSuIIWvgPBtGxiP+FCQMokDyFnobKR6HmZ5khIh/jAMm4R?=
 =?us-ascii?Q?wHmcAZnibzf34Wu0lmfwZOBfOT5YS7G6vIxeFoIRa0oHpP2/ElT8sJAcSiJ1?=
 =?us-ascii?Q?GK9EyvZm6rJlrMkxm1Anlj0zbSJL+P0lNKr8OxvH2QVoYcWuw2S0/7h1uGVy?=
 =?us-ascii?Q?ibhNSnBqxiPYDGc6QaWuy6h7TbFQt7J7nUL6zJUS9XdK22UUA/uol+1MKcuW?=
 =?us-ascii?Q?GS3Z/6hk2LjY5Kl4fQT9XcxTl0cAv22WJDEa7GoZNpWFuFarW1OlyFMweikO?=
 =?us-ascii?Q?j78XUSsqMFjxZcFYE9F7GE0ckyV84OeAqY74CkfytpJvURkEq+lIKsGj7pjX?=
 =?us-ascii?Q?KCOohw2JvElhtbUAkQ9zN+ExD+0hz5eMlDjNWQI3n8PJoHfaS5w9vr8hITq5?=
 =?us-ascii?Q?WeoJHNAwQO8FmOZ7YnDxpe6sUk+kTORszEmXQK22pDznAGlP+VVBxhaKFM9O?=
 =?us-ascii?Q?FA7nicM2Ih5c6LLmnLDfW5ZI8DVh/3SiT0D3xF/SRZfI6yxvd6uynkMgFXUS?=
 =?us-ascii?Q?y6xxkW3a8xiLp2iqjaRcq8PHZRijEqf/IDoH5GRbKgdh/mrUiENqRvMxA4WC?=
 =?us-ascii?Q?CuffGt1b9so5ORvr9VQLXg8wCe3G9ZjAEcA71AoNpHpltdw7CMKnZUbgrAGp?=
 =?us-ascii?Q?dimZqogC7bNFAVY24T/DAVFUN+Zuba3pgyhOETRgK4u2B+aNpjkpQO+MXkR9?=
 =?us-ascii?Q?ys1Qu0hqhbNMvvZsSTUZxPxyRvzvREOwxA1+xoJDC4OYmsqE7al3kkAMPop+?=
 =?us-ascii?Q?x/nhO5clHEo1WuD9xoF7PT2yBpXjGzc9WNO9nMFIaZsyI9lIcqy49npH+VVn?=
 =?us-ascii?Q?O4bkVXxWRHnUDEP5wR5uMWDzMnjR4bx2XpPKKX8Waay+TZY0LM4QX0787eIl?=
 =?us-ascii?Q?wveZYa82luiGbShGbu3o0B146Q7cnnOIiTuwvHXgRtPbP8UzD2ZW+n5iDTJK?=
 =?us-ascii?Q?DbcID2xABhK3FBrc0aPKj0MmDnZHRDX+8nVM2bh0G0VrNs2m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e608b9-9721-43c3-5a41-08deb706a997
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:00:37.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZbzA9cjuVXpzNruf7K5xjlGjAnMcWKfhTlkc2ZR0dnYWTWXW2oiRP4m7/DAH2Vv2/3HdGKlFXO3ooMDJaE7Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339

Hi Tejun,

On Wed, May 20, 2026 at 01:50:45PM -1000, Tejun Heo wrote:
> Add ptep_try_set(ptep, new_pte): atomically set *ptep to new_pte iff it is
> currently pte_none(). Returns true on success, false if the slot was already
> populated or the arch has no implementation.
> 
> The intended caller is the upcoming bpf_arena kernel-side fault recovery
> path. The install runs from a page fault that can be nested under locks
> held by the faulting kernel caller (e.g. a BPF program holding
> raw_res_spin_lock_irqsave on its arena's spinlock), so trylock-and-retry
> would A-A deadlock. Lock-free cmpxchg is the only viable option, which
> constrains this helper to special kernel page tables where concurrent
> writers cooperate via atomic accessors.
> 
> The generic version in <linux/pgtable.h> returns false. x86 and arm64
> override with try_cmpxchg-based implementations on the underlying pteval.
> Other architectures get the false stub - the callers there already fall
> through to oops.
> 
> v2: Rename to ptep_try_set(). Tighten kerneldoc for kernel-PTE use.
>     (David, Alexei)
> 
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h |  8 ++++++++
>  arch/x86/include/asm/pgtable.h   |  8 ++++++++
>  include/linux/pgtable.h          | 26 ++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9029b81ccbe8..a129be91ef2c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1830,6 +1830,14 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  	return __ptep_get_and_clear(mm, addr, ptep);
>  }
>  
> +static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
> +{
> +	pteval_t old = 0;
> +
> +	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
> +}
> +#define ptep_try_set ptep_try_set
> +
>  #define test_and_clear_young_ptes test_and_clear_young_ptes
>  static inline bool test_and_clear_young_ptes(struct vm_area_struct *vma,
>  		unsigned long addr, pte_t *ptep, unsigned int nr)
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 13e3e9a054cb..047e273a4eab 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1284,6 +1284,14 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  	} while (!try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(long *)&new_pte));
>  }
>  
> +static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
> +{
> +	pte_t old_pte = __pte(0);
> +
> +	return try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(long *)&new_pte);
> +}

Minor nit (feel free to ignore), on x86 pte_none() is defined as:

static inline int pte_none(pte_t pte)
{
	return !(pte.pte & ~(_PAGE_KNL_ERRATUM_MASK));
}

With:

#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
#define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)
#else
#define _PAGE_KNL_ERRATUM_MASK 0
#endif

If that mask has the D/A bits set, try_cmpxchg(..., &old=0, ...) will reject a
PTE that has only those bits set, even though pte_none() would return true. I
think this is fine for the bpf_arena use case, since hardware shouldn't set A/D
for fresh pages that the BPF prog hasn't touched.

Maybe it's worth adding a comment (something along these lines)?

 /*
  * Note: strictly-zero compare is narrower than pte_none() (see pte_none() and
  * _PAGE_KNL_ERRATUM_MASK), but the gap is harmless in practice: HW shouldn't
  * set _PAGE_DIRTY | _PAGE_ACCESSED bits on entries the caller never touched.
  */

Other than that, looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> +#define ptep_try_set ptep_try_set
> +
>  #define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
>  
>  #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index cdd68ed3ae1a..d68374f404c1 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1036,6 +1036,32 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>  }
>  #endif
>  
> +#ifndef ptep_try_set
> +/**
> + * ptep_try_set - atomically set an empty kernel PTE
> + * @ptep: page table entry
> + * @new_pte: value to install
> + *
> + * Atomically set *@ptep to @new_pte iff *@ptep is pte_none(). Return
> + * true on success, false if the slot was already populated or the
> + * arch has no implementation.
> + *
> + * For special kernel page tables only - never user page tables. The
> + * caller must prevent concurrent teardown of @ptep and must accept
> + * that other writers may race. Concurrent clearers must use
> + * ptep_get_and_clear() so racing accesses agree on the outcome.
> + *
> + * Architectures opt in by providing a cmpxchg-based override and
> + * defining ptep_try_set as an identity macro. The generic stub
> + * returns false, which is correct for callers that fall through to
> + * oops on failure.
> + */
> +static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
> +{
> +	return false;
> +}
> +#endif
> +
>  #ifndef wrprotect_ptes
>  /**
>   * wrprotect_ptes - Write-protect PTEs that map consecutive pages of the same
> -- 
> 2.54.0
> 
