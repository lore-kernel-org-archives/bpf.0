Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822982D63F8
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281534; cv=none; b=mPSuclYir/6+2WR8xWZJrkC8GqJPgS9l14/Y32glm696cepi/8d+0SZdhOieCxapnqrDrti1zuCENXTMm3tEUH/ZEVk20FPeMBsgf7BxbRtPNJ5egfmpxsQeGFAIIhtusbVoP/qUXXq6MfzuW0/zU7uU20P/ipjOGXv9rjjPqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281534; c=relaxed/simple;
	bh=STr3ytdwHXCKXbD/oqlkTHF4bjtfg6nYMJTiZzXVZrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGT7F8Z4PD55zfAaVgHNaaD01KEd8OKdtwKSToq8gZYt5trPYkWGrxO0J2CZSagZ9G3A5hU+TqMG3R6LxDGYjL8Uh6hGoyu9a7ccoFZKbHA0BKiOLhJk84U0+Yza0w+SXNGn2uwPNUnX9yloesuabwvtMfVKLjvD3kbV4a4qMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q31zCt1c; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q31zCt1c"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2dee127b3c5so1335640eec.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281532; x=1776886332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQDjnxsRJ1VgLaxh3r+cVvaXvxLdFW+s3hShCjWRoJY=;
        b=q31zCt1cKPavHndfh+IedwbHmmQVsqtfUFbdD9wwv4OLo4fxEvZ8JrWYmlhP7hgVK6
         z/AyeByyyZNqW0m18SvmNZuv3CW4Gcc6ubYvvV/qu2tE2gN56G8GbOSTXjvdWoLV5z1J
         fIJX+1zY0Qtjsvz69qyPgqGFeugQFE+h9c7GCrrGlsq2AJlm7SC3SPVty3VXv8Udng8r
         3U8IhlQ54Qsb40XgG6xfRgDO+N9lqUmDhnV/w4zndwNgNRm0OUH6IgafHTEk2BeUPLLd
         YeuQQ5mjcDE/kZBxWIy4fOJNfbWydb/TpTgAxVm1EyA4zhN77hIOgwxdqe3O6uzMe8PM
         2EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281532; x=1776886332;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQDjnxsRJ1VgLaxh3r+cVvaXvxLdFW+s3hShCjWRoJY=;
        b=nYTYxccARJRXuwQXu8YGRaHAw6GjNvZ7wyJQVoQ4Ti5TLSAgyjfEVGPjkRlrXOZ0qB
         XQy9c6NjR6BubH16s2aRbSAdqPjcybGTUs6Ilu9A9JZXxjPjhZI+ip1fFFYqqk4CQuAN
         iyqODcAAr0p0du2yw/tk16j63EXXo0IxWEHuFRfCFFai097ejkeqrZaOUnkQ6aYqR2fR
         tAVCeg17SbIZu5kAptnLSwcnDsANgW+va68wpDgJHK0u38fPoMIh/ReIbYLbFdw6o/6Q
         dyvs6A6AkQMyJgPnYM9tT9HmFuxGi6ePdSFYl3L/YlhtmR/SqP8+/vHx8rfrOK34JFbq
         Uf9w==
X-Gm-Message-State: AOJu0YwbO38LTrXbrgS/zI4ItesmgxCWrX1IJmMRGqzoJq7yxXGrh8/m
	XGTrjr6M0FerMxMnhsBGbLBF3JTPXKg8FNjBQWxXmZtetnE6bbJe1dxL
