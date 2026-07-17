Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A534040B
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260017; cv=pass; b=MpZwoiFsJPIljc+GsZyyI7UFWle6W20KR4oUZI6yhDPAw1lQdDymvB25CjRJHGAfPI6JbifKr8l9wynicdszNw6ovF/EGisITxgiwT1JFqGQY6Wa0SRd2hoiUybSwdU4iRx3y/+qZsw4kqpr0t5Vm3ThQp+ooVZwZmWV+A4XDSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260017; c=relaxed/simple;
	bh=N3fP95K9irXNso3jags5aBR487rSqTZ+oeDUbB+drfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsrps4xgXvL/5Q7xjz3TNFi593DiVA7VoSMLrouG38AHPQEp2si9/1zcY74MY2dbaP7tQm7+/Y5cBWuyCyR181EWH325K50EYROo/Fn6xsGUlkU4xTZXSYRswTjukj1KWcm/7XLD8FoIWs1L7bDtVm7TafmJxBN1v7MFnXEMuG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdYj+q2E; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdYj+q2E"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-446f87b6de1so3274365fac.3
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 20:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784260014; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5un9J8DuOyvAoTmu4AkdZ6Zx7PSw+314YzO0KCeSK46jwYsJUqtBxuZvho7Iq8O2m
         MgCYCr55WGO2+m3brqJ32+p4PBzOLAO//hU46Xd6Gc+DN4tw8p5nMGqd+0C8UYx+iV90
         60RTJtWWvLmwix8fT1Gipif9aV70MHKat6EhIzKvG7/s1efQIaaKx77HNThUWHyehlgC
         AUK4MTOaSVZNvY3YuRbwLKCuc6S6zRDnfXO3Ciheb+alP7QeIHcsAfIuEpl4V7pdO13T
         w0FqffdlDRlwzkIq3bl8M+JaUFPrQi8JK401acVTmVdsBEsAedXfH5bc3Abn0VzRH5Ke
         G3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+qfsfSM7+v1WClc9BxhjMt2YlMxMtKRK2E8WppuykZI=;
        fh=cK6Cohotf1jXxss2UTMjHvKSxmKko1KPegYO6oH1uBM=;
        b=SooGr1+xMj1eAHITjZfHWuZDaVLO2IHDWWZ1LyuHP7hwYY/2YoUVrwGcPBj9YuP3bk
         SLYjwbPUJLpNhb/JboRJyn+6TGVYVfQtLIec8uGMy2dFCXyZ2LW0eVybpN3fvzuKkTpj
         zqUdXKvDRQz5Bzhuk6nw4Y+IdHElR3vJ+tNw4GUuhMED3zGIbQpS5H2jl0UwNjp37KEx
         qo4b/ZzNGhLvdqJb4IWL4LQrwjSXBMo9cIT6JUHKAGHNLeBMMhX0DGUAQpM1dFZ8Rq+u
         Joa+L+wFqACFP28b4Eix0QuomqKdEYa/Eebg9BDrdKfTFICn6xdMOmiSX85WuYR4WhG9
         0aJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784260014; x=1784864814; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+qfsfSM7+v1WClc9BxhjMt2YlMxMtKRK2E8WppuykZI=;
        b=qdYj+q2EWfrycp3pPsJ+CchD861m7W4DZKe8nqTihfVjt+54usexVwm9bnRRb1NWSK
         mojP4UoNaybtyuILBit3sAseHl+OW9T9ukOC6P+fWqKkxhDl7Du76wvOtXBlcZ1f4R6P
         4idaRD2Yn2KtYn42ZA5nKrGwmDykLXA0mnffL9oed2P48c4WI1WCVXs0aZghEfFxLS+y
         5OlVgUEayX7Pkb7w957zNY+ESWWnQkjNCnyLyqRGNw5GnscjLmFVxDBJmDuhLyxNu4cQ
         dhLo6E5zpWjG7QPzyo+boYPcxzOag6ZYjHLCRZI1fmj8OT1rvzkfOQjk48ybkDLY7mra
         ju8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784260014; x=1784864814;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+qfsfSM7+v1WClc9BxhjMt2YlMxMtKRK2E8WppuykZI=;
        b=eL5+zl+mn6b2Fk8lDCIrtrGVjvnI60xrPtjlnxLpBRwrI92+sZBnuJ8F8LpXJIacmI
         dIRM8TIKAb9TUAwGCsObI+Ek43COh9WMwYfUG/fMWUJagVU3mi0a+XRgRwavAC8d1Ns1
         18mqhVgcU6UBql0GglAa1LGSczPXOcsj8hdkesNDaGFgrAyr0zQysyMCE6QFg8gfMpjp
         LHPomgah6pPQk5KROIBkN+XGlGvzVkSPaLw4n85Ec16hcMrEnLrLvDbXKqwCArNESjDQ
         VBFlCtA4kq2iVDaJMvsoJjhRULQtvQDDNre3aAgpr5ShyqASkfADGvoBXBUKfVbjP6gw
         uXyw==
X-Forwarded-Encrypted: i=1; AHgh+RqKN77ay/ye82BBPnlwJia5i+6Dr3aVJzQsDTfjOyOAS0aVPzIlLhQhGxTYAjCHt9dS2EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCJ8bwmxoe5sp9gk76oMEP3loaSGSawRXFm2jqK0L6IkN+SdV
	hNUyG4QF2u2rmHDGBK1ZT7Hdjt5wfqGvDUQHpWcm5xqwXorzOXCzTKU24YEspmlOTAOYSgLLKoe
	gCABYQuDFgV3CNRtr+Q7DLXsKkZAXNAs=
