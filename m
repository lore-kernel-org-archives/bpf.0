Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666590;
	b=bDuU9MCuqYdpAKgr3kPqH6ozZouy985H8ZVej2ZzE+nbnbc7LV0XwlhqoQclPfLN9K2H
	 GzuFubmKdpyVVQm82ihVxF7hmiLzqu9u6wVmBCj5j8vwwZirerMQsd2SjF/iRgfiA3qzG
	 dOAxqtKQ3QhnETqI/iM9BbWpohN7C9DZZ0EEI6i9iLkcaPuGG6a55dlwYqfRYaLiNYWUe
	 cXROtvCFd7wagoUBw1Zf5RfPQXKpuRgJ9/6xybPncEvRdzyGa8czSprfq0n8Y5CCrR35t
	 /zC4MZHjQPJNyY4pzyOA6kFpv/0sziTplY4V0z2bqoliJRtCWYqNZzG59aGyadsseYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f7HvEUVX2tM63yR8jJepOym4Rh82WzMm5BKq2XP3tdo=;
	b=HdXbsetPGdoTz2UWDlJbv06LNy1x/HXWVHma2IZ/m65LVpV/85deOSCxFz3jp2wB/JH0
	 J/hal5zRL83AcGLn7Vbntnuj1m/NgHbOWE+qKiJPMjhU3MKm6X1VERuxsd1p0kQKjxgNE
	 6qV7gr6XjQ932VcmyDRLrJ6BEA5TqIxczZLaw61SnpoEtvZ5cZJLKYgY0LFxbuWmlFH4g
	 wsejq3Mb9q9rtfiFSTxjMlBIm7RCjwT06WkPXucFfCmpjdRYLrMuFlFLZ4DLmsvDTqa4t
	 1ZZ+xOH3Z32KuPH+Atq41cPMuprRQ0/r1MBWKzRChS8wuWDfpLDJehrjvo0Xyi9/gfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpXUScZA;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB7606A33F
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CDB7606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpXUScZA
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb61185057so4201265e9.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794666588; x=1795271388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f7HvEUVX2tM63yR8jJepOym4Rh82WzMm5BKq2XP3tdo=;
        b=HpXUScZACECxG4WhYK9jGinw4ofm8bkHLlHgC0rBsHtIayapJcUt8XtJ9A4FyTa+0R
         b11ZZl2iA9Rt1NDyvpXbeIbx/vRd5ZvFj5w1jFmYZeMLRs9m5fVvDbY3vrjzhSfID396
         mOAkiNkyBVDYGyFsa/NpUbcwMPhaFxsa1fLW7EweVi5rQKuP7G4cM2ZTXVJdeTpTeBAD
         SRDgnS8P+coEsSP/TyqY71F+vuh57tkCCTVD0a4jCahViewn6GustfvWM28hVIWR8R2j
         nj0/m6qQQ/P474IGCzI1zcrvTFZEhdaRMpal5S55MO7kkJ3J/gu/oezSqKL6jJNz3bHr
         Chnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794666588; x=1795271388;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7HvEUVX2tM63yR8jJepOym4Rh82WzMm5BKq2XP3tdo=;
        b=Z5IhUfMa9GtSjaEoyqW/a9gzEtJteMpBPENVj3l5fm8x6J+GWown82s3JWO+w2gwRj
         OPgFy/pR+kf0Z/oN8RPrvPCCjhv53j4q5MHfheXA1Mr5PPqA+nmLdopdUPzLBzjyWJEU
         2yHzMLJoXgy51Qq4092/P+NhVRgHMKy1Ppq9XoiLawDigemcMzrHFG6ZC7fFd7Hj77j6
         5CF+hc7WqwIMApUOR74Py+dPUOeZ6mqsMUtGnDQZ8zVyUkRsLpnV54iLzSgxs+5AyQH6
         qVT9/6ksU8I0tuy/zbhHORt9BQVD9lYV6hNmn+VFKwQ4n8M51NtL4sDQuLB+SYROyNXi
         +nfA==
X-Forwarded-Encrypted: i=1; AL+hErGpgK9vakTGZWjkIwJAWoy2Ri7jyXaxYCkQGrphlWjOoyulVV6WOV8E+sIBTm7qcBNEH9I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TSB4qOyNSDpO08FDdSI8k8lG7Wd3ysLUn/dm7tQ3RlkP1yNWi
	9wf1BbdOhWSM34CkBhppqI8h42w9XgWZY93UCoQFto++f2HJEJyzQz1d
