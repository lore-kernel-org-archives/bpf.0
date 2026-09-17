Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88694A43F2;
	Thu, 17 Sep 2026 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680853; cv=none; b=lMbFxHNxDGGpccKwOE6QENkAzZaSgMzjgD98tNwz4PBKMOfSOIH1jFpsRvhfpkSGh+G2VMsfdv6MZEJg/vOt/XFKxtQJP7pHQlyv2oz3DIPTGY7ktDlTFp2WhiZZscIsLa9cA7SH/81fUChznSNnjjamJ+YvjKouVmHIv4YjyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680853; c=relaxed/simple;
	bh=UGuAkVA3F4FOuZ1shjEm2GZG58LYdQZOkZimWU83QlM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NhvkBQpoRLjcapmA+GrEb8t/SmH1cWfsdrhuMuBq03txjjhLdvEut+N1acQMTcr59SvOiv6CtZZnkMgc1+mW2gqgFs+NIuxN/JucJ+Y0a+zkF1IKB72cuHXBRZTasRrYX4WR2OMFV9Q3mNdZUOJqOvJfEJ/MRCJSkABeVApXHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE5eQA6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE5eQA6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D465A1F00899;
	Thu, 17 Sep 2026 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680851;
	bh=wUCHnAC0DwF+yZjTvhifA9t8zbtxaBEWBWC1SreH0cE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OE5eQA6iosTjPI1Uouf8IGa6nEiG4IyOeHIVFtnHNJaFihN7iSRGSfWwcts+6fmPh
	 gzpi/dCcvrd/OygMARlnFfCsm1kZnwTYDOySlNZJle2k3u8RH5GQC27uaFDAwA3WOP
	 1o03ix00zLBMOAQLn0vAHIRW2ZJXja1PchZ4hzKsKZlMejYMzEGiHe+S+f+IMV1ZCf
	 w6zmhFfzOKW6xzcFUedfBaPtr8MsW7eq819chc3ITRpyVKVT0ZS8gEuR89DFgks4Ox
	 jpxpxjimPoTqm0VoSiV+49yuLdh6BRD8igOYI2ceIbx0/5gMfG+2Gt0AVI8QHe5AEU
	 eaE/QxkxCEkzQ==
Content-Type: multipart/mixed; boundary="===============8566282359264878778=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <789d39259c3d046150ef3b37854c76da019be57b738ad2d93c3c084d00799ab1@mail.kernel.org>
In-Reply-To: <20260917200542.3689605-10-ameryhung@gmail.com>
References: <20260917200542.3689605-10-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/15] bpf: Add infrastructure to support attaching struct_ops to cgroups
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,kuniyu@google.com,kerneljasonxing@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:10 +0000 (UTC)

--===============8566282359264878778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6ae70ef8e23d1..e27bcc86fc988 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -20,6 +20,7 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf_local_storage.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/bpf-cgroup.h>
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/seq_file.h>

[ ... ]

