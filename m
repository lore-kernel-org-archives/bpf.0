Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08CD3B0ADB
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037384; cv=none; b=AsA6bBG5f7xpwMZhleWSB1UkK8L75i8ipFM247dbpt9k+Z76QraAEWBcbRPApGhdXwVUR6FHt7FktwHdoBY3gGkP0kOiHmAzqi9ebQ9No3Eyj+FNpsnjxh0iexy8JD1gTe0ZBdfH6ZVT3ZpvHvjwELUIkEEgqkw0tNPlvR1ZjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037384; c=relaxed/simple;
	bh=8B3vJOPZb7/rn1u7I7i55sG7LiSYRyvb5TpVCfoY1GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3cdgMWzPnaOWDaxIWYV5MtwPj58RhLzDBQe1ljwWupqwtfovdhnBM6Jt+tmetIbcaUmwIso3IEnBLCHYI+YHP3DmrWwL9nnD+h67RdZOXni7yr+DPljO7PrxbfUUQvs7hlNGgbOkgfWfbG0R8WkcycXM6eLkqm/fw9Ygl0qVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qomy3z93; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qomy3z93"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82735a41920so2202889b3a.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775037382; x=1775642182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Th5pq1qyxZ39kb6RF1ERjw8ew05Ff4fiBhuPS0RJP2g=;
        b=qomy3z93vNUmTnjPGeAnvhapZdwLBGXUdUSm7Wyn1PFZvIUIvhN583HpF3Fin7C1Cv
         m8WCn44hTy+TFWuR75vP/aWrPajEjugsgmNQiser3l+OR/bvTgsMZBD31cKSeKEqBAR/
         GLXOakrfL24u3X5ivuulays2dzoo/EQVoc60JEIoGjkQgqT2Ffm5yHB0dz4X1gUITeRh
         pgi6yaFE/rxfrGoG6nP90atb5/CZRQRKKioIYoN3p2olfOLw3vWSQNqaLcPsOXqfXU4h
         tmlOUYWm8Iw4aPsCU+95oODEdTV/00dMlAJ+KDQW+r1tn7pJAutzQbYeToCIbnYDJtdJ
         umtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775037382; x=1775642182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th5pq1qyxZ39kb6RF1ERjw8ew05Ff4fiBhuPS0RJP2g=;
        b=lTC2eHDiEjBLlcxCPc3N7YXHAZSnSmIHRWxXVFaoM78z5WXyzRYJbgLbt2Rsp4wuY5
         gSlGI6C4HSoFx5dZB7gVE9tl/igtVJD7OK8wVDZadhZ8MTALU/ACSHeZVNBkz8yETyfe
         02mfwlkKWO1aoeQDfxQVjPwUrz7Oet8BRp4wn867G35xsUcSxEINzS+JxiKbkssbFHoB
         UMaUJDJCoRYvq8NHqRBIQ8hoxyd8I/bJLyBebWKql95uI2UDKB8Ai49+mFI0vgyFqsgp
         QGW8hAvlKKBW1+S6vSfzGp+SxpaJDFJWIVqJpEPsfpMFgO6RJatvUBFAROnO2nOtmehd
         888A==
X-Forwarded-Encrypted: i=1; AJvYcCVsCLU9XI/ts2UrI+4hGbo8XCyi4lyzZ71fHwDD57GUetv9Xm6n3M6c5rxvKo6gDKhrrlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5OrSyiSFg5aElp3OvLKOau/KZGxbnQTuwpLpc8UXy7/tYh9E
	sv6xm+fF3cmWikEKOkEQiC2RMGe7fPAhzKkNwGf6k5lCE49g8DZ/Dlwb
X-Gm-Gg: ATEYQzzsBzWYdy2yKtXPPOfNLArlESO0/yiD9bE0itaBfY6s27XwKFrQAZ3crr0h8xI
	XaIErB15Jf58ph1hAuzTCvNWVF5BrXYOmv4tXkecGPUsNSdGNFAKALjOJQGfxKcpDQWpAU8WcK8
	d9c9o3snRM/jLG+kVlIqmHXAUHsGaLprjQjuRr9rzzXWFNmWQ+PYVrjRM9/nPGbA0NI7ogZsTsW
	DTZRXinSoQMI7vS56Jyv9JfwOin+4ttgYNc6hoeS7oTZ3ks/lIM6YaXZy1j1O4NZIvONzVnE9s1
	0ZbtydCqD/VNZmp4ChLXxCyMLZIYcEzccRa52k/iakCVhFvyMlEYP+eY8G4yXEmoVi0qJLDklM5
	pCp+DqAq/Uwsw1No8/GPcdnrAjvCRpQHfAJkXXAZKiQnTGoznvDNE2Ho+ifZb0IpDWI4ALonKxL
	FkXQ3HC0MhlupTJD9G06oo6Hpbp4FVj5vA9KwUNZWq
