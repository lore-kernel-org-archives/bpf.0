Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793485533;
	b=wA2pSipmkuAVkjtPMS4esmFb3012v73rjqAjI4v+pV9g/OAUGFQmFv/QvTK1abIcX8Tx
	 lcOpckDfcir2PNh7tAc6csBhryF9D8LF9KP88QlqchJF3uVMdKINlaeIC/eOAxQH1vlMA
	 kcnl6p8IcFQ2KCOm/oQME1xS2303haV2khlUK7XTQ4aMnzlWuKausGbxAde/pszMcaWUc
	 /zOIioOmE/xnpnuc6C5a8r/k8yR07+PR8h2nxmWWqVPyV0Ny2w9aLx2qvKMIvi5ms3k/S
	 f03c4EDTnWORehhNcLgs+mfgib17dZM+G05J9BK8425JS/xkJl8Xi6I/CP/rfgzj8Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485533;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pLYW4PXkT93PPBs0iIDA+9tupwovTqGh9vLpYfzFMHE=;
	b=1lUVEac4zfnwwLO6pw2AMg3kWJXGxufSPwNoqzbyN3KBqFpm/tY0wStJyjchfuaxBPqw
	 HqImroGnjvfkKSTVukfz/uw/WBHKmHVQkcSsP5cTLXIvYvkymKrP+AMp+w5JCYaRE6zGV
	 38x2N0GxMrFUSBE1Rb7yRrO5L6/JCzUXUtaJQQb+qrqAxgmdwr61oauODTo3VzrL1TtMv
	 dBnbb5ZKovkbaU7HYnyAYlthv6lqNFNtVT7pPQr2wQNPIkyrkqg+nX2rKPH2ie+iry7TO
	 KXclEXZb8+7T/czfMuXROmbtMD+hdXFvFx3ryrXlKas9V+3dXxhTbl3gVRP0Ji02X9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f6bRMUF/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412F606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6bRMUF/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7961F000C1;
	Sat, 31 Oct 2026 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793485532;
	bh=pLYW4PXkT93PPBs0iIDA+9tupwovTqGh9vLpYfzFMHE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=f6bRMUF/PeHUVNjHuKoA1DTRJdRfKY2ta9x+v9JgsZCohBA1Vo/cuG7Q2+2PE3n6U
	 1jLLt2grTEID2IfHuQOQ6ru6fXYwGnPreoLULHNtknsqKsc9M07ut4Ut3z6ytdYiG9
	 rCHpLsKewcJOHqFOm67BNQqj60YClgTXWPYrgj1JI67Pa9i/n0ic4Oibmh8LlxV5b9
	 DN985zjsbtnSf1mcFYwiDT8QwqBDrJ3gVCB6VXK35ulK9fDqVtjsuXtBo3H8opXnt0
	 lFslAMxB1xuraZUPHM32NznUNq+x2+vQ7lfca4bcGrB39Wd8/QfJKKZRAth684B8Sa
	 8E1cjYBgcpgTA==
Message-ID: <sashiko-outbox-192205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 7/9] bpf: One may_goto time slice per prog
 invocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261031215543.682284-8-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
 <20261031215543.682284-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 22:25:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: 16-bit jump offset overflow in may_goto_expand_timed() unde=
r blinding
- [Medium] bpf: torn reads of cb->prog and cb->callback_fn in timer and wq =
callbacks
--

commit 382d62c2e4ba7bcffedca7ed4f3c49e710163db0
Author: Alexei Starovoitov <ast@kernel.org>

bpf: One may_goto time slice per prog invocation

