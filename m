Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402478;
	b=nEjF9QmwGGtmTFhb41599tBiOhKfF78kVdt2viFSV2jpcCkL4uljxmgFDTtBXB3yZgYk
	 xK29JJPQGMbOUEiLtJmrsHWTjp9PvDJbnU+ZuaRYGunFxXXAFpHd7q7aZFWk5tHkjA/MM
	 G1wsAPwWufESQKU64NIR8kcMSb0w1zcPsps0/IOCnfAsmlsuTu2Uel9UUKjdD57DQMiWL
	 Udi+uYC8gh2SN3zyNiN3/zZygJVDVy1OUfjkSnzaTNClyTzgj/liAgrebhvUA5V8BHEpK
	 2l3nHLnysRh8fK5ZjYXyoYWeYPaQ8Tn1BkVhRD4Aykya6BAuxefEUE48ybR+vuUP4sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cx4bEGE3gLurh951cdWY2VyzPEOPwrScYT+cKpERr+E=;
	b=b8LfJU37QiS8VYKIUccL1DNcjrV/vI7iKxjjmYCyg0ar4CDpfGOnq5HGD9ygcEO8NDBl
	 HU9c07UoN8quuCnk5r1el4iVNktlOgDD2wuEIIyaaxaK50xbdAVLA0ro4N7kD63XVxggt
	 EjCCLMONA8qnW859CYHxllGfhfpblkYMua+eHzMV+jzVsIkVaZ+uCoyS/Kz1DG8JAI2oE
	 GUpeD4t4PQzJxm+qepgfjStqfUE/hGGakZPo4pLjtDO6WYga1QV6rSEG+7JNZAbJFyR9+
	 cDbe3zdedY+GJwWGLDg7nFmOk98fFMWcfyjuhsQ92kFLeAKNrnx8sx+eQaNAN3xCeZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwEFlMry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDD606A321;
	Wed, 11 Nov 2026 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwEFlMry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C6E1F00A05;
	Wed, 11 Nov 2026 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402477;
	bh=Cx4bEGE3gLurh951cdWY2VyzPEOPwrScYT+cKpERr+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwEFlMrysLV05W3S0EtNk4glp5ayE1+1MQaKK71Z7SPQvUI1gNlRgwfMVCIYWMR5N
	 hkY7uwrWYosFXHITwR+kEiv2ICNn5fHpzZeDGinGmCW8TqPhxQhh852d1qFJQ+vwzI
	 eBVAljC2pcU2oT97IQ4//IKsxoSXL13qUAo6Egf9cLvpOEdQLXCKPKrTH040U+Wu2M
	 8OMgXPjwOrk6Pw2dp0ypGNg7EO5nUlhc/OX8Ma7JCb1ucGbHqEXMql3gZO27VVUQFk
	 UYYXrNkWxp7UN74VCkpEJZCIaW0Sd0p2gAu6nWT7Ha0zHzPSYCHEYHJPWrvHVf7OtV
	 CGTWXrx7dZG3w==
Message-ID: <sashiko-outbox-209043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 next 09/13] kallsyms: Add a kernel parameter to
 change the kallsyms_markers[] density
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261111115911.1142000-10-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
 <20261111115911.1142000-10-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:07:56 +0000
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
- [High] kallsyms: wrong markers_cnt rounding in write_src() overflows
  or leaks heap
--

commit 03c7dad0d75ad1647bb5f932cd21410fa5140c26
Author: David Laight <david.laight.linux@gmail.com>

kallsyms: Add a kernel parameter to change the kallsyms_markers[] density

This commit adds CONFIG_KALLSYMS_MARKER_SHIFT and a --marker-shift option
to scripts/kallsyms so the interval between kallsyms_markers[] entries is
configurable rather than fixed at 256 symbols.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 930ec27a53c06..c27aaabccd1b0 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -441,8 +443,8 @@ static void write_src(void)
>  	stamp("write token table");
> =20
>  	/* table of offset markers, that give the offset in the compressed stre=
am
> -	 * every 256 symbols */
> -	markers_cnt =3D (table_cnt + 255) / 256;
> +	 * every (1 << marker_shift) (typically 64 or 256) symbols */
> +	markers_cnt =3D (table_cnt + 255) >> marker_shift;
>  	markers =3D xmalloc(sizeof(*markers) * markers_cnt);

[Severity: High]
Should markers_cnt round up using (1u << marker_shift) - 1 instead of
255?

The loop below populates markers[i >> marker_shift] up to index
(table_cnt - 1) >> marker_shift.  With 255 still hardcoded,
marker_shift > 8 can under-allocate markers[] by one entry, overflowing
the xmalloc() buffer in write_src() and omitting the final entry from
kallsyms_markers[] so that get_symbol_offset() and get_name_address()
read past the end of kallsyms_markers[] at runtime.  Conversely,
marker_shift < 8 (including the new default of 6) over-allocates
markers_cnt and writes uninitialized heap memory from xmalloc() into the
generated kallsyms_markers[] table.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111115911.1142=
000-1-david.laight.linux@gmail.com?part=3D9
