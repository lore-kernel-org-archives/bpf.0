Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4552931E9
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580149; cv=none; b=VAYq9/upVwtyI0GyMBWbLDNaHwUk00Xld5TpwMBME6Y+t2t9C+6/hUGHLCF1yuLufC+WS5ziXpBTfZVzcJSOJL1GttOHZSgAbZPNIV8TbKfMYHl/UA9i72xOxj0UNUKkc2fN/VmB0G1du1F/zHJScEdgygHFjJAaJwdIYouMdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580149; c=relaxed/simple;
	bh=69I0hqJEFq7NnBEdjux4L25UKNPUnqYSo4tv9al7PAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EEKdubjCvNu123sqXKDKTDk8kUJ6oJNQSiqBGX9lsU/4uIzIFQxSdIZIFAFo1lB0PIblMsjE3u+/vLjUXw78rJAIdAZgJOJDeI752rOSEe57ukeZkRyCQnS9Hmq+AVJPko85yUvD0/8QuofiIq9dYl+fg4JoHVkKH0Rrbzz9aJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+VHzSLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+VHzSLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11DB1F000E9;
	Thu, 13 Aug 2026 00:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580148;
	bh=eRlKgzwNPJ2dTTS5oZJWuTuPopvIwlQiLxMGjEmxlgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O+VHzSLIFHm1RVUAuVltl1gbLEg4FajCzotAg8gZ9CSFyv7i/R94T1J3tLX5GmQTS
	 q1kOU7dP9HcH//tagGz653miQTgCAcOT5M12+VWd5dzwRLltdFyT7RysM3KPg22iJc
	 lr8v5lXAMaR+mFD1Ucv5cV0x3uuqhxpaXQhrxgIO+Xfwx0MnFRiQAA8gx0qADTXQm+
	 wPZpRhma5HseEPkDn6RmtdWWARfcuh9RZYJa81Rs7eJKSSQLZGgfwUV2/h+HRjXgKU
	 V3+xJEUjhlsdUtYde4kmvOsP4OtdFZ+kLObfocYFlAGyd0jRBGTkA5/017rskFejMm
	 J4m9ge9WPJw4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 02/16] bpf: Add source and instruction
 diagnostic context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812233326.3575958-3-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
 <20260812233326.3575958-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 00:15:47 +0000
Message-Id: <20260813001547.C11DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_disasm_kfunc_name() will trigger a NULL pointer dereference or=
 mutate verifier state if diagnostic formatting is invoked before the add_k=
funcs() pass completes.
--

--- Patch [2]: [PATCH bpf-next v4 02/16] bpf: Add source and instruction di=
agnostic context ---
commit ef91626322111071ba03bd2ef6640700c748dd5f
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add source and instruction diagnostic context

Teach verifier diagnostics to annotate an instruction with BTF source
line information and nearby BPF instructions. The renderer keeps source
text in a fixed-width lane and prints instructions in a stable right-hand
gutter.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -35,6 +245,182 @@ static void diag_write(struct bpf_verifier_env *env,=
 const char *fmt, ...)

[ ... ]

> +static const char *disasm_kfunc_name(void *private_data, const struct bp=
f_insn *insn)
> +{
> +	struct disasm_ctx *ctx =3D private_data;
> +
> +	return bpf_disasm_kfunc_name(ctx->env, insn);
> +}
> +
> +static void format_disasm_line(struct bpf_verifier_env *env, int insn_id=
x,
> +			       struct disasm_line *line)
> +{
> +	struct disasm_ctx ctx =3D { .env =3D env };
> +	struct bpf_insn *insn;
> +	const struct bpf_insn_cbs cbs =3D {
> +		.cb_call =3D disasm_kfunc_name,
> +		.cb_print =3D disasm_print,
> +		.private_data =3D &ctx,
> +	};

[Severity: High]
Can this sequence trigger a NULL pointer dereference or unsafe state
mutation?

If bpf_diag_source() handles an error during early structural validation
(before add_kfuncs() runs), it calls format_disasm_line() to print nearby
context instructions.=20

If any instruction in this window is a module kfunc call, it invokes the
bpf_disasm_kfunc_name() callback shown above, which eventually cascades into
__find_kfunc_desc_btf() in kernel/bpf/verifier.c.

__find_kfunc_desc_btf() then executes:

tab =3D env->prog->aux->kfunc_btf_tab;
b =3D bsearch(&kf_btf, tab->descs, tab->nr_descs, ...);

If the kfunc BTF table hasn't been allocated yet, wouldn't dereferencing
tab cause a panic?=20

Additionally, if the table is only partially initialized, wouldn't
__find_kfunc_desc_btf() mutate the table by appending and sorting new
entries during what is expected to be a read-only logging operation?

> +
> +	line->idx =3D insn_idx;
> +	line->valid =3D false;
> +	seq_buf_init(&ctx.seq, line->text, sizeof(line->text));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812233326.3575=
958-1-memxor@gmail.com?part=3D2
