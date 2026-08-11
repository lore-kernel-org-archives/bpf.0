Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C5321F5E
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786476545; cv=none; b=aXquIuXoM6VybrJoAzCa0FRXvoXQaYtjvsSt/ZctMCse8VaJAzTa+I8tHaEEf2QDMyNxMjSQNHROMtGupsMn60VcDSnI8PPgi9WYiiZQmZjAgVreotrMXsVf4+7PvX9DtfOpsmFVQmDcyM/QZz+y073NS9dOMKiWw2UCeCa1HTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786476545; c=relaxed/simple;
	bh=7uQjLzyt1JFa+9FQc3OiPCK6zevg0GeA+kYrZsOZMfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knuehCYz6xtJtO7G306X537K/EoukaMKQp1oCSWfTPGEBcfx0WxDe27GIPLASY2Qk7el/0XnIyVg5yDyku8zGSp+fFIO4kpVLfGxw12EsElQ6nJlVEVmZOuZrCb4isedrM+9pJr3KcqXn+QriqtCBSUZoSeIq0dup50NBJGMkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7C8MUiR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7C8MUiR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso74000a91.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786476543; x=1787081343; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ww3neGLRbNdGLG05thKU1/9bQZ/Qlg6r9EY9y0og2QE=;
        b=E7C8MUiRJ75EjEuDc2J/jjcxHYNw5amvR3YvszomccgNB6Ghr1w3WofId/X1f9krFi
         LljtXvUcsbXE1bHuA4W3XtrXD3IpmoOYbnPISGeGTZQjiftnmRVmyL8shDjTH1NaKkTR
         4MnAxcEvu0UPnKln6H0UBkbPmYR7UyMQzi5UN/B82Wv+9HY3NEFD/ahTqvMtuPgWIsWF
         wym2Kbr2DWcAUsTgfR1p2wpQUfPZCo219NKiY25esvJ2G/ytab/AbzrCGiBnaLMuoI7O
         eb5nVXuT3SwvE8J9l8KAPT5Z2/Yzne7BIpFPLRT5bdug+i3Np9EApi4obVFyVDAvTx7b
         ZEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476543; x=1787081343;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ww3neGLRbNdGLG05thKU1/9bQZ/Qlg6r9EY9y0og2QE=;
        b=ApLTEZbBw+PA7tiWTHga+/RUOt2P68QUkNeWC2U8ggZDPPTZL9hlx8E/jj+sZK/4Kf
         exqM0DUXzwHBSQqdVN/wReWmuNzh9+cLd6Rqkm8f5eFUwpNjkQqKVnKbvsTYnVXmIuWN
         fhYH/3kXBofwaMntPSmjwCtWhiH/PEZezAwED+HV+XontxVIYkMFaTrxT3anazEmNBQ5
         hbYcKuNEBqxwMoOHAHMsLKbxJZpu94z/3fvp3+omkwhyRjEuxuRwed0iQGtLkRG6oWDD
         eIZJgP4db7/XwlTYdhZ1+1lPIix3QrXis8RMYIz+ZVn2KgbvspQRTc0GSACQTdz0xEz+
         mYwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqA8GaFnIqlkA92LHm3vfkvNVHR4Voa6/13Fz0WxRsSSwwxGDojIR92fgTpESElztjNWxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxinPI4eR3UMV76wodzkjsM69Uh0YPwBQerx8BenUPtfPNtdJcC
	y/Y28UxmfUOVH9+g1GQi2yyeJF5HWMUUIM4oZ9Yl/DkGZXroo+lzQRro
X-Gm-Gg: AR+sD13ZJccqxNNt/XBrzKuQpDInDrO6KZNjkgPdFofJR+ZyAe+GCGzoAtF+7eWGXGS
	NgQRsTFB+SlO9tgUp6IMe7Nvd1Gx+UqhlceioTA068udSbAmQbsaDWuXaCqqSJ45VlUbR2Xqs5Y
	QU6S8/K7UhYmpZ/oWspGNKkBU8can0PGTfFHHo706Ei9S/0G32Nx0oRIf3jfBd6GUtPzwzcBrPQ
	0O8wS1DMKboxFewmH12SY9c7zPcOMz+Rj0vnG2rhiXWYZWlxCPJhaERJECMOowpq9k5DqZ2Gxlm
	BwIWBKP6h5vdC+576Mipq0xw66bTcOurVBkE3GAycEoAnK9N7a4zv5W04ar1Vi6eTdpcXr0+b73
	k1vP3kXpotXYZpp5gT9HwZ4WO4xkrKlugEbSRxjLpMlaApU9uDKi94FTSvoxCptHUjxue1Zo2FM
	0SVoZQUxKhCXa09xG1T2WSAfr09e6DATo+C8Mb8Vb1E7ts+UMKkTnvv9naKImuHz+I1Y5th/rpr
	R4yUtYt9RtR5jyFh0NaNcj7ue6DhC89kFvQszBr5Vyx2w==
