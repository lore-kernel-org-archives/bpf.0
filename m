Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A746DFF2
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028503; cv=none; b=WVCSIU5xMjHCCdnY2yu/BshcEZ2++wWnAm6+YkvcUx/7jAEeuPkXLrKk6GAPUkneR/mRCeIZ9sMKdJ4wL+9FTqy0ZeNuRgf/ZG6gZ9nVoQOrUf9j0mzv7E+pavxPnpzoTzkZe2QKMlzGm+HP8Y69XtqURZibXLN/7h9iYJvM5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028503; c=relaxed/simple;
	bh=0iugY0XpCy1T76NJBDJj3Bb/5qtMaUupLY+llj0jkmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mp788pPKvkRyURXJZkWI+40h69Du8zusHIztS5veFe6ldsDfHf8Y//sh6F7lw35xi6PfuGeX7KYXA1JpoA0eSuTrVa4abSWquqtfLHNNu+SW5VjKzaQGofZI/oCiT9hazv2NeA96sQkXaxIGpVVZxG0a0xja7f6YdhGQtc/c/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyPUyQlZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyPUyQlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B834E1F000E9;
	Thu,  6 Aug 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786028501;
	bh=e0jkZ3Gf6GhiYldqqZjpJHT9UzjLICgOhSpjoXm2/g8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iyPUyQlZrX//0gawY8RvBYSKfzMuGjDX+Fw2lic38Yh4qrb+lkkTnAjDNpOKzJnTm
	 IyULJDbX7yiB2HDqZtiRD1pazsVdNvMg9lmHnxmx0eFoJpUEdxzNhHpdCY9Cq2aDpL
	 G1pfAPJat9TaamgmrbXzrNniSJijVneTrJ41Mi8sMJKiSzVBkTSfpjSIagrRWJg/vj
	 3LLpqsc865crBGjj2CioDYjIpzrR3VG84slItAi/t/20EBHpmocBjyUQxCGOBLaulj
	 /RAXJP46GfjLIaHPd/9a78/uCEqBmG1XcX1XyqHPWBA2FRZUbe8Xib+zPzls0hzGOS
	 tOLX0PX82xR9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/6] bpf: Reject load-acquire from pointers
 requiring fault protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806143924.319238-1-daniel@iogearbox.net>
References: <20260806143924.319238-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:01:41 +0000
Message-Id: <20260806150141.B834E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The verifier fails to convert BPF_LDX instructions to BPF_PROBE_ME=
M when paths with PTR_TO_MEM and PTR_TO_BTF_ID | PTR_UNTRUSTED merge, allow=
ing unhandled page faults.
--

--- Patch [1]: [PATCH bpf-next 1/6] bpf: Reject load-acquire from pointers =
requiring fault protection ---
commit 7bfb4a68d477eb7f566fc7d106ee4703a225c192
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Reject load-acquire from pointers requiring fault protection

This patch prevents BPF_LOAD_ACQ instructions from being used with
pointer types that require exception table entries for fault protection.
It rejects untrusted pointers and bare PTR_TO_BTF_ID pointers since the
JIT does not emit exception tables for load-acquires, which could result
in a kernel panic on a page fault.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d952bd95cbb7b..78637faf13508 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -4921,6 +4921,30 @@ static bool is_arena_reg(struct bpf_verifier_env *=
env, int regno)
>  	return reg->type =3D=3D PTR_TO_ARENA;
>  }
> =20
> +static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
> +			       struct bpf_insn *insn)
> +{
> +	const struct bpf_reg_state *reg =3D reg_state(env, regno);
> +
> +	/*
> +	 * A BPF_LOAD_ACQ is not rewritten to a BPF_PROBE_MEM load by the
> +	 * verifier, unlike a regular BPF_LDX. The JIT would emit a plain load
> +	 * with no exception table entry, so a fault (e.g. NULL deref) crashes
> +	 * the kernel instead of being handled.
> +	 *
> +	 * Reject the source pointer types that a BPF_LDX would have had that
> +	 * fault protection applied to, i.e. the ones bpf_convert_ctx_accesses()
> +	 * turns into BPF_PROBE_MEM: a bare PTR_TO_BTF_ID and any PTR_UNTRUSTED
> +	 * pointer (untrusted btf ids, untrusted MEM_ALLOC, rdonly untrusted
> +	 * memory). A PTR_TRUSTED pointer is not among them, is not converted,
> +	 * and stays allowed. Same for the other flagged PTR_TO_BTF_ID variants
> +	 * (MEM_ALLOC, MEM_RCU, ...), hence the exact match on the base type.
> +	 */
> +	return insn->imm =3D=3D BPF_LOAD_ACQ &&
> +	       (reg->type =3D=3D PTR_TO_BTF_ID ||
> +		(type_flag(reg->type) & PTR_UNTRUSTED));

[Severity: High]
This is a pre-existing issue, but since the comment mentions pointer types
that bpf_convert_ctx_accesses() turns into BPF_PROBE_MEM, does it currently
miss handling PTR_TO_MEM | PTR_UNTRUSTED?

When paths with PTR_TO_MEM and PTR_TO_BTF_ID | PTR_UNTRUSTED merge,
save_aux_ptr_type() produces PTR_TO_MEM | PTR_UNTRUSTED without MEM_RDONLY:

kernel/bpf/verifier.c:save_aux_ptr_type() {
    ...
			if (is_ptr_to_mem(type) || is_ptr_to_mem(*prev_type))
				merged_type =3D PTR_TO_MEM;
			else
				merged_type =3D PTR_TO_BTF_ID;
			if ((type & PTR_UNTRUSTED) || (*prev_type & PTR_UNTRUSTED))
				merged_type |=3D PTR_UNTRUSTED;
			if ((type & MEM_RDONLY) || (*prev_type & MEM_RDONLY))
				merged_type |=3D MEM_RDONLY;
    ...
}

However, in kernel/bpf/fixups.c:bpf_convert_ctx_accesses(), it seems this
exact type combination is not converted to BPF_PROBE_MEM because the switch
only handles the MEM_RDONLY case:

kernel/bpf/fixups.c:bpf_convert_ctx_accesses() {
    ...
		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
		case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
			if (type =3D=3D BPF_READ) {
    ...
}

Could this lead to an unhandled page fault and kernel panic if an untrusted
pointer and a valid writable memory pointer (like from a dynptr) reach the
same BPF_LDX instruction, bypassing the fault protection?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806143924.3192=
38-1-daniel@iogearbox.net?part=3D1
