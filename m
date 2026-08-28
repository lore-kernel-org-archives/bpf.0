Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347F3C109A;
	Fri, 28 Aug 2026 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894945; cv=none; b=b8ghImaV1/sMdqsQrFXwPuE3r88y2BqrU0kV95HN7cfSzbf+aChIyx00jAtp/GgZllq9aNgvTAfvLTSLyD0Me9jaTAZg0gmv15wgOPt9jWJAv5eTiUWTyo+6OO78BIcue/m1qj1hfvXU2TwwdxDO4sKiGR+0nmenBwnHtM3Xc5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894945; c=relaxed/simple;
	bh=xmcWMiBAgnLLbgOm7IQia4m8RQ14Uvegkpco+TF2ur0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Oot+zhvpcvwQ6joM67XHcWXO3BU/5wECsN1KcTMbCkbjWUh7CnsbQrP61One8yaGQ4uytrCle8u4tozI7NClakpbMxOvFEZJMFY46xkzKpIOeSyKkWeoqC5lnm9984kKPvKPCoxsgaCxLn4REObi/KgCMO1vXPhPmMD2lQYYKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0BkD5al; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0BkD5al"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07D91F000E9;
	Fri, 28 Aug 2026 05:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787894944;
	bh=Y36S8vTNNdyC8fugOZaGZ2ZklylXgJ+nzT/f/UGLqoE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b0BkD5alYed4kNaDi1OFxkMbx/VmaTo6tyGqc3PakmVLUuPZWL8qYPEcoZmEkW7Jp
	 6LewkU+uO/PRqrXDy6Qzjw24sC4dw3G/X/TZWq2BphBvdwRa7F/mC19xoxW/rrgvQq
	 S8lH7hf9Z2ygOR+LOLPg0peCxIGformhrQ9p9wwcKoFRKwAkgcYn8b6d4XGWvAQgWm
	 ejSyqs4GjKiTuHW9piu57la3DZpifuqd6wIHm/Lieb4zcBdweiPG24ibuEDvtIpJv5
	 IZLXPNdq6mvF/T5Wr7zVBavc4K8JiPpYIfO3Fd0rsuP5xV03xiYpebw8yB7uTw/lqG
	 ysI4wiFV01aVQ==
Content-Type: multipart/mixed; boundary="===============0848727128224488949=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a893cf993fc45d0da27fa066e413e8ca8afb226edb7d6aaed0a1ae4f4ec8642@mail.kernel.org>
In-Reply-To: <20260828042715.16546-1-yangtiezhu@loongson.cn>
References: <20260828042715.16546-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add test for indirect struct_ops trampoline
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 05:29:03 +0000 (UTC)

--===============0848727128224488949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
> new file mode 100644
> index 0000000000000..5a21aedd02fc5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_trampoline.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "struct_ops_trampoline.skel.h"

A subsystem pattern flags this as potentially concerning: the new
standalone prog_tests file plus a new progs file are added to cover a
9-argument struct_ops callback whose last argument is stack-passed.

tools/testing/selftests/bpf/progs/struct_ops_arena.c already exercises
this shape via bpf_testmod_ops3.test_arena_stack, whose declaration in
bpf_testmod.h carries the comment "enough leading args to force @ptr onto
the stack on x86 and arm64", and test_arena_stack_cb() already pins the
slot layout with argument checks before using ctx[8]. That test is driven
from prog_tests/test_struct_ops_arena.c in the same directory.

The plausible reason for a separate file is that the arena test is gated
to __x86_64__ || __aarch64__ and needs arena support, which LoongArch and
RISC-V lack.

Could a plain (non-arena) >8-argument member on bpf_testmod_ops3 plus a
new case in test_struct_ops_arena.c or test_struct_ops_multi_args.c have
avoided a new test binary?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_trampoline.c b/tools/testing/selftests/bpf/progs/struct_ops_trampoline.c
> new file mode 100644
> index 0000000000000..b0fc19a2a0c53
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_trampoline.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../test_kmods/bpf_testmod.h"
> +#include "bpf_misc.h"

This isn't a bug, but could the bpf_misc.h include be dropped? The
program has no __failure/__success/__msg/__retval/__sink/__arch_*
annotation, unlike progs/struct_ops_multi_args.c which includes the same
header and does use __failure __msg(...).

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 850cf4f830c48..be96bbc1b7c04 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -589,6 +589,9 @@ noinline int bpf_testmod_trampoline_count_test(void)
>  	return 0;
>  }
>
> +struct bpf_testmod_ops;
> +static struct bpf_testmod_ops *st_ops_trampoline;

This isn't a bug, but does the struct bpf_testmod_ops forward declaration
add anything here? bpf_testmod.c already includes "bpf_testmod.h" at the
top, which defines the struct completely, and the dereference below at
st_ops_trampoline->test_trampoline requires the complete type. The
neighbouring static struct bpf_testmod_ops3 *st_ops3 carries no such
forward declaration.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33142391368
--===============0848727128224488949==--