X-Received: by 2002:a17:90b:5706:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-392f47eef9dmr2648095a91.12.1786476542818;
        Tue, 11 Aug 2026 12:29:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124583ad0sm1827116c88.12.2026.08.11.12.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:29:02 -0700 (PDT)
Message-ID: <60b9145e6bfcc75d7da7cfdc4d661a61cdca0df0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: exercise veristat filtering
 logic in a selftest
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 12:29:00 -0700
In-Reply-To: <f600f7fa9410958a73e65c5d9ab1c069b404368473adfa99d38f08cca8bf955a@mail.kernel.org>
References: <20260811-veristat-filter-fix-v1-2-b5b43c431550@gmail.com>
	 <f600f7fa9410958a73e65c5d9ab1c069b404368473adfa99d38f08cca8bf955a@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-11 at 18:56 +0000, bot+bpf-ci@kernel.org wrote:
> > Test cases for veristat file/prog name filtering logic.
> > Check various formulations for any (*foo*), file (*foo*/),
> > prog (/*bar*) and file/prog (*foo*/bar) filters, alongside
> > errorneous filters and mixed allow/deny filter expressions.
>=20
> This isn't a bug, but there's a typo: "errorneous" should be "erroneous".

Oops

> Also, is the prog filter form meant to be "/bar" rather than "/*bar*" to
> match the cases in the table?

Nope, *bar* is fine.

>=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/t=
ools/testing/selftests/bpf/prog_tests/test_veristat.c
> > index 9aff08ac55c0..e1eda4ae755e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> > @@ -37,6 +37,13 @@ static struct fixture *init_fixture(void)
> > =C2=A0	return fix;
> > =C2=A0}
> >=20
> > +static void read_output(struct fixture *fix)
> > +{
> > +	ssize_t len =3D pread(fix->fd, fix->output, fix->sz - 1, 0);
> > +
> > +	fix->output[len < 0 ? 0 : len] =3D 0;
> > +}
> > +
>=20
> This isn't a bug, but since read_output() also terminates the buffer, wou=
ld
> it make sense to switch the existing read()/pread() call sites in this fi=
le
> over to it as well? The new helper is safer than the bare reads used in t=
he
> other subtests.

Makes sense.

> > +/*
> > + * Name filter tests below run veristat on veristat_foo.bpf.o and
> > + * veristat_bar.bpf.o, both defining programs 'foo', 'bar' and 'buz'.
> > + * Every entry describes a single (filters, file, prog) combination an=
d
> > + * tells whether that program is expected in the veristat output:
> > + * 'true' if it is, 'false' if it is not and -1 if veristat is expecte=
d
> > + * to reject the filter.
> > + */
> > +#define FILTER_OBJS "veristat_foo.bpf.o veristat_bar.bpf.o"
> > +
> > +static const struct name_filter_case {
> > +	const char *filters;
> > +	const char *file;
> > +	const char *prog;
> > +	int included;
> > +} name_filter_cases[] =3D {
> > +	/* no filters, every program is processed */
> > +	{ "",			"foo", "foo", true  },
> > +	{ "",			"foo", "bar", true  },
> > +	{ "",			"foo", "buz", true  },
> > +	{ "",			"bar", "foo", true  },
> > +	{ "",			"bar", "bar", true  },
> > +	{ "",			"bar", "buz", true  },
> > +	/* deny filters */
> > +	{ "-f '!*foo*'",	"foo", "bar", false },
> > +	{ "-f '!*foo*'",	"bar", "foo", false },
>=20
> A subsystem pattern flags this as potentially concerning: the table rows =
for
> '-f !*foo*' both assert 'false' (row should be absent), but there is no r=
ow
> that asserts 'true' (row should be present) for the same filter. Every ot=
her
> filter with 'false' rows also has a 'true' row for the same filter string=
.

Makes sense to add.

> For example:
> =C2=A0=C2=A0'!*foo*/bar' has (foo,buz)/(bar,bar) true
> =C2=A0=C2=A0'!*foo*/' has (bar,bar) true
> =C2=A0=C2=A0'!/bar' has (foo,foo) true
> =C2=A0=C2=A0'*foo*/bar' has (foo,bar) true
>=20
> Adding one positive row for '-f !*foo*', such as { "-f '!*foo*'", "bar",
> "bar", true }, would make this filter's coverage consistent with the rest
> of the table. A regression that made the any-glob deny form reject everyt=
hing
> would still satisfy both existing rows plus ASSERT_OK(err), because absen=
ce
> of a row is all that is checked.
>=20
> The expectations themselves are correct (they match veristat's implementa=
tion
> and the changelog table of the preceding fix commit), so this is a
> test-completeness observation rather than a functional bug.
>=20
> [ ... ]
>=20
> > diff --git a/tools/testing/selftests/bpf/progs/veristat_bar.c b/tools/t=
esting/selftests/bpf/progs/veristat_bar.c
> > new file mode 100644
> > index 000000000000..83d2a2a1dfc9
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/veristat_bar.c
> > @@ -0,0 +1,3 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> > +#include "veristat_foo.c"
>=20
> [ ... ]
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/315217=
42364
