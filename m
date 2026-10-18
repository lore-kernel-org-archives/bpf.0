Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827B3CF1FC;
	Sun, 18 Oct 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339513; cv=none; b=r4oPGhc7H6gaGyfwaB6hOZ47gPJYyMh1gxhjYIEgEInbnLInp0H8PqRBPCp0GaTO8PrkL5+j41aHm4FPD83bH0wB33HzMI6iqy5T9cX5ZcyUvd4uQhT0yEPJcRiD3vbBgTfqDS/REXC+flqgbjSP2RiWOiiHuhMozw4oC9JDcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339513; c=relaxed/simple;
	bh=3rQaavD7BjJyss81S8coMCVHLNRF2Cjq5iNfVoUhNOg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=h/kXW2/Q9cGdL/8gKM7pyrp5O9oG7nDjUQTol3IU2NtfActmFFknqr2pH2clZAnzceN20OFUPg5xe5zP1Iol/H99orGDXC/3XudtGPpoL6yrgdVfFHIFM/q0qoh9zF45QI+bTlBjTrsrqx3Px7mXuYuPLT5lZ5/aYCeKgRxENNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ85Koz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ85Koz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1591F000C5;
	Sun, 18 Oct 2026 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792339511;
	bh=KD+CTp3CWinqNBFDnNf5cvIVWM7ncI9URL/mMzffLPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQ85Koz3+5QHDnsQB0zLKgE4UFIFXWls0DZeDCk7/Y6U/5RbBTp/PW3loUXr5DQEN
	 7wNHu73IGrmcT0PG89hXr1d1WTIChryd5+LzhB8Jgub5VS+p/Y1yTe2Lt2jqu/FP/X
	 9Y7lyqBIfAoyn7adztgZxGmpY/6a1i7QSRNg1VFkkMQnmYXr0xc1E0HTURBwdxRMgi
	 OMwYgRmf1k6lFuBomvlTvv0OGJ9tIEMsXD+tO+VrheUNice0IfSP+jW9FDvfZndmLs
	 C3HhwewfZO4rGHhvMZIQFr3SX3Janc+ty89Ikuy/Y2uJRof4E0Zzt09m/NiW7H+2rI
	 hT0TWPskoUbPw==
Message-ID: <sashiko-outbox-176259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/15] kallsyms: scripts/kallsyms: Improve compression
 by about 2%
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Kees Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261018155206.132411-16-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
 <20261018155206.132411-16-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:05:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kallsyms: infinite loop in optimize_result() on self-overlapping=
 token pairs
--

commit 36121744ef0b7fd951486247d0297f67eaca31d8
Author: David Laight <david.laight.linux@gmail.com>

kallsyms: scripts/kallsyms: Improve compression by about 2%

