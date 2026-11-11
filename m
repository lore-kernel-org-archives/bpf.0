Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399292;
	b=DAc6KsM3lsWS7KnoMZA0hf02HTEy5qPkaSfgMIULCu4ijUc8vWa02+43LhL+Sht2CRc4
	 nuJyH4TxlkCBLRRldueRjXDUPlMjARMJfU3ol2Sdt8TLzx1NKuKG1YwLYC7mYhYqQzZoj
	 5ovxgTJCPYkioa058NW7MnT5QjI7PAl/1XA00K5LtYMrKV427D1mrkcW3FHISOzV2imXX
	 hzUSHW48lM6ihDIzrWgRx0V18CpTI2LkTVUTPXmJZChRNz1UpYazhmPDn7NbNi+sYnrD9
	 A47qcfe3ZJ1umLFrUNYehRYBik39868NsfDE2SuGfpM6hkx8Z4mZ4kaSKUT+iTS9qZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399292;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WKvCc4vn9rgt3nBvxIK7Bu0vWFbGSlymvCb8q2dEKZU=;
	b=a7x0+iCyPrHBdJAZlAHFXOxW2GDbI7Duu3w+4LLB0re4qTr6GX8gJZVMZahtnC1mJFBH
	 lTycmsEEuknWK63aG0WT0zuscm7zq24e/3B5MVE8Jq9Uqq4OoAq/XLgxm6ub06zYXJXXy
	 fGtDKHJzPahBXqvy8hcGrfhukmAaiX1IdM0d8VgIPFH7A0eDFVusl2rpKARC0g7MYxSCm
	 wpCFnb4HzEf4e3iYh3Ba26yVk5sRFt4fm7PnkF2pgg5sPEw6+xJI8auGJwuYaVz+knVNi
	 Fp5ghW2rAinaLtCPed8fPvlanWmP5SkDPD3lsVoSskFQWyJV6LK90zQ17fWSz2YTm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LS0S9cak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E80606A8B6;
	Wed, 11 Nov 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LS0S9cak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC161F00A05;
	Wed, 11 Nov 2026 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399292;
	bh=WKvCc4vn9rgt3nBvxIK7Bu0vWFbGSlymvCb8q2dEKZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LS0S9cakPomZM/ga4l/AhVLYM/DN6lHlpMKdBsdYCgKrtLNPzOMYXZrf7rBPnpT34
	 1RCsY3iJm7eYXgAO9jMZIQJB2FtMXhm8gGpfK4F/WMB2+iVy0vKLLS6aACAeo19r1C
	 NQmROAAEN6bYLeUVt/MRWU6s4icLPeAStZ+0edT+Ys3XGeaJ8KWQffCDlmtG04cFk3
	 kLduYKJlIY/gktOUGiqSrx4dw3HRc0lwBoYnf8s4hxqw8NWS2RCRDtgD5pNlAFHMAJ
	 wjLJUUZWq8/jr+NyDvK/q2bssXXgjz7fGRWd+3QEp+j7RN8QOPP1qLP2fuYyzjucLE
	 qPypzK2XFOkNQ==
Message-ID: <sashiko-outbox-208961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 next 02/13] scripts/kallsyms: Improve error reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel
 Wu" <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261111115911.1142000-3-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
 <20261111115911.1142000-3-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:14:50 +0000
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
- [Low] scripts/kallsyms: incomplete errx() conversion in write_src()
--

commit 74224a3e189e43104e9d68aefe42fe16a066052c
Author: David Laight <david.laight.linux@gmail.com>

scripts/kallsyms: Improve error reporting

This commit converts fatal error reporting in scripts/kallsyms.c to use
err() and errx(), updates the usage message, and adds a --verbose option
for timing output.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 140e888bf7133..aa3a8ec83fbb8 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -490,7 +485,7 @@ static void write_src(FILE *out_bin_file, const char =
*out_bin_name)
>  			long long offset =3D table[i]->addr - _text;
> =20
>  			if (offset < INT_MIN || offset > INT_MAX) {
> -				fprintf(stderr, "kallsyms failure: "
> +				errx(EXIT_FAILURE, "kallsyms failure: "
>  					"relative symbol value %#llx out of range\n",
>  					table[i]->addr);
>  				exit(EXIT_FAILURE);

[Severity: Low]
Since errx() already prepends the program name, appends a newline, and
does not return, should the "kallsyms failure: " prefix, the trailing
newline, and the unreachable exit(EXIT_FAILURE) call be dropped here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111115911.1142=
000-1-david.laight.linux@gmail.com?part=3D2
