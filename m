Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247998;
	b=NhWEkzpq0QDhDWSk0ICowS1ItRigL6vg4ylcXFoCsR23X8tAVXaNj2DfKNq5XbXjh6lG
	 GY2aQcaIC8P+v3P6UlGP9XhDAJ2t65dX+f4DMp+BDR9Kid6ToylYdC2OifagNuvEWstcC
	 Jd1+x4B7ZsuzqPLxAK3arBYDn5tKnPYHvRSdYgu3uJqrXzASIaP/y1L83NRCJF1Mz6d46
	 oFAxdchj0T4ZrjDBrJ7Qgl4QuZwgoopDkl30Y7BifCYS4FwsgO3vwONJiKL4QYvCLlcRw
	 UPNqqnzFxjzW2dot2vEBX60zTgXyFY7b7kDE6XEXlb7WFSRB7CzPgBnZiFXSP/wDyVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+A7vD8wKU1LYvfRiNl39tlXu8zi4fga1ZP/mRITyNS0=;
	b=4CBjQN7lDcA2LZz2GSSM3T3y8NLiYjuVrG/KOAOPX7Z7bhd12JFcrFq0yTfWwoJy6dF2
	 Mxv2PdqiQWO0/6m0+XwmF1x3vf4/RzgDd21zyyb4S1wLL9GyAx8Hqixo7NgW3FwMqWd7Y
	 6cUM1aeHeeT8xfSW6Oekc/LcVyHBfg6azHCuUkpEYVq0ofT/eveDyLldsWhJrKY5k8aqq
	 79QPRSySxeQ9OYQDP+yrN9XZpk8jSX4sdlwR6Vsj5O5cfqLyCk4R3mMX08mph65enwj4Y
	 GU6Mpq9A8OPzYQJSwU+3PzCbWfYU5dbzI+zqzE5fb20j2TKblXbAKcu1DEPkB7OBE2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyc5JRIm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6486606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lyc5JRIm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4186E1F0089F;
	Mon,  9 Nov 2026 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794247997;
	bh=+A7vD8wKU1LYvfRiNl39tlXu8zi4fga1ZP/mRITyNS0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lyc5JRImhm/PstgfjChC0hqzI2w5TNimOMnHoJaR53+5LjwelyCpqxsHs+bxz7waN
	 +N9LeWJo5AevzQZUDM2zTOurlZPCI+aNilgejbY4kf6bOwDk24+Jrdvp309ke0jFxq
	 Xy2nE44JP1ryzYQXF1NIpyjEWOTBNLW4mTKH3gaM9mNPukHSsIWkrHBpfgryOuDQ6y
	 55yBFqKllfCaAgZKdAEaXUAqEPjTO5IPEsk4SiON5ekkqomnnkKOotBnIQJ6w4Ob6V
	 e5iYtXozo7TK6K93jcz59N+yfw1CMom2nH209vUJDrkl/McMe+HkgZ8A++Stgp/StI
	 b/eFr/ZY23AJg==
Message-ID: <sashiko-outbox-205381@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 15/18] resolve_btfids: Tag fmod_ret
 candidates as targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261109170550.141443-16-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
 <20261109170550.141443-16-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:13:16 +0000
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
- [Low] resolve_btfids: skipped duplicate-named functions in
  choose_functions()
--

commit 51f98882bd7c33a728dede77756350958f73cb62
Author: Anton Protopopov <a.s.protopopov@gmail.com>

resolve_btfids: Tag fmod_ret candidates as targets

This commit teaches resolve_btfids to parse .BTF_fmodret_candidates
records emitted by the bpf_scan_ir plugin and tag eligible functions in
BTF with bpf_fmodret and bpf_fmodret_retval:<values>.

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfid=
s/fmodret.c
> new file mode 100644
> index 0000000000000..df44b93eea734
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
Does advancing i =3D j while only inspecting functions->functions[i] skip
candidate records on functions->functions[i + 1 .. j - 1] when multiple
static functions share a name?

collect_elf_functions() gathers all defined STT_FUNC symbols regardless
of whether they have an fmodret record.  If functions->functions[i] has no
record (or zero values) while a later function with the same name in
[i + 1, j) has a record with values, the continue statement jumps to j
without counting the remaining functions in stats (such as
stats->with_values and stats->ambiguous_name) or logging the
ambiguous-name rejection when verbose > 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109170550.1414=
43-1-a.s.protopopov@gmail.com?part=3D15
