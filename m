Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999853;
	b=TFhBl4F091WQsO1vV3w9nxSpHsDaFMA0yqrat8aCtqoqOM5MUobbQ6cQXnxEInftm+qL
	 CSZTxDogI7td+7v8/wLmvnmxvrVpza88JeMPKyBh1CTXfzb3e7BiasOEEj2xJGbMq14fP
	 A8ZfYbYv7VqoJ2zSi3guZqeqb4F7E+s+Gk2JZjOgF+POqjsvzo/g6mV1u+8kXMgM33HqP
	 Ww5+9ev0D4YztbEFmCrpTAhtS3VJJ9jU364e95aUif4RREg/fgLu546Q7zfXKEVNtr/D0
	 LDMUHizcLeBN4e8vJUdy9YHhANJlwelcn06pKvBj3I37RiLl6PcgVIla6QV/sNR04bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999853;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZTLeySFmFiYGYJVi7j0aEJUnoMsu86CIQTKV6yT7czA=;
	b=aubUatBsmw1Jpf7c/sG5GyXRR7DId19AT6VMp57hzK9tEIdEYzd+FOUrwjXUMDeXSCY/
	 wK0gR3C6ZukrvWG2QcmHTeh73rc8HEo4fwlOpJGzlnfFqccZriM6OVZzjcWxW2Gkc+vKR
	 VQR72iaxMd4+FFuSf00x5EaF4Rgp9jE1N+EY2jwFVIn+6cvwJJ/QegM1p8o6n+nTFoAFm
	 dIsc//X59m8yyRbo+7PEFIMO3WIi7+zozwHycI7Yr99vOBwzJQ5Ahjb8d60QhswhuqBeY
	 1A6++oFY2/kpxYciw2FTGlOQcH7V/qAEJE2SYHJk/MxM4vczI2aNevNkBJv0xuWltgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URYOt31T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AF606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URYOt31T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3141F0089F;
	Fri,  6 Nov 2026 21:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999853;
	bh=ZTLeySFmFiYGYJVi7j0aEJUnoMsu86CIQTKV6yT7czA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=URYOt31Tmq/mX/kvW84zQ0xEIrxjbOt8N0HAfdJU/rJW9rYtgx00MYEfw+oBkjDWQ
	 ltGRTkuSXX/N0sTJUDIprh8m1K09fmZ3KLMDD/vwK74NEaO1180223kbsNxnuuAlRB
	 u2AH28dfgxFbZc13ExTp5UasziW1QYpuP7SmAY3aCT7OxhfQkuhC7FVTz/QG4oMpdo
	 CDJqY7H27hl/pLaeZ18c11/rfCB2Q76vVxAa/KnUkgbLXPJm77LsApbZHL9lf1otSm
	 e8koxu+/UjGMyix57eezpgASnN+6JUyOc/fyvqLj0C52cn7ntPfrjdHSUslpZYOsUT
	 Q9uS1T0rp9byw==
Message-ID: <sashiko-outbox-202293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 13/18] bpf: Check the return values of
 fmod_ret programs on found targets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106210314.1767267-13-a.s.protopopov@gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-13-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 21:17:32 +0000
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
- [Critical] bpf: use-after-free in check_helper_call() [1]
--

commit f5e3bd12bcf921a0d31fb8a40c17694ea46d4300
Author: Anton Protopopov <a.s.protopopov@gmail.com>

bpf: Check the return values of fmod_ret programs on found targets

This commit parses the "bpf_fmodret_retval:" BTF decl tag on fmod_ret
target functions and verifies that attached fmod_ret programs only return
0 or one of the specified error values, while disallowing tail calls and
freplace extensions on such programs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b58a1796a2e4..71fbb30e4d768 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13338,6 +13338,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  	}
> =20
>  	if (func_id =3D=3D BPF_FUNC_tail_call) {
> +		/*
> +		 * The program which a tail call jumps to returns for this one,
> +		 * and a program array does not check the values it may return.
> +		 */
> +		if (env->prog->aux->fmodret_retvals) {
> +			verbose(env, "tail calls are not allowed in fmod_ret programs with re=
stricted return values\n");
> +			return -EINVAL;
> +		}
>  		if (env->cur_state->curframe) {
>  			struct bpf_verifier_state *branch;
> =20

[Severity: Critical]
This problem wasn't introduced by this patch, but in check_helper_call(),
can passing an RCU-protected or iterator-yielded pointer to a pointer-cast
helper such as bpf_skc_to_tcp_sock() drop its lifetime constraints on
regs[BPF_REG_0] [1]?

kernel/bpf/verifier.c:check_helper_call() {
	...
	if (is_ptr_cast_function(func_id) &&
	    find_reference_state(env->cur_state, meta.ref_obj.id)) {
		...
		regs[BPF_REG_0].type &=3D ~PTR_MAYBE_NULL;
		regs[BPF_REG_0].id =3D meta.ref_obj.id;
	}
	...
}

RET_PTR_TO_BTF_ID initializes regs[BPF_REG_0] without propagating MEM_RCU or
parent_id from the input argument, and the cast block above only runs when
find_reference_state() finds an acquired reference.  Because RCU-protected
and iterator-yielded pointers are tracked via MEM_RCU or parent_id rather
than a reference state, regs[BPF_REG_0] is left as an unconstrained
PTR_TO_BTF_ID.  When the iterator advances or bpf_rcu_read_unlock() is
called, the parent pointer is invalidated while the cast pointer remains
trusted, allowing a use-after-free.

[1] https://sashiko.dev/#/bug/linux-97cfbde4-a454-41bd-bdcf-b13a51d2adaa

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106205523.1765=
622-1-a.s.protopopov@gmail.com?part=3D13
