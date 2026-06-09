Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE23266B72
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011394; cv=none; b=Q41K9CZiiD3MIX6VoKoVwavkLfuoFt+gyDm04tqEaI/JzaUOtLgJhwk90yToPO4+DB9HBiQKMfn4XZlOImEvWIkTC3inmZngbGLO6MiOU/120NXP6Uf5LPpAF4FG/J13PEhTtaayG1ISwHiA+JVCEoP/g97meyyRPeBs8PSguhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011394; c=relaxed/simple;
	bh=aBhiQJaYmOwVyxz82eYRazavqn1zkyHxz3lTj0dRthQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoeAijtIrzL+12LRnIF0Ppb3FyAeeQDT+UNtKtS5rZP3m3/JpZcp6rH8kjnS4yKK77Cag70i+cjS19cs2/0ZO1CrQLXGjVG2Dy7iiNy/C6AdPhUlB4HH07piFJZo8rRZSXZ8oC3fmGOY5diiqcFrh8G+wnO2DW0tzmtpGt8eNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnjOgMVp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnjOgMVp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490af320e2aso60543185e9.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011390; x=1781616190; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ZV6RsZExqbpNR2Ks/4acYQkYZtNf2DRP83lBEHNlGM=;
        b=nnjOgMVpfnjmRYdnbDTuwQQYulzjrXqeOV19olJL850kGlwTnVUyPuhdKMfF0m0Uew
         GrYTYBF9XsMVV99jTqrlrJ+bRSWIqYePSxdF+c4a1IzHZvDxMIyVvwZh4a3i2HdMbKOH
         qIpal2uGPUwzOpbvcyej1hwPIJlB0ovEUS4oDQFcrPcKQllMGbAxfbpgS+9TqX1a2k49
         0YEVG2RHi1nwwFbWp65vot6aCyl3Z3DgXzQa47bHgBzKk+dKrr/6na2UXSGTIaV7rJqs
         Vng7EDf5/HJKFog7WcQqDHBha2DT7RqbLd+oZaco9zlUYRPvdDt37BnoCvYjir/vVA63
         5xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011390; x=1781616190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZV6RsZExqbpNR2Ks/4acYQkYZtNf2DRP83lBEHNlGM=;
        b=EuQ+3drxo8d3ekFyR/a0hY7s1hHtMie1fnmGLnDn4lhialF9lBcdPztr2/GMOxgKJO
         sjUSPO9dXRRAsuw8+YCI1Xvt+tqY65tMBbk5FKd1WSUq6oMWFy9roe0pNIoEDi+1LN0B
         z38EN2gHXOUfptByM9syeSbGSal8JKbBkbKLRREDLwwT4cutWjOWkpEnK7eZWIdeD9BC
         on3XXXNB5Y90Ot+9CcSXOciJu/1+ZarhghhC2iVKKHVVFAg9li66/jsNxtGMursG1UZ3
         5AvjE44bgAqtNrA0REQ/6cRct027jKzg7iqheb6nJTItykuQMOOLM+ae9CzPP+gTfwg3
         06yA==
X-Gm-Message-State: AOJu0Yy7tcfpQ1+ndZZvff0dvn5JMUjsdxkeYYsJzWpk1TyBo3gIIBFV
	V/Kho7VGpcpxFaGjcwGmBphaW4ff84UwMgZ3IPE5SXJz9qHk/6DrNTUF
X-Gm-Gg: Acq92OHP2cjfx2J/wqgiU/Dqu+LbKGWAslBaTT7Yv/UBgpsng/AE8MUIvKeLPzq/txD
	BnuTheZqmerup6B48tzMAmiMCByo7UIlJKN4r7GYZ1FWAMCvEI/vODZ1UvIcgeM/tOwEbLWh5yk
	+Y5ymDVnoSEqabiTffFm5hu1EQO/7C/Qa7uRMNB7bWJm04RI4CwJYYbu/qgA8ApaGvpSP1mC8Z/
	MIvm9OteeRidjdzLRjIeaC4WhV0FN6n49kJacGql7PwtrqVbATxtQNbtRMA5sMeir+I3gPfSVmS
	kJ77RZ2JOFSL1Qmtz++pKf9rSFe5gEcgO2IeKYOl21hLik2k2Uh7FhJTGfx7hdp3y7f9FjwI+Rt
	8usTCStR+tXxh6yQj9OGNPsZ9DzJ9OibhrGTnGxiS8nw7oXdgJETm767xLTNkNmeqID//2JMBmy
	Q5klbcUZqgZUcy9v9cEvXQCu2a30oaoAZDZaOt
