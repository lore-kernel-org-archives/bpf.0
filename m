Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166033921F8;
	Wed, 15 Apr 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289408; cv=none; b=IBXLle0ieAo2bmmO0BZQCl0fJnrqFCCIaeTFpAhB3YU/HqMKkLaiAW4TaTjQ/dn8ho0plo760IlP5zcf8zs/YuOkZYZE+eClAVbK1rnCjTx15ybo0ZYOErdcZ7HB91/+xLqg2hTdcxw901oCGyKHo+BrCPNDH3mx4PndN947zsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289408; c=relaxed/simple;
	bh=obmc4SWHIWxCv34BL9LEfyupN8SiiGhX+l0jmzbY/JQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SKRsnrm/8XmAY91k5tk5P6F0zhqK5x2Uzumb1l902d3JKNlh5JkHl/a/0jNEWOd9wQMpGZOpnk1HsvO8Av1CPdN75lIXFNwRLL8WpdAFcYHSNNEJL6q8KaQiYNBz/2UP/cItux92t9OxqWzRXBV1j7WSueX/t7Wy9J+pDQFfCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw2jaxw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw2jaxw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F798C19424;
	Wed, 15 Apr 2026 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776289407;
	bh=obmc4SWHIWxCv34BL9LEfyupN8SiiGhX+l0jmzbY/JQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mw2jaxw94HdNoG4n7PFesX2jIjm9cYJuQJOFefoQnU+Y4ck1t2t9gz3sLfSpajxI/
	 RR8wGwawsYkFYs8RwsIomkzrlKViqsEqsOsKYnvc9kv9U2X+EwwjMhrFmeFff35ciz
	 cB8n1DuMlRlG8Xp5YAtpDsSWMIf626uXcV2MmMc94AakwnuPr8Gckn9HzwWfRqc3N+
	 u37gKAgxbIhEkHpY4wOne+yQW2Aommc91aPg9O19dBu7GIlYhzmeqDCsQq5IpwnFY7
	 cvoj9XpymTScnlIqehrJFBThDHkOfaqeKIOg1kTpXAgez1IlmsfXv95IKA25eDEPSu
	 +umyrpWs7/d9A==
Content-Type: multipart/mixed; boundary="===============3871154906545698315=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b12f031c5c38bd0dbfc9cf3652ce0dc68f49f96ad2085c2747e0eeefaa7f6620@mail.kernel.org>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-3-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-3-03d0a52a898a@suse.com>
Subject: Re: [PATCH bpf-next v5 03/11] selftests/bpf: Tolerate BPF and skeleton generation failures
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Apr 2026 21:43:27 +0000 (UTC)

--===============3871154906545698315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 5c4cdf1dafc8..a305d13409e4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -598,47 +602,77 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:
>
>  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> -	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
> -	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
> -	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
> -	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@
> -	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h)
> -	$(Q)rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
> +	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
> +		exit 0;							\
> +	fi;)								\

When the .bpf.o prerequisite is missing during an incremental
permissive build, this exits 0 without removing $@ (.skel.h).
If a stale .skel.h remains from a previous successful build,
downstream targets will silently compile against it.

The commit message says "remove failed outputs so downstream rules
can detect absence" -- would adding $(RM) $$@ before exit 0 match
that intent?

> +	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
> +	$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$< &&		\
> +	$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o) && \
> +	$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o) && \
> +	diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o) &&		\
> +	$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@ && \
> +	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
> +		$$(RM) $$@ $$(@:.skel.h=.subskel.h); \
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
> +	}); \
> +	rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)

When PERMISSIVE is not set (strict mode, the default), the $(if)
block expands to nothing and this recipe becomes a single shell
command ending with:

    ... > $$(@:.skel.h=.subskel.h) ; \
    rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)

If bpftool or diff fails anywhere in the && chain, the shell skips
to the semicolon and runs rm -f, which always returns 0.  Make then
sees exit code 0 from the recipe and continues the build as though
skeleton generation succeeded.

The original code used separate $(Q)-prefixed recipe lines, where
make saw each command's exit code individually and would abort on
failure.

The same pattern appears in the TRUNNER_BPF_LSKELS,
TRUNNER_BPF_LSKELS_SIGNED, and TRUNNER_BPF_SKELS_LINKED rules.

One possible fix would be to capture the exit status before the
cleanup, for example:

    ... > subskel.h ; rc=$$?; \
    rm -f linked1.o linked2.o linked3.o; \
    exit $$rc

https://lore.kernel.org/bpf/20260415211532.A56BEC19424@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24478691588
--===============3871154906545698315==--
