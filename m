Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025905;
	b=3igt6q9Okx4DJC2fsb8SLr4soeSYI0w+tbi5ORuve7lKKMCGEngRM4HjT+q3kU2hYDqj
	 58wqv8hzxAmdMA28hdyOhOgK1kpEJ5FJsZr/Fk+pEFwHmZ3hNsHDK4z0quRMnYefHInQV
	 nqxyXytqEYx01tavIyPoC8u4VqonzypcqhGfvNin9OIUdBjI2HFlNjEw/yPvkC8JfeaHA
	 WQZnkpf9FgqZQWJx0YgjfD5gPZSWIf+DpDKZtil3WRFPg1tHWFeb1ZBXKuCbwUS7Lyypb
	 BKPFHtiV4vl7q8asaMcMRj59MQ4Qq1CSda11vpdUJScDUqo2L6FkZQgJomj6ao7tKfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Shn+Yvm/RP4pdGU9OALSPgihDQtUiLxmzzVvfpQb2H8=;
	b=OFwOD/zqtqrGZABd6or1ni8g25/qu0hOYfzg58x8gGL7+GFtcjXv+ZMAB0d/F22aB4KD
	 sIqz75wsSUNXiHsZV3XmY8rLUUJxdEflFh1PHzte2qoois6X7C8YhMD8wnVmosRKLQEDX
	 hto754EEZ0pFTJ0v8HFeewA/+Af02zmZFUKHwIC4XPN2HYH4wLhslhBOn4q3qOxMGaHGf
	 3rEo9B+5HlaYvVwBdhB1tYwQ8oKon232SZmfGmj93Nwvg339wHMLXoFo3Ds/LaSUpohE8
	 nE/s0u40EYnqek9vNCejzhDq7lTpQ2q/vzqXMf8V5TrWtOj9F6rOuBKqqhvltZ/Qdyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gcs/dihq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330C606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcs/dihq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031FA1F008A1;
	Sat,  7 Nov 2026 04:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025905;
	bh=Shn+Yvm/RP4pdGU9OALSPgihDQtUiLxmzzVvfpQb2H8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gcs/dihqtEE3JknlApRCl8Kyp7nCgKO9iA3Q5sV7U4eM89gZSPzKdVZF5ZrHUv3tj
	 r7hIaw8DDrcsIIZGaRh+KzvtHXz6oT8s24D4C2UzpEpIZJI9QrqLVehUzFjQNTq0vh
	 aNBbwk2LD6g4FR4EyXOALRdsjMEbcLy+jQ57T4k9OXmAZFWKDjILPzdtdQp48UvwPN
	 9xz58DXQ0NAABNup7//hiBLUu9f+YwovtOSOIQMAWL9eeRzdClfCUgiol0Vyjrngiv
	 pG96wwxTvm1sHDj1WcTe+EyCIMoWqvTUPNYJ6ZjVsCBlFcsl0THn52zBVxK2VfdEbi
	 8uBPCPr7P0HSA==
Message-ID: <sashiko-outbox-202584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 27/46] bpf: Track a pointer to one of a set
 of functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-28-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-28-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:31:44 +0000
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
- [Medium] bpf: unconditional R1-R5 split in do_check_insn() causes
  state explosion
--

commit 5fe8c15ac1cfee1e78fee4f0e12cfb386fffa7e1
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Track a pointer to one of a set of functions

This commit defers splitting verifier states when loading function pointers
from a read-only map table by representing the loaded register as a set of
possible functions until a callx or callback helper/kfunc requires a single
target.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7769b4bd14673..a5c3e86f3f87f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21009,6 +21125,12 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
>  				return check_func_callx(env, insn, &env->insn_idx);
>  			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
>  				return check_func_call(env, insn, &env->insn_idx);
> +			/* a callback is one function */
> +			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
> +				err =3D split_func_set(env, i);
> +				if (err)
> +					return err;
> +			}
>  			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
>  				return check_kfunc_call(env, insn, &env->insn_idx);
>  			return check_helper_call(env, insn, &env->insn_idx);

[Severity: Medium]
Can splitting all of R1 through R5 before every helper and kfunc call cause
an N * N state explosion or unnecessary state cloning?

When a function set of size N is loaded into R3 and copied to R2 before
calling bpf_timer_set_callback(), both R2 and R3 are marked live in
live_regs_before because bpf_timer_set_callback_proto declares a third
ARG_PTR_TO_PROG_AUX argument.  Splitting R2 and R3 independently produces
N * N combinations at the call instruction instead of the N states produced
before this patch, exceeding BPF_FLOW_MAX_STATES (1024) for N >=3D 33 and
rejecting the program with -E2BIG.

In addition, non-sync-callback helper and kfunc calls inside a basic block
are not flow points, so dead caller-saved registers in R1 through R5 have
not been scrubbed by bpf_clean_verifier_state() when do_check_insn() runs.
If a dead register in R1 through R5 still holds a func_set of size N,
split_func_set() pushes N - 1 states onto env->head at env->insn_idx,
inflating env->total_states and re-verifying the call and the rest of the
basic block.

Splitting only when checking an argument that expects a function pointer (s=
uch
as in process_kf_arg_ptr_to_func() and the ARG_PTR_TO_FUNC path in
check_func_arg()) would avoid splitting unrelated or dead registers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D27
