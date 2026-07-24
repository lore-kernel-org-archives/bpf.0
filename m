Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07237189B
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867291; cv=pass; b=X4ma27G8yOdS3cMVfmJSUbB8O/crU/u6g/CRPDUG/JGEGuhDambrZgyUIRlf7ZVNBRKckk9K6jYraXaipOwprBL+fgzKkohe9N3RLvreI+rzK4PODY1+p/XPYWhnhyNHG8YWE9Bd/OK6wPg7GQvYbwyoY/CLQK9gFMnbVDkvnMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867291; c=relaxed/simple;
	bh=hjlFGHq2VYPYfj3lPmOr/26/QmhORDjiRk0e1q6TIzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3a2l8rQxEl1Fo03FHKFsvJYV9MF2+/MR+5THv/Q9qQ1bL9psb3t6UWflCMFrF+AfBoc6oCF+fnYVrKO2SyEDDCJSnA2oDX0jl/utPMqtYD05Le/5XL4oe0YDrWaOpVrlc1fEv2Zy9zxthlOLaYlVuBOUYUVH+DAO0RFyGWI7F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWjtw752; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWjtw752"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2132616a12.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784867288; cv=none;
        d=google.com; s=arc-20260327;
        b=C/IayLarmil6SolE1nVUjOzDc0uWYa0rWMt6Ifvbx3PvqsIV1kAC8HBWNe2O792Ujw
         pMdQ4Za/H+AkQ0XrFrzhORfI39OXGpTJPkm+Jyv8QhbpszEJZOKeQ8TpiB3tMAcvcAA3
         4OPj32Xc1D7UZrZJUZi+Q/11QGKQXSpDbvj2mU+/zR/eKrFQRjlYb5lHUQSaNez5f40O
         CbkRfcsGWoqSttpFgLjB1LpLDvtDvNznQr0suz34WZ12heX4liaydzRrQEkHkHDSDyI2
         PHX/dpT64150e9Z7DLqxFpbc4UKXVR+zV2cuxcsav+8HpTXil8tc5GLtfdmNuVRCseAU
         HQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9+3Kex2RPCKiUUu1M2ayq7cE1n3GCcPXXxPBF2HtgE=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Bvipm2yUhiYHlh16jceC9xG3t6GidCN6P7P0tPk9wk4w1ewKyYTfpxw+dFMDiI+6r1
         wZcC8hvmvzmTfrQRAFoOCazuHliy8cIrrQ7UDgSUHUMX+fOJe4ojgSHxU+Sekj+bKdgY
         4CvUGu/j8W755H4nSAzbmPoyq+6+lMgtU0ni/OXJzF7naV3cjnkWPrnXdVsyyO7+qnT5
         L680dyz5XJsXb4498K5AibmInrn8XLClgxdfgLg5b+8j7cblormZtmQpecK4xpw9lcdF
         JPDuV6UCQC6pFS7NCNo0GUzEZTD2SVcfgDQDJptRKGnW3EEYIgUMFzubPnKLWRm47Y9D
         dynw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784867288; x=1785472088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c9+3Kex2RPCKiUUu1M2ayq7cE1n3GCcPXXxPBF2HtgE=;
        b=GWjtw752/CPZnrUl3E4R4mPH7jCEBXdaQtez4L2bWivZcpG5q5sISKNtNf5/mfe5Wc
         cDEjKSyFF9Hbs7JU0lVqbJk+qOc8kldxU6MHdweNdIZlhJO/DjhSgxaNHfHRKEKFe3SM
         jg++C0DZT+8k+wIO5bQxEIRTpVGHzlNDp9LgspVk8xZEAVkBsnfZnAoW58couMhTTmVX
         S/rTgVdJHH9fhm1JNyu1PdcV2LqzTFbWYhy849qdM7HpqL4ptPBvvzfv8TwCIgCX61rV
         iUAC9dSssdD6PGhjaZ+D+rik6nYrRdfJ63eHiKzd+D5AGFHN6xGXFfRw0EgR1bIRuzT+
         kdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784867288; x=1785472088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9+3Kex2RPCKiUUu1M2ayq7cE1n3GCcPXXxPBF2HtgE=;
        b=k+D/Yat0QPVyvA79z8YZFJANeQp9DN6buwuntDmjSMRBr5vmd9qj4cANssv90P2/v0
         MCjF/4MHqrEg1rmXjleRzjtnvNQglO4c9K/JiWMiYJFQZkthTNlawbvtITduv04vQeOc
         ykxEgJXX/E30GcRCxDWBP7y4TiSsCDwM4tIfzKuAqRlngVNOmnNlKwfxje2mBEt/fOn0
         Z9NJpRgCnavK3DSaww2e5K2+O8ImEPBeiRTxxSka5NW0E+yH7m2qov6NC+DIJBqLutWi
         ybedg9DDvi70SoYU6u5iaMeDYQz5t01nM+578SViliDLrWnK14iVnaDzKARg+TjrfsKN
         +9Og==
