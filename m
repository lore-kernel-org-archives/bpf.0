Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628742;
	b=H/NkHHEOnFYQ+QaKb3HPpNPW3+yk0TH/U3qXoVEdTaqQL5n5PuF5dmvE6OEIeDanEvIi
	 SB8XS5seWC6IkVz9ufw/Je1Bd5NyxUyp2p9AgFyFlpZTBKLFloH1yTEY2hNOfKwUsaVjn
	 5zwI60bZyfnYdrQFjVgYd6p7+20mObMnajc6+q6CCmnWmTEZjqDCra946YO/H5gPzclMX
	 6ir0f0EtQkXgT5f7XYEMmsFXHoendrEb8LObRml1qoqmhlseErVpgZHm59OUOxH2iRVCD
	 yajsdz2E/xs9NPh1e93lmt6D3I+6GOybL45AW1foZm9zPhk3NM9GoKWNeCQ9IDziNSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BKOvSAfKwCPl77Mt885tfTsQZMlHvqWxtn+M00Mq7GU=;
	b=txVPFvNkTpV/1Jt1lXy2q7u83Oc3xgeyWSi1bSsZvFgAUbnze7xbLU/uqiZYJaEQp0Bg
	 Ta4BBf0FHAa5dxMIBdc4mfKR7OY6D5zvIu05wJGqhgI6HEC78r0MeA5qSL6h23ZTLFRG0
	 cQMcPDgDia+sj/EJlsbYgtKYnm7vv6Yd4SqALHkEO5WoneopR0sgtcxYNrnzG0YfuaQRr
	 paE6DHJ16apGcHBfqdxiPLQHMstouNWsm5/XVWd6XcUFTSiADno8bHSJyWm9s6BjFThGa
	 4ZkevLGvD8aqFHGciVkONr4F0MaLsjeA0zhKwwuYAS7V8dH9Zqc/aCvDbu2kiWm9Shw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YXzH8/PJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67D606A337
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YXzH8/PJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF01F000C0;
	Wed, 25 Nov 2026 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628741;
	bh=BKOvSAfKwCPl77Mt885tfTsQZMlHvqWxtn+M00Mq7GU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YXzH8/PJEyAmuN11PkmcigQ43zM+TnOT36QBRfsFcnuU8H6jZgYqqA7gYKVJx79bT
	 bI/MK9+oijM7bhCyFgU1w2+jBQdP32fi4wzhOhwD3qBI9W5oA3hqHs1kNCARxozOkP
	 oEdlQdr8Uctm0poDBdsL1+XJHyisAjGqAbvfmY6YXR/hHkIGD0BuolIL19J/72BtOB
	 UcyCzy9f4pfhZzP0a8T5k0Zq+vpDJyWef1e0VXeWFjwcAaAZgx/9YCYYE9GNTFvEPm
	 +hhL6gFczbqvcBL0Zbt1/z7yRIKDnyqKIzgYSGb5fZK5N++tXxW9Kc6aYhaoAVoEZS
	 LhlKGaNuDPihw==
Message-ID: <sashiko-outbox-233854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Test nospec after stack writes
 of calls and atomics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luis Gerhorst" <luis.gerhorst@fau.de>, bpf@vger.kernel.org
In-Reply-To: <254382ea54ff319c0dcf8c93642f5850b276b549.1795625597.git.luis.gerhorst@fau.de>
References: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
 <cover.1795625597.git.luis.gerhorst@fau.de>
 <254382ea54ff319c0dcf8c93642f5850b276b549.1795625597.git.luis.gerhorst@fau.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:45:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: missing SPEC_V1/SPEC_V4 guards on nospec jump
  range tests
--

commit 6fc5e1de114ef93cc1978b1912c33448c16a6ee8
Author: Luis Gerhorst <luis.gerhorst@fau.de>

selftests/bpf: Test nospec after stack writes of calls and atomics

This commit adds BPF verifier selftests covering Spectre v1 and v4 nospec
insertion after helper and atomic stack writes, dead speculative stack
writes, backward jumps, and 16-bit jump offset overflow when inserting
nospec instructions.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
> index a54b5a58b945b..12d5e9e668909 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
[ ... ]
> @@ -1072,4 +1137,140 @@ __naked void nospec_backward_call(void)
>  "	::: __clobber_all);
>  }
> =20
> +/*
> + * The jump is reached with a pointer in r6 on a speculative path only, =
so a
> + * nospec is required in front of it. Its offset is the smallest one tha=
t a
> + * jump can have, and the nospec is between the jump and its target: the=
 offset
> + * can not be adjusted for the nospec.
> + *
> + * The program is valid, it is only rejected because the verifier can no=
t widen
> + * a jump when it patches a program. Any insn that is inserted between s=
uch a
> + * jump and its target has the same effect. Without the nospec the progr=
am
> + * would not be safe, so it must not be loaded. If jumps can be widened =
one day,
> + * this program has to be accepted.
> + *
> + * The insns that are only executed speculatively are removed as dead co=
de, so
> + * they must not be between the jump and its target.
> + */
> +SEC("socket")
> +__description("unpriv: nospec does not fit in front of a jump")
> +__success __failure_unpriv
> +__msg_unpriv("cannot be patched due to 16-bit range")
> +__caps_unpriv(CAP_BPF)
> +__retval(0)
> +__naked void nospec_jump_out_of_range(void)
> +{
[ ... ]
> +}
> +
> +/*
> + * Like above, but for the nospec behind a store to the stack that is be=
tween
> + * the jump and its target.
> + */
> +SEC("socket")
> +__description("unpriv: nospec does not fit behind a store")
> +__success __failure_unpriv
> +__msg_unpriv("cannot be patched due to 16-bit range")
> +__caps_unpriv(CAP_BPF)
> +__retval(0)
> +__naked void nospec_result_jump_out_of_range(void)

[Severity: Medium]
Should nospec_jump_out_of_range() and nospec_result_jump_out_of_range()
guard their __failure_unpriv expectations with #ifdef SPEC_V1 and
#ifdef SPEC_V4 respectively?

Because __caps_unpriv(CAP_BPF) is set, the unprivileged subtests run on
every architecture with CONFIG_CPU_MITIGATIONS=3Dy.  The backward jump in
each test has an initial offset of -32768 and only overflows 16 bits when
the verifier inserts a nospec instruction.

In nospec_result_jump_out_of_range(), check_stack_write_fixed_off() sets
nospec_result only when !env->bypass_spec_v4.  On architectures where
bpf_jit_bypass_spec_v4() returns true (such as arm64 and loongarch), no
nospec is inserted, so the unprivileged program loads and fails the test
with unexpected_load_success.  Similarly, nospec_jump_out_of_range()
relies on a Spectre v1 nospec that is skipped when
bpf_jit_bypass_spec_v1() returns true (such as on loongarch).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795625597.gi=
t.luis.gerhorst@fau.de?part=3D4
