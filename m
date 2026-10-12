Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019AF357D0D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815228; cv=none; b=CA/cysICd3sECOCJqSlxwN7E5pLaTAqZf/WidYGVktWumlwBBes2VWfQ/RhvarjzDcbn6zJVQ1WOmG3TR3NUUXV0ENr0j1G/Rv3iHisA96/ZauDj4F8fIrvtStpNSqSxL6QSunSv99bigk8oK6CKORo0Or/BdfG03VjOVmrmtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815228; c=relaxed/simple;
	bh=epWnkuGzCMn1qHqcEWyIudEG8zh9BNSwwuiMEEmcgDU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YNTed9gkaGL2ZeZX6wwQoNdayWM7YPCB20ZzaK8UqalhhW5liJ/FeQ4V6rspRbS4b21lU9BLBb5TecxzJbYEoM9LCZSNma/C5Wqzq9jLxbXuIWbsGz8oZEo70LEguxXuulqBRVHeeVIQ3TQDMWyb+FMCOUuHSJzy6oZSb6q5UEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyndDhYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyndDhYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EDF1F0089B;
	Mon, 12 Oct 2026 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815226;
	bh=mlN+Pl8AxetWSC0+iO6+sdeLqeY1E/1q8qW1MpYCLPk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KyndDhYFyxFwrI2FZfHgo6maWzWU2Va6LdGwvGh8uWPB+nVgCu9AQo4VwWgwhRIMS
	 iDnXIG2unLcTuE3QRdP2YOwKzc0j48MU3utHqQ8L6LuaCSHPN7UvncMVQv0LrtqUB9
	 f7eIQd/niFh18yWG6T1St0f6VDRy7qWyEdILosJTfgae0J9DUjtCODwBSLP+Ou5rol
	 tSjNNxR7g9yHyzJLYq6bfMehHkqlf11q64i8y0FcM96iJOZrc7ZYNGkbgGmN7eTb/a
	 1x0BU/bsDX7y5EGAeLWPYpkdydRBSI/yp63JaFZgFDcJnoyyBU94+o81ly6oKMjPfk
	 9dXIYcDA5ZNRQ==
Content-Type: multipart/mixed; boundary="===============6858646837068833329=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ce4c8ae09d8d234e8a8357f852a7ee6884db1a08b24acac87e86c5a707899a2@mail.kernel.org>
In-Reply-To: <20261012133711.4030594-5-memxor@gmail.com>
References: <20261012133711.4030594-5-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] selftests/bpf: Test __nullable pointer members
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 14:27:04 +0000 (UTC)

--===============6858646837068833329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test __nullable pointer members

TL;DR: Test issue: on GCC-built kernels the "nullable" BTF tag is missing, so
the unchecked-pointer negative test struct_ops_nullable_fail would load and
fail instead of skipping; it should skip when the tag is absent.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
> new file mode 100644
> index 000000000000..fc52870782b7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c

[ ... ]

> +/* Serialized because it attaches the singleton bpf_testmod_ops3. */
> +void serial_test_struct_ops_nullable(void)
> +{
> +	if (test__start_subtest("nullable_member"))
> +		nullable_member();
> +	RUN_TESTS(struct_ops_nullable_fail);
> +}

Will struct_ops_nullable_fail fail instead of skip on kernels built with
GCC?

The "nullable" BTF type tag only reaches the bpf_testmod BTF when the
kernel is configured with CONFIG_PAHOLE_HAS_BTF_TAG, which depends on
CC_IS_CLANG:

    include/linux/compiler_types.h:
    #if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
            __has_attribute(btf_type_tag) && !defined(__BINDGEN__)
    # define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
    #else
    # define BTF_TYPE_TAG(value) /* nothing */
    #endif
    ...
    # define __nullable	BTF_TYPE_TAG(nullable)

    lib/Kconfig.debug:
    config PAHOLE_HAS_BTF_TAG
            def_bool PAHOLE_VERSION >= 123
            depends on CC_IS_CLANG

On a GCC-configured kernel, "struct task_struct __nullable *task_or_null"
in bpf_testmod.h is then a plain pointer in the module BTF, so
btf_struct_walk() never sets PTR_MAYBE_NULL for it.

check_ptr_to_btf_access() treats args->task_or_null as a plain PTR_TRUSTED
because bpf_testmod_nullable_args__safe_trusted lists the member, and the
unchecked bpf_task_acquire() in unchecked_nullable() passes the verifier:

    t = bpf_task_acquire(args->task_or_null);

The program loads, so the __failure __msg("Possibly NULL pointer passed to
trusted") expectation reports a failure.

The nullable_member subtest still passes in that setup, since the callback
checks the pointer either way, so only the negative test breaks.
.github/scripts/matrix.py defaults kernel_compiler to Compiler.GCC, and the
x86_64, aarch64 and s390x configs there build with GCC and run test_progs
and test_progs_no_alu32.

Other tests that depend on module BTF type tags skip when the tag is
missing.  For example, load_btfs() in prog_tests/btf_tag.c does:

    /* skip the test if the module does not have __user tags */
    type_id = btf__find_by_name_kind(*module_btf, "user", BTF_KIND_TYPE_TAG);
    if (type_id <= 0) {
            printf("%s:SKIP: btf_type_tag attribute not in %s", __func__,
                   module_name);
            test__skip();

Should serial_test_struct_ops_nullable() look up a "nullable"
BTF_KIND_TYPE_TAG in the bpf_testmod BTF the same way, and skip
struct_ops_nullable_fail when it isn't there?

No later commit in the series (1ae1456b867d..00e951183327) adds a skip or a
DENYLIST entry for this test.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38258617362
--===============6858646837068833329==--
