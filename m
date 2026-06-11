Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F03BED66
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170669; cv=none; b=aGA7fNEfproCs/ZfDAv2CjzMPTvppQuvS0A2iO7dhAGfwyhJrZpx6WJXfKFD9P/djsQiI82zJjFQg2FI9wtZT8COLBzRo2GSt5XEkSnVR0DQP8pa9VFnRwD+P/2WF/l6T+c1o2I5kDB+qkKmsWEG6+qCJMdjkYvT4KKu0qDeu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170669; c=relaxed/simple;
	bh=RXGWonNJsTpKp63dGZeF6C6rR65Jux1BlW8HHmSlvkE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI8PfOVH9A/1vOPbNlGKytm9pHqSsNRAAwUbRyzXyKFf81kIqyzSGO6nR5m5ffYhZaAEok7RKgXSnTJ/S+USJ2v5Ly9bUBZK+Qqc3fLryBGHbdh0p7SNUZxvx+bu/GeZd5gfXYde+ydXaqTVpIDyPKKxBlxiTn50EREyGeBDc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvCtlFKZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvCtlFKZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-460166910e6so4095521f8f.2
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781170666; x=1781775466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGaFz2qptunT/Ub1/2XY6XPkKOp0++7hetebbbs9weY=;
        b=qvCtlFKZxIzpclw6DLHvlhQo9ESgA1iBe49orRy2c+X4Y7kMDTKgNi0PmKz+o2xN1w
         evd6KHES6qNU2+bIic6jn5tca3NcVMqbb4r6iorqioLem6gEUruAoF7leXIDYqQrJWms
         fsEyQMmJaOdXLaW2P3Bq3roKdj0oX6iKdxeu+0pxQUdfPt7lSpgjhmtD8nOXuSEPQW2H
         UF90Bw/DFe+BDkFPGjcQTS6uw/620MeMJLLMUUJ631neO+3lJTDlfAenwk6bv1Hv93i+
         QRTkXrrfwDIifTism6a02UAUy/0HIfWVBfwormFRECP7bTm1ATOlKvmBmAlxkFYbclX9
         Y6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170666; x=1781775466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGaFz2qptunT/Ub1/2XY6XPkKOp0++7hetebbbs9weY=;
        b=msVDy/40Y/rR3cgb3FS7NxBxvmQEkryByYzhoHQ/nseCNT35qZeTaOHNYLRZOJ17SO
         sIKvTMseTxeXhM6+z4ACwkciMUXXYjRc3WFhRWPRUevgcvNE+1y7GF0w/yVKxHi7fPi2
         jCUscGOlm91nFeJ1dz/GQRPvy+5GSJ0YTBsNRzeDitS64aCsPhGnS+R634RDPGK7P9UL
         ilA2OYK3KoyDMV1GNU3w8LbBihvcxxLaOaNmiNkFttqCgAU9IlKbNO9iRqIvFZl0bX9k
         xe6EV3R5TrbxfdnY2d+EaODj4xdckrIdlK2n8j83dg+HOAjI+MdcqVzIBi2YLd6W0p9Q
         HAgw==
X-Forwarded-Encrypted: i=1; AFNElJ9COcdegR0QIhf1qSyLfC5cvz/diSTaNZwXucrO9qiYvq8nMzFoMNxr5EDfNLdEM5u2Ioc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw440SrM3/BemAuhj1iyCEmgeINUgpjstYirK9UFGwYh08VCXOT
	BqyywAjNv5+aNQWaFZAzBtBvh0XZGepwytdsECTpkPHVGMiceaCyDV3k
X-Gm-Gg: Acq92OGImzo0jO38Ws9t9BsDwROfJLmunqoxWUgAz4kB2Vr0kbLPIjCBNFsNfC/9hQp
	VmqqhjlvAYOHX/zvKlN9KOZwDYbtuMJm8KqTM1to7uOGecGz8MkhjljJzy96IXRxvpYj7W5aLHF
	VaZAWr2HwzMDhU4AbfJ3rx9iq1QMj3Xxo6CxnTZ3Vks+B+/vMfHz4X0yORrY3DBsHPJm8NTDZST
	eECR0yCSuFRbYLl1mrvCxUzP64Sr2R5rK8wDRXtMr6TyPGf5BY0Lxb4MfHXPWmDnMpSBs/SONqv
	c4E9T82KG89l5pCqJEo4fCvx7keWzbmboeiakIWZ30npWVy2+1EEJ4G+OSnTelss9Vy7QEWMxS7
	OUFnEAMeUclyQa0DfbMdpuMeC9aFj7frkhbqFhA+pMpMkVML2WZ30wSW8GEcRcxZRz4DX48fr5p
	NLY3N93B6gnuxLb81eEf8PCceICw==
