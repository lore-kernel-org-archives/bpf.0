Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B44A3F25
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054651; cv=pass; b=JsO6E1WiaL6E7IinGsutxOHetHzFNo/hVz5yLKN8USC/yjUbsjtGkzzHutpO3+nCqAMIRWE1b+EeHuubdtFlU7TmQDno1R7cIjJoPGmqnthIQxAP46W+XjBoRIvpsY12JfU+DCEX/Tk+T0KP7PxcmAFiBal2lCseA9xD8WqP4Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054651; c=relaxed/simple;
	bh=ynSxNuDkxhKdE/yGw9XYokMd7L14dEwjnifpIUDbrDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj76jiCT7D21CTV5wlQS5Ng/fT2nw+BZylAqstEG2Ca2NXhVd0UhvvzgTnyktG4AsPMDgfhebKmGHCmJoS4FaJaEDEq3LKuymHAlcYVBGgoiJ77lDzzkdkdsyxqsDVOtg4wsB0mM2dzfW2c6dmQxUiIoi1EfOk0eZRI1jiuWgHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wd8vwnNR; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wd8vwnNR"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5307425f44bso265981cf.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789054648; cv=none;
        d=google.com; s=arc-20260327;
        b=BoWUURvB9zQnQ9oOUIYJE7zJOS5w2kwyNtnVPR7/Cp4uoEClKm4LRVe+0WXWL3vN1N
         iXHcNvQVyuiZawBfFoi5Bb1NmKASsBhNaXjSq2xRqS/uivXCoJnYrWvF5wrNSBj5Wd6R
         TjMI4/xX+IG98q9Hb0YNOTWh574bfeyCwymnxfgGbbSM5yIa2WRztP765wSfpTh5CT7J
         UHfjeVpfTr9WR86BuXSFGH4YptdxpOv3yrOGCzCtDhktroaLL2VNRaWgUPeni6pmr2y9
         AZT0pB5WrjK3voR+IzOA+pm8PXYqPHG0I8YZHZYa33xGSua3+4xFwrrVUHNhkSEyLSGB
         0lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2fzJmHe53im+RdRlFHTdcZykU88bTlrtsEb9uv7A3KM=;
        fh=aHVJtDG9ZDsBXX9i4OwhL+2BFAs9XekPs/tI0lnkEfA=;
        b=YvYT9RKEYYtJCf6euXLcvwxHliS+G0pyqdI2plVD+vy9qAMGTIkPODMgEcvIMLuEJE
         Ul9MOR0FU/hGpHWRcP9v+ThWbCbBdEutWsJ0PWvJC+X7wYwvQ6qweU3ZUfUZMGZVUty3
         66dvfW1VRvoUsOFjov3vmEX2+S7/DjwkfP/3HPA4eBQuFR6EsKS8GU91S3amVJoxaqen
         iKnW9eMWPw4ViRA9RKj3BGeRqGtLdoZIvUgfEZXXC01KT48tulOGUL2/9qmPLcMWvMYs
         AM/EY2C2MsuIKPX9teIDPZUTP9YeAxfSTwyAxP105wqcSeKoROzf5oKT7RndfQ8ph+0A
         fg+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054648; x=1789659448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2fzJmHe53im+RdRlFHTdcZykU88bTlrtsEb9uv7A3KM=;
        b=wd8vwnNRXgVHoy9xVoIX50iGQJxor55X1x214F6cv6Zb/Q/yCojNIy4Gn8J+JUJs+i
         l6r9+FoVQpzxjJD404IOrhPh8ClFNuYMakxyuaMSEtiYXhlA1GRDfliYP4raZMb+bIT5
         FeYl+tzvOPCyRohKGWRodf61Ad69RnbUVYyVsBHmo91dTKkvN1sVleiTiEzOZZj/PEK8
         exo7Gzzqhgkv+J2lkuaRCRmKxXL2VbU1zUvjpO3pB8e9eHtMzO3IP7xt2/n2Uvm1OFft
         +o1JxutEq7GJLzi6mkY0CMr7+6qWWVQsfm0c5pTHFxmrp3di7UYD0RsF83f9jZ+scD+O
         bt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054648; x=1789659448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fzJmHe53im+RdRlFHTdcZykU88bTlrtsEb9uv7A3KM=;
        b=IR/cfY6C29hvq1xc0OrEhKz7qWE0SUwb8VE86xqloFhKMXy7So5rxRGGfFCvDHFIDQ
         3NE6NI80xla5bjXVSDDTa+RwRPYw3bfm0cL0zGqwb9jjMotatnk8nodSJHpQ/IHekXa3
         w1m4Iqt2MP9mkbVZoJQkCU0SzCAS/DBCM1XWa5JA2ULVe4GtAzQ7Yc8nWLNz6JnrK8po
         bK8XCYb+Ln754TrYRc6eFLbYLR+xLw6rjYP3cyggsXIIR3q6zizD+j+ch73WNj3of1at
         HCa7bkDihQP2xCwgHfHS4qlsSjzE1zPH+ztvoFQfl6+UuYRG6fTJimjL7h6ZBJQEiWsC
         2Syw==
