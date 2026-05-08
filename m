Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6E3D9DBD;
	Fri,  8 May 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255854; cv=none; b=rS5IZeF2556pP8nzBXaG38AtHgh1ho3tVCFo/O7WNwTPM28V1vLGDxQ5GkPDJz+m0X+BdlXc6qhY3fs3/LHOaHVVldMjvuRTcWBmwp1C8pXyP4iEHD2Zcv7v3IQy4MxDrxEr/WlvfOgSrLhHLLp+MuQp+Qh0Se0kFZd2laxolQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255854; c=relaxed/simple;
	bh=gRMh0vxNvOcqmY4byqlbNlY2lSNV+1xXQpcIqJYlhvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkS7suC1g+3nhPzsNYlsH43BVWp/iCruPpFsfmoBgyRri7V4ORfID+o16EPBmP9/yYHLC7C5nXgffNNbPTHNOH/MiLg+af/fnX6V/Tb8EIk/FS50K3AyCLn+7XzWLziqrjs/Xl3I88AEvAKOklTAXnXRfVuJruNyRmI582ETlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH1qv6dg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH1qv6dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB30AC2BCB0;
	Fri,  8 May 2026 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778255853;
	bh=gRMh0vxNvOcqmY4byqlbNlY2lSNV+1xXQpcIqJYlhvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hH1qv6dg+jT6rT+czTfAZY+WSEadGq4YN/5/N2lYHvfdsZCnln3eYeAs9OVuVWZ9v
	 1mSAQB0WIwDg3xPfq6BxQXzxUpEBPA8N37QTY7QDC9c8O2cdaeaoVlzGZoW2WrmKqG
	 WTwwPnhh0lhbFkaQkdKZzKQyIyy+T1+a1CLIhX4NF2h4mW6udxu+qGaHe5zF3Un7Rx
	 uQLnAYR1OCBlt4tao8V+zxEAmvs+2RNdHZCj8e3fbYz8kPkkudOrX1SCa4NPB1p1BT
	 pGaeX0s5Zpjg+l5VyIfmVJZZ5RwoZ77swhtQVpGg8jHbY8VffhiSXkhYOk6rF1ovwd
	 Em1uUqF4kJ1Dg==
Date: Fri, 8 May 2026 16:57:24 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, roman.gushchin@linux.dev, 
	inwardvessel@gmail.com, shakeel.butt@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	surenb@google.com, tz2294@columbia.edu, baohua@kernel.org, lance.yang@linux.dev, 
	dev.jain@arm.com, laoar.shao@gmail.com, gutierrez.asier@huawei-partners.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v2 3/4] mm: introduce bpf_mthp_ops struct ops
Message-ID: <af3_HfCPpLNe1Wri@lucifer>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
 <20260508150055.680136-4-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508150055.680136-4-vernon2gm@gmail.com>

NACK

This patch not only overreaches by fundamentally impacting THP behaviour (which
has NOTHING to do with the subject line), but also, unbelievably, taking control
over this away from the THP maintainers, are you actually serious here?

On Fri, May 08, 2026 at 11:00:54PM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
>
> Introducing bpf_mthp_ops enables eBPF programs to register the
> mthp_choose callback function via cgroup-ebpf.
>
> Using cgroup-bpf to customize mTHP size for different scenarios，
> automatically select different mTHP sizes for different cgroups,
> let's focus on making them truly transparent.

Err, wait what? You're both adding a BPF hook and then adding a default policy
change that affects all cgroups anyway?

Or are you not and this message is just wrong (I don't really see how you're
'automatically' doing anything here).

And the commit message is 'add struct opts'?

>
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>

Please have a bit of a think about how you're approaching this, wait until the
THP code has actually been reworked (you can contribute patches to speed that
up), before even thinking of sending something like this again, and then send it
as an RFC.

