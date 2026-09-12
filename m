Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C95377ABA
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243607; cv=none; b=fCHajeaslm9xjUWPHHKvF5wAfU3lE/1rTehHRkwHMLzD+1yqBUvOp5UIjTbWLpjRw4Aszg445MUqAWMf3/0prxtL6Ndkt4P63EmZSrZEYGeoxKmgRIoNavdyAqzKQqfeFVCrYIG8PZRJcWLzZVT/nUGDItIIzGFjv/ZMz1ULRGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243607; c=relaxed/simple;
	bh=8WlcJwT7Vnpx3vnDVukQFb6A6Io2A+RAj3H129VlCC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBcONoT2+tydFQW23L2KgSwgPpNOy42vmf9Ngo0KTNgb9n978im6a7XWgFZh1eN+lT91jkoQuwVbWMvSf0BQuwqcJv6mDQjDDgUbFivT5tuFELIx4jDxsxIVlAfH0okLvGSaPDji1NK2w2w5wLFUZopU3McLOMJrrfWd9FELJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9+pxRUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9+pxRUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208041F000FF;
	Sat, 12 Sep 2026 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243605;
	bh=ppj1H4TEjED5fN3k1OJmstrp+D+NgmnZbwl1f8n9UU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9+pxRUqW8/w+YxRwyW2w4L65ovPO7UEEgID0Zcin+kejx6V25V4jnuetIP44MdaU
	 es/afpgs3++x4DX0CkgCB2JpNnGEWvxKBnQtMqBNG9zuNy9Wb4MP6V9H5z4rzt+cv8
	 E1WeTjElR7dIHjI5gZ8+l5B8rlMtkxz4Uq17bTe9cPRZwTxhmvlouj0Pu4Jmqnb0P7
	 ZtKQFq8jCPbkBeAmz8VjBJm5SYMnjamUfAW1QCw2b5Gy8RtjKsKWgrIM04+C+IkPn9
	 +TOW+o0+xvjEelSVJH5MN4rvCdyczhCteu5hgfBJS2l1ku/DM/veQqRzjEnaO4DLtM
	 BcEeqFsT3+Dug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 01/15] bpf: Read a kfunc's __sz argument
 only when it is in a register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260912195201.982215-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
 <20260912195201.982215-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:06:44 +0000
Message-Id: <20260912200645.208041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing negative bounds check for enum parameters in memcg kfuncs =
allows out-of-bounds array read
--

commit 5816e44e0d469f2be29753390131ba5c9f8fd073
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Read a kfunc's __sz argument only when it is in a register

This commit fixes an issue where an out-of-bounds index could be used to re=
ad
from const_reg_vals[] when a kfunc receives a stack argument pair of a
pointer and size. It ensures size_reg is bounded by MAX_BPF_FUNC_REG_ARGS
to prevent reading unrelated callee-saved registers.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 617a277c3558c..0c6a404167ca4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13641,13 +13641,14 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_ver=
ifier_env *env, struct bpf_insn *
>  		goto out;
>  	}
> =20
> -	/* ptr + __sz/__szk pair: size is in the next register */
> +	/* ptr + __sz/__szk pair: the size follows the pointer */
>  	if (arg + 1 < nargs &&
>  	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
>  	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
>  		int size_reg =3D BPF_REG_1 + arg + 1;
> =20
> -		if (aux->const_reg_mask & BIT(size_reg)) {
> +		if (size_reg <=3D MAX_BPF_FUNC_REG_ARGS &&
> +		    (aux->const_reg_mask & BIT(size_reg))) {
>  			size =3D (s64)aux->const_reg_vals[size_reg];
>  			goto out;
>  		}

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem with how the
verifier handles enum arguments for kfuncs, specifically in the memcg
kfuncs.

Since the BPF verifier treats enum types as plain signed integers and does =
not
enforce enum ranges natively, BPF programs can pass negative scalar values
to kfuncs.

In mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events():

	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);

Does this signed comparison without a negative bound allow a negative
event value to bypass the check and cause an out-of-bounds read on the
memory_events array?

Similarly, in mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events():

	if (unlikely(!memcg_vm_event_item_valid(event)))
		return (unsigned long)-1;

	return memcg_events(memcg, event);

And the check in mm/memcontrol.c:memcg_vm_event_item_valid():

	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));

Could a negative idx here bypass the bounds check and lead to an
out-of-bounds access on the mem_cgroup_events_index array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912195156.9808=
86-1-yonghong.song@linux.dev?part=3D1
