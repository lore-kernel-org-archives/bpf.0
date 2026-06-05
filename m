Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4626B4CB5B
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670555; cv=none; b=kVIvAGJIOM3xWD062tvhvMVwMgYFw0KCz1e70meZTh7WC//LiXByrmDv74ZVgNpMyeRyFwVbZxd0Ku+UtPaJdVyJzYPx5jmqXphFzTjUThvElSefF70vdqiVYO+DDBPwxyDY43k22nvuN+uA10MmAqqZLXvaQhbyfYW8VMXMlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670555; c=relaxed/simple;
	bh=E7yCuZQ/gjxjYK64+YNAQKaOjs55h345FWsY1vdneQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LM1Xc524r+BvJYY/ZOSq95LxIZLpJXFP/Uo/PGZUGjWgkd/69FX9SrxaW2AcYIZxaCMiib95mTMRuMwd8NauG4+wdaHZheURNMjubZNtfitaQPn/bIosR2OJp1co1ByIre3XpOoq7WdewWYULFX0Fomoyod5laoQ58pm9YZ13Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScYWUOe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScYWUOe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A141F00893;
	Fri,  5 Jun 2026 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670552;
	bh=lH15OBjlffDERJ1Vsa1vI/y5/zU39FBYd4umcYXmT2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ScYWUOe5HZO5og6LU5SDDcWFn7oyaHwo11OFjuG9yewuLrAqWQzOy/E6CsLFD9ZQr
	 +WG6f1xjUnuAZzfUGQDWGLJFhdegD4NW1lzQ/AFKPerwfg8KKTGT+q0VYpv/WQByAs
	 gkBOvFDMJufl7g2ekV5gLyUy7MbwPzp2qVxKZ9OY9Uc6IEQ/7o/mQ8Z/C3og+KWlcR
	 +mBZuasHyvLHKYWyp5zOM90Q5vz+lbSh+x8SBTp/Mn52v8RHz4tdvQubUiLE1b/ACL
	 PuQhHY7HYhZVirvD0gPa34MOfzYQ3h3TWetSA1EbddZuh7dSbRHkHUT5zesPJHdhTZ
	 GQECIPKdnmlXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Add validation for bpf_set_retval
 argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605140243.664590-3-xukuohai@huaweicloud.com>
References: <20260605140243.664590-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 14:42:32 +0000
Message-Id: <20260605144232.95A141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The verifier incorrectly refines the bounds of `bpf_get_retval=
()` for boolean LSM hooks to [0, 1], but at runtime the returned value can =
be -EPERM (-1), leading to a register bounds violation and arbitrary out-of=
-bounds memory access.
--

commit 2c0b94558327f28e9ce1f11e3518238475fc93d6
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Add validation for bpf_set_retval argument

This commit adds argument validation for the bpf_set_retval() helper to
prevent positive return values in cgroup hooks that expect negative error
codes. It also refines the return value bounds of bpf_get_retval() so it
can be passed directly to bpf_set_retval() without extra manual bounds
checking.

Link: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.=
uestc.edu.cn

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a4..a50280bb0d453 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9790,6 +9792,29 @@ static int do_refine_retval_range(struct bpf_verif=
ier_env *env,
>  		reg_set_urange32(ret_reg, 0, nr_cpu_ids - 1);
>  		reg_bounds_sync(ret_reg);
>  		break;
> +	case BPF_FUNC_get_retval:
> +		/*
> +		 * bpf_get_retval may see arbitrary value passed by bpf_prog_run_array=
_cg for
> +		 * CGROUP_GETSOCKOPT type.
> +		 */
> +		if (prog_type =3D=3D BPF_PROG_TYPE_CGROUP_SOCKOPT &&
> +		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_GETSOCKOPT)
> +			break;
> +
> +		if (prog_type =3D=3D BPF_PROG_TYPE_LSM &&
> +		    env->prog->expected_attach_type =3D=3D BPF_LSM_CGROUP) {
> +			if (!env->prog->aux->attach_func_proto->type)
> +				break;
> +			bpf_lsm_get_retval_range(env->prog, &range);

[Severity: Critical]
Does this cause a verifier bounds violation when multiple programs are
attached to a boolean LSM hook?

When do_refine_retval_range() calls bpf_lsm_get_retval_range() for a boolean
LSM hook, it strictly refines the register bounds to [0, 1].

However, if multiple programs are attached to the same cgroup hook via
BPF_F_ALLOW_MULTI, they run sequentially in bpf_prog_run_array_cg().
If the first program returns 0 (which is within the [0, 1] bounds),
bpf_prog_run_array_cg() translates this into an error code:

kernel/bpf/cgroup.c:bpf_prog_run_array_cg() {
    ...
    if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
        run_ctx.retval =3D -EPERM;
    ...
}

When the next BPF program in the array executes and calls bpf_get_retval(),
it receives the current run_ctx.retval, which is now -EPERM (-1).

Since the verifier statically assumes bpf_get_retval() will only return
0 or 1, will receiving -1 at runtime allow an attacker to bypass verifier
checks and perform out-of-bounds memory accesses?

> +		} else {
> +			range.minval =3D -MAX_ERRNO;
> +			range.maxval =3D 0;
> +		}
> +
> +		reg_set_srange64(ret_reg, range.minval, range.maxval);
> +		reg_set_srange32(ret_reg, range.minval, range.maxval);
> +		reg_bounds_sync(ret_reg);
> +		break;
>  	}
> =20
>  	return reg_bounds_sanity_check(env, ret_reg, "retval");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605140243.6645=
90-1-xukuohai@huaweicloud.com?part=3D2
