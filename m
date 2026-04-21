Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEC37CD37
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761820; cv=none; b=qrsdTRSivWlfkx53xooRPvK+cFJTZRZKnOPODdc/yxJ/LBg1vo/t8cjVNklRXcEL+Hl9KCpZlXpK3Mr5MXIUVZ5a5N3GTtImCHwAojDG8EDr8ERsZPItVX/JfJP8ReC70OUxrZicy4xJY0vP90q1pt0qm8rywRyThAPN0bIQJuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761820; c=relaxed/simple;
	bh=CIZL7UDOzIHx4kBy3bG1HxhhYIu6lC6fwaUSbwlvVis=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESewEMpFM9Dzxyz4GWgYCJsRxfUEc4eYUNwfmSiJkMfk1AVQJSsO6UV73U6J8DeP6uzL4Yvd5FEPgolB7KYJLgfgRPQayYMlWkOy7M7Pv3Dv2zZ82cdUKG6xRXEk4bjAGtabNQtEUy/ac3epRiYGOOebAyjpGJimZ81Vb664+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDnsC1Xz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDnsC1Xz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ba840146so37422075e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761817; x=1777366617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PogW4mupQvvo8UZj9OhLW51Gud2lL2Fw5bDCoh6om3g=;
        b=ZDnsC1XziHsZGBC2sG03D6CpCD2jOusO4w/Zmhnoq/WaU2zLpmzPf3mOpu7h8U7xMa
         TEQhNzSWrf0XGyq6n81q5OQ6uMsA2M1U8NEnbjdJeJ6vjhX0NM7Ot3afItRUCVuudkxS
         fiXoYd20ra8UB5Kg/lLArsqN2kK7sGWLXGIl+d9YpuryEclmHCylPdFuBml1lvU/rOZz
         Jk69EU0ugnT/hOQS6/fs/+t1v3OjFKhZLWR3Sy4PMD9By4IbEW+ZTO8i86nFgWc9stnG
         XDoP9QjSICim7pM4Oh202WcvbD4uWZnr9+anw5DDKKwxgmwdkSPAx4o0q2GyHg9dOH0r
         +O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761817; x=1777366617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PogW4mupQvvo8UZj9OhLW51Gud2lL2Fw5bDCoh6om3g=;
        b=ndwU3S5vncSVh/JPxuWYkJ4tptT96lLr1RRSS8egXXc+DcXb6bF50nEQ5UzQnEsl+v
         60aaM5pqJbKYCWfiwKetAqghuSfpucRvV1h4W3rSwVj+jAtoi/7jv2Ig4BtnmR9c8VOW
         IGLm++2vbpyz0WXx3tSJbXrETK0er5XGEwm6OBN3END4iz4N5kyttr9r4x+F2TP40Wcp
         Yx/si0EMoTLqDewm88Td17Qb8sv4VIGs5t9/aMQ/zK5iWBbyV0Xgxrl4J95e+MBweP4F
         6BG/Nfmfutwp0tXoWPkwoepVNEEYyEGVwIrYZ3C10T63ERfaGm3htx/RMVZmKwSuhHp7
         MugA==
X-Gm-Message-State: AOJu0Yw727skVOj/kj++duwnAFYqLC06JAkLYxb8gJdVOeqFiy7qzgKr
	FyU+TQmOUs5nX2xx1IOiEpPIf55C2Dnd6vqe96aAozx/QRJ/l3ob8O7Y0/ssASC4
X-Gm-Gg: AeBDies/TCfcpB4tqfB2XEyJ3Fc4TgbYEKvah8xVclMa3ip/U6keFY09f3HuZjGTmyn
	4JsD5YyoJzW2ebnRvZs+HyZRxF4+lTtDhkXWGBA2YJ3Z/dK72yLmI6qI0nAi1Izw5Gf64wGyLCt
	YfFQCkrmiHpYxO5zCpfnpCY61NcVtbdq+saHXY6VN3w1EbIEtFkT9dlwTH7kmOdcwr+ycU1Zd5Z
	AGRSrZpZVjYu5r+bGaVZs7+7QiANTdW6A+y4fNTEfoQ2hIu0QN7Rknd+vVeGgGeaBYE4if2xT45
	gwcaheBDxJOz6wk2FKD1XT0TzPl5AwCB6nKD2Bj3iliUUMEB1UXfjcPY0q0IHEgOt9aQ1PIm5C2
	iPY5Q3PkOrtAnymFTL7UyzKtBkuszg6EdxJjYFTxSA11N+SDn0roGfZ1Fqzs8pJOt29Vg20iwc/
	/4wYF8V6o=
