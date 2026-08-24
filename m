Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED052376A10
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596637; cv=none; b=l2JRTS/HWOkLKiwDCMfWPWiHxGmaf55ILrHb5tuRd/BnlkdnGGjRLTNYTNfBk241LoyqCPVAwPesh+iRCQfiM7PnnNB/4J5KbcGJWF/UaE5AzdjguUo81elEIDA8yW8EElVexUv1sNPfOwdQhE6KAD2Mb8yOkeTsFQmYJkTA4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596637; c=relaxed/simple;
	bh=18F52JusIfI5n0mVWubrAuGSoJ32jJt4S906bKcE0oE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pfi2QEK8/Ok5fWqifRZUDvcVEc31heVtdfEGI2BIYDc2IIHFfX9CGlJUTe0873hXs8pGuV4HPsyEamasaB0wSsYBQaPL5Medaatd1Cb7ENmkuUDBAZznrZGgPCgKOk+0+M4cbWLFXWhcCqYS578p05YkkR/RwA9iFe9tGfT1UJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em0TUZvG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em0TUZvG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4191531a91.3
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787596635; x=1788201435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q0QxQ4CXNIoVn+24IcKcIYFbwctD75pXwmCrxYybtUM=;
        b=Em0TUZvGoWk0TlIO64Iehzlb10b+ZgO9OkB9vC0+wSHLxY92fnXfI2j9RZ9+GEXvpa
         jmDVnK/58ZKF0pn94GCiOMUkai9opcfN4tp5o1+LC502MDHfmfileks0FRBgNEqbKHaT
         FW84Lrhq8Dv9QVzwfch9xAO2A1189BZ++cBrHkUeNf3oUZalqpz7vIb/7XeFdI6al3zW
         L9OxsRPXdgF+qjbQ7JxSQop1mRGn5RuAGj0VDJCj7HtinSFFmQgJXNWjK6uo7v6jA5S1
         XuWDpjhW1QWkZlXA1x+139h9+azwprL7XNh4EoPB5j4flcocf04aICTDoCZfRUizFMtW
         e2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596635; x=1788201435;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0QxQ4CXNIoVn+24IcKcIYFbwctD75pXwmCrxYybtUM=;
        b=J4EtwWXFnKQvY0PRq+kyn9WByjMbh3cmOr6PKJQKB1E/w/5M7VAzsGZiVwn7NcWWaY
         8J4tpcXwqTcKWlv3gbmu4pWWSsqc6CWM7ao5HXY82kfHqsEa6XDkGA0buW6N1X2rd/v+
         RI6eHK3paKYPNaf+MH6vUrZUxzmxHgycz2J2iUJxtptWWc3G8EUys5lbBbOiK1dp68Dq
         20FKRnseGLsGy+SvfTHZLd3FyPIrkeTB1FLRgJJut35GDxJDzvo7Q16faw4fr6Yri70w
         ba3bcb/Ja3VeAiJNVxWenCQQmcfeTPRpajtQ5YzZqh1CPFvUQIJhAWUOJnL6i25QVW4M
         V/zw==
X-Gm-Message-State: AFuF++lcrB2yq8LjzOFV6Ae4rPIgmsIjt7+/ix97W8aOZ34UGp74GoXv
	7DV9BBI7gHrhPr/TGjM/6/0y7+SW4xZDKqiNhPf+JXAjmZaMuNLTuZ8c
X-Gm-Gg: AR+sD11vqzaofBxuleO5QxX41z5GjOo1udxH19zb7VaiD8O26rhIyUd9dciMg3yVu9d
	9bb/Vkjrxx/VJJAk4OWZuCS7Ir6GivpShn/qohiIjx3H8Ny5E3sfk2VD9KLMSLE7X2BItHBhk7P
	Kv31Uq3cZ8Utgk1mYl1UP6+XhRen4PZL2R4W3Opa/zmj/RfRDA+Zgd738oOVga0IgNvMqOk2ABw
	9A4L21UT6QWyoGomLVMDpYYTjyN9xGJbyqvLYPJ4WS16+x8XG5HHYU1QuPgDlDYD/Z2f7DI7nJx
	RkBYNJ192pZHJNhkRlLdUX+2YrX+NmOnY2sP106Lgqvb5F3HBtJWWMDrJbqITeVEHYv9Sc9mAKj
	SbUSCnzuV12UIZZUYiT9WHDKmSPGJ3VOEoYtHfxp7gPagkLCuI8K48aasJS9rmL82+jR6ND0s2K
	QkRmyDCHCAtaXH2YjYtUAUBcdXgkM/AtB1ceufhAuhauvJsdZlXsW3J4bKC72EqcqiCjVJjVisE
	5aXwJGC170H2VOsyKtfHw7WMDxgzPzXUuAqhqSQZRkAIA==
