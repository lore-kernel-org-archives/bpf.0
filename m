Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2913CEBA7
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665053; cv=none; b=A2LCEFitHj/J3gEEGCrx1l5bk38EzO4KHcwOiyfKGyq16ApcVLid7wNkF5zfquqg/2dUSjnRKPardC7VjuNZhVRegWsQMyAUmR+vWCPaSbFeXsz/fXt2lnd9vijfdFN1y1YvoCCfUQMJY+rkWhlObrwS5OSr3avr4eSjpyCJFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665053; c=relaxed/simple;
	bh=Kxyn5IstlUSw1fhnIDZ5QxHp/0cCSyXx7VML37R+SoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9/a1CtpIOYrcIpKq7XndHBr1USBJaIB+k2YFhmsD0AA7dMVNVQT/uHQ5Uy1gJJs/GgWRFE+I8UejEMp3XOUsmnMilNvcmxXSTiCkXO1uaUqOKJ601+b8/TPxkXX0B8Qihb6CoqpFDNsEGvyRuNkPczV3XQFSIUkcr/ZaY9IutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F16+1RQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F16+1RQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DD81F000E9;
	Thu, 13 Aug 2026 23:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665051;
	bh=cEjKvZxEmALusK/nLzcqFRTA1tqYqT/h+QA9WgeF6RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F16+1RQQ5ms0oXJlAgBkV1Xwvi0Gq5v5p94DhOTRw1EsdPqK/mgYQZYao+b4Zvp6x
	 0pN5Yh96Wm8L8xC4uhP79/+I/tuB60zKnxv1kisVnDRfCV6ym0iV7iwGDgpfE60ikX
	 BENOH+eAocsUzp94z2ivWlt4lmrWW1fv8E0JlDHugKMOnql8eXgVQEKeK5kRutmBj7
	 LX1jxEq2hGcU1Gcp9LbbFnZcd0jG46INoWRocdZj0EyESLElkWwn0cERVtKg8zawZ8
	 pBCXsLPObAPwZUzfHjS//sbSZ7Mz7XvKdoYnf9GdGRCcK/CS0Lm6FYV5UTBPl9Lsj5
	 UNK5kVuEpDOWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] selftests/bpf: Tolerate benchmark build
 failures
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260403-selftests-bpf_misconfig-v2-7-f06700380a9d@suse.com>
References: <20260403-selftests-bpf_misconfig-v2-7-f06700380a9d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:50:50 +0000
Message-Id: <20260813235051.53DD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Masking benchmark compilation failures breaks `make install` unc=
onditionally due to the missing `bench` executable, as partial linking of `=
bench` is impossible.
--

--- Patch [7]: [PATCH v2 07/10] selftests/bpf: Tolerate benchmark build fai=
lures ---
commit d38880b3d361e7ca90a0ac6bc884115d3f936eda
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Tolerate benchmark build failures
   =20
This commit makes benchmark object and binary compilation non-fatal during
the selftests/bpf build. It emits SKIP-BENCH or SKIP-LINK and removes
failed outputs to prevent stale object reuse.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index ca64a7678dfe1..6c4f854594862 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> @@ -918,7 +919,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/usdt_2.o \
>  		 #
>  	$(call msg,BINARY,,$@)
> -	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
> +	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$(wildcard $^)) $(LDLIB=
S) -o $@ || \
> +		($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@) (some bench=
marks may have been skipped)' 1>&2)

[Severity: Medium]
Could this cause the installation pipeline to fail unconditionally when a
benchmark object fails to build?

When a benchmark compilation fails, the linker step fails and deletes the
target executable. Because the bench binary is listed in
TEST_GEN_PROGS_EXTENDED, the rsync step in tools/testing/selftests/lib.mk
during make install will fail when it attempts to copy the missing file:

tools/testing/selftests/lib.mk:
INSTALL_SINGLE_RULE:
    ...
    $(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INS=
TALL_PATH)/)

Also, is it possible to partially link the bench binary when some objects
are missing? Looking at tools/testing/selftests/bpf/bench.c, it hardcodes
explicit references to all benchmark structures:

tools/testing/selftests/bpf/bench.c:
static const struct bench *benchs[] =3D {
	&bench_count_global,
	&bench_count_local,
	&bench_rename_base,
    ...
};

This guarantees an "undefined reference" linker failure if any object is
skipped, meaning the bench binary will always fail to link and get deleted =
on
a partial build. Should missing benchmarks be excluded from the benchs arra=
y,
or should the installation step be updated to handle the missing executable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260403-selftests-=
bpf_misconfig-v2-0-f06700380a9d@suse.com?part=3D7
