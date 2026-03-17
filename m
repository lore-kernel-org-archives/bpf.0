Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732631E841
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767944; cv=none; b=A2L0B+gxGDgh1JXimeyvqm3wA8V7rg/7SwA6bXYquIwzQllatVpap8sqtXQGugN/tuHzN8yjS2jDgqIExLXE36H8Uk3sR8UN00Geukr+dZZtnvXW+ER5j7fHLd0i0QLEjmkAw69DssfVtxKJLBxMH1Z5w0TjMAyOfk2gQ4aLeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767944; c=relaxed/simple;
	bh=YK3vJ4juRoBYROJ37OP8MfuqnoWisPryD3xrvOBo84Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMS34i+MXmNmdYVZELntKuP65PWQHSOi29Ch5Fq/VKmpSupG3a9NIY7c27QqQXluqkgX/J0Nq1sQn/j3PHkS5yCXERw6s0bfVFvAqJ0YOI9lrdHk6DckLTUf9JygD8e3TQNuUqU22xRXh18g7c/jLr3g+l0LjqKXGJHH/zjhINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT8y5yK4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT8y5yK4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b45bb7548so1759240f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767942; x=1774372742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3uAG3hNoBvu0rfKDECyv2wLgMaAu8pY7D5FJIL9fBA=;
        b=WT8y5yK4qrkIohNkS/zWA/HRQ5eEdtX1F4cEyQxCDDNAjax82NjPP5pjFtEvZTSk5u
         mB4OWA9EUQEHJIIiY5fW8q81fjGy/75TfvHFZef3iB5WA0+7UepSfwwa5cCnmDOik9cJ
         7NJSNy537+qjWDnZRffZnWGN6R2dQJWsgl7d02a+vLE3HSQXvtWmyKbEBg+jmi/jEDkt
         G4KLD+wRyEtbjM2sxfOM2np7I2cB8exURTs0vvAvcDL5eli8u2iBNPli/VzihRBJZYHb
         u2kC2rDE2bIbmn8xAS4MiY82nDxZ+cr3QILHXqFeh/7+xCAhhyY+9OT7zFdULxV3sbQe
         CYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767942; x=1774372742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3uAG3hNoBvu0rfKDECyv2wLgMaAu8pY7D5FJIL9fBA=;
        b=BHj/YKWCOQxJJBE6ASTzF2IcFgE0HrzbFDlO//tK+5TEdfH5xy5e9rQy94morDMiAE
         8mLGK6P24L4twATRQ8Ko+2DoYQvj51cekUfxrhnp+bhqECHeoAdxZt6E8VXZfzkmFqKX
         61cOGwAkw1CDKBU9Ym9IflqTo/ztP8p33iarjUAYQaV85O/V4E5INQYWxH5awC6kFQEO
         Sy56/WkF2HTApA1YAKUnjyGao15WgMoelZEX1hcnlQzs6rVVkYLQYDcCa+olBTarR2ib
         LUdSS96PigCgJ3cOmTFjDMK8dh1C6+XI5L7GZzYTJTm2FLkiWE/BRL8fIDx2rQIDU850
         wZRA==
X-Forwarded-Encrypted: i=1; AJvYcCUw8G9aPQwHEOPVaS5vktwgvvfsIb7rz0gKYsozgUb5hKdOzcUgezWRPH/n2i9kCF/eZsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ+b8xCDskRWmBT6OI/KA+frP7sL9/rsNuWEP5+kQoOaw8z9KT
	8g92XgrFL+P+KMAgArYBYRw1tvY5noNLrcHAMv0xeERCQpBK4tdMoXvA
X-Gm-Gg: ATEYQzy3i1wA37pRHgOXViRBwFz+UDCE3CQawz/00nNiJr3mJukR4NjAeATQB7jNM4h
	5Z9poMvzmJcZm9ndwqhVLgt3+P/sIsu2FFYpj2fzxTPVPAcEzWcbZh+d1PEiMOJ+MF/y5wyxpoc
	BCOkLut71ufxTHh55VEJlbazfhSQGo/Bm+2r8CeSpU6s4jxQ9xjFNUgCKcPg1eHaDXBP1pwTdrM
	Jnzs80aR/UiDYPzLfi7ddjvIWiSxsc2YJMCD6csYU4pTqEpMPPSYW/glddRK/j9LQznVI0NaFyx
	+MdAMwt9rN2nvcoYAqZ1b3HCwE3SOQyrpYPq9pYIXZQYDFjz5GLylEOTTNtuq3VhmozDslwjvO9
	J0pp8RNL0L0tNrzwh7GZC5sHTzoopgDdE2yYPLAXV8c6rOMT0CioY6zxvkT+v9t8zbHRve1n5cM
	K9r+GVuO112Qk=
X-Received: by 2002:a5d:5885:0:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43b527c4c70mr12482f8f.29.1773767941438;
        Tue, 17 Mar 2026 10:19:01 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a3dedsm720056f8f.36.2026.03.17.10.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:19:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Mar 2026 18:18:59 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv3 bpf-next 20/24] selftests/bpf: Add tracing multi
 cookies test
Message-ID: <abmNA2wbZE8XpMrO@krava>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-21-jolsa@kernel.org>
 <e01da3b0-ff72-403d-8f3f-4312d35e6ec7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01da3b0-ff72-403d-8f3f-4312d35e6ec7@linux.dev>

On Tue, Mar 17, 2026 at 11:06:25AM +0800, Leon Hwang wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> > index 0e3248312dd5..e6047d5a078a 100644
> > --- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> > +++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
> > @@ -7,6 +7,7 @@
> >  char _license[] SEC("license") = "GPL";
> >  
> >  int pid = 0;
> > +bool test_cookies = false;
> >  
> >  extern const void bpf_fentry_test1 __ksym;
> >  extern const void bpf_fentry_test2 __ksym;
> > @@ -28,7 +29,7 @@ extern const void bpf_testmod_fentry_test11 __ksym;
> >  void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
> >  {
> >  	void *ip = (void *) bpf_get_func_ip(ctx);
> > -	__u64 value = 0, ret = 0;
> > +	__u64 value = 0, ret = 0, cookie = 0;
> >  	long err = 0;
> >  
> >  	if (bpf_get_current_pid_tgid() >> 32 != pid)
> > @@ -36,6 +37,8 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
> >  
> >  	if (is_return)
> >  		err |= bpf_get_func_ret(ctx, &ret);
> > +	if (test_cookies)
> > +		cookie = test_cookies ? bpf_get_attach_cookie(ctx) : 0;
>                          ^ dup test_cookies check ? Can drop this one.

heh nice, yea, thanks 

jirka
