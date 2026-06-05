Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F62436352
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642661; cv=none; b=JJqIpsUakwvO6uhzvS0+4o0bpN43m6pXLJJ3R7DNyZl/8cH/UGezAfOEMT5lkLmQ5t8RqQauqsiiqUY3lcbFh85XzKUkJbDvqg/NwlYQ1+Yaxz2inCSEwVrtz4Y/YeJTwdTgf3w66kBnb1P43pBdjDnd2gAwfijDYaYpmyw4IwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642661; c=relaxed/simple;
	bh=I4i/uofLLUOjPp3N7HizHX9WauYvewLiRljfCz4okR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAhWxAjLe5rhor+phrU7OWrvfdv9K9Q4MJVqxRE5APWn1TBxIVQ2tFUFJVWiNn/Fd1WXuUTgjaTNPd0zh5htN31Che9cJQ5DBpBjnr7ahhIC1wRlBY3d+VUjK389PkxmxvJN224ZWfC2pzKPnDc+8BoVyxcTs1OZM2RQy3EtaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjK2oxwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjK2oxwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9756C1F00893;
	Fri,  5 Jun 2026 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642659;
	bh=7TOQIKxu2AO9AGzbHO043EVfXv8QtqsDB1gMA5bF5mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjK2oxwUotascaqBErKxUKQHzjfO8qnhUU3fWhdC/bF6m76PUaJj2mXkxHvSyqaZE
	 5bN8LEZTtAdbyBOQD1Hqrx0DYM3h2MFWiOh078dZtV+uyNQInd4/w1RRVj8sLBTAxA
	 kW6uOj0rJlSTNS1ZcbH+g5nSzaNnKquXTxHxI572Z8Haq6l/oA9uS+vDhncWuzw+iP
	 YSpYy5aglarhAaHrouRh5G9ldoeApGqJ6E0/6m6AjVWfOX0rjWoLF7FLPwAv916BKg
	 K7p7XX28nESZkkzxEnsGbJ3oQWD9ohU3a09zhDUZE3wllZZAryo+Jg+q2UlMzGYEF4
	 R4nmovJqtLXoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 08/17] bpf: Report Register Type Safety
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-9-memxor@gmail.com>
References: <20260605063412.974640-9-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:57:39 +0000
Message-Id: <20260605065739.9756C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Diagnostic reports for pointer arithmetic incorrectly target the=
 scalar register instead of the pointer register.
- [Medium] Unconditional history dumping when regno is -1 floods the verifi=
er log with all branch events.
- [Medium] Invalidation of spilled registers breaks the diagnostic causal p=
ath.
--

commit 5519f021558a88153013c28db08b650a5c841f07
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Register Type Safety errors

Augment selected register-state verifier failures with Register Type Safety
reports. The existing verbose verifier messages remain in place, while the
new reports add reason, source context, causal path, and suggestions.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 7a122c5025c27..920ac17758c20 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -648,6 +658,157 @@ void bpf_diag_report_source(struct bpf_verifier_env=
 *env, u32 insn_idx,
>  	}
>  }
> =20
> +void bpf_diag_report_register_type(struct bpf_verifier_env *env,
> +				   u32 insn_idx, int regno,
> +				   const char *problem, const char *reason,
> +				   const char *suggestion)
> +{
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno =3D bpf_diag_current_frameno(env),
> +		.regno =3D regno,
> +	};

[ ... ]

> +void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 ins=
n_idx,
> +				   int regno, const char *reg_name,
> +				   const char *type_name,
> +				   enum bpf_diag_invalid_deref_kind kind,
> +				   s64 offset)
> +{
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno =3D bpf_diag_current_frameno(env),
> +		.regno =3D regno,
> +	};
> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY,
> +			       "invalid dereference");
> +

[ ... ]

> +	bpf_diag_report_section(env, "At");
> +	if (kind =3D=3D BPF_DIAG_DEREF_MODIFIED_PTR)
> +		bpf_diag_report_source(env, insn_idx, '!',
> +				       "dereference requires the original %s pointer",
> +				       type_name);
> +	else
> +		bpf_diag_report_source(env, insn_idx, '!',
> +				       "invalid dereference of %s (%s)",
> +				       reg_name, type_name);
> +
> +	bpf_diag_print_history(env, &opts);

[Severity: Medium]
Does this unconditionally dump the history when regno is -1?

If regno is -1 (for example, from reg_from_argno for a stack argument),=20
bpf_diag_history_start_idx() will fail to find a match since dst_reg is a u=
8.=20
This causes it to return index 0.

Because bpf_diag_history_event_visible() returns true for all branch events=
,=20
this will inadvertently flood the verifier log with the entire branch histo=
ry=20
of the program.

Could we add a check for regno >=3D 0 before printing the history, similar=
=20
to the check in bpf_diag_report_register_type()?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7bb2a81ee3535..adf660ab9e7d4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13684,6 +13712,7 @@ static int adjust_ptr_min_max_vals(struct bpf_ver=
ifier_env *env,
>  	struct bpf_sanitize_info info =3D {};
>  	u8 opcode =3D BPF_OP(insn->code);
>  	u32 dst =3D insn->dst_reg;
> +	char reason[256];
>  	int ret, bounds_ret;
> =20
>  	dst_reg =3D &regs[dst];
> @@ -13707,12 +13736,28 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,
>  		verbose(env,
>  			"R%d 32-bit pointer arithmetic prohibited\n",
>  			dst);
> +		scnprintf(reason, sizeof(reason),
> +			  "R%d holds %s. 32-bit ALU operations on pointers discard pointer pr=
ovenance, so the verifier cannot keep the result as a safe "
> +			  "pointer.",
> +			  dst, bpf_diag_reg_type_plain(env, ptr_reg->type));
> +		bpf_diag_report_register_type(env, env->insn_idx, dst,

[Severity: Medium]
Will this diagnostic report target the scalar register instead of the point=
er?

For commutative pointer arithmetic operations like scalar +=3D pointer,=20
adjust_ptr_min_max_vals() uses insn->dst_reg. Because dst_reg held the scal=
ar=20
value before the instruction, passing dst here causes the message to falsel=
y=20
claim the scalar register held a pointer.=20

This also traces the scalar's history rather than the pointer's provenance,=
=20
which could produce misleading output.

[ ... ]

[Severity: Medium]
Looking at the register invalidation logic in clear_all_pkt_pointers() and
release_reference():

	if (regno >=3D 0)
		bpf_diag_record_reg_invalidate(...);
	else if (slot >=3D 0)
		bpf_diag_record_stack_arg(...);

Are spilled registers silently omitted from the diagnostic history?

When iterating over all registers, bpf_diag_func_regno() and=20
bpf_diag_stack_arg_slot() evaluate to -1 for standard stack spills.=20

If a program later restores and dereferences a pointer that was spilled
during invalidation, the verifier trace will stop at the stack fill=20
instruction. This breaks the causal path, failing to show when and why=20
the pointer was actually invalidated.

Does this need to track stack spills to maintain the diagnostic history?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D8
