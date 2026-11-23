Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473826;
	b=Exj0XbvfXVaq9hbUenXZJ+GC/FXrVrwkrgeMO+zNd1huYmgIjbuclCx5s8lPTJGJ499P
	 ImuxF603n1VtEJj0FTED5UBOGA74TSogkN3RPwH8c+exDOZYv8QriipZalN2pf/G4DMR+
	 zP4gFVSVfaLzuUhTBgJ5aRMxPL36URS6uzpRoZfo91RnFQcondrEKuFEFDxUz1BNYE0ZF
	 ckEmWCvva8ddmShxQekuQMtgVZo0cOuqOKy8M0QH0FtvQiIAyLr8mXzsK0wPbT71C8ELF
	 okI/nTgnjrUGdxZV2wNE+kbBWJ1oLZ5IORi0J6bqYm2vFKe9H9p1Zd1ywyaut48HlSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473826;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jdKTz0ZuhlW25oIRPGloMmDMj70PM9ioS0wAlWzwlaE=;
	b=vU/QtxGLqGOi2M93xU5CbBYY3OpIeIjCpwfAJdtNaxqAE0vLtw9dnQYcI85ce/CbVo6s
	 r43bySYZUo3+NI2g+gQo1/EExmNw/fB2OddOh4RTrV/DcT+RX33Dzfg66uHBjjFGm1489
	 4use1Ac4jolYjcOj6hGHEBXKnHfKMOFCEHP+oRrjHY3boZPzmHI0GI6yhckZtk9OzXXC+
	 UTwA1P2r0ZUu1t2Oo5azWru4h3HLAcpEYHcjEKBEIv47TayhPANhiJPpvTkR4BcnFeKyT
	 bMqKPibABtx8DfOFlmS9JUAVViUKrblnb2+8ABJYuInhWTqUPy/72G/xvSB9goHlRdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k07arvEF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C9606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k07arvEF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0260B1F000D0;
	Mon, 23 Nov 2026 22:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473826;
	bh=jdKTz0ZuhlW25oIRPGloMmDMj70PM9ioS0wAlWzwlaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k07arvEF3BN7eeMB38DoyT8FdQoph63xO5mu9+HFpkNPKUIbpGrjmJW+yIm0RUZNw
	 Y2Leaawo0M/2oG8pU0eCHVL5+WiG9YRB3LfbR5pg/vBlT3h2rfmoUebrUi4hYroIvn
	 pOcKtMnSLtGY8WQy5Jie/Cvv4wlFfKvlRl0KvI5trRhXaJs5xfWxjoqmYMZqwjhbsD
	 ctfqQO1SZW3SM4vQexxPZ5zk+jUsld58yTIoJ9Na76bcDz3tVO6ivzjJ24p1OodLJj
	 wVn/5NQeUOmFe7GBsdnzzso4VFEMKg1x3j44PbmpooGSudi83M8Ks4n9F5AqoyWzPx
	 f9smR7ghAqZ9g==
Message-ID: <sashiko-outbox-230159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/7] selftests/bpf: Test CO-RE relocation of
 tracing program arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <almagui@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123223227.745345-4-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
 <20261123223227.745345-4-almagui@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:43:45 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests/bpf: unfiltered tracing hooks in
  test_func_args_core() race under -j
- [Low] selftests/bpf: multi-line comments in func_args_core.c violate
  BPF comment style
--

commit 0bbc8fc67b8eff90ed517069d0dfc1334363d6c3
Author: Alan Maguire <almagui@kernel.org>

selftests/bpf: Test CO-RE relocation of tracing program arguments

This commit adds BPF selftests covering CO-RE relocation of tracing program
arguments using __bpf_func_args structs and BPF_PROG_CORE() with both libbpf
and light skeletons.

