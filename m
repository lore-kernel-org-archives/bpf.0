Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41C2FDC3C
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134643; cv=pass; b=alNnandMomy1skTHiH87aULtK12WT1zXcGTDzcGlcu+TbV5sl4uYm6riulDIwXwbpk7OKZZsQ8P/Fr65MAg7JzoTbIXrx9YPC43lZGnJAL3cEETlUZISpSEDul9RM+fci3ZpQV64WK0iYeAYlcTEwpnSvO6zzHc2Yt1KEUTsLxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134643; c=relaxed/simple;
	bh=DKhBnYuFq7B+Ka2fMjz8uQe4g1obMrfJOQUL6QN6XG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5L9hTowRgRvAASyovDzcr1ItDwGB1sEG8/6sf/ys1YDXDe+O0P2U3OC7Xy3vojeQAdzrlkHzv5kBRj/68OBPe9/y6U8cFuwtL0k29IlttKokZaAKKulAKuDm2RAzVGw+Si2rd+HE5ZhygT8Ndc2ZraJNFZgLjFak/iSzbTawVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYfgPIas; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYfgPIas"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aeab6ff148so80285ad.1
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 16:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774134641; cv=none;
        d=google.com; s=arc-20240605;
        b=EemabU0Fu8Q+oKXuWevRTUVTnzImZm4wrBN0ju1A1+Rqy2HSHWTqqntWeDij8BRM4s
         HmxMPKz00+JgBI4WVViokzGimjQIIRkwZGsLKcgXtSQMqRsDXKo5SgCVN0yEcgcQRxx9
         qOse4gJN5ngYs9fRJSp54QST9Z5WjtnvGlhjkF5A7C6Dxkb6JzFHCvWHb4FPhKka8yMf
         7bx6IH06kdyPRe07Ab6Piore1xwFeMC/hUqAna0td4Mo0hhulgrHRyiXDKxmXgv0CvsS
         s5cQKoN1Mg6IenMUADWkpgPlF7KvNh8OtuYLNXR7g8l8deIS2v5vKlyLjg4i4VXjYDWc
         JVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gskRpbF7e3HZE20lexLZJJLsX9C51g5JYA8B2ClPVts=;
        fh=u54d2bQEeF+IWdM1aGLp9OmQkSkRFKQ6vR+0iR+JGjc=;
        b=TQh3N1XFe2Dt5cXe1kGaP/k0JCM9tjYbMaymUmrrRissGGvhsR1XRa6uf+NXRwNLRr
         vxcN3xjYq05fdrbY696J63Mi+VDDHnVYDnQu9mOxNSsyAVk/EWZxBb3tW7IEyUtVgTDs
         3WmjKtNeU+UUyvBNj9Epch+qDG2gSfew4skT9fBKMWNII+Lo698Xm44DhtYFEn7iuZGx
         gwr5q8Q4Ln7+1RsEaYpRDW8OwqQCObgb5Bcp0ZKp/1tJGeeRep/woF4duQKl8OMI/8FB
         fRAaDgvR+Gjbqt3uPJnaim4KTsMSaRwhARL2AlW50eQwknJmkfQwcB9NiLmQveFPlPO7
         e/cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774134641; x=1774739441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gskRpbF7e3HZE20lexLZJJLsX9C51g5JYA8B2ClPVts=;
        b=MYfgPIascI1phgtGwZG98lanVj51czVbubvnoiQ7JpDg5qlcYhw1h7HiTVOSCAt02a
         0CpGwD+AyltGAUB1ycpGwm7KmchyDdC7tFe/oZFO4nOGahVxYQAvcqFLdxjpsU7my/JO
         GmkI+aJTaZhByORflSgYuX7UH9756XF3g+lEadGixKWP7h+APXrx73Dc+mjEdYQcvbtE
         dXjuLJzqAU26dPoFJFVJaolUbMJiX8+8DS1JhvTkbRft05vjn/gPNz4Ib6lY8KibeyoP
         vJCbPLuyp3nay+iGoZ6eLZ0C8pAT+yxWwxWS4AcZPIBWJm56FniCb4GEBWEfw/OFnaJD
         zySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134641; x=1774739441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gskRpbF7e3HZE20lexLZJJLsX9C51g5JYA8B2ClPVts=;
        b=qRQX02hpulfDw+4arhz27o6hzhBgeIdRsZJhHCqSZdjtf/XIe2tT7S5J1FdF6Do+rX
         FRLB1HiqSIgysz5AwTtWieSnc8dpU8Ugr4uKfX0mecXntWEf5JqrT3opf5y3liKhz8Xj
         N59zgRqKiQSSqa7d4A6R7+fU1MLQCie3LF0YNF4DS3PPDUHVSaxAFyPtMG0pMwekHEhY
         WxB/2N94iN3pynQY1W9cYmd1BhM2QnLqtE8UphOAUDFbz0VsHxQz6+U1ij3ctJyH8Gyx
         tRmjzameX7XueZ2cSev/6zucl1HQkQzJ5KBMf44kgmyn6WB/mh1sVEciCDJWV7h82b45
         EyCA==
