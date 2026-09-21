Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36093AF640
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019710; cv=none; b=jiiKQ+sUyAR0ndT/L3vTax9icyqyQg9mg61bkeyROYlI4BlA67cYQfmX/rGub4wqpoKD3m31xkDElh5TbihGs6TjliP4GYEoqp3GTtJkY/+nmeeH1bE0U6ANeHywIbfkyO1IbcK526qsOSGxy7OomA1p/FeZz0VRTv8U3tXCeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019710; c=relaxed/simple;
	bh=/FucrnI4JJ3mwGOGTp0aH0/mqHo33ZtYF/4CX9YnWsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L4xoZKFldSWdr42nZ6IbRk2r8lSagXT3N3lLkmBr4FXBNiyOXlQz4VdpkAhl5sqC4B3YKjEFmhNLRbct3CUz9ZqlRj235C0gikuoc8A6Ff6baYojc31clQEpfTnCNhLlN7/cp35OiqNw3L82NmXQ/t/T0RtoSFMcyCP92EB5EBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE57EiwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE57EiwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775051F000FF;
	Mon, 21 Sep 2026 19:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790019706;
	bh=aMTT4ULNBpRjFLcvdo0vIREJGYHytKoJCpqFiekaSRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FE57EiwI0AokT4Q/oC/Uzn2YYsOx5uVqt8cfsEFOCNd2Ddipxhq2Oz87wgqt8MDjn
	 GU+JBvFZz0UDvnM+0fuzzMFqsNJbDUKTlWcSvdIzakoo6rCD8sLE+YXlYytHEvqy7t
	 Sdz9iWh99WFkB6iHjN5RRjaG/t/FrprgwPDN4aKqNwpxgUWwuX9iM/O0EvCrA7ayPR
	 v2PXTC/ry3710gvJKQek8QqaEtZyu+NnkVyhoULvDftdKAtyOLmV+nNritRBqaJIq1
	 AbrMS1H4u4jNIHyToabhmO/K8IwdUy/uU3Cz3Mt60OuCXU7MRsw0bu8ZAlNwX36cGX
	 VTCNo4Yw+Fhyw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] memcg_ext: add cgroup-attached bpf_memcg_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shakeel Butt" <shakeel.butt@linux.dev>
Cc: mkoutny@suse.com, bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org
In-Reply-To: <20260921192559.2619635-3-shakeel.butt@linux.dev>
References: <20260921192559.2619635-1-shakeel.butt@linux.dev>
 <20260921192559.2619635-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:41:46 +0000
Message-Id: <20260921194146.775051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: spurious boot warning when CONFIG_CGROUP_BPF is disabled
- [Low] bpf: missing newline in pr_warn for bpf_memcg_ops registration
--

commit f28f15056753b0bfc8cefa4ccf7793b6fb45150d
Author: Shakeel Butt <shakeel.butt@linux.dev>
Subject: memcg_ext: add cgroup-attached bpf_memcg_ops

This patch adds an empty bpf_memcg_ops type for attaching memory policies
to cgroups. It also moves the cgroup BPF attach types outside
CONFIG_CGROUP_BPF and updates the struct_ops registration stub.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index d8f579c285600..fd6dff150f017 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
[ ... ]
> @@ -248,8 +348,14 @@ static int __init bpf_memcontrol_init(void)
> =20
>  	err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
>  					&bpf_memcontrol_reclaim_kfunc_set);
> -	if (err)
> +	if (err) {
>  		pr_warn("error registering bpf reclaim kfuncs: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D bpf_memcg_ops_register();
> +	if (err)
> +		pr_warn("error while registering bpf_memcg_ops: %d", err);

[Severity: Medium]
Will this print a spurious warning on every boot when CONFIG_CGROUP_BPF is
disabled?

If a kernel is built with CONFIG_MEMCG=3Dy, CONFIG_BPF_SYSCALL=3Dy, and
CONFIG_BPF_JIT=3Dy, but CONFIG_CGROUP_BPF=3Dn, bpf_memcontrol_init() calls
bpf_memcg_ops_register().

This eventually calls register_bpf_struct_ops(), which relies on
cgroup_bpf_is_struct_ops_atype() in btf_add_struct_ops(). Since the
!CONFIG_CGROUP_BPF stub for cgroup_bpf_is_struct_ops_atype() unconditionally
returns false, this returns -EINVAL.

Does this mean the late initcall will return an error and unconditionally
pollute the kernel log with this warning on supported configurations?

[Severity: Low]
Does this pr_warn() need a terminating '\n'?

Without it, subsequent printk messages might be incorrectly appended to the
same line in the kernel log.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921192559.2619=
635-1-shakeel.butt@linux.dev?part=3D2
