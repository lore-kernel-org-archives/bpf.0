Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69096274B53
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179938; cv=none; b=H+HkDMZ0vC5veAOD4SFcn/JG3KyJ5jIEMgg7u4Zjov7v99sA+P/XxdPsu4fnMMg1vhmZsOUaDU4ObY+2qX+CMBhB/VaemTYWArZGSb8qgNYnRVw78Ck9Vpa4zmKbv6l8yDMC6mFUGS45gbh9J7RkvUlANk68kXNQj7KE3eCH4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179938; c=relaxed/simple;
	bh=zK5ncSguZdWcAaUKZBb56PMqy9oUwt1argimx1tSaWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shFfMvPeLtpy7d+O5WYatAshVf4mWVTcY+Jj+WezirnRnKoGevDazlFpgAfeIyJbMe7g++X5GK0EcpSiRm+mcIgvQVr/e2yux/GDu4WDGs4rBWgPgJalwANBepSs1mkiTwaPewxVe+ZNY82HixTEUbnbhD+ujvwDmSm0Y02SwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5SPhuY1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5SPhuY1"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bd810cdc5dso13037187b3.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179936; x=1778784736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iuEHp6Cypc5z2ggicspGcmwWyOQWaTV1+mNT4ShGRhw=;
        b=G5SPhuY1qzcOFEXeK/33I9zJgQakx9stvMRjWRIn9VH45PtX8un3lJc+T7iOwv7zQU
         DgzI0NkeGfvMjg3daWzkB/TSt4kgka7/uQHlgXPmNg7R79CXS+eEHRVHdPnIcJsVa4OF
         eNUy0RirORvsOzCh5Erlkz76zqJZXWJirGj+B1pxL3g6yU6gnekf86XOZtIc2STDo7dK
         1aJqcIesbJSbOwkfzXN56IYrXCcuEiPjolAreur33aLkwjVwhSF91prC0d5N+gys2hpx
         9b+oYp7LaDANFgenBbU95smFCIHRT6SLEPbQIXIjtq1Ss467Y+UDK4A1Ue+2AyJn4F/M
         sE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179936; x=1778784736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuEHp6Cypc5z2ggicspGcmwWyOQWaTV1+mNT4ShGRhw=;
        b=plKyBFskDbWNTBPYg1wjvRl6u21rG/hGHxy1ssSMOeJCcd00jG69O41dfnaS7E0t2m
         +wLXeXE1KIgv3yaYd8Iw9kHaCUukZA10YumTdgiL1IFeCCfV9OuMnKG1Q7pcHNS4io3V
         hYwdGv8TPuQbEZfCj1q6iASEwnpk68mw5lrjeDNAo5iNDh1j5tt2OAW6zh4/VSpdFq+l
         RflKKC5GCxymUPFS0sBl///kZHKD2Kv9fO8PSCcG6fzXPLxSjSObiyRRnNFivYQMlRpY
         S8gWZgUD3ACGs56zidImw1jKbQzJSR9Z45O0JMzVm7YvXALX9TauHi9n2r0XUVZHC1Zn
         WGVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KmZSBZWcS7R1VmIRnA88tJk/xO/VrRjrJKQ28jWFasTjmrFtdT3mQOs1arn8yMPIBWNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpgstAWbqGDlW6EKBklT/XeS/kN6wNmk/nUHxAShxiriptJg9
	G9s5o+VIHBove5S3hSoexxzZzsj4vEciiW3Chr8W57jBit7efyz/xx5K
X-Gm-Gg: Acq92OHvA9GRsUNy4kwpiMEymbmjE8oV90lC6p0YIw+JAAPwlnCNAqoSVi4jojLgb8h
	nIqwSaKzr725S9RyMTo9llsofyxrg2S5ZhelBhoBM+YSUOi/jRL4pH/G+AEOgxQ8W23wh1mmPxr
	biQ9q9BPGBls00Ga44l+xJO1em4caDNK99RDCWhCtG7I2oHXllxBAUfqhF8XMdvG2Ymgjk9Z40K
	TUdomR8VJGJ+bHOewi8TCfVHDpd+jbs7KAWefEMdhTrmasaf/yTkiwWMjtESvzUjHe7Wohwahi7
	lmy4/q8EwIA277qLcfNT54FvFQq/pVZucQkvkbCgu5u22lN0KtqiNPoUoM3wpjiGO8uJTlP0ENx
	JJ6KjgYL3Fm/ryw3ir0kFiY9ExJ8vVNV8GQo0zG3wygWyFU8LqiiZCxAzdqnv7SwwWJdBSMlmED
	xblXwRf9fPRkCiafox0MuezwumGYHCeNqgrk/ZyOIrhlpgqTGlHGk00qYg
X-Received: by 2002:a05:690c:c0d8:b0:79a:3655:9df5 with SMTP id 00721157ae682-7bdf5dc6e2cmr97229707b3.12.1778179936290;
        Thu, 07 May 2026 11:52:16 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:491:bfe9:4001:a4da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652742csm95077927b3.9.2026.05.07.11.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:52:15 -0700 (PDT)
