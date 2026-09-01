Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AC48F84F;
	Tue,  1 Sep 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285342; cv=none; b=ZX7bYMhxuZSQcqZKeMmUssJMwAGtNp1Ev+4P08ZBt0rV/dMpU9mlsvms1cjQE4AFzE62pzUFnDjLNiZmoVTYSSoYyjfrFMHjKtserC+hpS1PQoO8cC1902V/NVIK9AvQAVC/ZSRCcrRkBA+echejZitlda5ml1dtE7lrSlaaP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285342; c=relaxed/simple;
	bh=qUdPoUjJgV42HsqsUrDqZlP6inli/i3WRFVaCkMqm6w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c8diWX1k6XJCfhK+8ltQwLad5WxkzA0cUr+w0NA/p1Vl7WnvASULwqq2Y8jPUCvlIZ21iE1Rd+hRS603Iudd47lk2Y0W8Ujlp2L+InULodWyjFztsM5arHXh+aztxVZlQ1QnfQYf9M4LegF0M/3414ALm+XpjeOK+Zh6ol5N0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfxNANmG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfxNANmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFED1F00A3D;
	Tue,  1 Sep 2026 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285340;
	bh=uxxV774cd40lwJQfHa4N6D5cVQzIUpegw4ZPnJlZznE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nfxNANmG0bUimDYItNGckfRUfKktZO0HpAAftutXAbYmkSO9Wp0G4fNvNXYeGhwih
	 gWtLfSOwMHg8QgFj7nJ+DI1zP8BfzK0Mbby9jOKEuMdCeCKvJrOz0kSOxpiFSCtpJj
	 aGf7gPFM2G6MhFz1OiNYuZTK+5Z8PjFNJ/fE9AXUSx5Pd9VVifny4kZLPp3S/ZRUgk
	 KI8Bqo+W5zTHz0Yu77l4hJ2eUwa+C66XrvL8X3aEQoWTj6nbd7Z2nxBpY0Yyd8BSfO
	 xm3AwTS+eJZ0o/8X7qMotfRVAs5dDqI+SdVJOTPJS2rkuuBOFPdYdqKShNPhq1ksjx
	 jGoNkUvETCprA==
Content-Type: multipart/mixed; boundary="===============4623552170929007387=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac46a44fcde3b8e92949cb3f78cd4a58fc316de8a938fadcb0662c370babb1c9@mail.kernel.org>
In-Reply-To: <20260901165757.801449-19-alan.maguire@oracle.com>
References: <20260901165757.801449-19-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 18/18] selftests/bpf: Add a test verifying inline information
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:39 +0000 (UTC)

--===============4623552170929007387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_inline.c b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
> new file mode 100644
> index 000000000000..8e0a85f6c698
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026, Oracle and/or its affiliates. */
> +
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf.h>
> +
> +#define BTF_SYSFS_DIR		"/sys/kernel/btf"
> +#define BTF_INLINE_SUFFIX	".inline"
> +
> +/*
> + * For a specific inline site, verify we have the right function,
> + * loc proto and loc param representation and that the offset is
> + * reasonable given the caller where it was inlined.
> + *
> + * Because bpf_testmod is compiled "out-of-tree" we have inline
> + * information in the split BTF directly rather than in btf_testmod.inline.
> + */

The comment states the inline information is "in the split BTF directly
rather than in btf_testmod.inline", but the code below parses
"/sys/kernel/btf/bpf_testmod.inline", which is exactly the file the
comment says is not used:

> +	inline_btf = btf__parse_split(BTF_SYSFS_DIR "/bpf_testmod" BTF_INLINE_SUFFIX,
> +				      btf);

