Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9427E1DC;
	Thu, 30 Apr 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555850; cv=none; b=pQ3Sf58AGmXz9NzXIpAWgLC1d3X/7Yera/l8yq0bF2zIe8QCPny28tpEBCd9OorJWdcszWaeVCi810Kn3SoFUPygYSXzFZJcOlk+0tj+n9SBGWlYRJwDscHBAf6K4jQjX59mb+2gw5KhXrFzMxxsKTUfHbIW61hkKAezB6G8GJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555850; c=relaxed/simple;
	bh=fAW7jwEgCsu05O4PKRlWauqQkyTkQ2BfUXoZju2emu8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=a2M06j5d6v3Q2HNF1YjMxUstOCk3/nphOGmwPO2rTg6a4vMvfstsHL1rlhGaePIkLXvhk06F7x/yoxhTFuMolEmxAonfNg1yrysE6X/TwtswXH8HVI3ulbwVnzM1LPeIZPKjZ76lQrIR4OrN+2Zbi4F7tBF7AMWU3GALl/fuuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Upji5fCY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Upji5fCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3F4C2BCB3;
	Thu, 30 Apr 2026 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555850;
	bh=fAW7jwEgCsu05O4PKRlWauqQkyTkQ2BfUXoZju2emu8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Upji5fCYGlRfHKu8A0f6Qp0+gfyNGeF8YmriBu+Jx5qSBx5caQKI4kKX+PT2yBph/
	 jaCFAXJLOhvwCNqpQenIewYUclhw+bn3vT7hwz+gszqRulp4W4z4YepOqUn1Ln2rGQ
	 Wtg1WSDoQjmSd53pYCU3sdz92BQhXbsFKSbSKvE2yRNn+z2pTqqF7p6FAHEM6bC7NH
	 K1MrCM5lDMezysvodGbWi6G35Jjqd35Fx8I0hgz2B6Xbuqd6Q0kEcpABuiGy1xckcQ
	 qYmQpV+cgBxBt/LGalXVn/3N7R777D01Cp7+GhiElK4Yt+lrDlw30vFsXPh8D7BjFi
	 fPIsW3LHw1Ygg==
Content-Type: multipart/mixed; boundary="===============3572617045440469739=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4de9eeb57c344c41536f55d67f71254eb43687505ecf15f6c4995d73a8fe49c5@mail.kernel.org>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-5-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-5-cd302a31af16@suse.com>
Subject: Re: [PATCH bpf-next v10 05/11] selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 13:30:46 +0000 (UTC)

--===============3572617045440469739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 9a4d8bea0c18..608e6dff0392 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -726,11 +726,11 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
>  $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
>  			    $(TRUNNER_TESTS_DIR)/%.c			\
>  			    $(TRUNNER_EXTRA_HDRS)			\
> +			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)		\
>  			    $(TRUNNER_BPF_SKELS)			\
>  			    $(TRUNNER_BPF_LSKELS)			\
>  			    $(TRUNNER_BPF_LSKELS_SIGNED)		\
> -			    $(TRUNNER_BPF_SKELS_LINKED)			\
> -			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> +			    $(TRUNNER_BPF_SKELS_LINKED)

sashiko-bot raised concerns in v9 about the assumption regarding GNU
Make's behavior with order-only prerequisites. The commit message claims
that "GNU make builds order-only prerequisites that do not exist," but is
this correct in the scenario described?

If .test.d already exists and its regular prerequisites are not newer, Make
ignores order-only prerequisites completely. Since the generated .d files
only declare dependencies for .test.o and not for .test.d itself, modifying
a local header to include a new skeleton doesn't mark .test.d as out-of-date.

Could this introduce a race condition or build failures for newly added BPF
skeletons? The new skeleton might not be generated before compilation, causing
a missing file error when building .test.o.

Additionally, if the new skeleton is concurrently being generated for another
test that correctly tracks it, Make won't enforce dependency ordering for the
modified test. This could result in gcc reading a partially written .skel.h
file.

This concern from v9 was not addressed in v10.

Reference: https://lore.kernel.org/bpf/20260429202343.CB842C2BCFA@smtp.kernel.org/
Reviewer: sashiko-bot@kernel.org
Date: Wed, 29 Apr 2026 20:23:42 +0000


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25167006036
--===============3572617045440469739==--