X-Received: by 2002:a05:6a00:1ac9:b0:82a:5d55:5807 with SMTP id d2e1a72fcca58-82ce88c385dmr3229496b3a.6.1775037382094;
        Wed, 01 Apr 2026 02:56:22 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ceb1de4edsm2161024b3a.39.2026.04.01.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:56:21 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:26:10 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev, 
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, eddyz87@gmail.com, martin.lau@linux.dev, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, leon.hwang@linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 1/3] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
Message-ID: <aczqZPJKv4XAOS1i@computer>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-2-varunrmallya@gmail.com>
 <acqOKws88JsU3riu@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqOKws88JsU3riu@krava>

On Mon, Mar 30, 2026 at 04:52:27PM +0200, Jiri Olsa wrote:
> On Mon, Mar 30, 2026 at 04:30:17PM +0530, Varun R Mallya wrote:
> > +			const char *sec_name = prog->sec_name;
> > +			/* Here, we filter out for u[ret]probe or "u[ret]probe/"
> > +			 * but we leave out anything with an '@'
> > +			 * in it as uprobe_multi does not support versioned
> > +			 * symbols yet, so we don't upgrade.
> > +			 */
> 
> nice, I missed that uprobe.multi does not support versioned symbols,
> I guess we should fix that

Thanks! I intend to fix that after I am done with this patch.

> > +			if (((strncmp(sec_name, "uprobe", 6) == 0 &&
> 
> str_has_pfx ?
> 
Implementing on v3. This looks much cleaner.

> > @@ -9909,9 +9926,11 @@ static const struct bpf_sec_def section_defs[] = {
> >  	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
> >  	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
> >  	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
> > +	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
> 
> should we add sleepable counterparts?
> 

> >  	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
> >  	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
> >  	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
> > +	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
> 
> just an idea for discussion.. I wonder if it'd be better to add new uprobe
> section that will upgrade itself to uprobe.multi if it's present, instead
> of changing the existing (expected) type
> 
> but I guess we want existing uprobe programs to benefit from that and
> there's not really a reason anyone would want perf based uprobe when
> uprobe_multi is supported
> 
> ok I talked myself out of it ;-)
Yeah, that does seem like it's redundant. I think integrating this into
uprobe and kprobe is the best we can do. I have tried my best to ensure
that it does not really break any current functionality though.

> > +		LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
> > +		unsigned long offsets[1] = {func_offset};
> > +		__u64 bpf_cookie;
> > +
> > +		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
> > +		if (offsets[0] || func_name) {
> > +			multi_opts.offsets = offsets;
> 
> could we do the same as for ref_ctr_off case and drop the offsets array?
> 
>      multi_opts.offsets = &func_offset;
> 
An artifact from a previous version. Fixing this.
> > +			multi_opts.cnt = 1;
> > +		}
> > +		if (ref_ctr_off) {
> > +			multi_opts.ref_ctr_offsets = &ref_ctr_off;
> > +			multi_opts.cnt = 1;
> > +		}
> > +		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> > +		if (bpf_cookie) {
> > +			multi_opts.cookies = &bpf_cookie;
> > +			multi_opts.cnt = 1;
> 
> I think it's better just to set multi_opts.cnt = 1 once outside those if conditions
Fixed this as well. I think it solves a part of the AI review as well.
> > +		}
> > +
> > +		return bpf_program__attach_uprobe_multi(prog, pid, binary_path,
> > +							NULL, &multi_opts);
> > +	}
> >  	legacy = determine_uprobe_perf_type() < 0;
> >  	switch (attach_mode) {
> >  	case PROBE_ATTACH_MODE_LEGACY:
> > @@ -12830,6 +12875,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
> >  	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL, *func_off;
> >  	int n, c, ret = -EINVAL;
> >  	long offset = 0;
> > +	bool is_retprobe;
> >  
> >  	*link = NULL;
> >  
> > @@ -12856,13 +12902,14 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
> >  			else
> >  				offset = 0;
> >  		}
> > -		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> > -				strcmp(probe_type, "uretprobe.s") == 0;
> > -		if (opts.retprobe && offset != 0) {
> > +		is_retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> > +			      strcmp(probe_type, "uretprobe.s") == 0;
> > +		if (is_retprobe && offset != 0) {
> >  			pr_warn("prog '%s': uretprobes do not support offset specification\n",
> >  				prog->name);
> >  			break;
> >  		}
> > +		opts.retprobe = is_retprobe;
> 
> is there any functional change above? looks like just opts.retprobe
> is replaced with is_retprobe ?
> 
> jirka
Again, sorry about that. It was an artifact from a previous version.
Fixing it in v3.