> ---
>  MAINTAINERS                     |   3 +
>  include/linux/bpf_huge_memory.h |  52 ++++++++++
>  include/linux/cgroup-defs.h     |   1 +
>  include/linux/huge_mm.h         |   6 ++
>  kernel/cgroup/cgroup.c          |   2 +
>  mm/Kconfig                      |  14 +++
>  mm/Makefile                     |   1 +
>  mm/bpf_huge_memory.c            | 168 ++++++++++++++++++++++++++++++++
>  8 files changed, 247 insertions(+)
>  create mode 100644 include/linux/bpf_huge_memory.h
>  create mode 100644 mm/bpf_huge_memory.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index caaa0d6e6056..f1113eaa1193 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4887,7 +4887,10 @@ M:	Shakeel Butt <shakeel.butt@linux.dev>
>  L:	bpf@vger.kernel.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +F:	include/linux/bpf_huge_memory.h
> +F:	mm/bpf_huge_memory.c

Err what??

You're adding THP-specific behaviour to 'BPF [MEMORY MANAGEMENT EXTENSIONS]'?

I'm sorry but what on earth possessed you to do that?

>  F:	mm/bpf_memcontrol.c
> +F:	samples/bpf/mthp_ext.*
>
>  BPF [MISC]
>  L:	bpf@vger.kernel.org
> diff --git a/include/linux/bpf_huge_memory.h b/include/linux/bpf_huge_memory.h
> new file mode 100644
> index 000000000000..ffda445c9572
> --- /dev/null
> +++ b/include/linux/bpf_huge_memory.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_HUGE_MEMORY_H
> +#define __BPF_HUGE_MEMORY_H
> +
> +#include <linux/cgroup-defs.h>
> +
> +/**
> + * struct bpf_mthp_ops - BPF callbacks for mTHP operations
> + * @mthp_choose: Choose the custom mTHP orders
> + *
> + * This structure defines the interface for BPF programs to customize
> + * mTHP behavior through struct_ops programs.
> + */
> +struct bpf_mthp_ops {
> +	unsigned long (*mthp_choose)(struct cgroup *cgrp, unsigned long orders);
> +};
> +
> +#ifdef CONFIG_BPF_TRANSPARENT_HUGEPAGE
> +/**
> + * bpf_mthp_choose - Choose the custom mTHP orders using bpf
> + * @mm: task mm_struct
> + * @orders: original orders
> + *
> + * Return suited mTHP orders.
> + */
> +unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orders);
> +
> +/**
> + * cgroup_bpf_set_mthp_ops - Set sub-cgroup mthp_ops to parent cgroup
> + * @cgrp: want to set mthp_ops of sub-cgroup
> + * @parent: parent cgroup
> + */
> +static inline void cgroup_bpf_set_mthp_ops(struct cgroup *cgrp,
> +					   struct cgroup *parent)
> +{
> +	WRITE_ONCE(cgrp->mthp_ops, parent->mthp_ops);
> +}
> +#else
> +static inline unsigned long bpf_mthp_choose(struct mm_struct *mm,
> +					    unsigned long orders)
> +{
> +	return orders;
> +}
> +static inline void cgroup_bpf_set_mthp_ops(struct cgroup *cgrp,
> +					   struct cgroup *parent)
> +{
> +}
> +#endif /* CONFIG_BPF_TRANSPARENT_HUGEPAGE */

These have the same interface flaws as the original THP BPF work. We don't know
whether we want BPF interfering on this decision and it impacts future
development on this.

