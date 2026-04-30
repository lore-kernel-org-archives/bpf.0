Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFFB477E2D;
	Thu, 30 Apr 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567324; cv=none; b=PiCSxp8a0ICAJ+q265ASubj2Ck6Jjn1x/McglSSZV35R2Q76RWc3IM9ag63NHIubXLfXZYQNH7OQLj4BC8FjiMf/hgAlIEg3/D/kPi5IecNo8zKol13TbvmjEDEdbUqYMKhwrJkwtwFUtWxm2NjHNtesy8MsjATxpqrBnRHFVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567324; c=relaxed/simple;
	bh=p4T/P+cg/+Opc0jMFVbXpIndKd5hyRAAi2QVvcmPkao=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cOkvFI66TYKXG9AqKKP9bxjJs4uNhpa++uZpPRMYrRTLEJJxk1nGewQiAF75AzgojgWhGo+i5xnPIS7i3t7VDYKM1xGU5ET0Wd3uFItO4IIYIwpxgJXMqXN6HpnIQSgGWchfgQpZMAApgYeiZqLONug7LeyqnO0XKDX0wvgiN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l41aP/nC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l41aP/nC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ACCC2BCB3;
	Thu, 30 Apr 2026 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567323;
	bh=p4T/P+cg/+Opc0jMFVbXpIndKd5hyRAAi2QVvcmPkao=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=l41aP/nCKVEvjEtcCuk0FP679QF+oR6VmiNTV3WBNKbJTyGabRcbMjIq5A0iH7J4U
	 WZvPnAL5Yri+vk3VQlCjgoI5qu5ONE35KswnB/1WLCaoK/BvKJHx+JCAmMeZ3K23Qy
	 3uM5Wpw9dtBk3ayjwr1b6CPaI8+k33IhPIGeE1TdWEmOZZU39JX0jUhN9OTIY3mp6/
	 QZUjlen4GUjA9ocT63bHqGsR0HRgpOcBsjSYSNNpiBllZN0tw6PeV5CiMfa/LAPdgE
	 jEvew7z3xTiQfSMZaRJkR9Sw7vEViVPAZ7hEqZGKeydQtDybtk0Fux99gnDy+3DQDR
	 6vDkE7VbAvD9Q==
Content-Type: multipart/mixed; boundary="===============3289116302628097459=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f07336b357836aa0d9b5017f4bdf56969d6cb4044b8df5fd9dc67baf593b761e@mail.kernel.org>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-2-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-2-e11f7a8c4fdc@suse.com>
Subject: Re: [PATCH bpf-next v11 02/11] selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 16:42:00 +0000 (UTC)

--===============3289116302628097459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6094fe99b5f6..cc6ee7a2df93 100644
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

Will the automatic fallback to /lib/modules/$(uname -r)/build cause
confusing build failures?

Since bpf_testmod relies heavily on internal BPF structures, experimental
macros, and kfuncs that change frequently between kernel releases, compiling
it against host distro headers on a system where the running kernel does not
match the upstream source tree will likely fail.

If the host headers are present, the permissive skip check further down in
the file will pass since the directory exists. However, because the
compilation failure is not ignored by the parent bpf/Makefile, this would
abort the entire BPF selftests build with confusing C compilation errors
instead of silently skipping the unconfigured kernel tree.

Should in-tree test modules avoid falling back to host distro headers to
prevent these version mismatches?

This concern was raised in v9 and v10 by bot+bpf-ci@kernel.org and
sashiko-bot@kernel.org:

  "Will falling back to the host kernel headers cause compilation errors
  when building in-tree test modules like bpf_testmod? Since bpf_testmod
  relies heavily on internal BPF structures, experimental macros, and
  kfuncs that change frequently between kernel releases, compiling it
  against /lib/modules/$(uname -r)/build on a system where the running
  kernel does not exactly match the upstream source tree will likely fail.
  If the host headers are present, the permissive skip check further down
  in the file will pass since the directory exists. Because the compilation
  failure is not ignored by the parent bpf/Makefile, won't this abort the
  entire BPF selftests build with confusing C compilation errors instead of
  silently skipping the unconfigured kernel tree? Should in-tree test
  modules avoid falling back to host distro headers to prevent these
  version mismatches?"

Reference: https://lore.kernel.org/bpf/d1297f1c857e5430af42dcb3e4d05c7ddaff08470a43893cac0fbcb83ec51666@mail.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25176431268
--===============3289116302628097459==--
