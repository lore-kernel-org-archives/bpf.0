Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787571;
	b=NJh4o+NO2PdWiVnW5uB8CO/igQqycyBmbw6gfI59vjMnhYTERCLP5YBmyFOSShcVE5Ht
	 3y/BHaYT9jEoqxPGQR0tog3VGPqyBcoaznMI80abmE8CdRDC+5oyQGD/+fY1hw+uatFnT
	 ru81oGIoGf47RERhbpS0xhN1wp0cxES8PyIv4hFELhc97riSmnHqjx2vAtA/9NyENnz3/
	 Sw3/BoGolTUtCSXeTUMpv5owMa48anLfVO6llu6+J8sOzk5RGWP/7YxE2ciimlIGOULZX
	 MDY4aO+qeMXGQ/7zHDVV8PYf/5jmiXAOMri2MVlx0tYCXGGf250EPArKfCY8ZbhJdSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PHOrIONiVnB9qj2DBrsXOkXEckvs6hQ3EHFyOc2DRaY=;
	b=Vqf9woaxpkrUM3dxQaiQOwCrdTp1sLobL4vtRvala7aCZMgZtB+F8sWvXZBo+Mn4JEcu
	 +OvOdsB3GnItbbZKbQSHVyIMF/qtOh4pr0fuPDp6WQxeBjXQntnq7ltg9N1NvZILm8TsB
	 +ZDg6qF/NhRuiDC6q2ptoyMqRWNf+t8J77IU2qmKEr4YqCOPtxhHYLo838xzjT8Mj/qt7
	 8vDJED4rVqydJO7FnbHMumIAvnURupr0atRCs9LNN/l7ge2sRU91PtifTPqUHki0ZCLTH
	 2TUJoddDzVt2LAIZhH90vQp4hv8Tpfp2omntsXwbmVpGC8npWKnmtqI4nrkJ+tJ5Ksw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjnDtVW8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F5606A32F
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjnDtVW8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900601F00A02;
	Wed,  4 Nov 2026 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793787570;
	bh=PHOrIONiVnB9qj2DBrsXOkXEckvs6hQ3EHFyOc2DRaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjnDtVW8T6I+mldgxYgsAGFPJPMKyNw9Q+4ZL4whAZCfaeBI3rGPCe8wVSbFfZ8nK
	 MMbXRgSpMivxIWu6ltRaRPac4hYoQjEMBFaHVZVy6OANmJ9mma8aoylAgDrt1S9o8R
	 wcOu7WvbxZ364iCEEMX5/E3UiFjsbtkuAeTuaOBIsRS1W+Wt6X+1zxoKJTmzBm3Lkz
	 CR+5DqKwXciG8taZ0nNqYISZkB0o0z7/+jqYEHbBkTYNtypU8B46gmzebVn5z8nHHS
	 nMVHav4YYmnByjj1OdIntghmQKAfDROCzewAd3sV9RvvieRRvbXtpz4bcNyLMmbb0a
	 Ik0kF8VBmeCkw==
Message-ID: <sashiko-outbox-197083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add a runtime test for
 private stack and stack arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261104100411.997-4-cp0613@linux.alibaba.com>
References: <20261104100411.997-1-cp0613@linux.alibaba.com>
 <20261104100411.997-4-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 10:19:30 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: broken compiler skip in serial_test_private_stack=
_runtime()
--

commit d5748c85c54dbc46700395b1926da29c28fcdef7
Author: Chen Pei <cp0613@linux.alibaba.com>

selftests/bpf: Add a runtime test for private stack and stack arguments

This commit adds a runtime and JIT disassembly selftest on 64-bit RISC-V for
BPF programs that combine an adaptive private stack with outgoing stack
arguments.

> diff --git a/tools/testing/selftests/bpf/prog_tests/private_stack_runtime=
.c b/tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
> new file mode 100644
> index 0000000000000..918c41d6b179c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "private_stack_runtime.h"
> +#include "private_stack_runtime.skel.h"
> +
> +void serial_test_private_stack_runtime(void)
> +{
> +#if defined(__riscv) && __riscv_xlen =3D=3D 64
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		    .data_in =3D &pkt_v4,
> +		    .data_size_in =3D sizeof(pkt_v4),
> +	);
> +	struct private_stack_runtime *skel;
> +	struct bpf_link *trace =3D NULL, *ops =3D NULL;
> +	cpu_set_t saved, single;
> +	int cpu, err, tested =3D 0;
> +
> +	/*
> +	 * Two independent halves. RUN_TESTS() validates the __jited patterns
> +	 * through the test loader, which builds its own object from the ELF
> +	 * bytes. The half below loads a separate skeleton to check the runtime
> +	 * values and the CPU the program reported, which disassembly patterns
> +	 * cannot express.
> +	 */
> +	RUN_TESTS(private_stack_runtime);
> +
> +	if (!ASSERT_OK(sched_getaffinity(0, sizeof(saved), &saved), "getaffinit=
y"))
> +		return;
> +
> +	skel =3D private_stack_runtime__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +	if (!skel->rodata->has_stack_args) {
> +		printf("%s:SKIP: clang lacks __BPF_FEATURE_STACK_ARGUMENT\n", __func__=
);
> +		test__skip();
> +		goto out;
> +	}

[Severity: Medium]
In tools/testing/selftests/bpf/prog_tests/private_stack_runtime.c,
serial_test_private_stack_runtime() calls RUN_TESTS(private_stack_runtime)
before opening the skeleton and checking skel->rodata->has_stack_args.

When the BPF compiler does not define __BPF_FEATURE_STACK_ARGUMENT (such as
bpf-gcc or an older Clang), tools/testing/selftests/bpf/progs/private_stack=
_runtime.c
compiles run_args() as an empty stub and omits the __arch_riscv64 and
__jited() annotations on private_args and kernel_args without adding a
__skip() annotation:

tools/testing/selftests/bpf/progs/private_stack_runtime.c:
    #else
    const volatile bool has_stack_args =3D false;

    static __always_inline void run_args(struct private_stack_result *resul=
t)
    {
    }
    #endif

    SEC("raw_tp/sys_enter")
    #ifdef __BPF_FEATURE_STACK_ARGUMENT
    __arch_riscv64
    ...
    __jited("	ld	{{.*}}, 0x8(s0)")
    #endif

    int private_args(void *ctx)

When RUN_TESTS(private_stack_runtime) runs in that configuration,
parse_test_spec() and run_subtest() treat private_args, kernel_args, and
zero_stack as three valid subtests with no __jited() expectations, load all
three, and record 3 passing subtests before resetting env.subtest_state to
NULL.

Execution then reaches the !skel->rodata->has_stack_args check and calls
test__skip() outside any subtest, incrementing test_state->skip_cnt to 1 wh=
ile
test_state->subtest_num is 3. Because skipped_cnt !=3D subtests_cnt in
print_test_result(), doesn't this run three vacuous subtests and report the
test as OK (SKIP: 1/3) instead of skipping it when the compiler lacks
__BPF_FEATURE_STACK_ARGUMENT? Could the has_stack_args check be performed
before RUN_TESTS(private_stack_runtime), or should the programs be annotated
with __skip() when __BPF_FEATURE_STACK_ARGUMENT is undefined?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104100411.997-=
1-cp0613@linux.alibaba.com?part=3D3
