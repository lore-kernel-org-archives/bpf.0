Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFE3BF662
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559976; cv=none; b=J14LlFDDiMkjGrJzNLX5yOkXucRUCimhBJZCTsnesmkh6z60z7hIdZGrwwCi5xO/yrYL9k+3akANNcrxpGdKd5167g+YveIi9Z2tCwv15gDSwvB+bei/o+VItvr5BfhZnMSgG21pgB1pl9eW7jPtvOais99O4jM+jFxIV9XNViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559976; c=relaxed/simple;
	bh=N7XFvxq6uMxAVWjKUzpyldIRjh1dfUspj22geuigDWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKbOFOpVlEIDES2NPtZgDub6Mi9k5W8Txb0LVHwRgDsJd5MrgULDHtYOg/pEHM8I9zKpVWE1fdwQfzWbJDGo6z/TyFY1cN/e2Eakx5+zkpHmYhFzf522btCAfdNcqKiTvkvK8URp6/dx569C68dRVkyH6q+Fhcu4wisdFnBNpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5LekFrf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5LekFrf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso4167465e9.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 00:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559974; x=1781164774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xr+ux2g6fgVsR71sMDGTVxIHHMX3sO8aKW8cZWnSGvE=;
        b=o5LekFrft/DQ1nTcMJNV63htyxmJiwyhsB648cSzWLlB84c2lRielwl0RRzP0K1fBZ
         NyfM1MGxBsBkBMGB1xxtNsMjUUyR8xTrtKaRK67L8fBST50g/8nXalvC7jQZoWgolcQ0
         3cgIiQuvUBfYVRdZfwg093m0pkR3y3QiusshWb2CWv+94hqe2rGXT8BpQNvo0RTM5E43
         Jta+HxOkYvTR0xmQ1HQWZY9tbDJESIw08PqtN96uhayxaRdfKVqy4upEyTYLATpSTbFW
         8v6/S7l2uG3vYfRdWLj4GtV7pDdBMn/OpiLWzUDSDQMMe2V8ot0ZwxdQWHY4+2u9e836
         JmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559974; x=1781164774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr+ux2g6fgVsR71sMDGTVxIHHMX3sO8aKW8cZWnSGvE=;
        b=kgrBKXqWBFVjdu0h0kbvCN+nizH/6FOrKpFXXxqWtzVmTMgjKfFjmnS0zkvS0HsQlG
         hnPHebamf4YJKNnRHvjGsDV8OMG9ZiuzrfTJPq+XSDF9q+v/2ZO50lpLAt8/IjfjAjf5
         nPbjD9UYwVLZXwzL6u38y9FBNCtmcqO/IAQ/0FnCecW+XP85a/+wkcMmaGoaQ9N5mGHj
         nR8zVJiCf9c/WSM8DvUH7VcdFhNpyngLiIebjdmVb7ec73W5U5T5IX1dePrVji92mCE+
         jIo7UoKLdNqEm1NoK5bsDCOIFo68rei+q+7iMPQM657iqVQFi5l9D8yKwA3tZw0ho73D
         Cs9Q==
X-Gm-Message-State: AOJu0YyVsNeN8DeIYvi2pfqK4u/YGth3vigt4+fDQ0MKquaFNFZ/PEmE
	VIKTzJH7acYnTVl4XJPqtKiDEuAZN9aoRunYMIe4d+YSQzl3qL7dzaQezOlz8w==
X-Gm-Gg: Acq92OH/lp9eLqJ/hxBr2P+Nv8dbLeEbEMkI7XhgWOiVoLPbSxwhTegDUS8eQ+AKKFo
	804dJFd3/1g8qVWABbPk3cXRxYFiJw7FhWry8giOifUU2o7h6oZv/jwRBrEmVWwdNX2Aml0b3V1
	XXA0OKu4OQr0YEnYmBnzWhQ5efH8ReYZ+2MEAaapBeIhoiQ71bv9Lz1X6L7tALHrhMvnO9HAq3n
	qGAghZ/1GB7MB+eBLgeWpZcUAbnVu+bYkyBi3Fn/vdJSsx1pLrCQ3tD7sgxI6yRG3XCkK38pvKT
	NCJ+ty+s0ib4uEvSNntywGV3CdFW5GAwjpTp4w96j+TZste/RkEe94BhhyaGhONPt7ogTNnir0L
	6D8KFC/FGXgmuElEFWrI5cH7PbCKC8+H6prf8Iq9lbvq1IvQRIt4XdDR2AMABrMDPIuKJyR2YgH
	oqmXkcHkvi7t3Zo6u4YCvV/FenEw==
X-Received: by 2002:a05:600c:34ca:b0:490:4ee0:82ff with SMTP id 5b1f17b1804b1-490b5fe6112mr101748985e9.27.1780559973698;
        Thu, 04 Jun 2026 00:59:33 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm15672983f8f.23.2026.06.04.00.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:59:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 09:59:31 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv7 bpf-next 18/29] libbpf: Add bpf_link_create support for
 tracing_multi link
Message-ID: <aiEwY-dYqjQQu3n1@krava>
References: <20260603110554.29590-19-jolsa@kernel.org>
 <20260603113419.D927B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603113419.D927B1F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 11:34:19AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch references undefined UAPI constants and struct fields, causing a build failure.
> --
> 
> commit dfbf332632be62321ec615d0d0c35a8d46309172
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Add bpf_link_create support for tracing_multi link
> 
> This commit adds support for the tracing_multi link in bpf_link_create().
> It introduces the tracing_multi record to struct bpf_link_create_opts and
> maps these new options to the bpf_attr union for the sys_bpf syscall.
> 
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index bc513aa8f4041..f37e3416f61a5 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> [ ... ]
> > @@ -845,6 +845,15 @@ int bpf_link_create(int prog_fd, int target_fd,
> >  		if (!OPTS_ZEROED(opts, uprobe_multi))
> >  			return libbpf_err(-EINVAL);
> >  		break;
> > +	case BPF_TRACE_FENTRY_MULTI:
> > +	case BPF_TRACE_FEXIT_MULTI:
> > +	case BPF_TRACE_FSESSION_MULTI:
> > +		attr.link_create.tracing_multi.ids = ptr_to_u64(OPTS_GET(opts, tracing_multi.ids, 0));
> > +		attr.link_create.tracing_multi.cookies = ptr_to_u64(OPTS_GET(opts, tracing_multi.cookies, 0));
> > +		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
> 
> [Severity: Low]
> Are the UAPI constants (BPF_TRACE_FENTRY_MULTI, etc.) and the tracing_multi
> struct within union bpf_attr defined at this point in the tree?
> 
> It appears this patch relies on UAPI additions to linux/bpf.h that are
> missing from this specific commit. This causes a build failure in
> tools/lib/bpf/bpf.c due to undeclared identifiers.
> 
> Should this commit include the UAPI header updates, or be reordered after
> the corresponding kernel patch to prevent breaking git bisect?

added in:
  2beba92273f5 bpf: Add support for tracing multi link

this commit compiles fine

jirka

> 
> > +		if (!OPTS_ZEROED(opts, tracing_multi))
> > +			return libbpf_err(-EINVAL);
> > +		break;
> >  	case BPF_TRACE_RAW_TP:
> >  	case BPF_TRACE_FENTRY:
> >  	case BPF_TRACE_FEXIT:
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260603110554.29590-19-jolsa@kernel.org?part=1
