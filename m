Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985183815E6
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411485; cv=none; b=dMW+M/1Ysy70fcKppanAmMTQ1mN8IgbjwOl6oC8mJx03n8gSty8QgG0NojvGLnh9GyaeZeiN6zoQ0yB+eoSeWdDKcwSxsG/FWgl9qrNtf/ZVdt54qIMaiUfbORDOBsbay0eLO57UM8oJxeR4iaSvsCeeCQi6xMNkhc1kfbufFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411485; c=relaxed/simple;
	bh=4RZuKsyAw7f4OL30mIk5rwyF7JRRo+8BgeX2nirrh3E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bfNq8mMDsY66T1DLakxdG2Pi4fcdFX7cMcq/iJ+Eeia70E/QOUwaXStFoh4q3ggsz50WtW/4R5y236N+5hIw5nJAXlAoQ6bji4Q+CoPHy/thRdjvBta6sm83YtNHOEA450i1Dlx6nAsc7mpV58ZBaf/vORD5Z39zBIPIvXOlveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhOYSkcn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhOYSkcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E568C1F000E9;
	Tue, 11 Aug 2026 01:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411483;
	bh=zUVhGbvuEx4K2e5wQoVEEZZF5OvO7OM9n5tdLHzoKXE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GhOYSkcn7yA2Yct+njibipkGWMfN93ULYqXKXducaMtb3nhoAmR2A4NE9RiFFXuHK
	 NvXTu70Qs/mFU7Jhld3zDhpSpGOXVnke6jCqOGI2pnyMFXFLvCleEkSZqPLontNvvd
	 x3+jeL8MgnFAhrIMsvZ0QT6C2jczoqS0KA3zR5lGHPOVsUiRcPT9cWVf/SuVPjR/hV
	 rpdPSTm9uCj4jLQBuvID2ka3WxQNPlyFPMKox7OXbpmo3nwnSC6+o8oEfU0biMXLus
	 Yvson729SxZ59oH7M+YuzDlW0EvoPKyAgpW0YN80JYpHhp7OY7BkVVnspwOIDjf7qY
	 tHGZZSiTdKIZQ==
Content-Type: multipart/mixed; boundary="===============3822318507285033672=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1401ba2c0512cfb3069383693bc55e1f977ad9bbf07dd9cca7e266bf517c571f@mail.kernel.org>
In-Reply-To: <20260811001013.2385213-1-yonghong.song@linux.dev>
References: <20260811001013.2385213-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 12/13] selftests/bpf: Add tests for callbacks returning more than 8 bytes
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 01:24:42 +0000 (UTC)

--===============3822318507285033672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for callbacks returning more than 8 bytes
>
> Add two __failure tests covering the callback return-size checks:
>
>  - timer_ret_pair_fail: a bpf_timer callback declared to return more than
>    8 bytes, rejected by check_ld_imm() where the callback's PTR_TO_FUNC is
>    created, with "callback function with >8-byte return value is not
>    supported".
>
>  - exceptions_ret_pair_fail: an exception callback declared to return more
>    than 8 bytes, rejected by do_check_common() when the callback
>    subprogram is verified, with "exception cb cannot return value larger
>    than 8 bytes".
>
> Both callback bodies are written in inline asm so that the tests do not
> depend on LLVM 23 R0:R2 codegen and run on any compiler. The verifier reads
> the return type from BTF rather than from the instructions, so the >8 byte
> return prototype is supplied through __btf_func_path(), pointing at a
> companion btf__*.c program that exists only to carry that BTF.

Does __btf_func_path() actually supply the return type? Looking at
fixup_btf_from_path() in tools/testing/selftests/bpf/test_loader.c, it
appears to keep the prog's return type and parameter types while
substituting only parameter names:

  ret_type_id = fp->type;                    /* fp is the prog FUNC_PROTO */
  for (j = 0; j < vlen; j++)
      prog_param_types[j] = params[j].type;  /* prog param types */
  new_proto_id = btf__add_func_proto(prog_btf, ret_type_id);
  ...
  pname = btf__name_by_offset(custom_btf, custom_params[j].name_off);
  err = btf__add_func_param(prog_btf, pname ?: "", prog_param_types[j]);

