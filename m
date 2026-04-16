Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91E2D46B3
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363064; cv=none; b=QmKf/DCZQa505aQOFiwBZdbe2zRjfYNw9pV+godkOqo5nDIjRzNbVGxFxXlt8Q6SSNlEJCrOzQP+Fb1yTbj68NlUbXXCPWDiWD/leJWlbocxlP+crn6/Wt22qajP9ZLmU9nUV80yjvrVx5w0i7VNLP78ZhhUncmOArka6nGCSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363064; c=relaxed/simple;
	bh=YRyRbra96qCzvtTHVGNhul3Mwrs6dZoxF/LhbhazlWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h5RnuAU4uGXr7v/cWeHOLPyG22sznbJwBksdxJPJFgiRl9Qx4gXeLbvqJPFTvnXVQVyvuUZoHbcyrI0NtieoVVCr2tyh523FLzhoF6elgcTw9BbuyM6t08B/dkbeTB3QCOYW5a3XseZLV2TwauGgHjtipj1SheTjsm6NQQuTybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5+yrJLw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5+yrJLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8090C2BCAF;
	Thu, 16 Apr 2026 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363063;
	bh=YRyRbra96qCzvtTHVGNhul3Mwrs6dZoxF/LhbhazlWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N5+yrJLwGxW6aac4QXrOPkVZZT9HHj2cnZz1ks/OiPR1Q6pbtpx2MhQwFrlXKY3Dh
	 b4gLmGNKbMIUnwurUpG3+wPmHM0OXJZkkVOG8v0xwohHK3XC1GQCmVp8TB078d9qZj
	 QICmCaiDjHBy0wjFDQgmMEuKcecbc+NNrVH6qPe0yqMu4aqEZdUGk1Uu8vOXIpvO64
	 xMg9ELmqFdpRc2fvv4SAEMhLUXt9gGUEISl6FLnUQ9b8WRq3guFmL7NIm1mMxfjV9U
	 5Q4FLLRyNkhknpN2+7Nkl6jZ4hnWbyjMNiKaPF4Q9Lk+fuiebuWo8ZEAGDrgFHUi8o
	 xr9H5rEJ1N2sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 08/11] selftests/bpf: Allow test_progs to
 link with a partial object set
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-8-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-8-7efeab504af1@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 18:11:03 +0000
Message-Id: <20260416181103.B8090C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] In permissive mode, moving test objects to order-only prerequisi=
tes breaks incremental builds.
- [Low] In the default non-permissive mode, the linker command duplicates a=
ll test object files, causing 'multiple definition' linker errors.
--

commit 9ee39343705c1b6b0ebaf3f229944fadafcd695b
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Allow test_progs to link with a partial object set

This commit modifies the Makefile to support a PERMISSIVE mode, shifting
TRUNNER_TEST_OBJS to an order-only prerequisite when enabled. It also alters
the linker command to filter built objects.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 5ad50d3ff2f8c..79991dc98ddda 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
[ ... ]
> @@ -758,14 +758,15 @@ endif
>  # some X.test.o files have runtime dependencies on Y.bpf.o files
>  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
> =20
> -$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
> +$(OUTPUT)/$(TRUNNER_BINARY): $(if $(PERMISSIVE),,$(TRUNNER_TEST_OBJS))	\
>  			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
>  			     $(TRUNNER_LIB_OBJS)			\
>  			     $(TRUNNER_BPFTOOL)				\
>  			     $(OUTPUT)/veristat				\
> -			     | $(TRUNNER_BINARY)-extras
> +			     | $(TRUNNER_BINARY)-extras			\
> +			     $(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS))

When PERMISSIVE is set, $(TRUNNER_TEST_OBJS) are moved exclusively to the
order-only prerequisites list.

Since order-only prerequisites do not trigger a rebuild if they are newer t=
han
the target, could this regression break incremental builds? If a test C file
is modified, the .test.o object file will be properly recompiled, but it
appears the test binary will not be relinked because none of its normal
prerequisites have changed.

>  	$$(call msg,BINARY,,$$@)
> -	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS)=
 $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> +	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$(if $(PERMISSIVE),$$(wildcard =
$(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)) $$^) $$(LDLIBS) $$(LLVM_LDLIBS)=
 $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@

When PERMISSIVE is empty (the default behavior), $(TRUNNER_TEST_OBJS) is ad=
ded
as a normal prerequisite, appearing at the beginning of the $$^ variable.

The modified recipe prepends $(TRUNNER_TEST_OBJS) to $$^ in the filter
command, making the expression evaluate to:

$$(filter %.a %.o, $(TRUNNER_TEST_OBJS) $$^)

Because Make's filter function retains all matched words and does not
deduplicate them, will this regression pass every .test.o file twice to the
linker and cause multiple definition errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416-selftests-=
bpf_misconfig-v6-0-7efeab504af1@suse.com?part=3D8