> diff --git a/tools/testing/selftests/bpf/prog_tests/func_args_core.c b/to=
ols/testing/selftests/bpf/prog_tests/func_args_core.c
> new file mode 100644
> index 0000000000000..1516ad13eaa26
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "func_args_core.skel.h"
> +#include "func_args_core.lskel.h"
> +
> +/* runs bpf_fentry_test1..N() (via a fentry prog), bpf_modify_return_tes=
t()
> + * (via a fmod_ret prog) and bpf_testmod's test read
> + */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a multi-line
comment on its own line, with the comment text starting on the next line.
The same applies to the other multi-line comments in this file and in
progs/func_args_core.c.

> diff --git a/tools/testing/selftests/bpf/progs/func_args_core.c b/tools/t=
esting/selftests/bpf/progs/func_args_core.c
> new file mode 100644
> index 0000000000000..4656a6c642d10
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/func_args_core.c

[ ... ]

> +SEC("fmod_ret/bpf_modify_return_test")
> +int fmod_ret_test(struct modify_return_args *args)
> +{
> +	fm_calls++;
> +	fm_a =3D args->a;
> +	fm_b_set =3D args->b !=3D NULL;
> +	fm_ret =3D args->ret;
> +	fm_ret_exists =3D bpf_core_field_exists(args->ret);
> +	fm_missing_exists =3D bpf_core_field_exists(args->missing);
> +	/* don't override the return value */
> +	return 0;
> +}
> +
> +/* fsession on bpf_fentry_test3(char a, int b, u64 c), called as (4, 5, =
6) */
> +__u64 fs_entry_c, fs_exit_c;
> +int fs_entry_ret =3D -1, fs_exit_ret =3D -1, fs_ret_exists =3D -1;
> +int fs_entry_calls, fs_exit_calls;
> +
> +SEC("fsession/bpf_fentry_test3")
> +int BPF_PROG_CORE(fsession3, __u64, c, __bpf_func_ret int, ret)
> +{
> +	fs_ret_exists =3D bpf_func_arg_exists(ret);
> +	if (!bpf_session_is_return(ctx)) {
> +		fs_entry_calls++;
> +		fs_entry_c =3D c;
> +		fs_entry_ret =3D ret;
> +	} else {
> +		fs_exit_calls++;
> +		fs_exit_c =3D c;
> +		fs_exit_ret =3D ret;
> +	}
> +	return 0;
> +}

[ ... ]

> +SEC("tp_btf/bpf_testmod_test_read")
> +int tp_read(struct test_read_args *args)
> +{
> +	tp_pid =3D args->task->pid;
> +	tp_len =3D args->ctx->len;
> +	tp_bad_ptr_exists =3D bpf_core_field_exists(args->task___bad_ptr);
> +	tp_fwd_exists =3D bpf_core_field_exists(args->task___fwd);
> +	tp_void_exists =3D bpf_core_field_exists(args->ctx___void);
> +	tp_void_same =3D args->ctx___void =3D=3D (void *)args->ctx;
> +	return 0;
> +}

[ ... ]

> +SEC("tp_btf/bpf_testmod_test_read")
> +int BPF_PROG_CORE(tp_read_macro, struct task_struct *, task)
> +{
> +	mtp_pid =3D task->pid;
> +	return 0;
> +}

[Severity: Medium]
Can concurrent test_progs workers cause check_results() assertions to fail
when test_progs runs with -j?

test_func_args_core() runs in parallel with other selftests that call
trigger_module_test_read() or invoke bpf_fentry_test3() and
bpf_modify_return_test() via bpf_prog_test_run_opts(). Because these progra=
ms
do not filter by the test worker's PID, another worker can increment
fm_calls, fs_entry_calls, and fs_exit_calls past 1, or overwrite tp_pid,
mtp_pid, and tp_len with its own PID and read length before check_results()
runs. In addition, if test_get_func_args_test() runs concurrently, its
fmod_ret program on bpf_modify_return_test() returns 1234 without PID
filtering, causing the trampoline to short-circuit and skip fmod_ret_test().

Filtering events by a target PID (and making the test serial if needed to
avoid fmod_ret short-circuiting from other tests) would avoid this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123223227.7453=
45-1-almagui@kernel.org?part=3D3
