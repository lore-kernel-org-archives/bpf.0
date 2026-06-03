Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CA3D3D12
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486675; cv=none; b=YW83nYBhfsMeoa3O9Lkb4wUlTL1yhSQ/kCFblU/EONsLzALXLsPak6OIehreLQm4hCUYQVGDQ/Thuej85qC6jtSAOWLUnq6Vy2JyDG1LvFRPpT8bdMCS9QvNuTW4nA9OjWvPGysQaLy4vtzES50im0FYMvvUkwLcXuZUI5EfipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486675; c=relaxed/simple;
	bh=XxO27b28guJbWwAwI8FnyFr6yeWjLQyPNGuOG+NcQiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u4tVA95r1Z6Xe4qNcEyZsEzmX6GCXitqKIrD+vQSYPCKYfuiSPzIrcgiGu2lPBIvPdu2dQ/efNaZfHg1Uj/hjFFNeC3giCpDqkH85PITlgh0+rkWydkDfpR21zIL9wfztYR4nSBrvXVCK8G4wHSp9hL4pBTGlZ5b9V0LnCHfvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXssKF30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXssKF30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4C51F00893;
	Wed,  3 Jun 2026 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486672;
	bh=Oir3/LsEYQDCtYBq/hH+5OtWyDgLXoHwuqAH5KxpJGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXssKF30oAmEnJH5tRGK9O6jt4at9yXhGPWG9Mq9ToujhtldtKEuYAafxOJV/efyv
	 ttE2g5JCkjweFzvQ/ORYLO5Z1wJHoq9lnMyYuk+x17IbhM1LnFuAu7pMZKMz9rYgQF
	 gyzzOj/72Uarr3c2mRDmp6fTdsR4YHjNOGThXOyMp4OgH7Z0FcPo0S7K7nlnWMIyO8
	 QDT7H4y695qua0m+mr8m9aF5HQc56GiuCgArSJBOA5TLqLdAyL9dsDBZG2n5nNOfGb
	 6899EWKNmzrsAc+Ht4RJvSoUgJhM4ELjFMV8p+n/1kOZcMUztg35n38M2VVW8rd5EN
	 WiX82CQ6Q/b1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 bpf-next 10/29] bpf: Add multi tracing attach types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603110554.29590-11-jolsa@kernel.org>
References: <20260603110554.29590-11-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:37:51 +0000
Message-Id: <20260603113751.DC4C51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `BPF_TRACE_FENTRY_MULTI` and `BPF_TRACE_FEXIT_MULTI` cases=
 in `btf_validate_prog_ctx_type` causes valid `.multi` programs using `u64 =
*ctx` to be rejected.
--

commit 0330f287f02c3a32c9ab8bf7f4f5a6ad6cf7366f
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add multi tracing attach types

This commit introduces new program attach types BPF_TRACE_FENTRY_MULTI and=
=20
BPF_TRACE_FEXIT_MULTI to support multi-tracing attachment. Base verifier=20
support is added to recognize these types and accept them as sleepable=20
programs, while deferring actual target validation to link creation.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8ed484cb1a8a4..521ec2a9051ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -16314,6 +16314,8 @@ static bool return_retval_range(struct bpf_verifi=
er_env *env, struct bpf_retval_
>  		case BPF_TRACE_FENTRY:
>  		case BPF_TRACE_FEXIT:
>  		case BPF_TRACE_FSESSION:
> +		case BPF_TRACE_FENTRY_MULTI:
> +		case BPF_TRACE_FEXIT_MULTI:

[Severity: High]
Are we missing an update to btf_validate_prog_ctx_type() in kernel/bpf/btf.c
to handle these new multi types?

Currently, BPF_TRACE_FENTRY and BPF_TRACE_FEXIT are explicitly whitelisted
there to allow u64 * as a context type:

kernel/bpf/btf.c:btf_validate_prog_ctx_type() {
    ...
		case BPF_TRACE_FENTRY:
		case BPF_TRACE_FEXIT:
		case BPF_MODIFY_RETURN:
		case BPF_TRACE_FSESSION:
			/* allow u64* as ctx */
			if (btf_is_int(t) && t->size =3D=3D 8)
				return 0;
			break;
    ...
}

Without adding the new multi types to this switch statement, the verifier
will fall back to the default canonical type (void *) and will reject valid
multi programs that use BPF_PROG and u64 *ctx.

>  			*range =3D retval_range(0, 0);
>  			break;
>  		case BPF_TRACE_RAW_TP:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110554.2959=
0-11-jolsa@kernel.org?part=3D1
