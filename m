Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400329;
	b=tgRmxiKLpVT23bcv+Yy1ivNEhkwZyjG9q3ek1o6MakmtNnkQb6P1cwOpg9ufvtIS/JV/
	 snpll1A7QoEaTeaUXUwxoOzhIjAq9xy7DrvdSMHtf5oZ00QQXlH8K77LzWVRQ7GQe0K/V
	 GmE9ENulzwhuWluKopgm9wnaD5OejC4+0CaXAVYiHWaYEIB0LFgN1D7nfHtQVBBTHLLuY
	 d4DJBMH3NM8bYGCNpa9n/PP8SLHWGc1E1fsP+KcWTQnDNIdNVdrdOs85LKz+OONxwLmxC
	 2dQoo0p3cJUhhr4X0PgzGWwu2ugHhG2ksnxA8KDbAe4alWRTqT0hRUzs12EnHlTmzRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9WsLjvkNNu9s+q1Y30o/mSE0qGBgt1KxnCS2sDzvwyI=;
	b=1sfnvcp38xX3SyvpEwy5SCVVKRBK+b2WpTjTYsZq1bfcEpYsFYCXaTkfWF7AxAAKfNEC
	 kwA57gYYdVKszzo/wV1SpHknzM8Zo9v92xd58iT9Mq6wKre1/TgX3VkjvDXESv2PhToO7
	 6p+Yb2lcLfYsiy8XqG8lCzlTDk/tP7fKu69D/d1zALZPbu6pqhAmxKb4TPEJc0lVJUCG7
	 xlCZrqaL3mkuuKzCMbkuoYUb9V0LRLt4gLLZwoRYqYBr8KMk81Wsi6oOp1EAOkGOryjWO
	 MatbuxMDrc0vUPOHAdeeCpEg8bXn4nAA866ZnY9tZHA7CBBTJXIj6whmClVLx6tXnlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJh7Xsmz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8C606A324;
	Wed, 11 Nov 2026 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJh7Xsmz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C041F00A05;
	Wed, 11 Nov 2026 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400328;
	bh=9WsLjvkNNu9s+q1Y30o/mSE0qGBgt1KxnCS2sDzvwyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJh7XsmzJ0ybSFCIeH/im7LKvZlxcvXoOGKD2ZWiWuoJVimz24cVKhd0tXea71BcI
	 8yGCnnorB2TgHP+gDfMLGm9uCdEQo2e4Vixpbuhqe1hqxY9WBm4DbuJNHq6HvqdA+t
	 W3pCpCqRyMJPTSnjHTimKREl/oJ2djMO5a9vPGdceQyYQi5C0ZuLS9v5afeQoP/G/+
	 lEBh5CshkZfNwa+y+ua+JNkEbZ+WO0M66itBmsmi9edcMjoUEnMWAiZD+g6BP1MmB1
	 HZLGe7mX3dXgjNb8Vz+zBFPc2Fvq6XufSu63OIjGnIH8JfqbPBfDVT34xJzSiWW6Hb
	 Vp9PgDqkzuWjA==
Message-ID: <sashiko-outbox-208980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 next 04/13] scripts/kallsyms: make use of binary data
 output optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261111115911.1142000-5-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
 <20261111115911.1142000-5-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:32:07 +0000
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
- [Medium] scripts/kallsyms: wrong variable negated for negative offsets
  in write_src()
- [Medium] scripts/kallsyms: 9-digit buffer in write_src() clobbers sign
  on large offsets
- [Low] scripts/kallsyms: missing endian.h include for htobe32() and
  htole32()
--

commit b5cbf4ceba792715bcee0dd6d58ce67f9542a5ad
Author: David Laight <david.laight.linux@gmail.com>

scripts/kallsyms: make use of binary data output optional

This commit makes the binary output file and input ELF file optional in
scripts/kallsyms, writes the markers table in target endianness when using
binary output, and formats pc-relative offsets into a buffer for fwrite().

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index aa3a8ec83fbb8..74db751600b4f 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
[ ... ]
> @@ -406,51 +417,105 @@ static void write_src(FILE *out_bin_file, const ch=
ar *out_bin_name)
[ ... ]
> +		if (out_bin_file) {
> +			if ((i & 0xFF) =3D=3D 0)
> +				markers[i >> 8] =3D big_endian ? htobe32(off) : htole32(off);

[Severity: Low]
Does scripts/kallsyms.c need to include <endian.h> for htobe32() and
htole32()?  Glibc pulls it in transitively through <stdlib.h>, but on
musl libc hosts neither scripts/kallsyms.c nor its included headers
declare these functions, breaking the host tool build.

[ ... ]

> @@ -458,31 +523,15 @@ static void write_src(FILE *out_bin_file, const cha=
r *out_bin_name)
[ ... ]
>  	output_label("kallsyms_offsets");
> =20
>  	for (i =3D 0; i < table_cnt; i++) {
>  		if (pc_relative) {
> +			/* All 64 bit builds and (at least) relocatable 32 bit ones */
> +			static char line[] =3D "\t.long\t_text - . +123456789";
> +			char *end =3D line + sizeof(line) - 1;
>  			long long offset =3D table[i]->addr - _text;
> +			int off32;
> =20
>  			if (offset < INT_MIN || offset > INT_MAX) {
>  				errx(EXIT_FAILURE, "kallsyms failure: "
> @@ -490,12 +539,28 @@ static void write_src(FILE *out_bin_file, const cha=
r *out_bin_name)
>  					table[i]->addr);
>  				exit(EXIT_FAILURE);
>  			}
> -			printf("\t.long\t_text - . + (%d)\t/* %s */\n",
> -			       (int)offset, table[i]->sym);
> +
> +			/* Build the line so the the faster fwrite() can be used */
> +			*end-- =3D out_bin_file ? '\n' : '\t';
> +			memset(end - 8, ' ', 8);
> +			off32 =3D offset;
> +			if (off32 < 0) {
> +				end[-9] =3D '-';
> +				offset =3D -off32;
> +			} else {
> +				end[-9] =3D '+';
> +			}

[Severity: Medium]
Should this negate off32 (or an unsigned magnitude) instead of assigning
-off32 back to offset?  Because offset is not used after this point,
off32 stays negative when a symbol lies below _text, so off32 % 10 in the
digit loop below yields negative remainders and writes non-digit ASCII
characters into the assembly output (and -off32 overflows if off32 is
INT_MIN).

> +			do
> +				*end-- =3D '0' + off32 % 10;
> +			while (off32 /=3D 10);

[Severity: Medium]
Can a 10-digit offset in [INT_MIN, INT_MAX] overwrite the '+' or '-' sign
in line[]?  The template only reserves 9 digit slots after end[-9], so any
symbol at least 1,000,000,000 bytes from _text runs 10 iterations of the
loop and clobbers end[-9], emitting invalid assembly syntax.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111115911.1142=
000-1-david.laight.linux@gmail.com?part=3D4
