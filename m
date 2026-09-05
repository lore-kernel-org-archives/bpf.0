Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119C282F0E
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567597; cv=none; b=qnR+c2lub5Qfa/neqw3WKlAkDVBc266YY3d7h5hld5jJ+Ctgu5uNWCzb8Xs5t2Z5wBsUhUohi0pbsx5WuLmp0KqCpYJjBsER0nQst8IVu2UW28ygfeVV48Y+Ec6M1K6Pd4EH5YgBmn/wtqdrVXoRZlwtH0iyTem3YpvxYp5x9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567597; c=relaxed/simple;
	bh=MbGMLEOwOBMQ9riw58HNApqS+11eUhYApssNYJhkdxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ut9cGSiyqF4qVcnGi9VuzTcvfZJ7vGYC8huB8E3HSGUa8U+CYFKZl8YXSQGOeyIp9LJxwOFYIzeD1dGHePee2ne8v/VhS/+KSfO2hA9TtvqCiqMEi3k720jLTj38A9eoMfglHHELY6166UOIoO9t6QVZ6+yPtPx1R0VibYpwUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEcHmjeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEcHmjeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFA21F00A3D;
	Sat,  5 Sep 2026 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567596;
	bh=wjj9JmKtdKdS0+rzR52dTjOP3Gml2RaP7Ej5uS4HjT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEcHmjeSrKZo6kGoM3260luRZ30g3MWQVg/b4VorNNaVYHk4vAfoZ224mXCXZ4otL
	 6RsUnsa2ytK+YgVYIVg6mKhhy/gydajCGKWO6hDXqeq1NBWKHXq7WENNm0ijIFylUj
	 jj+zAoxSFfG81gJL5pFrsGJ4xiD6ArBkkuqap1h8X4V8Dqrht4NHO7dK6B7H2jzCaS
	 cXPlFxg9Mqz3acFHfV58mDKy5J/JqwbfWVPuaqbeVZgFORRGysoRaFqTY5q63ebOHf
	 +a2HCDMHf+OfKAMEfop6Fa2PTrdCZi191dX0aGOtZ4PXOLMiDiXBetAdJWE/T9723i
	 uXXgZsl80PvDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 07/10] bpf: mark a NULL BTF_ID argument of a global
 subprogram precise
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-7-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
 <20260904-register-is-null-precise-fixes-v1-7-0f5a360ff15d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:19:55 +0000
Message-Id: <20260905001956.1FFA21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing precision marking for NULL register in `check_map_kptr=
_access` bypasses kptr type checks, enabling arbitrary kernel memory read/w=
rite.
--

commit 86bb17dfcff95ef6eeda4b1333ab93abe99ab7bb
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: mark a NULL BTF_ID argument of a global subprogram precise

btf_check_func_arg_match() accepts a NULL register for an
ARG_PTR_TO_BTF_ID argument tagged __arg_nullable and skips
check_reg_type() and check_func_arg_reg_off() without marking the
register precise. Hence a checkpoint created on such a path would
prune against arbitrary scalar value.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2b3d080978062..3c3575215899b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9767,8 +9767,12 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
>  			struct bpf_call_arg_meta meta;
>  			int err;
> =20
> -			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type))
> +			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type)) {
> +				err =3D mark_arg_precision(env, argno);
> +				if (err)
> +					return err;
>  				continue;
> +			}
> =20
>  			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */

[Severity: Critical]
This isn't a bug introduced by this patch, but does the same missing
precision issue exist in check_map_kptr_access() for BPF_STX operations?

Looking at check_map_kptr_access() when handling BPF_STX:

	} else if (class =3D=3D BPF_STX) {
		val_reg =3D reg_state(env, value_regno);
		if (!bpf_register_is_null(val_reg) &&
		    map_kptr_match_type(env, kptr_field, val_reg, value_regno))
			return -EACCES;
	}

If a BPF program branch sets the register to 0, bpf_register_is_null()
returns true, and the type check is skipped without calling
mark_chain_precision().

Could a subsequent branch set the same register to an arbitrary non-zero
scalar and get incorrectly pruned by regsafe() because it compares against
the imprecise 0?

This sequence appears to allow storing an arbitrary scalar as a forged
pointer into a map. This could then lead to arbitrary memory read/write or
local privilege escalation when the kernel later drops or uses the kptr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-register-i=
s-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com?part=3D7
