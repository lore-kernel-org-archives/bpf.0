Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB43347520
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333422; cv=none; b=O/Gf0gIGhwDhHTQMj5ReNitwTzTOasxZ2juQraHZJmAxb3rBlDI3zjUGGfwvRfUrv2JxcPr4w7qtFR6/co/3G2JiR6ZW4xohVMuaJWe3xImJyp1CzU+JCzSJkfToiHFxbejh+2KlgmNOJGM0CIvoIOIb3FB6N+q6g7FpFe+DpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333422; c=relaxed/simple;
	bh=yi+5Xb7QjzwtUFXAXyBneNbSgrYbqFtlYmb8lHm3t+4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QmHT8oRCpScywBcdSyX8LXlFxXBW3s9vomANNejHlTq1CpXKZ47td5G2LSYInSm0vkp5JB6lEPjy9UOUXJEUOXxyyC25pA1WMFxw3tN+dhT3Y+xSh2UN67KQgdyvixmSCIdBqUj9rEE51WQ7fNVUBrVJJrqWke1iUr7sBrQB7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=f7gKU/2h; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="f7gKU/2h"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367d88b9940so3632213a91.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 20:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779333419; x=1779938219; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jELMhKLGUtWyEbvchAP5Mgs2MLb2HNlCeWKkazBlD+8=;
        b=f7gKU/2hK9lXD0i7SaeziFFMdjVpwL8JcswuBmpCIER1v6Z6NdmKacz9hEeDkgiYSy
         01SWCbuJJ7RA1oxQM2IL0O4BGmxphJjD9X7QHBWiKnZ4AufDkE6hpWgEwX2Uqid4o4V6
         UTJQpiqb4fyeSEMTUm6BIAQGIV+xlb5KR5jn9jOEfLDw8tZp+GWt3ZCdC2rRUxRbZb0P
         H/BxSR35Zbdv8zzLbUjj5Wjz+2kww/OZ4tRXumP+J6zsMthu+2bvk2unuFJ3tew0ofli
         XUyYI9HqibxZlmwnDdns8G+t56A2pSjslTJr/eaj4A/EG9R1k0+AeeByDRSoAhS344EH
         nHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779333419; x=1779938219;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jELMhKLGUtWyEbvchAP5Mgs2MLb2HNlCeWKkazBlD+8=;
        b=cJIp2+azkRHxUX7LmzJpG+meSY98h41GtglEvYg0y8619IrrhkGQBt2YFkMbTyNb7T
         Tl3bCNg+hz1o260Jg3CtGij6T1T5+dsblDDDVdGNxBXskddPnFQbhwAgzYzJmFlcNQcN
         qSEu7qYopUkSEDtWxPAwmT7dWbIt6yUVKrIZvOPXAEgoXRIqwAhP5GQ5GHj0TWzl1pB4
         0dqKkqLjTT79wz/QRvhAlNZx2A3EL11PeMw7OSqGphJdAShDLi1/Fij5HUJ8SJNr+nTh
         BwdcBY5DoCRaE/rNdrOBbF20XRMOWQv0O/Dpgbt22qa7v+WDpJbgIwRWb8yWJzIbpW7g
         sWiA==
X-Forwarded-Encrypted: i=1; AFNElJ+3Bua2cGCMwUAnVTgqY4CaYySE4BI+GdjE8dVmEChWl2t/G/oHZ7N7neCZNQRj9gezqzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgosrkh2kag9RX5ZijrMiGgd61NOp1upg/RfSH7KzqznO+GBDA
	NUCnXS0T7iKtIucY/TZmo+QTBePo5HYkPPWQtp4qF5hWOw3jEFpadlXC3wlT5lyAJEM=
X-Gm-Gg: Acq92OHl7fHVg1kF9xSvlGsXGLnw4wfJvBtBAFgNbgNJ8BXqi4w9W8muSfDU1WinPwz
	dLgKihUz+Z9oQF88XdC19+5Zs4IIjzFfhaU1iFWb13MbZr4cNfzKOs8lo5yOICuJw8auH7bhsLu
	UVooFl/BHPsRwpx0aEBeqwbyULeptLz3A55wdGaPOqzMnB8uwyIQA95eb/R2dXUOr6VtU/xQJEQ
	gqs+O1TZkDuSEDpXiaAGUoMr4Tk8QEC/TU3uzUKdu/9AXsyxhNoCTX42v2+RWNhFUkDAmgh8Tvw
	PLFrs4yEfggdLmDrE261r0Rf3EaFoKtPWn2dhuzrwe1AXCOvRCNg3TWStji5xPAoczWNHX15jZt
	ptS6HKIoFv4X3KXoI3S9jCV2rKjHqutgcKQeKLg+ECXtGwoi1mgyVh+UFpnR4Cpa5aTM2XQcCS4
	JYrItOIsAwul4p4Ov1AiwZKcJS
