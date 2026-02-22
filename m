Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71578223702
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770912; cv=none; b=KjOCNyuBmZ7SfihWUnhAj6LVVxOVjBf4/peo/gB2C8lMuNTYF8MYfkHoqR0tu6hRpLvARe6sE5C/jY6v7ImLr456ppHZhoV6OFZZEGB9lQedzpfOIZlO0ORQPKLlyYj74wFdqps9avrZxjhM7+l3iRuyRf3s4GLFEOqwXWlVSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770912; c=relaxed/simple;
	bh=vktM7BRk058T9EgqkKWWszp5qZZmm5bzsA9nWsQ334E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px0L46nSzshEKUXUe5IbkGKpeWUYcqW493BpyrfI8MHAMMKgZ/l0WPzASQqHKmKvs4wX0hgzUtr6iuf0ew3CLvHdAoJhSVrNdOhG1X/UGA3oq1KY8V2g4MaKlts+XQS4MgRZjJ3eRx0sI+E2IzpdPSeZ6sEcO94XsLeiiMRFYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga9RQDEg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga9RQDEg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4833115090dso33467165e9.3
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770910; x=1772375710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObkTvvTUXDhmbm+XB5jZaN2+4troEqpoA0rJxjwXv7I=;
        b=ga9RQDEgCckqnCR/qnc/zRrxHSOa0GuVBXZ9i2WyxV5PbVNWteT50flwmALIM7NAuo
         AOnGaEMfSCWZc/6e3PJrqzzJgAFYAE9LuTXHospBlxw9m+1nsbPggkt2oFouD10vB0vV
         JjGSrmuL6+Se9qCLLaNlB30WhrhcVvnr2P8GyS3Wf15BgFKajuKUOUTYx+ghtk48Ai0K
         AMzpBedG2ifyjNNohf+KKt3O5TcqgTKUfenZ42LstTrZE8CyHCyiXGzFSuwDFCkxymda
         y+tbV8/2jxj1hckz+5sXrKpGu6pHGDES09VxtxnTgYy3TARqfaRDvoyfwkLuNo3J9NLF
         vBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770910; x=1772375710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObkTvvTUXDhmbm+XB5jZaN2+4troEqpoA0rJxjwXv7I=;
        b=GlLzIOQOcBmJe5PNZhm+jDkAZScfNtGt9rpLVk4cnL+FF+Lzf3gJXoOtq8XIP7IxGb
         ehENXos4UEDbVADQjU0saYV/hrn39otb9SsZJRjggddU00NYJ+CJX+N0GhRwU8zZplOi
         l9hv5EVmC/6KKfpMo4vDF6bzPTHxfF899FsreyMc8NWucMpDJDB4xs5Hz4yYq/jOI+r3
         5tXJ+nyY2iCWunehnsQNFAxNIJwYIE5kb+OyaceiTOcQnwacrzWq7O59bkdQYrtnV9Jt
         bFzDPovqj3CPQ/r0Gj4TtvK9PYGcF760gjVhNet41aTmNlGdw6hHcfFwtDhpqDMyD2Tm
         v5vA==
X-Forwarded-Encrypted: i=1; AJvYcCVJbV++T3encTAteTrDm9NJNm0xmp8w8L0RPVNrUjbUvppW0ePYsdrSof2rW085d3JBJao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT4FAnnTelN7wRGDZKzhL6UGmg/yIB2JaQi5ZevVetiawhASS6
	cEqe2v1Ci7fyl6nyxvsJLX+N1/fDHeXKfirK/ZtFgtoqpxXngHrhi6T0
X-Gm-Gg: AZuq6aI5DYYZYNdqZqM3XHgBaLXC+LG96VZHQrd1pY1mRCHVKaMzzFKTiAQrcjitogo
	yDMtBXW4nCoALFA3kzcWQIb7rc/7gnDD2QDR6EVzWLYAi+ZTHkcWkTpQ+O58yDDQ63zTGh53V9H
	/zw7zk3lGLHq62j0Bv6/iTE6Jq/wjQoAA9+L7wBZwDC5h4vLH7com4B5e3diJGgjSTvexibzswu
	zDdQakLPSAn7T5wcUUPoRGDhqL9iiuaYQ2WYH/ATlSULMjmgrETDZQNXSlXS9LSQK3RJT8NRSSH
	JRGW5ucREWDo9oUv4sXwp1Fko1ykFOx+jEkGmvXQnAUrZJ1jM0RQZGjf5NCOyaSfegdc/il92PY
	6S0SxVt7yfXDMKRjO9QaYwG54bz/8Z+tRktZg5n3RuPG2RhzzqRA6PNLa2jgXIJppWVwK+zETrK
	HMbt6wJpI=
X-Received: by 2002:a05:600c:45cc:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-483a95f554amr95193665e9.23.1771770909621;
        Sun, 22 Feb 2026 06:35:09 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb3f31sm120803945e9.13.2026.02.22.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:35:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:35:07 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 08/17] bpf: Add support for tracing multi link
Message-ID: <aZsUG16KRLWzpQO-@krava>
References: <20260220100649.628307-9-jolsa@kernel.org>
 <e41633c6d6d32fabb08ecc4ae8432a45afaa72aa61756601f4cdb9aebd039f86@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41633c6d6d32fabb08ecc4ae8432a45afaa72aa61756601f4cdb9aebd039f86@mail.kernel.org>

On Fri, Feb 20, 2026 at 10:57:58AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> 
> [ ... ]
> 
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing)
> 
> The existing BPF_LINK_TYPE_TRACING also uses "tracing" as its name
> argument:
> 
>     BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> 
> This means bpf_link_type_strs[] will contain "tracing" for both
> BPF_LINK_TYPE_TRACING and BPF_LINK_TYPE_TRACING_MULTI, making them
> indistinguishable in fdinfo output via bpf_link_show_fdinfo().
> 
> The libbpf side correctly uses "tracing_multi":
> 
>     [BPF_LINK_TYPE_TRACING_MULTI] = "tracing_multi",
> 
> Should this be BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
> to match?

it should, fixed

> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> > +{
> 
> [ ... ]
> 
> > +	ids = kvmalloc_array(cnt, sizeof(*ids), GFP_KERNEL);
> 
> [ ... ]
> 
> > +	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
>                 ^^^^^^
> 
> The ids array above uses kvmalloc_array() to handle large allocations,
> but the link struct uses kzalloc(). With MAX_TRACING_MULTI_CNT at 1M
> and each bpf_tracing_multi_node being roughly 40 bytes,
> struct_size() can request up to ~40MB of contiguous memory. kzalloc()
> is limited to KMALLOC_MAX_SIZE (~4MB on x86_64), so this will fail
> for cnt values above roughly 100K.
> 
> Would kvzalloc() work here instead? bpf_tracing_multi_link_dealloc()
> would need to use kvfree() accordingly:
> 
> > +static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
> > +{
> > +	struct bpf_tracing_multi_link *tr_link =
> > +		container_of(link, struct bpf_tracing_multi_link, link);
> > +
> > +	kfree(tr_link);

yes, makes sense, will fix, thnx

jirka
