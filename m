Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B639E175
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138415; cv=none; b=KZiuN0Ihd7c3GJlYSz5IxI9ltOnKqrBG74SRN4vMiU0B4/Ah7kp/GyQCxcF14+VXqeMsnHhMeviO0n/yb5T7OHKIjFmK6ZnBuguQyTSzt7AjAabGaRS0yRUm2ccEpLq3mW4xqRla+rggkLhXI46dynCnuVrPjyrBasJFA2cEqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138415; c=relaxed/simple;
	bh=IX9dJ25J/tCftaEu21WyidAA71Ikn7l0xn5RYHwHtKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DqG7HM1/I1W6EszxmHyZ/45I2Uo7rrRfRju/YkbWbaHgMbXEqdIhMCEFaDpduM7GIICSLg4tKmZND9GN/gGSAqU2759fF0DbHpOPYj5iW/NX9EWqdSPfm/FQZwhVuXQfnyLc4m08pxSMGBTDfzkaLKYt2WkHS3+vEdQCx3n4P2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Elkq3i9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elkq3i9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8BA1F00893;
	Sat, 30 May 2026 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780138414;
	bh=Fu/xMEZbOwB+MSZK92vncRn99otEGGgb3wjbbKQczVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Elkq3i9o4alDJmBvoYQkNXPJlrY0rm9rR4VmODYGjjtD4KWgIIixdj1E3Bip8vpAK
	 1bzbLv0vbnEWN0keLE4RDSdnyOHk8tdlMJ4Wy4RRzzD3tDFAWSyyIOuc84dR1Fd1OP
	 LxQBdFn0OBNl+y+XRaAXtKFmQPeAp42jW/pT/MbzMaJMSkez4YwRNziGT5KYytSZ6m
	 aOUis1qhjIcNfx9GrJBigCwaJ3VqMWU3n0wdH0XjsfrUrEmESxaPcZSrXAUvPo7kwX
	 OVBDk2/lFFqJ1POAsZylsHX1X09u2ayvuVmdZf6rszUHajbQEmSBD48O7P7h30OL4T
	 upkcz4i9cr/XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/3] bpf: Add validation for bpf_set_retval
 argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530101239.590395-2-xukuohai@huaweicloud.com>
References: <20260530101239.590395-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 10:53:34 +0000
Message-Id: <20260530105334.8E8BA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The strict bounds check added to `bpf_set_retval()` unconditionall=
y rejects programs that pass unconstrained variables, such as the output of=
 `bpf_get_retval()`, breaking backward compatibility for existing user prog=
rams.
- [High] Restricting `bpf_set_retval()` to `[-MAX_ERRNO, 0]` breaks `BPF_CG=
ROUP_GETSOCKOPT` programs that legitimately return positive values.
--

commit 822adc8377df563ad6f9bfabc65c87c7f98aaf52
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Add validation for bpf_set_retval argument

This commit adds validation to the bpf_set_retval helper to prevent
cgroup BPF programs from returning unexpected positive values, which can
cause wild pointer dereferences or bypass error checks. For BPF_LSM_CGROUP,
it enforces LSM-specific ranges. For other cgroup types, it restricts the
argument to [-MAX_ERRNO, 0].

Link: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.=
uestc.edu.cn

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..4948bd4bf9e16 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10460,6 +10460,19 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		}
>  		break;
>  	case BPF_FUNC_set_retval:
> +	{
> +		struct bpf_retval_range range =3D {
> +			.minval =3D -MAX_ERRNO,
> +			.maxval =3D 0,
> +			.return_32bit =3D true
> +		};

[Severity: High]
Does this blanket restriction to 0 break BPF_CGROUP_GETSOCKOPT programs?

Commit c4dcfdd406aa2167 ("bpf: Move getsockopt retval to struct
bpf_cg_run_ctx") removed the restriction that getsockopt filters must
return <=3D 0, noting that valid getsockopt handlers often return positive
values for the option length.=20

Could this maxval =3D 0 limit prevent BPF_CGROUP_GETSOCKOPT programs from=20
legitimately returning positive lengths via bpf_set_retval?

> +		struct bpf_reg_state *r1 =3D &regs[BPF_REG_1];
> +
> +		if (r1->type !=3D SCALAR_VALUE) {
> +			verbose(env, "R1 is not a scalar\n");
> +			return -EINVAL;
> +		}
> +

[ ... ]

> @@ -10469,8 +10482,20 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
> +		err =3D mark_chain_precision(env, BPF_REG_1);
> +		if (err)
> +			return err;
> +
> +		if (!retval_range_within(range, r1)) {
> +			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
> +			return -EINVAL;
> +		}

[Severity: High]
Will this strict bounds check unconditionally reject programs that pass=20
unconstrained variables, such as the output of bpf_get_retval?

The helper bpf_get_retval returns an int which is tracked by the verifier=20
as an unknown scalar. If this unconstrained scalar is passed directly to=20
bpf_set_retval, it is checked against the newly hardcoded [-MAX_ERRNO, 0]=20
range.=20

Since the unknown bounds fall outside this narrow range, the verifier will=
=20
reject the program at load time.=20

Could this break backward compatibility for existing user programs relying=
=20
on the bpf_set_retval(bpf_get_retval()) pattern?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530101239.5903=
95-1-xukuohai@huaweicloud.com?part=3D1
