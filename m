Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B737F742;
	Wed, 15 Apr 2026 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290096; cv=none; b=hZ+U++7s/9DN7mAbFT1I5zbBdkctkYea/6ccsbKC4yD4tjf/WD+u3Tsmgeflnq51azhA6IBsCPYk9NLhyt1PxPa+huEakCfIiCIjehKCbIarZZaQrYTh2cdD7G3y8pZfmpgOeEe0w9dhuiX0C2wA3VttKw/TNmzeFdbZ4aZ4KSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290096; c=relaxed/simple;
	bh=TZYFKbFO+bWgfI+VnjBD8YlmOVr1OUyHfh1/1awWrzQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SisNT13UrlGjJ3MyUTU2iXrAztvHkUx2N3FPV9Rz0AaQuxTf4kZEGQDldQ9kcX0RS8GmKakLtSJ2LZKiIi0dGCvN348isXNre5jrcMaYr3Ui1ZoRZ9lJNRwfMpTqzfPsWm6ajHYKXUhFEd6p7yKPqmAVSV+Z6u0Z8AwCG8JlWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhM+q2hh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhM+q2hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374EDC19424;
	Wed, 15 Apr 2026 21:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290095;
	bh=TZYFKbFO+bWgfI+VnjBD8YlmOVr1OUyHfh1/1awWrzQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GhM+q2hh7e6EsSX9fvSD37JJU8+QL6Nph36Ukot21F5hh+DZFS4AXFLLun6tAHPPX
	 q3uNINLhzsK6sZLJ19Sq14PsiGD0y9+NabbB6rAQfGD7UR2GGb1vNSWt9zsxVNWw+1
	 rgbQtYfN8BTMT4seC8yzSzDo8Mrz8KLIehjqnbVi5DebNZbTjQcbpZglM3FYtYVoZY
	 GZl5TiT1QDr8dbXFwtl1k7mmkAQ0n6ovBwkEkd4ZRNdLegvTVUd1AbsVzF/yP8abSO
	 JADzfx0jMBqjSIq8Bbe4DQkqvdwx541jCCVWjD92HtYHwHBbg8XGo7ZoAnEhmQ5tkT
	 t0JrU6NX5rkIw==
Content-Type: multipart/mixed; boundary="===============3319286475227976617=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <15b5d4de8ec1d989cc4d066c0ed1699deaa80562fefe0b13edba930fce880dcf@mail.kernel.org>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-7-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-7-03d0a52a898a@suse.com>
Subject: Re: [PATCH bpf-next v5 07/11] selftests/bpf: Allow test_progs to link with a partial object set
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Apr 2026 21:54:55 +0000 (UTC)

--===============3319286475227976617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index ee7bbfcd661b..128ea61fd986 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -754,14 +754,14 @@ endif
>  # some X.test.o files have runtime dependencies on Y.bpf.o files
>  $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
>
> -$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
> -			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
> +$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
>  			     $(TRUNNER_LIB_OBJS)			\
>  			     $(TRUNNER_BPFTOOL)				\
>  			     $(OUTPUT)/veristat				\
> -			     | $(TRUNNER_BINARY)-extras
> +			     | $(TRUNNER_BINARY)-extras			\
> +			     $(TRUNNER_TEST_OBJS)

Does moving TRUNNER_TEST_OBJS to the order-only prerequisite list
break incremental builds in the default (BPF_STRICT_BUILD=1) case?

Order-only prerequisites ensure build ordering but do not cause the
target to be rebuilt when they are updated.  If a developer edits a
test source file, the corresponding .test.o is correctly recompiled
via the pattern rule and .d dependencies, but because
TRUNNER_TEST_OBJS is no longer a normal prerequisite of
$(OUTPUT)/$(TRUNNER_BINARY), the binary will not be relinked to
pick up the new object.  The developer would need to run make clean
or touch a normal prerequisite to get the updated test code linked
into the binary.

>  	$$(call msg,BINARY,,$$@)
> -	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> +	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)) $$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@

When PERMISSIVE is set and some .test.o files are absent, the
resulting binary still contains entries in the prog_test_defs[]
array for the missing tests (via tests.h and __weak symbols), but
both run_test and run_serial_test resolve to NULL.  The existing
validation in test_progs.c main():

    if ((test->run_test == NULL && test->run_serial_test == NULL) ||
        (test->run_test != NULL && test->run_serial_test != NULL)) {
            ...
            exit(EXIT_ERR_SETUP_INFRA);
    }

will abort the entire test run.  This is addressed later in the
series by commit ec7dae68360b ("selftests/bpf: Skip tests whose
objects were not built"), which replaces the abort with a skip
marker.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24478691588
--===============3319286475227976617==--
