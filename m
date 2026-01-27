Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065C311C1D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542458; cv=pass; b=ovGiriT4vRWtclONVepko8rmWcahdqq8ehOq8E4bIlwRlRZ+8IbSVL/VJd/80avKyhL86hCthLBjpkU4C71KbYEZWrAmO16HD9uD+VNUc0fxA9ylHV0h03eegvBQ+PSNqXUt5A0WZ+yOhPDo6yA6qTZ9EBpWN6Nm6yF2oOjHSHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542458; c=relaxed/simple;
	bh=zdcyGx+PcCniJuAuyXsgthrfxQ3sgFQZK+eF/Mocblg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xd5Fx6HzmGuF7C8kVGas+K061IEC5W8W4VhTVIvyzXV4jP06+WpqFxMbaWCOFXiDe4ann4wmpoXyQrD1tw0lTldIkta+985k4gLBWtV1L6Ho3DqerP38y3Vttg+t/cmM/yqyglvyhtTalLRYmhCIth8vAC+V6KeMaSCsf9J+xS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR1WIMaO; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR1WIMaO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a2ea96930cso38103425ad.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:34:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769542457; cv=none;
        d=google.com; s=arc-20240605;
        b=Ke+8bX87AjufGWFLwzTD1KV2g0RudZ1yp3mB/EGl1NcwKAu3YE1iEzVRHyuLVLs6xW
         dH9bgS7Ti1cVrIZh3MqpHFzcX9phLDmzPsdd8eAZi5ZgZ1Y30webQEk1xIb7ZQoPepTm
         YYx8KGRL1kAu4PuxuNH2blheZWpmfj41KRzaSJX69fMs9zRD2TD2RV94mvHUZ39n7ogR
         edQz08u965RCjxrKSfphs1PkgrJpNKGu9f+OO7yh5UW0w64J7MJLOWw902/YSuXJeudq
         X2E7JNICSM8GFUEv1O+7yIK8hBqn6gTxjeyPI6DcwIms413kXXlkwlBOQYJ5aOg34IfX
         d3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UKOseiznsTrZqeJbis69qVcn3O87zlhWxNMY1ap4lBQ=;
        fh=afqtdvjCksjM+sFbTjIqgTNP6PY46hPOoOpghAXPXCQ=;
        b=CJ1HvUvdWrHkuH0VaeIwTBbK0NIH/OPiscY/tPjWhwBS8NUwGfU9umUgV+cBvOHmfL
         1IvkSTVWyLgT5i2Zh3sFXPevIjNwA0UPwbh/Hnhsb3Q5OLLQtDcjtaQMz5lC6YbqmI2T
         1tsbt7vH7svKnRby/1HMPZJL5JcHlvlzoH9w/g7yIoclMGtEadOMfu2O9mmR7/U9p71m
         Gsd1jMARvWrnbJJnjhhNHgzMz5i+I+1W6dNihiPaU0e0kd/XBIlkZBbu9Knd2oNfuBra
         eqtGT/A+ZovUnVB1mkXxBgcMKKaPmM2DdMk0mN4RtvVGtZYmPMZgaj4hZOufczxplpP2
         ddzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542457; x=1770147257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKOseiznsTrZqeJbis69qVcn3O87zlhWxNMY1ap4lBQ=;
        b=CR1WIMaOP32QnfGj03g743WO7NmDqYImNraMUM470Vu5JdP38HN+jgQi/6zKFAj5Wk
         2TvxcLoIswZGa00O3vtIKVPr3wzBFPwvbTItTs/bn1oDCJ14OnxiVrsxD1W9KbaTpHTc
         Ryfc2ng2XCq1Vyz2jbcnJuUfoFtUjg0paRpDzlzvAGzW99SwiMjocIFqDdEmvLt547rP
         pRnGNGiJiWKczMDDe38yHUX/FssEmQ+VLlwsl8XDnorg6G1bBxqr4kOzuuzzhKUsQx+7
         9fkPCqn3yxsSsco0cfwyMOLRB5PqKi/+TxevHLoPu6xx4KLfVEeNpRS6aW0TgvEljFHr
         PngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542457; x=1770147257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UKOseiznsTrZqeJbis69qVcn3O87zlhWxNMY1ap4lBQ=;
        b=jv/FG3p4aM1sskXFZM+F1dNzMmrlDvSdgZvXwH3TjNRerV3Tn5Q3uujgK7RJmIL0hS
         om08p3sYXd4lQn1nTpNTOatX+Q3JWBi3rJbImyN9YGUlLjm29jW/URH2IrC/5qdzrO+k
         29cMKk0C9S1wYETjQhovfva1bKAYu80FE9w6+lTXTSXyUugSCSmvGCyvYR8ODwLqxPjd
         jiinCy/jnwH4kkJb9FhNRdXgMcu99/qRDgkcsTaG2pIbm/AAaj0br4uE6sEo7FCT0Bcu
         mpEflUmAHHDxKMP4zHa4jYjascBi0JeOc0pnUzTOlx1Cz2ojy3BQ9tbDgm8GTCKWu2rq
         uomg==
