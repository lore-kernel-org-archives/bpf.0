Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4039281F
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037588; cv=none; b=W0SikedvZxT63SyeiKTQBsevvZvKpJCz4eJOpBdjR26s18boZyYJc/qvUnKUfNWElu23gsJ3Td02/fBHzntD8sbV5EdRawazpkRDX91NWXmVrt0fXg41O76zjPH976aaHygMG28DmCykiKv+CCAnTC2eWG8PTpo+V/+Ka5pgCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037588; c=relaxed/simple;
	bh=ycUEdA2x+MJTDT2g4Oi10cO8WuuS+tfm1q2PNLmAaS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkeNCYEQNjgtKPPZ2vvPd4aebTJ9gozgC1cYejv18oImL4irE7RO3wZBfS4htRztLxYaRzZYWkRmE942nYm8dAl7BU+h43zs/lLhWRjm8KsV9TA8YsH8r+H109HNwQpYltg6ZTKqqPlmllLUYzV2iclf0yNXLdMmkxLUnRf8Pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kafSk2Qd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kafSk2Qd"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2687242a12.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775037586; x=1775642386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGZSfzYmOxZUsSdlNf6ON97guqDpcO5sFhVaagpb4Kg=;
        b=kafSk2QdjnznkIR2yZEwHrNhCWZZyuMXV8t12ZilUMr5N77bvOwmBHIXaKBS25T6Y9
         X8pqAmfre8ZTUaJxSXh9EmzSlZm6DcgULm8iWY+ZbzhPG9VdBxBiLTrHpt75+9O6pj3j
         9xNA0oyO+CXL/CzrooEHq9zBSUwz3xi7NN+R2afyFgQxKhA0u/hGLOb3X4AnxOhr+Aum
         iBJ2eP0bInX4KzuZSqskak63N0X+6Z0/4vcvtyhswobZCs8egXZ7eDpPllKbmp2ZjOSJ
         DET6CvnMd2SiZfZhYpTlKEMmY7LmWHeAf0DTa5taoDHTJRRJ3lSCYKQVAhPLTM25YDtr
         I5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775037586; x=1775642386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGZSfzYmOxZUsSdlNf6ON97guqDpcO5sFhVaagpb4Kg=;
        b=Ze1X8MmI9NKNb0H3kr0rOsY8Rc/bAI7ZG97w2/SC/RAkqdJkw12CMFMrg86S0wB2fh
         aFB666P9x4/LDCvkdFNlW1P/b+9TeFzit+Yv5Db7LTxdo7TsLIDicIPUrAuZKW9hsF68
         iKfn21aDiPn4kmQwUVJKUD34c0vmYFgrXhxHPiXzNeuSHg5ILIp/hmrA27XOHV4asBf/
         8xuDnCZhAjJv8RyT51gyt3/6HYWUNoxAFNbRM4HkWjlRgwi9d+JE38iOYIinThS9GPRy
         I8zhKNpksoVJesKhThBpO/WaUHw7xUCLT3Cz5RmOaZXUyXysyW93Jwphnb/6m8vPTY/E
         h44Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKiB7XCxnmRRwADYrl7ybAVRWISPcZc+mAk8rtOcoPUQ8hpVGnHTa5K5V/sCKwjulaIfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pDxlfoXW1KJAOzSv2XfCX8rmvD/AGTTBalW0+uOs+5S2x51k
	6spir+AHkroL8gI5nfutK9x6oikg1oVIMktr/2eGPM7bOx3YxP1uNHKE
X-Gm-Gg: ATEYQzwNHOsVQcrYmQM/DAVCbakRN8TrYFwtDb6jX8B86xocjvG1hgxFyUu/6DjtYJX
	Dom9RrMc+cfR8/kaNG9bKGHw2tUWAyrTW82QL6njJLU2N2M/WhisM+bEM2pVAVOtgtuUgxsNAFi
	/cJJYQ67lHCSkyCk3wvJt9muFewXpF/3dGVaWD4EBlsLnr7KdzMlQC1IaNHiPMbkkJh4P5hLuWr
	wgAogIZods5a/vGkJ5I7f/b2MWa4+2CT1g+4Y719SpiwP1tPnOEZMxHbtS3SXPAztivMgYcyv0E
	s9TO58PvEaYEedGCWCez5lrf66HLL97Tpse4Xe8zdoFA36Ecxkm0uPi+dyV8MPTljIVwTIYkCvX
	Zp+UtspVOF4F9COcoaVgwWZbypFGSxBJVQVNO9x4ceGmcQW5Z1era4WSLzGrL5ywYG7KGYBsag7
	Jzx8Q6ZJMM9Vn1ME91X5Fs/4U0yx8lqH5M73hN1AaF
