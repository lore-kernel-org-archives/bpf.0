Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFD415B67
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142706; cv=none; b=fdb+Cx+GGOs5Q2kRVLYUm4aOy79n+/33OHQ+YTZlLJPmhYWVuM6ryt3WHnNrBvVLwK0PXPGnGIV86DzD0ycYkjtkRkEqFH/mAi+45bFFYpCVJFxduAlmIjQNi6ggShBGG7svSJwgL7GsdIo7b3OWrlBoGfoBJFNTFvxJ6Sl+4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142706; c=relaxed/simple;
	bh=Y71cUIt2o2JSGlRMnkj0Lavh02JsU1+5FePc1FwWTJQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hJ+7/fTFrAOPwaiOphJ5G1PgvCzp6eANK0N0rlY5GxCtTRq5E9DFj7wknzpJv0ZMNRh4otrKOEpev7q92ejJ9y9ALPntFNnCJ+DIiGm8t3m+jNmIcSIUDywBMyj5jlsXY3I6tTotQ3AZyciYTvFRbImf1jl2axTJP/Bc4+OyGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJkzs6DD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJkzs6DD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548AC1F000FF;
	Wed, 23 Sep 2026 05:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142704;
	bh=hld1if60Bi/VzTVJ6jNO4WfrTC8xbuHZuVzxFTUQtS8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gJkzs6DDt4THUNdKL8G0OKL8bP/lUeXQttflUcyoCYYy8DIt8HGf70b5o2LZmriKZ
	 A40WY0RiLdlTvhGqgY7SzslQmTY28pxmhq/c3UEobFpkMdE72c3Xz+rdoMN1wXfLnx
	 d8XTWlUf/6HQgZ8z8NfQPIUacgO3QQBbEbBJNjQt1iPCQyDp5xpPkW26w0i1VU1k0U
	 Afuc5FM9UZnv9Syp1ng8Ehi1ACVF9qINSWSOVmgSVr53Wu2LkglJ+GAf8VhV+54FQz
	 1weO6enB5svAsb7YT2Vz00/9RezYOo2xGMQ/ifETluoTiOD8yxNKCeCUNfpwETlXWY
	 zxIDQZ2TcKysg==
Content-Type: multipart/mixed; boundary="===============6676330559029891585=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ea518f10919eff1081d1e36cb5060919176e73a3cea2477074a5b8fdf2f7e2d1@mail.kernel.org>
In-Reply-To: <20260923050029.2427329-1-yonghong.song@linux.dev>
References: <20260923050029.2427329-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 20/21] selftests/bpf: Cover the exception cleanup shapes the chain does not reach
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 23 Sep 2026 05:51:43 +0000 (UTC)

--===============6676330559029891585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> index d9823023ec04..dbdb78b791e0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c

[ ... ]

> +static void run_shape(struct exceptions_cleanup_shapes *skel, struct bpf_program *prog,
> +		      __u64 input, __u32 retval, __u64 pads)
> +{
> +	__u64 ctx = 0;
> +	int err;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .ctx_in = &ctx,
> +		    .ctx_size_in = sizeof(ctx),
> +	);
> +
> +	skel->bss->input = input;
> +	skel->bss->pads_ran = 0;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
> +	if (!ASSERT_OK(err, "run"))
> +		return;
> +	ASSERT_EQ(topts.retval, retval, "retval");
> +	ASSERT_EQ(skel->bss->pads_ran, pads, "pads_ran");
> +}
> +
> +static void test_freplace(struct exceptions_cleanup_shapes *skel)
> +{
> +	struct exceptions_cleanup_freplace *fr;
> +	struct bpf_link *link;
> +	int tgt_fd;
> +
> +	tgt_fd = bpf_program__fd(skel->progs.entry_freplace);
> +
> +	fr = exceptions_cleanup_freplace__open();
> +	if (!ASSERT_OK_PTR(fr, "freplace open"))
> +		return;
> +
> +	if (!ASSERT_OK(bpf_program__set_attach_target(fr->progs.new_fr_callee,
> +						      tgt_fd, "fr_callee"),
> +		       "set_attach_target"))
> +		goto out;
> +	if (!ASSERT_OK(exceptions_cleanup_freplace__load(fr), "freplace load"))
> +		goto out;
> +
> +	link = bpf_program__attach_freplace(fr->progs.new_fr_callee, tgt_fd,
> +					    "fr_callee");
> +	if (!ASSERT_OK_PTR(link, "attach_freplace"))
> +		goto out;
> +
> +	run_shape(skel, skel->progs.entry_freplace, 101, THROW_COOKIE, 0);
> +	bpf_link__destroy(link);
> +out:
> +	exceptions_cleanup_freplace__destroy(fr);
> +}
> +
> +static void test_pad_calls_freplace(struct exceptions_cleanup_shapes *skel)
> +{
> +	struct exceptions_cleanup_pad_freplace *fr;
> +	struct bpf_link *link;
> +	__u64 ctx = 0;
> +	int tgt_fd, err;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .ctx_in = &ctx,
> +		    .ctx_size_in = sizeof(ctx),
> +	);
> +
> +	tgt_fd = bpf_program__fd(skel->progs.entry_pad_calls);
> +
> +	fr = exceptions_cleanup_pad_freplace__open();
> +	if (!ASSERT_OK_PTR(fr, "pad freplace open"))
> +		return;
> +
> +	if (!ASSERT_OK(bpf_program__set_attach_target(fr->progs.new_pad_callee,
> +						      tgt_fd, "pad_callee"),
> +		       "set_attach_target"))
> +		goto out;
> +	if (!ASSERT_OK(exceptions_cleanup_pad_freplace__load(fr), "pad freplace load"))
> +		goto out;
> +
> +	link = bpf_program__attach_freplace(fr->progs.new_pad_callee, tgt_fd,
> +					    "pad_callee");
> +	if (!ASSERT_OK_PTR(link, "attach_freplace"))
> +		goto out;
> +
> +	skel->bss->input = 101;
> +	skel->bss->pads_ran = 0;
> +	skel->bss->pad_runs = 0;
> +
> +	err = bpf_prog_test_run_opts(tgt_fd, &topts);
> +	if (!ASSERT_OK(err, "run"))
> +		goto out_link;
> +
> +	ASSERT_EQ(skel->bss->pad_runs, 1, "pad_runs");
> +	ASSERT_EQ(skel->bss->pads_ran, RAN_PAD_CALLS, "pads_ran");
> +	ASSERT_EQ(topts.retval, THROW_COOKIE, "retval");
> +out_link:
> +	bpf_link__destroy(link);
> +out:
> +	exceptions_cleanup_pad_freplace__destroy(fr);
> +}

