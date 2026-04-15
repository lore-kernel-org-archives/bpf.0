Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC324DCF6
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241382; cv=none; b=EZHrtK1k0rBKX3RUoIwaG2d35V+IikVpWoSH2wgnk8jU1HBTQfBuFS+U5HgmA6HrqFFvKIEuWSxtH4C4RiKhASmXY5BVW6lpzzIiX/kn75Rkebt0FA05ysI4rg64czkNSnQS2zt9F5o/o0eS4RA0AWqfN3z04dxyu8OJ4PFjQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241382; c=relaxed/simple;
	bh=PxyO+ZfM+NjNs9Q+i7VUt0sXGy/MXx5pol6ENmelY8M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htQrunVV3ZerDX3fxBnor37xnAZSQ97QR6vdlHRRBao5xXZRqv7MoVIgplag+0iw/1HTtfCwcVeY1fi38C5s383MQdm9Zr2upymAxu+WDlWxxd+5TURwsNqX7ZmbvTMcAqKsH/YKOclceM5AQ541aY9db4r46SD/McMzV4gdSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlMo7vi5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlMo7vi5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so101073345e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241380; x=1776846180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlvPukQWyhYQfBoynyp/GRENvMlT0J5qGSfEcgup7J8=;
        b=RlMo7vi5v3JE3Gt0R7WjG9B2XmtFTpl2jaYhuotnVavEbwB7lmNO0jJMDkQ1Vmrr0z
         xKggDTYuNA9wHzsY5D9Et2mfOmXbzfl0dViCm7ylxAyRfwzV1UWwSj6LREW4Xu5+MfcA
         73FJqypxqadxJFJNbC5c68wTKtb5bERE38r8gu+Odfke6eKRUbEWK8GTRsnHtnneWDsB
         Q0kn0f5ISMPFhlrTbnesGZex1CEiMpjY6xGyDxVFd3SiiUCxvLPnQ2Kd5/ieVqVQa31Y
         pC8jR5BMibU1hJZ2rHmdqDtkyB0TiKX18j0bIDjTQOIX+KbRHE5j+740Zqa859cV7uRM
         aV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241380; x=1776846180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlvPukQWyhYQfBoynyp/GRENvMlT0J5qGSfEcgup7J8=;
        b=mfMwgU/hS46NbPNr+zlVga9OllUO3CTtJL8uKsV/BH8i/YQJKNkPzhJDMcvYxZGu0I
         ab9+5pPitv7j/p+9LWQK6/4fjs2AOTr2NVoP6BZZmLNUCPIwzsz1dpKyQPd5AeuX6dwh
         5ezz+xK8JLU4uEJq8SpqdzYgsGWo3z2+026DdPqaWLCju4Y4o7ku83YnCy8Pf7MaTH76
         WIN0Txm0AwnXTp/cIEiLC+3coSioQxdjjbwjL1H0IBK0tmKVUUXr791fi7HrWGrDEPu5
         hMfvC9qICKBN5NNlet93USHQ1LZhCOAXlLmZ0KHAcEpEBBxMEzQrikr+jECKlx6C/YpL
         oTSA==
X-Forwarded-Encrypted: i=1; AFNElJ+mVHiPjU1aFLkftBzE9VFmUrgU4upLyi/zZyMuLJTIKofM0p6ELa02snLmNqhzLL73qpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOu1qqoo7h2xGWtXVYD+Y7b6lh1fI9fvFl5ZPni4nKKi7Sc6K
	X38VrvAnBu2X4bTbe6qwquzX7+rCm681/CIMfyW7snECdc2aWf5FWoqr
X-Gm-Gg: AeBDievD70+gz0I+QpjcO1e+PZAwnjBcoKKjQQK9xKC8KBDxmXgSZvsoDLwjAwj42hC
	7pY4jIa9TKwzBB4CkZRkfmUrSHGG7Uu8tnOSiVt7M6Lp3PJnSUrZjN9gO9qJhhVklVNPUX4qkRF
	Xgd7L/lpsJ5q7nTruc/cE8qalq6zl6NAQKyMH9py5AmAFE4Y+TXDYa+e3JoWyhzYxHKLj0J2isP
	/32xymcr9iP8Zh92PaZVhQOgkBodwMqOuV38j8pDSU7BRiJLi5AVb8RQk8pvpEGbSGm6Q/Npesa
	JSGexKFV+c0nKzJN2WRlqQ4azfJgANQotF2x8mHtMr5aQeWZlMvfBQjEcvkaGgHWOefAoaEBR6c
	1ShQEAc2cp7kYPAkgvkt4cNSFD12fR/DdBx4Bh8zq3CxRc4YNL4Cws9r/yvtWz7pc5IzH+zqbsT
	mt0sXer2M=
X-Received: by 2002:a05:600c:3149:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-488d68431f6mr278556795e9.17.1776241379492;
        Wed, 15 Apr 2026 01:22:59 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1dd899esm31642375e9.1.2026.04.15.01.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:22:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Apr 2026 10:22:56 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf 1/2] libbpf: Fix btf object leak in load_module_btfs
Message-ID: <ad9K4IHsKSZo0jsI@krava>
References: <20260414194804.1428676-1-jolsa@kernel.org>
 <83d5ae9a86ff32e179554c24e012a6a1af045faf164cfd059a7e683615e6f76d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d5ae9a86ff32e179554c24e012a6a1af045faf164cfd059a7e683615e6f76d@mail.kernel.org>

On Tue, Apr 14, 2026 at 08:28:59PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > @@ -5771,6 +5770,8 @@ static int load_module_btfs(struct bpf_object *obj)
> >  		return 0;
> >
> >  	while (true) {
> > +		struct btf *btf = NULL;
> > +
> >  		err = bpf_btf_get_next_id(id, &id);
> 
> [ ... ]
> 
> > @@ -5837,6 +5838,7 @@
> >  		continue;
> >
> >  err_out:
> > +		btf__free(btf);
> >  		close(fd);
> >  		return err;
> >  	}
> 
> When strdup(name) fails a few lines above this, btf_module_cnt has
> already been incremented and mod_btf->btf already holds the btf
> pointer:
> 
>     mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
>     mod_btf->btf = btf;
>     ...
>     mod_btf->name = strdup(name);
>     if (!mod_btf->name) {
>         err = -ENOMEM;
>         goto err_out;
>     }
> 
> Can this double-free btf?  The new btf__free(btf) here frees the
> object, but bpf_object_post_load_cleanup() will iterate btf_module_cnt
> entries and call btf__free(obj->btf_modules[i].btf) on the same
> pointer.  Similarly, close(fd) here and close(obj->btf_modules[i].fd)
> in cleanup would double-close the fd.
> 
> This is addressed by the next patch in the series (36358f0b8f1b
> "libbpf: Prevent double close of btf objects") which defers the
> btf_module_cnt increment until after strdup succeeds.

ok, I'll squash both changes in v2

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24420241619

