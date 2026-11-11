Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401992;
	b=bfWToAWe3ftTYuSOuxVB6VNo9tN2+9NX+N82/9ZK5l6Ts9o/gny8EIy8fCrckaBFcurl
	 U3yqnzSPSBPgklU/wwPWOzoj+8zEjxblcJ7Jy4hTD7czOWuWFekMYo5d1M8bRpFmd3UjH
	 L1ppm8sC3QtA+SWHvFPh65EfeGfNLCennP3xWV+KG2w29LkfO9RHNTh3mHQIH7T9Uzl5L
	 Fi2jsG9oAgG2w6kn8XZ9y0c/vk3+PXGhV8NIT2NALk/ZSwmTs/XWSeT9TL502XOBs79VR
	 kFRJHmcnoF43PFFryPN1UGQ4SwD+KW0qbUQUo9LVudVKysUTYGrESqvittsZ4wKbz0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cq0EbijHimnHd5/JHm1YtAfp5uf1vMCdUbdB6R387fA=;
	b=0nIRScm+NRTByynVu5hDsqKH0uw2GcGIHQxKzeZP5Pc3+Z5aDrd7BrpVWqhC5TlgmDVt
	 wM4coYsKUmCEXAVoi4mGdRWF1mR7nmFWTOzRT9h3AQUNBH9C99Fj4KM8QretmQjZOyEML
	 k7pEFFiAyxRGlrf9tmwxM9GH3/TgCrNkbD0PE4YtrVLD37NmWmULtypuW2IgXh3Ra23Lj
	 s17ZzFicOuxEra1uFfa1iKq8XhBQZZESwYDcywhMfq126ZSBcEZ+AN+Xq6CmRh2mZ4txk
	 QunkUCslPo2xLeHZsGtrebet2RMWuEojwTXG5VkOppZn50liJGP/wYwI4jYkX0m5X0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs27OMQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB5606A321;
	Wed, 11 Nov 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs27OMQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806F91F00A05;
	Wed, 11 Nov 2026 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401992;
	bh=cq0EbijHimnHd5/JHm1YtAfp5uf1vMCdUbdB6R387fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rs27OMQInlrg6aKPuuon0L2ShvXarHZy6hJygJWRrfQNlTWFL0RCs1Bsf/ljhVs0Z
	 JSi+PEAfx/69NdxYIUgCt4dZ57CkrZFf2xMMMutv0czCCkauUc0sjXu6kOH89cCDvR
	 Y+xGQ5AGr1ooIM2KXSZImEcLmdMYO90Qs2m97in7L6/L3/NCGdKT+zMWeu0kptj73E
	 39SMhj8Gu6unYQyyTcTO5ZFuEfoTF4iin6lkWiqRBCqOKoxeP4E5Fm1HzFROmHO0Pk
	 xnr1yxjupTilRQnh+Fn7eRIE/HXI13Zs2tC0OZ+uHLvFH7g6fB9VRNl3CP6Z2x8/S4
	 2LoXr0iBfcirg==
Message-ID: <sashiko-outbox-209030@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 next 08/13] kallsyms: Optimise symbol name search
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261111115911.1142000-9-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
 <20261111115911.1142000-9-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:59:51 +0000
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
- [High] kallsyms: broken 24-bit big-endian offset calculation in
  write_src()
--

commit 129df190c855fc8323de3f8129f606cadccd6466
Author: David Laight <david.laight.linux@gmail.com>

kallsyms: Optimise symbol name search

This commit changes the alphabetically sorted symbol table from indexing
kallsyms_offsets to indexing the compressed kallsyms_names stream, with the
low bit indicating duplicate symbol names.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 74db751600b4f..930ec27a53c06 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -570,23 +571,41 @@ static void write_src(void)
>  	sort_symbols_by_name();
>  	stamp("sort by name");
> =20
> -	output_label("kallsyms_seqs_of_names");
> -	write_incbin_header("seq_of_names", &bin_offset);
> +	off_size =3D table_size < (1u << 23) ? 24 : 32;
> +	output_label("kallsyms_offs_of_names");
> +	printf("\t.long\t%u\n", off_size);
> +	write_incbin_header("offs_of_names", &bin_offset);
>  	for (i =3D 0; i < table_cnt; i++) {
>  		se =3D table[i];
> -		seq =3D se->seq;
> +		off =3D se->seq << 1;
> +		if (i && se->len =3D=3D table[i - 1]->len &&
> +		    !memcmp(se->sym + 1, table[i - 1]->sym + 1, se->len - 1))
> +			/* Mark that this is a duplicate of the previous symbol */
> +			off |=3D 1;
>  		if (out_bin_file) {
> -			unsigned int seq_be =3D htobe32(seq);
> -			fwrite((char *)&seq_be + 1, 1, 3, out_bin_file);
> +			unsigned int off_te =3D big_endian ? htobe32(off) >> (32 - off_size):=
 htole32(off);
> +			fwrite(&off_te, 1, off_size / 8 , out_bin_file);

[Severity: High]
Does this corrupt the 24-bit entries written to out_bin_file when building
a big-endian kernel on a big-endian host?

On a big-endian host, htobe32(off) is a no-op, so shifting the result right
by 8 discards the low byte of off and leaves two leading zero bytes at the
start of off_te.  fwrite(&off_te, 1, 3, out_bin_file) then emits two zero
bytes followed by only the most significant byte of the 24-bit entry,
breaking kallsyms_lookup_name() and kallsyms_on_each_match_symbol() at
runtime.

Shifting off before byte-swapping, as in htobe32(off << (32 - off_size)),
places the three big-endian bytes at the start of off_te on both
little-endian and big-endian hosts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111115911.1142=
000-1-david.laight.linux@gmail.com?part=3D8