X-Forwarded-Encrypted: i=1; AJvYcCV/uPoar6xHN3EPpYG9IX56+YJaIuf8SG2/JnfArd0sUdYRRuXRbqSQwJxC1q25HnDJKCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcVkxDadlQH9KOU3tIdG6+BCmLfXihiBPixk8+ZyMRsLw85rT
	HddwViN2SqAXu0guERjYgckUFa3qGN0bfUHEO+Pkw+byrs6J6RpWtcUSBFjtdVIoHHa+dLAdd/j
	UHB1Aj/mg64dEDeXrascSEzZtBbk/e+HMH0QhtQ/a
X-Gm-Gg: ATEYQzykb7EEHfmvmdbN487MkpggSs3aq4Mirn+A7pm5W6AG+5JEX2XxbvolV7Wmda7
	lNK1WtMyH0z0rY4YrqiMkKbHvGVWwJFN+78fFw1RZHvKugekQHElN1D/qvhgNeXCqLZBjCzGCHN
	XEDiz0UG9YmEA5XiZKnP2DUrNxc61tgHWN8rtg63CoLdueCu+tSX6YTPzB3vjCOpsG2xphHeD4Q
	dEARRG2B4ULha7ZKbPcVqpCjbl4CyXi/usjY6QN18ERlwlz17745AAbDWh8z17fmRz4SAh2dPW0
	5NGS11Hb
X-Received: by 2002:a17:903:17cc:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2b08c4e8ebbmr1788085ad.15.1774134640638; Sat, 21 Mar 2026
 16:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
 <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com>
 <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com> <CAADnVQJNt0Xmcm0L7u87fX3xFeVGyLnTxUGjPsnYcNSX4Zv5rQ@mail.gmail.com>
In-Reply-To: <CAADnVQJNt0Xmcm0L7u87fX3xFeVGyLnTxUGjPsnYcNSX4Zv5rQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 21 Mar 2026 16:10:29 -0700
X-Gm-Features: AaiRm52CSCEKDzXzsvi00SkOJjBGfxApqGPpCOtGJuq_kvVV8r02qX7BNyoTiF4
Message-ID: <CAP-5=fUsaORbZuCtUxFgzMT-Cn2jVDLYfcYGSkXC7TdtyfnatQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 4:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 21, 2026 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Sat, Mar 21, 2026 at 12:49=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.de=
v> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > > > > The hashmap implementation contained strict aliasing violations=
.
> > > > > > Specifically, the hashmap_cast_ptr(p) macro was casting pointer=
s (such
> > > > > > as void **) to long *, and these were subsequently dereferenced=
 in
> > > > > > functions like hashmap_insert(), hashmap_find(), and hashmap_de=
lete().
> > > > > >
> > > > > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an obj=
ect
> > > > > > through an lvalue of an incompatible type. Dereferencing a long=
 * to
> > > > > > write to a void * object is a violation, even if they share the=
 same
> > > > > > size, as they are not compatible types. This can lead to undefi=
ned
> > > > > > behavior, especially with aggressive compiler optimizations.
> > > > >
> > > > > Potentially this could be a concern. Did you actually find an iss=
ue
> > > > > with it?
> > > > >
> > > > > The linux kernel build has
> > > > >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> > > > >
> > > > > The libbpf does not have this flag. Maybe we should add '-fno-str=
ict-aliasing'
> > > > > for libbpf as well? This way, we can avoid any future potential
> > > > > 'strict aliasing' issues.
> > > > >
> > > > > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > > > > also has '-fno-strict-alaising' flag.
> > > > >
> > > >
> > > > The change itself looks correct to me, fwiw, but as Yonghong said, =
we
> > > > can add -fno-strict-aliasing to CFLAGS and move on. I also doubt th=
e
> > > > compiler can cause issues here, since the usage happens in hashmap.=
c
> > > > which wouldn't be visible in other CUs where the call is made and
> > > > pointers are passed in (unless compilers also do aliasing-based opt=
s
> > > > during LTO). I guess libbpf maintainers can decide what they prefer=
.
> > >
> > > Agree. I don't think compilers can misoptimize things here.
> > > It's safe to ignore this.
> >
> > There's LTO support in the Linux tree for tools/perf with the LTO=3D1
> > option [1]. My experience is that it works best with clang and ldd.
> > libbpf is statically built into perf by default.
> >
> > A sashiko review raised the issue when perf was reverting the addition
> > of -fno-strict-aliasing, the sashiko review is posted to LKML here:
> > https://lore.kernel.org/lkml/CAP-5=3DfVro6E6fowmmJ7gmKX-5SN8bFU7-5KJk_w=
FG-bQuVnMHw@mail.gmail.com/
> >
> > -fno-strict-aliasing was added because some crypto code (copied from
> > the kernel) requires it for get/put_unaligned. The fix was to use
> > memcpy in the unaligned functions, which they now do [2].
> >
> > I'd prefer not to hamstring the compiler with -fno-strict-aliasing, we
> > have sanitizers that can capture aliasing issues.
>
> We're not going to hack libbpf source or add -fno-strict-aliasing
> to Makefile because gemini found a "bug".

No worries, I think the best approach is to fork the hashmap copy in
tools/perf/util and apply the fixes there.

Thanks for being as useful as ever,
Ian
