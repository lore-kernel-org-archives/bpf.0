Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A192C3255;
	Fri,  3 Apr 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230311; cv=none; b=mGxUvr51YWH8iIZTsw0ok1AL5Fl/V8UNS9p/WhHFR+7itmC6BqiWb+34pM7kma3Ao8ekmKg/+hUXWtxBwFvdFGjEYDbWT4TJcgnEXYCNzWP+qRXUxOy969//x/3i1FGflmzshI/qgLRlFJ2Mrfbtff07X55cySvjAS+sFoqXNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230311; c=relaxed/simple;
	bh=agMln0ujWJSLy5SV56SLKyuGqXBTlsDf1LetTYGjGVY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lkLoWMe+vzJ4ZpJFKnbZ4svQu08yTccwmyGB+SAPlT9yIY4tRHVxcpkgxU4Stc8YyfXbrg+QDsKOseMPmAyAFItKSK3pLLL/t5jqWH2B2XOLwPhvYL1ZmILDRm1uMhsIYypuO9MQPA5UXW8P3yI/WkTDWaZju1ZEwaxZw5yrEP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOGJTs6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOGJTs6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99222C4CEF7;
	Fri,  3 Apr 2026 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775230311;
	bh=agMln0ujWJSLy5SV56SLKyuGqXBTlsDf1LetTYGjGVY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TOGJTs6tfRz9Vpg2ljzZygZClY5fjXKpgQgTEUJ8qkyvPs+gx3ihDyRTd68n2YeAO
	 FdLD7CRfPla9DEc7jKRvvt0RwfgXeJ/WatL9Ep36Z31T6aAtwTg8QH467fELeugfkv
	 NYG3HjAaRV9/ChvYXvu3IkpFoq0/tPtQEbuN6Zg0UPGRSjZfax9KD5Bs+l8vcSdXDc
	 3aN1ua8J0GuKPoPXVBWWS+d9J4GagucXPzCMWV44BECbUj/LWMeqc89jHYZFrKHmqI
	 EIm//2fh0RKa1AVf41HUX61ICqi3T4wh07H8pMWX9vaiTeB9Fn3aEZtG4n44kMhNdN
	 joA+nCk1fq8vA==
Content-Type: multipart/mixed; boundary="===============5395896508885707630=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e31cce2c29bdf1172acb1b8aff046729ef5b0b20ffed3c276fcf62261a94ccca@mail.kernel.org>
In-Reply-To: <20260403-selftests-bpf_misconfig-v2-5-f06700380a9d@suse.com>
References: <20260403-selftests-bpf_misconfig-v2-5-f06700380a9d@suse.com>
Subject: Re: [PATCH v2 05/10] selftests/bpf: Tolerate test file compilation failures
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 15:31:50 +0000 (UTC)

--===============5395896508885707630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 72f576a8236a..6a3835a58f87 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> @@ -688,11 +688,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
>  		      $(TRUNNER_TESTS_DIR)/%.c				\
>  		      | $(TRUNNER_OUTPUT)/%.test.d
>  	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> -	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
> +	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F) || \
> +		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)
>  	$$(if $$(TEST_NEEDS_BTFIDS),						\
> +		if [ -f $$@ ]; then						\
>  		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
>  		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
> -		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
> +		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
> +		fi)

When TEST_NEEDS_BTFIDS is set (for resolve_btfids.test.o) and the
object file exists, does the msg macro interact correctly with the
new if guard?

The msg macro in lib.mk expands to:

    msg = @printf '  %-8s%s %s%s\n' ...;

Before this change, $$(call msg,BTFIDS,...) was the first thing in the
$(if) body, so the @ ended up at the start of the recipe line where
make treats it as a "don't echo" prefix and strips it before passing
the command to the shell.

With the if [ -f $$@ ] guard inserted before the msg call, the recipe
line now starts with "if" instead of "@".  Make passes the literal
@printf to the shell, which tries to find a command named @printf:

    /bin/sh -c "if [ -f file ]; then @printf '...' ...; resolve_btfids ...; fi"

This produces a "command not found" error on stderr during every
non-verbose build of resolve_btfids.test.o.  The BTFIDS processing
itself still runs because the semicolons cause the subsequent commands
to execute regardless, but the spurious error is confusing.

One possible fix would be to move the msg call before the if guard,
or strip the @ from the msg expansion when used inside shell control
flow.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23951016185
--===============5395896508885707630==--
