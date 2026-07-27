Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1CF9E8
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785111236; cv=none; b=SI5RDf1b0xaFFKlNUBYzsjaLXKclmMFW13YUOsRVvAo2DzGvkjdt4zE5DsUpkUm5ni7mP7+iUhYxNJ0LhvRUVFKunBKf7+PNxvd/lOI8lqSpJLylDgVRN5zmQG+CyEb4C1zR21ifkgtkzVL6l2o+j1OVBZOvm7ERCJfRCE2FnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785111236; c=relaxed/simple;
	bh=b4YIiYSiNK5sW/23yqDRuGjQVG8GTMILKo+rSVJO+ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCt3OTtZbFrz8jhnGmo9syWK1ustb3kTxlAjtR9bw8atjJevNOlzdLcCLyJKVPehKZ2R89IQggOr06TG/78yzJtM+e4MSSgM5JokrA2zGocdNGwF12lPXpQKE7z6MrULdd11qXzUA+JRftGvXlVdOiCeFU2oU1KRPF8SahFfOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiBToLN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiBToLN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F1E1F000E9;
	Mon, 27 Jul 2026 00:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785111234;
	bh=Rj5P0cF5ygXn7iX9QL+o0hmy4oHkq/URFAypVvWwoGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TiBToLN9Z/+0lC1D3zKu70Q8xw4ZVq4wpszaYPcOgyrbRVzQFCuN5hxzZr3IvwPCE
	 mUEuMpFrBA3HJ9cpJTaZV3M41PoN6BGMV4USY/GrXV/2XF5uLEgS6OvFARbWc+7KAK
	 BEeZrCqbORrC/UOEHqB0EQhPaWKJGJ6sqzeXX1twu/Vv3c2jErO2nktEjXjIkxXz8O
	 5Q5ehdih6vfKk+9g36Feln2Vo9KV0P90D39aM8UUfOZ1Ib3xX+SyFjdjf2Ov1/YcXQ
	 jAWc335e1405BInJCijWYIK1JRU7YzOMfho6lyM6pPE0kOkTfWFe2orXiQUX2PnszM
	 DpUbnAgUH0bwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in
 refcount_acquire
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ning Ding" <dingning04@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726235030.1152542-3-dingning04@gmail.com>
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 00:13:54 +0000
Message-Id: <20260727001354.B3F1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] check_ptr_to_btf_access() incorrectly allows writes to PTR_UNT=
RUSTED allocated objects or triggers a verifier_bug WARN_ONCE when reading =
from them.
--

--- Patch [2]: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refcoun=
t_acquire ---
commit 80e6c61503b2eee2d4804b0a7ec8927827ed7d92
Author: Ning Ding <dingning04@gmail.com>

bpf: Reject untrusted pointers in refcount_acquire

This commit fixes an issue where a refcounted map kptr could still be passed
to bpf_refcount_acquire() after being marked PTR_UNTRUSTED due to
bpf_rcu_read_unlock(). It updates check_kfunc_args() to reject PTR_UNTRUSTED
arguments for KF_ARG_PTR_TO_REFCOUNTED_KPTR.

Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.org

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1e7343b625de5..63b1d997fe804 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12414,6 +12414,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			meta->subprogno =3D reg->subprogno;
>  			break;
>  		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> +			if (reg->type & PTR_UNTRUSTED) {
> +				verbose(env, "%s is an untrusted refcounted kptr\n",
> +					reg_arg_name(env, argno));
> +				return -EACCES;
> +			}

[Severity: Critical]
This is a pre-existing issue, but I noticed a similar problem with
PTR_UNTRUSTED handling in check_ptr_to_btf_access() for allocated objects:

kernel/bpf/verifier.c:check_ptr_to_btf_access() {
...
		if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
			verbose(env, "only read is supported\n");
			return -EACCES;
		}

		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
			verifier_bug(env, "allocated object must have a referenced id");
			return -EFAULT;
		}
...
}

Does this logic incorrectly allow writes to PTR_UNTRUSTED allocated objects
or trigger a verifier_bug WARN_ONCE when reading from them?

If a program loads a program-allocated kptr containing an RCU-protected fie=
ld
inside bpf_rcu_read_lock(), the verifier marks it MEM_ALLOC | MEM_RCU (and
NON_OWN_REF if it contains a bpf_rb_node or bpf_list_node). When the program
calls bpf_rcu_read_unlock(), it strips MEM_RCU and adds PTR_UNTRUSTED.

If the program subsequently tries to read or write this pointer,
type_is_ptr_alloc_obj(reg->type) evaluates to true because it ignores
PTR_UNTRUSTED, bypassing the read-only check for writes.

Then, if the pointer lacks NON_OWN_REF, it hits the type_is_alloc() conditi=
on
and triggers a verifier_bug(), leading to a BPF_WARN_ONCE. If it has
NON_OWN_REF, it bypasses the verifier_bug() check entirely, and proceeds to
allow a memory write to the untrusted pointer.

Could a malicious BPF program exploit this to achieve a local denial of
service via panic_on_warn or a use-after-free memory write?

>  			if (!type_is_ptr_alloc_obj(reg->type)) {
>  				verbose(env, "%s is neither owning or non-owning ref\n",
>  					reg_arg_name(env, argno));

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726235030.1152=
542-1-dingning04@gmail.com?part=3D2
