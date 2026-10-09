Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA66349CF3
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520817; cv=none; b=c0YSiJRTeh3qvOqIgUnKMOdZDxr9giq23YbYCaKhf1exJVeR+d3xbx63al2VtHBUUS74owbzAjRJBc/Br/OHHefPps3Lg2cZ2mMqy4k2q3xzp9n/Nb+NoreggL6hnqdTr2XFOh0pag6s5W4y54xdHN9vFpSm4P1U6NdTuzEZaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520817; c=relaxed/simple;
	bh=Pdy3AAbe1NVEvB3mMVX9Ewnh0dgDiE/YCOsuK7WofAQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bf0Q80VIukryX4297mcR1oWTPyuwjmSOAwwJqssh03D8MRNbIrq3JLw/sPi+wrmnBdMOo2tKUCJB1r4k6X2vwxlzGjG0qPeVZWY89SXCeNog9yqMwfnCzIQUI16uiXd9sNOlwXY3h2Oj+roIU8U2fKLzMIeJu1rAxRSNmLkp/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+C9XOPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+C9XOPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F981F000FF;
	Fri,  9 Oct 2026 04:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520815;
	bh=4XhulMZU7R3l6y6+9jMnwFOcRpV7BpMSGDLy9IMwVO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+C9XOPmzsJcIzOijj96zy8OcoM0tbpj0fusVIJ7a4BKgAXPimTksR7Pc8U6vWbKM
	 lN4ROMMThz9D4xO+zLe19T4awF4cY07YQB4OGT85T9d9G+P8kZFSqrROOZz6CvxgR5
	 Cj677XfQGt8RlOoJ1WCSIaC6h/IXjc9Ke32DcyUatxNT3pWXE8ftj6A1eDpKOi4Hsf
	 kZgjdve0GytLaDDK1xSZ0W0rFDnjStAt3VNniJOSg4tFa9AeOwwQf9XDzu122wCFI6
	 1Qt6gsqZlJEhqUuhkHF4q2DJT0c6Z8l9VoWrCk5/EskqdZqNsqJ2kOT0P3+NRwC+Sg
	 VPTcfv5w8Dg2w==
Message-ID: <sashiko-outbox-164848@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 07/24] bpf: Verify an unwind through
 landing pads and epilogues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041523.26992-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041523.26992-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:40:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: skipped exception pad verification for global subprogs that t=
hrow and unwind
- [Medium] bpf: Soft lockup in mark_callx_might_unwind() due to O(N^2) inst=
ruction traversal
--

commit 54596ff7029b639349bb84341497b649e38e027e
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Verify an unwind through landing pads and epilogues

This commit adds verifier support for tracking control flow through
unwind landing pads and epilogues. It calculates whether a subprogram
might unwind by propagating the might_unwind flag along the CFG,
and integrates backtracking through these new paths.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -716,6 +753,82 @@

[ ... ]

> +static void mark_callx_might_unwind(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn *insns =3D env->prog->insnsi;
> +	struct bpf_subprog_info *caller, *callee;
> +	int i, j, len =3D env->prog->len;
> +	struct bpf_func_ptr *ptrs;
> +	bool changed;
> +	u32 cnt;
> +
> +	if (!addr_taken_subprog_might_unwind(env))
> +		return;
> +
> +	for (i =3D 0; i < len; i++)
> +		if (bpf_is_callx(&insns[i]))
> +			bpf_find_containing_subprog(env, i)->might_unwind =3D true;
> +
> +	do {
> +		changed =3D false;
> +		for (i =3D 0; i < len; i++) {
> +			caller =3D bpf_find_containing_subprog(env, i);
> +			if (caller->might_unwind)
> +				continue;

[Severity: Medium]
Could this loop cause a CPU soft lockup for very large BPF programs?

The loop iterates up to len times (which can be up to 1 million) and
repeatedly calls bpf_find_containing_subprog(), which performs a binary
search. Because this propagates upward through the call graph, the do-while
loop could execute many times (e.g., up to 256 for the maximum call depth).

Without a cond_resched(), this might stall the CPU in kernel space for an
extended period.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19464,8 +19602,14 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
>  				cur_func(env)->no_stack_arg_load =3D true;
>  			if (bpf_is_callx(insn))
>  				return check_func_callx(env, insn, &env->insn_idx);
> -			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> -				return check_func_call(env, insn, &env->insn_idx);
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL) {
> +				int call_idx =3D env->insn_idx;
> +
> +				err =3D check_func_call(env, insn, &env->insn_idx);
> +				if (err)
> +					return err;

[Severity: High]
If a global subprogram has the might_throw flag set, check_func_call()
simulates the exception exit and returns PROCESS_BPF_EXIT (which is 1).

Because err is positive, does the check here mistakenly return early,
bypassing the subsequent call to process_global_call_unwind()?=20

If the subprogram can both throw and unwind, its landing pad might never be
visited by the verifier, potentially leading to a dead code sanitization tr=
ap
at runtime.

> +				return process_global_call_unwind(env, call_idx, do_print_state);
> +			}
>  			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
>  				return check_kfunc_call(env, insn, &env->insn_idx);
>  			return check_helper_call(env, insn, &env->insn_idx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D7
