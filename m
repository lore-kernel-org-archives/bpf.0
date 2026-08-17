Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E444429022
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973092; cv=none; b=aqJQ0u1GxbmKAMJPRfy0g+74+EfYOk7UC5QRv2sj9eJMkQvGMPHHCINylDZg2MNWi98727lyNpWDzY1Y9Gn4qpq1SEcbvixZmvI6a6v2w57Tsz+jnA9NlNWuXCe5STo6d5N2HwwJvmWxqiMpwbWKNQUQbsdbMB49JZbRNV5msxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973092; c=relaxed/simple;
	bh=Hw/jfXcPPMobBLBI8W1VNi7tiStnZDpg9z6Ju3cQlQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj1VuIV109zgBLM1AmXmoYabsmvJ37EOEBw6Qk9sid53BWxisygRkcTxgCES3ZnVunl1lUjph8qATNPoOVHwo/5RTXNREubqjgqnJEGUpo1zPVtvL78gfZR1rlU27Fvzh7fEtJMCOEgT42pH+Wo2hipuMgXNR1L3gYjfSEuPRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Vr+7rqUS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Vr+7rqUS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49954b88fffso38633445e9.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786973088; x=1787577888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oBxqkvt2QiyULLxw2yg2sHAVvNGWnYOoHvbaWXtRPBA=;
        b=Vr+7rqUSSmJQlcFh13E5PEUcs5NjpEBKr1CbNuCsbKC4C8uXbCU1uU/vxfKju1teOs
         jYGjkaMMapiV2Ag1e3hWftj3u5VTC4qrYkr4XyGS5qQVqK+o1a8GmZ54J9Rc3j8wyOki
         EWWPHSYwh5EWtxEl+k0XVg22Dz+3a8F/8JLASx4ox+loy/THofG/OjeOThDkzr30H6+/
         JVQWJs/noLpZ/sdk8odXwzlkO/cc+VJw04xPYbcMaoUzN5a7fcEfnAFckjfmY701GS/a
         LAB8BoCmE0Q+mgJGQGNCIzbSv16raXt3dmojRPlz/Ky1FYeZ1+0r2lIpJfcbPrM9QAPq
         YNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973088; x=1787577888;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBxqkvt2QiyULLxw2yg2sHAVvNGWnYOoHvbaWXtRPBA=;
        b=su4OoXRA2B3MxXJq4NY9pt2L1E+oOOCJjyyJeQgOHxkW0zbuIt+4xK6Ue7wyawEdXx
         kOCDiFoQ1Pb2zP+Dugl3HwwKtanX82bGQ4jWMacOSwQQJt/P/b0WVpBvC+YmbgK0WnfV
         1EIgTCKirHYRfGSJprQkb8JboQQHgxxD4r9dAi0PURflye0tKMt6sg4SGlA/Q4mzRWHP
         kegDDDMYjavjYxoBx0aCy8HZKi6v13l6IUDzWL2IhkZ2JRXzR+sYTCkmD4vxtRKWyoWm
         iNAs5dbb8EPTU+8ONIaLghoE8yDAY3PoLYJMjuUFDluGLrN/QEpRgRD8KMGPwITIvjY2
         hRkA==
X-Forwarded-Encrypted: i=1; AHgh+RoC7KbcbukdhyI1Eg1grM9YN+p0WFJsX8BCY0HolW8ldYwtzMHfKTOnLCgc5iey/OxL+oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRLR4n7zSzBvC47bavgIq6dpSxqjDA9OATV2CbGexg1ez/tEn
	aqU+EdpJYM1zRzSUvXkrOp7nAVUwUKQHxjpuVpFXY+sSf4Zk8RIPj1BKdV8Dn2G8XQ==
X-Gm-Gg: AR+sD12w0Uw75DYwJwatjmIyLcCilx80FGQvm2iAMIz5obuj3Rqcx7Ozr3eXQX0+NQ/
	Un7M+xuk0CKJf5j7+Szi4zsm/q+Y6EcVBQsxzm0dJKOtsWXA4cFEs9aspFA4WgFUty5l+bwgYnE
	zp4xjUWbGxMXak2eGSU/B1qw9T4pfQKnJjG49qAhr8nMPElhe5mYZ+GfxjD1TE7R4qVACpP13z3
	2hjsNcwUn0WAZsaOr8MW4VX82+s3/eoWsvKfm3k0UYGNsbZEPwTOpxG1DCp36tf67YQoEOLHkD1
	RQTO6asmgpb3GGYyrKwVnEt1ndzT1B8Os6WYkWUhD8ihzb+yzfCBIw9ZxVOjkE3JMLEc3qLqXfA
	svD25VGsZKLkhZJ+H6boT2Bp03ieL1BvGQ2iJ3JUnKZnCjPtz4XchbFcx8kVZVcKT7nSVCNOCTn
	8j4u9+jjW0l78fhxIIuSgRJFBLi96digJiVorhPWVx148I/nhmjZYBTmyCwKhLosCzFowo0P4=
X-Received: by 2002:a05:600c:3b1d:b0:499:87b6:f3c0 with SMTP id 5b1f17b1804b1-4998807e4c9mr382618245e9.14.1786973087942;
        Mon, 17 Aug 2026 06:24:47 -0700 (PDT)
Received: from spiro ([141.5.46.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996109652sm188597975e9.4.2026.08.17.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:24:47 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:24:44 -0700
From: Jennifer Miller <jmill@asu.edu>
To: Kees Cook <kees@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, linux-hardening@vger.kernel.org, xmei5@asu.edu, 
	samitolvanen@google.com, peterz@infradead.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by default
 when x86_64 CFI is enabled
Message-ID: <aoL_G-3chdLZGxSJ@spiro>
References: <20260710191932.120911-1-jmill@asu.edu>
 <20260710191932.120911-2-jmill@asu.edu>
 <202608091030.C69278022@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202608091030.C69278022@keescook>

On Sun, Aug 09, 2026 at 10:30:35AM -0700, Kees Cook wrote:
> On Fri, Jul 10, 2026 at 12:19:32PM -0700, Jennifer Miller wrote:
> > Initializes bpf_jit_harden to 1 if x86_64 CFI is enabled. Prevents the
> > misuse of BPF JIT code to craft CFI signatures or Endbr64 instructions
> > by enabling constant blinding for JITted BPF code from unprivileged
> > users.
> > 
> > Signed-off-by: Jennifer Miller <jmill@asu.edu>
> > ---
> >  kernel/bpf/core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 47fe047ad30b..ed22b90c6e4e 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -548,7 +548,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
> >  /* All BPF JIT sysctl knobs here. */
> >  int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> >  int bpf_jit_kallsyms __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT_ON);
> > -int bpf_jit_harden   __read_mostly;
> > +/* Enable hardening by default when x86_64 CFI is enabled to prevent CFI
> > + * hashes and endbr64 instructions from being crafted.
> > + */
> > +int bpf_jit_harden   __read_mostly = IS_ENABLED(CONFIG_X86_64) &&
> > +					IS_ENABLED(CONFIG_CFI);
> 
> Why not just do this for all CONFIG_CFI?
> 
> -Kees
> 

The intention was to not enable JIT hardening by default for other
architectures when CONFIG_CFI is enabled when we don't know if it would
be preventing any CFI from being bypassed. It may be possible that kCFI
on other architectures is able to be bypassed in similar ways to x86_64,
but we haven't looked into it.

~Jennifer

> >  long bpf_jit_limit   __read_mostly;
> >  long bpf_jit_limit_max __read_mostly;
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Kees Cook
