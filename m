Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FD44C4ED
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921900; cv=none; b=ptoIocmARU1cuBYcA/niftojJBe8DJVed5HiN2+WxpzajF+5ETKxiyMnZPSdCkTx1Rq3SyHxGvajAnBIpjy8KKO3RH5vF9Pt03MgGIeJBmh0/GVHTlttECwA0Cdn5yqWesyzZgwJ/LX/VJFvhHXNOmXSx4MTjSblbY+3zuu5N4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921900; c=relaxed/simple;
	bh=hkTPvEZZjpBXYMWxjAx+Kb+r4q+9wrpmUGQFwp0jNzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D/zorFV+FrGeXa0FspQNnWheXoLHZAxZb1yUSWPhElCU/2xvlTY6IOxtWArPInao7Lv5RsAU4yEsDWBBFHBCVVVKL3tdMU4zl3Tdk1c2Bmg3cY3IhDhSYOoD9Sj6GDVtbeE2u/ob38EDQAEJmJ7K0tpZuxc9XAWZHw0RmqWKW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTNsTvdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTNsTvdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981241F000E9;
	Fri, 24 Jul 2026 19:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784921898;
	bh=PkzkEuYRLf4w5Ikq5hwSjCE2sgSMcdnj+bqmbydy0+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mTNsTvdiNMBI8GKjPgT7JX0MbBZsUs9SARj/JMuKajytr6+Se9e1NHlos8TleqEdL
	 R8GcfgQ7ufv1qd7DWYRmsb2t4wftxP33UEMjEhchZgDlJsJcNbovhANTk0drNYEEKP
	 YQqg9hRRnSvRNIoq00n9TblX+6wanVgaGffpxYR/UcPbLREBKqVPyvZb8P6QkLON8T
	 YddQbqCV1yYj50Cu2VMiJ69Lg3e1L65aqH2l3XbfcKK/aiTNMxP0uMkZfrJOsro6Ze
	 lpVY3rR68q8p0OfcaGUtdET8biMrArY9amTJbyYhUHJZf3U8gsph+1V+ML+IPyMdaf
	 3Jf1eNZapaLTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 16/18] bpf: Tag nullable kfunc pointer args
 with PTR_MAYBE_NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724190813.1458271-17-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
 <20260724190813.1458271-17-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 19:38:18 +0000
Message-Id: <20260724193818.981241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the BPF subsystem style.
--

--- Patch [16]: [PATCH bpf-next v2 16/18] bpf: Tag nullable kfunc pointer a=
rgs with PTR_MAYBE_NULL ---
commit 8714272b2414d4acacf57ee10e018ba054ac3e95
Author: Amery Hung <ameryhung@gmail.com>

bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL

This commit updates get_kfunc_ptr_arg_type() to classify nullable kfunc
pointer arguments by OR-ing PTR_MAYBE_NULL into the returned type based
on BTF alone. It defers the check of whether the register is actually NULL
until after the classification is complete, matching how helper arguments
are handled.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 76a84574b23e9..3b357007e893b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -11361,93 +11361,85 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env, struct bpf_call_arg_meta *m
[ ... ]
> +		if (btf_type_is_struct(ref_t) && !arg_mem_size) {
> +			/* A pointer to a struct without a size argument is classified
> +			 * as KF_ARG_PTR_TO_BTF_ID.
> +			 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style? Multi-line comments in this subsystem typically require the
opening /* on its own line before the text begins.

> +			arg_type =3D KF_ARG_PTR_TO_BTF_ID;
> +		} else if (!btf_type_is_scalar(ref_t) &&
> +			   !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
> +			   (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> +			verbose(env, "%s pointer type %s %s must point to %sscalar, or struct=
 with scalar\n",
> +				reg_arg_name(env, argno),
> +				btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
> +			return -EINVAL;
> +		} else {
> +			/* Otherwise this is a memory buffer supported by
> +			 * check_helper_mem_access(): a pointer to a scalar, or to void
> +			 * when paired with a size argument. The access size is derived
> +			 * from the pointed-to BTF type unless a size argument follows.
> +			 */

[Severity: Low]
This isn't a bug, but this comment has the same style issue where the text
starts on the same line as the opening /*.

> +			arg_type =3D arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | M=
EM_FIXED_SIZE;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.1458=
271-1-ameryhung@gmail.com?part=3D16
