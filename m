Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F99282F0E
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567693; cv=none; b=k+35IKZ9ZnSxE15ohesH9R/BDCbjWuFWuyhaqOgBQt5mZb5jXB1FTaPRU9xQPr1VOIcAC9H02QoGG8OXxv0QdWUzEWUCI5hvQJb46rlFtaCaZw3aMDPrT1TN01VxbgyMVcUy8w5efkTgspqiSDzkBZBAe1Cc0TNQEuXls0w02/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567693; c=relaxed/simple;
	bh=68qY67Y2fJFYnKkdrV2x/9nke0Fqfx/LmRrHqWc39q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Op3OCr+EFNQu+3idZN01Md5Gpr1l01d068gV+mNp9ChvD5LU5NoBDcu5JOTAENHPTe7k8x11hST0VnSGAWE05F5yvw+KdfdgnoooDFYuc12tvZfsXdzf22rd3sYXPv95NwdqEx5HMXRtmeZJ5uMJL0hlL0oJbgIcbXyNE+OUeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0ODhruc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0ODhruc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEAF1F00A3D;
	Sat,  5 Sep 2026 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567692;
	bh=ocBnh8ODBpOOpgTHoMZI9oF9rbIszlsxmwLo9K5HtTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0ODhruc9O+lTgcRn+/fvTGrRR/LywyXL8Yh6iq/lDH/y9XCXcPCnxK9GSHPvF+k9
	 dtqEaYHVeUOH8QWjDxucLQFgbYMJP5s3GWvQWTcHMekZog/jeu5SdclSmlyNOg1gF7
	 aaaTCE/koJZvXJdiVDe8dlIxo46Dm1j97CcVcQ6YXGWJ6w/ELe9qQQkUppVkmUJ44v
	 Mpq4bHcmYeq+H3KYEez2Op4nKZOZHsJCK2S1E8VfELElBpNxbo2kNUaWlCJgysMyn9
	 ExMHnX3cjFE+qiN1cpi6xVqXg3GvYiUAFsCrgd7/liF4EtKDDGkN6MKPy0EtjGuXhX
	 8h3NutjrR8zqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 01/10] bpf: mark a NULL call argument precise
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-1-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
 <20260904-register-is-null-precise-fixes-v1-1-0f5a360ff15d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:21:31 +0000
Message-Id: <20260905002131.DFEAF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the patch an=
d the series fail to fix it while fixing identical vulnerabilities elsewher=
e. Missing precision tracking for nullable arguments was fixed in `check_fu=
nc_arg()`, `check_helper_call()`, `check_kfunc_args()`, and `btf_check_func=
_arg_match()`. However, the exact same vulnerability remains in `check_map_=
kptr_access()`. When storing a NULL value into a kptr map field via `BPF_ST=
X`, `check_map_kptr_access()` checks `bpf_register_is_null(val_reg)` to byp=
ass pointer type validation. Because it skips validation on a NULL scalar w=
ithout calling `mark_chain_precision()`, a checkpoint created with a NULL s=
calar in `val_reg` will incorrectly prune a subsequent path where `val_reg`=
 holds an arbitrary, unconstrained scalar value. At runtime, this pruned pa=
th will execute and write an invalid scalar into the kptr field. When the m=
ap is later freed, the kernel will attempt to drop the kptr by treating the=
 invalid scalar as a valid pointer, resulting in arbitrary kernel memory co=
rruption.
--

commit a287fdd95b87b267c8cbd45bc11d4088d9532eb9
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: mark a NULL call argument precise

This commit fixes verifier pruning logic by marking NULL call arguments pre=
cise
in check_func_arg() and check_helper_call(). This prevents the verifier from
incorrectly pruning paths with unconstrained scalars against checkpoints wi=
th
NULL scalars.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c6ad157a61ec..ca362a7ea58c3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8752,11 +8752,15 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
>  			return err;
>  	}
> =20
> -	if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
> +	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
>  		/* A NULL register has a SCALAR_VALUE type, so skip
>  		 * type checking.
>  		 */
> +		err =3D mark_chain_precision(env, regno);
> +		if (err)
> +			return err;
>  		goto skip_type_check;
> +	}

[Severity: Critical]
This isn't a bug introduced by this patch, but the series appears to miss
an identical vulnerability in check_map_kptr_access().

When storing a NULL value into a kptr map field via BPF_STX,
check_map_kptr_access() checks bpf_register_is_null(val_reg) to bypass
pointer type validation:

kernel/bpf/verifier.c:check_map_kptr_access()
    } else if (class =3D=3D BPF_STX) {
        val_reg =3D reg_state(env, value_regno);
        if (!bpf_register_is_null(val_reg) &&
            map_kptr_match_type(env, kptr_field, val_reg, value_regno))
            return -EACCES;
    }

Because it skips validation on a NULL scalar without calling
mark_chain_precision(), a checkpoint created with a NULL scalar in val_reg
could incorrectly prune a subsequent path where val_reg holds an arbitrary,
unconstrained scalar value.

At runtime, this pruned path could execute and write an invalid scalar into
the kptr field. When the map is later freed, the kernel would attempt to dr=
op
the kptr by treating the invalid scalar as a valid pointer.

Could this lead to arbitrary kernel memory corruption? Should
mark_chain_precision() be called on value_regno when
bpf_register_is_null(val_reg) is true here as well?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-register-i=
s-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com?part=3D1