The comment at the call site says "Fix up __naked subprog BTF using a
separate file with named params", and the >8 byte return type already
comes from each test object's own BTF: exceptions_ret_pair_fail.c
declares 'unsigned __int128 exception_cb_bad_ret_type3(u64 cookie)' and
timer_ret_pair_fail.c declares 'static unsigned __int128
timer_cb_ret_pair(...)'.

The companion btf__*.c objects supply parameter names, which are needed
because clang emits anonymous parameters for __naked functions and
btf_func_check() in kernel/bpf/btf.c rejects a BTF_KIND_FUNC whose
FUNC_PROTO has a typed-but-unnamed argument, which would make the whole
object's BTF fail to load.

Could the explanation be more precise about what __btf_func_path()
actually provides?

>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> index 3588d6f97fd4e..71d00c568d802 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> @@ -5,6 +5,7 @@
>  #include "exceptions.skel.h"
>  #include "exceptions_ext.skel.h"
>  #include "exceptions_fail.skel.h"
> +#include "exceptions_ret_pair_fail.skel.h"
>  #include "exceptions_assert.skel.h"
>
>  static char log_buf[1024 * 1024];
> @@ -12,6 +13,7 @@ static char log_buf[1024 * 1024];
>  static void test_exceptions_failure(void)
>  {
>  	RUN_TESTS(exceptions_fail);
> +	RUN_TESTS(exceptions_ret_pair_fail);
>  }
>
>  static void test_exceptions_success(void)
> diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
> index 09ff21e1ad2f0..593e56d8964ea 100644
> --- a/tools/testing/selftests/bpf/prog_tests/timer.c
> +++ b/tools/testing/selftests/bpf/prog_tests/timer.c
> @@ -6,6 +6,7 @@
>  #include <sys/syscall.h>
>  #include "timer.skel.h"
>  #include "timer_failure.skel.h"
> +#include "timer_ret_pair_fail.skel.h"
>  #include "timer_interrupt.skel.h"
>
>  #define NUM_THR 8
> @@ -285,6 +286,7 @@ void serial_test_timer(void)
>  	test_timer(timer);
>
>  	RUN_TESTS(timer_failure);
> +	RUN_TESTS(timer_ret_pair_fail);
>  }
>
>  void serial_test_timer_stress(void)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_ret_pair_fail.c b/tools/testing/selftests/bpf/progs/exceptions_ret_pair_fail.c
> new file mode 100644
> index 0000000000000..842f86ad8659e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_ret_pair_fail.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +__naked __noinline __used
> +unsigned __int128 exception_cb_bad_ret_type3(u64 cookie)
> +{
> +	asm volatile (
> +	"r0 = r1;"
> +	"r2 = 0;"
> +	"exit;"
> +	::: __clobber_all);
> +}
> +
> +SEC("?tc")
> +__exception_cb(exception_cb_bad_ret_type3)
> +__failure __msg("exception cb cannot return value larger than 8 bytes")
> +__btf_func_path("btf__exceptions_ret_pair_fail.bpf.o")
> +int reject_exception_cb_ret_pair(void *ctx)
> +{
> +	bpf_throw(0);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

A subsystem pattern flags this as potentially concerning:
exceptions_ret_pair_fail.c is a new prog file added for one narrow
variant of behaviour tools/testing/selftests/bpf/progs/exceptions_fail.c
already covers: rejected exception-callback return types.

exceptions_fail.c already holds exception_cb_bad_ret_type1(),
exception_cb_bad_ret_type2() and the corresponding '__failure
__msg("exception cb cannot return void")' case. The new callback is even
named exception_cb_bad_ret_type3, continuing that file's numbering while
living in a different file, so a reader grepping exceptions_fail.c for
the series will not find it next to its siblings.

There is a concrete technical reason the exceptions case cannot simply
be appended to exceptions_fail.c: __btf_func_path also sets
bpf_object_open_opts.btf_custom_path, and libbpf uses that as the CO-RE
target BTF for the whole object. exceptions_fail.c includes <vmlinux.h>,
which applies preserve_access_index to all records, and it dereferences
vmlinux structs (ctx->len, ctx->protocol, ctx->tstamp), so it does have
CO-RE relocations that would then be resolved against the 10-line
companion BTF. That makes the split legitimate here; the remaining point
is only that the shared naming (exception_cb_bad_ret_type3) does not
reflect the split.

Is the naming pattern worth revisiting given that the test lives in a
separate file?

> diff --git a/tools/testing/selftests/bpf/progs/timer_ret_pair_fail.c b/tools/testing/selftests/bpf/progs/timer_ret_pair_fail.c
> new file mode 100644
> index 0000000000000..29fd294dfd49b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/timer_ret_pair_fail.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/bpf.h>
> +#include <time.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct elem {
> +	struct bpf_timer t;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, struct elem);
> +} timer_map SEC(".maps");
> +
> +__naked __noinline __used
> +static unsigned __int128 timer_cb_ret_pair(void *map, int *key, struct bpf_timer *timer)
> +{
> +	asm volatile (
> +		"r0 = 0;"
> +		"r2 = 0;"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}
> +
> +SEC("fentry/bpf_fentry_test1")
> +__failure __msg("callback function with >8-byte return value is not supported")
> +__btf_func_path("btf__timer_ret_pair_fail.bpf.o")
> +long BPF_PROG2(test_bad_ret_pair, int, a)
> +{
> +	int key = 0;
> +	struct bpf_timer *timer;
> +
> +	timer = bpf_map_lookup_elem(&timer_map, &key);
> +	if (timer) {
> +		bpf_timer_init(timer, &timer_map, CLOCK_BOOTTIME);
> +		bpf_timer_set_callback(timer, timer_cb_ret_pair);
> +	}
> +
> +	return 0;
> +}

A subsystem pattern flags this as potentially concerning:
timer_ret_pair_fail.c is a new prog file added for one narrow variant (a
callback whose declared return value is larger than 8 bytes) of
behaviour that tools/testing/selftests/bpf/progs/timer_failure.c already
covers more generally: bad bpf_timer callback return values.

The two files are near-identical scaffolding - the same '#include
<linux/bpf.h> / <time.h> / bpf_helpers.h / bpf_tracing.h / bpf_misc.h'
set, the same 'struct elem { struct bpf_timer t; }', the same
BPF_MAP_TYPE_ARRAY 'timer_map' with max_entries 1, the same
SEC("fentry/bpf_fentry_test1") + BPF_PROG2 entry program, and the same
'__naked __noinline __used static' callback idiom already used by
timer_cb_ret_bad().

The new program adds ~10 lines of actual test content on top of ~35
lines of copied setup, plus a new skeleton, plus a companion
btf__timer_ret_pair_fail.c, plus the RUN_TESTS()/#include churn in
prog_tests/timer.c. Adding it as a third program inside timer_failure.c
would reuse all of that. Since __btf_func_path is a per-program tag
consumed per-subtest in run_subtest(), and timer_failure.c has no CO-RE
relocations (it includes uapi <linux/bpf.h>, not <vmlinux.h>), the
btf_custom_path side effect of the tag would not affect the existing
subtests in that object.

A separate file is defensible for symmetry with the exceptions half of
the patch, where a separate file IS required due to CO-RE relocations.
Should the new timer case be a new subtest in timer_failure.c, or does
the symmetry with exceptions_ret_pair_fail.c make the separate file
structure clearer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762
--===============3822318507285033672==--