X-Forwarded-Encrypted: i=1; AKwUvBxm1d8UrpQGbahGVZGwkOjVTfRuifVqjdKOOkih22BdVk6PXX2fWcko5OL4U2Wa68fxcDk=@vger.kernel.org
X-Gm-Message-State: AFuF++nPeZQVKg9ywW3qZE7zKWCAvCO5W+pOdIx/YQnuq634I2MTgStJ
	KrOVM9e0eNCyElTGxkzqXxUJC26Xgqz1M8zYPIo7K/Rc8F0XYsYd4gBqS+5atAUu1J/N3SW7E9V
	LbBq2zcIUjl/FSPgDlyI7JBGFOuEJ/r6+9z37OyXY
X-Gm-Gg: AYBFou27jg9JNDcI7DV86Ovf3RkqhExStt57uVL43zz2eipaimhR4W72g90UUeZLug3
	rnzjQNF6xp1iN8fHm4iaDIWffwuWiThj4AP680zgavpNV7Pc/GdCmAi1BYC8gskgipgTuqNx5Nj
	YeAUp597yrDDmd2bO0GivpYwqZV+DOjZDuTZeqRIYFPMGH3VCLlalOCqTdMlDoafnWOH1VDtDcI
	cQO/9G9AT4UQMPEAxyQ6RQ4wWVjoGW/AC5vcVcAGsDDeDS18zagcmiBwG/jGXUltekDoMMGbge3
	CARFLBpamvo9nw3IrgrXDxGQKbkA8MZbe3hgQuh4LBzvnPpEyyP3neRGxuagzm/boSjNoKZO+A2
	Jk5AJuBM+gdlYiQ+yTVFs
X-Received: by 2002:ac8:5711:0:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-530b48fee7bmr20271511cf.8.1789054646975; Thu, 10 Sep 2026
 08:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909204122.1993010-1-irogers@google.com> <20260909204122.1993010-4-irogers@google.com>
 <36a64b34-bb69-4352-9e84-c31d0793b6a4@kernel.org>
In-Reply-To: <36a64b34-bb69-4352-9e84-c31d0793b6a4@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 10 Sep 2026 08:37:15 -0700
X-Gm-Features: AcwNN1VPdFbSJ00CKGszV1vwicAKF7OS9Ew-KRRognhOG4ktLaQZIRP5UUupJ2I
Message-ID: <CAP-5=fUC+2+qafs=GjfC6K5X1o8t8BTxj8L7NuGAm40n_UTYWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] bpftool: Add explicitly sequenced -lzstd to libbfd
 feature fallback