> @@ -10024,6 +10028,31 @@ static int btf_add_struct_ops(struct btf *btf, int btf_id,
>
>  	cgroup_atype = st_ops->cgroup_atype;
>  	if (cgroup_bpf_is_struct_ops_atype(cgroup_atype)) {
> +		/*
> +		 * Cgroup struct_ops callers hold the RCU read lock around the
> +		 * entire trampoline call, including its trailing instructions.
> +		 * A regular RCU grace period therefore protects both the kdata
> +		 * and the trampoline image, so a tasks RCU grace period is not
> +		 * needed.
> +		 */

This isn't a bug, but the comment reads as though it applies to the
entire guard below, when it only explains why free_after_tasks_rcu_gp is
rejected. It says nothing about why an unrecognized cgroup_atype or a
struct_ops supplying ->reg/->unreg is also rejected, which are the
clauses a reader is most likely to encounter first.

Would it make sense to either move the comment down to sit directly above
the free_after_tasks_rcu_gp clause, or extend it to cover why
reg/unreg/cgroup_atype are constrained for cgroup-attached struct_ops?

> +		if (!cgroup_bpf_is_struct_ops_atype(cgroup_atype) ||
> +		    st_ops->reg || st_ops->unreg || st_ops->free_after_tasks_rcu_gp) {
> +			pr_warn("struct_ops %s: cgroup_atype invalid or has reg/unreg/free_after_tasks_rcu_gp\n",
> +				st_ops->name);
> +			err = -EINVAL;
> +			goto errout_release;
> +		}

[ ... ]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 213570500b681..c0a4301e804dc 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -24,6 +24,33 @@
>  DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
>  EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>
> +struct cgroup_struct_ops {
> +	u32 type_id;
> +	void *cfi_stubs;
> +	bool mult_rcu;
> +};
> +
> +static struct cgroup_struct_ops cgroup_struct_ops[MAX_CGROUP_BPF_ATTACH_TYPE];
> +
> +void cgroup_bpf_struct_ops_register(int atype, u32 type_id, void *cfi_stubs, bool mult_rcu)
> +{
> +	cgroup_struct_ops[atype].type_id = type_id;
> +	cgroup_struct_ops[atype].cfi_stubs = cfi_stubs;
> +	cgroup_struct_ops[atype].mult_rcu = mult_rcu;
> +}
> +
> +static enum cgroup_bpf_attach_type
> +find_atype_by_struct_ops_id(u32 type_id)
> +{
> +	enum cgroup_bpf_attach_type atype;
> +
> +	for (atype = 0; atype < MAX_CGROUP_BPF_ATTACH_TYPE; atype++) {
> +		if (cgroup_bpf_is_struct_ops_atype(atype) &&
> +		    cgroup_struct_ops[atype].type_id == type_id)
> +			return atype;
> +	}
> +	return CGROUP_BPF_ATTACH_TYPE_INVALID;
> +}

Can find_atype_by_struct_ops_id() distinguish between 'not registered' and
'type_id is 0'?

cgroup_struct_ops[] is static and zero-initialized, so until
cgroup_bpf_struct_ops_register() runs for a given atype,
cgroup_struct_ops[atype].type_id stays 0. The predicate
'cgroup_bpf_is_struct_ops_atype(atype)' does not check registration state
- it only tests whether atype is recognized (e.g., CGROUP_TCP_SOCK_OPS).

So a user-supplied type_id of 0 would match an unregistered slot.

This is fully reachable via bpf(BPF_PROG_QUERY, {attach_type=BPF_STRUCT_OPS,
type_id=0}) with CAP_BPF/CAP_NET_ADMIN. In __cgroup_bpf_query():

  if (type == BPF_STRUCT_OPS) {
      u32 type_id = attr->query.type_id;

      atype = find_atype_by_struct_ops_id(type_id);
      if (atype == CGROUP_BPF_ATTACH_TYPE_INVALID)
          return -ENOENT;

Nothing validates attr->query.type_id == 0, so the query would return
success with empty results instead of -ENOENT.

Impact is confined to the returned errno - no out-of-bounds access since
cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) is false in that state and
__cgroup_bpf_query() jumps to skip_count without walking any arrays.

Would it make sense to either require a non-zero type_id explicitly in
find_atype_by_struct_ops_id(), or record a separate 'registered' flag, so
the sentinel stays distinguishable from a valid key?

[ ... ]

> @@ -1363,7 +1440,17 @@ int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>  	int ret, from_atype, to_atype;
>  	u32 flags;
>
> +	if (type == BPF_STRUCT_OPS) {
> +		u32 type_id = attr->query.type_id;
> +
> +		atype = find_atype_by_struct_ops_id(type_id);
> +		if (atype == CGROUP_BPF_ATTACH_TYPE_INVALID)
> +			return -ENOENT;
> +		flags = 0;
> +		if (!cgroup_bpf_enabled(atype))
> +			goto skip_count;

A subsystem pattern flags this as potentially concerning:

cgroup_bpf_enabled(atype) expands to
static_branch_unlikely(&cgroup_bpf_enabled_key[atype]), which with
CONFIG_JUMP_LABEL=y reaches arch_static_branch() that requires a
compile-time-constant key address via an asm "i" constraint.

This is the first call site where atype is a runtime variable. Every
pre-existing user (BPF_CGROUP_RUN_SK_PROG, BPF_CGROUP_RUN_SA_PROG, and
the sites in net/ipv4/tcp.c, net/ipv4/udp.c, net/ipv6/udp.c) passes a
constant enumerator, and those compile cleanly.

Here the compiler can constant-fold atype only because
find_atype_by_struct_ops_id() is static with one call site (so it
inlines), its only non-INVALID return is guarded by
cgroup_bpf_is_struct_ops_atype(atype) (i.e., atype == CGROUP_TCP_SOCK_OPS),
which lets VRP prove atype == CGROUP_TCP_SOCK_OPS after the early return.

Once a second cgroup struct_ops atype is added, the fold becomes impossible
and this line would fail at build time with "impossible constraint in 'asm'".

Would it be worth using a plain static_key_enabled() or an array-safe
variant here, so the code does not depend on an optimizer transform that
breaks when the recognized atype set grows?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35271288839
--===============8566282359264878778==--