X-Gm-Gg: AYBFou13JVQ26P9a5ngr9YfIUaYYbZPsckckE8p/Jd3SaLzQqk8OGlLFBxH4bBaIZK0
	H2uCE/Wv/5JlWReMqNMTr7v5UJiKJjBt8/9UcCVnrwVsH9jcKtSXs7N34UwDq1UIlX3MuIEftQa
	KmPvKa90/wBcFvb4kll2AOxHZv4uOV7doOmYlbj9R+Lm67yKC04C0B3WrTVNkG/n7qjTdjOlrq9
	BRkI7D7tZjDd1frWNyv8iEAY+ccFTi2kpkRLUudNyM9z/gnuI4PlIbrdbT/uj58269npRj3Ast/
	TNezvE06FemQAqWVOQ/XiPD/JcuVcP2KsKJfNIGgdUSOzEQNqIoR9vXieUWEPDrYISP9dmzMU2M
	AOUjuWs/mMFVlIDCVIAMmlb3WWm/GHh7XHOgKQWZka1Riw44oQrr48S6y/iNzMm9SA8KFl1/nl2
	/RB0MpSmVnqsP5rWGtLDFBGdw4bfIhwmdBCEbLN5CtHKRwxkO3gh3I8+gpUI3kdquzKAdxanMFN
	E1jja0an/FzdjWM2xs5zoFYHk3UTvLChOQ9Zgq69/TkkSVkdcj0LLAToTh9i6RzBcfl1kTQQNGD
	37DpHfkCVzgCkcJMH+NuqPIPWU8kFGG6w75RqYL5gkh7kUonr7i6T47EK3bt2FevmQ==
X-Received: by 2002:a05:600c:a0b:b0:4bb:685e:cc41 with SMTP id 5b1f17b1804b1-4bb685eccc8mr17988175e9.8.1794666587612;
        Sat, 14 Nov 2026 06:29:47 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56f8d054sm92922965e9.3.2026.11.14.06.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:29:47 -0800 (PST)
Date: Sat, 14 Nov 2026 14:29:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: pmladek@suse.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, jim.cromie@gmail.com,
 ljs@kernel.org, mcgrof@kernel.org, andrey.grodzovsky@crowdstrike.com,
 rostedt@goodmis.org, andrii@kernel.org, wusamuel@google.com,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 next 02/13] scripts/kallsyms: Improve error reporting
Message-ID: <20261114142946.4d696bc5@pumpkin>
In-Reply-To: <8c6f9e7d8a4cb037b480c22ba2b6866133292bbd68ebdc777e385373950b793f@mail.kernel.org>
References: <20261111115911.1142000-3-david.laight.linux@gmail.com>
	<8c6f9e7d8a4cb037b480c22ba2b6866133292bbd68ebdc777e385373950b793f@mail.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 23:33:55 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> > scripts/kallsyms: Improve error reporting  
> 
> TL;DR:
> - Error message for failing to open the output file says "nin.out", likely a
>   typo for "out.bin"

Indeed - will fix (and in #4)

> - usage() text for --all-symbols may be inaccurate: it covers all sections,
>   not just local symbols

It'll do - needs to be terse and it's a build tool.

David

> 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c  
> 
> [ ... ]
> 
> > @@ -822,6 +824,25 @@ static void sort_symbols(void)
> >  	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
> >  }
> >  
> > +static void usage(void)
> > +{
> > +	fprintf(stderr,
> > +		"Usage: kallsyms [options] vmlinux out.bin > out.S\n"
> > +		"       kallsyms --sysmap=out.map vmlinux\n"
> > +		"           --all-symbols     Include all local symbols\n"  
> 
> This isn't a bug, but is this description of --all-symbols accurate?
> 
> In symbol_valid() the option only disables the text range filter:
> 
>     if (!all_symbols) {
>         ...
>         if (symbol_in_range(s, text_ranges,
>                             ARRAY_SIZE(text_ranges)) == 0)
>             return 0;
> 
> so symbols from the data, rodata and bss sections are included, global and
> local alike.  Local text symbols are already kept without the option.  This
> also matches the CONFIG_KALLSYMS_ALL help text, "symbols from all sections".
> 
> Would something like "Include symbols from all sections, not only text" be
> closer to what the code does?
> 
> [ ... ]
> 
> > @@ -845,49 +867,57 @@ int main(int argc, char **argv)  
> [ ... ]
> >  	out_bin_name = argv[optind + 1];
> >  	out_bin_file = fopen(out_bin_name, "w");
> > -	if (!out_bin_file) {
> > -		perror(out_bin_name);
> > -		exit(EXIT_FAILURE);
> > -	}
> > +	if (!out_bin_file)
> > +		err(EXIT_FAILURE, "failed to open nin.out file %s", out_bin_name);  
> 
> Is "nin.out" a typo here?  usage() and the close-time message in main(),
> 
>     errx(EXIT_FAILURE, "error writing out.bin file %s", out_bin_name);
> 
> both call this file "out.bin".
> 
> The string is changed later in the series by 317dc01f3774 ("scripts/kallsyms:
> make use of binary data output optional") to "failed to open bin.out file
> %s", which still differs from the "out.bin" used by usage() and the
> close-time message.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43116767394

