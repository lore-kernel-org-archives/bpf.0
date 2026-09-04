Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870833955EE
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523972; cv=none; b=bX9xHGbpkVMz+g4oK/96ADYtXW4AC3lzNwNkI3Jl93x0GEthvkecirL1+O79oZxipiUKrWlrNfwVtTCiEnWtT9Yvqw7nfi4BjYTN5RRWu1ERnzfU9GJX6dEmRdcH8Ju/Br/l88DU0JigGkj1PJqhb53tKHySOj8af50oPDUEyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523972; c=relaxed/simple;
	bh=b+mwFZQ2bfOGJri/qk/utZ+p1rWZuNJWV2cSdC4vqCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjbnEGj8OukJ6zUuNGhJAhmZ0xLM/6sWHE0gl/vZZoRkLl+EIuHpA3L7UvxuyVnBQIOJO98we0Hl2/RQBmdLLxU4ggfk7mEg5jzBOHNWDnoiq19eOg0VlzpgGN/poNxRiOHr8Mi1Q3crsV5gk7eKHNBOFuJPLIHRuQx4SURUWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2rMjqhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2rMjqhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231D01F00A3D;
	Fri,  4 Sep 2026 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788523971;
	bh=rmvsgowIvLnCqvkvq+fQBqAsSd8LzDdHdo8etqKq+QU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2rMjqhrRteS12XKK1rQ7KafnHtNAbpU5W4sCEny0/AsPGn15sbo5ZYKY7YkoHi4z
	 sNUzMPnXws/5qayWdXt7A/0amySJC0+m5U0QeskcdCnml031xvD2bxSj7sEO7/0LIC
	 01AeT8YirW9wPe8GqM3sgl4Rw+3XYbx9BMn3oZiReOUra5kgBufLStCWVr0x+G1Pgu
	 V8SbUwgjCwIvjtckCJyK6k7WA3Bvd+WMF4wEikMHzWT5XTLmYHmst8QyH7D1yLtQHv
	 TFZ+lD+/DsqfKWr2rP3D6WHdV0XpUfFSVaQrzTSDBxqLI83/CGKBa+dmFHp5DZbzj3
	 5tgCVU97oXlHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 5/8] bpf: Mark NULL kptr stores precise
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904104203.345917-6-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
 <20260904104203.345917-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:12:50 +0000
Message-Id: <20260904121251.231D01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete vulnerability fix: missing precision tracking in `bpf_r=
egister_is_null()` checks across multiple helper and kfunc argument validat=
ion paths.
--

commit b710eacbe0205aaaab5cfce621a3ee0cf1e3f81f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Mark NULL kptr stores precise

check_map_kptr_access() permits a scalar store into an untrusted kptr
field only when the register is known to contain zero. Unlike other
verifier checks whose outcome depends on a scalar value, it does not mark
that register precise.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d7dd0befbd10e..ba9753bf529af 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4694,8 +4694,15 @@ static int check_map_kptr_access(struct bpf_verifi=
er_env *env,
>  			return ret;
>  	} else if (class =3D=3D BPF_STX) {
>  		val_reg =3D reg_state(env, value_regno);
> -		if (!bpf_register_is_null(val_reg) &&
> -		    map_kptr_match_type(env, kptr_field, val_reg, value_regno))
> +		if (bpf_register_is_null(val_reg)) {
> +			/*
> +			 * This store is valid only because the scalar is known to be
> +			 * zero. Mark it precise so another scalar cannot be pruned
> +			 * against this state.
> +			 */
> +			return mark_chain_precision(env, value_regno);
> +		}

[Severity: High]
This is a pre-existing issue, and was not introduced by the patch under=20
review, but while this commit successfully fixes the precision-tracking=20
bug in check_map_kptr_access(), does the exact same vulnerability still=20
exist in several other locations where bpf_register_is_null() is used=20
without calling mark_chain_precision()?

For example, in check_func_arg():

	if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
		/* A NULL register has a SCALAR_VALUE type, so skip
		 * type checking.
		 */
		goto skip_type_check;

And also later in check_func_arg() for map values:

	case ARG_PTR_TO_MAP_VALUE:
		if (type_may_be_null(arg_type) && bpf_register_is_null(reg))
			return 0;

Similarly, in btf_check_func_arg_match():

			if (bpf_register_is_null(reg) && type_may_be_null(arg->arg_type))
				continue;

And in release_reg():

	if (bpf_register_is_null(reg))
		return 0;

And in check_kfunc_args() for nullable args:

		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
			continue;

And in check_kfunc_args() for memory buffer lengths:

			if (bpf_register_is_null(buff_reg))
				break;

And in check_mem_reg():

	if (bpf_register_is_null(reg))
		return 0;

And in check_helper_call() for get_local_storage():

		if (!bpf_register_is_null(&regs[BPF_REG_2])) {
			verbose(env, "get_local_storage() doesn't support non-zero flags\n");
			return -EINVAL;
		}
		break;

Since mark_chain_precision() is omitted in these bypass paths, the scalar 0=
=20
remains imprecise. Could an attacker pass an attacker-controlled arbitrary=
=20
scalar on a second pruned path, which would then be incorrectly accepted by=
=20
the verifier when substituted at runtime?

> +		if (map_kptr_match_type(env, kptr_field, val_reg, value_regno))
>  			return -EACCES;
>  	} else if (class =3D=3D BPF_ST) {
>  		if (insn->imm) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904104203.3459=
17-1-memxor@gmail.com?part=3D5
