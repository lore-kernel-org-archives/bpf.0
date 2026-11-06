Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999686;
	b=J2ID9v9+NvgGgUBrdJuRf9+znOWSTm663ATHt2zmW7mnW7kcSsueXhIIHXL8Fo5gVb0/
	 ifrgFTYmfxisqxKxR+WEi6ecQkWNDUbjxCt0qmLn9Xg+GlCBs4v0LaAYv+F01hmz5Ez0b
	 yg5Led59AQxDraZ+3pYY/6tKFI/E5kENeH/NlzvdCp2zOWm0anQhEhxEKSI1veomaQq1c
	 OdBVaiu3vn5ETKfQRLBYAhaNsZzCrEP+5fAOmd9oky6yTWz0HNF1EehPeggqvPsQgVALq
	 /nLuSNprrdx9Q66KmBNHCQ5g2NMtKUlz4BtzBVJFnh1QcphSL7gD+mIWuTkEJD+0s6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999686;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ngy3RUdS/H3H13OrG3SfTkRnA1e82pwnbyH7ubF7QgY=;
	b=CHYiY2m9/B/o5ZaMXcW0m5veYsJNCL+YiMqWFMIY5aCZWpS2udSnq/gEnSlEXxwhd1+L
	 4zccs2w5bixIJmm7JWFSWTDlbWwDo7a4LXb1GJ3NhoMfRZ0rd3ZD+eR+ph5VX7FRsgNVt
	 +EhlkGKs6s+gCOch5veOumbIGQ0JT57fBdQuMTnyWuJevJ3ZI7QmraVpRcPD9y1RLOR+H
	 h30Wu/hKYC0LcrXrZjHyB9MqkK/rl4uUWRhKB7Nlf645Ga1kekvwZgktkhorS+J0EV5zZ
	 YnrGam8aezFjxPlOxEBqYgjAufsSoe0iUUmZNB5kYJ97QMZ/5ponCnXMLlBw1HbyG3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMQqpDbw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670E606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMQqpDbw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC62D1F0089F;
	Fri,  6 Nov 2026 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999685;
	bh=ngy3RUdS/H3H13OrG3SfTkRnA1e82pwnbyH7ubF7QgY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HMQqpDbwXar97qY5ykKI9GpXZe4GyQgiWQ0Jb8CmrLi73JI7J4cFRe/yH771S9n8j
	 nm7m1/WLCJ9boxfxCvhk64PM8iUe2reFJkgybxeMKJxCYqD4tpGtVUD8XV8m5i4wLw
	 7eQqwwyEA9dLS6kiaIwXDPJM9DHNKGF89xn8BY4SF3WegFdBJOvYDEXqpPmdZkV0Zv
	 1jo/3qM0sDRQ5J33Jp1Jcq+26rM+PtBYF9YzoTXAEN79gLO8FQwdfe/NuBlooHuISS
	 DODkkpYxtSON5oxXhV8fhiBxoN8gXlGbgnHIrXfxJ5z/hLyvgag25OnI1pwOw76vHM
	 gKh8tssCRzoaA==
Message-ID: <sashiko-outbox-202290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 15/18] resolve_btfids: Tag fmod_ret
 candidates as targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106210314.1767267-15-a.s.protopopov@gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-15-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 21:14:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: resolve_btfids: choose_functions() skips records on
  duplicate names
--

commit 592223df16723596e1694e3167578ff1cfdd0320
Author: Anton Protopopov <a.s.protopopov@gmail.com>

resolve_btfids: Tag fmod_ret candidates as targets

This commit reads candidate records from .BTF_fmodret_candidates in
resolve_btfids, filters eligible traceable functions, and emits
bpf_fmodret and bpf_fmodret_retval: BTF declaration tags for them.

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfid=
s/fmodret.c
> new file mode 100644
> index 0000000000000..1c29ab9a8616a
> --- /dev/null
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> +/* Choose the targets among the functions and describe them in RESULT */
> +static int choose_functions(struct elf_function_list *functions, const s=
truct btf *btf,
> +			    const struct btf_func *btf_funcs, size_t nr_btf_funcs,
> +			    const unsigned char *buf, size_t ptr_size,
> +			    unsigned int encoding, struct fmodret_retvals *result,
> +			    struct fmodret_stats *stats, int verbose)
> +{
> +	size_t i =3D 0, j;
> +
> +	qsort(functions->functions, functions->nr, sizeof(*functions->functions=
),
> +	      cmp_elf_function_name);
> +	for (i =3D 0; i < functions->nr; i =3D j) {
> +		const struct elf_function *f =3D &functions->functions[i];
> +		size_t record =3D chosen_record(f);
> +		const char *reason =3D NULL;
> +		unsigned int flags =3D 0;
> +		struct fmodret_retval *r;
> +		__u32 size;
> +		int id =3D 0;
> +
> +		for (j =3D i + 1; j < functions->nr; j++)
> +			if (strcmp(f->name, functions->functions[j].name))
> +				break;
> +
> +		if (!f->nr_strong && !f->nr_weak)
> +			continue;
> +		if (record =3D=3D NO_FUNCTION) {
> +			stats->ambiguous_body++;
> +			reason =3D "ambiguous-body";
> +			goto rejected;
> +		}
> +		/*
> +		 * A strong definition without values has no record. If it
> +		 * replaced a weak one, only the record of the weak one points
> +		 * to its body.
> +		 */
> +		if (!f->nr_strong && !f->weak_symbol) {
> +			stats->overridden++;
> +			reason =3D "overridden-weak";
> +			goto rejected;
> +		}
> +		if (!read_elf_value(buf + record + 16 + ptr_size, 4, encoding))
> +			continue;
> +		stats->with_values++;
> +		flags =3D read_elf_value(buf + record + 12, 4, encoding);
> +		if (j - i !=3D 1) {
> +			stats->ambiguous_name++;
> +			reason =3D "ambiguous-name";
> +			goto rejected;
> +		}

[Severity: Low]
Does choose_functions() skip candidate records on functions[i + 1 .. j - 1]
when multiple ELF functions share the same name?

add_record() attaches each record only to the functions at that specific
location, and choose_functions() then groups all functions with the same
name into [i, j) and advances with i =3D j.  If functions[i] (the lowest
address instance, such as a static helper in another translation unit) has
no record or zero values, the continue statements skip the rest of the
group before reaching the j - i !=3D 1 check, leaving stats->with_values and
stats->ambiguous_name undercounted and omitting the verbose rejection log
for records on functions[i + 1 .. j - 1].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106205523.1765=
622-1-a.s.protopopov@gmail.com?part=3D15