X-Received: by 2002:a05:6a20:94ca:b0:39b:f0a1:1495 with SMTP id adf61e73a8af0-39ef7754357mr2819652637.52.1775037586082;
        Wed, 01 Apr 2026 02:59:46 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b9c20473sm4025536a12.24.2026.04.01.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:59:45 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:29:32 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev, 
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, eddyz87@gmail.com, martin.lau@linux.dev, jolsa@kernel.org, 
	menglong8.dong@gmail.com, puranjay@kernel.org, bjorn@kernel.org, leon.hwang@linux.dev, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH bpf-next v2 3/3] libbpf: Auto-upgrade kprobes to
 multi-kprobes when supported
Message-ID: <aczsYZo08vcha6Rt@computer>
References: <20260330110019.549079-4-varunrmallya@gmail.com>
 <d5f1a4484d26fbff3aaafd358025dffeb2ba3cbff9c35c1643e4b0ab503201d6@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f1a4484d26fbff3aaafd358025dffeb2ba3cbff9c35c1643e4b0ab503201d6@mail.kernel.org>

On Mon, Mar 30, 2026 at 11:47:26AM +0000, bot+bpf-ci@kernel.org wrote:
> > +			multi_opts.cookies = &bpf_cookie;
> > +
> > +		return bpf_program__attach_kprobe_multi_opts(prog, NULL, &multi_opts);
> > +	}
> > +
> > +	legacy = determine_kprobe_perf_type() < 0;
> 
> What happens when a program was auto-upgraded to
> BPF_TRACE_KPROBE_MULTI but the caller passes offset != 0 or
> attach_mode == PROBE_ATTACH_MODE_LINK?
> 
> The redirect above is skipped, and the code falls through to the
> perf_event path, which eventually calls bpf_link_create() with
> BPF_PERF_EVENT. The kernel's bpf_prog_attach_check_attach_type()
> in link_create() rejects this:
> 
> kernel/bpf/syscall.c:bpf_prog_attach_check_attach_type() {
>     case BPF_PROG_TYPE_KPROBE:
>         if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
>             attach_type != BPF_TRACE_KPROBE_MULTI)
>             return -EINVAL;
> }
> 
> This affects callers of the public API
> bpf_program__attach_kprobe_opts() who have a SEC("kprobe") program
> that was auto-upgraded but then manually attach with offset != 0
> (the get_func_ip_test.c case) or with PROBE_ATTACH_MODE_LINK (the
> test_attach_probe_manual.c case). The selftests were updated to use
> .single, but external users of the API would get a confusing
> -EINVAL with no diagnostic.
> 
> Would it make sense to add a pr_warn here for the fallthrough case
> when expected_attach_type == BPF_TRACE_KPROBE_MULTI, suggesting
> SEC("kprobe.single") as a workaround? Something like:
> 
>     if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI) {
>         pr_warn("prog '%s': kprobe was auto-upgraded to multi but "
>                 "offset or attach_mode is incompatible; "
>                 "use SEC(\"kprobe.single\") instead\n",
>                 prog->name);
>         return libbpf_err_ptr(-ENOTSUP);
>     }
Nice catch! I've added a check for that now. 
> [ ... ]
> 
> > @@ -12269,14 +12308,24 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
> >  	*link = NULL;
> >
> >  	/* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
> > +	if (strcmp(prog->sec_name, "kprobe") == 0 ||
> > +	    strcmp(prog->sec_name, "kretprobe") == 0 ||
> > +	    strcmp(prog->sec_name, "kprobe.single") == 0 ||
> > +	    strcmp(prog->sec_name, "kretprobe.single") == 0)
> >  		return 0;
> 
> This isn't a bug, but the comment above still says SEC("kprobe")
> and SEC("kretprobe") -- should it also mention the .single
> variants now that they are handled here?
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23741893093

