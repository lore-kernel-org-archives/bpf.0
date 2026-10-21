Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792542121;
	b=jVpCZdS4rkkVu5UujdSdObXGUfK5Lx3rI6T9M+jpU2uag+v8AsLbXYHY15ZWAj9DKtMF
	 TtNHa7di8vtpCcVhWexM3tit6WEMMWSCJ6WRWv5MHqJSJn6ex5dUEPXQ19Tpgrwf6iPQl
	 HZJZGCGmkjQwwpAkCWWt8nky7ABQ84TZDa5cawj/b0/+h7YqbEx7bZ1U2liW5sQRExfGO
	 Ar8xWu7C7c77sYawUKDPj+4rB8E4gGLoL224iEzuSjEpnAsCtxmWgOu6duH+LbTtsh44u
	 2K6GOZUMs+ss7pnryMVFn+iWkq5OttI6lb/mlotOqc+uMuDlCDDpPjidUmoMm0pyJ2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792542121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=klbd5TD47tid/c2avJ6ZpjlEUJJtuX4v6HKBV8mzwmo=;
	b=BJYyRjG3rdH7Gwo/XaP9PrFlDFF5KpO1/OIKUjwbGfHLErKmu/JmtbKKeMV+8b1ZFLfP
	 jwwwVfNcQTjiThMXl72zhv9hAeIEYts+lR72N2buV4DTYvMDAeN/xhPjuoiaYQT1dyPEn
	 6lIBGOob8zVDIp11g8Xfo8Qnib5zfUG8DJb62GLnQ83IfyHOPWix2eKnCw/4LF3zbFswa
	 MRmjozccvOHLsCwn+muJpzOtD2RZSxm+v6WLQtofwXo42K/37LYvjOliZmgZhzd7yYIEH
	 w+F+6b8N/mTVItXFSbYagN6yeo8SEc5hFDkpO80aVBnJEQercIWFr330m7YnA1Azm9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lv4rcuXz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE17606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lv4rcuXz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A586F1F000C9;
	Wed, 21 Oct 2026 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792542120;
	bh=klbd5TD47tid/c2avJ6ZpjlEUJJtuX4v6HKBV8mzwmo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Lv4rcuXzmebm4PcMc8WklthU2oV+tSDtff8fkbPUFPaFjf+Xr67aEMxWuFzBqmjez
	 I8E9qjy9Xtsp1qk1mOtsgOTxJHUC3bI80+TSPGu/KXuaNk6BHbUzS4XbDKfyKgZ52n
	 Cd4Sj9c2PSlVVYsa4w+nKAO8MqbfkG0e0nrK97PDyjwfRARXKsoKE3RGxbu9u6p20G
	 vYGdE38QpXK93k3mOo28O1eWRm9+82JIkpMXO72flmkRULqrN3H31XngzcBFFbxF8j
	 qkKIdhz4eNhOSgn6miClwl5P4XxKU2OZTqrEo8VmCY4D2prnAF/VmivyPxbALqnapR
	 KU9Wv43Eud1qw==
Message-ID: <sashiko-outbox-179631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: reject pointer operands for 32-bit
 recurrences/latches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261020234705.375067-1-eddyz87@gmail.com>
References: <20261020234705.375067-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 00:22:00 +0000
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
- [Critical] bpf: 32-bit pointer recurrences not rejected in bpf_compute_lo=
op_iters()
- [High] bpf: missing pointer and type checks for linear SCEV widening and =
clamping
--

commit ea9c83878323b0365b4124b8b3e8c881f6513530
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: reject pointer operands for 32-bit recurrences/latches

This commit updates scev_value_compatible() to reject pointer operands when
the loop latch uses a 32-bit comparison or a 32-bit recurrence, preventing
loop iteration counts from being inferred solely from pointer offsets.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index fea77772ca967..44916071c16bb 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -2024,7 +2024,8 @@ static void log_incompatible_scev_values(struct bpf=
_verifier_env *env, const cha
>  }
> =20
>  static bool scev_value_compatible(struct bpf_verifier_env *env, struct b=
pf_func_state *st,
> -				  const struct scev_value *a, const struct scev_value *b)
> +				  const struct scev_value *a, const struct scev_value *b,
> +				  const struct linear_latch *latch)
>  {
>  	const struct bpf_reg_state *ra, *rb;
> =20
> @@ -2035,7 +2036,7 @@ static bool scev_value_compatible(struct bpf_verifi=
er_env *env, struct bpf_func_
>  	}
>  	ra =3D scev_reg_for_read(env, st, a->ptr_reg);
>  	rb =3D scev_reg_for_read(env, st, b->ptr_reg);
> -	if (ra && rb && bpf_same_memory_origin(ra, rb))
> +	if (ra && rb && bpf_same_memory_origin(ra, rb) && !latch->zext32 && !la=
tch->jmp32)
>  		return true;

[Severity: Critical]
Checking !latch->zext32 && !latch->jmp32 in scev_value_compatible() only
rejects 32-bit pointer recurrences when the pointer register is one of the
latch comparison operands in compute_max_iters(). What happens if the loop
iteration count is bounded by a separate scalar latch, while another live
pointer register undergoes a 32-bit linear recurrence in the loop body (for
example, w1 =3D w1; w1 +=3D 8)?

In kernel/bpf/scev.c, is_simple_linear() matches both 64-bit and 32-bit
linear recurrences:

static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs=
 *out)
{
	u32 base, slope;

	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) &&
	       is_reg(scev, base, &out->base_reg) &&
	       is_imm(scev, slope, &out->slope) &&
	       out->slope <=3D S16_MAX &&
	       out->slope >=3D S16_MIN &&
	       out->slope !=3D 0;
}