X-Received: by 2002:a17:90b:44:b0:395:a7eb:a4d8 with SMTP id 98e67ed59e1d1-3964652186fmr1764638a91.14.1787596635313;
        Mon, 24 Aug 2026 11:37:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6989sm26756382c88.2.2026.08.24.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:37:14 -0700 (PDT)
Message-ID: <1667c9542f7ef67ed970c1825de87d16f90c9ee7.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 8/8] selftests/bpf: build each test
 runner instance in its own sub-make
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, 	martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, 	memxor@gmail.com
Date: Mon, 24 Aug 2026 11:37:12 -0700
In-Reply-To: <CAMtxOX3KFvfvbYOLB9WqbrxBhi=k8J5eXGs1wE0peg24CdAQiw@mail.gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-9-nickolay.lysenko@gmail.com>
	 <8da8aa48afa6ef52c22f976793af75b334b189a1.camel@gmail.com>
	 <CAMtxOX3KFvfvbYOLB9WqbrxBhi=k8J5eXGs1wE0peg24CdAQiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-22 at 17:34 -0700, Mykola Lysenko wrote:

...

> > > -# Define test_progs BPF-GCC-flavored test runner.
> > >  ifneq ($(BPF_GCC),)
> > > -TRUNNER_BPF_BUILD_RULE :=3D GCC_BPF_BUILD_RULE
> > > -TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(call get_sys_includes,gcc,)
> > > -$(eval $(call DEFINE_TEST_RUNNER,test_progs,bpf_gcc))
> > > +# Sys includes come from the *host* gcc, not $(BPF_GCC) - bpf-gcc's =
own
> > > +# search path lacks the host's asm-generic/ headers.
> > > +GCC_SYS_INCLUDES :=3D $(call get_sys_includes,gcc,)
> > > +
> > > +$(OUTPUT)/test_progs-bpf_gcc: $(RUNNER_PREREQS) FORCE
> > > +     +$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3Dbpf_gcc TESTS_=
DIR=3Dprog_tests \
> > > +             BPF_CC=3D'$(BPF_GCC)' BPF_CC_MSG=3DGCC-BPF             =
             \
> > > +             BPF_SYS_INCLUDES=3D'$(GCC_SYS_INCLUDES)'               =
           \
> > > +             BPF_CC_FLAGS=3D'-DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-att=
ributes -O2'
> > >  endif
> >=20
> > Did you test the bpf_gcc flavor?
> > I have a recipe to build the toolchain somewhere, if you need it.
>=20
> Two data points. The BPF CI GCC-BPF job builds the flavor and is
> green on this series. Locally I ran it with the bpf-gcc Ubuntu
> packages (gcc 14 snapshot, 2024): the machinery works - 671 of 982
> programs compile, the ones that old gcc cannot handle skip cleanly
> under BPF_STRICT_BUILD=3D0, skeletons generate or skip with the
> objects - until resolve_btfids aborts on btf_data.bpf.o carrying no
> .BTF section, which that gcc does not emit; the BTFIDS recipe step is
> not covered by the permissive suffix in the current Makefile either,
> so the behavior matches stock. I would take your toolchain recipe -
> with a current gcc-bpf I expect the flavor to complete, and I'd like
> it in my pre-send checklist.

#!/bin/bash

set -e

base=3D/home/ezingerman/gcc-bpf-toolchain
build_base=3D$base/build
gcc_repo=3D$base/gcc
gcc_build_dir=3D$build_base/gcc
binutils_repo=3D$base/binutils-gdb
binutils_build_dir=3D$build_base/binutils
install_dir=3D$base/install

mkdir -p $gcc_build_dir $binutils_build_dir

cd $binutils_build_dir
$binutils_repo/configure --target=3Dbpf-unknown-none --prefix=3D$install_di=
r --disable-gdb
make -j
make install

export PATH=3D"$install_dir/bin:$PATH"

cd $gcc_build_dir
$gcc_repo/configure --target=3Dbpf-unknown-none --prefix=3D$install_dir --e=
nable-languages=3Dc,lto --disable-multilib
make -j
make install
