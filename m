Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B23624D4
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884724; cv=none; b=E/rB3CKi/QXdV05XS2S7uVT9X3vDddlZcmuLI5lH+zhLrozxClvc3po658BC+ukbbci2Ew7oB++0EuMSrAHOOUo/9oHr+i6YTZSMm+3K0zR3pifvI0o4m1FKYti2Ue9J8gpevaynXig9fEafxN4nD+FmYrQ4Yi8Olc0UteZAY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884724; c=relaxed/simple;
	bh=jVKBe5ObxmysQMcv666ZU6CKAhJry/u63IwKjTTomKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ADkYW+4Aku2IAgE3BqYbHkXrwBS2IFIEf2HRApwasNz35pP49AVGP8df8mFO0/sIt6wMq0OtHyPTb/vu92RMtNRPL02d2PcwcLp5kbD55kv+Isj0u7oxVft5dlwwHkOKy2GBxUWV1uto4MfqYR8TydH5dQ/MlSiAiwkIoPVt/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbrRjjwO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbrRjjwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A668C4CEF7;
	Mon, 30 Mar 2026 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774884723;
	bh=jVKBe5ObxmysQMcv666ZU6CKAhJry/u63IwKjTTomKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UbrRjjwOSFWuxqMpZHWtzsoBlPo9jvfMusZRVmkw4lPbkclZxub9YZNLyeQv4UD6O
	 DC8IW6ITTcV9wyUPwGZNDyy3ZX1b0gtc7KitJcwDghvbhgmWsaxyz4wPSMNJZXIPaX
	 VQz/t7wxL/h426JZJKFtmjdtgdCmf44kKLi2mbI5hOmLmCDbe2d9PA47DKrwRNF0IA
	 dLebDrwtUnkubi3TS+iHR0VBte5Fk4tTnZbHdYeh943QWTbo2BWJkLN1g26P4TrEhV
	 FJFCL74xiNHO8NekDQErFuZPgs8SQw+1z1/JVzyF1GbXKDgMwW36OtepsV/pPd7kuY
	 ph4lOopOO3MYQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, eddyz87@gmail.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH 2/4] selftests/bpf: make str_has_pfx return pointer past
 the prefix
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-2-5dd2ced5d9ad@gmail.com>
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-2-5dd2ced5d9ad@gmail.com>
Date: Mon, 30 Mar 2026 16:32:00 +0100
Message-ID: <m27bqtpc3z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Change str_has_pfx() to return a pointer to the first character after
> the prefix, thus eliminating the repetitive (s + sizeof(PFX) - 1)
> patterns.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_loader.c | 41 ++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 338c035c36884c02ac57cd17110122c10b4858e4..f1eb99f829e112f0e738bfe44e7e61a49120ec85 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -11,8 +11,12 @@
>  #include "cap_helpers.h"
>  #include "jit_disasm_helpers.h"
>  
> -#define str_has_pfx(str, pfx) \
> -	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
> +static inline const char *str_has_pfx(const char *str, const char *pfx)
> +{
> +	size_t len = strlen(pfx);
> +
> +	return strncmp(str, pfx, len) == 0 ? str + len : NULL;
> +}
>  
>  #define TEST_LOADER_LOG_BUF_SZ 2097152
>  
> @@ -452,8 +456,8 @@ static int parse_test_spec(struct test_loader *tester,
>  			continue;
>  
>  		s = btf__str_by_offset(btf, t->name_off);
> -		if (str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX)) {
> -			description = s + sizeof(TEST_TAG_DESCRIPTION_PFX) - 1;
> +		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
> +			description = val;
>  		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
>  			spec->priv.expect_failure = true;
>  			spec->mode_mask |= PRIV;
> @@ -530,29 +534,24 @@ static int parse_test_spec(struct test_loader *tester,
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
> -			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX))) {
>  			err = parse_retval(val, &spec->priv.retval, "__retval");
>  			if (err)
>  				goto cleanup;
>  			spec->priv.execute = true;
>  			spec->mode_mask |= PRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV)) {
> -			val = s + sizeof(TEST_TAG_RETVAL_PFX_UNPRIV) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV))) {
>  			err = parse_retval(val, &spec->unpriv.retval, "__retval_unpriv");
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
>  			spec->unpriv.execute = true;
>  			has_unpriv_retval = true;
> -		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
> -			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX))) {
>  			err = parse_int(val, &spec->log_level, "test log level");
>  			if (err)
>  				goto cleanup;
> -		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
> -			val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
> -
> +		} else if ((val = str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX))) {
>  			clear = val[0] == '!';
>  			if (clear)
>  				val++;
> @@ -577,8 +576,7 @@ static int parse_test_spec(struct test_loader *tester,
>  					goto cleanup;
>  				update_flags(&spec->prog_flags, flags, clear);
>  			}
> -		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
> -			val = s + sizeof(TEST_TAG_ARCH) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_ARCH))) {
>  			if (strcmp(val, "X86_64") == 0) {
>  				arch = ARCH_X86_64;
>  			} else if (strcmp(val, "ARM64") == 0) {
> @@ -596,16 +594,14 @@ static int parse_test_spec(struct test_loader *tester,
>  			collect_jit = get_current_arch() == arch;
>  			unpriv_jit_on_next_line = true;
>  			jit_on_next_line = true;
> -		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
> -			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
> -		} else if (str_has_pfx(s, TEST_TAG_CAPS_UNPRIV)) {
> -			val = s + sizeof(TEST_TAG_CAPS_UNPRIV) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_BTF_PATH))) {
> +			spec->btf_custom_path = val;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_CAPS_UNPRIV))) {
>  			err = parse_caps(val, &spec->unpriv.caps, "test caps");
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
> -		} else if (str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX)) {
> -			val = s + sizeof(TEST_TAG_LOAD_MODE_PFX) - 1;
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LOAD_MODE_PFX))) {
>  			if (strcmp(val, "jited") == 0) {
>  				load_mask = JITED;
>  			} else if (strcmp(val, "no_jited") == 0) {
> @@ -635,12 +631,11 @@ static int parse_test_spec(struct test_loader *tester,
>  					      &spec->unpriv.stdout);
>  			if (err)
>  				goto cleanup;
> -		} else if (str_has_pfx(s, TEST_TAG_LINEAR_SIZE)) {
> +		} else if ((val = str_has_pfx(s, TEST_TAG_LINEAR_SIZE))) {
>  			switch (bpf_program__type(prog)) {
>  			case BPF_PROG_TYPE_SCHED_ACT:
>  			case BPF_PROG_TYPE_SCHED_CLS:
>  			case BPF_PROG_TYPE_CGROUP_SKB:
> -				val = s + sizeof(TEST_TAG_LINEAR_SIZE) - 1;
>  				err = parse_int(val, &spec->linear_sz, "test linear size");
>  				if (err)
>  					goto cleanup;
>
> -- 

Nit: Other users of str_has_pfx() can also be updated?:

--
148:            if (!in_regex && str_has_pfx(pattern, "{{")) {
149-                    in_regex = true;
150-                    pattern += 2;
151-                    continue;
--
153:            if (in_regex && str_has_pfx(pattern, "}}")) {
154-                    in_regex = false;
155-                    pattern += 2;
156-                    continue;
--
