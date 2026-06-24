Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF93A6407
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293371; cv=none; b=itYpUcS91248NKgleLURej1F2KJBNtIErqjQuOxo9uEnD8Lp3Ek+pJ8zL6qzk+4c9Y29l2cEL4fMHzQ6gJhCBUGZimjyFZNsigypCYFuG7iMewe4faFr1j/B1At7AZK38luLeuzTjfy8kJmZWIDiVkfgkY8Mzu4cch4HwaADZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293371; c=relaxed/simple;
	bh=bKuUFw3D4a/P/EpQArTHTGUckc+SVMxio+Q/kIZQebU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XotqEVhi58wXSjvT3oSLcs27Ub56o+WEPGOu9Du5B14s/xoKy7fAI3aiBByhOjGqwLIxQodagHu0V1WrQT+CNG237nztAc0xX1MajpRSkQh3o7W8p76ehX346hNpkYpp1oBPQbTKSutMi3m8OSQOqjuGRv8couZ2JH1WVnPXfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9zNZeDL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9zNZeDL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ac357c55so7300415e9.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782293361; x=1782898161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JZ4YDevUIo1udhjLYGex7mGuWUU0PrMDtr2MU5bE7Qo=;
        b=P9zNZeDL7WveqIy5wjBdqpGHkAk7ayaB/E0Nkuf9flYf1N1HbZCqUKMJX3o5Qxjv+F
         EA5vys7FTW3AplnVchBAjbafLWVAbwhj5F77fTJPNLSXu6v98y8aVyVSwdkwzZ/Uz3co
         129VOzKt2Q1OAUuKHnQn6oFmdbRqVcScrKWVqoHFJsyozSbY4tIqNzRv82ADl4M1bkAl
         /YQuTbH31ttUreCR3u2VIWlNjQorbw40kkZY9fXNpbUjR8GnJ2eNkAYqK3KOytcOY29s
         mEI08rHjWfo3sk+7bdcVUZNfTSQsafb57ouIfE/Cd0Y/aq+W9BJLO0F9mPNvNb7emSaV
         6aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782293361; x=1782898161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ4YDevUIo1udhjLYGex7mGuWUU0PrMDtr2MU5bE7Qo=;
        b=maQHfsvktXPqD1xMoTz5Qe+chBYsiOvmzKX5HIsnh5/YWTEx+SLmpOWHBIlKscKeqD
         oLbMSlxsDdi48pUh4Uic200SuSJYyXyOWXalMH+eNkxq92y9vB0IPPa0N2dSiEUB+/5e
         8nsBO7h/6u2IMXEU7/oMDYgG3D9TEvHKIjtH9cvJnK2mZoMUtWYc4gUwbQlqORBsRYZg
         YLPzmCcUTiziSpP/H0iyn01fqf5gmHIfqvPlj6Ve8RGPjIEOpgpAp02SVyViqi2YBfMW
         xUTWW4Ik4JOjQoIX9oRAlERzdNDvfvD8uM6JpTItM7dP9mKbtv89C4kMFhWQkGAvjhcS
         3ytw==
X-Forwarded-Encrypted: i=1; AFNElJ8s0k5W6WJRTvdEdW1noPQBZt7FWBq+pEIMnWZWyn0kE3SXB9uCA0NVKXngzb0iNnSh02E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR6cgeH1a8HlUW3rKTK+5xHj1OnFXx2eLUwX0hRBpyHmXft1Q
	mUdKcg1qVNQ6MaUE8jXCJelCkb/Kh48kQpmEolqPy1rmzTyQT4yzCT8HCHgHlg==
X-Gm-Gg: AfdE7cke3+BX0xIpSctl7AvVQzbTXdFSlz5k46OUEKhPkq5zfMksP14rzlj4gVzW94V
	NKuVCncqw1C2KrfbgSJSCzmwDarMRSJaod0UOWVHWyIgV11IzKJcL027scXGBcIb56XCO3g2BAC
	h3nC0tXmvRuoLDqrxbFc1W5S9rzUHaLg8hlRV8KHdCx72mBI4OMd4M+4SYaDiEFoss/J57kopmA
	LZojg6oXBjArD46ZDZxclgd9Cml6bUymPE1oZKrVRUZu42ubLPxVJ7o1Hqx2ovjKm438kmR8lv/
	wz43x/jGu93rY24sB4fga/p7zn7jtMxqx1Fuo+/p9X/wVvrEqs/62K5qjZzpVTnYyfTt3IKbvfY
	2Id6ZsR8UFBQ076qaUlXrbCmGDLnRH7HMYF595apUk2cX5gr1cBBtihIB9a1UD04ypu3mWR6tM1
	xg
X-Received: by 2002:a05:600c:871b:b0:490:9588:bdae with SMTP id 5b1f17b1804b1-4926086d9bfmr34432515e9.18.1782293361163;
        Wed, 24 Jun 2026 02:29:21 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm373966775e9.11.2026.06.24.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:29:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Jun 2026 11:29:19 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCHv2 bpf-next 0/3] bpf: tracing_multi link info support
Message-ID: <ajujb-Fdsf-zTIp7@krava>
References: <20260623142417.275892-1-jolsa@kernel.org>
 <CAEf4BzbLUzTfvf4pVTOCoOM5AdiS1wkbmuK3R3L+fFZLuF7n+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbLUzTfvf4pVTOCoOM5AdiS1wkbmuK3R3L+fFZLuF7n+g@mail.gmail.com>

On Tue, Jun 23, 2026 at 01:51:29PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2026 at 7:24 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > adding link info support for tracing_multi link.
> >
> > Adding the kernel support with related selftests and bpftool support
> > to display the tracing_multi link info, the output looks like:
> >
> >   # bpftool link
> >   ...
> >   27: tracing_multi  prog 93
> >           attach_type trace_fentry_multi  obj_id 1  count 3
> >           btf_id           addr             cookie           func [module]
> >           91984            ffffffff824f4a24 a                bpf_fentry_test1
> >           91986            ffffffff824f6a84 1e               bpf_fentry_test2
> >           91987            ffffffff824f6a94 14               bpf_fentry_test3
> 
> kernel's bpf_tracing_link_show_fdinfo() emits cookie as decimal
> number, why go with hex here?

true, will switch to dec, thanks

jirka

> 
> >           pids test_progs(1462)
> >
> > thanks,
> > jirka
> >
> >
> > v1: https://lore.kernel.org/bpf/20260621204524.61067-1-jolsa@kernel.org/
> >
> > v2 changes:
> > - fix kernel symbol search logic [sashiko]
> > - typo fixes [bots]
> >
> >
> > ---
> > Jiri Olsa (3):
> >       bpf: Add tracing_multi link info support
> >       selftests/bpf: Add tracing_multi link info tests
> >       bpftool: Add tracing_multi link info output
> >
> >  include/uapi/linux/bpf.h                                |   9 +++
> >  kernel/trace/bpf_trace.c                                |  55 +++++++++++++++++
> >  tools/bpf/bpftool/link.c                                | 137 +++++++++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h                          |   9 +++
> >  tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 ++
> >  6 files changed, 458 insertions(+)
