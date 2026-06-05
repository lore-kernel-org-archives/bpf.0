Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8EC44D68A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642970; cv=none; b=t6WBCA/RD5I+2hfLiD60OLrOBQgs7Sp7zf8an+1YgRU6oUxsVUH9cnBi6k/T7s4bPKlYnA18Ty+w0BLXDhOv5MW+R+boq+Opv+xJnbnzN3Tf2mSmTI1oivoLhF1FdKOncn+lPTpjBWn4e6EF4tEnYSY9MChQsnuZS3cfmAmsPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642970; c=relaxed/simple;
	bh=b0pfywq/CcjuZ0L7dKrCYYLcZ04GL33PSRfXfNqs2Qk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c5XloLTiLvSd3z3Us90FsC7e9H4LwsEIdoLjs9UlTF4hXZ0+RgZEWMOfXtYMVyBdEoNGrpYMvdJ+2/rRUEtP6w3ZNtW9o0h7eqcslViKSU7tf1PeI+I8OIFFqMnlU+WMqbWBx/63aEqUoiogTEsNZFrQkKZw/zxcEiGhirFVDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNdJclOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNdJclOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00A71F00893;
	Fri,  5 Jun 2026 07:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642969;
	bh=SYtN0ta4VlzzmWfqLia6bbLf8uG6T5076x9kp8GtPL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZNdJclOyYBlLbAd8F/CWf95JGC3Mh+ZScVZeR5uuGRwz0zffzQZ5pBlnAD7vu0vDN
	 4fk8HwFhcoDWFrBjbUqkj9Ijq2oggELyEv0Z7ncCWdtff51lDiksqVp80YIwW77gUl
	 yGzn94x2w4SLlo7QGGsRyXHwLShDgRDqWaV+FiW6V6Z11CEY6jA4ZuqCAgCqx4Tdwy
	 En9E6Dx3KZIGKc5lHNiuD+G3AjTHoKYYPxMkkp1dW4jAjIGEM43LeSpOY6AP3O92L8
	 7uYeN00MZ/YY14E/pdtbbiQSxH719yqkq09GFN6+9s+GXuMDjfqiE+QgftnkPjdMMG
	 OdG6e6q6DKpig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 14/17] bpf: Report Policy helper and kfunc
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-15-memxor@gmail.com>
References: <20260605063412.974640-15-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:02:48 +0000
Message-Id: <20260605070248.D00A71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read in `bpf_diag_func_name` when formatting verifie=
r diagnostics.
--

commit 2af8da104307236e989f2e90416035f301412857
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Policy helper and kfunc errors

Augment selected helper and kfunc allowability failures with Policy reports.
These reports explain which requested operation is forbidden and why, witho=
ut
adding path history for non-path-dependent policy checks.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 325c162e3df0d..f81aad4aeb8e1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2829,6 +2829,10 @@ static int add_subprog_and_kfunc(struct bpf_verifi=
er_env *env)
> =20
>  		if (!env->bpf_capable) {
>  			verbose(env, "loading/calling other bpf or kernel functions are allow=
ed for CAP_BPF and CAP_SYS_ADMIN\n");
> +			bpf_diag_report_policy(env, i,
> +					       "bpf-to-bpf or kernel function call",
> +					       "loading or calling other BPF or kernel functions requires C=
AP_BPF or CAP_SYS_ADMIN",
> +					       "Load this program with the required capability, or avoid bp=
f-to-bpf and kernel function calls in unprivileged programs.");
>  			return -EPERM;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but was introduced earlier in th=
is
patch series. When a user provides a BPF program with attr->func_info_cnt
smaller than the actual number of subprograms, env->prog->aux->func_info is
allocated with a size smaller than env->subprog_cnt.

If the diagnostic framework is invoked early (for example, here in
add_subprog_and_kfunc(), or during check_subprogs()), it can trigger an
out-of-bounds read.

bpf_diag_func_name() calculates the subprogno and accesses the array without
checking if it falls within func_info_cnt:

kernel/bpf/diagnostics.c:bpf_diag_func_name() {
    ...
	subprogno =3D subprog - env->subprog_info;
	info =3D &env->prog->aux->func_info[subprogno];
    ...
}

Since the validation enforcing func_info_cnt =3D=3D env->subprog_cnt happens
later in check_btf_func(), can this allow a malformed program to trigger
an out-of-bounds heap read before validation occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D14
