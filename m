Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590B38422E
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475321; cv=none; b=X6TMsoe01mOOByRnndHFsTKopydYX2gm8yUgPvMdwG7CuHM6uqWcJXzEJpfeann3wAjrIKFgULAnBiscB3OR+Tm7wvSWg4yhY4YmFQIUYvvmnCfov4jE0hSIojyqpMxIjWVChLv+sB6eeacmqggrpteH8Y4Aw0KMI8Iroo8bViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475321; c=relaxed/simple;
	bh=N4j8WVwGW2dUhodmKwMPLJOmYrZt1oI3mSS15+zfokE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb3z97cjKwgGyiDjW30CRlVvpWSvgw91cxIB5PT/+QtNXH5POh7h7+d1dgNBqlQwdWSWinQLYWxbz4yoP9Xlb6ZzNUZk9xsr8ApTRz2oo3+4FES5Xk3WDayf+Dyyb+wl0NBJIpZQUNodTzQIVMOBba5ZOv2wxm6OdbJmAYZLQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgpvLM3k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgpvLM3k"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso3881875e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774475318; x=1775080118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xc298YiEg0UGoMoYsdPxMm8O+yLEPvDueB+D9xvQQg=;
        b=YgpvLM3kz4QTooMlp3X/oyvIKPNEeRIo6i7vYJtWTugc4/meF7hyUE84be+N8CwjH6
         x3qXdVnozYkGGEdiF2yK6HXNrb0kBw8TFbHIQlEKgzmKE/T9+rKGOpr4JIWxWP0k9/J2
         IpfSk1gGx4+yPQCAI1LmpcE1ahDWbc7GJUiY7HhiJioOYDajlB+nQ3L9L/pcG4dowxQT
         9gq6GLBbL3/rkpFyEmCa7aQsYytA80UFmlbyovNY9wihb+GUsI1AwsFmQ6cifm9ME1xN
         fBMwCSy/iKxa87bSWRhRyuDw3N/3oOWuKFWNk0Ccpi72gfSuOvbml7b1x6y06j55psy+
         AADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774475318; x=1775080118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Xc298YiEg0UGoMoYsdPxMm8O+yLEPvDueB+D9xvQQg=;
        b=A3Va4yr66GXZwM0rqLl2ohsDlOj+sGZ002a71D4Q0UvGkKHk4hmL69BgXUWKzNbLik
         nqi91A7NxUXzwct2TswJ04ikROfL2+y4OcTCsvU4d9bg4ANQMP3ZsxOqn/hIdHQ46eAB
         PNdADg/lFGcEhtoVQISb6lgENeyxLpG5uoZEqEaiQhK5tNOFAOj1NcFXUPlh4aL44Kx9
         ky/ltKohvmrkJqSh/xOhRSXzBQkAKUOzY2KQannHBmLHNusc0+DIq65cVDDT7mh30yCl
         iDI/M1cfaZnn0a7B1URmFd1RLBePI1V/WlekIYRsYxIYgnY0iOMaEGaLeKgPdEPuiu4M
         hrSw==
X-Forwarded-Encrypted: i=1; AJvYcCUmSTEHQZpXSTMcCDhfvp/alwa11dhrOU7SBVG/f8Eb/we/wJYuWN+KUCNkS78cTHxp8UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLlgLH5Ny1EiPIlKiEcW154DRX5J+wGl/HmtAERjn6NDaZMSE
	GQfUxc24l9uxoe+6blcXy/naAvDVKw3tiUrkfjMgm5YPejyNHKWSgNgD
X-Gm-Gg: ATEYQzwG9R7dSpiCrlS75n+/ym+3yFvxn2yHak1GGVhOfYFaM5zPw5u+tx0m2FVuhA5
	5J6/PKMh285QLYkYjk7j2nJ7OuU5sgxVsQcEDIRxjDAFNcxjGbzdp2vdUflZRe5p1XvdOw81tGn
	XO+6p6TobPTA4M7hdWXKQIDijv76tSACr9f9X8teB6bGEmP+YGuLi3xWzVaaoZXvIpGzSm4FG49
	GgU9BEqAGVYqLbga8Hw9SGKg1dOmZGTTzK4lueXLH3B/ffsFSZ8lATLd1uz2VUMeJAbxnmIJL+6
	l5h6kLtB7vmRDoSy2DLY+FNj5Do6omAZj7/jb2iCn3APFbzNusywDOnwh7WNNtBZwPgmVdugQRv
	uMkUp31iX6KVj/rjjJ4CDzzibInMJgeESvk5Mse5E0qe7duSPtSNYm1B6JtzJXnhrKeaIx1Hps4
	I50EWjElY/ussfn9sgOvjEShocanbxUBVJVOtldOLN/Q==
X-Received: by 2002:a05:600c:1f8e:b0:485:3fa9:358c with SMTP id 5b1f17b1804b1-4871605677amr81195465e9.17.1774475317944;
        Wed, 25 Mar 2026 14:48:37 -0700 (PDT)
Received: from krava (h082218179122.host.wavenet.at. [82.218.179.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbca47dsm4244455e9.1.2026.03.25.14.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:48:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Mar 2026 22:48:34 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv4 bpf-next 24/25] selftests/bpf: Add tracing multi attach
 benchmark test
Message-ID: <acRYMqbD8cgI95uI@krava>
References: <20260324081846.2334094-1-jolsa@kernel.org>
 <20260324081846.2334094-25-jolsa@kernel.org>
 <7a119223-9994-4edc-af0b-f1ee9876cd20@linux.dev>
 <CAADnVQL3gO=kuvDHQNa8VfL_NWUMvBv6=vrXkOd=8Fe9-dcU3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQL3gO=kuvDHQNa8VfL_NWUMvBv6=vrXkOd=8Fe9-dcU3A@mail.gmail.com>

On Wed, Mar 25, 2026 at 08:11:00AM -0700, Alexei Starovoitov wrote:

SNIP

> > > +     attach_start_ns = get_time_ns();
> > > +     link = bpf_program__attach_tracing_multi(skel->progs.bench, NULL, &opts);
> > > +     attach_end_ns = get_time_ns();
> > > +
> > > +     if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
> > > +             goto cleanup;
> > > +
> > > +     detach_start_ns = get_time_ns();
> > > +     bpf_link__destroy(link);
> > > +     detach_end_ns = get_time_ns();
> > > +
> > > +     attach_delta = (attach_end_ns - attach_start_ns) / 1000000000.0;
> > > +     detach_delta = (detach_end_ns - detach_start_ns) / 1000000000.0;
> > > +
> > > +     printf("%s: found %lu functions\n", __func__, cnt);
> > > +     printf("%s: attached in %7.3lfs\n", __func__, attach_delta);
> > > +     printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
> > > +
> > > +cleanup:
> > > +     tracing_multi_bench__destroy(skel);
> > > +     tdestroy(root, tdestroy_free_nop);
> > > +     free_kallsyms_local(ksyms);
> > > +     free(ids);
> >
> > Is btf__free(btf) missing here? Since 'btf' was calloc inner
> > btf__load_vmlinux_btf().
> 
> Good point.
> Leon, please trim your replies. No need to quote the whole patch.
> 
> btw sashiko caught it too:
> https://sashiko.dev/#/patchset/20260324081846.2334094-1-jolsa%40kernel.org
> and many other bugs beyond what bpf CI could find.
> 
> Jiri, please address them all.

ok, will check

jirka
