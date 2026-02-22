Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC142253EC
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770968; cv=none; b=iebCDDB3bs/9LsD8SrSAMH6cs+c0PWF5+SKw4Sc2jxbl0JIbdh8UYvGkB/o0B8Mqk5D9UQU0cegVIpV4W8/fGHlipjsNxyUwPxnyBmmsY5ZksflmDYr3CoiOv+0WKMobXa8BrUoG6/dGGtnaR8Sw4ULa4LWDs0clDfI1fpg0dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770968; c=relaxed/simple;
	bh=Lh7zHtti+UFwjZSPSdzF1eFbtEdNKhAcoT8uv6ypMQ8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElNKERjqkf+mozXc9dGn76GNhjMsPM4XYwlpFozngxLW0F99gSlB008YZwgnuS0KEMHMMevKmS67rOwxGNUN0sm5i4dgnW2I574HOUVMd/NKCIsub60erjZzy0gAlePN3yn3jzlLlzBg8M2hJKSexAh8F/yzWC+nD3cVuojYji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa8GutYr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa8GutYr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483a2338616so21480745e9.0
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 06:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770965; x=1772375765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HZ6whw5IMPhwktEDQwrczvE7RIG7O7dxlSCf6ECZ8U=;
        b=Sa8GutYrmDchdFKB+OZBz0E1rwNNApqAk4PqTQfNZildGsATPY72fbILOWAA2bYqNC
         hJFIYFIlvwCgIDf7tM8ekOp9t3tZWviXhS1kB3Kys/T6jZk0jbxHBjOXm4R+0ukqo9KA
         wEXqw9MzSHsVvIuXINekHMDF/zPHAeK0R3dJ3BrOzUCm2yRe8FMcyFPgWa1DZU5RHDpw
         QzlvS1RPqw8DyrDRFmLvJ7JhP83xYAefawhkNjjfEJiqmGCa1UkUV4/B7hYu8+AV/qT9
         p9U36456mMRGtKXvDfBjVx0Hfce82mkJGtqxz+vMnJgyQ28yPgA6ahm9Sdq6vDeE50B7
         J6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770965; x=1772375765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HZ6whw5IMPhwktEDQwrczvE7RIG7O7dxlSCf6ECZ8U=;
        b=oleq74zYwUQhdGt3VGoJ4LvG79QTfFB5nG5iVparLTmLH9IREU619X8vi3IG0HVU9p
         KYMOQumYslYWYRkPyJJkSHBsv0KPG79xknC+p9seQSoypk4/kxtdVxnvEQNhvkTHpqtz
         MEi+OA4OzCHkc1cB1fBmqzUvdndtKNcQwnK+mQJSdY1fWW6fZlhW1XnVdbhcXYl2LSHz
         v/A+66CpK/rnoENkU1iGojaeOnOEoYbIm55RBr1RjqLugoLKnbnKZKVhritT0zDsLu9Z
         k3/DZP8Lw7KDx7uvhGVX6SIfDbDOjbnHEc1PLRUhm8o0mJOsxof3b1HVrBJmbthM5aUN
         n2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZnV8UXi4rA/1o5I/oAcSa3+uSl7RxbATFPlB/nNiLqmRmzMBVCSxNXg2mGhMPb5Y4Y6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrquYZDvH29apCFr8PrWBtbIwSaBH5xr2stsgSSt6NlL9jJAqu
	xnkLUSti5K/0HwWV+rYbDSpMEYw+OrGQ2FnAe1zqIDnHuthgLPPCvO12
X-Gm-Gg: AZuq6aKaG781ReaqPT3rn6sbd3u6uLBHdhuT0EkRUPV2zqMNlzITxNCyDGCbZDft7Nu
	aekFsbg8wWQsh3MdmZzqwonsWvokKhDuc4m6GFayZmksLdcbrAwFxEVf2fPFeFPnluRByHTr/3y
	o3DjLs33q9h1K8plnPETl6vsmWZjpsHWYIUDW/hYpqAVQ40H5cfoI6Y6ux3TLcta/2cgjLLfesK
	lrCTZBoqlBLpIxLsqgzFBkKab0FsJhyH4HwysP5OYJckYBgKBviG5BJqJfGMI0AKqb4yRYtZnMn
	GBEeHcKyuyaBl1w5PlUjN87qaTPwBbpOcAM74n26IGJknzOHzUvEr+5FSCtlkKmwI3HMARyAw0T
	Ta7YtRBJUhhLgF+yWs/H6A36eJsDcGBI6ezFO+hA6ArH3OelgqepDZCmc0VwLniuK2YXnJtrM
X-Received: by 2002:a05:600c:8b0a:b0:483:7f27:cdc5 with SMTP id 5b1f17b1804b1-483a9603c12mr95344775e9.31.1771770964732;
        Sun, 22 Feb 2026 06:36:04 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb3de5sm133442465e9.12.2026.02.22.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:36:04 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:36:02 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 11/17] libbpf: Add support to create tracing
 multi link
