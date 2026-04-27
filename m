Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE936EA93
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325033; cv=none; b=BS2eVjtFSlHat/igIrOkbG9FgJ8xTiZM9rOPbMQPWI/+lxyfhtCfABIxxclHzz8ro/5MOBQBXsnhtzzehbPEsU5REdFvRp60VKd+DC7oDNKLakCNgYiBQo6Xmdm7yPxQlxBiQxkIcqnILxPYlYR3AyvcDKrx3Ay9sG05SqAwXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325033; c=relaxed/simple;
	bh=KRk8B+ngbDeB9L6cL/EdHsENn2mLX85NZwMuOMvqjyo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=tNtEbGH4ZwV8nYN0+pDcB0sKt8lQii/XMj6ByUaWRFFHQG/YhNYpyxe+PcaXp0cbvRDwnSxMxT5G7oGVNK7h1PvikC9gS2+89i2lbKqjkVJvEyzPWs9ZkB9lgNyrjMigqOexmETz80ejvvv2AmHXyMRqlCxXUerxIGGIeAdJdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A1WkO90M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A1WkO90M"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so140936945e9.0
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777325030; x=1777929830; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSb2kT/p2nHp9W8YGbH4Kxl+qPnG5y+IcOEh9Cvj7/8=;
        b=A1WkO90Mk8OKLS7kulpUo9XU35uE5QbfhpdMzob9NcfgXWCUnFH10m7xVshwyWfn0b
         QrhPA+j3krlZEIKwdgZQFx89sGgK5dzxIXaVMvwiqpGTnlYsrjjifPHnX0Eq6HKclE6t
         3mWkulQMIXugeBUbFx96hNMDNphcmyTuswofSOqA6q7mPKMKG0B2VTcTwkrXpG5QNRpU
         0D04kGnYRIeP9KfSvh1rpeFeuiaz1WYjx10u6akcOgwE2rnK/J0YJ1gIZFx7auX6595C
         IKPYM1+bkAr0IOwUuGtMkkC1SkFM/KcTogsenPQprWSMHch+R3tkxlvwQm1opbQ1TQy7
         8Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325030; x=1777929830;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSb2kT/p2nHp9W8YGbH4Kxl+qPnG5y+IcOEh9Cvj7/8=;
        b=VLaPLFMWBqLH3g9ZcEFyGf8YcEWegPdbQNGPF/jjN6+mPVqDcbs80zFMj1aJ+KErTn
         j9K+S8FCIRmlYyBwPq8Rmdf8pWT/VlyWX9t94OB0j776BloPnS309IKOV7sjP64/5RXh
         S2WjYCjoX9UBGnDuusWJQHHyhH94WDBJBRuGduKuVaDHE5m0gtrE4YhXzPKi2FiOyLvm
         2QCXEQbIqbnsw1mTLvlUne1puuprjCQiGewCG3QNHhTyK/I89ujtHNbx6GQBKvCOsOZp
         qOOForStwMOdMtGIbIfe1FNP6PU6C476WDIX2EEpfLxxI4ZMj1OFRtvDxmsR3/Cx231U
         pItA==
X-Forwarded-Encrypted: i=1; AFNElJ/U3e+QzS5fqxHtiN6BehTysnqyD0R5alE/l7f+lPqIAakC3hZtzgAsqmiE+2UCvHSt3L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBmVZHQekLNsXegTbv3JmyoCqdaF71PHZUHk2I4VXAIevuQt4
	ipeZQD2Hy7Xvy094VtYeNWcLIW72LfC3yz3NYy8e9fh77JHZ/TLmxJnPcdkJTR4weqs=
X-Gm-Gg: AeBDiev7B5H2cjTunGGdaYK9Ako88Z8DT0fN7rmITKYNH2/IvTHrinZ+3Jtq5VUqsDP
	oZmZVUgGCMciVBU2U6gGwkw87Zm1vUnoa35K91U/JpM5Z5KNt0X+sBTxNVs2VA824ku8qJJSMWR
	/+qyGGiMPx7UT0mNCvI+TkWdfrEKv1X9Zu+vtpgSvulCpmWaGBpMKS6IKqDaOHbp6MhCdX7o0pN
	vJBnY+1d0J8zUEzcak5l0mFu0rl2S2xCFFmOfU4VuiF3P93isBRI0XzCgkv+0doas3EjW+tvGTW
	TlGQHQkbdTCnN2escKQKCuoU0HAaEgA5oRi4TiExPCQsUHbFvOEkCc4XPqbP4T19VewGF26PEZF
	QDVG+w5FEOFs8S2zFImK7EnqcD3x7kWzu2lemRqrclbQoAeKAAWN2va+8B/nMSsUQ3n1UmLMCIx
	XfkrRog/2TSyR+xU8K1NgK8o0=
