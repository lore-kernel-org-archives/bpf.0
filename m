Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654102;
	b=JzM9D8MySAePVtIOcMdfhnfug5cn/hgEd/qrFZ4LQHqSo76cMcYZTGDdh/YIkOM+gPb/
	 vh/WG9U3RG1b9gzgI640uyH2uDV3vbgANXLoNnCHLd6BvYHAmSEHmVu//DSVr+5iJsZik
	 TW4DLsS9RVLYfk+DRHvr7OpDJnmcHJs1LtmRCkboU56eU9fFz5CsPmUFLl/cGvR+47hsl
	 q4o/sfESRk0Ns1yRy/i51jQ0sGNPSh2kI1tOq0vWaC7S6mMResFOKMEvuqnsjuErvnLGb
	 4IbzZtMnUJuOl8UlBTyNfZANAKXSF9LujViySAdWeNvYW0aQT7/zSqYaAC753srF3gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
	b=R5eQrldlFuZSETFE9E/KjQRDp3ZBIzH2m+eJbP6lHV5/8zbbMkR/aqxiQFD7XlaKrIYY
	 EXGjTQ7YZAe1aq1xHU10ao6yOgLmbnX+bDHrKnfACv8FFAyiR/3jEUIdWV5fbPM/aBZRT
	 CFB5XDvMtdrEQgIcHQArSxr2wHOSvE2WtEZ71fil48JnfDOhtQTwxpi9ptfCiQUPGGtz4
	 cULqDpZu3eG74R78P1kRv+H0mgJ7an8MSXzaeXSRV5CaAuU0qko5j9r+gf5zEZrNvpThZ
	 i4rAbeGshylGAY4erqztKxFH6zzxONNhC3fl2E89lv1dqXpl513zmajtkFZkkoS+2XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QWMZ80Cz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B0606A32A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 00:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556B0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QWMZ80Cz
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50cc7540b7so910823466b.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795654101; cv=none;
        d=google.com; s=arc-20260327;
        b=k0SmDpC5owFtUTwKesU5zaBgNbi8B0PgMRey7oQYQU2pPBGwcjHclgFXRjPrYzrHWY
         Ea/lzysM33sV5rEbS5Hhetz7A+dQXOR8uHJg5fb1bOWyiubpjEohFNIQg7i63g3n52o7
         6ol7JS4p/mUrecSVPZuafRLKjZDS4Z7uG66UZr9ePHfMnUxW8xRrw8ksP+hdD/zmE38K
         vrR8q9wtBwOxBKT4EyddvzqCKiJm5Qqd9mq/oeiK42qOZwsKGAQ2stAAn/WVCY6vWI28
         QieVI+7ixX5wyephYcNUi95eZQNj/50K6z4zVC3CFSnzALn+D6++anFYGjJYqXTtLysd
         RCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        fh=SuQUnpStRj+nQ4/wB+8xX2y6pkNO6QEDj9tCsWLvx+k=;
        b=ONu9j/Z3pxVPH69o0iUgDBt+lY6QbZklU6Y/SIetSjLhrV2wRn9x+0mY0P9/chnDtZ
         aY3HoBZsvSjdLrc70vTGfPmeivQjvJy9zgN8Mp5XgdUPg8J6nv+1gukzn/LoMIlxfAvZ
         z3Ar5Vwa/KBYYpyPjJRWoFSKfMYXo6Vuj07OHoA5Z++cJAeeBjhQQr4LnlLOQbLPR6qV
         6HQX3szAmdOVdTdiuRxAzIeAeFXotf0PWxXMKpQpXRlh4cpwAmu/nENbyPIVCIsuFmha
         LDveHP75KSyyEJ/zhanJn6E2czDRqE/eYO+Y9OUuNBIfhHWKrBQAl33hrdm1eZKp2EeJ
         wsWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795654101; x=1796258901; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        b=QWMZ80CzZfH6yoH4sucNVvHTrwf1PIcC+Bp2zpQDOXhvTaLR5/Hb6aclEYP0GJ5EbO
         tJUXzbHm5a1lhC/Ax05U+ZOxJaUnTui2Rk4msdPfixijvZGIv/STMD8sdmvdk0JLoPML
         TqbI7e+F27OvNQ1L2QOdn33Qfg3eLkeqAwD6ryOf7vQH0q2dc2f1o0EKha9CE2cwglDJ
         7Sd/maZlmbFd2u6vfPe4Bc4+mGU0kS7nC1KhuBzJ0BY73ENkc4VuiMfat2qIpNB6JRsB
         QZjOMEBbuY0eBgGxKWFhpFa0ZVGml7Ayw5gVKKOPjRvn3VcvJm969BGQaiZe0I0XPK79
         1ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795654101; x=1796258901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iCzRjJNZndkziacQw9rQDKbsJVun7kbrLRZjMIP3YsY=;
        b=kbH4s6/50X+sWg88YXYg/EjAvmpyQZsAxkILU3kV8uGgRcuBIzPkPeLfmvpsqdSHgv
         3tX9Tu8Pr277MD/TyPznm4WZzAedpR23kyDkxH4zX6HlMEMSu/SicC/lhOd6gGsHtNeS
         HMWcb+/EVombr1pZuAdumeFITSwgmlablCi5edJ036c3275UGKOnDQzBp288HiASDgYg
         Mm6wugsCZXAp9UPg6Gi2+S5CLk1kVG8ncK67sN7AxqcWrl9v+wVeLQbemf87O8RfJaS4
         SRfHXZhicwIQtEGDRuAfgCyn87iUSRY2DZkSuTttep9DbOrgCXCcI1fwOQoZyCQvCT8y
         sjeQ==
