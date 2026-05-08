Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73605312803
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279358; cv=none; b=T3lT+/g9Lcmhjfq5RGIbrj+1PiG5COIRDdUKLSI3Boqwp6CCRhAnoXIEgem+pb/EoCKT9sn5x2JBtzve0bxOdQSprJAfQ3SdxTcaomB9WXb1H1yOzopdy8dOs33dWgFPM840rjVMCMmFXpKoTHJYXdMSSJSjLHMGUwkCuoz8AG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279358; c=relaxed/simple;
	bh=IqyzBckRjZwcfuxcre1W57XdcUOch383OYAhd1hcQ8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qRR9Debo3Td3s7+BfTkPMslWhPbfimM5xuT7/P6/fh1cHFiptrdlZfXiT+vMWejrYyw8sN9tz2ft7YraI7KuEfsPuDx8F7keBAakWDkvomXWOF3PTfcBr34prvZchHhSTCTFtWf6Xp4v0/R/Olx1CN2xDMVAw6LmD16jR81opSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPYa+V8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPYa+V8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C2BC2BCB0;
	Fri,  8 May 2026 22:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778279358;
	bh=IqyzBckRjZwcfuxcre1W57XdcUOch383OYAhd1hcQ8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DPYa+V8Gjz57MF5IVQ+gRwpYzpQYJQn34SA/xwXYeKIr0hSFsTlFxpo+xtl/+2MHE
	 Ak1obKHHMCsjMBv0OUT/1fCiD2YSVfOnJg9mCFlOb6sF16Ja2V2UiXR6SyFbfqOmEV
	 PpVWsVnG9slPYmN9N+ecQR+wXpAbvReCWW/zkwjgXTOHiH7n7vrLCzf1a7bXKZofWx
	 ZzuEscN+LiFuz6H6dEGH1au9lmjRNQz7VZQfe4HTk2TMf1SLkxaw92pdOW3aDA/WXA
	 GxsuHHuGRGxVAAQ6UGRFPlpt+lX9jXRGFM4wknhduxm9wgUuuwocpPI/v77ntzb5LF
	 c57HcGm+Uwx6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] mm: introduce bpf_mthp_ops struct ops
Reply-To: sashiko@lists.linux.dev
To: "Vernon Yang" <vernon2gm@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508150055.680136-4-vernon2gm@gmail.com>
References: <20260508150055.680136-4-vernon2gm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 22:29:17 +0000
Message-Id: <20260508222918.40C2BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] BPF architectural layering violation resulting in a Use-After-=
Free risk.
- [High] Broken cgroup inheritance prevents overriding parent policies.
- [High] Unconditional atomic operations and SRCU locking on the page fault=
 hot path.
- [Low] Build failures due to incomplete types and missing header includes.
--

commit 5151cfb43b99be8eef5398ab31786c76a122dc79
Author: Vernon Yang <yanglincheng@kylinos.cn>

mm: introduce bpf_mthp_ops struct ops
   =20
This commit introduces a new BPF struct_ops called bpf_mthp_ops to allow eB=
PF
programs to customize the sizes of multi-size THP (mTHP) for different
cgroups. It adds bpf_mthp_choose() to the page fault path to retrieve the
BPF-specified orders.

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1f084ee71443e..7db83ca81e6e7 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5836,6 +5836,8 @@ static struct cgroup *cgroup_create(struct cgroup *=
parent, const char *name,
>  	if (ret)
>  		goto out_stat_exit;
> =20
> +	cgroup_bpf_set_mthp_ops(cgrp, parent);

Does this file need to include <linux/bpf_huge_memory.h> for this function
call? This might cause a build failure due to a missing declaration.

> +
>  	for (tcgrp =3D cgrp; tcgrp; tcgrp =3D cgroup_parent(tcgrp))
>  		cgrp->ancestors[tcgrp->level] =3D tcgrp;

[ ... ]

> diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
> new file mode 100644
> index 0000000000000..851c6ebe29334
> --- /dev/null
> +++ b/mm/bpf_huge_memory.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
[ ... ]
> +#include <linux/bpf.h>
> +#include <linux/srcu.h>

Does this file also need to include <linux/memcontrol.h> and <linux/cgroup.=
h>?
Functions like get_mem_cgroup_from_mm() and css_for_each_descendant_pre() a=
re
used below, which might lead to build failures.

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
> +	memcg =3D get_mem_cgroup_from_mm(mm);

Since thp_vma_allowable_orders() calls this function unconditionally on eve=
ry
THP allocation, does executing get_mem_cgroup_from_mm() and modifying atomic
reference counts on the page fault hot path introduce significant overhead?

Could a static key be used to bypass these atomic operations and the SRCU
locking below when the BPF feature is inactive?

> +	if (!memcg)
> +		return orders;
> +
> +	cgrp =3D memcg->css.cgroup;
> +
> +	idx =3D srcu_read_lock(&mthp_bpf_srcu);
> +	ops =3D READ_ONCE(cgrp->mthp_ops);
> +	if (unlikely(ops && ops->mthp_choose))
> +		orders =3D ops->mthp_choose(cgrp, orders);
> +	srcu_read_unlock(&mthp_bpf_srcu, idx);
> +
> +	mem_cgroup_put(memcg);
> +
> +	return orders;
> +}

[ ... ]

> +static int bpf_mthp_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link =3D (struct bpf_struct_ops_link *)l=
ink;
> +	struct bpf_mthp_ops *ops =3D kdata;
> +	struct cgroup_subsys_state *child;
> +	struct cgroup *cgrp;
> +
> +	if (!link)
> +		return -EOPNOTSUPP;
> +
> +	cgrp =3D st_link->cgroup;

Can this code successfully compile? struct bpf_struct_ops_link appears to b=
e an
incomplete type defined privately in kernel/bpf/bpf_struct_ops.c, and it la=
cks
a cgroup field.

Additionally, does bpf_mthp_ops_reg() need to acquire a reference count on =
the
target cgroup using cgroup_get()? If the cgroup is deleted while the link
remains active, could st_link->cgroup become a dangling pointer and lead to=
 a
use-after-free when bpf_mthp_ops_unreg() is later called?

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

Since cgroup_create() copies parent->mthp_ops directly to the child cgroup,
wouldn't all descendants inherently have mthp_ops set if their parent does?
Does this block users from registering an overriding BPF program on the chi=
ld
cgroup, or block the parent if a child registers first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508150055.6801=
36-1-vernon2gm@gmail.com?part=3D3
