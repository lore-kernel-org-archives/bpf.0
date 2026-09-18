Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0C3D890B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711134; cv=none; b=EdjfMJ0XqRWoKBQONWqoSQ+VwXqNEx57yfwN1ul/7hzKr6dlgoW/M+0dV+bkLQum4i7FMwpSH1tZ5+a77zEkNIa4THqcURYln0QgO2FdRKBY5o0qMNOXmvDWQmp+N/2ugIE/Nwc6NAAhDTN5AkIQxhK2AqLvqjzjsLHhOtzZ4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711134; c=relaxed/simple;
	bh=Qbq7USBSGzapJrrzyl3Y3sHg/lzy2WspGEj5dUuFsJQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lCFyEJvuwGbd/bi4zdAXyXv2IYJXqkWZqEYiIClnkQjUFJwslEWTvqGMzzrbjOUYm6BWQgxDoWOgtYFx0ZY7EnQliapeiXTWrcObSUV3zQI2r7E6aE38ZkNBLtDuz4NX9kRVUghY53Lku9R8fvoYUBpFdUr93G4njNIZ2HPwJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX6ZPwxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX6ZPwxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E3D1F00898;
	Fri, 18 Sep 2026 05:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789711132;
	bh=nLIirkmQh/hGi5O0sIB40It3T3B+IHErzmcqOlCZCzQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BX6ZPwxxHrrpZ3ErJSnmE7Q+OT2PXZGrKk149KEhtT5n+f1Gh+mDUSK2NxACgnLoW
	 t5hRL5FdNJCXS/4l+tenvZRpDhv2CIlAIuovMGxEs/vQE9L6qECjIhehHQW77UpyG7
	 QdhN66UBPfNluRM1CY3WJ+r28RmF1WVhIn13RIWC/DH6jHiKe7zc1N6AlDrSw2F+gk
	 BvKwEm3oQFOB9zB3ldv5+UuoYpxSPaLZL5cLIGdnTiCAd9rWVqDDhiZaNm1hefX69j
	 BGaiv9JMVGu6YC9A931sKgLhQ8M5P3qmfOE9FkO4qf0a796ZJOo6nQmJ8K9NBtKmvf
	 WlB51e/ni/g/A==
Content-Type: multipart/mixed; boundary="===============2614937759655452155=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <112c4c6755b0b925b20a58097d943b45c23723b8e561267fb39cd06ee39378e6@mail.kernel.org>
In-Reply-To: <20260918044332.3293447-1-yonghong.song@linux.dev>
References: <20260918044332.3293447-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 18/20] selftests/bpf: Add an end-to-end .bpf_cleanup exception test
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:58:51 +0000 (UTC)

--===============2614937759655452155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> new file mode 100644
> index 0000000000000..ce2dac306a84c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> @@ -0,0 +1,600 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_experimental.h"
> +#include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +#include "exceptions_cleanup.h"
> +
> +__u64 input = 0;
> +
> +static __used __noinline void __kfunc_btf_anchor(void)
> +{
> +	bpf_throw(0);
> +	bpf_preempt_disable();
> +	bpf_preempt_enable();
> +	bpf_unwind_resume();
> +}

Is bpf_unwind_resume() declared anywhere?  It is called from C here but
bpf_experimental.h declares only the other kfuncs this anchor exists for:

tools/testing/selftests/bpf/bpf_experimental.h declares bpf_throw():

    extern void bpf_throw(u64 cookie) __ksym;

and the preempt pair:

    void bpf_preempt_disable(void) __weak __ksym;
    void bpf_preempt_enable(void) __weak __ksym;

but bpf_unwind_resume() does not appear in any header. vmlinux.h contains
type definitions only, not kfunc prototypes.

BPF objects are built with BPF_CFLAGS = -g -Wall -Werror -std=gnu11
(tools/testing/selftests/bpf/Makefile). -Wimplicit-function-declaration
is part of -Wall, and in C99+ mode modern Clang promotes it to an error,
which with -Werror becomes fatal:

  progs/exceptions_cleanup_fail.c:17:2: error: call to undeclared
    function 'bpf_unwind_resume'; ISO C99 and later do not support
    implicit function declarations

This would break the build of the whole BPF selftests tree. The same C-level
call appears in the three other new prog files added by this series
(progs/exceptions_cleanup.c, and in follow-ups progs/exceptions_cleanup_shapes.c
and progs/exceptions_cleanup_light.c), so all of them would fail to compile.

The anchor cannot simply drop the call either: the C call is what makes Clang
emit the BTF extern FUNC for bpf_unwind_resume, which libbpf needs to resolve
the inline-asm "call bpf_unwind_resume;" relocations. The fix would be to add
the declaration:

    extern void bpf_unwind_resume(void) __ksym;

in bpf_experimental.h alongside bpf_throw(). For comparison,
progs/exceptions_cleanup_shapes.c (commit 198e7e8d6d72) does declare its
sibling explicitly:

    extern void _Unwind_Resume(void) __ksym;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============2614937759655452155==--