This isn't a bug, but test_pad_calls_freplace() repeats the body of
run_shape(): it declares its own ctx and LIBBPF_OPTS(bpf_test_run_opts,
topts, ...), sets input and pads_ran, calls bpf_prog_test_run_opts(),
and asserts retval and pads_ran.

test_ext_table() gets its extra ext_pad_ran assertion by wrapping
run_shape(); could test_pad_calls_freplace() use run_shape() the same
way and keep only the pad_runs reset and assertion around it, instead
of open-coding the run?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_freplace.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_freplace.c
> new file mode 100644
> index 000000000000..afb358fd3d40
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_freplace.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "exceptions_cleanup.h"
> +
> +/* Without a 32-bit int in BTF, libbpf's dummy_ksym var gets type id 0. */
> +int btf_int_anchor;
> +
> +SEC("freplace/fr_callee")
> +__u64 new_fr_callee(__u64 x)
> +{
> +	bpf_throw(THROW_COOKIE);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_pad_freplace.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_pad_freplace.c
> new file mode 100644
> index 000000000000..eabac6baabb7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_pad_freplace.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "exceptions_cleanup.h"
> +
> +/* Without a 32-bit int in BTF, libbpf's dummy_ksym var gets type id 0. */
> +int btf_int_anchor;
> +
> +SEC("freplace/pad_callee")
> +__u64 new_pad_callee(__u64 x)
> +{
> +	bpf_throw(INNER_COOKIE);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";

This isn't a bug, but these two files are nearly identical, differing
only in the SEC() target (pad_callee vs fr_callee), the program name
(new_pad_callee vs new_fr_callee) and the cookie (INNER_COOKIE vs
THROW_COOKIE).

Would the SEC("?freplace") + bpf_program__set_autoload() idiom that
exceptions_ext.c uses let both replacements (and one copy of the
btf_int_anchor note) live in a single object?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> new file mode 100644
> index 000000000000..bea2c8e95db3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c

[ ... ]

> +static __used __naked __noinline __u64 regs_frame(void)
> +{
> +	asm volatile (
> +	LOAD_MAGIC_REGS
> +	"call bpf_preempt_disable;"
> +"1:"	"call regs_thrower;"		/* cleanup region */
> +"2:"
> +	"call bpf_preempt_enable;"
> +	"r0 = 0;"
> +	"exit;"
> +"3:"					/* landing pad */
> +	"call bpf_preempt_enable;"
> +	CHECK_MAGIC_REGS("%[ran]")
> +	"call bpf_unwind_resume;"
> +	"exit;"
> +	CLEANUP_REC("1b", "2b", "3b")
> +	:
> +	: [cookie]"i"(THROW_COOKIE), [ran]"i"(RAN_REGS),
> +	  __imm_addr(magic), __imm_addr(pads_ran)
> +	: __clobber_all);
> +}

This isn't a bug, but regs_frame()'s asm operand list declares
[cookie]"i"(THROW_COOKIE), yet the template never references %[cookie].
The cookie is supplied by regs_thrower() one frame down, which has its
own [cookie] operand.

Is the [cookie] operand in regs_frame() still needed now that
regs_thrower() supplies the cookie, or is it a leftover from the split?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35821138073
--===============6676330559029891585==--