The commit message agrees with the code ("the inline information will be
in btf_testmod.inline which is relocated using bpf_testmod.ko .BTF.base"),
so the in-file comment appears to be inverted.

> +void test_btf_inline(void)
> +{

[ ... ]

> +	inline_btf = btf__parse_split(BTF_SYSFS_DIR "/bpf_testmod" BTF_INLINE_SUFFIX,
> +				      btf);
> +	err = libbpf_get_error(inline_btf);
> +	/* pahole may not have inline BTF feature support. */
> +	if (err == -ENOENT) {
> +		skip = true;
> +		goto out;
> +	}
> +	locsec_id = btf__find_by_name_kind(inline_btf, ".text", BTF_KIND_LOCSEC);

Can inline_btf be NULL here? btf__parse_split() returns libbpf_ptr() of
the btf_parse() result, and libbpf_ptr() returns NULL with errno set for
errors other than -ENOENT. If btf__parse_split() fails with -EINVAL,
-EPROTO, -ENOMEM or -EPERM (malformed BTF, allocation failure, restricted
read), inline_btf is NULL and err is not -ENOENT, so the code falls
through and calls btf__find_by_name_kind(NULL, ...), which dereferences
the NULL pointer in btf__type_cnt().

Every other pointer in this function is checked with ASSERT_OK_PTR(); this
is the only exception. This matters because the test is meant to catch
malformed inline BTF from earlier commits in the series, but the crash
kills test_progs and takes every remaining test with it instead of
recording a test failure.

> +	p = btf_loc_proto_params(t);
> +	t = btf__type_by_id(inline_btf, *p);
> +	lp = btf_loc_param(t);
> +	if (!ASSERT_EQ(lp->flags, BTF_LOC_PARAM_REG, "param_is_reg"))

The second btf__type_by_id() result is used without the ASSERT_OK_PTR()
check that the first call three lines earlier receives. btf__type_by_id()
returns NULL for an out-of-range id, and btf_loc_param(t) is just
'(struct btf_loc_param *)(t + 1)', so lp->flags reads address 4 and
crashes.

There's also a legal-input case: the BTF spec allows a LOC_PROTO
parameter id to be 0 (meaning "no location info"). For *p == 0, libbpf
returns &btf_void, and lp->flags then reads past that static object,
producing a confusing failure message instead of a clear diagnosis.

Checking the pointer and the type kind would catch both cases.

> +	if (!ASSERT_GT(l->offset, caller_addr, "inline_gt_caller"))
> +		goto out;
> +	/* simple sanity test to roughly ensure inline site still in function */
> +	if (ASSERT_LT(l->offset, caller_addr + 256, "inline_in_caller"))
> +		goto out;
> +out:

This branches to out when the assertion passes, but every other check in
the function is 'if (!ASSERT_xxx(...)) goto out;'. The failure is still
recorded, and 'out:' is the next label, so today the inversion has no
observable effect, but the sense is backwards and will silently do the
wrong thing the moment another check is appended after it.

Worth noting: the '+ 256' window is a compiler/config-dependent bound on
the size of bpf_testmod_uprobe_write(), so once the '!' is added this
becomes the one assertion in the test that can fail for reasons unrelated
to inline BTF correctness.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 2380b6cbdead..09d910d5e312 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> -static int testmod_register_uprobe(loff_t offset)
> +static __always_inline int testmod_register_uprobe(loff_t offset)
>  {

testmod_register_uprobe and its sole caller bpf_testmod_uprobe_write are
only compiled on x86_64. Both live inside the '#ifdef __x86_64__' region
that opens at line 721 ("bpf_testmod_uprobe sysfs attribute is so far
enabled for x86_64 only") and closes at line 838 with empty stubs.

The new test added by this commit keys off both names unconditionally:

    const char *inline_caller = "bpf_testmod_uprobe_write";
    ...
    caller_addr = ksym_get_addr(inline_caller);
    if (!ASSERT_NEQ(caller_addr, 0, "caller_addr_nonzero"))
            return;

On arm64, s390x, riscv64 or i386 with bpf_testmod loaded,
ksym_get_addr("bpf_testmod_uprobe_write") returns 0 because the symbol
does not exist, so ASSERT_NEQ fires and 'btf_inline' reports a hard FAIL
instead of a skip.

The commit adds no arch guard and no DENYLIST entry. The commit's only
stated skip conditions are '!env.has_testmod' and pahole lacking inline-
BTF support, so architecture is an unhandled third prerequisite.

Either the annotation should be moved to a function that is compiled on
all architectures, or the test needs an explicit architecture skip. Absent
prerequisite must skip, not fail, so it does not turn an environment
difference into a false regression signal.

> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 679008b310d9..bf4cb720e7b8 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -244,6 +244,26 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
>  	return err;
>  }
>
> +long module_get_base_addr(const char *module)
> +{
> +	unsigned long long addr, base_addr = 0;
> +	char name[500];
> +	FILE *f;
> +
> +	f = fopen("/proc/modules", "r");
> +	if (!f)
> +		return 0;
> +
> +	while (fscanf(f, "%s %*s %*s %*s %*s 0x%llx", name, &addr) > 0) {
> +		if (strcmp(module, name) == 0) {
> +			base_addr = addr;
> +			break;
> +		}
> +	}

Does the fscanf pattern handle /proc/modules lines with taint suffixes?

kernel/module/procfs.c:m_show() emits:

    seq_printf(m, "%s %u", mod->name, size);
    print_unload_info(m, mod);                 /* " <refcount> <deps>" */
    seq_printf(m, " %s", ...state...);
    seq_printf(m, " 0x%px", value);
    if (mod->taints)
            seq_printf(m, " %s", module_flags(mod, buf, true));   /* " (OE)" */
    seq_puts(m, "\n");

The format "%s %*s %*s %*s %*s 0x%llx" matches a line correctly, but
leaves the optional taint token unread. Because %s matches non-white-space
and white-space directives in the format match any amount of white space
including newlines, nothing ties a conversion to a line. The next
iteration reads "(OE)" into name, skips the following line's
name/size/refcount/deps with the four %*s, and tries to match " 0x"
against the state string "Live", which fails. fscanf() returns 1 (name was
assigned), and `1 > 0` keeps the loop spinning while one token out of
phase, so strcmp() never sees a real module name again.

This is reachable in the BPF CI environment. tools/testing/selftests/bpf/
config sets CONFIG_MODULE_SIG=y, and the selftest kmods are unsigned and
built out-of-tree, so every module line carries a "(OE)" suffix.
/proc/modules is emitted in load order (newest first), so any module
loaded after bpf_testmod is listed ahead of it, and test_progs loads extra
modules mid-run (bpf_test_modorder_x/y.ko, bpf_test_rqspinlock.ko,
bpf_test_no_cfi.ko, livepatch-sample.ko, plus modprobe rc-loopback/loop/
dm-verity). When one of those lines precedes bpf_testmod,
module_get_base_addr("bpf_testmod") returns 0 and the new test fails at
ASSERT_NEQ(base_addr, 0, "base_addr_nonzero"), a spurious failure rather
than a real BTF problem.

The immediately preceding function, kallsyms_find(), avoids exactly this:

    fscanf(f, "%llx %c %499s%*[^\n]\n", &value, &type, name)

explicitly consumes the remainder of the line with "%*[^\n]\n", and bounds
the string with %499s. The idiomatic fix here is the same shape: either
read a line at a time with fgets() + sscanf(), or append a "%*[^\n]\n"
tail and require the full conversion count (== 2) instead of > 0. That
also removes a latent overflow: %s into char name[500] is unbounded, and
while a module name is capped at MODULE_NAME_LEN (56), the desynchronised
scan can steer the comma-separated deps token into name, whose length
grows with the number of dependent modules.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============4623552170929007387==--
