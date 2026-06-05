Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147345BD5C
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649296; cv=none; b=NV17cXMn7KKEjbPYqz3L55vny2zLliTrlq0ep46yJPLw0So6DX9Z8VZs+wOqVe5K7EsDhP7p93oy1JBOHA4paF3YZ9g7Ous5Yje9sd+WUEvjYTfLga0vDaxO59A/94ret76aTz5ldedda3Y8zutaBPy8Z2EVefSltCchhpfthD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649296; c=relaxed/simple;
	bh=KhHss1kt5SFpx8DD7NcvWnQU9TQ/ecDf+CNCbjvNQn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kUAy7yLdRBjCokENpnq4r/gVMZMyk8DvCOW28CQdUCCnKrHeKN2Zdcu/q7KRFAEc8+q42uU+QDM6+IcxjX7uZfFqtX/61CKpbQVzYpFFer1oxEYVYnF8e0mtBbtzOOU+lTYdAOR9yChJK4Rs6gIhav1M7CPoIq0eMimf82tPjEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/vdbs49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/vdbs49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729271F00899;
	Fri,  5 Jun 2026 08:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780649294;
	bh=rxzjEIjg/WNw45Vbv3pNKDkeWR9jS/xOhICOyyJMM98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/vdbs49W+a7OuDezYPdyql6YoWhA0bqjgpLfVnZwdadRjjIwdgThNuIfm11Pg3SG
	 VjRSyJDZMaVEarDMsOhYfAOA5q0RxVyln/Zv/SWCQGdOsPOthcSG/iwDDIwEnM5QcG
	 B/PDBR6TKc7wXz629hwHzkDuHaXzj5TtexxUnJKnoSBjtxlDS+/jF28fl5OfRr7yKN
	 NJPYDHSSnRgmsP/u9bsfJsUkJy/aSnaGv75BaJLoOkY/gxoAUSfmJTxcuom8Tn8jyw
	 JJWsS3skIXcaZm9vllvpDl0zsEQ8PRsYj4TdLdw3l9/8HbcQb7m/iNdFjBt7kxVab1
	 0qiiNyr30zZCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 03/17] bpf: Add source and instruction
 diagnostic context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-4-memxor@gmail.com>
References: <20260605063412.974640-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:48:14 +0000
Message-Id: <20260605084814.729271F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing array bounds check in `bpf_diag_func_name()` when resolvin=
g hidden subprograms.
- [Medium] Tight loop coupling silently drops BPF instructions when the dia=
gnostic is triggered near the top of a file.
- [Low] Potential loss of the visual alignment caret (`^-- `) due to `scnpr=
intf` truncation if the source code is heavily indented.
--

commit e84e87b559a751018ace3ee43b2b61b8014f1c4e
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add source and instruction diagnostic context

This patch adds source line and nearby instruction annotations to the BPF
verifier diagnostics. The renderer keeps source text in a fixed-width lane
and prints instructions in a stable right-hand gutter.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index d9a103cf3a16e..652d4627c2b0f 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> +static const char *bpf_diag_func_name(struct bpf_verifier_env *env, u32 =
insn_idx)
> +{
> +	const struct bpf_subprog_info *subprog;
> +	const struct bpf_func_info *info;
> +	const struct btf_type *type;
> +	int subprogno;
> +
> +	if (!env->prog->aux->func_info || !env->prog->aux->btf)
> +		return NULL;
> +
> +	subprog =3D bpf_find_containing_subprog(env, insn_idx);
> +	if (!subprog)
> +		return NULL;
> +
> +	subprogno =3D subprog - env->subprog_info;
> +	info =3D &env->prog->aux->func_info[subprogno];

[Severity: High]
If the verifier dynamically adds a hidden subprogram like the exception
callback, env->subprog_cnt increments but env->prog->aux->func_info_cnt
remains the same since it represents user-supplied BTF data. Can this code
cause an out-of-bounds read on the func_info array if a diagnostic is
triggered inside a hidden subprogram? Should this verify that subprogno is
less than env->prog->aux->func_info_cnt before accessing the array?

> +	type =3D btf_type_by_id(env->prog->aux->btf, info->type_id);
> +	if (!type)
> +		return NULL;

[ ... ]

> +static void bpf_diag_print_source_annotation(struct bpf_verifier_env *en=
v,
> +					     int line_width, int indent,
> +					     const char *label,
> +					     const char *msg)
> +{
> +	char first_prefix[128], next_prefix[128], text[BPF_DIAG_MSG_LEN];
> +
> +	scnprintf(first_prefix, sizeof(first_prefix), "  %*s | %*s^-- ",
> +		  line_width + 4, "", indent, "");

[Severity: Low]
Since the indent comes from user-supplied BTF line info, what happens if the
source code has heavy indentation (for example, over 110 spaces)? Will
first_prefix truncate here and silently drop the "^-- " visual caret used
for alignment?

> +	scnprintf(next_prefix, sizeof(next_prefix), "  %*s | %*s    ",
> +		  line_width + 4, "", indent, "");
> +	scnprintf(text, sizeof(text), "%s: %s", label, msg);

[ ... ]

> +void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
> +			    char marker, const char *fmt, ...)
> +{

[ ... ]

> +	for (line_num =3D start_line; line_num <=3D end_line; line_num++) {
> +		const char *line;
> +		int row =3D line_num - src.line_num;
> +
> +		line =3D line_num =3D=3D src.line_num ?
> +		       src.line :
> +		       bpf_diag_find_source_line(env, src.file_name_off, line_num);
> +
> +		bpf_diag_print_source_insn_line(env,
> +						line_num =3D=3D src.line_num ?
> +						">>> " : "    ",
> +						width, line_num, line,
> +						&diag_insn[row + BPF_DIAG_INSN_CONTEXT],

[Severity: Medium]
When a diagnostic is triggered near the top of a file, start_line is clamped
to 1. Because the instruction layout is coupled to the source line loop
using the line_num difference, doesn't this skip iterating over the earlier
BPF instructions that were already correctly populated in the diag_insn
buffer? Could this drop valid instructions from the verifier log output,
making diagnostics harder to read?

> +						insn_idx, insn_width);
> +		if (line_num =3D=3D src.line_num)
> +			bpf_diag_print_source_annotation(env, width, indent,
> +							 label, msg);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D3