Date: Thu, 7 May 2026 14:52:15 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org, 
	mykyta.yatsenko5@gmail.com, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <afzeWzdWQ7eDJ-hP@zenbox>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <77bd1e436e9b8a4679a4e60adf5971f93688ff28ad0a9b16a0adf2b8172dd116@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77bd1e436e9b8a4679a4e60adf5971f93688ff28ad0a9b16a0adf2b8172dd116@mail.kernel.org>

On Thu, May 07, 2026 at 06:43:29PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> 
> [ ... ]
> 
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 3b1f0ba02f61..d34fdb99eb8a 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/bpf_trace.h>
> >  #include <linux/bpf_lirc.h>
> >  #include <linux/bpf_verifier.h>
> > +#include <linux/bpf_mem_alloc.h>
> >  #include <linux/bsearch.h>
> >  #include <linux/btf.h>
> >  #include <linux/hex.h>
> > @@ -19,6 +20,7 @@
> >  #include <linux/fdtable.h>
> >  #include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/irq_work.h>
> >  #include <linux/license.h>
> >  #include <linux/filter.h>
> >  #include <linux/kernel.h>
> > @@ -42,6 +44,8 @@
> >  #include <linux/cookie.h>
> >  #include <linux/verification.h>
> >
> > +#include "percpu_freelist.h"
> > +
> >  #include <net/netfilter/nf_bpf_link.h>
> >  #include <net/netkit.h>
> >  #include <net/tcx.h>
> > @@ -65,6 +69,111 @@ static DEFINE_SPINLOCK(map_idr_lock);
> >  static DEFINE_IDR(link_idr);
> >  static DEFINE_SPINLOCK(link_idr_lock);
> >
> > +struct bpf_dtor_kptr_work {
> > +	struct pcpu_freelist_node fnode;
> > +	void *obj;
> > +	btf_dtor_kfunc_t dtor;
> > +};
> > +
> > +/* Queue pending dtors; the idle pool uses a global pcpu_freelist. */
> > +static struct pcpu_freelist bpf_dtor_kptr_jobs;
> > +static struct pcpu_freelist bpf_dtor_kptr_idle;
> > +/* Keep surplus = total - needed = idle - refs >= 0 so NMI frees never need to allocate. */
> > +static atomic_long_t bpf_dtor_kptr_surplus = ATOMIC_LONG_INIT(0);
> 
> An unaddressed review comment from the v2 discussion raises a design
> concern about the complexity of this implementation. Mykyta Yatsenko
> suggested an alternative design where bpf_dtor_kptr_work is stored in the
> kptr map slot itself (a bpf_kptr_box approach) instead of using two lists
> (idle and armed) with 3 atomics and headroom/trimming management.
> 
> From the lore discussion at:
> https://lore.kernel.org/bpf/51a054a0-e57f-49dc-9527-36da0535087c@gmail.com/
> 
> Mykyta's suggestion was:
> 
> "I think this still looks too complex:
>  * 2 lists - idle list and armed list
>  * 3 atomics, controlling demand/supply
>  * headroom/trimming management
> 
> The complexity introduced for performance reasons, but I'm not sure if
> the tradeoff is worth it.
> 
> What about the next design:
> 
> Instead of idle list, store bpf_dtor_kptr_work in the kptr map slot
> itself. Use kmalloc_nolock() to allocate bpf_dtor_kptr_work on the first
> xchg just once per map value, then reuse it across xchg in/out."
> 
> While Justin responded with an explanation of ABBA ordering issues, and
> Mykyta provided a more detailed counter-proposal with RCU protection and
> atomic detach/attach, the v3 implementation does not adopt this
> suggestion and still uses the pcpu_freelist approach with a surplus
> counter.
> 
> Was there a specific technical reason to continue with the two-list
> approach rather than exploring the bpf_kptr_box alternative, or would it
> be worth revisiting this design choice?
> 
This was addressed.

See https://lore.kernel.org/bpf/afy8yl1bleXmO78H@suesslenovo/

storing a pointer to the bpf_kptr_box, or any other pointer that isn't
the original kptr in the map slot would break direct load operations
on ref kptrs in maps requiring patching the program and breaking
bpf assumptions.

> [ ... ]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> This commit fixes a deadlock bug but lacks a Fixes: tag. The bug was
> introduced in commit 14a324f6a67e ("bpf: Wire up freeing of referenced
> kptr") which added bpf_map_free_kptrs() that calls kptr destructors
> inline without checking for NMI context.
> 
> When BPF programs attached to tp_btf/nmi_handler delete map entries,
> destructors like bpf_cpumask_release() that take RCU locks are called
> from NMI, causing system deadlock.
> 
> Suggested: Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
> 
>
I'll add the Fixes: tag in next reroll.
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25513277524

