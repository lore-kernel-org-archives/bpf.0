Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D679CD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789623873; cv=none; b=YbLcdPmGTwyTcRcSeIJCgs0HBbqMIaU0P+aDbfqEvqXe/G+XBpy7+8nb4livbUrKe4hJDPozr99YS1K0u7WQlzyswoo8FZMKKWFew1yQQylVafWYvlXN4q7tF/eahuPtXtixiRg+k5U1OLTN6otFrZLfPgY13x50RrkEo8/EfuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789623873; c=relaxed/simple;
	bh=3lY4ZWywpz8YtbdGoqwfFI9zKIYqnCHQkbBuFtMTzuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LcJsn9gn1g9LkmQKi/l5EK5DjyvRvBR0BZcnCcH5bSrNRUW0CE8VOpj6AGXAc71xwcSZejJ3EiEz6rzhJGm40+UGzU7NWKMJ6tPXj4bD3cYcSuvI+hIeTqpJIJ+lSw3g7fxEr8P19xi/kiygcR73cQxkYyJOxW+YAMtpAeDbxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awyc8YU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awyc8YU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787511F000FF;
	Thu, 17 Sep 2026 05:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789623871;
	bh=kcYkOmY2ciEJINUL84CO9SqJliI9sWjjTJFfEp0WxN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Awyc8YU27GwB6xip0AKodIoi19hTkIty6njuv7TO/9HQ9UBjeycCHYKytwdjn80om
	 GZDHwrQDw24dWIbcFsYYuqe1NDin5+xNz0IO8hCr0uhc6n4488TDksmUHSt/xDNM4t
	 adQ2wTx4ghedfhoSXiWyzmq6QM0/OyYqFA55PZNhU5E9EqB85rWpDFaIeILKbI2KxT
	 +tPigGFl3rwNldOSMiO9SSJyeIP5yckSkSIMg8X4pTpAGL9QwrXHANv81//xDuV+tj
	 i3oBSHwDY1eh+1Gtfui49UB6LYMJ+JIas8XvH0bZvrFDxAfMpd1E2PTdiDd/EUf1Aq
	 Ixh4CNfRQv64Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Track iterator-owned BTF pointer
 lifetimes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917051948.1588826-2-xyx2021@mail.ustc.edu.cn>
References: <20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn>
 <20260917051948.1588826-2-xyx2021@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 05:44:31 +0000
Message-Id: <20260917054431.787511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: bpf_iter_next() fails to invalidate dynptrs and PTR_TO_MEM sl=
ices
- [High] bpf: PTR_TO_MEM slices returned by kfuncs escape iterator lifetime=
 tracking
--

commit 78eae9a9dcb52a34bea55102674e78d19a5f54b8
Author: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

bpf: Track iterator-owned BTF pointer lifetimes

This commit introduces lifetime tracking for non-RCU struct iterator
results by associating PTR_TO_BTF_ID results with the iterator reference.
It invalidates the previous result when processing the next iterator
argument and propagates the backing register's lifetime for dynptrs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..3d47487233b75 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -7817,6 +7834,27 @@ static bool is_kfunc_arg_iter(struct bpf_call_arg_=
meta *meta, int arg_idx,
>  	return btf_param_match_suffix(meta->btf, arg, "__iter");
>  }
> =20
> +static int invalidate_iter_owned_btf_ptrs(struct bpf_verifier_env *env, =
u32 parent_id)
> +{
> +	struct bpf_func_state *unused;
> +	struct bpf_reg_state *reg;
> +	int err;
> +
> +	err =3D check_reference_children_leak(env, parent_id);
> +	if (err)
> +		return err;
> +
> +	/* Struct iterators can release their previous element on next. */
> +	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
> +		if (base_type(reg->type) !=3D PTR_TO_BTF_ID || reg->parent_id !=3D par=
ent_id)
> +			continue;
> +		bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_REF_RELEASE);
> +		mark_reg_invalid(env, reg);
> +	}));
> +
> +	return 0;
> +}

[Severity: High]
Does this code fail to invalidate dynptrs and PTR_TO_MEM slices derived
from the iterator element?

The bpf_for_each_reg_in_vstate() macro only iterates over spilled registers
using the 1 << STACK_SPILL mask, which completely skips STACK_DYNPTR slots.
Furthermore, the loop explicitly filters out anything that is not a
PTR_TO_BTF_ID.

If a BPF program constructs an unreferenced dynptr (e.g., via
bpf_dynptr_from_skb) or a PTR_TO_MEM slice from the iterator element, these
derived objects inherit the iterator's parent_id. Because they are skipped
by this logic, they will survive the bpf_iter_next() call and remain
accessible after the underlying memory is freed, potentially leading to a
use-after-free.

[ ... ]

> @@ -14446,6 +14502,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].btf =3D desc_btf;
>  			regs[BPF_REG_0].type =3D type;
>  			regs[BPF_REG_0].btf_id =3D ptr_type_id;
> +			if (bpf_is_iter_next_kfunc(&meta) && !(type & MEM_RCU))
> +				regs[BPF_REG_0].parent_id =3D meta.ref_obj.id;
>  		}

[Severity: High]
Can PTR_TO_MEM slices returned by kfuncs escape iterator lifetime tracking
entirely?

When an iterator element is passed to a kfunc, the verifier attempts to
propagate lifetime tracking by populating meta->ref_obj in
check_func_arg() using this check:

	if (reg_is_referenced(env, reg))
		update_ref_obj(&meta->ref_obj, reg);

However, since non-RCU iterator elements track their lifetime purely via
parent_id and have id =3D=3D 0, reg_is_referenced() evaluates to false. This
leaves meta->ref_obj.id as 0.

When check_kfunc_call() processes a returned PTR_TO_MEM slice, it only
assigns parent_id if meta.ref_obj.id is non-zero:

			/* Ensures we don't access the memory after a release_reference() */
			if (meta.ref_obj.id) {
				err =3D validate_ref_obj(env, &meta.ref_obj);
				if (err)
					return err;
				regs[BPF_REG_0].parent_id =3D meta.ref_obj.id;
			}

Because meta.ref_obj.id is 0, the returned PTR_TO_MEM slice receives no
parent_id. Does this allow the slice to escape the iterator's lifetime
tracking and outlive the iterator element, causing a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917051948.1588=
826-1-xyx2021@mail.ustc.edu.cn?part=3D1