X-Gm-Message-State: AOJu0Yyi6nK5943/1e4HZe/H4P6wyfE6/vGKRJs9kFr6GzrRpPWx0Gud
	hAObwhOQBBNSJkLIv9vhbBm5DvrApcCp6Tq0stTJ10MPYWL2mtbJfY86rtYUWfVVcLaFqkmkadG
	i9tOWkQGEDaEw/vh8Pg+wOgf/KI9eqlI=
X-Gm-Gg: AZuq6aIkV+6GdcOEYKiVOet87GQD7NxcrbFQQ2P3bSa4ZIIIr+YHCSjsIzreN4WCq61
	8+XhFeLX0gnp8atSE/EHZcsm8PCmELpIk/bitV5OPYfN/seW9kDWH9SeIGM+CPxFHSmzS0GvFAT
	8Fp/YPLhUBo0alL4Ch4HOkiFkmiZXQjuLMRM2VdazpMXMqoD2UdCDJBWkZ2y3+v7fu0dY2Qbt08
	GEg3yMf+iSCjmeak3O6JQq1ev6HXXw0huzW4C6kFnBzkxHOi7FpbKvlUw4oCkh9c6Y4rlUUwsPr
	Wd1esGbUwqo=
X-Received: by 2002:a17:903:1249:b0:299:e215:f62d with SMTP id
 d9443c01a7336-2a870d57808mr25389795ad.5.1769542456703; Tue, 27 Jan 2026
 11:34:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127163408.1991583-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY48PKYcUU9sQ+g9CXd69Xuf1Js6Ow0TtTSt8m9SC353Q@mail.gmail.com> <58e46dfe-b17a-4683-a7cf-a0b20236ad62@gmail.com>
In-Reply-To: <58e46dfe-b17a-4683-a7cf-a0b20236ad62@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 11:34:04 -0800
X-Gm-Features: AZwV_QihE17hTAzlPRpDQmgYh4ryp7rNn8r0Yp5MgWNyLrhUA-mwoF68mktpuXc
Message-ID: <CAEf4BzZgkSA1BX0Fjr=1dr28wJZ1t+iNLaXQJTjYjTg3H057JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add hexdump fallback when xxd
 is unavailable
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	kpsingh@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 11:05=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/27/26 18:53, Andrii Nakryiko wrote:
> > On Tue, Jan 27, 2026 at 8:34=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> The verification signature header generation requires converting a
> >> binary certificate to a C array. Previously this only worked with
> >> xxd (part of vim-common package). Add a fallback using
> >> hexdump (available on most Unix systems) to generate equivalent C arra=
y
> >> output when xxd is not found. The XXD variable is auto-detected at
> >> Makefile parse time.
> > why not always use hexdump then?
> I thought about that, not sure, it looks like xxd creates dump in a
> certain format,
> I did my best to replicate it with the hexdump, but not sure how
> reliable this is.
> I think most of the users going to have xxd anyways, so I'm trying to
> make this less
> risky.

but now we will have two different ways to generate the same snippet
of C code. If your hexdump-based thing works right now, I don't see
why it should suddenly stop breaking. Let's converge on one more
generic way of doing this.

pw-bot: cr


> >
> >> Fixes: b720903e2b14d ("selftests/bpf: Enable signature verification fo=
r some lskel tests")
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/testing/selftests/bpf/Makefile | 13 ++++++++++++-
> >>   1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/self=
tests/bpf/Makefile
> >> index 9488d076c740..820816257590 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -31,6 +31,7 @@ SAN_CFLAGS    ?=3D
> >>   SAN_LDFLAGS    ?=3D $(SAN_CFLAGS)
> >>   RELEASE                ?=3D
> >>   OPT_FLAGS      ?=3D $(if $(RELEASE),-O2,-O0)
> >> +XXD            ?=3D $(shell command -v xxd;)
> >>
> >>   LIBELF_CFLAGS  :=3D $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/nul=
l)
> >>   LIBELF_LIBS    :=3D $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null =
|| echo -lelf)
> >> @@ -722,9 +723,19 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG=
_SETUP)
> >>          $(Q)mkdir -p $(BUILD_DIR)
> >>          $(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
> >>
> >> +ifneq ($(XXD),)
> >>   $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
> >>          $(Q)ln -fs $< test_progs_verification_cert && \
> >> -       xxd -i test_progs_verification_cert > $@
> >> +       $(XXD) -i test_progs_verification_cert > $@
> >> +else
> >> +# Fallback when xxd is not available: use hexdump to generate C array
> >> +$(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
> >> +       $(Q)ln -fs $< test_progs_verification_cert && \
> >> +       (echo "unsigned char test_progs_verification_cert[] =3D {"; \
> >> +        hexdump -v -e '12/1 "  0x%02x," "\n"' test_progs_verification=
_cert | sed 's/0x  ,//g; $$s/,$$//'; \
> >> +        echo "};"; \
> >> +        echo "unsigned int test_progs_verification_cert_len =3D $$(wc=
 -c < test_progs_verification_cert);") > $@
> >> +endif
> >>
> >>   # Define test_progs test runner.
> >>   TRUNNER_TESTS_DIR :=3D prog_tests
> >> --
> >> 2.52.0
> >>
>