X-Received: by 2002:a05:600c:890b:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-488fb775a35mr171422315e9.19.1776761817133;
        Tue, 21 Apr 2026 01:56:57 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm584707825e9.3.2026.04.21.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:56:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:56:55 +0200
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 19/28] libbpf: Add btf_type_is_traceable_func
 function
Message-ID: <aec71yEZE8KF19Xz@krava>
References: <20260417192502.194548-20-jolsa@kernel.org>
 <20260418034049.4F212C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418034049.4F212C19424@smtp.kernel.org>

On Sat, Apr 18, 2026 at 03:40:48AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [High] Unsafe BTF type resolution in `btf_type_is_traceable_func` lacks validation and bounds checking, leading to out-of-bounds read and segfault.
> - [Medium] `btf_get_type_size` hardcodes `sizeof(void *)` for pointer sizes, breaking cross-architecture analysis.
> - [Medium] Missing maximum resolution depth in type modifier loop allows Denial of Service via infinite loop.
> --
> 
> commit 70d9630993310d9569ee7d038356f4a4ec3a18e9
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Add btf_type_is_traceable_func function
> 
> Adds the btf_type_is_traceable_func function to perform checks on functions
> to prevent attachment on some functions. Exports it via libbpf_internal.h
> for use by benchmark tests.
> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3a80a018fc7d5..65a9ac10053d5 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > @@ -12425,6 +12425,80 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
> >  	return ret;
> >  }
> >  
> > +#define MAX_BPF_FUNC_ARGS 12
> > +
> > +static bool btf_type_is_modifier(const struct btf_type *t)
> > +{
> > +	switch (BTF_INFO_KIND(t->info)) {
> > +	case BTF_KIND_TYPEDEF:
> > +	case BTF_KIND_VOLATILE:
> > +	case BTF_KIND_CONST:
> > +	case BTF_KIND_RESTRICT:
> > +	case BTF_KIND_TYPE_TAG:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static int btf_get_type_size(const struct btf *btf, __u32 type_id,
> > +			     const struct btf_type **ret_type)
> > +{
> > +	const struct btf_type *t;
> > +
> > +	*ret_type = btf__type_by_id(btf, 0);
> > +	if (!type_id)
> > +		return 0;
> > +	t = btf__type_by_id(btf, type_id);
> > +	while (t && btf_type_is_modifier(t))
> > +		t = btf__type_by_id(btf, t->type);
> 
> Does this loop need a maximum resolution depth limit?
> 
> If a malformed BTF object contains a circular modifier reference (e.g.,
> typedef A -> const B -> typedef A), could this loop spin infinitely and
> cause a hang?

I will add that, something like in btf__resolve_type

> 
> > +	if (!t)
> > +		return -EINVAL;
> > +	*ret_type = t;
> > +	if (btf_is_ptr(t))
> > +		return sizeof(void *);
> 
> Does this correctly calculate the pointer size for cross-architecture
> analysis?
> 
> Since libbpf is a user-space library that may process BTF blobs from
> different architectures (like a 64-bit tool processing a 32-bit BPF
> object), will hardcoding sizeof(void *) return the host's pointer size
> instead of the target's pointer size?
> 
> Would using btf__pointer_size(btf) be more appropriate here?

yep, will change

> 
> > +	if (btf_is_int(t) || btf_is_any_enum(t) || btf_is_struct(t) || btf_is_union(t))
> > +		return t->size;
> > +	return -EINVAL;
> > +}
> > +
> > +bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t)
> > +{
> > +	const struct btf_param *args;
> > +	const struct btf_type *proto;
> > +	__u32 i, nargs;
> > +	int ret;
> > +
> > +	proto = btf_type_by_id(btf, t->type);
> 
> Could this cause an out-of-bounds read if t is not a function type?
> 
> Because the type and size fields share a union in struct btf_type, passing
> a type like BTF_KIND_STRUCT causes its size to be misinterpreted as a type
> ID. The internal btf_type_by_id() helper skips bounds checking.
> 
> If the interpreted ID exceeds the BTF type array bounds, it might read past
> the end of the array and return a garbage pointer, which would then be
> dereferenced in the next line.
> 
> Should this verify !btf_is_func(t) first, and use the bounds-checked public
> API btf__type_by_id() along with a NULL check for proto?

will add the check

jirka