X-Gm-Gg: AfdE7clcMq1QVpgbDrVKWWWgF/m+vOr2R86Y88J2Bapn7rQzPlybh1Gb/budLd5zBwz
	Vpw+JptuH7XKzlOYH4bDUgnOr5jsce4vud/5mlS7AT43y9U+Y1JTdUBeaPj0gJmUF7BwpQXcK3q
	URbFTcFcWzdNerFXBwYrgdy++CK1W2vA7KtL9PYyhkPq06JWmdES1dRsh94d9AFrZZJKYf2o92O
	X6C88ghqwSDnH+0EG6ZMGGnWXbeqpSV6140YJqwxPLV33jf4DoKTXAPtscQ6RaGxGXEu1JuX9a+
	k6L4jAcItS8aLdYr
X-Received: by 2002:a05:6808:14c6:b0:4a4:a693:9d8f with SMTP id
 5614622812f47-4a4d03063fdmr419990b6e.6.1784260013937; Thu, 16 Jul 2026
 20:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org> <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
In-Reply-To: <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 17 Jul 2026 04:46:42 +0100
X-Gm-Features: AUfX_mxBLT37KrDyrNbP0EYWC50r_QKOrJ4iSaMj1OT4QL3-liPKJMNfSVRy2ow
Message-ID: <CA+XhMqzUO49FiC-Oa6VYUt7Wm9RZLH30DhUH2kVn_PBodyZ6dg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write lock
 to avoid UAF
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 22:31, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> x86 implements page attribute modification using its Change Page
> Attributes (CPA) mechanism.
>
> This tracks properties of ranges such as cache mode through x86 page
> attributes, and as part of that logic manipulates kernel page tables.
>
> Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> fragmentation") ranges of kernel page table entries can be collapsed into
> huge page table entries as part of this logic.
>
> As part of this collapse, it frees the page tables which the collapsed
> entries previously pointed to, and it does so without any relevant locks
> being held to preclude concurrent kernel page table walkers.
>
> The only way this code can be reached is if CPA_COLLAPSE is specified, and
> this is only set in set_memory_rox() via:
>
> set_memory_rox()
> -> change_page_attr_set_clr()
> -> cpa_flush()
> -> cpa_collapse_large_pages()
>
> Notable users of this are execmem and bpf when manipulating executable
> mappings.
>
> However, this is problematic for ptdump as it walks ranges it does not own
> and thus runs the risk of a use-after-free on page tables freed underneath
> it.
>
> In addition, concurrent CPA collapse operations are possible which can also
> cause races.
>
> Resolve the issue by acquiring the mmap write lock on init_mm across the
> whole operation.
>
> It is safe to acquire a sleeping lock as all the callers invoke
> set_memory_rox() from process context and in any case,
> change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> mutex, disallowing atomic context here.
>
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 15 ++++++++++++++-
>  include/linux/mmap_lock.h    |  2 ++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d023a40a1e03..d1e63f7d267f 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -22,6 +22,7 @@
>  #include <linux/cc_platform.h>
>  #include <linux/set_memory.h>
>  #include <linux/memregion.h>
> +#include <linux/cleanup.h>
>
>  #include <asm/e820/api.h>
>  #include <asm/processor.h>
> @@ -410,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
>
>  static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
>
> -static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>  {
>         unsigned long start, addr, end;
>         struct ptdesc *ptdesc, *tmp;
> @@ -442,6 +443,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>         }
>  }
>
> +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +{
> +       /*
> +        * Take the mmap write lock on init_mm to:
> +        * - Avoid a use-after-free if raced by ptdump (which takes its own
> +        *   write lock on init_mm).
> +        * - Serialise concurrent CPA walkers.
> +        */
> +       scoped_guard(mmap_write_lock, &init_mm)
> +               __cpa_collapse_large_pages(cpa);
> +}
> +
>  static void cpa_flush(struct cpa_data *cpa, int cache)
>  {
>         unsigned int i;
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 6b5c2390cc30..047f5f5e2c34 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -621,6 +621,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
>
>  DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
>              mmap_read_lock(_T), mmap_read_unlock(_T))
> +DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
> +            mmap_write_lock(_T), mmap_write_unlock(_T))
>  DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
>
>  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>
> --
> 2.55.0
>

Hi,

This bullet confuses me. __change_page_attr() and friends are serialised by
cpa_lock/pgd_lock and never take init_mm's mmap lock, so this doesn't
exclude them.

Collapse vs collapse looks covered already: collapse_large_pages() holds
pgd_lock across the walk and both collapse_pmd_page()/collapse_pud_page()
calls, and the pmd_leaf()/pud_leaf() early-outs stop a second CPU
re-queueing a collapsed table. I couldn't build the interleaving behind the
cover letter's "could result in memory corruption". Can you spell it out?

If the reason is really Will's v3 point - collapse rounds up to PMD/PUD and
frees tables outside its caller's range, so it has to exclude
walk_kernel_page_table_range() walkers holding the read lock - then say
that. It's a UAF independent of ptdump, and it's why v3's read lock wasn't
enough.

Also: patch 1 justifies the trylock fallback on ptdump being rare, but this
takes the write lock on every set_memory_rox() (BPF JIT, module load,
execmem), even when nothing collapsed. vmap_try_huge_*() then loses the
trylock and quietly falls back to PTEs on every BPF load. No counter, no
trace. Not a blocker and I've no better idea, but fa93b45fd397 was about
getting vmalloc-huge on by default, so it's worth calling out.

Rest looks right. 4/4 restores pud_free_pmd_page() exactly as it was before
fa93b45fd397, and 3/4 builds the same walk init_mm got via
walk_kernel_page_table_range_lockless().

Reviewed-by: David Carlier <devnexen@gmail.com>

Cheers !