X-Forwarded-Encrypted: i=1; AL+hErG81URaLMVIZF99ROaf1B54UJDkficsC0EQbZ8fbMDeMbf6Rns+FGP4kgZokaNFI3MeH8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/HTAJBLwNXVb2uCgwHOChAbJ/emMEvZavAyaDQF6ek7SqxMDR
	fVKDVvP/dZVJsIlXUKrb/NsYvTfqRwMXQy0uTlGv5W9F5MJ8d4XXyNG2aq7C7DqJDL69LPJZ+lP
	xJu9Mln33vEydsO/FnDzordUbXbkQjEfAvk32lkQm
X-Gm-Gg: AZFdTZdXJQ2nvbwUKf5rcGIx6F0TQfCTFFBQ1aTV0HSd21uogVf98zGW4s05B5oYti8
	obbSc29GW/MvqwyyJp4EEG7oZYD4J6cSmp2RspyIu+UrtBcauoooUeUK78yxKEMmaQZ+H2VJGP/
	aMqYdFZ1ennkrrnzGqLNP4TU1O4DCVZmcwtm0ANEXlCTpnOeIBAGySbHzPHrRov61kWeRfbXcB/
	gYQPN+/EAjZtjxQKkCt4U8tr515qYhmS1hkI6OomPyUNbRPN+cOfsHoprP9EvLgHHvtoXkRkZeI
	FQbttVF10K+Ucl2kUUjKjF33OFJ9zjWNPslcS6BvyotINvVbkq1XWOi+rwO/voUfLACS6MF/Epf
	TfU3FuWKsVu/7Ztk1UFEjr6Sr76GzDusJQ9OYSZ5Ee2faVNsX2H6qhtZ1tM/qtWWEcwY=
X-Received: by 2002:a05:6402:1d4f:b0:6b7:f106:3419 with SMTP id
 4fb4d7f45d1cf-6ba37ed40e7mr16523342a12.43.1795654100281; Wed, 25 Nov 2026
 16:48:20 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-14-wusamuel@google.com> <CAEf4BzYLqCCwxSAfuzB-wZiae_tgf0yxAVsFc_wzfRAdeqjDtw@mail.gmail.com>
In-Reply-To: <CAEf4BzYLqCCwxSAfuzB-wZiae_tgf0yxAVsFc_wzfRAdeqjDtw@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 25 Nov 2026 16:48:08 -0800
X-Gm-Features: Aa3M54pWdHazBU-AqLK5TiYQKtZxCNreXkIezAAKXNEVmmWGCBCO_8U3jzAUf4c
Message-ID: <CAG2Kctp-XoiK-Ej3eHWnYyijydej6Bw5sLKNNi-S+xEGDB+mGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> > +/*
> > + * Find a symbol by exact name, or by prefix with KALLSYMS_QUERY_NAME_PREFIX,
> > + * in the entries of /proc/kallsyms, except undefined module symbols. vmlinux
> > + * matches come first. A module_filter of "vmlinux" selects the core kernel.
> > + *
> > + * Each call returns one match and sets pos to its position, even on
> > + * -ENAMETOOLONG. Start with pos 0 and use pos + 1 for the next match, until
> > + * -ENOENT. Use pos only with the same query. Matches can be skipped or
> > + * repeated if symbols change between calls.
> > + */
> > +struct kallsyms_query_by_name {
> > +       __u64 size;             /* in - sizeof(struct kallsyms_query_by_name) */
> > +       __u64 query_flags;      /* in - enum kallsyms_query_flags */
> > +       __u64 query_name;       /* in - user ptr to name or prefix */
> > +       __u64 module_filter;    /* in - user ptr to loaded module name, or 0 */
>
> similar to the comment on the previous patch, how does the user
> express that it only wants to search vmlinux image and not consult
> module?
>
> and naming nit: query_module to be consistent with "query_name"?

Passing "vmlinux" selects only the core kernel (noted in the block
comment above, missing inline). Will rename to query_module and note
"vmlinux" inline.

>
> > +       __u64 pos;              /* in/out - start position / match position */
> > +       __u64 sym;              /* in - user ptr to struct kallsyms_query_sym */
> > +       __u64 sym_struct_size;  /* in - sizeof(struct kallsyms_query_sym) */
>
> I'd name it "sym_size" for consistency with "sym" naming, and the
> comment/doc here is unambiguous about what that is (struct size, not
> the symbol's recorded size). seems fine as far as UX goes
>
Ack, will switch to sym_len
>
> other than nits, this API looks great
>
> [...]
>
> > +/* On -ENAMETOOLONG, *ksym is still copied, to return the required sizes. */
> > +static int kallsyms_copy_sym_to_user(u64 usym, u64 usym_size,
> > +                                    struct kallsyms_query_sym *ksym,
> > +                                    const struct kallsyms_sym_match *m)
> > +{
> > +       size_t copy_sz = min_t(size_t, usym_size, sizeof(*ksym));
> > +       bool too_long = false;
> > +       int err;
> > +
> > +       ksym->sym_addr = m->addr;
> > +       ksym->sym_size = m->size;
> > +       err = kallsyms_copy_str_to_user(ksym->sym_name, &ksym->sym_name_len,
> > +                                       m->name);
> > +       if (err == -EFAULT)
> > +               return -EFAULT;
> > +       too_long |= (err == -ENAMETOOLONG);
>
> nit: if (err == -ENAMETOOLONG) too_long = true; is just as short
>
> but also you are eating any other error, maybe write it so that
> original err is preserved as is, not special-casing ENAMETOOLONG? if
> you get EFAULT later, original error still takes precedence

Sounds good- I'll simplify this to preserve the first error via
something like `ret = ret ?: err` without any special handling for
ENAMETOOLONG.

[...]
