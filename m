Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0B476045
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663517; cv=none; b=opI1N2b7TXgRFR+yCBF1+ZUIIVUmnA+OhIL25BNSA5qho+QgVQvz3SvV/nGR0mI244AD9X3dRfgwU8JcgTs5wf9dCNuCFgBt6iWp3Cg0PWoZqqD19C3kDYs1dRSb7xOj1vLJ+Y9YvQRM+RhftQ5Ed4onnMrZw8flDxwS07c4aoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663517; c=relaxed/simple;
	bh=4uBCS0+VDZZfRjj7v+QYcFLurgU064CvqLAxibBCyAM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iESVJnxpDSdfvGshnIabMh1Xgl1PpwGx5TqxaMqc2u2i3ovN+l+BwAQyX55JbGv0xO8XZzP0GCbvLUvgK5tMH3V11hTD+0b+PwINbCkaEuYVdnPbDgV1IEgotnJEmResBzEVx9Du8Lzcx2MWG1LSByUGCuhFWBA8b2SX33FpYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWWt6Frc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWWt6Frc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78721F00A3A;
	Tue, 21 Jul 2026 19:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663515;
	bh=/3ipz48jhKv451SML2zeUn9u9fav/DmsuLoZTx0IzJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PWWt6FrckrvxPIXPXDbvkXu5qvn5CwPCB3+SR7P8sIbBZwGLwfzKAD3USYhdvpunA
	 r0XHdyT2VoAPprmeHo/1OXfnwMKE49oFuQSyvhUhhGh9cCmwfSqd49UGNCJnwUNFsj
	 esmUgCqnbvZacEJ2iZhSQ5tpMQazITXXV0WyuJneeL5lZkDo5UroBaGVf9B4LoXCaV
	 bbVP/sSK+w4v7BQvoD0hARowhunhfVZg1SEFcp42tjbvxsBwxEnU3b0/NvG9t0oMpK
	 ZE75llwHkrBHiymDl9MFNhwyEKav/0pxQo1IN8qADjLTAYO4voB+iwyoP84ZUFiZ4f
	 hh2tigq2Oob1A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v2 3/3] selftests/bpf: build each test
 runner instance in its own sub-make
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykola Lysenko" <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721194111.334795-4-nickolay.lysenko@gmail.com>
References: <20260721194111.334795-1-nickolay.lysenko@gmail.com>
 <20260721194111.334795-4-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:51:55 +0000
Message-Id: <20260721195155.B78721F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] In permissive mode, test objects are treated exclusively as orde=
r-only prerequisites, which completely breaks incremental test development =
by never relinking the test runner when test sources are modified.
--

--- Patch [3]: [RFC PATCH bpf-next v2 3/3] selftests/bpf: build each test r=
unner instance in its own sub-make ---
commit f7cbf6f3b146270d8f7ba71d9ea0557ab2070208
Author: Mykola Lysenko <nickolay.lysenko@gmail.com>

selftests/bpf: build each test runner instance in its own sub-make

This commit refactors the bpf selftests build system to use a dedicated
Makefile.runner for each test runner instance, running them in separate
sub-makes. It aims to eliminate double-expansion complexity while fixing
parallel build races.

> diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/=
selftests/bpf/Makefile.runner
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.runner

[ ... ]

> +# In permissive mode, link whatever test objects were successfully built
> +# (their compilation may have been skipped); the wildcard in the recipe
> +# picks up the survivors at link time.
> +# Prerequisite order is also link order (test objects, extra objects,
> +# libbpf, lib objects).
> +$(OUTPUT)/$(BINARY): $(if $(PERMISSIVE_TESTS),,$(TEST_OBJS))		\
> +		     $(EXTRA_OBJS) $(BPFOBJ) $(LIB_OBJS)		\
> +		     $(TRUNNER_BPFTOOL) $(OUTPUT)/veristat		\
> +		     | extras $(BPF_OBJS)				\
> +		     $(if $(PERMISSIVE_TESTS),$(TEST_OBJS))

[Severity: Medium]
Will this break incremental test development in permissive mode?

By placing TEST_OBJS exclusively after the order-only prerequisite pipe (|)
when PERMISSIVE_TESTS is active, make is instructed to not rebuild the targ=
et
when the test objects are updated.=20

If a developer modifies an existing test file while using BPF_STRICT_BUILD=
=3D0,
the test object will successfully recompile, but the test runner binary
(like test_progs) will not relink to include the new object. Does this cause
stale tests to be executed unknowingly?

> +	$(call msg,BINARY,,$@)
> +	$(Q)$(CC) $(CFLAGS)						\
> +		$(if $(PERMISSIVE_TESTS),$(wildcard $(TEST_OBJS)))	\
> +		$(filter %.a %.o,$^)					\
> +		$(LDLIBS) $(LLVM_LDLIBS) $(LDFLAGS) $(LLVM_LDFLAGS) -o $@
> +	$(Q)ln -sf $(if $(FLAVOR),..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpf=
tool \
> +		   $(RDIR)/bpftool

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721194111.3347=
95-1-nickolay.lysenko@gmail.com?part=3D3
