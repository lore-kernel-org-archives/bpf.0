Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4332248B3
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785031986; cv=none; b=HeKuoGVm49mmzEWsbAqm7RmpdmtAoDhfAQh20P4zmS7b8/IMuCujuaob6RW/7t1uLbrEg8KF0k5bg3+HH47vCW7SWp58827WCEvZXzua1X5rOE47KC0Efmj9V4d/tgtQvz6hkacLlU0FUqZYe/Kr7p2BuccUoAhcJYeWWgS4f6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785031986; c=relaxed/simple;
	bh=P+CL/sNePPTkLc5YMBwsZqx9Gd16uudxsQptdFR1nrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8Di3yKPUFE2F3XISaZauZJN6Z1lim8UMTkW6eXMnchcAIzzIjy6w2SVTBdw+/X1LaK9wgMKbJR9arKYdlLWDGyT5Z7Tu+HzN6ureKlfm8sDvNEFsFITHU3bEborrSMdxkImb28YkGhT+ldMnmDUsu1ISQt5C6go7Sz/svWUuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy6xJO83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy6xJO83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED91F000E9;
	Sun, 26 Jul 2026 02:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785031984;
	bh=/WNfZw+Btb47FojH8V+uHnlqXWojM20Rr5hSg3oM5Iw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oy6xJO83OyzK5wBwMnSrlZsq1fdv/AIR+idlrqfY+6BmtCcafEl4uhLbDz9NlLxs9
	 yGMKcJeynpa4/31YM665mLyR1eyH4/o41x312C8aV01ccnWbESKoddeBM3qpPeeJVp
	 FZ/7UtuR8ZqTMmJsq1LEAN3aXYPtys+WKH9rg96kYEmCdiXattbJKtYfigQk0PBGhd
	 EH85YIzXCIEplDKKWtIPOCbJhlibQIrVXPLCGFOS4yZr+gWL9QFRE8bANFByjijZIl
	 hPueWGg8uyZy1tsthtnnq02uiFGdhQfK0jGG4mnl1ZTpSBPuH/3Khkzg1j5Iwsznly
	 1n4ABGywHiIng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Keep refcount_acquire nullable for borrowed
 RCU kptrs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ning Ding" <dingning04@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726015330.705259-1-dingning04@gmail.com>
References: <20260726015330.705259-1-dingning04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 02:13:04 +0000
Message-Id: <20260726021304.97ED91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_refcount_acquire() permits untrusted pointers due to inade=
quate modifier checks, leading to Use-After-Free.
--

--- Patch [1]: [PATCH bpf] bpf: Keep refcount_acquire nullable for borrowed=
 RCU kptrs ---
commit 5798e6cddf6ec01af2fa26e9f86dfc1bb3fd1681
Author: Ning Ding <dingning04@gmail.com>

bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
   =20
bpf_refcount_acquire() can fail for a refcounted map kptr loaded
within RCU. Another execution can replace the map kptr and drop the
last owning reference after the pointer is loaded but before the
acquire, causing refcount_inc_not_zero() to fail.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7aa47342dc659..1e7343b625de5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12419,7 +12419,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  					reg_arg_name(env, argno));
>  				return -EINVAL;
>  			}

[Severity: Critical]
This is a pre-existing issue, but does bpf_refcount_acquire() permit untrus=
ted
pointers due to inadequate modifier checks, potentially leading to a
use-after-free?

In check_kfunc_args(), KF_ARG_PTR_TO_REFCOUNTED_KPTR skips the is_trusted_r=
eg()
checks that are applied to other pointer types. The argument is subsequently
validated using type_is_ptr_alloc_obj():

include/linux/bpf_verifier.h:type_is_ptr_alloc_obj() {
    return base_type(type) =3D=3D PTR_TO_BTF_ID && type_flag(type) & MEM_AL=
LOC;
}

Since type_is_ptr_alloc_obj() only requires MEM_ALLOC to be set and does not
restrict unsafe modifiers, it returns true for a pointer with the PTR_UNTRU=
STED
flag.

If a BPF program loads a refcounted pointer from a map inside an RCU read-s=
ide
critical section, checks it for NULL, and then drops the RCU lock using
bpf_rcu_read_unlock(), the pointer's verifier type is updated to include the
PTR_UNTRUSTED flag.

The program can then pass this untrusted pointer to bpf_refcount_acquire(),
which bypasses trusted register checks and accepts it. At runtime, the
bpf_refcount_acquire_impl kfunc executes refcount_inc_not_zero() on the
provided untrusted address.

Since the address might have already been freed outside the RCU critical
section, could this result in memory corruption or a kernel panic? While th=
is
patch sets meta->arg_owning_ref =3D false for untrusted inputs, does it fai=
l to
prevent the unsafe input pointer from being dereferenced inside the kfunc
itself?

> -			if (!type_is_non_owning_ref(reg->type))
> +			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
>  				meta->arg_owning_ref =3D true;
> =20
>  			rec =3D reg_btf_record(reg);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726015330.7052=
59-1-dingning04@gmail.com?part=3D1
