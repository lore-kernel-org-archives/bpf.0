Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162629;
	b=c7no5UgmjAmQnx0oE7vGwiLvuFgAGBDCOC97l/hZHgYf4YM4HYi/Zw3Pfa+RIzVDbewp
	 0qsFFQue0mqtoZi6Q4588IxPNX8mkJU5e6SU8Oi/KFc7tbPCYSKQFnZyNs/hyCJadKSeJ
	 1c5MnHeCvhebSgQdEk0iU84TI2KRzd0gUjDCTmbgHNEVjZxt9tVJZPPvB4iBoZJ5rlyMm
	 C1xv8mQ0+WM0QIvZnkM19jP0EhQYPoGKiy/K0X+AppRMgpWxqY3bKvuZa9kDWZB+b/UaB
	 /+ypLaMnlAnUbDtHBVtuHIDcPn7ieQt3Jyb5bwLgvLLhoxbCZmjtKC7TtRaDkmh5msA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162629;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=toQywi+AEdJ8YL2jjauCczD1WVWxJp2bCOgzDsPvmic=;
	b=KAhAOJr2jN3n0gX1dIPc2aaI2/gzFUdMcLAz5N10l4Or40ABehw0hX2gKb79EDczigEN
	 OznaluDE7zP8dbn0jUp9skGIOyxXjqfPGjeoMqBSEwCk38D9OClVlh4HDoPlm1S3/IzUw
	 /YcpPS7cE33MFiSenCOFWHdZJJWuNGfUwMtw0zhaZi70L7i4QMo8O5u5QFwSxEhvgIDjy
	 gDS1y34PongzFsEHp2yjf/puzk9wdxh3TigtcBehfpZuardCa1r6mqbsBmNFrvEoZrLNg
	 BCbjofgef2DlLVQqsJcaaHIPxHXQbbrJzpYlqfw89WpSM+dSGJ12v3wQkyWV7kcyaHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgaNTKez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E9606A332
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgaNTKez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B941F000D0;
	Fri, 20 Nov 2026 08:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162628;
	bh=toQywi+AEdJ8YL2jjauCczD1WVWxJp2bCOgzDsPvmic=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cgaNTKez1KcNstms3wtauv4W+sbug171vb9wLx73yR1FalX7lssNVsFbibinlFkkw
	 0Asd7gel9Pb2vN6u8LK+kaHYvhyaR68p8RHAw3xjjoiYgnjUgpsEFtM0Hoeont+RnN
	 OST+8/Va+oCEftoz2S2XFSBcw9om/CJcPyMo5/B3j++2OWd6NDkKhBng3NZts1+dX9
	 nFZwvQs0WQtgYswm8gnkXdxfwdon8Q/vNPak+QmrIy0ZrT10ehkfmDVUX9HCjfZx3r
	 6LuYCXFffYfK8+9QhtnG3MJ9xkC6MCDMm9laJXGu3yZrQ8W6N3bdL1KHxCt2B6POCH
	 yuZ1U5TcYaMfQ==
Message-ID: <sashiko-outbox-224698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 17/49] bpf: Keep a table of equations in each
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-18-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-18-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:17:08 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: out-of-bounds heap read in print_verifier_state() [1]
--

commit 50d5a04552747afb8f6e6e42345fff3aae2918b7
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Keep a table of equations in each state

This commit adds a per-state equation table tracking xreg equations, symbol
equations, and symbol ranges across verifier state copies, logging, and
memory accounting.

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 7b1390d905498..8a905f4df9b18 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -803,6 +803,9 @@ void print_verifier_state(struct bpf_verifier_env *en=
v, const struct bpf_verifie
>  			verbose(env, "%s%d", i > first ? "," : "",
>  				state->loop_stack[i].loop->header);
>  	}
> +	/* one table for all frames */
> +	if (print_all && frameno =3D=3D vstate->curframe)
> +		bpf_equations_print(env, vstate);
>  	verbose(env, "\n");
>  	if (!print_all)
>  		mark_verifier_state_clean(env);

[Severity: Critical]
This problem wasn't introduced by this patch, but can print_verifier_state()
read past the end of state->stack [1]?

When a BPF program reserves a dynptr at the current maximum allocated stack
depth and then overwrites only its second slot,
check_stack_write_fixed_off() calls destroy_if_dynptr_stack_slot() and
scrub_special_slot() on the written slot, leaving the first slot (at the
last allocated index of state->stack) with slot_type STACK_DYNPTR.  If a
verifier log dump then runs, the STACK_DYNPTR case in print_verifier_state()
advances i past bpf_stack_nr_slots(state) before indexing state->stack:

kernel/bpf/log.c:print_verifier_state() {
	...
	for (i =3D 0; i < bpf_stack_nr_slots(state); i++) {
		...
		case STACK_DYNPTR:
			/* skip to main dynptr slot */
			i +=3D BPF_DYNPTR_NR_SLOTS - 1;
			reg =3D &bpf_stack_slot(state, i)->spilled_ptr;
	...
}

This triggers an out-of-bounds heap read that can crash the kernel or leak
adjacent heap memory into the verifier log.

[1] https://sashiko.dev/#/bug/linux-75762bbc-6239-4798-be8a-b4058144a0ca

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D17
