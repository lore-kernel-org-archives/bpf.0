Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404271;
	b=rwqLQ0yEzbpaeEoV1HARC/MMHh35D8TRnx8LmjD8Q8l+KnzeztdwNy578GE5eKvHmDbf
	 narFh8wzQUWcyGJ46YZVWN6uy2+6m6JV//DGRClc+yboOxSYYQuBWiWs3u+fGkhSTsV8e
	 Sr6iz2P1JlC+LjS9QZshy3v9uEq/U7MgPU03ubMl9xvoIiF/E1kf5RA3ervJEMeimBvwG
	 F3UZo/mwCZjAR/3hkGUjD3e8CFPJDceQFPnjBqFrqBSh/6j2pPVetkk3WUwuvYdfNNzJ4
	 7NnCp/yKfS/zxWbBHXMdR1nq1Ez4iLMc21ojwApvRNKItkPBSEa4P+nTUvWPs3RP11w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AR5YsUUmvUA8tIYtuqC5XeoOdiPG47ht+rYE45AwySc=;
	b=VpvF2aaYX875bMGsknFcYmSWl797aVNlUs3adT9AIZy7hqx7msJ4mqbx4uZLJOFamSpR
	 rzHZU5+oq/68I23mYhEx2No+HCwjbgtWZ+JTudqYgucJhE3jhV82iywIHiKrdLjbS7nvm
	 2lHPqwFS/8Yff7GcQFPrDhcgXwRWB3Pm1lyWkLeyJdcsenf/n2Ow85cGlNonBJh4JvKBj
	 B2IvKhkIDpYkF2fWBTFigqZ4OJXRj+9VTezI0E6eI/Gem0SVujGVMQmEssjIsfcvk2N98
	 mreMTY3ICwco5FhMdQ5Z3Ifdi5Dkp82RggBhwLaZjWJrRVVyhqMgaRaoMV3x8rPq1Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXHTRiN1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B5606A31C;
	Wed, 11 Nov 2026 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXHTRiN1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686C21F00A06;
	Wed, 11 Nov 2026 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404271;
	bh=AR5YsUUmvUA8tIYtuqC5XeoOdiPG47ht+rYE45AwySc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TXHTRiN1HAtBNmzusFJ6ayIyK8a0YoucU5ZEF8p1Ki+NJUC5RbbD54/U1rZj3Rg6y
	 8qjxX38BMXU0kLPoE4XMH2yWCFrfrZiZoxyyEIlCIihlb1J0dXO5E5joSjEbQhI9Ir
	 TAsfd5ZJZTcis1PvyHqNOYs80LzOqHy0/WbA97Zo4pY0/LSz7LDptBd6kxU35berq7
	 fY7hh+18P7d8tEEftQEzgTA4nW+sCj4cuFTvmh/m7bCFZm6m/YshHbOmQoaUpLF7Zs
	 zqNRGUgzOSqCTmN40bfBPlGvrH+e7CveI8fjzbaCsYyywUkofwL7k0hKGHGLBK4Wyb
	 nC/VC8eZMeTrw==
Message-ID: <sashiko-outbox-209079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 next 13/13] scripts/kallsyms: Reuse little-used
 compression tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261111115911.1142000-14-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
 <20261111115911.1142000-14-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:37:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] scripts/kallsyms: missing syms update on split in
  uncompress_symbols()
- [Low] scripts/kallsyms: premature 3-char token disqualification in
  split_token()
- [Low] scripts/kallsyms: unreset syms.cnt and splits in
  sym_arr_free_all()
--

commit f874410df5dfe77ff678c52a66379728c6ebf5ba
Author: David Laight <david.laight.linux@gmail.com>

scripts/kallsyms: Reuse little-used compression tokens

