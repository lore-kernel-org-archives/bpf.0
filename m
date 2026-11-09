Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210172;
	b=ytRJ83++Bw3xQt8QUTj+EWgFREI7brK/a7ZvHCwul40J1q37PDk+ftbDWYxkOgoEsaSQ
	 83H6nuVUgwWe6BP9nauNx/jKov0ATNPbjVY+PfRQKoZFcIYcUIdL3HSlR1bXsysdAvd3K
	 gCRm1qVe34XCBO3aD8rJITJE8HRRGsh59HU9yPNiTgW3zRrQml5/Vt69Rj/Km1XNsrTWn
	 9pkCi9HstxgSdgRmdsLEKfPgQ/SgHKt+9HVsFQeMtE04WJ2VxDhPiDYpljLQk8+F4KfNS
	 hPl9+ZtzRVwQmqA+5A9sLS85DbOWIs1Pj8VQr3lLTQ2peEF5iyJX0wyZuzx/2/XKvyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210172;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FceE5xJr8Qry5/SpeiA7EHgYlFtuW3PstgLjeceLv7E=;
	b=HJAS66FAXn0wzc5q/vDVIIKISxSchx8BDBr3HihKOKci5hbubyxm6vbmXdL1M7DXkf+H
	 F+NKlFhpyf/JogUFgCprGhWahqAWJ0tdcYwuhRnDzuiSR2kYyiMkU3h/hBaV9dvQRMVNX
	 5T+QZwhddqU5HBKFttBL1Iz0pJg82H1XqJBmXy/0LM3f1qBFlYPlC2gl/r4VTpvuiyefi
	 3Ww/T89nqZap/dPZZUdUMeWqGBMYdpjfd4BL6BDXCX0dhufBsC/2xh/ZC5ZlTs2VDweDw
	 eZ4yurGGRsB7u9WYNh+Q99Y/FCIwc4puExqI59MskKtC8PVDeIEhfmdspKnql2bPmZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jbukk5Hk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84310606A323
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jbukk5Hk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D726E1F0089F;
	Mon,  9 Nov 2026 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794210172;
	bh=FceE5xJr8Qry5/SpeiA7EHgYlFtuW3PstgLjeceLv7E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Jbukk5HkHkFqTPowZQ6Xvxv7sHhYpwSh+bL21E3o9KZFlVHktQQZNmqBFLtGnxosT
	 nsoJCVuV4Ck0j/w/Gc696tbM98UZrHJW7jQpucH5WjCd1xf4UfYx61IrLO9gHXyVWB
	 pWoZSAIEuQhSb7B6pQcRSu4aUTT2gxYZ+LNrKlbl4D93Bu9tHTCmlEMAupj9zSm7bh
	 fNpcvEVPq3Lk09s2EkCHgLRA90x30LdC20/xFPGVm/V6DbSb+zu4kGKbsTsju52TTN
	 xDzNt4Oqh0AwEUzdW31u1mFM2Omff0UfDMeCmJehmhTbhrjgUx1atb+VriGkNtQngT
	 X/Wb2HmPKZz4A==
Message-ID: <sashiko-outbox-204549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 09/26] bpf: Check writes to the stack against
 bpf_may_write_mask()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261109064715.2382452-10-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
 <20261109064715.2382452-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:42:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] bpf: false verifier_bug_if() in check_may_write_mask() on
  widened size_reg
- [Medium] bpf: missing ancestor frames in arg_track_deref() on
  ARG_IMPRECISE fill
- [Low] selftests/bpf: store_to_one_of_two_buffers never tests
  !fixed_off path
--

commit f461f9c4654f675e9f3fd050b693d2b558488f0c
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Check writes to the stack against bpf_may_write_mask()

This commit adds check_may_write_mask() to verify during the main verificat=
ion
pass that stack writes in check_stack_write() and
check_stack_range_initialized() fall within bpf_may_write_mask(), along wit=
h a
selftest for variable-offset stack stores.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5bffc1e288f60..ae3b751b99a1c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4327,6 +4327,31 @@ static void invalidate_stack_slices(struct bpf_ver=
ifier_env *env, u32 frameno,
>  	}));
>  }
> =20
> +/*
> + * Scalar evolution takes the may-defs of stack slots from bpf_may_write=
_mask(): a slot that is not
> + * in the mask holds the same value before and after the insn. The itera=
tion count of a loop depends
> + * on that, and nothing detects a wrong one later. Here an insn, a helpe=
r or a kfunc writes to
> + * [min_off, max_off) of frame @frameno. For a frame of a caller the ins=
n is the callsite. Without
> + * @fixed_off the range can be wider than the mask: two offsets become a=
 range at a join point. Then
> + * the write is somewhere in the range.
> + */
> +static int check_may_write_mask(struct bpf_verifier_env *env, u32 framen=
o, int min_off, int max_off,
> +				bool fixed_off)
> +{
> +	struct bpf_verifier_state *st =3D env->cur_state;
> +	int idx =3D frameno =3D=3D st->curframe ? env->insn_idx : st->frame[fra=
meno + 1]->callsite;
> +	int spi, first =3D bpf_get_spi(max_off - 1), last =3D bpf_get_spi(min_o=
ff);
> +	const unsigned long *mask =3D bpf_may_write_mask(env, idx);
> +
> +	spi =3D fixed_off ? find_next_zero_bit(mask, last + 1, first) : last + =
1;
> +	if (!fixed_off && find_next_bit(mask, last + 1, first) > last)
> +		spi =3D first;
> +	if (verifier_bug_if(spi <=3D last, env, "insn %d writes to fp%d outside=
 of may_write_mask",
> +			    idx, -(spi + 1) * BPF_REG_SIZE))
> +		return -EFAULT;
> +	return 0;
> +}

