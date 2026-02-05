Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBB221FCF
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299160; cv=none; b=mkabA79F2SQuXfULDxMFcJ2OEG+woCM4eeEQYBBY8iBTHk1AomkqzUL2T169GiB1EJOc3Bl6ogxp5rZKf0jq2w6hchUwcclyK7pN1+Bc0ku2cIfGdqvOabFsK4NC+n2pvcoQOeN7FvRNwvXvQfcfR3JX85hIYMlhZBo8vx11xh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299160; c=relaxed/simple;
	bh=zntokVry81Mkk3OI0HoMyp2+zaPjjBCi0jfPMCHWqZg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kewwldDMhGTu5tB/tgD6uCi4uify9HDcu2Bd14kHUDoJ3JmtCwxArp5zbtg359MXC4cZFvggOPmk1bMseRR3Mbmvzl5aXM7Xsh5YY822CAzYoHLcsfB3gpfuOTp39WItP8ai0BwiUMRE+Ngntl3Vb/ZdYoAyZPMTrXIvG482wwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk+49ZGL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk+49ZGL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4805ef35864so8567395e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770299159; x=1770903959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSe3DP+UKMA69sAOGcKJ9mzaLMcIBDtArPSidVC84FE=;
        b=Bk+49ZGLKHTgkFl2QDWCyWIuR5hjTfD/7J1/uqxl6AWiUu85+FZeEOc+BJJo+iBLmg
         +Z30KcZ03q/+CDTalS/vb2LlddsREhQkfKaKkO8CZs5g30iy38znfaT8JMc9uRRNUuaJ
         JiNTCrPfj+0ci8vSJvQrU3wxtLXPdS1YZ5TUoCyZtvPjUMcv+RRzHdcdOEhXr1q6dJnm
         dWgos2of80T7ehiCIqT5QIawYyp4363QcZelkIq8XeIitGblChpnkzYtLTknnUrmx0fh
         lseeeVrUQ/HA7+6IX+Ikrm2CCfUm9oC2MHU7ZgmeJtEl3OYTIKjV3KyvndCuZsruw7Xp
         7wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299159; x=1770903959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSe3DP+UKMA69sAOGcKJ9mzaLMcIBDtArPSidVC84FE=;
        b=wh1jKQuKNENAG8Xxm1OcgvNLcr6IK/7vJMHHaxRnDmD7rLxcIWpWVu2QP5epB0CCgO
         KXHZF15DQNE3IWeDNl4GlDTZSb9092yb7oaL/8ZDs7KsyZKnF983pAa7mGpRyDP/gHX8
         GF2JY4dO4fsPM5EsiWnv1t/qQHKkDILWRzLsQXfRjKaXfR2A533oYreYRvQF8pywi8Me
         3WO8lV9hWJ/t9Cri0TNh+dNRUCtSc1M/lqQeqPXlvQ/IbQNa4iG/FZoOf1Z4J30FEnGe
         6+a52gYWCyhXa6KuQcr5/yRzNyEAt/8eoQc55I+lx0xnK/Ib5QW7F10sP3JKnneVObIX
         CFoA==
X-Forwarded-Encrypted: i=1; AJvYcCUxI7nnz/oI6tBqrN1mLyqmgaQ4/9xUkmjxFcpgRTSQ+hSmJUh6LjPNtgtg3BZNZ2/m6RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71Z6xGrln828WogUUsyiFQoUTBHTPICZo7iNLgevu9xjoPJA/
	fejOcvudHQLhFWQmyqykEibzx3GkY3hjaycbVncFwqJ7UVwKL8bVJxvM