X-Received: by 2002:a17:90b:1fc6:b0:369:c5f4:9681 with SMTP id 98e67ed59e1d1-36a45626bb0mr1185388a91.22.1779333418913;
        Wed, 20 May 2026 20:16:58 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3d0d847dsm999527a91.10.2026.05.20.20.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 20:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 23:16:57 -0400
Message-Id: <DIO11ZK1AJTB.1U25TXKLC0W90@etsalapatis.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, <bpf@vger.kernel.org>,
 <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-3-tj@kernel.org>
In-Reply-To: <20260520235052.4180316-3-tj@kernel.org>

On Wed May 20, 2026 at 7:50 PM EDT, Tejun Heo wrote:
> From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> BPF arena usage is becoming more prevalent, but kernel <-> BPF communicat=
ion
> over arena memory is awkward today. Data has to be staged through a trust=
ed
> kernel pointer with extra code and copying on the BPF side. While reads
> through arena pointers can use a fault-safe helper, writes don't have a g=
ood
> solution. The in-line alternative would need instruction emulation or asm
> fixup labels.
>
> Enable direct kernel-side reads and writes within GUARD_SZ / 2 of any
> handed-in arena pointer, without bounds checking. A per-arena scratch pag=
e
> is installed by the arch fault path into empty arena kernel PTEs - x86 fr=
om
> page_fault_oops() for not-present faults, arm64 from __do_kernel_fault() =
for
> translation faults, both after the existing exception-table and KFENCE
> handling. The faulting instruction retries and the access is also reporte=
d
> through the program's BPF stream, preserving error reporting.
>
> bpf_prog_find_from_stack() resolves the current BPF program (and its aren=
a)
> from the kernel stack - no new bpf_run_ctx state is added. Recovery cover=
s
> the 4 GiB arena plus the upper half-guard (GUARD_SZ / 2). The lower
> half-guard is excluded because well-behaved kfuncs only access forward fr=
om
> arena pointers. The kfunc-author contract - access at most GUARD_SZ / 2 p=
ast
> a handed-in pointer - is documented in Documentation/bpf/kfuncs.rst.
>
> The install is lock-free via ptep_try_set(). On race-loss the winning
> installer's PTE is already valid, so the access retry succeeds. The arena
> clear path uses ptep_get_and_clear() so installer and clearer race throug=
h
> atomic accessors. No flush_tlb_kernel_range() afterwards. Stale "not mapp=
ed"
> entries just cause one extra re-fault, cheaper than a global IPI on every
> install.
>
> Scratch exists only to keep the kernel from oopsing on an in-line arena
> access. Its presence at a PTE means the BPF program has already
> malfunctioned, and the violation is reported through the program's BPF
> stream. The only requirement for behavior on a scratched PTE is that the
> kernel doesn't crash. In particular, any user-side access through such a =
PTE
> may segfault. The shared scratch page is freed once during map destructio=
n.
>
> BPF instruction faults continue to use the existing JIT exception-table
> path. This patch changes only the kernel-text fault path. No UAPI flag is
> added. The new behavior is the default.
>
> v2: Use ptep_get_and_clear() in apply_range_clear_cb(). (David)
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  Documentation/bpf/kfuncs.rst |  14 +++
>  arch/arm64/mm/fault.c        |  10 +-
>  arch/x86/mm/fault.c          |  12 ++-
>  include/linux/bpf.h          |   1 +
>  include/linux/bpf_defs.h     |  11 +++
>  kernel/bpf/arena.c           | 177 +++++++++++++++++++++++++++--------
>  kernel/bpf/core.c            |   5 +
>  7 files changed, 183 insertions(+), 47 deletions(-)
>  create mode 100644 include/linux/bpf_defs.h
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..6d497e720998 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -462,6 +462,20 @@ In order to accommodate such requirements, the verif=
ier will enforce strict
>  PTR_TO_BTF_ID type matching if two types have the exact same name, with =
one
>  being suffixed with ``___init``.
> =20
> +2.8 Accessing arena memory through kfunc arguments
> +--------------------------------------------------
> +
> +A read or write at any address inside an arena does not oops the kernel.
> +Unallocated arena pages are lazily backed by a scratch page and the
> +access is reported through the program's BPF stream as an error. Only
> +the BPF program's correctness is affected; the kernel itself remains
> +intact.
> +
> +The arena is followed by a ``GUARD_SZ / 2`` (32 KiB) guard region that
> +is also covered by this recovery. A kfunc handed an arena pointer may
> +therefore access up to ``GUARD_SZ / 2`` past it without bounds-checking
> +against the arena. Larger accesses must verify the range explicitly.
> +
>  .. _BPF_kfunc_lifecycle_expectations:
> =20
>  3. kfunc lifecycle expectations
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 920a8b244d59..0d58d667fcd8 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -9,6 +9,7 @@
> =20
>  #include <linux/acpi.h>
>  #include <linux/bitfield.h>
> +#include <linux/bpf_defs.h>
>  #include <linux/extable.h>
>  #include <linux/kfence.h>
>  #include <linux/signal.h>
> @@ -416,9 +417,12 @@ static void __do_kernel_fault(unsigned long addr, un=
signed long esr,
>  	} else if (addr < PAGE_SIZE) {
>  		msg =3D "NULL pointer dereference";
>  	} else {
> -		if (esr_fsc_is_translation_fault(esr) &&
> -		    kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
> -			return;
> +		if (esr_fsc_is_translation_fault(esr)) {
> +			if (kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
> +				return;
> +			if (bpf_arena_handle_page_fault(addr, esr & ESR_ELx_WNR, regs->pc))
> +				return;
> +		}
> =20
>  		msg =3D "paging request";
>  	}
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index f0e77e084482..b0f103ddbd23 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -8,6 +8,7 @@
>  #include <linux/sched/task_stack.h>	/* task_stack_*(), ...		*/
>  #include <linux/kdebug.h>		/* oops_begin/end, ...		*/
>  #include <linux/memblock.h>		/* max_low_pfn			*/
> +#include <linux/bpf_defs.h>		/* bpf_arena_handle_page_fault	*/
>  #include <linux/kfence.h>		/* kfence_handle_page_fault	*/
>  #include <linux/kprobes.h>		/* NOKPROBE_SYMBOL, ...		*/
>  #include <linux/mmiotrace.h>		/* kmmio_handler, ...		*/
> @@ -688,10 +689,13 @@ page_fault_oops(struct pt_regs *regs, unsigned long=
 error_code,
>  	if (IS_ENABLED(CONFIG_EFI))
>  		efi_crash_gracefully_on_page_fault(address);
> =20
> -	/* Only not-present faults should be handled by KFENCE. */
> -	if (!(error_code & X86_PF_PROT) &&
> -	    kfence_handle_page_fault(address, error_code & X86_PF_WRITE, regs))
> -		return;
> +	/* Only not-present faults should be handled by KFENCE or BPF arena. */
> +	if (!(error_code & X86_PF_PROT)) {
> +		if (kfence_handle_page_fault(address, error_code & X86_PF_WRITE, regs)=
)
> +			return;
> +		if (bpf_arena_handle_page_fault(address, error_code & X86_PF_WRITE, re=
gs->ip))
> +			return;
> +	}
> =20
>  oops:
>  	/*
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0136a108d083..831996c411cf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -6,6 +6,7 @@
> =20
>  #include <uapi/linux/bpf.h>
>  #include <uapi/linux/filter.h>
> +#include <linux/bpf_defs.h>
> =20
>  #include <crypto/sha2.h>
>  #include <linux/workqueue.h>
> diff --git a/include/linux/bpf_defs.h b/include/linux/bpf_defs.h
> new file mode 100644
> index 000000000000..d98e033b8c0b
> --- /dev/null
> +++ b/include/linux/bpf_defs.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Subset of bpf.h declarations, split out so files that need only these
> + * declarations can avoid bpf.h's full include cost.
> + */
> +#ifndef _LINUX_BPF_DEFS_H
> +#define _LINUX_BPF_DEFS_H
> +
> +bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write, unsi=
gned long fault_ip);
> +
> +#endif /* _LINUX_BPF_DEFS_H */
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 08d008cc471e..1c0b87ecc817 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -53,6 +53,7 @@ struct bpf_arena {
>  	u64 user_vm_start;
>  	u64 user_vm_end;
>  	struct vm_struct *kern_vm;
> +	struct page *scratch_page;
>  	struct range_tree rt;
>  	/* protects rt */
>  	rqspinlock_t spinlock;
> @@ -118,6 +119,11 @@ struct apply_range_data {
>  	int i;
>  };
> =20
> +struct clear_range_data {
> +	struct llist_head *free_pages;
> +	struct page *scratch_page;
> +};
> +
>  static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data=
)
>  {
>  	struct apply_range_data *d =3D data;
> @@ -144,33 +150,59 @@ static void flush_vmap_cache(unsigned long start, u=
nsigned long size)
>  	flush_cache_vmap(start, start + size);
>  }
> =20
> -static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *fr=
ee_pages)
> +static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *da=
ta)
>  {
> +	struct clear_range_data *d =3D data;
>  	pte_t old_pte;
>  	struct page *page;
> =20
> -	/* sanity check */
> -	old_pte =3D ptep_get(pte);
> +	/*
> +	 * Pairs with ptep_try_set() in the kernel-fault scratch installer.
> +	 * Both sides must be atomic.
> +	 */
> +	old_pte =3D ptep_get_and_clear(&init_mm, addr, pte);
>  	if (pte_none(old_pte) || !pte_present(old_pte))
> -		return 0; /* nothing to do */
> +		return 0;
> =20
>  	page =3D pte_page(old_pte);
>  	if (WARN_ON_ONCE(!page))
>  		return -EINVAL;
> =20
> -	pte_clear(&init_mm, addr, pte);
> +	/*
> +	 * Skip the per-arena scratch page. A kernel fault on an unallocated ua=
ddr
> +	 * scratches its PTE. A later bpf_arena_free_pages() over that range wa=
lks
> +	 * here. Without the skip, scratch_page would be freed.
> +	 */
> +	if (page =3D=3D d->scratch_page)
> +		return 0;
> +
> +	__llist_add(&page->pcp_llist, d->free_pages);
> +	return 0;
> +}
> =20
> -	/* Add page to the list so it is freed later */
> -	if (free_pages)
> -		__llist_add(&page->pcp_llist, free_pages);
> +static int apply_range_set_scratch_cb(pte_t *pte, unsigned long addr, vo=
id *data)
> +{
> +	struct page *scratch_page =3D data;
> =20
> +	if (!pte_none(ptep_get(pte)))
> +		return 0;
> +	/*
> +	 * Best-effort install. ptep_try_set() returns false only if another
> +	 * installer (real allocation or concurrent fault) won the cmpxchg.
> +	 * Their PTE is already valid, so the access retry succeeds.
> +	 *
> +	 * No flush_tlb_kernel_range() needed. Stale "not mapped" entries just
> +	 * cause one extra re-fault through this same path.
> +	 */
> +	ptep_try_set(pte, mk_pte(scratch_page, PAGE_KERNEL));
>  	return 0;
>  }
> =20
>  static int populate_pgtable_except_pte(struct bpf_arena *arena)
>  {
> +	/* Populate intermediates for the recovery range (4 GiB + upper half-gu=
ard). */
>  	return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena)=
,
> -				   KERN_VM_SZ - GUARD_SZ, apply_range_set_cb, NULL);
> +				   SZ_4G + GUARD_SZ / 2, apply_range_set_cb, NULL);
>  }
> =20
>  static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
> @@ -221,22 +253,29 @@ static struct bpf_map *arena_map_alloc(union bpf_at=
tr *attr)
>  	init_irq_work(&arena->free_irq, arena_free_irq);
>  	INIT_WORK(&arena->free_work, arena_free_worker);
>  	bpf_map_init_from_attr(&arena->map, attr);
> +
> +	err =3D bpf_map_alloc_pages(&arena->map, NUMA_NO_NODE, 1, &arena->scrat=
ch_page);
> +	if (err)
> +		goto err_free_arena;
> +
>  	range_tree_init(&arena->rt);
>  	err =3D range_tree_set(&arena->rt, 0, attr->max_entries);
> -	if (err) {
> -		bpf_map_area_free(arena);
> -		goto err;
> -	}
> +	if (err)
> +		goto err_free_scratch;
>  	mutex_init(&arena->lock);
>  	raw_res_spin_lock_init(&arena->spinlock);
>  	err =3D populate_pgtable_except_pte(arena);
> -	if (err) {
> -		range_tree_destroy(&arena->rt);
> -		bpf_map_area_free(arena);
> -		goto err;
> -	}
> +	if (err)
> +		goto err_destroy_rt;
> =20
>  	return &arena->map;
> +
> +err_destroy_rt:
> +	range_tree_destroy(&arena->rt);
> +err_free_scratch:
> +	__free_page(arena->scratch_page);
> +err_free_arena:
> +	bpf_map_area_free(arena);
>  err:
>  	free_vm_area(kern_vm);
>  	return ERR_PTR(err);
> @@ -244,6 +283,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr=
 *attr)
