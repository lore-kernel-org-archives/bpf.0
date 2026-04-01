Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8A3DEFED
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040797; cv=none; b=Qmj+OW/OfssnezK00+6BY6D65w7Kd1dyVEDQRzrx414cbv47rumZXSaddZgruJhM6h33y+ihIPxvhrXu1/IDo3n+emZDh1AYyQeAMQDpS2vpQWAbPY0yTMtv9LgsMKPGXvIKSusuHttCear6Sq/r1QE81N/i96cJRwW64XClb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040797; c=relaxed/simple;
	bh=UvyDyyW62o/2RLTvRuroInPpDO903kx2ZQTtjJhdI6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlIyIZm9gtvk3ubWCKhDj27WPCaWR6tInyG5PoS/1eLmGxj6mMHpYetiVNnXEOvV2Q5uGFSJYP+ZGYFUT9z1Ydvn17+uHed2eUOUsgWv9iCJdZ7DrPCj0cBw4rRyTdx5kW2ruPqtetcv3FDLksA9DdY6xVEg+Shc9moaO6Wz16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD3yVIJJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD3yVIJJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab46931cf1so5422485ad.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775040795; x=1775645595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1cDM+9ZaY5XHKgHPK9aHCTW+oushVX4JCMP/tcbrFk=;
        b=SD3yVIJJf0Sgm9U36qdaIqSS3c/cMm7jSpb+SgVWA4/b34k5JAmIju8dCukubX2AFa
         5JgriHmLpDsAyWnxuudAIGwQwuHe0N8juLC4a0aUIQpwpKOCIYZsQKgEj5TO7YDrVeou
         qiDxu8Q8G1a75w2+P67ZQlF3RBSIPuJQIYxlG3wA05CYtW0oYhhxeOVfGkDMEFj6ggNl
         WFTIhkl57vUIKMAr6UUXirFDh3MMhsOj/w+CR8se3nup9CpmNRXlcb8181bMymmuUARk
         GLRIpQYEbqe1jVkyiJYnN4IR5DBHjOp/f5Fofnx9eHsASRyu63PbTL9dqLTkN1j2w8cY
         RyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775040795; x=1775645595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1cDM+9ZaY5XHKgHPK9aHCTW+oushVX4JCMP/tcbrFk=;
        b=jh0HH+SMaaXobLDUh/i3itF4ltx/OywGsUYEzogkX0ayaoFFxWcIjyfxFjhdgR5jGb
         C9mW5KXxZ2eugG0A4XYs3XiWzje82ZRlswNnAvjQssn0rnOnTZqMlmUGq4FtnINs86th
         07Ig/7kxOcwPoLm8eMK36DkH1LK1yLKEpuJT0qYOJ0rzCq4dM5emjVaKoB2JSr8wTl7k
         K0fZWfQZYrE6Ii3pjlRuATXTeIQeku8mYKkzrK/unCLj5H6XtRiVGeukyFka2Itrcykg
         gL5reeyTxmTBGMkvG1kK/1o7Tghz94BixwrLEGPQyPmgzaIJbIcCE88R+TIrd3x+3nq4
         r/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVL78ZEMIYq/cFqcOJJO0cg0y2daGf87fosPeW4Pdl6H1Obn13rPeQ6T7zxg9m/HDgaok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXU+79Ky5VzDMknjHhebHHfp1xXJHK7VbD1Fanv1nBkSHjMYGD
	lNcv8RftIsJd6+SJCkrFrbOjGa5yQWzZ8d1zzqRHRNQudLUEsxjJlt+T
X-Gm-Gg: ATEYQzyEpijqnTwpxFkyGzhIgQs728ws/GZI6nEUaj+3J5GWJle5BE52/7xt+GzjMdP
	UL6uA273mwHFo9jDSoE4NFu5H2ihryvkbAJ8ovPY3tzgPaPgcEcaNPBq9LCZ7zMyJeEUEUCzTSi
	qHj+tu2NeiYI3d17FOi2Gq/x36i2V9TageCGPkrHY9PPVlZx/2FdkKLwwV2SREuW/RZqqm1NsgK
	7AYMT2hqMmhnxZNETfj8jDL/UihOYamlHeNgUhE9Uf1AI//OUSe+2Ccy2/0Hz20AmC0IXozpqqc
	qEO/WpwW3XxzJ53ZZRO4XhXUaoM7m9ItoehuFnsORMzIaf99p/bgrvAVEcnyYmYlhXMl84f90vp
	cGJWJ2FKVNMSQQG4zrTt3cEvkjsX/GRejxso8x+7/S666XNSvAJoU4GnpPBA7I/1j0poYIS4H/5
	GYEspe1rLzZcws7NuoDjpHtXUY0ZFy8Buukl7yDU19