Then bpf_compute_loop_iters() accepts the register for widening because
is_widenable_reg_type(reg) allows pointer register types without checking
coefs.zext32:

		r_scev =3D header_env->reg2scev[r];
		reg =3D scev_reg_for_linear(cur_func, r);
		/* If SCEV for r is (linear <reg> <slope>) */
		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_typ=
e(reg)) {

At loop entry, bpf_widen_scev_regs() calls linear_bounds() on the pointer
register with coefs.zext32 set:

	if (coefs->zext32) {
		r32 =3D cnum32_from_cnum64(r64);
		r64 =3D cnum64_zext32(r32);

This truncates and zero-extends the pointer's tracked offset at 32 bits
while keeping reg->type as a pointer (for example, turning a negative stack
pointer offset such as [-16, -8] into [0xfffffff0, 0xfffffff8]).

Furthermore, when env->allow_ptr_leaks is enabled, 32-bit operations in the
loop body such as w1 =3D w1; w1 +=3D 8 convert r1 into a scalar holding the
truncated 32-bit runtime address. When the backedge reaches the loop header,
bpf_clamp_scev_regs() computes linear_bounds() from entry_reg's pointer
offset and intersects that offset range with the backedge scalar in reg:

		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
		bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);
		bounds.r32 =3D cnum32_intersect(reg->r32, bounds.r32);
		if (cnum64_is_empty(bounds.r64)) {
			verifier_bug(env, "scev clamp produced empty range for r%d", r);
			return -EFAULT;
		}

Can this either clamp the runtime-address scalar to the small pointer offset
range (allowing out-of-bounds memory access if the scalar is subsequently
added to a pointer) or produce an empty intersection and trigger
verifier_bug() if the scalar was narrowed in the loop body?

> =20
>  incompatible:
> @@ -2267,7 +2268,7 @@ static bool compute_max_iters(struct bpf_verifier_e=
nv *env,
>  		}
>  		return false;
>  	}
> -	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
> +	if (!scev_value_compatible(env, st, &initial_val, &bound_val, latch))
>  		return false;
> =20
>  	initial =3D initial_val.value;

[Severity: High]
Related to the issue above, can a pointer register at loop entry also be
degraded to a scalar in the loop body even when coefs.zext32 is false,
causing bpf_clamp_scev_regs() to intersect a backedge scalar range with
loop-entry pointer offset bounds?

In kernel/bpf/scev.c:transfer(), a 64-bit native-endian byte swap (such as
r1 =3D le64 r1 on a little-endian host) sets need_bswap to false and op to =
0,
treating the instruction as an identity operation in the expression graph:

			need_bswap =3D class =3D=3D BPF_ALU64 || ((x_or_k =3D=3D BPF_TO_LE) !=3D=
 little_endian);
			switch (insn->imm) {
			case 16: op =3D need_bswap ? BSWAP16 : ZEXT16; break;
			case 32: op =3D need_bswap ? BSWAP32 : ZEXT32; break;
			case 64: op =3D need_bswap ? BSWAP64 : 0; break;
			default:
				goto mark_dst_unknown;
			}

			id =3D reg2expr[dst];
			if (op)
				id =3D expr1(scev, op, reg2expr[dst]);

If a loop body executes r1 =3D le64 r1; r1 +=3D 8 on a register that holds a
pointer at loop entry, transfer() produces a 64-bit linear recurrence with
coefs.zext32 =3D=3D false, while check_alu_op() degrades r1 to an unbounded
scalar value.

When bpf_clamp_scev_regs() runs on the backedge, it does not check whether
entry_reg and reg have matching register types before clamping reg to the
bounds computed from entry_reg:

		entry_reg =3D scev_reg_for_linear(entry_st, r);
		reg =3D scev_reg_for_linear(cur_func_state, r);
		if (!entry_reg || !reg || entry_reg->type =3D=3D NOT_INIT || reg->type =
=3D=3D NOT_INIT ||
		    is_unbound_scev_reg(env, entry_st, r))
			continue;

		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
		bounds.r64 =3D cnum64_intersect(reg->r64, bounds.r64);

Should bpf_compute_loop_iters() reject coefs.zext32 on non-scalar registers,
and should transfer() or bpf_clamp_scev_regs() also ensure that a pointer
register at loop entry is not widened or clamped when degraded to a scalar
in the loop body?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020234705.3750=
67-1-eddyz87@gmail.com?part=3D1