> =20
>  static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
>  {
> +	struct bpf_arena *arena =3D data;
>  	struct page *page;
>  	pte_t pte;
> =20
> @@ -251,6 +291,12 @@ static int existing_page_cb(pte_t *ptep, unsigned lo=
ng addr, void *data)
>  	if (!pte_present(pte)) /* sanity check */
>  		return 0;
>  	page =3D pte_page(pte);
> +	/*
> +	 * Skip the scratch page. The walk is page-table-driven, not range-tree=
-driven,
> +	 * so it can visit scratch PTEs at uaddrs the BPF program never allocat=
ed.
> +	 */
> +	if (page =3D=3D arena->scratch_page)
> +		return 0;
>  	/*
>  	 * We do not update pte here:
>  	 * 1. Nobody should be accessing bpf_arena's range outside of a kernel =
bug
> @@ -286,9 +332,10 @@ static void arena_map_free(struct bpf_map *map)
>  	 * free those pages.
>  	 */
>  	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(aren=
a),
> -				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
> +				     SZ_4G + GUARD_SZ / 2, existing_page_cb, arena);
>  	free_vm_area(arena->kern_vm);
>  	range_tree_destroy(&arena->rt);
> +	__free_page(arena->scratch_page);
>  	bpf_map_area_free(arena);
>  }
> =20
> @@ -374,33 +421,37 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
>  		return VM_FAULT_RETRY;
> =20
>  	page =3D vmalloc_to_page((void *)kaddr);
> -	if (page)
> +	if (page) {
> +		if (page =3D=3D arena->scratch_page)
> +			/* BPF triggered scratch here; don't lazy-alloc over it */
> +			goto out_sigsegv;
>  		/* already have a page vmap-ed */
>  		goto out;
> +	}
> =20
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> =20
>  	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
>  		/* User space requested to segfault when page is not allocated by bpf =
prog */
> -		goto out_unlock_sigsegv;
> +		goto out_sigsegv_memcg;
> =20
>  	ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
>  	if (ret)
> -		goto out_unlock_sigsegv;
> +		goto out_sigsegv_memcg;
> =20
>  	struct apply_range_data data =3D { .pages =3D &page, .i =3D 0 };
>  	/* Account into memcg of the process that created bpf_arena */
>  	ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		goto out_unlock_sigsegv;
> +		goto out_sigsegv_memcg;
>  	}
> =20
>  	ret =3D apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set=
_cb, &data);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
>  		free_pages_nolock(page, 0);
> -		goto out_unlock_sigsegv;
> +		goto out_sigsegv_memcg;
>  	}
>  	flush_vmap_cache(kaddr, PAGE_SIZE);
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
> @@ -409,8 +460,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	vmf->page =3D page;
>  	return 0;
> -out_unlock_sigsegv:
> +out_sigsegv_memcg:
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
> +out_sigsegv:
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	return VM_FAULT_SIGSEGV;
>  }
> @@ -668,6 +720,7 @@ static void arena_free_pages(struct bpf_arena *arena,=
 long uaddr, long page_cnt,
>  	struct llist_head free_pages;
>  	struct llist_node *pos, *t;
>  	struct arena_free_span *s;
> +	struct clear_range_data cdata;
>  	unsigned long flags;
>  	int ret =3D 0;
> =20
> @@ -696,9 +749,11 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt,
>  	range_tree_set(&arena->rt, pgoff, page_cnt);
> =20
>  	init_llist_head(&free_pages);
> +	cdata.free_pages =3D &free_pages;
> +	cdata.scratch_page =3D arena->scratch_page;
>  	/* clear ptes and collect struct pages */
>  	apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
> -				     apply_range_clear_cb, &free_pages);
> +				     apply_range_clear_cb, &cdata);
> =20
>  	/* drop the lock to do the tlb flush and zap pages */
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> @@ -788,6 +843,7 @@ static void arena_free_worker(struct work_struct *wor=
k)
>  	struct arena_free_span *s;
>  	u64 arena_vm_start, user_vm_start;
>  	struct llist_head free_pages;
> +	struct clear_range_data cdata;
>  	struct page *page;
>  	unsigned long full_uaddr;
>  	long kaddr, page_cnt, pgoff;
> @@ -801,6 +857,8 @@ static void arena_free_worker(struct work_struct *wor=
k)
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> =20
>  	init_llist_head(&free_pages);
> +	cdata.free_pages =3D &free_pages;
> +	cdata.scratch_page =3D arena->scratch_page;
>  	arena_vm_start =3D bpf_arena_get_kern_vm_start(arena);
>  	user_vm_start =3D bpf_arena_get_user_vm_start(arena);
> =20
> @@ -813,7 +871,7 @@ static void arena_free_worker(struct work_struct *wor=
k)
> =20
>  		/* clear ptes and collect pages in free_pages llist */
>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
> -					     apply_range_clear_cb, &free_pages);
> +					     apply_range_clear_cb, &cdata);
> =20
>  		range_tree_set(&arena->rt, pgoff, page_cnt);
>  	}
> @@ -928,23 +986,12 @@ static int __init kfunc_init(void)
>  }
>  late_initcall(kfunc_init);
> =20
> -void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip)
> +static void __bpf_prog_report_arena_violation(struct bpf_prog *prog, boo=
l write,
> +					      unsigned long addr, unsigned long fault_ip)
>  {
>  	struct bpf_stream_stage ss;
> -	struct bpf_prog *prog;
>  	u64 user_vm_start;
> =20
> -	/*
> -	 * The RCU read lock is held to safely traverse the latch tree, but we
> -	 * don't need its protection when accessing the prog, since it will not
> -	 * disappear while we are handling the fault.
> -	 */
> -	rcu_read_lock();
> -	prog =3D bpf_prog_ksym_find(fault_ip);
> -	rcu_read_unlock();
> -	if (!prog)
> -		return;
> -
>  	/* Use main prog for stream access */
>  	prog =3D prog->aux->main_prog_aux->prog;
> =20
> @@ -957,3 +1004,53 @@ void bpf_prog_report_arena_violation(bool write, un=
signed long addr, unsigned lo
>  		bpf_stream_dump_stack(ss);
>  	}));
>  }
> +
> +bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write, unsi=
gned long fault_ip)
> +{
> +	struct bpf_arena *arena;
> +	struct bpf_prog *prog;
> +	unsigned long kbase;
> +	unsigned long page_addr =3D addr & PAGE_MASK;
> +
> +	prog =3D bpf_prog_find_from_stack();
> +	if (!prog)
> +		return false;
> +
> +	arena =3D prog->aux->arena;
> +	/* a prog not using arena may be on stack, so arena can be NULL */
> +	if (!arena)
> +		return false;
> +
> +	kbase =3D bpf_arena_get_kern_vm_start(arena);
> +
> +	/*
> +	 * Recovery covers the 4 GiB mappable band plus the upper half-guard.
> +	 * Lower guard is unreachable from kfuncs; an address there indicates
> +	 * a different bug class - leave it to the regular kernel oops path.
> +	 */
> +	if (page_addr < kbase || page_addr >=3D kbase + SZ_4G + GUARD_SZ / 2)
> +		return false;
> +
> +	apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
> +			    apply_range_set_scratch_cb, arena->scratch_page);
> +	flush_vmap_cache(page_addr, PAGE_SIZE);
> +	__bpf_prog_report_arena_violation(prog, is_write, page_addr - kbase, fa=
ult_ip);
> +	return true;
> +}
> +
> +void bpf_prog_report_arena_violation(bool write, unsigned long addr, uns=
igned long fault_ip)
> +{
> +	struct bpf_prog *prog;
> +
> +	/*
> +	 * The RCU read lock is held to safely traverse the latch tree, but we
> +	 * don't need its protection when accessing the prog, since it will not
> +	 * disappear while we are handling the fault.
> +	 */
> +	rcu_read_lock();
> +	prog =3D bpf_prog_ksym_find(fault_ip);
> +	rcu_read_unlock();
> +	if (!prog)
> +		return;
> +	__bpf_prog_report_arena_violation(prog, write, addr, fault_ip);
> +}
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 066b86e7233c..fa368d8920d9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3290,6 +3290,11 @@ __weak u64 bpf_arena_get_kern_vm_start(struct bpf_=
arena *arena)
>  {
>  	return 0;
>  }
> +__weak bool bpf_arena_handle_page_fault(unsigned long addr, bool is_writ=
e,
> +					unsigned long fault_ip)
> +{
> +	return false;
> +}
> =20
>  #ifdef CONFIG_BPF_SYSCALL
>  static int __init bpf_global_ma_init(void)

