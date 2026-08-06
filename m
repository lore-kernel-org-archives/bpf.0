Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471850276
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041052; cv=none; b=UKL3ROG+8X+M5l4Ohlw4TyoStphTe4NGSC/IAsOUGzNaaulUaII5tep8lomaGgMw+TtcWQhL6+qy4XBM0SD17Ufwfqmdiu9E8vC7hBX95MBrPFbD64vfHlhMCGu1a/bKg1mkNDodoy6+TYaY/DgdtndxgMGJlxFHfBpGKzqXR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041052; c=relaxed/simple;
	bh=FOKmuqV0tg3ylAuRp8l3wbm/O78CV/7gVmfhUc+ZfYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKGY2cFD4iaDFwWuDzZSleKkyDoRkvJnN5Fu71l+Ht1aAU6OY38y+ZAefs38kJXbVodC3HoAP/qE1IPIp9udw/SuSlL7FqC1+klzX3ST9lFqzl1t75DcEnbynjnpq29Gk39T6zpmzhuhf1sifbKBNEVLh8eo4wjTbFQ9SWly/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiQQ2Drf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiQQ2Drf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3162728b3a.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786041051; x=1786645851; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HTd9X28djD1Qeo3tw/f/5htMfOsb3D7/Qnsls5TsMlI=;
        b=aiQQ2DrfU49s8R9ZI3xI5QNHy64kIC0u8rQCCsj/N2WCOp1YX1iN6p6AvFfJYW5NMl
         0N1zQa8TsajeGiWn2ZRtmZMi3oZhm/pTBtjZNB0LHkeQXRQrpyqRJv6Rb2kov1YbBcrE
         zIXXg+aWY7CwNmPmP7YjPKgEyHSoaefB8tJgfxsaCgfBxKYaMMN3zVwqSqdwimhqzcIp
         Qx7aqTJciyFs3fDVGbdh2ZaVr+rB17DtkP7oqiuyb7Uv96+2Qx87/mzMJZ431gSp9mOt
         kgTGSysuGFsyDnEgk/JlJ788oa9sD2efvFkVskh9cMwbUBrgFtJnixztpd4rUgAzYhHQ
         gudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041051; x=1786645851;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTd9X28djD1Qeo3tw/f/5htMfOsb3D7/Qnsls5TsMlI=;
        b=pVE6Xcw6ZkGzG4XovymIROw30Ilfl45mSV4/GWjaiN0xZXaDDnIrEBWsM+kzDZu23q
         Nf2T0mtGXB1HgSUFdEeGmC8uluJhklYnDx8Md9eQFUOjjQm393D/g/hh6unZl2PsfkrG
         LMZO9rDcisZ7oAi9EqTG4yvkxU1yawvXjXWt7kT+ipvAumhMHWozUoD8wV8FRBE9bQak
         9dKe4zmK66eAVQf6LX+4c2LTaB6CEXI9m9fiDlGGLyGoJ6iMlpnck0yXtLfzNRx/dz52
         HzhaAGIDKMMmQBxKNdmETSNLMtte8Zn5n3NZVDq1NM0VVI9e9K+lVaIpVy2eDUiWvbuK
         Vm3g==
X-Forwarded-Encrypted: i=1; AHgh+RoFEieWRbx6EldoNA9DunIUemKKeeM2XwsjwsTdxX43ahH37oxsSjVR9gQ6PbnkkpCx5HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsuKp6hfGVaZa0auhTp5up7Q3JO/1IEUKrGTtyY8yNczz7wXK
	nwRxrcUPJlmdnlsjC3xmWz26CqjQdfbqkTSIq794aN0svJ6KegmczWzi
X-Gm-Gg: AR+sD12DEzC1hEYjDASq0PvjYNxJl6sIe/0ie+VSr5sPiNPgfDuDD2DExbi1BYHsbYP
	/qKkBA/mW+Njg5niZG2thzne1zef4o5Gc0r/ssj7PWyCEgAlH531AwVZooOYXOL08Ztiqo7KE5S
	eNGLEPTddacGrZpcYDTtdnGyBs3r6ymRBxVmD7KYHBZgSSHGVWeK6tZ90xKCG2Ph/7nIsGcZBr4
	3qvZAQ22pJ1rVVTyrO9BmsWTueOx1DbzevZx26b9RgYv2wcE3AWqACZ7VWdieN+/wwVr6paZhz+
	/lioxM9we2L+dry8/Ew+MHppNCGsrE9PIgYRi+6OBPs5Ug8eInctZWqpY8F1bGUCLrtQPUTfaM+
	MQgx4urNgnIz+WhZqvFLQWI81+gEjOnVlBFNYdOP902bV2oVSGxi/1EM+wZ5yEVPOPUi73ZsXiu
	92KhfPTBtqz7y4A95OUwvhlEzZwkOU3WYeSxGBmtegzSWTRh/oLkc1003rxw/fjqVr/NdLTJHP+
	4YhMTmoZV7WDi9c
X-Received: by 2002:a05:6a00:3d54:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84f2e014151mr18502945b3a.3.1786041050461;
        Thu, 06 Aug 2026 11:30:50 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f4538dfdesm1929993b3a.8.2026.08.06.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:30:50 -0700 (PDT)
Message-ID: <c3f59776953b04e20e18da57e22b9cae2db5c9b6.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 8/8] selftests/bpf: build each test
 runner instance in its own sub-make
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Thu, 06 Aug 2026 11:30:47 -0700
In-Reply-To: <8da8aa48afa6ef52c22f976793af75b334b189a1.camel@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
		 <20260804170156.1709916-9-nickolay.lysenko@gmail.com>
	 <8da8aa48afa6ef52c22f976793af75b334b189a1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 01:02 -0700, Eduard Zingerman wrote:

...

> > +# The default flavor's skeletons are also inputs of bench, test_maps,
> > +# xskxceiver, xdp_* and test_cpp; "default-skels" builds just those
> > +# without the test_progs test objects and binary.
> > +.PHONY: default-skels
> > +default-skels: $(RUNNER_PREREQS)
> > +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dprog_te=
sts \
> > +		BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDES=3D'$(CLAN=
G_SYS_INCLUDES)'	\
> > +		BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'		\
> > +		BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS skels
> > +
> > +$(OUTPUT)/test_progs: $(RUNNER_PREREQS) default-skels FORCE
> > +	+$(Q)$(RUNNER_MAKE) RUNNER=3Dtest_progs FLAVOR=3D TESTS_DIR=3Dprog_te=
sts \
> > +		BPF_CC=3D'$(CLANG)' BPF_CC_MSG=3DCLNG-BPF BPF_SYS_INCLUDES=3D'$(CLAN=
G_SYS_INCLUDES)'	\
> > +		BPF_CC_FLAGS=3D'-O2 $(BPF_TARGET_ENDIAN) -mcpu=3Dv3'		\
> > +		BPF_DEFINES=3D-DENABLE_ATOMICS_TESTS
>=20
> Is there a way to reduce copy-paste between default-skels and
> test_progs? Why does test_progs depend on default-skels?

Overall, I don't like the default-skels dependency for `bench` and company.
Previously these depended only on a subset of skel.h/bpf.o files.
But idk if that could be avoided. One option is to extract Makefile.skel
with the rules necessary to build bpf object files, and include it from
Makefile.runner and from the main makefile. Making `bench` and others
depend on the exact set of skels they want. But I'm not sure I like this
option either.

Please think a bit about this thing, maybe you can come up with
something.

...
