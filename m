Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7836E460;
	Fri,  8 May 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254810; cv=none; b=RMX4NtUVdOO98AanaVbKFPaJ9Gf4gHHkLHtnAhC41XY3aK9oSnHuaUnuyo1r+WMa/JDGWNylUxnx+nC43VDkQvcffklI9iJuD+UGD06DnHjyf6VcBz1saZMW+yTTM3UW0lMNCOf/exX/hLxpG4WGHASiiT5oD0pPuRgJ3LPTA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254810; c=relaxed/simple;
	bh=E8G9MYegRpzWpWVKYNRRCGAxqMbVWlinVx/Om5EhD2c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cC3W+imIeRIYCVmjHJX7D99sw+jwC2mSon5CmLZRTu0F4IGSq0K8hLmbxisk5WrQ6nhVPE4CThx+960D5bJdrTo+13fW+6VSgFVB/6bAW2LNCrPhm/3Fu6KoAKicXCMd9HEYl/adxbuXCa5dIcz4yIRQjeq2bmYrsqtQnQfoAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBx3ej7f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBx3ej7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC2DC2BCB0;
	Fri,  8 May 2026 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778254810;
	bh=E8G9MYegRpzWpWVKYNRRCGAxqMbVWlinVx/Om5EhD2c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EBx3ej7f2CmGFrRVSf/PpZzoO7LFjhpaWV9umAj6rdU1EIONp6mc9AFLNQxSgzNia
	 Rnnb4HUSXO/aHv9MAUdA3Ad1L4OkRqid86QDxfRg5eqNI33FaHuOGv4+zCyb8WloRs
	 3CRWPybgZFfXIgiLtA1WTCZbp4Vm8vGjTGx3bz8ZCfYRSlewzLfu6AFjb7cmH+39tD
	 X56Us7/86EEZNnj0JG7woqgycponkkkul8HGZGfqv0iECDj/51/15D/F1KbtkQbtlp
	 sF6+7fRlRVlCnIPBK+HdA/bpJnydd+bDxVPtgPR9G6oWy5OWlCWGZICmCGFaoRMpwQ
	 MZdSV39sBPtyg==
Content-Type: multipart/mixed; boundary="===============1780306519113491024=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c096deaccb513762aa50dbb59ccb0d18e6fb14a772fe37c428fb49fc550d9b1e@mail.kernel.org>
In-Reply-To: <20260508150055.680136-3-vernon2gm@gmail.com>
References: <20260508150055.680136-3-vernon2gm@gmail.com>
Subject: Re: [PATCH v2 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
From: bot+bpf-ci@kernel.org
To: vernon2gm@gmail.com,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,ast@kernel.org,daniel@iogearbox.net,surenb@google.com
Cc: tz2294@columbia.edu,baohua@kernel.org,lance.yang@linux.dev,dev.jain@arm.com,laoar.shao@gmail.com,gutierrez.asier@huawei-partners.com,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,yanglincheng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  8 May 2026 15:40:09 +0000 (UTC)

--===============1780306519113491024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index 7b4fd8190810..243dcf97bea4 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -52,6 +52,10 @@ static inline void psi_memstall_enter(unsigned long *flags) {}
>  static inline void psi_memstall_leave(unsigned long *flags) {}
>
>  #ifdef CONFIG_CGROUPS
> +static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
> +{
> +	return NULL;
> +}
>  static inline int psi_cgroup_alloc(struct cgroup *cgrp)
>  {
>  	return 0;

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index baa12b24bb64..5562a6c9d2f9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -29,6 +29,7 @@
>  #include <linux/task_work.h>
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
> +#include <linux/psi.h>
>
>  #include "../../lib/kstrtox.h"
>

[ ... ]

> @@ -2881,6 +2882,37 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
>  		return NULL;
>  	return cgrp;
>  }
> +
> +/**
> + * bpf_cgroup_stall - acquire the total stall time of cgroup
> + * @cgrp: cgroup struct
> + * @states: psi states
> + *
> + * Return the total stall time.
> + */
> +__bpf_kfunc u64 bpf_cgroup_stall(struct cgroup *cgrp, enum psi_states states)
> +{
> +	struct psi_group *group = cgroup_psi(cgrp);
> +
> +	if (unlikely(!group || (u32)states >= NR_PSI_STATES - 1))
> +		return (u64)-1;
> +
> +	return div_u64(group->total[PSI_AVGS][states], NSEC_PER_MSEC);
> +}
> +
> +/**
> + * bpf_cgroup_flush_stats - Flush cgroup's statistics
> + * @cgrp: cgroup struct
> + */
> +__bpf_kfunc void bpf_cgroup_flush_stats(struct cgroup *cgrp)
> +{
> +	struct psi_group *group = cgroup_psi(cgrp);
> +
> +	if (unlikely(!group))
> +		return;
> +
> +	psi_group_flush_stats(group);
> +}
>  #endif /* CONFIG_CGROUPS */

Will these functions build when CONFIG_BPF_SYSCALL=y, CONFIG_CGROUPS=y,
but CONFIG_PSI=n?

The functions reference several PSI-only symbols:

In bpf_cgroup_stall():
- enum psi_states (parameter type) only exists in include/linux/psi_types.h
  when CONFIG_PSI=y
- NR_PSI_STATES and PSI_AVGS are enum members only defined when CONFIG_PSI=y
- struct psi_group's total field doesn't exist when CONFIG_PSI=n (psi_types.h
  defines an empty struct in that case)

In bpf_cgroup_flush_stats():
- psi_group_flush_stats() is only declared in include/linux/psi.h when
  CONFIG_PSI=y with no stub for the !CONFIG_PSI case

kernel/bpf/helpers.o is compiled whenever CONFIG_BPF_SYSCALL=y. Since PSI
is an independent config option, the combination CONFIG_BPF_SYSCALL=y &&
CONFIG_CGROUPS=y && CONFIG_PSI=n is valid and would hit undefined symbols.

The cgroup_psi() stub added in include/linux/psi.h only handles the
!CONFIG_PSI case for cgroup_psi() itself, but doesn't solve the unresolved
PSI types and functions. Should these kfuncs be guarded with CONFIG_PSI,
similar to how kernel/cgroup/cgroup.c handles cgroup_pressure_show()?

>
>  /**
> @@ -4734,6 +4766,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_cgroup_stall)
> +BTF_ID_FLAGS(func, bpf_cgroup_flush_stats, KF_SLEEPABLE)
>  #endif

These BTF_ID_FLAGS entries would also need CONFIG_PSI guards if the function
definitions are moved inside CONFIG_PSI.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25563319416
--===============1780306519113491024==--