[Severity: Medium]
Can check_may_write_mask() hit a false verifier_bug_if() when a subprogram
fills a caller stack pointer from an ARG_IMPRECISE pointer and writes throu=
gh
it?

A subprogram at frame F > 0 can spill a stack pointer belonging to an older
ancestor frame (such as frame 0) into frame F's own stack.  When
arg_track_deref() dereferences a pointer with a single known ancestor frame
and an unknown offset, fill_from_stack() sets .mask =3D GENMASK(ptr->frame,=
 0)
to cover any older frame pointer spilled there.  However, for an
ARG_IMPRECISE pointer, arg_track_deref() returns *ptr unchanged:

kernel/bpf/liveness.c:arg_track_deref() {
	...
	if (ptr->frame >=3D 0 && ptr->frame < depth) {
		struct spill_snapshot *parent =3D env->callsite_at_stack[callsites[ptr->f=
rame]];

		return fill_from_stack(insn, at_out, reg, parent->at, parent->slots, ptr-=
>frame);
	}
	if (ptr->frame =3D=3D ARG_IMPRECISE && !(ptr->mask & BIT(depth)) && ptr->m=
ask)
		return *ptr;
}

If frame 1 spills a pointer to frame 0's stack into frame 1's stack, a
pointer to frame 1's stack is joined with a pointer to frame 2's stack
(producing ARG_IMPRECISE with mask =3D BIT(1) | BIT(2)), and frame 3 loads =
the
spilled frame 0 pointer from that joined pointer and writes through it,
record_imprecise() only marks FM_MAY_WRITE on frames 1 and 2.  Frame 0's
may_write_mask remains clear at its callsite, so check_may_write_mask()
triggers verifier_bug_if() and rejects the program with -EFAULT.

Should arg_track_deref() widen ptr->mask to GENMASK(fls(ptr->mask) - 1, 0) =
in
that case?

[ ... ]

> @@ -8032,6 +8061,13 @@ static int check_stack_range_initialized(
>  		max_off =3D reg_smax(reg) + off;
>  	}
> =20
> +	if (clobber && access_size) {
> +		err =3D check_may_write_mask(env, state->frameno, min_off, max_off + a=
ccess_size,
> +					   tnum_is_const(reg->var_off));
> +		if (err)
> +			return err;
> +	}

[Severity: Medium]
Can this check_may_write_mask() call trigger a false verifier_bug_if() when
the helper or kfunc size register is constant in const_reg_mask but widened
in do_check()?

When aux->const_reg_mask has the size register marked constant,
bpf_helper_stack_access_bytes() and bpf_kfunc_stack_access_bytes() bound
bpf_may_write_mask() using aux->const_reg_vals[size_reg] (for example, 8
bytes at fp-16).  During do_check(), sanitize_speculative_path() can call
mark_reg_unknown() on size_reg at a conditional jump on a speculative path,
and size_reg can then be bounded to a larger range such as [0, 16] before t=
he
call.  check_mem_size_reg() then calls check_stack_range_initialized() with
access_size =3D reg_umax(size_reg) (16) and tnum_is_const(reg->var_off) tru=
e, so
check_may_write_mask() requires both fp-16 and fp-8 to be set in
may_write_mask and hits verifier_bug_if() on fp-8.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/too=
ls/testing/selftests/bpf/progs/verifier_raw_stack.c
> index 0fe631411b9cc..d0975a28a2435 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> @@ -125,6 +125,41 @@ __naked void stack_skb_load_bytes_init(void)
>  	: __clobber_all);
>  }
> =20
> +/* The pointer is fp-128 or fp-96. At the loop header the two offsets ar=
e joined to a range. */
> +SEC("tc")
> +__description("raw_stack: store to one of two buffers")
> +__success __retval(0)
> +__naked void store_to_one_of_two_buffers(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r8 =3D r0;					\
> +	r1 =3D 0;						\
> +	*(u64*)(r10 - 144) =3D r1;			\
> +	*(u64*)(r10 - 120) =3D r1;			\
> +	*(u64*)(r10 - 88) =3D r1;				\
> +	r3 =3D r10;					\
> +	r3 +=3D -128;					\
> +	*(u64*)(r10 - 136) =3D r3;			\
> +l0_%=3D:	r8 *=3D 8;					\
> +	if w8 s> 100 goto l1_%=3D;			\
> +	r3 =3D r10;					\
> +	r3 +=3D -96;					\
> +	*(u64*)(r10 - 136) =3D r3;			\
> +	r4 =3D *(u64*)(r10 - 144);			\
> +	r4 +=3D 1;					\
> +	*(u64*)(r10 - 144) =3D r4;			\
> +	if r4 < 3 goto l0_%=3D;				\
> +l1_%=3D:	r3 =3D *(u64*)(r10 - 136);			\
> +	r1 =3D 7;						\
> +	*(u64*)(r3 + 8) =3D r1;				\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[Severity: Low]
Does store_to_one_of_two_buffers() actually reach the !fixed_off branch in
check_may_write_mask()?

Because the loop has max_header_count =3D 3 and r8 *=3D 8 is not linear,
bpf_flow_loop_enter() sets entry->apart =3D true and walks all 3 iterations
separately without widening at the loop header; moreover, join_reg() rejects
joining two PTR_TO_STACK registers with different offsets (fp-128 and fp-96=
).
As a result, r3 at *(u64 *)(r3 + 8) =3D r1 always has a constant var_off and
fixed_off is always true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109064715.2382=
452-1-alexei.starovoitov@gmail.com?part=3D9
