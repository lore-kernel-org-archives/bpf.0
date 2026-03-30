Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B203345CAF
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884608; cv=none; b=MnTK5wzj80SdXBUmiZsMBMr981f7P9k7kC1PyxGNM9Yds8AlB1CczkTwfZ/lfPpkJg4U9IIeecvHplO6WhSVAStlZyRLPUWNTLWYJzKZPkDKnbSX8hb3GNhLWyqcM/e3Ny4LfhQ9+quFtICMSHbVGoXihMju2k0Ir3SjI4MuDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884608; c=relaxed/simple;
	bh=G512egJYwYY65Fppm80cSEuCDCoVO+mvg+80YB8zD10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rwGjWOCbaqikNFyHfIkV+3Zy164DSzAo8fMjD/VnHMj6pXjlY61anDizc6oZRiAR2cA6NvInR6+8eNlof9CP+3bf9tauBzZxp+n7dD7InJG0QwXrEAq2KiY20ZI6c8Zc7ec8wKO0mpU24LsaCuajZuNgf2MEzIwZdMu8wkKq+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kort4RtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kort4RtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0898C4CEF7;
	Mon, 30 Mar 2026 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774884608;
	bh=G512egJYwYY65Fppm80cSEuCDCoVO+mvg+80YB8zD10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kort4RtIWzRAtbIvBjTcSwsvvnl5xMYUYmh1bQxDDLKgMcF11CEjqgKc53fk3EUPF
	 86tWk8aw7QZvldwURAst0VWHl4Q781MoQNziwBW5CJJSY1eEnsuZ4TghMeDxIF9gJ4
	 Dv1BqLu3igUBhS16w51pFm9Zs62HsTQAd8+8d/piG5oEIZreXGVa+jT4MS0HDalg9j
	 Jql16CnUyILDfvStntqtAoNmf60xbRV2iWyRVbRytQiG4WpYRkdhDdEiNOAgNxQczz
	 G5Xmmwaq12X+4/CNdDOKBy9s4a+f8KxTPebWWlM8Ea+eXgBmkbgVlKbpQrntnXWSAH
	 p9VZosMT7hZBA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, eddyz87@gmail.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test
 decl_tags
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
Date: Mon, 30 Mar 2026 16:30:03 +0100
Message-ID: <m2a4vppc78.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Impose global ordering for all decl tags used by test_loader.c based
> tests (__success, __failure, __msg, etc):
> - change every tag to expand as
>   __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
> - change parse_test_spec() to collect all decl tags before
>   processing and sort them using strverscmp().
>
> The ordering is necessary for gcc-bpf.
> Neither GCC nor the C standard defines the order in which function
> attributes are consumed. While Clang tends to preserve definition order,
> GCC may process them out of sequence. This inconsistency causes BPF
> tests with multiple __msg entries to fail when compiled with GCC.
>
> Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Checkpatch warns about this:

WARNING: Co-developed-by and Signed-off-by: name/email do not match
#19:
Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Add: 
Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
to fix this.

> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++-----
>  tools/testing/selftests/bpf/test_loader.c    | 174 +++++++++++++++------------
>  2 files changed, 130 insertions(+), 104 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 52cf9f3cccd0ccd8034b9786d787e53992a4a6d8..32e06c575fbe1f36264c8965cbd84e4432a434d8 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -130,39 +130,41 @@
>   * __linear_size     Specify the size of the linear area of non-linear skbs, or
>   *                   0 for linear skbs.
>   */
> -#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
> -#define __not_msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_not_msg=" XSTR(__COUNTER__) "=" msg)))
> -#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
> -#define __jited(msg)		__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
> -#define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
> -#define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
> -#define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
> -#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
> -#define __not_msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_not_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
> -#define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
> -#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited_unpriv=" XSTR(__COUNTER__) "=" msg)))
> -#define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
> -#define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
> -#define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
> -#define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
> -#define __retval(val)		__attribute__((btf_decl_tag("comment:test_retval="XSTR(val))))
> -#define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="XSTR(val))))
> -#define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
> -#define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
> -#define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
> -#define __arch(arch)		__attribute__((btf_decl_tag("comment:test_arch=" arch)))
> +#define __test_tag(tag)		__attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ":" tag)))
> +
> +#define __msg(msg)		__test_tag("test_expect_msg=" msg)
> +#define __not_msg(msg)		__test_tag("test_expect_not_msg=" msg)
> +#define __xlated(msg)		__test_tag("test_expect_xlated=" msg)
> +#define __jited(msg)		__test_tag("test_jited=" msg)
> +#define __failure		__test_tag("test_expect_failure")
> +#define __success		__test_tag("test_expect_success")
> +#define __description(desc)	__test_tag("test_description=" desc)
> +#define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
> +#define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
> +#define __xlated_unpriv(msg)	__test_tag("test_expect_xlated_unpriv=" msg)
> +#define __jited_unpriv(msg)	__test_tag("test_jited_unpriv=" msg)
> +#define __failure_unpriv	__test_tag("test_expect_failure_unpriv")
> +#define __success_unpriv	__test_tag("test_expect_success_unpriv")
> +#define __log_level(lvl)	__test_tag("test_log_level=" #lvl)
> +#define __flag(flag)		__test_tag("test_prog_flags=" #flag)
> +#define __retval(val)		__test_tag("test_retval=" XSTR(val))
> +#define __retval_unpriv(val)	__test_tag("test_retval_unpriv=" XSTR(val))
> +#define __auxiliary		__test_tag("test_auxiliary")
> +#define __auxiliary_unpriv	__test_tag("test_auxiliary_unpriv")
> +#define __btf_path(path)	__test_tag("test_btf_path=" path)
> +#define __arch(arch)		__test_tag("test_arch=" arch)
>  #define __arch_x86_64		__arch("X86_64")
>  #define __arch_arm64		__arch("ARM64")
>  #define __arch_riscv64		__arch("RISCV64")
>  #define __arch_s390x		__arch("s390x")
> -#define __caps_unpriv(caps)	__attribute__((btf_decl_tag("comment:test_caps_unpriv=" EXPAND_QUOTE(caps))))
> -#define __load_if_JITed()	__attribute__((btf_decl_tag("comment:load_mode=jited")))
> -#define __load_if_no_JITed()	__attribute__((btf_decl_tag("comment:load_mode=no_jited")))
> -#define __stderr(msg)		__attribute__((btf_decl_tag("comment:test_expect_stderr=" XSTR(__COUNTER__) "=" msg)))
> -#define __stderr_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stderr_unpriv=" XSTR(__COUNTER__) "=" msg)))
> -#define __stdout(msg)		__attribute__((btf_decl_tag("comment:test_expect_stdout=" XSTR(__COUNTER__) "=" msg)))
> -#define __stdout_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_stdout_unpriv=" XSTR(__COUNTER__) "=" msg)))
> -#define __linear_size(sz)	__attribute__((btf_decl_tag("comment:test_linear_size=" XSTR(sz))))
> +#define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
> +#define __load_if_JITed()	__test_tag("load_mode=jited")
> +#define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
> +#define __stderr(msg)		__test_tag("test_expect_stderr=" msg)
> +#define __stderr_unpriv(msg)	__test_tag("test_expect_stderr_unpriv=" msg)
> +#define __stdout(msg)		__test_tag("test_expect_stdout=" msg)
> +#define __stdout_unpriv(msg)	__test_tag("test_expect_stdout_unpriv=" msg)
> +#define __linear_size(sz)	__test_tag("test_linear_size=" XSTR(sz))
>  
>  /* Define common capabilities tested using __caps_unpriv */
>  #define CAP_NET_ADMIN		12
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index f1eb99f829e112f0e738bfe44e7e61a49120ec85..2779f0ecf0ada9985a5b1dfbc049c0d0ed824a76 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>  #include <linux/capability.h>
> +#include <linux/err.h>
>  #include <stdlib.h>
>  #include <test_progs.h>
>  #include <bpf/btf.h>
> @@ -20,34 +21,34 @@ static inline const char *str_has_pfx(const char *str, const char *pfx)
>  
>  #define TEST_LOADER_LOG_BUF_SZ 2097152
>  
> -#define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
> -#define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
> -#define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
> -#define TEST_TAG_EXPECT_NOT_MSG_PFX "comment:test_expect_not_msg="
> -#define TEST_TAG_EXPECT_XLATED_PFX "comment:test_expect_xlated="
> -#define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
> -#define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
> -#define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
> -#define TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV "comment:test_expect_not_msg_unpriv="
> -#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "comment:test_expect_xlated_unpriv="
> -#define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
> -#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
> -#define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
> -#define TEST_TAG_RETVAL_PFX "comment:test_retval="
> -#define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv="
> -#define TEST_TAG_AUXILIARY "comment:test_auxiliary"
> -#define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
> -#define TEST_BTF_PATH "comment:test_btf_path="
> -#define TEST_TAG_ARCH "comment:test_arch="
> -#define TEST_TAG_JITED_PFX "comment:test_jited="
> -#define TEST_TAG_JITED_PFX_UNPRIV "comment:test_jited_unpriv="
> -#define TEST_TAG_CAPS_UNPRIV "comment:test_caps_unpriv="
> -#define TEST_TAG_LOAD_MODE_PFX "comment:load_mode="
> -#define TEST_TAG_EXPECT_STDERR_PFX "comment:test_expect_stderr="
> -#define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "comment:test_expect_stderr_unpriv="
> -#define TEST_TAG_EXPECT_STDOUT_PFX "comment:test_expect_stdout="
> -#define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "comment:test_expect_stdout_unpriv="
> -#define TEST_TAG_LINEAR_SIZE "comment:test_linear_size="
> +#define TEST_TAG_EXPECT_FAILURE "test_expect_failure"
> +#define TEST_TAG_EXPECT_SUCCESS "test_expect_success"
> +#define TEST_TAG_EXPECT_MSG_PFX "test_expect_msg="
> +#define TEST_TAG_EXPECT_NOT_MSG_PFX "test_expect_not_msg="
> +#define TEST_TAG_EXPECT_XLATED_PFX "test_expect_xlated="
> +#define TEST_TAG_EXPECT_FAILURE_UNPRIV "test_expect_failure_unpriv"
> +#define TEST_TAG_EXPECT_SUCCESS_UNPRIV "test_expect_success_unpriv"
> +#define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "test_expect_msg_unpriv="
> +#define TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV "test_expect_not_msg_unpriv="
> +#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "test_expect_xlated_unpriv="
> +#define TEST_TAG_LOG_LEVEL_PFX "test_log_level="
> +#define TEST_TAG_PROG_FLAGS_PFX "test_prog_flags="
> +#define TEST_TAG_DESCRIPTION_PFX "test_description="
> +#define TEST_TAG_RETVAL_PFX "test_retval="
> +#define TEST_TAG_RETVAL_PFX_UNPRIV "test_retval_unpriv="
> +#define TEST_TAG_AUXILIARY "test_auxiliary"
> +#define TEST_TAG_AUXILIARY_UNPRIV "test_auxiliary_unpriv"
> +#define TEST_BTF_PATH "test_btf_path="
> +#define TEST_TAG_ARCH "test_arch="
> +#define TEST_TAG_JITED_PFX "test_jited="
> +#define TEST_TAG_JITED_PFX_UNPRIV "test_jited_unpriv="
> +#define TEST_TAG_CAPS_UNPRIV "test_caps_unpriv="
> +#define TEST_TAG_LOAD_MODE_PFX "load_mode="
> +#define TEST_TAG_EXPECT_STDERR_PFX "test_expect_stderr="
> +#define TEST_TAG_EXPECT_STDERR_PFX_UNPRIV "test_expect_stderr_unpriv="
> +#define TEST_TAG_EXPECT_STDOUT_PFX "test_expect_stdout="
> +#define TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV "test_expect_stdout_unpriv="
> +#define TEST_TAG_LINEAR_SIZE "test_linear_size="
>  
>  /* Warning: duplicated in bpf_misc.h */
>  #define POINTER_VALUE	0xbadcafe
> @@ -347,33 +348,54 @@ static void update_flags(int *flags, int flag, bool clear)
>  		*flags |= flag;
>  }
>  
> -/* Matches a string of form '<pfx>[^=]=.*' and returns it's suffix.
> - * Used to parse btf_decl_tag values.
> - * Such values require unique prefix because compiler does not add
> - * same __attribute__((btf_decl_tag(...))) twice.
> - * Test suite uses two-component tags for such cases:
> - *
> - *   <pfx> __COUNTER__ '='
> - *
> - * For example, two consecutive __msg tags '__msg("foo") __msg("foo")'
> - * would be encoded as:
> - *
> - *   [18] DECL_TAG 'comment:test_expect_msg=0=foo' type_id=15 component_idx=-1
> - *   [19] DECL_TAG 'comment:test_expect_msg=1=foo' type_id=15 component_idx=-1
> - *
> - * And the purpose of this function is to extract 'foo' from the above.
> +static const char *skip_decl_tag_pfx(const char *s)
> +{
> +	int n = 0;
> +
> +	if (sscanf(s, "comment:%*d:%n", &n) < 0 || !n)
> +		return s;
> +	return s + n;
> +}
> +
> +static void *realloc_or_free(void *ptr, size_t size)
> +{
> +	void *new = realloc(ptr, size);
> +
> +	if (!new)
> +		free(ptr);
> +	return new;
> +}
> +
> +static int compare_decl_tags(const void *a, const void *b)
> +{
> +	return strverscmp(*(const char **)a, *(const char **)b);
> +}
> +
> +/*
> + * Compilers don't guarantee order in which BTF attributes would be generated,
> + * while order is important for test tags like __msg.
> + * Each test tag has the following prefix: "comment:" __COUNTER__,
> + * when sorted using strverscmp this gives same order as in the original C code.
>   */
> -static const char *skip_dynamic_pfx(const char *s, const char *pfx)
> +static const char **collect_decl_tags(struct btf *btf, int id, int *cnt)
>  {
> -	const char *msg;
> -
> -	if (strncmp(s, pfx, strlen(pfx)) != 0)
> -		return NULL;
> -	msg = s + strlen(pfx);
> -	msg = strchr(msg, '=');
> -	if (!msg)
> -		return NULL;
> -	return msg + 1;
> +	const struct btf_type *t;
> +	const char **tags = NULL;
> +	int i;
> +
> +	*cnt = 0;
> +	for (i = 1; i < btf__type_cnt(btf); i++) {
> +		t = btf__type_by_id(btf, i);
> +		if (!btf_is_decl_tag(t) || t->type != id || btf_decl_tag(t)->component_idx != -1)
> +			continue;
> +		tags = realloc_or_free(tags, (*cnt + 1) * sizeof(*tags));
> +		if (!tags)
> +			return ERR_PTR(-ENOMEM);
> +		tags[(*cnt)++] = btf__str_by_offset(btf, t->name_off);
> +	}
> +
> +	qsort(tags, *cnt, sizeof(*tags), compare_decl_tags);
> +	return tags;
>  }
>  
>  enum arch {
> @@ -419,7 +441,9 @@ static int parse_test_spec(struct test_loader *tester,
>  	bool stdout_on_next_line = true;
>  	bool unpriv_stdout_on_next_line = true;
>  	bool collect_jit = false;
> -	int func_id, i, err = 0;
> +	const char **tags = NULL;
> +	int func_id, i, nr_tags;
> +	int err = 0;
>  	u32 arch_mask = 0;
>  	u32 load_mask = 0;
>  	struct btf *btf;
> @@ -442,20 +466,18 @@ static int parse_test_spec(struct test_loader *tester,
>  		return -EINVAL;
>  	}
>  
> -	for (i = 1; i < btf__type_cnt(btf); i++) {
> +	tags = collect_decl_tags(btf, func_id, &nr_tags);
> +	if (IS_ERR(tags))
> +		return PTR_ERR(tags);
> +
> +	for (i = 0; i < nr_tags; i++) {
>  		const char *s, *val, *msg;
> -		const struct btf_type *t;
>  		bool clear;
>  		int flags;
>  
> -		t = btf__type_by_id(btf, i);
> -		if (!btf_is_decl_tag(t))
> +		s = skip_decl_tag_pfx(tags[i]);
> +		if (!s)
>  			continue;

skip_decl_tag_pfx() can not return NULL so this check is dead code?

> -
> -		if (t->type != func_id || btf_decl_tag(t)->component_idx != -1)
> -			continue;
> -
> -		s = btf__str_by_offset(btf, t->name_off);
>  		if ((val = str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX))) {
>  			description = val;
>  		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
> @@ -478,27 +500,27 @@ static int parse_test_spec(struct test_loader *tester,
>  		} else if (strcmp(s, TEST_TAG_AUXILIARY_UNPRIV) == 0) {
>  			spec->auxiliary = true;
>  			spec->mode_mask |= UNPRIV;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
>  			err = push_msg(msg, false, &spec->priv.expect_msgs);
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= PRIV;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX))) {
>  			err = push_msg(msg, true, &spec->priv.expect_msgs);
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= PRIV;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
>  			err = push_msg(msg, false, &spec->unpriv.expect_msgs);
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV))) {
>  			err = push_msg(msg, true, &spec->unpriv.expect_msgs);
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= UNPRIV;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_JITED_PFX))) {
>  			if (arch_mask == 0) {
>  				PRINT_FAIL("__jited used before __arch_*");
>  				goto cleanup;
> @@ -510,7 +532,7 @@ static int parse_test_spec(struct test_loader *tester,
>  					goto cleanup;
>  				spec->mode_mask |= PRIV;
>  			}
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
>  			if (arch_mask == 0) {
>  				PRINT_FAIL("__unpriv_jited used before __arch_*");
>  				goto cleanup;
> @@ -522,13 +544,13 @@ static int parse_test_spec(struct test_loader *tester,
>  					goto cleanup;
>  				spec->mode_mask |= UNPRIV;
>  			}
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
>  			err = push_disasm_msg(msg, &xlated_on_next_line,
>  					      &spec->priv.expect_xlated);
>  			if (err)
>  				goto cleanup;
>  			spec->mode_mask |= PRIV;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
>  			err = push_disasm_msg(msg, &unpriv_xlated_on_next_line,
>  					      &spec->unpriv.expect_xlated);
>  			if (err)
> @@ -611,22 +633,22 @@ static int parse_test_spec(struct test_loader *tester,
>  				err = -EINVAL;
>  				goto cleanup;
>  			}
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDERR_PFX))) {
>  			err = push_disasm_msg(msg, &stderr_on_next_line,
>  					      &spec->priv.stderr);
>  			if (err)
>  				goto cleanup;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDERR_PFX_UNPRIV))) {
>  			err = push_disasm_msg(msg, &unpriv_stderr_on_next_line,
>  					      &spec->unpriv.stderr);
>  			if (err)
>  				goto cleanup;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX))) {
>  			err = push_disasm_msg(msg, &stdout_on_next_line,
>  					      &spec->priv.stdout);
>  			if (err)
>  				goto cleanup;
> -		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV))) {
> +		} else if ((msg = str_has_pfx(s, TEST_TAG_EXPECT_STDOUT_PFX_UNPRIV))) {
>  			err = push_disasm_msg(msg, &unpriv_stdout_on_next_line,
>  					      &spec->unpriv.stdout);
>  			if (err)
> @@ -706,9 +728,11 @@ static int parse_test_spec(struct test_loader *tester,
>  
>  	spec->valid = true;
>  
> +	free(tags);
>  	return 0;
>  
>  cleanup:
> +	free(tags);
>  	free_test_spec(spec);
>  	return err;
>  }
>
> -- 
> 2.53.0