X-Received: by 2002:a05:600c:820f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-48a77ad4632mr5119965e9.2.1777325030433;
        Mon, 27 Apr 2026 14:23:50 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573a4610f21sm426536e0c.13.2026.04.27.14.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 18:23:46 -0300
Message-Id: <DI49519GKW4C.165FTRCZIBL0P@suse.com>
Cc: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "bpf"
 <bpf@vger.kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <sashiko@lists.linux.dev>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next v6 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260416-selftests-bpf_misconfig-v6-2-7efeab504af1@suse.com>
 <20260416125321.7AF09C2BCAF@smtp.kernel.org>
 <CAADnVQLXvs_+c67FH5rk15L+QDGS0=UovgOaTvHeQ9-_suzo=g@mail.gmail.com>
In-Reply-To: <CAADnVQLXvs_+c67FH5rk15L+QDGS0=UovgOaTvHeQ9-_suzo=g@mail.gmail.com>

On Sun Apr 26, 2026 at 8:40 PM -03, Alexei Starovoitov wrote:
> On Thu, Apr 16, 2026 at 5:53=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>>
>> Sashiko AI review found 2 potential issue(s):
>> - [Medium] Relative paths passed via `O=3D` are incorrectly evaluated fr=
om the kernel source root instead of the invocation directory.
>> - [Medium] The `make clean` target unconditionally fails and aborts the =
build if the kernel source tree is unconfigured and distro headers are miss=
ing.
>> --
>>
>> commit 533e8d39cc98f56f3dff4f8c5bff0dcd49fc6ef1
>> Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>
>>
>> selftests/bpf: Fix test_kmods KDIR to honor O=3D and distro kernels
>>
>> This commit modifies test_kmods/Makefile to honor O=3D and KBUILD_OUTPUT=
, and
>> adds a fallback to /lib/modules/$(uname -r)/build for distro kernels. It=
 also
>> makes missing KDIR silently skipped when building in permissive mode.
>>
>> > diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/t=
esting/selftests/bpf/test_kmods/Makefile
>> > index 63c4d3f6a12f6..10f202bd0d8c2 100644
>> > --- a/tools/testing/selftests/bpf/test_kmods/Makefile
>> > +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
>> > @@ -1,5 +1,7 @@
>> >  TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_L=
IST)))))
>> > -KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
>> > +SRCTREE_KDIR :=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
>> > +KMOD_O :=3D $(or $(O),$(KBUILD_OUTPUT))
>>
>> Will this break out-of-tree builds if a user passes a relative path?
>>
>> If a user builds selftests with a relative O=3D path (e.g. make O=3Dout)=
, KMOD_O
>> captures this relative string and passes it unaltered to the kernel buil=
d
>> system via make -C $(KDIR) O=3D$(KMOD_O).
>>
>> Because make -C changes the working directory to $(KDIR) before evaluati=
ng
>> O=3D, the relative path will be evaluated relative to the kernel root ra=
ther
>> than the directory where make was originally invoked.
>>
>> [ ... ]
>> > @@ -14,8 +16,24 @@ $(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D=
.o)))
>> >
>> >  CFLAGS_bpf_testmod.o =3D -I$(src)
>> >
>> > +# When BPF_STRICT_BUILD !=3D 0, a missing KDIR is fatal (the default)=
.
>> > +# When permissive, skip silently.
>> > +PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
>> > +
>> >  all:
>> > -     $(Q)$(MAKE) -C $(KDIR) M=3D$(TEST_KMOD_DIR) modules
>> > +ifeq ($(PERMISSIVE),)
>> > +     $(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPU=
T=3D) \
>> > +             M=3D$(TEST_KMOD_DIR) modules
>>
>> [ ... ]
>>
>> >  clean:
>> > -     $(Q)$(MAKE) -C $(KDIR) M=3D$(TEST_KMOD_DIR) clean
>> > +ifeq ($(PERMISSIVE),)
>> > +     $(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=3D$(KMOD_O),KBUILD_OUTPU=
T=3D) \
>> > +             M=3D$(TEST_KMOD_DIR) clean
>>
>> Does this unconditionally abort make clean if the kernel source tree is
>> unconfigured and distro headers are missing?
>
> I think both issues flagged are valid and need to be addressed.

Yes, indeed! I will respin a v8 (this is v6) later addressing these and
a few other points. Thanks for checking, it means there's still hope for th=
is
series :)

I wish there was a way to trigger sashiko without having to send it to
the ML.
