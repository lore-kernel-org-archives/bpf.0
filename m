Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795290905;
	b=vsuJokZRyW7AwqKtu2CuViMsTcWzjGKNr5Smf0oU7a5ulpvF5ni/MVQtIqwWtU6Mb1wW
	 RP8lqiNq6ggbwRR576YoaLb8whlBoBrs0as2AdY+U2yr1aYxMyyl8e4ePQW0XEbiWmyzs
	 JJwNjntIgylKoaK9c0RfPh77+9sLEdHbjVawnvepxtW/hxaQgCSALhuFZuC7g+tN9CmCd
	 B2uF1GKjAeZmRu0wseh9XeFmN5tQhF6xa2kVr8e1GF7vxpOlDr/llaIYgAw2tntGn09Ld
	 IvNTAMmMA3DvAwiIE0hEcYSC1y3qmfCy/2NCGd0i7skxv6AMBft7hpNQIBzVlRzaZDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795290905;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=/vbwsN4h29XxakBUVj/FrYjeXkz8z1QGBkDweYC/f4I=;
	b=QaJWjvZbdpz1YANHoBCI1XOSwuPs+sJDz0dgX6zlvniMzrdb23PcuDkh1ueEtuGgxnEt
	 np+XpKSyYaXgwXTzzNycjbubud3AJa+yhJGZoz2XOJX7fIlbKeutKgPq9vUSr879sny8q
	 kKn0iaDxiNDsPisONWGsxv8nK37sKbOYWCWWYuv/552IvUKNNhr1lLfmrQVna4gEL3RQ4
	 wEibAdqxunFtvLwPKg53L+PGuKhLJUbiDY83ksZG7NkAnaHO9NPk13r+63B7A5lYQ6ek7
	 gW+ikpPr8jiSUXATkUm2ctWZ5u7/CnX57Qs30XHL4a1kl7C4ijmZJNCShNrnxrIo3Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN4DXJFm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C107606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AN4DXJFm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C061F000C6;
	Sat, 21 Nov 2026 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795290904;
	bh=/vbwsN4h29XxakBUVj/FrYjeXkz8z1QGBkDweYC/f4I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AN4DXJFmYxQwGlPABuyxqp+hz4ln1wcoduEktmydhuPOuf5FO+LuDMH8/l9/KFOyx
	 m/dmEIDHEx28ickt87xdMMP+hudM8pTQtlgG7w0XvQQCCr3sA3O6htJ433p6R1Ftwa
	 EB3gCeMaY1n+APNoVK8pGuDbPtEeY0bI68DhhAFlHcWsVP0KJHsnXe604rYlmD6Brj
	 A6qoHguvOZ6YMXlDA693aXuo1dg6gL1aqY8LkakTZmQ2a3KPOiT0lMH1N+NfNj0Jrw
	 hkuojmHyc07TR0hsHPBKuLowy60xJCntOf8uYMi8yEXegH8LWSQLk+KiHe7HqK3UST
	 A2gJgjBN2xSJw==
Content-Type: multipart/mixed; boundary="===============2820675984840709586=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5c9a79843b6c85bd162b5ba529c88b7f12a1219f2bdbc555469545b7219d73f0@mail.kernel.org>
In-Reply-To: <20261121191343.3670609-4-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Mark a skip of trips as a guess if a 32-bit value wraps
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 19:55:03 +0000 (UTC)

--===============2820675984840709586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Mark a skip of trips as a guess if a 32-bit value wraps

TL;DR: skip_wraps() may miss a 32-bit wrap that happens within the measured
trip (a 32-bit add followed by a 64-bit add), so the skip isn't marked as a
guess and the verifier may fast-forward to an impossible register value.

> diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
> --- a/kernel/bpf/equation_join.c
> +++ b/kernel/bpf/equation_join.c

[ ... ]

> @@ -862,6 +865,26 @@ static u64 step_of_xreg(struct bpf_verifier_env *env, const struct loop_stack_en
>  	       bpf_find_var_bounds(env, &entry->header_state->st, xreg, &is_ptr)->r64.base;
>  }
>
> +/* An xreg of @xregs passes a multiple of 2^31 if it moves @factor times as far */
> +static bool skip_wraps(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
> +		       const unsigned long *xregs, u64 factor)
> +{
> +	u64 off, end;
> +	struct cnum64 x;
> +	bool is_ptr;
> +	u32 n;
> +
> +	for_each_set_bit(n, xregs, MAX_BPF_XREG) {
> +		x = bpf_find_var_bounds(env, env->cur_state,
> +					bpf_xreg(env->cur_state->curframe, n), &is_ptr)->r64;
> +		off = step_of_xreg(env, entry, xregs, n) * factor;
> +		end = x.base + x.size;
> +		if (!is_ptr && ((x.base ^ (x.base + off)) | (end ^ (end + off))) >> 31)
> +			return true;

Can this miss a wrap that happens inside the measured period?

skip_wraps() only tests the skipped range, from the current header value x
to x + step * factor.  It does not test the move from the saved header
value in entry->header_state->st to x.  When a 64-bit insn adds a constant
to the result of a 32-bit insn in the same trip, the header value can cross
2^32 inside the measured period, and the skipped range then stays inside
one 2^31-aligned block:

  w7 = -28;              /* r7 = 0xffffffe4 */
  for (r6 = 0; r6 < 100; r6++) {
          w7 += 1;       /* zext_dst: the next insn reads all 64 bits */
          r7 += 5;
  }
  ... use r7 as a 64-bit value ...

The header values of r7 are 0xfffffffc at trip 4 and 0x100000002 at trip 5
(the carry comes from r7 += 5).  step_of_xreg() is 6, factor is 95 and off
is 570, so:

  (0x100000002 ^ 0x10000023c) >> 31 == 0

r6 does not cross either, so skip_wraps() returns false.  In
bpf_steps_are_constant(), insn_wraps is false for 'w7 += 1',
keeps_constant_step() returns true and r7 keeps its step, so the skip is
not marked as a guess.  bpf_fast_forward_xregs() then sets
r7 = 0x10000023c, while a real path has r7 = 0x23c at the exit, because
trip 6 computes low32(0x100000002) + 1 + 5 = 8.

That is the failure the commit message describes: an access that uses the
impossible value fails, the error is not marked as a guess, and the budget
of the next passes is cut.

The same gap exists for sign extension, for example
'w7 += 1; r7 = (s32)r7; r7 += 5' around 2^31.  The commit message says "If
the skip moves a number past a multiple of 2^31, a 32-bit insn can wrap",
but the value tested is the header value, not the value the 32-bit insn
writes, and the two differ by the later 64-bit add.

Should skip_wraps() also compare the bounds of the xreg in
entry->header_state->st with x + off?

> +	}
> +	return false;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44940968656
--===============2820675984840709586==--
