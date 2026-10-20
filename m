Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484149;
	b=Qir8kHBqOCx6TRh1tsGwWxiLnrriAJ5HiyRf7Kmp9AhTj/EyH6qfWSJ8aIXk3UQ2w5Tk
	 cbPDKZRO9gkgZoUmQZzKN9eD9Bk59amGtMVS0hhRn13uzQ1aZerbhN7Aujzzd8Lu3ug3W
	 v7gGwoLuSfA+QIVtW4YPuohIdlal36OURrGRVCkPlPHs4DIztx9rBhBm8xXrCOB10hukq
	 cqWgJkq/EPJUgQCNedAfh+DKmRB8ZF5bIigg2RqNuvTOwE2BG1J9naPfIo6rsSJq2c3tb
	 a30u/pAWRttHEAnAwxz2mBVTlV5hVhsnry2rFyjPn0TZG0SiOwpqZBpwqSmJmbu09Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ek/HjiU0NQUr+1/BhsqYnXkGvaZ/0t+xYjq4gigGDTE=;
	b=P47hXKFgDXkrz/oSwpmC+qfcwlsUsS9H3i4RWDlPSjsRPlxkKlGOaWNH5MFV7VXGnw1Z
	 TQQ4HPVsTsczBB2QpBhUqKroZZB3/vQ60PuKrDwEFZXsZA8UAqKmdzf3EjsG0sJSqh7F4
	 mj2uDiDMVnqD4YJMDh+bhwBUhd3Rh8DwjS4WXtvANxkezBZoiftGJhLYT2qB77ZgEKp7W
	 Z4DGiccl4qnpQdwg6Wx4VLImSxOieIUUIaS5nCECqak+Lxi6RJqLNKsQAqY1Z/RmFUXM2
	 L/zO3s7Fw86NVK7+SzQhYn5IJP7XjrxZpvqUZf9n/RIjfWdWzqXcAhTXu3F/dOO/bag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqZC1suE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FE606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqZC1suE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479971F000C4;
	Tue, 20 Oct 2026 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484148;
	bh=Ek/HjiU0NQUr+1/BhsqYnXkGvaZ/0t+xYjq4gigGDTE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IqZC1suEQaL/Mc74+r0PLFB5we63cDyTX9VdoiUjXnkKdVJI8MiUJs+EZzXibRHdw
	 PmcAZqbOO3PVGz2HDj+DKyGm+1QppFZeZ+fq/lx582qdSFNNYbVlRJW9hsAhQRdP9U
	 Dlh7W9rPdC5Q2N85AV5GqQROdSg6qmbKuczZJ020Rtq7TlIgucJDrK0KFv2fjtMjD5
	 4EPTUI5+9oQ4yRTAldOtneXKjAn+ccZbGqYBPWmU5ot/3e+oP9ZmqNvwBcTJfqlyl4
	 3sWX+qESvwyTok00pytdfJHy4spVsDWUE7UOEL7UxuOoSSyehtHBhFtnxWnr8aM7As
	 qJKr1nxBYvygA==
Message-ID: <sashiko-outbox-178505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 1/6] bpf: Add unwind_goto and unwind_exit
 insns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261020043319.3031996-2-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
 <20261020043319.3031996-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:15:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: dead code removal after unwind_goto drops speculative verific=
ation
--

commit c4406736d7c4ae90a726bff79265bfa8a261c473
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add unwind_goto and unwind_exit insns

This patch introduces unwind_goto and unwind_exit BPF instructions to
support zero-cost stack unwinding for Rust Drop, C++ destructors, and C
cleanup attributes. It updates the BPF verifier to track unwinding state,
validate landing pads, and explore speculative execution paths following
unwind_goto.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 409b9104c723e..9ae3a81604483 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -666,6 +666,10 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf=
_verifier_env *env)
>  		if (!bpf_insn_is_cond_jump(insn->code))
>  			continue;
> =20
> +		/* unwind_exit of a callee that never exits needs it too */
> +		if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen)
> +			continue;
> +
>  		if (!aux_data[i + 1].seen)
>  			ja.off =3D insn->off;
>  		else if (!aux_data[i + 1 + insn->off].seen)

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01434e1d23b59..6c56675c3298d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18759,6 +18826,23 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  		return -EINVAL;
>  	}
> =20
> +	if (bpf_is_unwind_goto(insn)) {
> +		if (!env->cur_state->unwound)
> +			return 0;
> +		env->cur_state->unwound =3D false;
> +		/*
> +		 * unwind_exit changed its return address, so the return is
> +		 * mispredicted and what follows unwind_goto runs speculatively.
> +		 */
> +		if (!env->bypass_spec_v1) {
> +			err =3D sanitize_speculative_path(env, NULL, *insn_idx + 1, *insn_idx=
);
> +			if (err)
> +				return err;
> +		}
> +		*insn_idx +=3D insn->off;
> +		return 0;
> +	}

[Severity: High]
When a static callee never exits normally and only leaves via unwind_exit,
can bpf_opt_remove_dead_code() delete the speculatively verified
fallthrough instructions after unwind_goto and shift unverified live code
into the return misprediction path?

For a loader with CAP_BPF (so is_priv is true) and without CAP_PERFMON (so
env->bypass_spec_v1 is false), check_cond_jmp_op() pushes the fallthrough
at *insn_idx + 1 via sanitize_speculative_path() with vstate->speculative
set to true.

Because the callee never returns normally, those fallthrough instructions
are only ever visited speculatively. In sanitize_mark_insn_seen(), seen is
only updated for non-speculative states:

kernel/bpf/verifier.c:sanitize_mark_insn_seen() {
	if (!vstate->speculative)
		env->insn_aux_data[env->insn_idx].seen =3D env->pass_cnt;
}

This leaves aux_data[i + 1].seen as 0.

Unlike ordinary conditional jumps where
bpf_opt_hard_wire_dead_code_branches() rewrites the jump into an
unconditional BPF_JA when !aux_data[i + 1].seen (which eliminates branch
misprediction into i + 1), bpf_opt_hard_wire_dead_code_branches() preserves
unwind_goto when aux_data[i + 1 + insn->off].seen is set.

Immediately afterward, bpf_opt_remove_dead_code() removes all instructions
with !aux_data[idx].seen:

kernel/bpf/fixups.c:bpf_opt_remove_dead_code() {
	for (i =3D 0; i < insn_cnt; i++) {
		int j;

		j =3D 0;
		while (i + j < insn_cnt && !aux_data[i + j].seen)
			j++;
		if (!j)
			continue;

		err =3D verifier_remove_insns(env, i, j);
}

Doesn't this cause two problems when the CPU mispredicts the return to the
instruction immediately following unwind_goto?

1. If speculative verification hit an unsafe instruction in the fallthrough
block and do_check() set insn_aux->nospec =3D true, verifier_remove_insns()
deletes that instruction and its aux_data before bpf_convert_ctx_accesses()
can emit BPF_ST_NOSPEC().

2. If the fallthrough block was a benign dead block (such as r0 =3D 0; exit)
followed by an unrelated live basic block while the landing pad is
elsewhere, deleting the dead block shifts that unrelated live block directly
into i + 1 (or leaves unwind_goto at the end of the subprogram if the
landing pad is at a negative offset), where the live block will execute
speculatively on return misprediction under the post-call register state
without having been verified for that state.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020043319.3031=
996-1-alexei.starovoitov@gmail.com?part=3D1