X-Received: by 2002:a17:903:124c:b0:2b2:53f5:461f with SMTP id d9443c01a7336-2b25ef9ece3mr65034055ad.25.1775040794851;
        Wed, 01 Apr 2026 03:53:14 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24265aa9fsm138622335ad.20.2026.04.01.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 03:53:14 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:23:03 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev, 
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, eddyz87@gmail.com, martin.lau@linux.dev, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, leon.hwang@linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 3/3] libbpf: Auto-upgrade kprobes to
 multi-kprobes when supported
Message-ID: <aczsqSHLdM1KtFFH@computer>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-4-varunrmallya@gmail.com>
 <acqOcnYHvG4GUgwN@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqOcnYHvG4GUgwN@krava>

On Mon, Mar 30, 2026 at 04:53:38PM +0200, Jiri Olsa wrote:
> On Mon, Mar 30, 2026 at 04:30:19PM +0530, Varun R Mallya wrote:
> > +			const char *sec_name = prog->sec_name;
> > +			/* Here, we filter out for k[ret]probe or "k[ret]probe/"
> > +			 * but we leave out anything with an '@'
> > +			 * in it as kprobe_multi does not support versioned
> > +			 * symbols, so we don't upgrade. Also for '+' as we do not
> 
> hum, kprobe versioned symbols?
Thanks for catching that! Removed.
> > +			      (sec_name[9] == '/' || sec_name[9] == '\0'))) &&
> > +			    !strchr(sec_name, '@') &&
> > +			    !strchr( sec_name, '+') &&
> > +			    !(prog->prog_flags & BPF_F_SLEEPABLE))
> 
> is this check necessary?

I had to add that check because selftests/bpf/prog_tests/attach_probe.c
was failing. Sleepable kprobes are not supposed to attach successfully,
but since this was upgraded to multi, it was doing so. So, I had to stop
all sleepable kprobes from being upgraded to maintain compatibility.

I'd like to know if kprobe_multi is even allowed to be sleepable. I
could not really find any selftests or patches for sleepable kprobe_multi
functionality anywhere, so I just want to check if this is not actually
intended behaviour and we are missing a check somewhere.

> > +				prog->expected_attach_type = BPF_TRACE_KPROBE_MULTI;
> > +		}
> > +
> 
> maybe add the upgrade logic into separate function, like
> 
>    static int upgrade_program(struct bpf_program *prog)
I am thinking of making the return type void though.
I see that there is int everywhere else, but it does not make sense to me
to return an int here since I'm not doing any operation in here that
could return an error. Should I keep it as int or make it void ??
> 
> >  		err = bpf_object__sanitize_prog(obj, prog);
> >  		if (err)
> >  			return err;
> > @@ -9924,10 +9942,12 @@ static const struct bpf_sec_def section_defs[] = {
> >  	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
> >  	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
> >  	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
> > +	SEC_DEF("kprobe.single+",	KPROBE,	0, SEC_NONE, attach_kprobe),
> >  	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
> >  	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
> >  	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
> >  	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
> > +	SEC_DEF("kretprobe.single+",	KPROBE, 0, SEC_NONE, attach_kprobe),
> >  	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
> >  	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
> >  	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
> > @@ -11769,6 +11789,25 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> >  	offset = OPTS_GET(opts, offset, 0);
> >  	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> >  
> > +	/* This provides backwards compatibility to programs using kprobe, but
> > +	 * have been auto-upgraded to multi kprobe.
> > +	 */
> > +	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> > +	    offset == 0 && attach_mode == PROBE_ATTACH_MODE_DEFAULT) {
> > +		LIBBPF_OPTS(bpf_kprobe_multi_opts, multi_opts);
> > +		const char *syms[1] = { func_name };
> > +		__u64 bpf_cookie;
> > +
> > +		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
> > +		multi_opts.syms = syms;
> 
> could we do directly:
> 
> 		multi_opts.syms = &func_name;
> 
> jirka

Implemented.
