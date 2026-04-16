Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828439448B;
	Thu, 16 Apr 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344627; cv=none; b=q/3njywddBWyN9PED7juP1ck/FgVZ9rYkkcO8O2H5IVaBgxhXt0kd26EflK3EqddcN868p+vu2G0e5Yn370fM6u73b+KrA1EKKTxhgtqC1CV/60WSvF23cGtDuMnaQiq28zUMnEkKaZSY+ypK+w0JGnS8fR9+hhjOmgi37V9b34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344627; c=relaxed/simple;
	bh=U+ZtfVg+btbC6MDDdBJb+AzYwUYtrSmejI1JsfZ0GCA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IgSE7fUyMsFsInIQRXlfOnt/RXHRmurj/sZQ8yoSJmNkQKGGMh3HrmPUCNQjbFsbYXblRy6UTWCNtu+ERGXKYgb8S7QB8hy3pEDN0/FHAXoEd6frtlw0DY5B0iPAmcxrh0fI+0qGvRXUzHPTeHtF2z46Ud4P6gbpqJD0jJrt7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLUrYLwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLUrYLwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1B6C2BCB3;
	Thu, 16 Apr 2026 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776344626;
	bh=U+ZtfVg+btbC6MDDdBJb+AzYwUYtrSmejI1JsfZ0GCA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aLUrYLwqaAH5AFR+W69v008J4xqFv512y05jBuTKEnGqkfyS9HPkryVxFx+hB8rYS
	 eLjWN//lDedwK5WgQkUoZBDdrQs6oQNu8EF15teHqGOsWgCoJ0kl8HVwseOqPbTa4+
	 ciwI+qE3tW8UYPmw2VBG7Fe1XkEYGNZxPPnvJZ1bkb1zhrdIo3jP33b/twOW76SUFP
	 5vtoI/JYZBCL0QrgWhd47d5kZfFE2MxnWEeXadUA4dwwogEy+aDIp9XkzzpN4qxCMV
	 yiERLA0LvYIfshhLq1FneZd+sp9r48r97uekfkvQ/LYmtm5cjj3jH84+qnPTc8oMMk
	 dxS+FLo7E+8cw==
Content-Type: multipart/mixed; boundary="===============5086334849017688193=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c666b0c8e3e085c57e6d75ac801c67f5c063c56f37b6542d4ca55ec001e433db@mail.kernel.org>
In-Reply-To: <20260416-selftests-bpf_misconfig-v6-8-7efeab504af1@suse.com>
References: <20260416-selftests-bpf_misconfig-v6-8-7efeab504af1@suse.com>
Subject: Re: [PATCH bpf-next v6 08/11] selftests/bpf: Allow test_progs to link with a partial object set
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 13:03:46 +0000 (UTC)

--===============5086334849017688193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5ad50d3ff2f8..79991dc98ddd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> -$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
> +$(OUTPUT)/$(TRUNNER_BINARY): $(if $(PERMISSIVE),,$(TRUNNER_TEST_OBJS))	\
>  			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\

[ ... ]

> -	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
> +	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)) $$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@

Does this duplicate every test object on the linker command line in
the default (non-PERMISSIVE) build?

When PERMISSIVE is not set, the $(if) on the prerequisite line
resolves to $(TRUNNER_TEST_OBJS), keeping them as normal
prerequisites. That means $^ already contains all test objects.

The $(if) in the recipe also resolves to $(TRUNNER_TEST_OBJS),
which is prepended before $$^. After expansion, the $(filter)
input becomes:

  $(TRUNNER_TEST_OBJS) $^
  ^^^^^^^^^^^^^^^^^^^^^
  already present in $^ as normal prerequisites

$(filter) does not deduplicate, so every .test.o file appears
twice in the linker arguments. With the default BPF_STRICT_BUILD=1
this would cause "multiple definition" errors from the linker for
all test entry points (test_arena_atomics, test_ringbuf, etc.).

The PERMISSIVE path looks correct because test objects are
order-only there and are excluded from $^, so the
$(wildcard ...) expansion is the only source.

One possible fix would be to omit the explicit
$(TRUNNER_TEST_OBJS) from the filter text in the non-PERMISSIVE
case, since $^ already carries them in the right order:

  $(filter %.a %.o,$(if $(PERMISSIVE),$(wildcard $(TRUNNER_TEST_OBJS))) $^)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24510378997
--===============5086334849017688193==--