X-Received: by 2002:a05:600c:608e:b0:490:b355:9c8c with SMTP id 5b1f17b1804b1-490c25f3f00mr306947365e9.23.1781011390145;
        Tue, 09 Jun 2026 06:23:10 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcbe3sm57972104f8f.8.2026.06.09.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:23:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Jun 2026 15:23:07 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add support to specify uprobe_multi
 target via file descriptor
Message-ID: <aigTuxypMn07LnIz@krava>
References: <20260609104244.588321-3-jolsa@kernel.org>
 <20260609105723.311541F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609105723.311541F00898@smtp.kernel.org>

On Tue, Jun 09, 2026 at 10:57:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing strict zero-validation for the unused `path_fd` field when the `BPF_F_UPROBE_MULTI_PATH_FD` flag is not set.
> - [Low] Mixing scope-based cleanup (`CLASS()`) with `goto`-based error handling in `bpf_uprobe_multi_link_attach`.
> --
> 
> commit f7958ff1ce57c1ab456d3f134881a0081a58b8ed
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Add support to specify uprobe_multi target via file descriptor
> 
> This commit adds the BPF_F_UPROBE_MULTI_PATH_FD flag to allow uprobe_multi
> links to specify the target binary using an already opened file descriptor
> instead of a path string.
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 970ce7bbf99e1..4965006d58ee6 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> [ ... ]
> > @@ -3240,29 +3241,51 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> [ ... ]
> >  	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
> >  	ucookies = u64_to_user_ptr(attr->link_create.uprobe_multi.cookies);
> > +	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
> >  
> > -	err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
> > -	if (err)
> > -		return err;
> > +	if (flags & BPF_F_UPROBE_MULTI_PATH_FD) {
> > +		/*
> > +		 * When BPF_F_UPROBE_MULTI_PATH_FD is set, the executable is identified
> > +		 * by path_fd, and upath must be NULL.
> > +		 */
> > +		if (upath)
> > +			return -EINVAL;
> > +
> > +		CLASS(fd, f)(attr->link_create.uprobe_multi.path_fd);
> 
> [Severity: Low]
> Does this code violate the cleanup subsystem guidelines by mixing scope-based
> cleanup with goto-based error handling?
> 
> The bpf_uprobe_multi_link_attach() function relies heavily on goto labels
> for error paths (e.g., error_path_put, error_free, error_unregister). The
> kernel guidelines state that goto-based cleanup and scope-based cleanup
> helpers (like CLASS) should never be mixed in the same function.
> 
> Should this function be fully converted to scope-based cleanup, or should it
> use explicit fdget()/fdput() without CLASS() instead?

ah true, I'll unwind the fd retrieval or perhaps move the path retrival
into separate function, will check

> > +		if (fd_empty(f))
> > +			return -EBADF;
> > +		path = fd_file(f)->f_path;
> > +		path_get(&path);
> > +	} else {
> > +		/*
> > +		 * When BPF_F_UPROBE_MULTI_PATH_FD is not set, the path is resolved
> > +		 * relative to the cwd (AT_FDCWD) or absolute  using the upath string.
> > +		 */
> > +		if (!upath)
> > +			return -EINVAL;
> 
> [Severity: Medium]
> Should there be strict zero-validation for the unused path_fd field here?
> 
> When the BPF_F_UPROBE_MULTI_PATH_FD flag is not set, this branch is taken
> and attr->link_create.uprobe_multi.path_fd is ignored without being
> validated as zero.
> 
> If userspace passes uninitialized garbage in this field, it won't be
> rejected. Could this break forward compatibility if path_fd needs to be
> assigned a new meaning in the future?

right, I'll add the path_fd check in here

jirka

> 
> > +
> > +		err = user_path_at(AT_FDCWD, upath, LOOKUP_FOLLOW, &path);
> > +		if (err)
> > +			return err;
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260609104244.588321-1-jolsa@kernel.org?part=2
