Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818853D4118
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165612; cv=none; b=RCZWVTtUedzQ+XviS0BJLP2woYOMhn3d0FX02rzYb85epebAcebCm6YwZJ4W2IOcB3LpqP2+dBcUYpDMTHwCVQeZLm/ZGNHJgW7kM1HSsupNXzzPGCoEGhzt9ESHIKtAr99NvJyOHhDVOvQiZe/JA8LZHuzfqSMPs5VZlQ7F1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165612; c=relaxed/simple;
	bh=DStV3sp1pc5hcMm6xx0gQE71u2SYCMU0UmLH2xVLeAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O2cuFS7twbVYaom6uYihpESaBEOYc/j7hIJ24xJkT324EkaEO5TlnQeAXEikZz9MaYZ3yLMpyj76pDPWD+vHab+4hsqcX1P/92/xsbf5xFHBj2cJmlAG+cM0rmVK1xNGH+dKX6+nhptw23yK/N6dNEY530M/8CqdFV+uBZOzz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9f1DdL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9f1DdL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A931F00893;
	Fri, 11 Sep 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165602;
	bh=mkPPHYK9YzPqKUf38l8o9B8t+QvKvDjha6pIHWNmk4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O9f1DdL3UklUaX5saDi4LZMTB7rmCjJ6lhVR5/sGG1M6xDo+vhBN7z0Wx7Prac0qx
	 y0sdqYv0cDY1elM4nSu2HNUZEyz2RJ75tIn92YQo+EQG0WHsYFzUjk1CS1S146VFIJ
	 rJt95Fp8GuulE+bxyixmOdXlp0se3cvFtvkhzfy3aVUu4jhFRIxMqgyx/oz+Ey5fzq
	 QsF1R/1TE0vs/BPJ7uFSGd0BmYAZviVtpGfM94FgoCVQTYV1UjZH1ZboqLfmr/zUxO
	 NwmsdlznLUKiI7ki4srb7CUR6o0sxhBGeXsSYIJAchI0CJQsDKEIdqis1GR3ukA5uQ
	 2zbHFdvgftCrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 06/23] bpf: Unify kfunc argument kinds with
 enum bpf_arg_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911220415.1396439-7-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
 <20260911220415.1396439-7-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:26:42 +0000
Message-Id: <20260911222642.72A931F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing negative bounds check for enum parameter used as array ind=
ex in kfuncs allows out-of-bounds kernel memory read.
--

commit 187c3e4699e70b4609c73e9f7618935e9265b164
Author: Amery Hung <ameryhung@gmail.com>
Date:   Fri Sep 11 22:03:58 2026 +0000

    bpf: Unify kfunc argument kinds with enum bpf_arg_type

    This commit folds the kfunc argument kinds into enum bpf_arg_type. It
    reuses ARG_SCALAR and maps kfunc callbacks to ARG_PTR_TO_FUNC, adding
    enumerators for kfunc-only kinds to allow check_kfunc_args() to carry o=
ne
    classification throughout verification.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d21bee458055..dc849e6708762 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12178,15 +12145,15 @@ get_kfunc_arg_type(struct bpf_verifier_env *env=
, struct bpf_call_arg_meta *meta,
>  	/* Scalar arguments are classified from their BTF suffix/name alone. */
>  	if (btf_type_is_scalar(t)) {
>  		if (is_kfunc_arg_constant(meta->btf, &args[arg]))
> -			return KF_ARG_CONST;
> +			return ARG_CONST_SCALAR;
>  		if (is_kfunc_arg_const_mem_size(meta->btf, &args[arg]))
> -			return KF_ARG_CONST_MEM_SIZE;
> +			return ARG_CONST_MEM_SIZE;
>  		if (is_kfunc_arg_mem_size(meta->btf, &args[arg]))
> -			return KF_ARG_MEM_SIZE;
> +			return ARG_MEM_SIZE;
>  		if (is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdonly_buf_s=
ize") ||
>  		    is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdwr_buf_siz=
e"))
> -			return KF_ARG_CONST_ALLOC_SIZE_OR_ZERO;
> -		return KF_ARG_ANYTHING;
> +			return ARG_CONST_ALLOC_SIZE_OR_ZERO;
> +		return ARG_SCALAR;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing how the
verifier classifies kfunc scalar/enum arguments, I noticed a pre-existing
issue where several memcg kfuncs take enums as array indices but lack
negative bounds checks.

Because the verifier treats enums as signed integers and does not enforce
valid enum ranges, a BPF program can pass negative values to these kfuncs
to bypass the upper-bound checks and read out-of-bounds kernel memory.

For example, in mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events():

__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *m=
emcg,
						       enum memcg_memory_event event)
{
	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);
}

A negative event value bypasses the signed upper bounds check and directly
indexes memory_events[-1].

A similar missing negative bounds check exists in
mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events():

__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
						   enum vm_event_item event)
{
	if (unlikely(!memcg_vm_event_item_valid(event)))
		return (unsigned long)-1;

The negative integer is forwarded to mm/memcontrol.c:memcg_vm_event_item_va=
lid()
which also lacks a lower bound check:

bool memcg_vm_event_item_valid(enum vm_event_item idx)
{
	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));
}

Could this allow users capable of loading BPF programs to bypass KASLR or
leak adjacent kernel heap memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911220415.1396=
439-1-ameryhung@gmail.com?part=3D6