X-Gm-Message-State: AOJu0YwcCi9pstC8txDi8XWZFDWEMaiQzRU/o+qRUGb+qnIa9tmDFBON
	B6udL658vnPQlF82/8V/k/84RerRMeer4USeIwDWkLlkDrwSc4fyWj32D4NfTnw/vUnPUJmRiJI
	uHq2PMLpHcHmV/QhbLFCvngIeCAnjyg4e9T13BXU=
X-Gm-Gg: AR+sD12oNIOVhMOBnp+m8vCGsEkfAeIEjkCCb3rOvg8Da4wKIQkt7U5mzv18jIFtdoi
	vSI48E62+Q0EqgqQKmXND3jUsor7LISfieWVjU3Csk+T4no0gcTksRhdfcdzRRABcc1dNLEUwlQ
	YuHnJjrnDZ2/FrBJc9rVcvTRPdFaV3AijwTCVetkica9dpZePZ2/n7R19TzpI3s6PS3eJdohIvC
	IyGjgxW70HBDTgHUWPJ0Dq+IRu2mnxhu6opjnA4qQNvaMF5j3aGua39mFXqXjdaSZwk0ZnO9g9a
	oAqY2gRhhDUCcZa+4qMP/7ekB2WNhQ==
X-Received: by 2002:a17:907:971f:b0:c16:589d:c965 with SMTP id
 a640c23a62f3a-c1c5096678dmr277726866b.46.1784867287874; Thu, 23 Jul 2026
 21:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721194111.334795-1-nickolay.lysenko@gmail.com>
 <20260721194111.334795-3-nickolay.lysenko@gmail.com> <20260721195216.712FC1F00A3A@smtp.kernel.org>
In-Reply-To: <20260721195216.712FC1F00A3A@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Thu, 23 Jul 2026 21:27:55 -0700
X-Gm-Features: AUfX_mzXoE2FJPFlVSc0CQI2QYirmr_NCdU04ciEYdOBL58QDaLwTEjGBLAhwxk
Message-ID: <CAMtxOX3VgWQPzi9FPZxarbOjsMvHAXM6vVYnyfpg1BN6dg2Srg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/3] selftests/bpf: move shared build
 definitions into Makefile.buildvars
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

addressed in https://lore.kernel.org/bpf/20260724042600.175440-1-nickolay.l=
ysenko@gmail.com/

On Tue, Jul 21, 2026 at 12:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The variables TEST_KMODS and BPF_GCC are duplicated in both Ma=
kefile and Makefile.buildvars, creating a brittle maintenance hazard.
> --
>
> --- Patch [2]: [RFC PATCH bpf-next v2 2/3] selftests/bpf: move shared bui=
ld definitions into Makefile.buildvars ---
> commit 609eb873658507425701a592c055f112cedbb6b8
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
>
> selftests/bpf: move shared build definitions into Makefile.buildvars
>
> This commit moves toolchain, path, flag, and probe definitions from the m=
ain
> Makefile into a new Makefile.buildvars file. This allows these definition=
s
> to be included by multiple makefiles for running test instances in sub-ma=
kes.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 09e5be201afb5..2ddcb812dc85c 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> [ ... ]
> > +# These probes gate the flavor list, which must be final before lib.mk=
 is
> > +# included; keep values consistent with Makefile.buildvars.
> > +ifeq ($(origin BPF_GCC),undefined)
> > +BPF_GCC :=3D $(shell command -v bpf-gcc;)
> >  endif
> [ ... ]
> > -TEST_KMODS :=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.=
ko \
> > +TEST_KMODS ?=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.=
ko \
> >       bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
> [ ... ]
> > diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/tes=
ting/selftests/bpf/Makefile.buildvars
> > new file mode 100644
> > index 0000000000000..2a7efe6d1c795
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.buildvars
> [ ... ]
> > +# Immediate (with an override-preserving guard): a plain ?=3D stays
> > +# recursively expanded and would re-run 'command -v' on every expansio=
n.
> > +ifeq ($(origin BPF_GCC),undefined)
> > +BPF_GCC              :=3D $(shell command -v bpf-gcc;)
> > +endif
> [ ... ]
> > +# Kernel test modules; TEST_KMODS=3D on the command line disables them=
.
> > +TEST_KMODS ?=3D bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.=
ko \
> > +     bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
>
> [Severity: Medium]
> Does keeping duplicate definitions of TEST_KMODS and BPF_GCC in both Make=
file
> and Makefile.buildvars create a maintenance hazard?
>
> Since Makefile defines TEST_KMODS with "?=3D" before including
> Makefile.buildvars, if a developer adds a new test module to
> Makefile.buildvars but forgets to update Makefile, the new module won't
> be built because the Makefile definition takes precedence and ignores the
> update.
>
> Could these definitions be consolidated into a single location to prevent
> silent build failures from desynchronized lists?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721194111.33=
4795-1-nickolay.lysenko@gmail.com?part=3D2
