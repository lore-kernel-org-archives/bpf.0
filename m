Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505AE285C8B
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287945; cv=none; b=qsms7V/0l5jhJ3zYY4h2VXADxbOQwrAH0fGq4kkv+8xApZCff6gGNi6RKL0y7qXWFY2T6IYW9QDfT3jvJfuwn6s/uFMhOudQR0Rg3mK1kmIspVPS24X2jdih89p+hKs/0A5fordXL9ituGjpbJEZBXpZN2xS8uCZy19rgrAGRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287945; c=relaxed/simple;
	bh=yFPrCzieF7tSGMxGBfsF/wTmYsiphElqGS5F4SLPJE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B7m46lE/zON1gEh9wf4zgfT+wcH/HDD3+ZixiNEtOZX9WYNQbu4p7oDVgJmGr0n6UA35a4GvGayK+9U/brIv22TZ/7lCNY6I/jYxE2kzkAlbIMPSeoJJ89fZk/AHiyDO8Yac3g83h9BiJFysg0S9bsPRIqYgSJSDdUGLHz59wjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdBMVOjx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdBMVOjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCC4C19424;
	Wed, 15 Apr 2026 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776287945;
	bh=yFPrCzieF7tSGMxGBfsF/wTmYsiphElqGS5F4SLPJE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hdBMVOjxPn+VXdkNSc6WXNALF/j13ZcLfS5b2lPRXRuMEBLOP8B3UrTG+qFkVyw6n
	 bJ55M+aAJk8Yf/USdqlmI0crUhZ3nid9ourMTIFqBJykW7rs/GDZQhpxFPevF8MCAR
	 ZLUI+PIQRiSVQ2wvED9zEoR5MoJkxFG2eQgvu4UJXY1dMUY7uuu/kD5Vi/Z8ZhmdVs
	 O/I2KncC3vNPEQGGIV1unUNjIR6UrtARBYK/gSwYzpB7tECoAwxT+NuUthDXKyHnCH
	 KmIzTGrKvi2IJ14u/fm3lhY9bWz0vD5L1tri8ZINhHm4Fe+7r92WcQlLDHJCbYhjMs
	 vohae6puGNkIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 07/11] selftests/bpf: Allow test_progs to
 link with a partial object set
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-7-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-7-03d0a52a898a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 21:19:04 +0000
Message-Id: <20260415211904.CBCC4C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Moving `$(TRUNNER_TEST_OBJS)` to order-only prerequisites silent=
ly breaks incremental linking for BPF programs and headers.
- [Medium] Linking with a partial object set introduces a regression that c=
auses the test runner to unconditionally abort at runtime.
--

commit 26b01d6050c56240db40d2043c1d68b4a725414c
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Allow test_progs to link with a partial object set

This commit modifies the Makefile to move test objects to the order-only
prerequisite list and uses wildcard expansion to only link built test
objects. This allows the test suite to link even if some test objects
fail to compile.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> -$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
> -			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
> +$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
>  			     $(TRUNNER_LIB_OBJS)			\
>  			     $(TRUNNER_BPFTOOL)				\
>  			     $(OUTPUT)/veristat				\
> -			     | $(TRUNNER_BINARY)-extras
> +			     | $(TRUNNER_BINARY)-extras			\
> +			     $(TRUNNER_TEST_OBJS)

Will moving TRUNNER_TEST_OBJS to the order-only prerequisites break
incremental builds?

In GNU Make, order-only prerequisites ensure build order but do not trigger
a rebuild of the target when they are updated.

Modifying a BPF program correctly recompiles the BPF object and the test
object file. However, because TRUNNER_TEST_OBJS is no longer a normal
prerequisite, it appears the binary will not be relinked unless a manual
clean is performed, silently ignoring changes to BPF programs.

>  	$$(call msg,BINARY,,$$@)
> -	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS)=
 $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> +	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$(if $(PERMISSIVE),$$(wildcard =
$(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)) $$^) $$(LDLIBS) $$(LLVM_LDLIBS)=
 $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@

Does linking with a partial object set cause the test framework to
unconditionally abort at runtime?

The test framework dynamically generates prog_tests/tests.h which expands
into weak symbols in test_progs.c. If a test object is omitted due to a bui=
ld
failure, its weak symbols correctly resolve to NULL.

During initialization, the test_progs binary iterates over registered tests
and validates that every test has a valid function pointer. It prints an er=
ror
and immediately aborts via exit(EXIT_ERR_SETUP_INFRA) if it encounters a NU=
LL
pointer.

While this is addressed later in the series by commit 6ad669628925e
("selftests/bpf: Skip tests whose objects were not built"), does this patch
introduce a temporary break in test infrastructure functionality?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415-selftests-=
bpf_misconfig-v5-0-03d0a52a898a@suse.com?part=3D7