This commit moves the timed may_goto count and timestamp from each subprog's
stack frame into per-CPU memory owned by the main program so that a single
250 ms time slice applies across an entire program invocation. It also saves
and restores the per-CPU timed may_goto state around asynchronous callbacks.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 5cbab55d84be0..66b9d1d9e961c 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1803,6 +1803,50 @@ static int may_goto_expand(struct bpf_insn *insn_b=
uf, int off, int stack_off,
>  	return cnt + tail_cnt;
>  }
> =20
> +/*
> + * Timed may_goto. All may_goto of a prog use one count and one timestam=
p: per-cpu memory of the
> + * prog, set in the first insns of the main prog, and by the callers of =
async callbacks.
> + * @reg holds the address. It is a register that is dead at the may_goto=
, or R0 that is saved at
> + * @save_off in the stack.
> + */
> +static int may_goto_expand_timed(struct bpf_insn *insn_buf, int off,
> +				 struct bpf_timed_may_goto __percpu *tmg, int reg, int save_off)
> +{
> +	struct bpf_insn ld_tmg[] =3D { BPF_LD_IMM64(reg, (__force unsigned long=
)tmg) };
> +	int cnt =3D 0, jmp, tail_cnt =3D save_off ? 6 : 5;
> +
> +	if (save_off)
> +		insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_10, reg, save_off);
> +	insn_buf[cnt++] =3D ld_tmg[0];
> +	insn_buf[cnt++] =3D ld_tmg[1];
> +	insn_buf[cnt++] =3D BPF_MOV64_PERCPU_REG(reg, reg);
> +	insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_AX, reg, 0);
> +	if (save_off) {
> +		insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
> +		insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, reg, BPF_REG_10, save_off);
> +		jmp =3D cnt++;
> +		insn_buf[jmp] =3D BPF_JMP32_A(off >=3D 0 ? off + tail_cnt : off - jmp);
> +	} else {
> +		jmp =3D cnt;
> +		off =3D off >=3D 0 ? off + tail_cnt : off - jmp;
> +		if (off =3D=3D (s16)off) {
> +			insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
> +		} else {
> +			insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
> +			insn_buf[cnt++] =3D BPF_JMP32_A(off >=3D 0 ? off : off - 1);
> +		}
> +	}

[Severity: Medium]
Can constant blinding cause the 16-bit jump offset in may_goto_expand_timed=
()
to overflow S16_MIN on backward branches?

When save_off is 0, may_goto_expand_timed() emits the 2-instruction
BPF_LD_IMM64(reg, tmg) into reg (one of BPF_REG_0..BPF_REG_9) before the
branch at jmp =3D 4. For a backward branch (orig_off < 0), off becomes
orig_off - 4, and if that fits in s16 (for example, orig_off in
[-32764, -32759]), it emits a 16-bit BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, of=
f)
instead of BPF_JMP32_A.

Later, when JIT constant blinding is enabled,
bpf_jit_blind_constants() -> bpf_jit_blind_insn() expands the 2-instruction
BPF_LD_IMM64(reg, tmg) into 7 or 8 instructions:

kernel/bpf/core.c:bpf_jit_blind_insn() {
	...
	case BPF_LD | BPF_IMM | BPF_DW:
		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ aux[1].imm);
		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
		*to++ =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
		*to++ =3D BPF_ALU64_REG(BPF_MOV, aux[0].dst_reg, BPF_REG_AX);
		break;
	case 0: /* Part 2 of BPF_LD | BPF_IMM | BPF_DW. */
		*to++ =3D BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ aux[0].imm);
		*to++ =3D BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
		if (emit_zext)
			*to++ =3D BPF_ZEXT_REG(BPF_REG_AX);
		*to++ =3D BPF_ALU64_REG(BPF_OR,  aux[0].dst_reg, BPF_REG_AX);
		break;
}