X-Received: by 2002:a05:6000:2883:b0:460:1301:dec8 with SMTP id ffacd0b85a97d-46067576742mr3065499f8f.3.1781170666010;
        Thu, 11 Jun 2026 02:37:46 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm85495446f8f.34.2026.06.11.02.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:37:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 11 Jun 2026 11:37:43 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, oleg@redhat.com,
	mhiramat@kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 2/6] bpf: Add support to specify uprobe_multi
 target via file descriptor
Message-ID: <aiqB55NxlVk_dlmz@krava>
References: <20260610143627.804790-3-jolsa@kernel.org>
 <bc91a6fbfbb53b29a1f48a07c8412caaca1a0f8429bf75d40f58272eacfdfcbd@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc91a6fbfbb53b29a1f48a07c8412caaca1a0f8429bf75d40f58272eacfdfcbd@mail.kernel.org>

On Wed, Jun 10, 2026 at 03:51:39PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index d4188a992bd8..cef9bd6316a5 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3475,7 +3475,7 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
> >  			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_KPROBE_MULTI_RETURN ?
> >  				   "kretprobe_multi" : "kprobe_multi");
> >  		else if (link->type == BPF_LINK_TYPE_UPROBE_MULTI)
> > -			seq_printf(m, "link_type:\t%s\n", link->flags == BPF_F_UPROBE_MULTI_RETURN ?
> > +			seq_printf(m, "link_type:\t%s\n", link->flags & BPF_F_UPROBE_MULTI_RETURN ?
> >  				   "uretprobe_multi" : "uprobe_multi");
> 
> This change in bpf_link_show_fdinfo() switches the uprobe_multi check from
> an equality test to a bitwise test.  Once a second flag bit exists (the
> BPF_F_UPROBE_MULTI_PATH_FD flag added by this same patch), a uretprobe_multi
> link created with both flags set would be misreported as "uprobe_multi"
> because the equality test no longer matches.
> 
> The equality comparison was introduced in:
> 
>   803f0700a3bb ("bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo")
> 
> Should this change include:
> 
>   Fixes: 803f0700a3bb ("bpf: Show precise link_type for {uprobe,kprobe}_multi fdinfo")

answered this one in previous version

jirka

> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 970ce7bbf99e..f5d68f6d90f3 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3214,6 +3215,38 @@ static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> >  	return run_ctx->uprobe->cookie;
> >  }
> >
> > +static int bpf_uprobe_multi_get_path(const union bpf_attr *attr, struct path *path)
> > +{
> > +	void __user *upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> > +	u32 path_fd = attr->link_create.uprobe_multi.path_fd;
> > +	u32 flags = attr->link_create.uprobe_multi.flags;
> > +
> > +	if (flags & BPF_F_UPROBE_MULTI_PATH_FD) {
> 
> [ ... ]
> 
> > +	}
> > +
> > +	/*
> > +	 * When BPF_F_UPROBE_MULTI_PATH_FD is not set, the path is resolved
> > +	 * relative to the cwd (AT_FDCWD) or absolute using the upath string.
> > +	 */
> > +	if (!upath || path_fd)
> > +		return -EINVAL;
> 
> This isn't a bug, but the non-FD branch (taken when
> BPF_F_UPROBE_MULTI_PATH_FD is not set) reads path_fd in the check
> 'if (!upath || path_fd)'.
> 
> path_fd is only meaningful when BPF_F_UPROBE_MULTI_PATH_FD is set.  A caller
> that supplies a valid string path but leaves path_fd as non-zero garbage (in
> a struct large enough to include path_fd) would get a spurious -EINVAL here.
> 
> The garbage value is never dereferenced or used for arithmetic, so this looks
> more like defensive input validation than a dangerous use, and old-style
> callers passing the pre-path_fd struct size get path_fd zeroed and pass
> cleanly.
> 
> Is rejecting a non-zero path_fd in the string-path mode intended, or should
> path_fd be ignored when the flag is absent?
> 
> > +
> > +	return user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, path);
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27284577665

