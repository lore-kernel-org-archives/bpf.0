Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71221CA13
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232557; cv=none; b=Oh5Sga6sBfgZdl+uZVojC1+gDPQCmzirlbOUo9NAyqaxzQDWqX8BdK9P8V08+440qobiVfE5AVWHz6DYFyyebScH/jIMsMvOTiO7RwJ86tAgc1dSqaGe3OHNDQwsiwOb/537pfybJlO3GU9/5hVv7pU7cRluuYa665awa/UPZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232557; c=relaxed/simple;
	bh=mun1sf8kmKZk08Nymw1fIkZAY0k5mSEpHquJTLuAa90=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UyyuEmntPWK0+oEpI9UORHk7XWxQxghOSLZ0HImoN8gyR9mIxQRMxE/kbfFxuMom1VIy2Kflo4iMMMt4wSJ1nWWf9xrZtFgDBOEWsFw1WB5w/2H0UEH4hKXswxzFyk4zydUUqdTpYDl5934eimhY1j4/j2ft1RgGgssqT7jff0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOTrjE3A; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOTrjE3A"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so5798268a91.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776232555; x=1776837355; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DS2EJhxlzryfSIx+ZY5iXdPRGbh5lfuGbvnIsk11xco=;
        b=dOTrjE3ApOQZjYOC29oWLXX3/nsQyzTJhhEmPP7zq5WYVRfOB94uJYdzsEKm1SutRL
         dZtZ6CXmAMrQgW7LEnw+D761oIh4Zw1T4TN22rz3Qqiv7bEu8Mbb9rZekibBdStk+rt1
         IvH5FXWoeZLfSx11Jc6vv793tGT0yKyjwveQD5n1CaskYd7RX+64/ZveKFnK9/jC9hQ7
         MDyb/5aphgPPzded7p+57tbAWkrqS1SBcLxx/oUYijM+/Z/w0Zdyn3UlIFD1sFhTQ6Pj
         J3bjD1pfpN4bZabKu8jr9yXDPOywMmjCyK/6PuWgwshVuQko2ghVIFrkEMSvMqywZjP1
         8twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232555; x=1776837355;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DS2EJhxlzryfSIx+ZY5iXdPRGbh5lfuGbvnIsk11xco=;
        b=Le0YZaU4uOwZZ0sbyCo5Tnucs6Knm7bg6N5ErHdQk3sNA3cz6lwMvMiymPEDdx6Zle
         kEDzjIxEmpBSFuoVaLCNeJEV4bI8KTpoVqQe4lg62d99brGwKypxObz6cYGfqAGJkJJu
         o6clQrgcKb4HqyN+cacmPAHyw4m39/BiO84itoyJ8MZGt2WbO7PzTIgOc6Z7cg2nds/C
         2rpV31G3tuoeqjauP4EXPTGLrwGAR4eukHHxpfG2EIizDr2saeemYukweM7UQNI11UIb
         EMNxPM4eSEUxj5l1vw+k6UKSfcIOSh2/O0p79sGkLDwaHeNl96tyoEgUhb2PN/wXWEjA
         J7YA==
X-Gm-Message-State: AOJu0YygfXZ1zX26JCL6d5KHUWJWGuQ7MCNmnNmMDWkcedmGRsA2ZMBf
	A6q0N2w9Mudi9cX5qZM7ZyQpkn6VUVNoQ+aFRGNfTMpug/dtPZpHteM4EXrzPS0i
X-Gm-Gg: AeBDieuaBa9P8lbtCeybJUzDlU3iNSkb3ZT90P0imxFNc4uKPb/d9gEn11V42tqoS4U
	hI7O8TaIbFVABnCq0Cd5lP0vG+cR6o3mDshORBwlB9E2gRpzr+4tZOTYPuiMlEvBDjkfeyduJRW
	I7NgMzMGxM6gBOX1AX24ycl6NadZNi9jCVpCjyJCjf/q7hiJO14mUz1u2se/pr7MMnk6/dJ9myf
	LXBPYhv27W8G5gOn6W7IK8jSiWpb3ECxDeV5JEa0MBfPlVDzTwEcWDuYLf1i1nw9esTr2wzc/XI
	hhq9WLcITwQgc+7wjCzVm51lSEgfcbqiaqVc9hEigQDWtbOQBLqSBYIw0AhrtEXtrRHHlJhBAW1
	7w5d3HmHcrtvvC44jUIKJhSku2/Dz6HwXXCgZUey/dklbLaqaLlmTAfW04lsfq11l1qDyVol5Sq
	v4FVyW8Ls+eJh4xxTNuX+E23ODqrzHtRkDmH104KSnkqGj+JJAr+nb
X-Received: by 2002:a17:90b:1850:b0:35f:bcfc:27b8 with SMTP id 98e67ed59e1d1-35fbcfc2b0emr9507734a91.7.1776232555418;
        Tue, 14 Apr 2026 22:55:55 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478115de4sm8544415ad.27.2026.04.14.22.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:55:54 -0700 (PDT)
Message-ID: <6fe22c1f033064a68fe170e6135611cac72ee59d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: verify kallsyms entries
 for token-loaded subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 14 Apr 2026 22:55:51 -0700
In-Reply-To: <20260415012106.5C63CC19425@smtp.kernel.org>
References: <20260414-subprog-token-fix-v2-2-59146c31f6f1@gmail.com>
	 <20260415012106.5C63CC19425@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 01:21 +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The test modifies global sysctls (`perf_event_paranoid` and `k=
ptr_restrict`) while running in parallel, causing race conditions and poten=
tial host state leakage.
> --
>=20
> commit 9e0a167112286dfb5b44d5686732b8297533a10b
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> selftests/bpf: verify kallsyms entries for token-loaded subprograms
>=20
> This commit adds a test to verify that both the main program and its glob=
al
> subprogram appear in /proc/kallsyms when loaded using a user namespace BP=
F
> token. It temporarily modifies global sysctl variables to allow reading
> kallsym addresses.
>=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/tes=
ting/selftests/bpf/prog_tests/token.c
> > index b81dde283052e..89da527ed9304 100644
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
> The BPF selftest framework executes test_token() concurrently with other
> tests because it lacks the serial_test_ prefix.
>=20
> If another parallel test modifies or relies on these sysctls simultaneous=
ly,
> can this create a race condition where the parallel test reads the
> already-modified "0" as its original state?=20
>=20
> This could result in the host permanently retaining the lowered security
> settings once the tests complete.
>=20
> Should this test be renamed to serial_test_token() to prevent concurrent
> modification of global system state?

I don't think that we have tests that rely on these parameters atm,
but suggestion makes sense.

>=20
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
