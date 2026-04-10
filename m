Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4C39E184
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806574; cv=none; b=dx3r/rwO7R4l17i1bqdM2hTQsaU7JRfPlGIrsxzGmmkH0GfF+K7Ne/PvMQP+bAYRe25Qly+3g/kUj9YWH96WYNrbuue57Nt9x+QMzH1m8zswjV0BRw1+z3jZKCrOwmqP7YncZuX9ViCdsZ52GkM+oEjHPuMYRx5JfMs9SHa6CWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806574; c=relaxed/simple;
	bh=zEar7jNbeTsj7AgTCmnaOTu2tk3RkezFjKF8QsxfeRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmj3o6f5PugST1DhuELOrU3YgjGa+HGEVQ47V1fgRTTKkrGBOamtLyEIfzt7KjCQ7dJjUN7U9UPrjZjcN2xY1Lat1bSnuCtSXq5Xb75w9kO3zR14ueK/3Qv6iKEZP5G3qKescG2nvLtCYbwrmjiSH+JPpJenKnVNjzWUb6ZJ4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcqvU2Ha; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcqvU2Ha"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c124d2613so1155685a91.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775806573; x=1776411373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KPruYEMiGGlsbWCF6fFGicF2/m92unqASPFJR0GccI=;
        b=rcqvU2HaqkA8llknp3U4R7GF7g2yzjEyWlr9MVcxOYitzVX28LNIjoP5021ktCSTod
         c20eJ7ozKuPfrGcTLV73pOvjHeEyBO569cLzZQE6Q3Z3796mVlte4vVyD4EsQ89zVwQx
         KYPQbhDkksrYao4bjyvUBaim//Yi8Kv7a3o6NHC0DPUNapGQLLBfB32eKZoALCb/PA1u
         HbnxDGU/MvDjdKC5X0QgYAtR/2tsody/pM+o89NZv6Z3b7WiHRlmAyrNVjeoXCSzoGjm
         CO9arHlRfCFHBlGiAr8k+S1mXYU0bh35oS4Uku7eRomcwqGMVj0MKGHjWAlx5jVgQXVe
         +RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806573; x=1776411373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KPruYEMiGGlsbWCF6fFGicF2/m92unqASPFJR0GccI=;
        b=Kdh2Iefo9kGDFEF9OOo6yMJbviC5Mo7rQ2zlp11z3QpEYJFcBTnIbU/36bmADLeQ8k
         DSxePnf79w/wfIq4KSZrPpJdAzFVP4DMsJdQQ+MFLl9fmRCxslRQQMTHE4fPaeU6zc4Y
         zKxe15R4vWqdt/buZIvUOHlMc753h8iU26oOcN9oFVRbjNlpnEGo6fNwKYz1H/x2C0x5
         Pj8AwzqwRKegoDvyI0FP0SicE++EjntV4bfh7Y9hzPg4SBwcc2mq4pX9pqVnBZ/UWwwD
         QWUKZIz0G8J8Rha/G5b2ligb3GR2QGf1OFP1K7IjFB78osbFmbCgGlcuUJMW30UrJOBP
         AWEw==
X-Gm-Message-State: AOJu0YxYzQsvx8uf5MHNPjEXUH4jZ54qPIzTNgLzWEK6JOfOcLEz1yCM
	WiZW9cFSbXGbSEjeakzA83jq89VugU0aUUb1aGd0O9pja/+24mNTD0Zi
X-Gm-Gg: AeBDieu/kQwLz5TzZtQnnw1LFAm3igLgXOqjQfhZa2xraO9Vo32gpH8X0qL1GPeCq6Y
	6dGMoEMe3zjFe10pRnbNy5WDtdLHYYtsv1dz4+5BRG0hoT4BAhte5Kbiw8F86/G7UPkx271pMFw
	RMXVX1SvjQ2SeIqaEDslEokEcT5iCQhnjzTrO3FYKEkLDCR+Gq062RoTDXeYyxqUZrFXoQMrssA
	L+CAHt1KhKwFQZTmU2Thviqe79hWuqT/gISemYFyrqiTXjS8UgWqMP7TVarTPjEU8t06JN9tBC7
	LbSDkmNKZ/v6BOElOWskGVqbX65ij+Ki6g18WCrTjIzFVN8XAsZTbTSn8hrtb+3HBogdrpMTuZb
	LGwO5W1UJRnYEjkz03fcEmqTiQ0+dhSCN8yJC5Ul1T1iPeTNYhpE9GHPfRLsuQRHi4lz1MSqPWv
	/JFI27LMdkE0l5X9kuu+c7DCJlCu91aay90sgzg+MdiQ==
X-Received: by 2002:a17:90b:510b:b0:35d:97a6:11ee with SMTP id 98e67ed59e1d1-35e4284130amr2580475a91.23.1775806572655;
        Fri, 10 Apr 2026 00:36:12 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:277d::3ef:37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35178460sm5689036a91.16.2026.04.10.00.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:36:12 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:06:00 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, jolsa@kernel.org, leon.hwang@linux.dev,
	andrii@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
	eddyz87@gmail.com, martin.lau@linux.dev, daniel@iogearbox.net,
	linux-kernel@vger.kernel.org, memxor@gmail.com, song@kernel.org,
	menglong8.dong@gmail.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH bpf-next v3 3/3] libbpf: Auto-upgrade kprobes to
 multi-kprobes when supported
Message-ID: <adioYBkwLPzQiDei@computer>
References: <20260403124412.37449-4-varunrmallya@gmail.com>
 <ceb1b1cdd7512c5d2bbcb01dd0699c261e077fc92c08c2319f4311f0a3012b63@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb1b1cdd7512c5d2bbcb01dd0699c261e077fc92c08c2319f4311f0a3012b63@mail.kernel.org>

On Fri, Apr 03, 2026 at 01:35:31PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index bc749b9c291e..f566527d95f3 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > @@ -11841,6 +11867,30 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> >  	offset = OPTS_GET(opts, offset, 0);
> >  	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> >
> > +	/* This provides backwards compatibility to programs using kprobe, but
> > +	 * have been auto-upgraded to multi kprobe.
> > +	 */
> > +	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> > +	    offset == 0 && attach_mode == PROBE_ATTACH_MODE_DEFAULT) {
> 
> [ ... ]
> 
> > +	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI) {
> > +		pr_warn("prog '%s': multi-kprobe upgrade failed (off=%lu, mode=%d); use SEC(\"kprobe.single\")\n",
> > +			prog->name, offset, attach_mode);
> 
> Should this use %zu instead of %lu for offset?  It is declared as
> size_t in this function, and the existing pr_warn() calls further
> down use %zx for the same variable.

Valid, I'll do that too.

> > +		return libbpf_err_ptr(-ENOTSUP);
> > +	}
> 
> [ ... ]
> 
> > @@ -12297,14 +12347,24 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
> >  	*link = NULL;
> >
> >  	/* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
> > -	if (strcmp(prog->sec_name, "kprobe") == 0 || strcmp(prog->sec_name, "kretprobe") == 0)
> > +	if (strcmp(prog->sec_name, "kprobe") == 0 ||
> > +	    strcmp(prog->sec_name, "kretprobe") == 0 ||
> > +	    strcmp(prog->sec_name, "kprobe.single") == 0 ||
> > +	    strcmp(prog->sec_name, "kretprobe.single") == 0)
> >  		return 0;
> 
> The comment above still only mentions SEC("kprobe") and
> SEC("kretprobe").  Could it be updated to also mention the .single
> variants that are now handled here?
> 

This seems valid, I'll add this into the next version.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23947048141