Because those 5 or 6 extra instructions are inserted between a backward jump
target and the 16-bit BPF_JEQ, bpf_adj_branches() -> bpf_adj_delta_to_off()
subtracts 5 or 6 from the 16-bit offset, underflowing S16_MIN and failing
blinding with -ERANGE. Since bpf_do_misc_fixups() sets prog->jit_required =
=3D 1,
the program cannot fall back to the interpreter and fails to load.

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 58e357302850e..2b75f7ba07a56 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1222,6 +1222,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrt=
imer *hrtimer)
>  {
>  	struct bpf_hrtimer *t =3D container_of(hrtimer, struct bpf_hrtimer, tim=
er);
>  	struct bpf_map *map =3D READ_ONCE(t->cb.map);
> +	struct bpf_prog *prog =3D READ_ONCE(t->cb.prog);
> +	struct bpf_timed_may_goto saved;
>  	void *value =3D t->cb.value;
>  	bpf_callback_t callback_fn;
>  	void *key;
> @@ -1229,7 +1231,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrt=
imer *hrtimer)
> =20
>  	BTF_TYPE_EMIT(struct bpf_timer);
>  	callback_fn =3D rcu_dereference_check(t->cb.callback_fn, rcu_read_lock_=
bh_held());
> -	if (!callback_fn || !map)
> +	if (!callback_fn || !map || !prog)
>  		goto out;
> =20
>  	/* bpf_timer_cb() runs in hrtimer_run_softirq. It doesn't migrate and
> @@ -1242,8 +1244,10 @@ static enum hrtimer_restart bpf_timer_cb(struct hr=
timer *hrtimer)
> =20
>  	key =3D map_key_from_value(map, value, &idx);
> =20
> +	bpf_timed_may_goto_save(prog, &saved);
>  	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
>  	/* The verifier checked that return value is zero. */
> +	bpf_timed_may_goto_restore(prog, &saved);
> =20
>  	this_cpu_write(hrtimer_running, NULL);
>  out:
> @@ -1254,6 +1258,8 @@ static void bpf_wq_work(struct work_struct *work)
>  {
>  	struct bpf_work *w =3D container_of(work, struct bpf_work, work);
>  	struct bpf_async_cb *cb =3D &w->cb;
> +	struct bpf_timed_may_goto saved;
> +	struct bpf_prog *prog;
>  	struct bpf_map *map;
>  	bpf_callback_t callback_fn;
>  	void *value =3D cb->value;
> @@ -1267,14 +1273,17 @@ static void bpf_wq_work(struct work_struct *work)
> =20
>  	map =3D READ_ONCE(cb->map);
>  	callback_fn =3D READ_ONCE(cb->callback_fn);
> -	if (!callback_fn || !map)
> +	prog =3D READ_ONCE(cb->prog);
> +	if (!callback_fn || !map || !prog)
>  		goto out;
> =20
>  	key =3D map_key_from_value(map, value, &idx);
> =20
>  	migrate_disable();
> =20
> +	bpf_timed_may_goto_save(prog, &saved);
>  	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	bpf_timed_may_goto_restore(prog, &saved);

[Severity: Medium]
What prevents bpf_timer_cb() and bpf_wq_work() from reading a mismatched pa=
ir
of cb->prog and cb->callback_fn when bpf_async_update_prog_callback() runs
concurrently?

In bpf_async_update_prog_callback(), cb->prog and cb->callback_fn are updat=
ed
with two separate lockless stores:

kernel/bpf/helpers.c:bpf_async_update_prog_callback() {
	...
	do {
		if (prog)
			prog =3D bpf_prog_inc_not_zero(prog);
		prev =3D xchg(&cb->prog, prog);
		rcu_assign_pointer(cb->callback_fn, callback_fn);
	...
}

When two programs share a map containing a bpf_timer or bpf_wq and update t=
he
callback concurrently while the timer or workqueue fires, bpf_timer_cb() or
bpf_wq_work() can read prog from one program and callback_fn from the other.

If that happens, bpf_timed_may_goto_save() and bpf_timed_may_goto_restore()
will save, initialize, and restore the wrong program's per-CPU
timed_may_goto state while callback_fn accesses its own program's
timed_may_goto. If the callback's program still has count =3D=3D 0 on this =
CPU
(because its main program has not run on this CPU yet or previously timed
out), its timed may_goto loops will terminate immediately on the first
iteration, or if it interrupted its own main program on the same CPU, the
interrupted invocation's count and timestamp will not be saved and restored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031215543.6822=
84-1-alexei.starovoitov@gmail.com?part=3D7