X-Gm-Gg: AZuq6aKyUIm2Uwdp2EBky7fXuboGX6R7o+QH00KMxN0udVpzn8p3LrV6kR33AGcFjET
	6/oOgoax3yIp2fZFPQe7q30h13D9YoMTafkUq3kNr48lmUFtcYksjcgnfLWRBfhsvYGhV8ioedB
	xwfg7K5KDYAAyNpiS09pyTbZpmiVa/nZw2nI+i9jmWAbXsv+qxRq7jz0xStc2VtSxcgywQhAH/G
	6Dtl+v9AmStBW5FLEMEJsk9SXxRTIbBc6N7+oce8rqwspSqjD6//cDLZBbufXCr3zFOpH9vyUIA
	+Mq6lGwYUpQmP8qtn07hG2lq0RH8+WFTmgOxDNNo6ax0HyWV1jOYOeKv7UAPYjSt368TpxAkYvm
	IsKFMxTzrMxKpjVPNBJ5dH9wEQc1IOJp/SsSBtV4exupE33BhKQxnAOjT2RyC
X-Received: by 2002:a05:600c:1f08:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-4830e993164mr89199165e9.28.1770299157801;
        Thu, 05 Feb 2026 05:45:57 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d3f007sm87930895e9.9.2026.02.05.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:45:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Feb 2026 14:45:55 +0100
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC bpf-next 06/12] bpf: Add bpf_trampoline_multi_attach/detach
 functions
Message-ID: <aYSfEy8Zf8bCs4-j@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-7-jolsa@kernel.org>
 <1945516.tdWV9SEqCh@7940hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1945516.tdWV9SEqCh@7940hx>

On Thu, Feb 05, 2026 at 05:16:49PM +0800, Menglong Dong wrote:
> On 2026/2/3 17:38 Jiri Olsa <jolsa@kernel.org> write:
> > Adding bpf_trampoline_multi_attach/detach functions that allows
> > to attach/detach multi tracing trampoline.
> > 
> > The attachment is defined with bpf_program and array of BTF ids
> > of functions to attach the bpf program to.
> > 
> [...]
> > @@ -367,7 +367,11 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
> >  	head = &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BITS)];
> >  	hlist_add_head(&tr->hlist_ip, head);
> >  	refcount_set(&tr->refcnt, 1);
> > +#ifdef CONFIG_LOCKDEP
> > +	mutex_init_with_key(&tr->mutex, &__lockdep_no_track__);
> > +#else
> >  	mutex_init(&tr->mutex);
> > +#endif
> >  	for (i = 0; i < BPF_TRAMP_MAX; i++)
> >  		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
> >  out:
> > @@ -1400,6 +1404,188 @@ int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> >  	return -ENOTSUPP;
> >  }
> >  
> > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && defined(CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS)
> 
> Hi, Jiri. It's great to see your tracing_multi link finally. It looks great ;)

heya, thanks ;-)

> 
> After analyzing a little deeper on the SINGLE_FTRACE_DIRECT_OPS, I
> understand why it is only supported on x86_64 for now. It seems that
> it's a little hard to implement it in the other arch, as we need to
> restructure the implement of ftrace direct call.
> 
> So do we need some more ftrace API here to make the tracing multi-link
> independent from SINGLE_FTRACE_DIRECT_OPS? Otherwise, we can only
> use it on x86_64.

I tried to describe it in commit [2] changelog:

    At the moment we can enable this only on x86 arch, because arm relies
    on ftrace_ops object representing just single trampoline image (stored
    in ftrace_ops::direct_call). Archs that do not support this will continue
    to use *_ftrace_direct api.

> 
> Have you ever tried to implement the SINGLE_FTRACE_DIRECT_OPS on arm64?
> The direct call on arm64 is so complex, and I didn't work it out :/

yes, it seems to be difficult atm, Mark commented on that in [1],
I don't know arm that good to be of much help in here, cc-ing Mark

jirka


[1] https://lore.kernel.org/bpf/aIyNOd18TRLu8EpY@J2N7QTR9R3/
[2] 424f6a361096 ("bpf,x86: Use single ftrace_ops for direct calls")

> 
> Thanks!
> Menglong Dong
> 
> > +
> > +struct fentry_multi_data {
> > +	struct ftrace_hash *unreg;
> > +	struct ftrace_hash *modify;
> > +	struct ftrace_hash *reg;
> > +};
> > +
> [...]
> > 
> > 
> > 
> 
> 
> 
> 