This commit reuses compression tokens that have few remaining references by
expanding their occurrences in the symbol table back into their component
tokens when a more common token pair is available.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 95ccde80359f2..dc69b802478ad 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
[ ... ]
> @@ -850,6 +894,123 @@ compress_symbols(unsigned int token_idx, int compre=
ssed_chr)
>  	return subs;
>  }
> =20
> +/* Change every occurance of idx back to token_pair/triple.
> + * This extends all the symbol table entries but frees up a token. */
> +static __attribute__((noinline)) void
> +uncompress_symbols(unsigned int token_pair, int idx)
> +{
> +	struct best_table *bt =3D best_table + idx;
> +	unsigned int sym_idx, len;
> +	unsigned char *sym, *p, *end;
> +	unsigned int substitutions;
> +	unsigned int third_char;
> +
> +	third_char =3D token_pair >> 16;
> +	token_pair &=3D 0xffff;
> +
> +	for (int j =3D 0; j < bt->syms.cnt; j++) {
> +		sym_idx =3D bt->syms.sym_indexes[j];
> +
> +		sym =3D table[sym_idx]->sym;
> +		len =3D table[sym_idx]->len;
> +		end =3D sym + len;
> +
> +		for (p =3D sym; (p =3D memchr(p, idx, len)); p +=3D 2) {
> +			len =3D end - p - 1;
> +			if (len) {
> +				if (third_char) {
> +					/* Adding three characters */
> +					adjust_profit(sym_idx, idx, third_char, p[1], p[1]);
> +					memmove(p + 3, p + 1, len);
> +				} else {
> +					adjust_profit(sym_idx, idx, token_second(token_pair), p[1], p[1]);
> +					memmove(p + 2, p + 1, len);
> +				}
> +			}
> +			if (p !=3D sym)
> +				adjust_profit(sym_idx, p[-1], p[-1], idx, token_first(token_pair));
> +			token_add_symbol(token_pair, sym_idx);
> +			p[0] =3D token_first(token_pair);
> +			p[1] =3D token_second(token_pair);
> +			end++;

[Severity: Medium]
Does uncompress_symbols() need to add sym_idx back to the .syms arrays of
multi-character component tokens when expanding idx into token_pair?

If a multi-character component token was previously split (clearing its
.syms.cnt) and later re-compressed so that first->str and second->str
again concatenate to bt->str across a different subset of symbols,
restoring token_first(token_pair) or token_second(token_pair) into
table[sym_idx]->sym without adding sym_idx to its best_table[].syms array
leaves that symbol untracked.  A subsequent split of that component token
will then miss table[sym_idx]->sym and leave stale token bytes behind when
the slot is reassigned.

> +			if (third_char) {
> +				token_add_symbol(token_index(p[1], third_char), sym_idx);
> +				p[2] =3D third_char;
> +				end++;
> +				p++;
> +			}
> +		}
> +		table[sym_idx]->len =3D end - sym;
> +	}
> +
> +	substitutions =3D bt->refs;
> +
> +	bt->refs =3D 0;
> +	bt->syms.cnt =3D 0;
> +	sym_arr_free_all(idx);

[Severity: Low]
Should sym_arr_free_all() reset best_table[ch].syms.cnt and
best_table[ch].splits instead of only clearing bt->syms.cnt here?

When optimize_result() frees a zero-reference token via sym_arr_free_all():

scripts/kallsyms.c:optimize_result() {
    ...
		if (!(first->refs -=3D refs) && first->len > 1)
			/* There are no references left, reuse the token. */
			to_process[idx++] =3D sym_arr_free_all(token_first(best));
		if (!(second->refs -=3D refs) && second->len > 1)
			to_process[idx++] =3D sym_arr_free_all(token_second(best));
    ...
}

best_table[ch].syms.cnt and best_table[ch].splits retain their values from
the old token.  When that slot is reused by compress_symbols(), new symbol
indices are merged into the stale .syms list (causing uncompress_symbols()
to scan unrelated symbols if the new token is later split), and the new
token inherits the prior token's split count (which may already be
max_splits).

> +
> +	token_profit[token_pair] +=3D substitutions;
> +	best_table[token_first(token_pair)].refs +=3D substitutions;
> +	best_table[token_second(token_pair)].refs +=3D substitutions;
> +
> +	if (third_char) {
> +		best_table[third_char].refs +=3D substitutions;
> +		token_profit[token_index(token_second(token_pair), third_char)] +=3D s=
ubstitutions;
> +	}
> +}
> +
> +static int split_token(unsigned int profit)
> +{
> +	struct best_table *bt, *first, *second;
> +	const unsigned int max_splits =3D 10;
> +	unsigned int i, best_token;
> +	int best_ch =3D -1;
> +
> +	for (i =3D 0; i < 256; i++) {
> +		bt =3D best_table + i;
> +
> +		if (bt->len =3D=3D 1 || bt->refs >=3D profit || bt->splits >=3D max_sp=
lits)
> +			continue;
> +
> +		/* Ignore tokens where the original parts have been reused ... */
> +		first =3D &best_table[token_first(bt->token)];
> +		second =3D &best_table[token_second(bt->token)];
> +		if (bt->len !=3D first->len + second->len ||
> +		    memcmp(bt->str, first->str, first->len) ||
> +		    memcmp(bt->str + first->len, second->str, second->len)) {
> +			/* ... unless they are three characters. */
> +			if (bt->len !=3D 3 || bt->refs * 2 >=3D profit) {
> +				/* Don't consider again */
> +				bt->splits =3D max_splits;
> +				continue;
> +			}

[Severity: Low]
Does setting bt->splits =3D max_splits when bt->len =3D=3D 3 and
bt->refs * 2 >=3D profit permanently disqualify 3-character tokens that only
lost to a better candidate in the current scan?

As the loop iterates, profit is lowered to the best candidate's cost
(bt->refs or bt->refs * 2).  Any later 3-character token whose original
components were reused and whose bt->refs * 2 is not strictly less than
that running minimum gets bt->splits set to max_splits, preventing it from
being split on subsequent calls to split_token().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111115911.1142=
000-1-david.laight.linux@gmail.com?part=3D13