> +
> +#endif /* __BPF_HUGE_MEMORY_H */
> +
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index f42563739d2e..78854d0e06ab 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -628,6 +628,7 @@ struct cgroup {
>
>  #ifdef CONFIG_BPF_SYSCALL
>  	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
> +	struct bpf_mthp_ops *mthp_ops;
>  #endif
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	struct scx_sched __rcu *scx_sched;
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 127f9e1e7604..65da35fb0980 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_HUGE_MM_H
>
>  #include <linux/mm_types.h>
> +#include <linux/bpf_huge_memory.h>
>
>  #include <linux/fs.h> /* only for vma_is_dax() */
>  #include <linux/kobject.h>
> @@ -296,6 +297,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  				       enum tva_type type,
>  				       unsigned long orders)
>  {
> +	/* The eBPF-specified orders overrides which order is selected. */
> +	orders &= bpf_mthp_choose(vma->vm_mm, orders);

OK so every single time we call thp_vma_allowable_orders() we take an SRCU lock,
even if there aren't any BPF hooks?...!

And guess what, nobody in THP can do a damn thing to change it since you took
control of that away from us.

No dude.

> +	if (!orders)
> +		return 0;
> +
>  	/*
>  	 * Optimization to check if required orders are enabled early. Only
>  	 * forced collapse ignores sysfs configs.
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 43adc96c7f1a..1dbef3e8b179 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5836,6 +5836,8 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
>  	if (ret)
>  		goto out_stat_exit;
>
> +	cgroup_bpf_set_mthp_ops(cgrp, parent);
> +

I'm not loving putting this is a fundamental cgroup function like this.

>  	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp))
>  		cgrp->ancestors[tcgrp->level] = tcgrp;
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 27dc5b0139ba..be49bde783a7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -949,6 +949,20 @@ config NO_PAGE_MAPCOUNT
>
>  	  EXPERIMENTAL because the impact of some changes is still unclear.
>
> +config BPF_TRANSPARENT_HUGEPAGE
> +	bool "BPF-based transparent hugepage (EXPERIMENTAL)"

Experimental means nothing.

> +	depends on TRANSPARENT_HUGEPAGE && CGROUP_BPF
> +	help
> +	  Using cgroup-bpf to customize mTHP size for different scenarios,
> +	  automatically select different mTHP sizes for different cgroups,
> +	  let's focus on making them truly transparent.
> +
> +	  This is an experimental feature, that might go away at any time,
> +	  Please do not rely any production environment.

That's not how BPF works.

> +
> +	  EXPERIMENTAL because the BPF interface is unstable and may be removed
> +	  at any time.

That's not how BPF works.

Did you even follow what was said on the last THP BPF series?

The interface is permanent, it doesn't matter what experimental labels you put
on it.

> +
>  endif # TRANSPARENT_HUGEPAGE
>
>  # simple helper to make the code a bit easier to read
> diff --git a/mm/Makefile b/mm/Makefile
> index 8ad2ab08244e..b474c21c3253 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -108,6 +108,7 @@ obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
>  ifdef CONFIG_BPF_SYSCALL
>  obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
> +obj-$(CONFIG_BPF_TRANSPARENT_HUGEPAGE) += bpf_huge_memory.o
>  endif
>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_TEST) += gup_test.o
> diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
> new file mode 100644
> index 000000000000..851c6ebe2933
> --- /dev/null
> +++ b/mm/bpf_huge_memory.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Huge memory related BPF code

Honestly reading this is making me a bit... annoyed :)

You seem to be trying to take control of THP away from the THP maintainers and
reviewers who work bloody hard for the community.

I'm sure you don't mean to, but it's not at all welcome!

I'll stop here, this series is a no.

> + *
> + * Author: Vernon Yang <yanglincheng@kylinos.cn>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/srcu.h>
> +
> +/* Protects cgrp->mthp_ops pointer for read and write. */
> +DEFINE_SRCU(mthp_bpf_srcu);
> +
> +unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orders)
> +{
> +	struct cgroup *cgrp;
> +	struct mem_cgroup *memcg;
> +	struct bpf_mthp_ops *ops;
> +	int idx;
> +
> +	memcg = get_mem_cgroup_from_mm(mm);
> +	if (!memcg)
> +		return orders;
> +
> +	cgrp = memcg->css.cgroup;
> +
> +	idx = srcu_read_lock(&mthp_bpf_srcu);
> +	ops = READ_ONCE(cgrp->mthp_ops);
> +	if (unlikely(ops && ops->mthp_choose))
> +		orders = ops->mthp_choose(cgrp, orders);
> +	srcu_read_unlock(&mthp_bpf_srcu, idx);
> +
> +	mem_cgroup_put(memcg);
> +
> +	return orders;
> +}
> +
> +static int bpf_mthp_ops_btf_struct_access(struct bpf_verifier_log *log,
> +		const struct bpf_reg_state *reg, int off, int size)
> +{
> +	return -EACCES;
> +}
> +
> +static bool bpf_mthp_ops_is_valid_access(int off, int size, enum bpf_access_type type,
> +		const struct bpf_prog *prog, struct bpf_insn_access_aux *info)
> +{
> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +const struct bpf_verifier_ops bpf_mthp_verifier_ops = {
> +	.get_func_proto = bpf_base_func_proto,
> +	.btf_struct_access = bpf_mthp_ops_btf_struct_access,
> +	.is_valid_access = bpf_mthp_ops_is_valid_access,
> +};
> +
> +static int bpf_mthp_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
> +	struct bpf_mthp_ops *ops = kdata;
> +	struct cgroup_subsys_state *child;
> +	struct cgroup *cgrp;
> +
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	cgrp = st_link->cgroup;
> +	if (!cgrp)
> +		return -EINVAL;
> +
> +	cgroup_lock();
> +	css_for_each_descendant_pre(child, &cgrp->self) {
> +		if (READ_ONCE(child->cgroup->mthp_ops)) {
> +			pr_warn("sub-cgroup has already registered.\n");
> +			cgroup_unlock();
> +			return -EBUSY;
> +		}
> +	}
> +	css_for_each_descendant_pre(child, &cgrp->self)
> +		WRITE_ONCE(child->cgroup->mthp_ops, ops);
> +	cgroup_unlock();
> +
> +	return 0;
> +}
> +
> +static void bpf_mthp_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
> +	struct cgroup_subsys_state *child;
> +	struct cgroup *cgrp;
> +
> +	if (!link)
> +		return;
> +
> +	cgrp = st_link->cgroup;
> +	if (!cgrp)
> +		return;
> +
> +	cgroup_lock();
> +	css_for_each_descendant_pre(child, &cgrp->self)
> +		WRITE_ONCE(child->cgroup->mthp_ops, NULL);
> +	cgroup_unlock();
> +
> +	synchronize_srcu(&mthp_bpf_srcu);
> +}
> +
> +static int bpf_mthp_ops_check_member(const struct btf_type *t,
> +				     const struct btf_member *member,
> +				     const struct bpf_prog *prog)
> +{
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +	switch (moff) {
> +	case offsetof(struct bpf_mthp_ops, mthp_choose):
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (prog->sleepable)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int bpf_mthp_ops_init_member(const struct btf_type *t,
> +				    const struct btf_member *member,
> +				    void *kdata, const void *udata)
> +{
> +	return 0;
> +}
> +
> +static int bpf_mthp_ops_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +static unsigned long cfi_mthp_choose(struct cgroup *cgrp, unsigned long orders)
> +{
> +	return 0;
> +}
> +
> +static struct bpf_mthp_ops cfi_bpf_mthp_ops = {
> +	.mthp_choose = cfi_mthp_choose,
> +};
> +
> +static struct bpf_struct_ops bso_bpf_mthp_ops = {
> +	.verifier_ops = &bpf_mthp_verifier_ops,
> +	.reg = bpf_mthp_ops_reg,
> +	.unreg = bpf_mthp_ops_unreg,
> +	.check_member = bpf_mthp_ops_check_member,
> +	.init_member = bpf_mthp_ops_init_member,
> +	.init = bpf_mthp_ops_init,
> +	.name = "bpf_mthp_ops",
> +	.owner = THIS_MODULE,
> +	.cfi_stubs = &cfi_bpf_mthp_ops,
> +};
> +
> +static int __init bpf_huge_memory_init(void)
> +{
> +	int err;
> +
> +	err = register_bpf_struct_ops(&bso_bpf_mthp_ops, bpf_mthp_ops);
> +	if (err)
> +		pr_warn("Registration of bpf_mthp_ops failed, err %d\n", err);
> +
> +	return err;
> +}
> +late_initcall(bpf_huge_memory_init);
> --
> 2.53.0
>
