Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913079;
	b=Ucjfp9tfRrBXuUFENs/nmgkaM5yp2gyKcUyBHtCBvtnmpF7cHouYBCG96MJaArZ/wsUH
	 dPvXa2I1PD7BitbdQ6zhj3GgN//dSz+9xL8DV+mx1OW+Q5EWkfIqMScydfewDIGbtWZrV
	 02RfjrROCLSa8xhIUf30WR49ohIpU5Op0MYXC0rnMcUD9JOAnpzwTPDh4MRiDTLakDKXf
	 fdp/RRstRVr60g7XZlofLutbSvQBaj4+00QvURgkuiHyjtddKNQkr23TdDl7DkfeNr5WR
	 H3eGHZQ0Eu5yLK2yavYUVPKuMjm37C7mWK6DFBUWJ+8TfIjqysC5B9yhcMvE3/axXXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jjGcLqLSpT1TELS2zikK9sk5Rkc+9/nweF6Eai9yQNM=;
	b=1D8OuNL4C+VgxfEWzPOpyLJ2puLerE4Lexrcsfq1kaMibatCJYoi5F3Vu/ERmbApQZ3U
	 11NqNkQPFxlZKetawrH8Y8kNNg47MEGY+N95Lu1JiUQx1m4jsIH9p+/dPyBs/NpedHnd+
	 ESpkEXEqzizfSBlYfdsOFzQ9FiZ3hA4nr8IVoPrd9x4gULoRiVpcryTyiwJ//OucSI9by
	 DW9rjwjefLM+3OHUKRWbpGCpYEid9whhlqESwca9/KXLLEXNhX5ANgtvR5BSofNmezDTv
	 0GoSR4WysywO9sLMaH2+IiwpvCmlEv1JF8a+UkDGHtxiQggsUpA4M3xIJX2UzDJbvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIB6Ijgc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B25606A31C;
	Tue, 17 Nov 2026 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIB6Ijgc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459CA1F000C5;
	Tue, 17 Nov 2026 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794913079;
	bh=jjGcLqLSpT1TELS2zikK9sk5Rkc+9/nweF6Eai9yQNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hIB6IjgchFEArgu4TdxRRlH9FQjxh+P/l/G8z/zfHYVP2aLUbn1XxGoUU5iSFixc0
	 kkcDnqBlFVhlsB05LqBeiSza6QSjBRd/Nh4JLe7sTOPOsJHGGthOOi0sxP8471EKfU
	 Qgf+isTgLQ8q48+x2T/UHQ/BKd76pWDuE4UzOTralFKNnp1CVrdP+WSA0imWfCz9V3
	 EQ2K+EY+wkpuLJ2/8Z8ZEU3j4BMSCwaCoir5o4OyEu8yGQcHAPlsJ+myT4bHYQ/wDk
	 hAwWTid4WwEB8nA0TDLkA9ucAY2uFEKkhMElVNhTFdyS4n8tbQ7tA0ntq3SR9+rAhl
	 yo/9nxbjV1zuw==
Message-ID: <sashiko-outbox-218682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 next 13/13] scripts/kallsyms: Reuse little-used
 compression tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261117103352.1244657-14-david.laight.linux@gmail.com>
References: <20261117103352.1244657-1-david.laight.linux@gmail.com>
 <20261117103352.1244657-14-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:57:57 +0000
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
- [Medium] scripts/kallsyms: missing syms update on split in
  uncompress_symbols()
--

commit 33aea03661ccead3785f7f56d31a3c8974eb8710
Author: David Laight <david.laight.linux@gmail.com>

scripts/kallsyms: Reuse little-used compression tokens

This commit reuses compression tokens that have few remaining references by
expanding them back into their component tokens or three-character strings
when a more common token pair is available.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 42a7c99585c56..976b525c4366d 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -855,6 +954,125 @@ compress_symbols(unsigned int token_idx, int compre=
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
> +			if (third_char) {
> +				token_add_symbol(token_index(p[1], third_char), sym_idx);
> +				p[2] =3D third_char;
> +				end++;
> +				p++;
> +			}
> +		}
> +		/* sym_idx is already in best_table[].syms from earlier. */
> +		table[sym_idx]->len =3D end - sym;
> +	}

[Severity: Medium]
Can uncompress_symbols() leave sym_idx missing from best_table[].syms for
token_first(token_pair) or token_second(token_pair)?

sym_arr_free_all() clears best_table[ch].syms.cnt when a token slot loses
all references or is uncompressed, while split_token() only checks that
first->str and second->str still concatenate to bt->str.  If a component
slot is freed and later reused such that first->str and second->str still
match bt->str (either reused for the same substring or for a different
length split of bt->str), its syms array only tracks symbols from the new
compression and no longer contains sym_idx where bt remained compressed.

Expanding bt back into those component tokens without adding sym_idx to
their best_table[].syms arrays triggers the errx() in check_best_refs(), or
leaves stale token bytes in table[sym_idx]->sym if that component token is
split again before check_tables() runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117103352.1244=
657-1-david.laight.linux@gmail.com?part=3D13