This commit improves kallsyms compression by expanding infrequently used
merged tokens back into their original constituent pairs when no unused
tokens remain, freeing slots for more profitable token pairs.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 8576fe6ad90b7..9dbd7c85eec1e 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
[ ... ]
> @@ -561,6 +593,47 @@ static __attribute__((noinline)) unsigned int compre=
ss_symbols(unsigned int toke
>  	return substitutions;
>  }
> =20
> +/* Change every occurance of idx back to token_pair.
> + * This extends all the symbol table entries but frees up a token. */
> +static __attribute__((noinline)) void uncompress_symbols(unsigned int to=
ken_pair, int idx)
> +{
> +	unsigned int i, len;
> +	unsigned char *sym, *p, *end;
> +	unsigned int substitutions;
> +
> +	for (i =3D 0; i < symbol_cnt; i++) {
> +		sym =3D symbol[i]->sym;
> +		len =3D symbol[i]->len;
> +		p =3D memchr(sym, idx, len);
> +		if (!p)
> +			continue;
> +		end =3D sym + len;
> +
> +		do {
> +			len =3D end - p - 1;
> +			end++;
> +			if (len) {
> +				adjust_profit(idx, RIGHT(token_pair), p[1], p[1]);
> +				memmove(p + 2, p + 1, len);
> +			}
> +			p[0] =3D LEFT(token_pair);
> +			p[1] =3D RIGHT(token_pair);
> +			if (p !=3D sym)
> +				adjust_profit(p[-1], p[-1], idx, LEFT(token_pair));
> +			p =3D memchr(p + 2, idx, len);
> +		} while (p);
> +		symbol[i]->len =3D end - sym;
> +	}
> +
> +	substitutions =3D token_table[idx].refs;
> +
> +	token_profit[token_pair] +=3D substitutions;
> +
> +	token_table[idx].refs =3D 0;
> +	token_table[LEFT(token_pair)].refs +=3D substitutions;
> +	token_table[RIGHT(token_pair)].refs +=3D substitutions;
> +}
> +
>  /* search the token with the maximum profit */
>  static int find_best_token(void)
>  {
> @@ -578,14 +651,47 @@ static int find_best_token(void)
>  	return best;
>  }
> =20
> +static int split_token(unsigned int profit)
> +{
> +	struct token_table *tt, *left, *right;
> +	unsigned int i;
> +	int best =3D -1;
> +
> +	for (i =3D 0; i < 256; i++) {
> +		tt =3D token_table + i;
> +
> +		if (tt->len =3D=3D 1 || tt->refs >=3D profit)
> +			continue;
> +
> +		/* Ignore tokens where the original parts have be reused */
> +		left =3D &token_table[LEFT(tt->pair)];
> +		right =3D &token_table[RIGHT(tt->pair)];
> +		if (tt->len !=3D left->len + right->len ||
> +		    memcmp(tt->str, left->str, left->len) ||
> +		    memcmp(tt->str + left->len, right->str, right->len))
> +			continue;
> +
> +		best =3D i;
> +		if (tt->refs =3D=3D 2)
> +			break;
> +		profit =3D tt->refs;
> +	}
> +	if (best < 0)
> +		return -1;
> +
> +	uncompress_symbols(token_table[best].pair, best);
> +
> +	return best;
> +}
> +
>  /* this is the core of the algorithm: calculate the "best" table */
>  static void optimize_result(void)
>  {
> -	unsigned int i, idx, len, refs;
> -	struct token_table *left, *right;
> +	struct token_table *t, *left, *right;
>  	unsigned char to_process[256];
> +	unsigned int idx, len, refs;
> +	int i, best;
>  	char *str;
> -	int best;
> =20
>  	/* Generate a list of the unused tokens. */
>  	for (i =3D 0, idx =3D 0; i < 256; i++) {
> @@ -593,20 +699,28 @@ static void optimize_result(void)
>  			to_process[idx++] =3D i;
>  	}
> =20
> -	do {
> +	for (;;) {
>  		/* find the token pair with the best profit value */
>  		best =3D find_best_token();
>  		if (best < 0)
>  			break;
> -		i =3D to_process[--idx];
> +		if (idx) {
> +			i =3D to_process[--idx];
> +		} else {
> +			/* Try to free up a little-used token. */
> +			i =3D split_token(token_profit[best]);
> +			if (i < 0)
> +				break;
> +		}
> =20
>  		/* replace this token pair in all the valid symbols */
>  		refs =3D compress_symbols(best, i);
> +		t =3D &token_table[i];
> =20
>  		/* Update the number of times each token is used */
> -		token_table[i].refs +=3D refs;
> +		t->refs +=3D refs;
> +		t->pair =3D best;

[Severity: Medium]
Can optimize_result() enter an infinite loop when find_best_token() selects=
 a
homogeneous token pair best =3D PAIR(x, x) that overlaps with itself in run=
s of
3 or more identical tokens?

For a homogeneous pair PAIR(x, x) where LEFT(best) =3D=3D RIGHT(best),
learn_symbol() and uncompress_symbols() count every adjacent pair, so a run
of [x, x, x] increments token_profit[PAIR(x, x)] by 2. However, when
compress_symbols(PAIR(x, x), i) replaces the first pair to form [i, x], it
calls:

    adjust_profit(RIGHT(token_pair), idx, p[2], p[2]);

which is adjust_profit(x, i, x, x), decrementing token_profit[PAIR(x, x)] by
1 for each triple. As a result, compress_symbols() performs fewer
substitutions (refs) than the initial token_profit[best] passed to
split_token().

If idx =3D=3D 0 and a splittable token s representing PAIR(y, z) has
refs < token_table[s].refs < token_profit[PAIR(x, x)] (for example, two
occurrences of [x, x, x] giving token_profit[PAIR(x, x)] =3D 4 and actual
refs =3D 2, while token s has token_table[s].refs =3D 3):

1. optimize_result() calls split_token(4), which selects token s (since
3 < 4) and calls uncompress_symbols(PAIR(y, z), s), setting
token_profit[PAIR(y, z)] =3D 3. Then compress_symbols(PAIR(x, x), s) perfor=
ms
only refs =3D 2 substitutions, setting token_table[s].refs =3D 2 and
token_table[s].pair =3D PAIR(x, x).

2. On the next iteration, find_best_token() selects PAIR(y, z) with profit =
3.
split_token(3) selects token s again because token_table[s].refs (2) < 3 and
token_table[x] is still valid. uncompress_symbols(PAIR(x, x), s) restores t=
he
two [x, x, x] runs and sets token_profit[PAIR(x, x)] back to 4 (2 from
adjust_profit(s, x, x, x) in the loop plus 2 from substitutions). Then
compress_symbols(PAIR(y, z), s) sets token_table[s].refs =3D 3.

Would this cause optimize_result() to alternate between splitting and
compressing PAIR(x, x) and PAIR(y, z) indefinitely?

> =20
> -		/* Generate the full name for this symbol */
>  		left =3D &token_table[LEFT(best)];
>  		right =3D &token_table[RIGHT(best)];
[ ... ]

=E0=A6=93=E0=A7=9F=E0=A6=BE=E0=A6=9F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018155206.1324=
11-1-david.laight.linux@gmail.com?part=3D15
