Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5761379C5D
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062295; cv=none; b=ifMtusCgPEm7gagAYebeqrZPggqcEswTeK6RgrPRQXtgi5kJdqOFdh4/sIjEtpIQomLC1IEheIYmK+MTYOcChCA2w2Cp6BZQ4BUKnp4v/5gnCi54kAgIjdaVqu+hpiJjWP5GQ3BvmU7laZld4iiTGgTJObNgK5UMKaInrMBAzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062295; c=relaxed/simple;
	bh=IsR1IqMI7MLoZRkA7rYrydkp9q7dGtbmu0DkcOb8Nqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n2a+Q9nkwYcfwq+38XZ9gzpYrJcKsIuZoXizqT26cHEBCuDppElQLodeU1e1CY62Jczv0jOZuZeBD1dT5dY+oeRCkkO1Hlt+JD+mrrhxoABlKvVVOih3rzRrDSb70cn5O7yAIiAws9fwSefC6WYe1iF3c4ElczSg4tk2AC06Xcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWdOoMz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWdOoMz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC8D1F000FF;
	Tue, 22 Sep 2026 07:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790062293;
	bh=yFswFrlocUY+tvKatIXjUTNmnaURjbaEiXwbvBM/+lU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWdOoMz1fFlo0QRrXdAEha7R8PUusw3LHTOCMcoXefIATpgjMzho/9lv4EDyct65Y
	 C0+I7qeVgecHDHAAYJeNSy/6Ys78F+aVslYq86QgTheKdTSvbyPIlge0g71cA6Sysi
	 /3zXquPGqbSc4XrhMgj0B8ZlRRIaRe3hCrha+oWraU6Ev0bOkRwxnYAfNoro7rD5G/
	 n5fzAJkEX/JV7wFeTAx6QYAkXhknEToLoHW6GGwMDk2xeZPtnnVsG0OPtmQ4LLwNQK
	 PbXOmhJFjqwEk3KFz7OcmVIe6TwCMvs90+s8TZORRREIgVYZWKcUH3uO5h6Tr96KVS
	 bDpIlC9u3HiBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] kallsyms: Add dynamic lookup index for batch
 resolution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-ksyms-tune-v2-2-a333ee31eac7@gmail.com>
References: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
 <20260922-ksyms-tune-v2-2-a333ee31eac7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 07:31:32 +0000
Message-Id: <20260922073133.5AC8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kallsyms: use-after-free on dyn_kallsyms_offsets in lookup paths
- [Low] kallsyms: undeclared get_symbol_data() causes build failure
--

commit ab1fc0aa56a3930399c450aad78232a641c6e73f
Author: Jim Cromie <jim.cromie@gmail.com>
kallsyms: Add dynamic lookup index for batch resolution

This commit introduces a dynamically allocated lookup index for kallsyms to
accelerate batch symbol resolution. The index is built on-demand in transie=
nt
RAM and freed when the batch concludes, falling back to a linear scan
otherwise.

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index b9e573e9a10b9..862a6b773ac5e 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c

[ ... ]

> +static u32 *kallsyms_build_offsets(void)
> +{
> +	const u8 *name =3D kallsyms_names;
> +	u32 *offsets;
> +	unsigned int i;
> +
> +	offsets =3D kvmalloc_array(kallsyms_num_syms, sizeof(u32), GFP_KERNEL);
> +	if (!offsets)
> +		return NULL;
> +
> +	for (i =3D 0; i < kallsyms_num_syms; i++) {
> +		unsigned int len;
> +		const u8 *data;
> +
> +		offsets[i] =3D name - kallsyms_names;
> +		data =3D get_symbol_data(offsets[i], &len);

[Severity: Low]
Does this cause a build failure? I noticed that get_symbol_data() does not
seem to be declared or defined in the codebase at this commit. Even if it is
introduced in a later patch in the series, each commit should compile
independently to preserve git bisectability.

> +		name =3D data + len;
> +	}
> +
> +	return offsets;
> +}

[ ... ]

> +/*
> + * Find the offset on the compressed table given an index in the
> + * kallsyms array.
> + */
> +static inline unsigned int get_symbol_offset(unsigned long pos)
> +{
> +	u32 *offsets =3D rcu_dereference_raw(dyn_kallsyms_offsets);
> +
> +	if (offsets)
> +		return offsets[pos];

[Severity: High]
Could this lead to a use-after-free when kallsyms_lookup_batch_end() tears
down the batch?

Because rcu_dereference_raw() is used here, static analysis and lockdep=20
cannot verify whether rcu_read_lock() is held. Readers like the=20
/proc/kallsyms seq_file iterators (e.g., reset_iter()) or exported APIs=20
(like lookup_symbol_name() or kallsyms_lookup_buildid()) can call this=20
function in preemptible contexts without RCU protection.=20

If a reader is preempted after dereferencing the pointer but before
accessing the array element, and another thread completes=20
kallsyms_lookup_batch_end(), synchronize_rcu() will not wait for the=20
preempted reader, which will then access the freed array.

> +
> +	return get_symbol_offset_marker(pos);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-ksyms-tune=
-v2-0-a333ee31eac7@gmail.com?part=3D2
