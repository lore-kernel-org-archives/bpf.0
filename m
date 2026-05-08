Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0802DF134
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277683; cv=none; b=VpX3mOjuC4ZYKBONTOdZQqGEmy9Jlxsqy3kTBO+NKEUy9M+AXxPSmbINrILy4msvlNcsqS9MOMBPAgQOLker8kRqjiZyP8lpaJbZrWiUIVayKkRzkqQUZFwk5hWzk6oKdbWnI2osl5xiUZXLavAryA0T1ROQ40fCF4hGITgHkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277683; c=relaxed/simple;
	bh=e5CRUY0wh/i6Gmrd2dC+CBzrH+Hnh7Is56pGflB9bsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bon6y86HO+ZdKgItyqPy73Zio8JHNI4JQvHipAT7oySPn4J+4Qqgv1igGOAJOGoF6SPpJWrCvrHQIPdzq78fqqvx86JphW1HZfeGX35kVRq5OEYxtVPnHgNyrULdRsVBLi71UJMvNFEXMeovUuu+guMfQRLiqyOTAzlYxTt1/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMbupR+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMbupR+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEAEC2BCB0;
	Fri,  8 May 2026 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277682;
	bh=e5CRUY0wh/i6Gmrd2dC+CBzrH+Hnh7Is56pGflB9bsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iMbupR+/Thn7g5AOoPnn51Cy6FjEd+f2IOro1EBInQHsnqa8a6HBr9wUgro316MPc
	 tzjsmFBAM+qxPj30+j4nmql76SuJlSipbeAr1ACR1PDtaDm81lwOZCG+EF0PXzW5Z8
	 VuB1JbCIxlR9zPog6bvwTrFBh0Vm/40ZjJlG0MXL9trQZ/DR5zgRznW7svydMBMnBX
	 nV+tebTEQV4gvy46Tcui13gldjO7PvpNkroQaq2/ZOQpDxSyatS040XfpMw+y8sZko
	 yBXVp9/WSEyBrNUz7c7ElMQ14Wsrul9t3JP5eXECRNdz7mpIG9uhVeaJ1ymxZlzdcf
	 f/+WSaO4lrynQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
Reply-To: sashiko@lists.linux.dev
To: "Vernon Yang" <vernon2gm@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508150055.680136-3-vernon2gm@gmail.com>
References: <20260508150055.680136-3-vernon2gm@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 22:01:22 +0000
Message-Id: <20260508220122.8EEAEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `bpf_cgroup_stall` kfunc reads the 64-bit statistic `group->=
total` locklessly, exposing a torn read vulnerability on 32-bit architectur=
es.
- [Low] The patch introduces a build failure when `CONFIG_CGROUPS` is enabl=
ed but `CONFIG_PSI` is disabled.
--

commit 6a28dc9991d77ff5f1bc78ed809531c8806dd33a
Author: Vernon Yang <yanglincheng@kylinos.cn>

bpf: add bpf_cgroup_{flush_stats,stall} function
   =20
Add bpf_cgroup_{flush_stats,stall} function to prepare for the
subsequent mthp_ext ebpf program.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c2665..1c353e0ff14f4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2881,6 +2882,37 @@ bpf_task_get_cgroup1(struct task_struct *task, int=
 hierarchy_id)
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
> +__bpf_kfunc u64 bpf_cgroup_stall(struct cgroup *cgrp, enum psi_states st=
ates)
> +{
> +	struct psi_group *group =3D cgroup_psi(cgrp);
> +
> +	if (unlikely(!group || (u32)states >=3D NR_PSI_STATES - 1))
> +		return (u64)-1;
> +
> +	return div_u64(group->total[PSI_AVGS][states], NSEC_PER_MSEC);

Will this cause a torn read on 32-bit architectures?

The 64-bit cumulative counter group->total[PSI_AVGS][states] is updated usi=
ng
standard non-atomic addition in collect_percpu_times(), which runs in proce=
ss
context under group->avgs_lock.

Since bpf_cgroup_stall() reads this value directly without holding the lock,
and non-sleepable BPF programs can execute in NMI or hardirq contexts, they
can preempt the update process.

On 32-bit architectures, a 64-bit update and read are split into two 32-bit
operations. If the BPF program preempts the CPU between the lower and upper
half updates, it could read a torn 64-bit value, leading to an incorrect,
artificial spike or drop in the reported stall time.

> +}
> +
> +/**
> + * bpf_cgroup_flush_stats - Flush cgroup's statistics
> + * @cgrp: cgroup struct
> + */
> +__bpf_kfunc void bpf_cgroup_flush_stats(struct cgroup *cgrp)
> +{
> +	struct psi_group *group =3D cgroup_psi(cgrp);
> +
> +	if (unlikely(!group))
> +		return;
> +
> +	psi_group_flush_stats(group);

Can this lead to a build failure when CONFIG_CGROUPS is enabled but CONFIG_=
PSI
is disabled?

Both bpf_cgroup_stall() and bpf_cgroup_flush_stats() are guarded by
#ifdef CONFIG_CGROUPS, but heavily depend on PSI-specific constructs like
enum psi_states, NR_PSI_STATES, PSI_AVGS, group->total, and
psi_group_flush_stats().

When CONFIG_PSI is disabled, include/linux/psi_types.h defines
struct psi_group as an empty struct and omits definitions for the enums and
macros, and psi_group_flush_stats() is undeclared.

> +}
>  #endif /* CONFIG_CGROUPS */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508150055.6801=
36-1-vernon2gm@gmail.com?part=3D2
