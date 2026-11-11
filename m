Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440041;
	b=twxreJs4a0HUCAdztxVbpWeLaCMLFD9SjAK+CNMKO1Qzjetj5E57faFBqaEUrits5RKd
	 9hdk5qehprJfuOMlJeQVG9GtyKe6wKEb2xw2Oy0ft4eW+A+U+NczzCXGbbDgxFoEshtal
	 yruU7MyccmFHqpFKGJIHPXWUx0xXyzFxYMW/cTxTcL5/dPZUPwFiWIyCLDiOg1Qm3jQ9h
	 lMToLqT7XrO6tj7X/lk2+5EKw4Epx2NOg3DsidCAVG+Hih2tGLXogrOXUQDZA14ohAHY5
	 WpQHWuCZv9AjLZ5UOoAodhk2lUmzwQ++fA+qzI7//IMRhvyPoui+WB29eevvDV7Vs+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440041;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uAnkXJdgFVKL/Gpr5kEycYZSm62FStlfxyQDHzl+9qo=;
	b=4AD6WubAZ5+gUwuIeuh6a3RlLpN2+Po1mOjGuVdsg9+CoRqRh9SwJ4lpgyHn9bxEmNZO
	 k+jzF/4+DmBHKwYQbZVV5iSoz0LqdmjVqbA5LJiEPRQilAVTrbvDRsaX9kbRVVF5w05Yj
	 WVEKd73HdnFAXg/i9Se9f88PjEmEa2tSzWvWpiDECU5BgaCAQZw0EoquDRLcBzUG7jHUo
	 lQYB3Zl7SbKGoAtQiBWhppms1lCEos5FgLF0ETIACXs9vkEjayyQUcmC17RUK6Wl5fOVD
	 0RCYJGv1zU7+G+RTAZCPZeTSblbfFp5drI+xlNyzj0OkksMB6E38ow52QHQ9xoGsN2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYOx0138;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94752606A88C;
	Wed, 11 Nov 2026 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYOx0138
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510811F00A09;
	Wed, 11 Nov 2026 23:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440041;
	bh=uAnkXJdgFVKL/Gpr5kEycYZSm62FStlfxyQDHzl+9qo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RYOx0138+nj+Ynai3bO30N9wJrmUBsUF7lt2DT9QA6EseQCvoCqU/NVdmOWROpvBf
	 5YyWNpAlz6rouWyiQoKMVqhBXfyP+okg/h5Ru3azDHLnPeHn9nH2Jpti8SKQQjFL4f
	 2XS0UU9po7XiUMgyG3PI8tOjZ/59PmMJGpiAZJhw38Fi7qTjATKlZDc6cYJDBjmAhu
	 8JEOdbT6WSS3GJzN6HFAvO4ywR64I9A6qkOgyCf2//YdC+bplIS++KB2aD5Xqmjtti
	 C5r4b2If2EAV53zPdJWTxYF7c8s1Rc92soRm2qUqEIbjeYUR8x52NQULnjlxVH4Bws
	 IhWZjPQxeehcw==
Content-Type: multipart/mixed; boundary="===============6245461029241772195=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f76636ba6a20d7a9073063eca8aad6011888e88e4290045699c5191b7b06404b@mail.kernel.org>
In-Reply-To: <20261111115911.1142000-5-david.laight.linux@gmail.com>
References: <20261111115911.1142000-5-david.laight.linux@gmail.com>
Subject: Re: [PATCH v3 next 04/13] scripts/kallsyms: make use of binary data output optional
From: bot+bpf-ci@kernel.org
To: david.laight.linux@gmail.com,pmladek@suse.com,kees@kernel.org,david.laight.linux@gmail.com,linux-kernel@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,jim.cromie@gmail.com,ljs@kernel.org
Cc: mcgrof@kernel.org,andrey.grodzovsky@crowdstrike.com,rostedt@goodmis.org,andrii@kernel.org,wusamuel@google.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 23:34:00 +0000 (UTC)

--===============6245461029241772195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> scripts/kallsyms: make use of binary data output optional

TL;DR: Nits only: possibly unneeded sys/stat.h include in kallsyms.c, commit
message typos and commit reference format, and a question whether independent
changes should be split into separate patches.

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c

[ ... ]

> @@ -278,26 +283,16 @@ static void add_table_entry(struct sym_entry *sym)
>  	table[table_cnt++] = sym;
>  }
>  
> -static bool file_is_empty(const char *path)
> -{
> -	struct stat st;
> -
> -	if (stat(path, &st))
> -		err(EXIT_FAILURE, "stat(%s) failed", path);
> -
> -	return st.st_size == 0;
> -}
> -

this isn't a bug, but with file_is_empty() gone, is #include <sys/stat.h>
still needed in kallsyms.c, or can it be dropped in the same change?

[ ... ]

Commit message:

>     While writing some of the output in binary (and using the .incbin directive
>     to get the assembler to read it) speeds up normal kernel builds, it makes
>     debugging kallsyms almost impossible.
>     Change the command line processing so that the out.bin file is optional,
>     if absent everything is written to out.S (at is was prior to 83da9f3197e5).
>     [ ... ]
>     To help anyone who ends up looking an hexdump of out.bin, add a text header
>     and 16 byte align each table.

this isn't a bug, but there are typos here: "at is was" and "looking an
hexdump".  Should the reference to 83da9f3197e5 also be given in the usual
form with the subject, e.g. ("kallsyms: output binary data to speed output
and kallsyms assembly")?

Also, could the independent parts (the hexdump headers and alignment, the
fwrite() offsets fast path, the token table reordering) go in separate
patches?  They don't appear to depend on making out.bin optional.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43116767394
--===============6245461029241772195==--