To: Quentin Monnet <qmo@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 2:20=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> On 09/09/2026 21:41, Ian Rogers wrote:
> > Distributions like Fedora currently ship a statically compiled binutils
> > libbfd that natively depends on zstd to decompress sections (e.g.
> > undefined reference to 'ZSTD_decompress').
> >
> > Extend the newly supplemented libbfd-liberty-z-zstd feature probe into
> > bpftool's Makefile so it can natively build against static binutils
> > distributions.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Assisted-by: Antigravity:gemini-3.1-pro
> > ---
> >  tools/bpf/bpftool/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index b0f7168e7943..1cac4508eb0c 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -125,6 +125,7 @@ FEATURE_TESTS +=3D libcap
> >  FEATURE_TESTS +=3D libbfd
> >  FEATURE_TESTS +=3D libbfd-liberty
> >  FEATURE_TESTS +=3D libbfd-liberty-z
> > +FEATURE_TESTS +=3D libbfd-liberty-z-zstd
> >  FEATURE_TESTS +=3D disassembler-four-args
> >  FEATURE_TESTS +=3D disassembler-init-styled
> >  FEATURE_TESTS +=3D libelf-zstd
> > @@ -135,6 +136,7 @@ FEATURE_DISPLAY +=3D libcap
> >  FEATURE_DISPLAY +=3D libbfd
> >  FEATURE_DISPLAY +=3D libbfd-liberty
> >  FEATURE_DISPLAY +=3D libbfd-liberty-z
> > +FEATURE_DISPLAY +=3D libbfd-liberty-z-zstd
> >  endif
> >
> >  check_feat :=3D 1
> > @@ -201,6 +203,8 @@ else
> >      LIBS +=3D -lbfd -ldl -lopcodes -liberty
> >    else ifeq ($(feature-libbfd-liberty-z),1)
> >      LIBS +=3D -lbfd -ldl -lopcodes -liberty -lz
> > +  else ifeq ($(feature-libbfd-liberty-z-zstd),1)
> > +    LIBS +=3D -lbfd -ldl -lopcodes -liberty -lz -lzstd
> >    endif
> >
> >    # If one of the above feature combinations is set, we support libbfd
>
>
> Hi Ian, thanks for this!
>
> Just checking: my understanding is that if libbfd depends on libzstd,
> then it always also depends on zlib, so we never need to check some
> variant such as "feature-libbfd-liberty-zstd" (without the "-z"), is
> this correct?

Hi,

You make a good point. Normally we want to use pkg-config to get the
libraries necessary for a dependency. Unfortunately pkg-config is
generally broken around binutils/libbfd. This is why we have all of
these tests to determine the list of libraries we need to link with
libbfd for things to work, which pkg-config normally provides. It is
perfectly possible to build libbfd with libzstd and without libz, but
currently, we haven't encountered a distribution doing this. I can
imagine a memory hardened future where libz has become zlib-rs that
conveniently provides C headers.

For perf we don't build with binutils by default; this matter is only
an issue for our build tests. We don't depend on libbfd because its
GPLv3+ license isn't compatible with perf's GPLv2 license, which would
create an undistributable binary. This isn't an issue for bpftool
because its BSD 2-clause license is compatible with libbfd. In perf
we've been replacing libbfd based functionality with that in elfutils.
libLLVM is another consideration, but it's generally too heavyweight
for the effort to be worthwhile (it is generally large, distributions
don't want a dependency on it, and it runs many initialization hooks
at startup that don't benefit perf). Hopefully elfutils can provide a
stable API for its disassembler (libasm) as that would cover pretty
much everything perf needs without requiring us to fork objdump, use
libcapstone or use libLLVM.

Anyway, we could add another flavor (zstd without libz) to the feature
tests for libbfd but since this isn't currently an issue I think we
can cross our fingers for binutils to fix pkg-config or for other
tools in the kernel, like perf, to migrate away from the use of
libbfd. If we add every flavor of libbfd's dependencies, it feels like
a lot of build clutter (imo) and I don't know where we stop.

Thanks,
Ian

> Quentin
