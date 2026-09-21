Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C23750D5
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982530; cv=none; b=UGjAUcWCKmTT0RWGZxJ4bbxiXwGBTaVJWPoj4H72+m1EQZdrZLnLARTSBVnbYAjHyRuDmu/B8CHG4WRtN+k4khdbsm/HhiPu+0uN7hfoObs6ghdcevErLwys5j9SKghyS3A3yG5Q2NyACJDuWxFzVkahQblaw/YjhxSwZFurmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982530; c=relaxed/simple;
	bh=b+nb+6pmFUHzeT1WLBkxbkm6bq+OTl8sDyhPAdUvy+k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F1E1Xy7oBKNLDm1zlGzpB3y7MLEA4ayj1eErK/TCgqQx7wsCUdYpXkjh9vQfmHYygpm4A/ueIwrgeu3WHRRAdZ8KJFaG3QIHDLx0GJ1BgfATh2vUQ5hY/smMEzCmD/nKUGfzLNnMMD0ziZrqA+S7Di9gxhkPI61tuEOKPVVjyBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaWtOJAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaWtOJAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F46F1F000FF;
	Mon, 21 Sep 2026 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982528;
	bh=VssJ4ZW5JglZM8dA+YuAZxmjQ22k/CtixoVATYN8SuA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iaWtOJAkrQ8eAdT4xpNBcU24GdrrMBDpNoeAxAQ3jAPPZSY/yQ8yWzBFb/De2M+gR
	 sbmD7hJjk0CyxjwE/wJ868rmVvLtZ+FcZefHOYbu1ikVxxS+wplgL1mBRGG+KIx2Q8
	 TF7Q9Qu0d6Sp3rJO9l/Vn2gU5HyqBV+xCERMQocJWTVbxJ/7l1OcFQFazipkwEhxPZ
	 tnJOYMRH54RYEfZWD8qhsq2ZOEqbRRjAjV0k1M+T3h8Qg3HfXBjMyW6GiX7Y8XjyDg
	 tPwpJfAezDvl5b/dEB3MyYrYb5lL9LDtKVIAL5l6yIyQPBRL6o+XOZ/zGUL6VDwKIH
	 c/v5dQiVXSgWg==
Content-Type: multipart/mixed; boundary="===============3860847443415516457=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a242ffd77138377c8726e5a7e52609fbe0352e8cc4a3b9efe48eecf566057cc4@mail.kernel.org>
In-Reply-To: <20260921075855.2065871-10-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-10-nickolay.lysenko@gmail.com>
Subject: Re: [PATCH bpf-next v8 9/9] selftests/bpf: build each test runner instance in its own sub-make
From: bot+bpf-ci@kernel.org
To: nickolay.lysenko@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,memxor@gmail.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 09:22:06 +0000 (UTC)

--===============3860847443415516457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testing/selftests/bpf/Makefile.runner
> new file mode 100644
> index 0000000000000..d266c42468882
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/Makefile.runner
> @@ -0,0 +1,125 @@

[ ... ]

> +# Permissive build behaviour (skip-on-failure compile, partial-link) only
> +# applies to test_progs and its flavors; runners that use strong cross-object
> +# references (e.g. test_maps) keep strict semantics even when permissive.
> +PERMISSIVE_TESTS := $(if $(filter test_progs,$(RUNNER)),$(PERMISSIVE))

[ ... ]

> +# compile individual test files
> +# Note: we cd into output directory to ensure embedded BPF object is found
> +# The %.test.d dependency files are a side effect of the -MMD below; the
> +# separate no-recipe rule for them orders the first compilation after
> +# skeleton generation and re-orders test object compilation when headers
> +# change.
> +$(TEST_OBJS): $(RDIR)/%.test.o: $(TESTS_DIR)/%.c | $(RDIR)/%.test.d
> +	$(call msg,TEST-OBJ,$(BINARY),$@)
> +	$(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< $(LDLIBS) -o $(@F)) $(if \
> +		$(PERMISSIVE_TESTS),$(call skip_on_fail,TEST))

Does the backslash placement here cause the $(if) condition to be
unconditionally true?

The backslash-newline sits inside the $(if ...) call between the
function name and its first argument. GNU make preserves
backslash-newline in recipe lines (so the shell can join continued
commands), and does not strip whitespace from the condition string
before testing it. The raw condition text becomes '\' + newline +
tabs + '$(PERMISSIVE_TESTS)', and since a backslash is not
whitespace, the condition string is never empty.

This means $(call skip_on_fail,TEST) is always appended, regardless
of PERMISSIVE_TESTS. The guard collapses to permissive for every
runner, including test_maps, contradicting the comment at line 50
that says permissive build behavior only applies to test_progs.

With BPF_STRICT_BUILD=0, a map_tests/*.c file that fails to compile
would now report success, have its .o deleted by skip_on_fail, and
then fail later in the test_maps link with 'No such file or
directory' for the removed object, instead of failing at compile
with the real diagnostic.

Moving the continuation to complete the condition on the first line
would fix this:

	$(Q)(cd $(@D) && $(CC) -I. $(CFLAGS) -MMD -MT $@ -c $(CURDIR)/$< $(LDLIBS) -o $(@F)) \
		$(if $(PERMISSIVE_TESTS),$(call skip_on_fail,TEST))


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35577680350
--===============3860847443415516457==--
