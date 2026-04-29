Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD42E11C7
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777439237; cv=none; b=BWhaPd7WpjnCGs37lJlENZfh7ADl6AyJhDDOTRoaDTwnmigwy8DspYUI2u7wo5oX5RoqlxoYk6nxAumMmD26ubyRRSP4DbzNXfeTIntpUwFMeU+LMs8U5w29619G/CLGbI+76z44+aD2SgBgIPkNqoDAIybsMKjVFWNT7WHLehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777439237; c=relaxed/simple;
	bh=XzVWWzBSBYTWVRzaVk6QRXVQQhDBBCYbbiqIyxtBxPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SFqYbuS0cE9nIC4MNkCQBP033JeWRkxFG7/HkR7Olk9D0UKbMCZOs206TK0KQGDeDzF+2Udk5SiCHdZZdqKfxq0RRs2fwPO5mJXdHc6mLJVgsPKoXD86Da3bcsPMhnPh2BSYHN8haox7K0M4i81eP7huyAwgBGxM6GoqvP4BMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAccHTkA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAccHTkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C37C19425;
	Wed, 29 Apr 2026 05:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777439237;
	bh=XzVWWzBSBYTWVRzaVk6QRXVQQhDBBCYbbiqIyxtBxPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lAccHTkAeJDCZrncUNPI4fzy7TXso64q22PQtpTEIRORFuz+TwO3kCibRrbaRdjKa
	 5DKjfKGE65jEMUqqn35UCQW4Uw4NDS9sA3DQANMXwzNWIsJ+qCSdibnrlazyDbYQi1
	 l3/TaIulqU5xXHvOlp0p8aJftEIjTbfPrh6FZRx2bLy1K0q3bzslMN4igcSS/8RoxY
	 alM9ntgpqxjBpX3H6EUh8cxrHi5Rftsobuxxk3xuU6OQ74C3DNS0r40cE6aNUEszkt
	 dN/a0p3BMOJ/8vUOMGLu+IqlSHRnmANthXp2So5DWRCLFhm0uKLvSQxCpLYFMu69BH
	 WFYcucav40ANg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 08/11] selftests/bpf: Allow test_progs to
 link with a partial object set
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-8-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-8-bf02cf97dbcb@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 05:07:16 +0000
Message-Id: <20260429050717.53C37C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Permissive mode completely breaks `test_maps` compilation if any m=
ap test fails to build.
--

commit 15e53592c403b04c6a911fd423e83a28f95d78e8
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Allow test_progs to link with a partial object set

This commit modifies the test runner linker recipe in permissive mode to on=
ly
link against test objects that already exist on disk, while keeping the full
list as order-only prerequisites. This allows the build to succeed even if
individual test files fail to compile.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index f0545ee6b32a..9a5177455f0a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -767,14 +767,15 @@ endif
>  # some X.test.o files have runtime dependencies on Y.bpf.o files
>  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
> =20
> -$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
> +$(OUTPUT)/$(TRUNNER_BINARY): $(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TE=
ST_OBJS)),$(TRUNNER_TEST_OBJS))	\
>  			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
>  			     $(TRUNNER_LIB_OBJS)			\
>  			     $(TRUNNER_BPFTOOL)				\
>  			     $(OUTPUT)/veristat				\
> -			     | $(TRUNNER_BINARY)-extras
> +			     | $(TRUNNER_BINARY)-extras			\
> +			     $(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS))
>  	$$(call msg,BINARY,,$$@)
> -	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS)=
 $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> +	$(Q)$$(CC) $$(CFLAGS) $(if $(PERMISSIVE),$$(filter %.a %.o,$$(wildcard =
$(TRUNNER_TEST_OBJS)) $$(filter-out $(TRUNNER_TEST_OBJS),$$^)),$$(filter %.=
a %.o,$$^)) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@

Does this change break the test_maps build in permissive mode?

The modified linker recipe applies to all test runners, which includes
test_maps. In permissive mode, if a test in map_tests/ fails to compile, its
object file is excluded from the linker command line.

Unlike test_progs.c which uses weak references, test_maps.c expects strong
references to all tests. The map_tests/tests.h header expands to
"extern void test_##name(void);" and makes direct calls to "test_##name();".

If a test object is excluded, will the linker abort with an "undefined
reference" error when linking test_maps, defeating the purpose of
permissive mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-selftests-=
bpf_misconfig-v8-0-bf02cf97dbcb@suse.com?part=3D8
