Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5339FD4
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529686; cv=none; b=rUvWzDsbAjZkdLTH/bDEzyC++gDdmhYaEnL3FMJcR2fE5ag2wBNzyatmW0BSsnZLVU9Dfm5sIuuUs6Tk5oQ/eROkNv8hDuNJjw6pWjxeYdom9u9ZtINb1PHk4LqlhQoniNDJ7y057Mr5HtEFK/sIv7XdLlU/rDesYHuB5nxUa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529686; c=relaxed/simple;
	bh=gp36n4NqDEhvhNBvIAWtdNEtvSapaZzVMw/oIaIRDW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l3SI4av4PmFI2PffVNcF4ZovcbHFKBO6n1gWnFpU/nTQexH+FO9vq80BRsrZbFfzJZ3OEE0zTM3ZTfChThSWlAj3cUunvMb+os5ISeM0UiwmZISmhEJeJCKv6Ej8oJO23EWkYWXDiAb/Mf4yWkNVkywbUSF9shSV0/OnUcl2G88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQsDA2WO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQsDA2WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9DD1F000E9;
	Sat, 23 May 2026 09:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779529684;
	bh=KOSCW6ghYEaY3Ekyx6Fpoc2gMr2fKY6gNbZHC/mzrQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQsDA2WOTNwuTxtRfssBTtATwr+w3uZs6YzWz4F/wsuU0W7hvniTiZSi36a+YO2lJ
	 gr+RDw/Qjk6Auf6LdyrZz+yEO72UapDInS9ihTT7jTHEUt9uVk5QJAvgnvkvwhrLUu
	 VWlc+2oPv0wEHrvuGAlRX5zo93Ncd5AZEw9I2Jh8+X8os9Lf5zKSFaIbJ7+cFMGvP7
	 2xe28QS6ATmXda6DaY9eQwVhy5pyGoNv9wB7MR4zqfBqiBD8r9LRWUWdO2bnHSgv+J
	 VH0Ko8Zrc6fJsM1G7M+8eTuxdeLKyLvd5+9vhoEyHsOZ2aoWH4Vi5u0vfnWxIYONLN
	 6jucuadigx0bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Add return value check for BPF_LSM_CGROUP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523085806.417723-2-xukuohai@huaweicloud.com>
References: <20260523085806.417723-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 09:48:04 +0000
Message-Id: <20260523094804.AE9DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The bounds validation for bpf_set_retval() can be bypassed by pass=
ing a pointer instead of a scalar, leading to the exact kernel panic the pa=
tch attempts to fix.

Pre-existing issues:
- [High] Bounds enforcement is strictly restricted to BPF_PROG_TYPE_LSM, co=
mpletely neglecting other vulnerable cgroup program types like BPF_PROG_TYP=
E_CGROUP_DEVICE.
--

commit db7ea535b43831ef01a0cbacc405e0287e5dd010
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Add return value check for BPF_LSM_CGROUP

This commit adds validation for the return value set by the bpf_set_retval()
helper in BPF_LSM_CGROUP programs. It verifies that the provided argument
falls within the valid return value range for the target hook to prevent
kernel panics.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..fe60a695de558 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10462,6 +10462,9 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  	case BPF_FUNC_set_retval:
>  		if (prog_type =3D=3D BPF_PROG_TYPE_LSM &&
>  		    env->prog->expected_attach_type =3D=3D BPF_LSM_CGROUP) {

[Severity: High]
This is a pre-existing issue, but does restricting this check to
BPF_PROG_TYPE_LSM leave other cgroup program types vulnerable?

Programs like BPF_PROG_TYPE_CGROUP_DEVICE can also call bpf_set_retval()
with arbitrary positive values. If such a program returns 1 (allow)
after setting a positive return value like 1234, the value propagates
through __cgroup_bpf_check_dev_permission() and bdev_permission(), causing
bdev_file_open_by_dev() to return ERR_PTR(1234).

Since 1234 is not a valid negative error code, IS_ERR() would return false,
potentially leading to a kernel panic when the caller attempts to
dereference 1234 as a file pointer.

Should we extend this validation to all cgroup program types?

> +			struct bpf_retval_range range;
> +			struct bpf_reg_state *r1 =3D &regs[BPF_REG_1];
> +
>  			if (!env->prog->aux->attach_func_proto->type) {
>  				/* Make sure programs that attach to void
>  				 * hooks don't try to modify return value.
> @@ -10469,6 +10472,13 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't mod=
ify return value!\n");
>  				return -EINVAL;
>  			}
> +
> +			bpf_lsm_get_retval_range(env->prog, &range);
> +			range.return_32bit =3D true;
> +			if (!retval_range_within(range, r1)) {

[Severity: High]
Can this bounds check be bypassed if a pointer is passed instead of a scala=
r?

Because bpf_set_retval_proto uses ARG_ANYTHING, check_func_arg() allows
pointer registers when env->allow_ptr_leaks is true (which is the case
with CAP_BPF).

If a pointer like PTR_TO_STACK is passed without a variable offset,
its s32_min_value and s32_max_value are both 0. Since 0 falls within the
valid [-MAX_ERRNO, 0] range, retval_range_within() will allow it.

At runtime, the 64-bit pointer address would be truncated to a 32-bit integ=
er,
potentially yielding an arbitrary positive return value and causing the exa=
ct
kernel panic this patch intends to fix.

Should the verifier explicitly ensure that R1 is a SCALAR_VALUE before
validating its range?

> +				verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
> +				return -EINVAL;
> +			}
>  		}
>  		break;
>  	case BPF_FUNC_dynptr_data:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523085806.4177=
23-1-xukuohai@huaweicloud.com?part=3D1
