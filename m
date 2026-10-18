Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB273D5227;
	Sun, 18 Oct 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339205; cv=none; b=TGNJJ1mhJRk0VBtK53ng0kJwNcpieh5acvh+jMW247x7ChD9exzio+iRtUP7yhhG0JbpseakLYM9dOUSAh7/FOVXHTkjnplM3qTKXfcDCpH910vT2kqi5IGJhjOMy3ziGsdnzlpeDPbmXsgaebM/HlPeAPa52aMWQSYUJ+E9Z2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339205; c=relaxed/simple;
	bh=1AgagvzxFWHKz4+ryptVpzIWqUxpKQ+UakAJvzSZF04=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mtaQ5Gl426ZMSKeWwuTAmghKBFSqCV06jBCbyG1G04iTQtmC6eW5oTDuEOUsXgPMIwcJt9VXo2JYDyc1RJGj7WvVNVWEcfXQizhq91LeWuYusDqbJMQV0WmDEXNgnBazVDf6y0Xh/OwdE/JzDZt3/jHy+JuyfZCcKLd3hGGyEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfCbqkIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfCbqkIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DB41F000C5;
	Sun, 18 Oct 2026 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792339204;
	bh=a+6IfJ3+0/OLUOLzxPThKWcgo4ye/fgRjK8zZ+Hu0n4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfCbqkIh6ZE77Xg6EegPm2dytfKE8qUotnRCGM0NedvDA9bnwE6YSvFsIEwFVUZgL
	 RH2ScGDQ4pQN0sX817w7LgZaho6DkMzECcPP+qP7pzyIS+K7oOvhwvHyeEIqrxwLO6
	 yZ5KL239GXmDHXBGA2fDPmqrcSDYeC8q3GjS+Wp/Ph+cHHle6a+PuhofoXqVwepmxB
	 ds+MqxFooMnHQWm/ZltRjGtPCMPdnmgTRx3hwV/2mmEoSVvYSQsnPbs2V8BIRKtyH0
	 oegnLxltmfG0qBM7G+OwI+LeQ+9XhJgqpkdWktLaSj1ugZKG0rO5YISN1xzqtAsy2T
	 ig5bHPa2p5kvA==
Message-ID: <sashiko-outbox-176255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 next 11/15] kallsyms: scripts/kallsyms: Keep full
 expansion of tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Laight" <david.laight.linux@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Kees Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, "Jim
 Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, nathan@kernel.org, nsc@kernel.org
In-Reply-To: <20261018155206.132411-12-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
 <20261018155206.132411-12-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 16:00:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kallsyms: NULL token_table[].str passed to printf() in write_src()
--

commit b464b94e58431a4ad1ec112c739d63f16547b8f2
Author: David Laight <david.laight.linux@gmail.com>

kallsyms: scripts/kallsyms: Keep full expansion of tokens

This commit stores the full NUL-terminated string expansion for each token
in token_table[] as tokens are allocated, avoiding recursive symbol
expansions later.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 5603b2a6c77bd..9e1bc0fdaa9f2 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
[ ... ]
> @@ -415,9 +403,8 @@ static void write_src(void)
>  	off =3D 0;
>  	for (i =3D 0; i < 256; i++) {
>  		best_idx[i] =3D off;
> -		expand_symbol(token_table[i].ch, token_table[i].len, buf);
> -		printf("\t.asciz\t\"%s\"\n", buf);
> -		off +=3D strlen(buf) + 1;
> +		off +=3D token_table[i].len + 1;
> +		printf("\t.asciz\t\"%s\"\n", token_table[i].str);
>  	}
>  	printf(".size kallsyms_token_table, . - kallsyms_token_table\n");
>  	printf("\n");

[Severity: High]
Can token_table[i].str be NULL here when some token slots remain unused?

In insert_real_symbols_in_table(), token_table[i].str is only allocated for
character codes present in the input symbols:

	for (i =3D 0; i <=3D 255; i++) {
		if (!token_table[i].len)
			continue;
		token_table[i].str =3D xmalloc(2);
		token_table[i].str[0] =3D i;
		token_table[i].str[1] =3D 0;
	}

Then in optimize_result(), the loop stops early as soon as find_best_token()
finds no remaining token pairs with positive profit:

		best =3D find_best_token();
		if (best < 0)
			break;

Any remaining unused entries in token_table[] keep len =3D=3D 0 and str =3D=
=3D NULL.
During pass 0 in scripts/link-vmlinux.sh, kallsyms is invoked on an empty
symbol file (.tmp_vmlinux0.syms), leaving all 256 token_table[i].str
pointers as NULL.

Previously, expand_symbol() wrote an empty string into buf when len was 0.
Passing a NULL token_table[i].str to printf("%s") in write_src() causes a
segmentation fault on non-glibc hosts (such as musl) or prints "(null)" on
glibc hosts while advancing off by only 1 byte, which corrupts
kallsyms_token_table and best_idx[].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018155206.1324=
11-1-david.laight.linux@gmail.com?part=3D11
