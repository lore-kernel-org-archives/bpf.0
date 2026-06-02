Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC773E7159;
	Tue,  2 Jun 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407450; cv=none; b=pS8SWUEeK/GLMcyEUQ8qDCWqr3XJX6cokX9Tlr/nmLCbrrCFwYH+/OE5KnbEXljXPkMUtT3mzgq+ii0h9Odoldl1hP30ykBBH58GRFB7mS7+TqFGPsqu4vrPBcxFbzrWBdRKWgG0E5VnSuKANCon7YU15T36UuF8aMzGrrTrW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407450; c=relaxed/simple;
	bh=I4hwqx3IbT/9IAGMUc4L+6mxyKZcWBzxiwdYN+qzRKg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=i3/4mz25+inR8NcHADGw6MYrnPVP9wOihQk/rGZnF6oA96/5lqO+r8cc4RE2RTTpkuuZ3RLLQWvqFzxpValyGHk/f3DSCW0t2s6B354p+ABgQcIQtvZwpqPZA9zGgmDkxOrpRVPhJJcnvmz2TZwVnN9FtZtMa4UTASwSMqDfasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNDitYo3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNDitYo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45BA1F00893;
	Tue,  2 Jun 2026 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407449;
	bh=yroxFHa2N4kyQMkQLaNCA1DYAIhUp5e+shfNW8bg4lI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MNDitYo30hK0v+q/WkK1xlUnA4fkHarwRNeZskhFdeihbg7qagIHMqMxtxxcG473D
	 pFPXiTvJRKaFFBf0z60w6G2TDD8vE9Qvwvntuv1fUiKYbIgAAgsnTgFPRjJiyaqFrx
	 0gY7nRIXHdxHBvJPEu+K07UoP3kJ+KIZAbA0OUc4SKRXu2j668hJy7MFfUI8/H0EVc
	 lDYGhea3rx7o/ldBcIr/wIaKDZra2KUn5mG2/x54pIWvBkwmPRQnkXinle8gXhWnmK
	 WSbd1TBPUTAKQpGkAJFBfJQ3/9UlJjYzpfrGzd9eMxQip2QvMtcTf/N0yJZhiplFes
	 uYMGTeRJdBiew==
Content-Type: multipart/mixed; boundary="===============7318987521802235669=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b4807b03f9d70c2749eab46289592c434c4d350d056646f2c493f642742b440c@mail.kernel.org>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-2-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-2-27f898b3ba26@suse.com>
Subject: Re: [PATCH bpf-next RESEND v12 02/11] selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 13:37:28 +0000 (UTC)

--===============7318987521802235669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 75036c1b5c4f..e912526a65dd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
> index 63c4d3f6a12f..031c7454ce65 100644
> --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> @@ -1,5 +1,16 @@
>  TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> -KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
> +SRCTREE_KDIR := $(abspath $(TEST_KMOD_DIR)/../../../../..)
> +# Honor O=/KBUILD_OUTPUT only if they point at a prepared kernel build
> +# directory (one containing Module.symvers); otherwise treat the value as a
> +# selftests-only output directory and fall back to in-tree or distro headers.
> +# The parent bpf/Makefile resolves O=/KBUILD_OUTPUT to absolute paths before
> +# invoking this sub-make so relative paths still anchor to the user's
> +# invocation directory.
> +KMOD_O := $(or $(O),$(KBUILD_OUTPUT))
> +KMOD_O_VALID := $(if $(KMOD_O),$(if $(wildcard $(KMOD_O)/Module.symvers),$(KMOD_O)))
> +KDIR ?= $(if $(KMOD_O_VALID),$(SRCTREE_KDIR), \
> +	    $(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR), \
> +		/lib/modules/$(shell uname -r)/build))

Multiple reviewers raised concerns about the automatic fallback to
/lib/modules/$(uname -r)/build. bpf_testmod relies heavily on internal BPF
structures, experimental macros, and kfuncs that change frequently between
kernel releases.

When compiling against host distro headers on a system where the running
kernel does not match the upstream source tree being tested, will this cause
confusing C compilation errors? If the host headers exist, the permissive
skip check further down in the Makefile will pass since the directory
exists. However, the compilation failure is not ignored by the parent
bpf/Makefile, which could abort the entire BPF selftests build with
confusing errors instead of silently skipping the unconfigured kernel tree.

Should in-tree test modules avoid falling back to host distro headers to
prevent these version mismatches?

This concern was raised by multiple reviewers (sashiko-bot, bot+bpf-ci) in
v9, v10, and v11. You acknowledged it in v10 and stated it's a deliberate
design choice inspired by livepatch, but the concern was raised again in
v11.

Reference: https://lore.kernel.org/bpf/f07336b357836aa0d9b5017f4bdf56969d6cb4044b8df5fd9dc67baf593b761e@mail.kernel.org/

>
>  ifeq ($(V),1)
>  Q =

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26821824931
--===============7318987521802235669==--
