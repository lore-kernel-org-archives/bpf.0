Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9F366823;
	Wed, 29 Apr 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475610; cv=none; b=TwVFck1i9l/aetpzJWF9N3M1ZxXl7gYHSab3ELGftwyoGVO3dOrRH37jnrzfkK/OwP7aEpIR/+AvlNXc3PTOf3jOpNd3GrJE9jg2Lb8BhbZap60bPUJqFrP/+hjtzFdNDF6zFkFMaRNsooFBaBRbA94p76q3twKTKhXGsfIpv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475610; c=relaxed/simple;
	bh=n5f2ixLZNRSBHxYtYWqzDjIrpTJYQNZPJFWrEwuX/Co=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W79zDtKqlpSAY6AF1MjvS/foMUTI4/PI8t/wLmbXo3CrOxp35opz4QmJ1lEPAIFs1PpbjxMzJkk/x+M7FuPDEVs6HZjygA5mTKgdaq8PFXhtbAFm0iZn8N1zSpc5cV0cjbjXTeA2QPMa6iUcmxiJhjt4IT0m3N6RFZuF8X1ZuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQWArXXR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQWArXXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DAC19425;
	Wed, 29 Apr 2026 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475610;
	bh=n5f2ixLZNRSBHxYtYWqzDjIrpTJYQNZPJFWrEwuX/Co=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FQWArXXRivRPMgBvWmZg/7xE2EnBsWbFCHOILoYxJURPu+yFPlUwo3tq5VrC7RhTA
	 DH0h8OjWQRYNZWwzNL3L3DZCNWwtGYDS3RhfIixjUXsE7N+hKb/K0Ok6tRWu91iwwg
	 yA0ICPdET3Xv5uhyxKEx0DYLGy9gEZVwJM56XIuiFYCeWwRntMsZgGfK0BIa3A3ta7
	 UqYSLoIOSMBDe8cJelisWGP2EoG1SXtPmb//Han0mwFj+BO10dA3RrRTYniNdT4IHm
	 bzqQrlNKi+SOobE6JRDPoXXLuhSHSBJikokgz7wTJYNRpsUR6aM/nF5hFFIM4sl5BN
	 6FZZmFQ9nyThg==
Content-Type: multipart/mixed; boundary="===============0411060881976129338=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0625d99bd069ff39efd2a3077ff84b7b0e7be5c2c3129bfbb4f7fc955a6aaae4@mail.kernel.org>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-3-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-3-c311f06b4791@suse.com>
Subject: Re: [PATCH bpf-next v9 03/11] selftests/bpf: Tolerate BPF and skeleton generation failures
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Apr 2026 15:13:29 +0000 (UTC)

--===============0411060881976129338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index cc6ee7a2df93..b104c687dcf0 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -607,47 +611,81 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
>  					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
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
> +		$$(RM) $$@ $$(@:.skel.h=.subskel.h);			\
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
> +		exit 0;							\
> +	fi;)								\
> +	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
> +	$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$< &&		\
> +	$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o) && \
> +	$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o) && \
> +	diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o) &&		\
> +	$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@ && \
> +	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
> +		$$(RM) $$@ $$(@:.skel.h=.subskel.h); \
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
> +	}) && \
> +	rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)

Does the permissive mode error handler only apply to the final command?

The TRUNNER_BPF_SKELS rule chains six commands together with &&:

    $(BPFTOOL) gen object $(<:.o=.linked1.o) $< &&
    $(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o) &&
    $(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o) &&
    diff $(<:.o=.linked2.o) $(<:.o=.linked3.o) &&
    $(BPFTOOL) gen skeleton ... > $@ &&
    $(BPFTOOL) gen subskeleton ... > $(@:.skel.h=.subskel.h) || { ... }

If any of the first five commands fail, the && chain breaks and the
recipe exits immediately with an error status, causing Make to abort the
build. The error handler (|| { $(RM) ...; printf 'SKIP-SKEL' ...; })
only catches failures from the final gen subskeleton command.

This appears to contradict the commit message, which states the intent is
to "continue with remaining tests" when generation fails. The same pattern
affects TRUNNER_BPF_LSKELS, TRUNNER_BPF_LSKELS_SIGNED, and
TRUNNER_BPF_SKELS_LINKED.

To fully implement permissive mode, would it make sense to attach the
error handler to the entire pipeline by wrapping the command sequence in
a subshell?

    ( cmd1 && cmd2 && ... ) || { error_handler }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25115689001
--===============0411060881976129338==--
