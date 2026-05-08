Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D93FE347;
	Fri,  8 May 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254814; cv=none; b=Gb49zrNGzoTnwO4L8wp2G3Ct1488u4sXH58hD8Gtwd1+AYp1x6gMCaxmzwhc8xqxD/SRQs1/lfx13IbiSHR/SYFF/BdYR/9bw5MeEWW83yR8Ce5YsXacuCNbqw+OwNzwBa65TKTBBQB4blE28ztL2+BIp1xO1gK9SUaNB6Qy7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254814; c=relaxed/simple;
	bh=5eIp3bwp4cQp8tg23m4rYRdOZqX+WIiuLyvtwPi+PH0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RDFdvQOgta2wb4sfAkwLICkwRPrvpjlIS78I2DLKVslrreKX0OWUluD8wzbJNDUBQfUywWk4Gzf29464q5DLcm9EZdhMCWRP1kn2Yo5UKm73jR15wi3FulYMq+zSQH83Z/lggRt+HKvJjpjVuQKRIbEUTL9V0dNS8JDD6xRqKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3/gBa0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3/gBa0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A15C2BCB0;
	Fri,  8 May 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778254813;
	bh=5eIp3bwp4cQp8tg23m4rYRdOZqX+WIiuLyvtwPi+PH0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=g3/gBa0cf9OwjQWFJ9vGe/TZWi/Xv4i+zd0jitU/4ginCWmWARUgMgccQRP1SCzCA
	 Vr32iTk0ixcL0tI+mygVv9hZuSJq/WYAQLW0s8zS4JUwzqPD5EdR/2F6YgbPmHzieq
	 Ac/gO3rLy7NXECVdQ8EMLY88VVLS2dLs6YZdSu7mfQu7wlL+uvZaglBLvLgNsB16rt
	 LqaIX8UuafPjEj1qKQ95twBOPWaKycexMADMh3v0f0eSANMxfdoSQkvcuhT/aAktZa
	 Gp4K4g+JQ5ac7//GdSQP+WjW4467vADUIupjUHGod2gdNG0lGdcXAzQyH91Y5TTnCz
	 wTGcG3mtwW4WQ==
Content-Type: multipart/mixed; boundary="===============2613262717962070956=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <669cdfc48ce0e37c6985d33d7f649e93eb599611a0cbe51b79defa52949580a5@mail.kernel.org>
In-Reply-To: <20260508150055.680136-4-vernon2gm@gmail.com>
References: <20260508150055.680136-4-vernon2gm@gmail.com>
Subject: Re: [PATCH v2 3/4] mm: introduce bpf_mthp_ops struct ops
From: bot+bpf-ci@kernel.org
To: vernon2gm@gmail.com,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,ast@kernel.org,daniel@iogearbox.net,surenb@google.com
Cc: tz2294@columbia.edu,baohua@kernel.org,lance.yang@linux.dev,dev.jain@arm.com,laoar.shao@gmail.com,gutierrez.asier@huawei-partners.com,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,yanglincheng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  8 May 2026 15:40:12 +0000 (UTC)

--===============2613262717962070956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13f49378b157..cad3a87d9873 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS

[ ... ]

> diff --git a/include/linux/bpf_huge_memory.h b/include/linux/bpf_huge_memory.h
> new file mode 100644
> index 000000000000..ffda445c9572
> --- /dev/null
> +++ b/include/linux/bpf_huge_memory.h

[ ... ]

> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index f42563739d2e..78854d0e06ab 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h

[ ... ]

> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2949e5acff35..80ec622213df 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h

[ ... ]

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1f084ee71443..7db83ca81e6e 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c

[ ... ]

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0a43bb80df4f..f3309376bcc5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -962,6 +962,20 @@ config NO_PAGE_MAPCOUNT
>
>  	  EXPERIMENTAL because the impact of some changes is still unclear.
>
> +config BPF_TRANSPARENT_HUGEPAGE
> +	bool "BPF-based transparent hugepage (EXPERIMENTAL)"
> +	depends on TRANSPARENT_HUGEPAGE && CGROUP_BPF
> +	help
> +	  Using cgroup-bpf to customize mTHP size for different scenarios,
> +	  automatically select different mTHP sizes for different cgroups,
> +	  let's focus on making them truly transparent.
> +
> +	  This is an experimental feature, that might go away at any time,
> +	  Please do not rely any production environment.
                                  ^^^

This isn't a bug, but there's a grammar issue in the Kconfig help text.
The sentence is missing a preposition and pronoun. It should probably be
"Please do not rely on this in any production environment."

> +
> +	  EXPERIMENTAL because the BPF interface is unstable and may be removed
> +	  at any time.
> +

[ ... ]

> diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
> new file mode 100644
> index 000000000000..851c6ebe2933
> --- /dev/null
> +++ b/mm/bpf_huge_memory.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Huge memory related BPF code
> + *
> + * Author: Vernon Yang <yanglincheng@kylinos.cn>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/srcu.h>

[ ... ]

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
            ^^^^^^^^^^^^^^^^^^^^

Does struct bpf_struct_ops_link have a cgroup field? Looking at
kernel/bpf/bpf_struct_ops.c, the structure is defined as:

    struct bpf_struct_ops_link {
        struct bpf_link link;
        struct bpf_map __rcu *map;
        wait_queue_head_t wait_hup;
    };

There is no cgroup member. The same issue occurs in bpf_mthp_ops_unreg()
where st_link->cgroup is accessed. This would cause a compilation error
when CONFIG_BPF_TRANSPARENT_HUGEPAGE is enabled.

Were you intending to extend struct bpf_struct_ops_link to support
cgroup-scoped struct_ops, or is there a different mechanism planned for
associating the link with a specific cgroup?

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
            ^^^^^^^^^^^^^^^^^^^^

Same issue here - the cgroup field doesn't exist in the struct.

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

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25563319416
--===============2613262717962070956==--
