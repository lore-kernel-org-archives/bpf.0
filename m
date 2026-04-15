Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE7390238;
	Wed, 15 Apr 2026 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289406; cv=none; b=ibbGGIvcALcIusxw/yMoce8FQ1QY/RgU/uToiQcd2RoPFq6pKw6Q1x2CWgI2Isk38bbLK9225H0+Dkdq025h9rNvDAaZ4vdSyoWd+0Ssq0OXfv0A2I1nFVPy1jG96PJzpbNQk3fJrrXk2ynkJl1IQXd80N44uNhVKVV69F9pWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289406; c=relaxed/simple;
	bh=OoYgNc3AOiW3CdVABkUKCvdiBpRFB42ifM0+Ca/YzEc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t3J8F5Gyej3KL0G7WOEXPJ2STwjm18qqbYrFqiRFbz1lzoq7G09gt0zcQsCsSnjgzhkp+COvAfwStRHoATwQXYd1CA+Esbn7iNWfxRk5hxygOMws3oqW2BBQ6+3oknCu9yasem0KQe1vQU589aZfp3qXQnaZG57u08vlFdWMqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaBpYZ/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaBpYZ/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC3AC19424;
	Wed, 15 Apr 2026 21:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776289406;
	bh=OoYgNc3AOiW3CdVABkUKCvdiBpRFB42ifM0+Ca/YzEc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VaBpYZ/oj0+epfXYLygF2rSHMNoFOCrwgSLQ/FryzByDUTQXurtyxRORRrMoHpZEU
	 EOv9LTDeFRduCAnWkjHplXAZ+tKsT6swqJ+LhKL58d0T5cMsZP4OyYl9nj8rZqCajY
	 B1N5jYdyJ9iZwYVQpej+mUYP2O1sZ2sGGZI2vh9mTVMf1/BWPEeyfy2cjyvatDBXWg
	 42TkHACl0G4DircUZeIIj3LoNygqgmr4cptUYnN2z9PjytNUOHq0ySvdUf1bA+hW3A
	 lRuWEIFGQhIqHrIJf5SVXbYhdMVPE4vfNTCE23+FhH/SkVuwWq3u72tVOKIAb+GxFG
	 w72HvzkVxhcKQ==
Content-Type: multipart/mixed; boundary="===============8735550601232768486=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a248d30d421faaa0544802edb0f24f3002e8289132da202549f94ad11ba0fb5@mail.kernel.org>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-2-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-2-03d0a52a898a@suse.com>
Subject: Re: [PATCH bpf-next v5 02/11] selftests/bpf: Fix test_kmods KDIR to honor O= and distro kernels
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Apr 2026 21:43:25 +0000 (UTC)

--===============8735550601232768486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c8ba8ccc2c6d..5c4cdf1dafc8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -296,7 +296,7 @@ $(addprefix test_kmods/,$(subst .ko,%ko,$(TEST_KMODS))): $(VMLINUX_BTF) $(RESOLV
>
>  $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
>  	$(call msg,MOD,,$@)
> -	$(Q)cp test_kmods/$(@F) $@
> +	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/$(@F) $@$(if $(PERMISSIVE),; fi)

When permissive mode skips this cp because the .ko file was not built,
the target file under $(OUTPUT) is never created.  However,
TEST_KMOD_TARGETS is included in TRUNNER_EXTRA_FILES:

    TRUNNER_EXTRA_FILES := ...
                           $(TEST_KMOD_TARGETS)
                           ...

and the test_progs-extras rule passes those paths straight to rsync:

    $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
    ifneq ($2:$(OUTPUT),:$(shell pwd))
        $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
    endif

For out-of-tree builds (the exact scenario described in the cover
letter -- make -C tools/testing/selftests TARGETS=bpf
O=/lib/modules/$(uname -r)/build BPF_STRICT_BUILD=0), doesn't rsync
fail with "No such file or directory" on the missing .ko paths and
abort the build?

The later commit 671e16611575 ("selftests/bpf: Tolerate missing files
during install") adds --ignore-missing-args to the install rsync
rules, but does not patch this extras target.

Would adding --ignore-missing-args here as well (or filtering the
prerequisite list through $(wildcard)) be needed to make the
permissive out-of-tree path work end to end?

> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24478691588
--===============8735550601232768486==--
