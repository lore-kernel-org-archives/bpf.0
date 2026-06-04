Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017813C6A27
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559984; cv=none; b=QMAhWUrLgGheTcsDKURx/nl1Jp5+dkhFcurwc/3P//EHAabgs1dCMK9HaiEBJcuysvqlAj8UDuLeiZgWAQFSwCzrXnG2pzOJ7vG0/rhnfDykj7E+fCiA/Gann0MhINqUiDydSwNTAHFLEfuOm6UBQv10+DH0IEhDZq6NsGfzsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559984; c=relaxed/simple;
	bh=EObEDmgAbrmoMGQf41FBnakR8lHg3gqKEeVus6KjzGk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJSMa4xKZo8XaKkZpyBFnrQlllOF6LN+Go+LKSLnEdOVaCWRTdBbyXEiswWYFnpMSwKKN1Jb72umbHBhCozTbJhO6Nqvjc33MZOTkd5nIMNEwaYo01wrVl7TNMn4K7gmTPgj16d1J7iIrAamhZqniS1R0r6t+iVVqgLW9eW0aYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYlWNMfS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYlWNMfS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45fd45e596cso173248f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559981; x=1781164781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXS/z/soeHYJ/mNI5HAUAm9JLuJ2u2VWKE1vQ89HSDM=;
        b=hYlWNMfSisPl/AG5b6k6aeVZ8H+WcuRkxFC5x8IpfEr732yZYtwOYrIOQl/dvucMc8
         yQ7j/2AvkalnXC1Q9jbHFlQODbKUlZ/pDzmqvCBqEupaWo6P/H7qGZ6ET5aghpkebe8/
         SDuNJB6pQz+PwgePvuQmiF3wlc6p3E9SX9TmiFOtBDpm7jHXyDm4bA7nJnFySV5aWL/+
         eriLFcdEiFUpp0BlPwP9WRc0TQSb3DkCie4om90bIrGkYRBUDdQU7bq2ml57ihrFeErz
         L+voJRMlmvji76zW7PoKPHbNtGmszOKUeBRHtUMeG+yH1Uiy8mjgsw+WIfV2s76yjzvW
         QHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559981; x=1781164781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXS/z/soeHYJ/mNI5HAUAm9JLuJ2u2VWKE1vQ89HSDM=;
        b=MvW9LJ1Hl6F6jD/aEO0iTdQUK5rFGUjxgpHa5m4cQ1a8+lWIfacKUrVJhd8S4jsdPp
         bhDfqiG+YS//irN+AQav5Uy9ofW0X3mEv00N7ZF01T+qxAoL3sb86gZ3VyM6Qh90NYIo
         wkT1qYsznLdtIzJ0sIHOR6yAM0+IHg5hL03N6TmTqRq5YAwEGOXrKI+NyqwMZRoZQ6lR
         5QwEKIHUSi/WQXIJMxr7MTcVRHmS+Nz/cTJGUA09UUzFaQL+7vwd9t/FOq5UhLx7n6OZ
         ELlsn5HMAYIE6cV7jNK3z6c3ifdVVWCQ0T9QId+3uv7nECV/k3bKuOt7bYrVhC20a17Q
         gxFw==
X-Gm-Message-State: AOJu0Yy09GHOwUbVPnQSxZb7oVTNUgT0FhyhB/eF9Li4YyG+XjuNtr8U
	SHHHRfRNcz0woNaGO959FLMaYKQxfy71rP9vBJr+yEgZx4LflEUEQiER
X-Gm-Gg: Acq92OF5HEeWpJB6rAVVI8DF3ks4WwLlL8RQ6q/2YCiS27ylmNHBw5UH9hHBitWeuuD
	tBjcIUMcnnFT5fZw2tVIKisoEXOpswkRWmc+E/RuzKcP9P+KXlgBvttbqqUpD9ZlB/P/APFi9od
	vEznfD/4A44XYPP5gKuQqKgAXAiBHZseizs6FZ4B5n1OWbs9Egouzxu4IJLOVbWUIWEJ+mfU/uz
	E7E//T9vqH8WJG4gA7fMWoCiGeB+OowbkGvnSgE2eLOEhSbYaz7kZ9nHsMvvDPLOgZ3f/YQccuB
	/YPLmtnSy8893KkS0OK0pjYms4wGamxD0w88Kb2EiLaN+OMsWCIc1P+zVCEQ6yjr9TO4PLY4DIP
	GyQoykXPjdQI5kXF8riIC2KN038mgML0Ymrd9scmgV0plZr9xlzYqK2IsQlYS4UswVObAm7P85o
	qoZWIZlef/9k1jnpp8RrweMg4T7WYby7xRA3LN
X-Received: by 2002:a5d:649c:0:b0:45e:eea1:f1e9 with SMTP id ffacd0b85a97d-460217a7001mr7788727f8f.11.1780559981312;
        Thu, 04 Jun 2026 00:59:41 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm11330211f8f.14.2026.06.04.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:59:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 09:59:39 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv7 bpf-next 19/29] libbpf: Add btf_type_is_traceable_func
 function
Message-ID: <aiEwa0ymzmFBA2J6@krava>
References: <20260603110554.29590-20-jolsa@kernel.org>
 <20260603113617.49FA41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603113617.49FA41F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 11:36:16AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] btf_get_type_size() fails to handle union types, leading to the incorrect rejection of functions with valid union arguments.
> --
> 
> commit 3f5d4e8440eaf929ad94e8774deb7fce495d30c8
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> libbpf: Add btf_type_is_traceable_func function
> 
> This commit adds the btf_type_is_traceable_func function to libbpf to
> perform the same checks as the kernel's btf_distill_func_proto, preventing
> attachment on unsupported functions. It exports this function via
> libbpf_internal.h for use in benchmark tests.
> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ab2071fdd3e8b..c659865ec2def 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > +static int btf_get_type_size(const struct btf *btf, __u32 type_id,
> > +			     const struct btf_type **ret_type)
> > +{
> > +	const struct btf_type *t;
> > +	int i;
> > +
> > +	*ret_type = btf__type_by_id(btf, 0);
> > +	if (!type_id)
> > +		return 0;
> > +	t = btf__type_by_id(btf, type_id);
> > +	for (i = 0; i < MAX_RESOLVE_DEPTH && t && btf_type_is_modifier(t); i++)
> > +		t = btf__type_by_id(btf, t->type);
> > +	if (!t || i == MAX_RESOLVE_DEPTH)
> > +		return -EINVAL;
> > +	*ret_type = t;
> > +	if (btf_is_ptr(t))
> > +		return btf__pointer_size(btf);
> > +	if (btf_is_int(t) || btf_is_any_enum(t) || btf_is_struct(t))
> > +		return t->size;
> 
> [Severity: Medium]
> Will this return -EINVAL for union types?
> 
> Unlike the kernel where btf_type_is_struct() covers both structs and unions,

ugh.. kernel btf_type_is_struct checks for both struct and union, nice
will add the union check back

jirka