X-Gm-Gg: AeBDievbJwwC6VTN1xKoAJERqohZw6DC9gDUHoHJGTZgyRTSbLA0elnsw2aNy9jV3Iy
	GEYzVQOIvGn7HKASlv3SFf6wIyNhSxja9JwLzRUo0M7guAodaS03P7CI9e5+VatdExS656LokiU
	uUh264Sx7sliwzYX/OV4ARyX37xvZS5npSWKmZ+n8aPbolKYJ2OYFC1S8BktK8bk8RDQ2W6zFCI
	hTNaM4VC28Vjhixbt0mGF9tvhfjWJaZKKu8a4kCqDCUmAff6DhbKzmmKzjfOgZvhRJUmhCDNAdc
	IYil/7DWWK3weXkKdBrvnrxkOWo4camwd9AAZs06c5or00AZH5Iktg2JH+sAqNzaIJlFqEo4bVq
	0rfhBSMV34lQD1KxUbAJuEDwlqKEdJ4Zs4Yo4ZqVf41nQmWQrymo+Adj24RM8vk96EEiRBECsH4
	kuAQ8rMJIVm2Ketn2ShEiZwmUzRhwX9++cE0RlNxLPEAiuQK0uPtODxGogkc8pVJGg8x9/TzmFz
	5zDvQ==
X-Received: by 2002:a05:7301:470e:b0:2d8:1efe:51dc with SMTP id 5a478bee46e88-2d81efe56c0mr6296618eec.6.1776281532185;
        Wed, 15 Apr 2026 12:32:12 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21dc:2944:7f23:f4d7? ([2620:10d:c090:500::cdb0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8fe4ea2bsm4019815eec.31.2026.04.15.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:32:11 -0700 (PDT)
Message-ID: <f6016087c52b0a84cb2cb871cf62674ae1fb472f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: verify kallsyms entries
 for token-loaded subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Wed, 15 Apr 2026 12:32:10 -0700
In-Reply-To: <20260415191738.226BFC19424@smtp.kernel.org>
References: <20260415-subprog-token-fix-v3-2-6fefe1d51646@gmail.com>
	 <20260415191738.226BFC19424@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 19:17 +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Unchecked return values of `sysctl_set()` in `serial_test_toke=
n()` can lead to confusing test failures.
> --
>=20
> commit e7dc629b9f37dc08742ff9bbddeaaf65c1e34956
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> selftests/bpf: verify kallsyms entries for token-loaded subprograms
>=20
> This commit adds a test to verify that both the main XDP program and its
> global subprogram appear in /proc/kallsyms when loaded using a user
> namespace BPF token. It also introduces a sysctl_set utility to configure
> system parameters needed to read kallsyms.
>=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/tes=
ting/selftests/bpf/prog_tests/token.c
> > index b81dde283052e..cf5b94512cff4 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/token.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/token.c
>=20
> [ ... ]
>=20
> > @@ -1194,4 +1252,23 @@ void test_token(void)
> > =20
> >  		subtest_userns(&opts, userns_bpf_token_info);
> >  	}
> > +	if (test__start_subtest("obj_priv_prog_kallsyms")) {
> > +		char perf_paranoid_orig[32] =3D {};
> > +		char kptr_restrict_orig[32] =3D {};
> > +		struct bpffs_opts opts =3D {
> > +			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD),
> > +			.progs =3D bit(BPF_PROG_TYPE_XDP),
> > +			.attachs =3D ~0ULL,
> > +		};
> > +
> > +		sysctl_set("/proc/sys/kernel/perf_event_paranoid", perf_paranoid_ori=
g, "0");
> > +		sysctl_set("/proc/sys/kernel/kptr_restrict", kptr_restrict_orig, "0"=
);
>=20
> Should the return values of these sysctl_set calls be checked?
>=20
> If the test is executed in an environment where these sysctls are read-on=
ly
> or inaccessible (such as inside a container), sysctl_set will silently fa=
il.
>=20
> This would cause load_kallsyms_local to read zeroed addresses because
> kptr_restrict wasn't successfully disabled, resulting in confusing test
> failures later at ASSERT_TRUE instead of catching the setup failure early=
.
>=20
> Would it be better to wrap these with ASSERT_OK?

Makes sense.

> > +
> > +		subtest_userns(&opts, userns_obj_priv_prog_kallsyms);
> > +
> > +		if (perf_paranoid_orig[0])
> > +			sysctl_set("/proc/sys/kernel/perf_event_paranoid", NULL, perf_paran=
oid_orig);
> > +		if (kptr_restrict_orig[0])
> > +			sysctl_set("/proc/sys/kernel/kptr_restrict", NULL, kptr_restrict_or=
ig);
> > +	}
> >  }