Message-ID: <aZsUUq3spbAY4RWn@krava>
References: <20260220100649.628307-12-jolsa@kernel.org>
 <56ab264977d669e52dc1cbb2fa6224443cae58e723b4757ea59d21fd160f1b9f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ab264977d669e52dc1cbb2fa6224443cae58e723b4757ea59d21fd160f1b9f@mail.kernel.org>

On Fri, Feb 20, 2026 at 10:57:53AM +0000, bot+bpf-ci@kernel.org wrote:
> > The provided <pattern> is used as 'pattern' argument in
> > bpf_program__attach_kprobe_multi_opts function.
> 
> This isn't a bug, but the commit message references
> bpf_program__attach_kprobe_multi_opts when the code actually calls
> bpf_program__attach_tracing_multi. Looks like a leftover from
> the kprobe_multi code this was modeled after.

copy&paste error :-\ thnx

> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > +struct bpf_link *
> > +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> > +				  const struct bpf_tracing_multi_opts *opts)
> > +{
> > +	LIBBPF_OPTS(bpf_link_create_opts, lopts);
> > +	__u32 *ids, cnt, *free_ids = NULL;
> 
> cnt is declared as __u32 here, but collect_btf_func_ids_by_glob()
> returns int. When that function returns a negative error such as
> -ENOMEM, the value wraps to a large unsigned number.

yes, will fix

> 
> > +	__u64 *cookies;
> > +	int prog_fd, link_fd, err;
> > +	struct bpf_link *link;
> 
> [ ... ]
> 
> > +	if (pattern) {
> > +		err = bpf_object__load_vmlinux_btf(prog->obj, true);
> > +		if (err)
> > +			return libbpf_err_ptr(err);
> > +
> > +		cnt = collect_btf_func_ids_by_glob(prog->obj->btf_vmlinux, pattern, &ids);
> > +		if (cnt < 0)
> > +			return libbpf_err_ptr(cnt);
> 
> Since cnt is __u32, this comparison is always false. On an allocation
> failure inside collect_btf_func_ids_by_glob(), the error is silently
> ignored. That function also does free(*ids) before returning -ENOMEM,
> so ids becomes a dangling pointer. The code then continues with a
> freed ids pointer and a garbage cnt, and eventually double-frees ids
> through the error label via free_ids.
> 
> Should cnt be declared as int instead of __u32?

it should, will fix

> 
> > +		if (cnt == 0)
> > +			return libbpf_err_ptr(-EINVAL);
> > +		free_ids = ids;
> > +	}
> 
> [ ... ]
> 
> > +error:
> > +	free(link);
> > +	free(free_ids);
> > +	return libbpf_err_ptr(err);
> > +}
> > +
> > +static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> > +{
> > +	bool is_fexit, is_fsession;
> > +	const char *spec;
> > +	char *pattern;
> > +	int n;
> > +
> > +	/* Do not allow auto attach if there's no function pattern. */
> > +	if (strcmp(prog->sec_name, "fentry.multi") == 0 ||
> > +	    strcmp(prog->sec_name, "fexit.multi") == 0 ||
> > +	    strcmp(prog->sec_name, "fsession.multi") == 0 ||
> > +	    strcmp(prog->sec_name, "fentry.multi.s") == 0 ||
> > +	    strcmp(prog->sec_name, "fexit.multi.s") == 0 ||
> > +	    strcmp(prog->sec_name, "fsession.multi.s") == 0)
> > +		return 0;
> > +
> > +	is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/");
> > +	is_fsession = str_has_pfx(prog->sec_name, "fsession.multi/");
> > +
> > +	if (is_fsession)
> > +		spec = prog->sec_name + sizeof("fsession.multi/") - 1;
> > +	else if (is_fexit)
> > +		spec = prog->sec_name + sizeof("fexit.multi/") - 1;
> > +	else
> > +		spec = prog->sec_name + sizeof("fentry.multi/") - 1;
> 
> The sleepable variants with patterns don't seem to be handled here.
> For a section name like "fentry.multi.s/my_func", none of the
> str_has_pfx checks match because "fexit.multi/" and "fsession.multi/"
> are not prefixes of "fentry.multi.s/..." (the character at position
> 11 or 14 is '.' not '/').
> 
> The else branch then computes spec using sizeof("fentry.multi/") - 1
> which gives an offset of 13, pointing into "s/my_func" instead of
> "my_func". The sscanf then extracts "s" as the pattern, and the
> program attaches to any function matching the glob "s" rather than
> "my_func".
> 
> Similarly for "fexit.multi.s/X" and "fsession.multi.s/X", the
> offsets are wrong and produce either error returns or incorrect
> patterns.
> 
> The SEC_DEF entries register all six sleepable variants, and
> sec_def_matches() correctly distinguishes "fentry.multi.s+" from
> "fentry.multi+" using the '/' separator check, so the matching
> works but the pattern extraction here does not.
> 
> Would it work to also check for the ".s/" variants, for example:
> 
>     is_fexit = str_has_pfx(prog->sec_name, "fexit.multi/") ||
>                str_has_pfx(prog->sec_name, "fexit.multi.s/");
> 
> with the corresponding sizeof adjustments for the spec offset?

yes, I mentioned in the cover letter that I did not add tests for
sleepable functions attachments.. I should have ;-) will fix

thanks,
jirka
