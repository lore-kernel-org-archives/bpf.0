Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474391;
	b=OYoD+NOZRtm753DYt94TarDu9MBDCUKTUh61HGnKr7VxTwbezKp8QQUv2v1EswxvoKip
	 mzUEuTcFBNXIiUcUO0Ljy67nABmKVWcV/9CIG6+7YIKRwnir47BZpRBvV83N7i6YdjmKG
	 eeldxPkuhoaRPj8B1kx7oJapFnV0Ki0fGO++7MNKXjPJp4381MpXaaWYLzBJIpcn84uI4
	 T5xm7J8WnS1xz23dyeTzbLcrfKupb6/SCee+noc+u073Fj1emXnOvDIdjvZ1oJlLIje0n
	 uaq3wZNl1oKk2AY/ktViany6Ahe4fhuw0bjWHwa67I0vS4sjug358+tRTtDdn8P1xVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A9HHJXG5O25Y/dj3ZyXVK5FhhU94yHMKuHqjMxaZ5ME=;
	b=crnz7n4FQswulZQFZQpXzwyhM22yzCQKDeUW8ZzprIPSAl77x2Nzd0sD+bb3/XAuSO9e
	 2TG4weqIzQUDUUYCjZVbxAdBVFpwf5cC5uDhNplGKJz25J6j2Qa8EOl18Qjw+MYrsKJq1
	 939XcavTdsh+OvCJA1D8ADtXq9ZpHwG/RALqAW7TMKzarEAT8rjVZs/Ws5g2CEmEPzGWB
	 4wp1r57Xy6B9rkhwH+NtIR9i3F76+AM/ig8IRxYLU0Q8NL+FPE0pbpSGZjhSUhgcJhNGP
	 bnhGpQ+uu1XIn1dVISND7yMBVPHxPBKnRJj7hNd4Ae9kJ5xjXLvGGxx+R4mowGxnNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmDjXFCM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB584606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmDjXFCM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7044C1F000D0;
	Mon, 23 Nov 2026 22:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474391;
	bh=A9HHJXG5O25Y/dj3ZyXVK5FhhU94yHMKuHqjMxaZ5ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmDjXFCMRolgFuTCN/6Jhhy0x+1k1ItuKXTlnj3eO+fOEPTAurp+4YOnxMeSj3JW3
	 ncBBQEmjfk4ZcBYiptaMA6IQ250VJwzrn/oMm72ufEp0eolbahvY6ywTxHC8fzJ9d5
	 XXl9Ze8mq3jpRIbT2DDF8jmbxUuHa7dOpqX2RG3el2IRwVevDydKDZEGn/smoW9nS7
	 8TFfINmNkD48+2eYF+zDUKreW4Wgnf0tmxEgqr8dqRLRUncLin3jOrI/MnNYnHoJ4z
	 FRyG3cUJcbru4AF3+qsOcc5u3QVjF8xkPD2JsILvjQXUqKSQJ7q2/JwIHaxm9nqu7n
	 s0S0yJvM5zSJA==
Message-ID: <sashiko-outbox-230162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/7] libbpf: Support CO-RE relocation of
 tracing program arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <almagui@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123223227.745345-2-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
 <20261123223227.745345-2-almagui@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:53:11 +0000
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
- [Medium] libbpf: wrong big-endian relocation for signed sub-8-byte
  tp_btf args
- [Medium] libbpf: pointer argument size and offset mismatch on 32-bit
  target BTF
- [Low] libbpf: multi-line comment style and misplaced comment in
  relo_core.c
--

commit 966987a90447045d3ff50e58c43a513399cdbc27
Author: Alan Maguire <almagui@kernel.org>

libbpf: Support CO-RE relocation of tracing program arguments

This commit adds CO-RE relocation support for tracing program arguments
described by structs tagged with __bpf_func_args and introduces the
BPF_PROG_CORE() convenience macro.

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 2672623a41989..2f6627952220b 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
[ ... ]
> +	/* sub-8-byte arguments live in the low-order bytes of their slot,
> +	 * including structs and unions passed by value, which, e.g., s390
> +	 * passes in registers like integers of the same size
> +	 */
> +	sz =3D btf__resolve_size(targ_btf, type_id);
> +	if (btf_is_big_endian(targ_btf) && sz > 0 && sz < 8)
> +		slot_off +=3D 8 - sz;
[ ... ]
> @@ -734,10 +1092,17 @@ static int bpf_core_calc_field_relo(const char *pr=
og_name,
>  		return 0;
>  	}
> =20
> -	m =3D btf_members(t) + acc->idx;
> -	mt =3D skip_mods_and_typedefs(spec->btf, m->type, &field_type_id);
> +	if (btf_kind(t) =3D=3D BTF_KIND_FUNC) {
> +		/* function argument (or return value), never a bitfield */
> +		mt =3D skip_mods_and_typedefs(spec->btf, func_arg_type(spec->btf, t, a=
cc->idx),
> +					    &field_type_id);
> +		bit_sz =3D 0;
> +	} else {
> +		m =3D btf_members(t) + acc->idx;
> +		mt =3D skip_mods_and_typedefs(spec->btf, m->type, &field_type_id);
> +		bit_sz =3D btf_member_bitfield_size(t, acc->idx);
> +	}

[Severity: Medium]
Does relocating a pointer argument against 32-bit target BTF downsize the
context load to 4 bytes and misalign the offset on 32-bit big-endian
targets?

Unlike func_arg_slot_sz(), which checks btf_is_ptr(t) and returns 8,
bpf_core_calc_field_relo() falls through to btf__resolve_size() for
BTF_KIND_FUNC arguments.  On 32-bit target BTF, btf__resolve_size()
returns 4 for BTF_KIND_PTR, so bpf_core_patch_insn() shrinks the 8-byte
context load to BPF_W, and bpf_core_match_func_arg() adds 4 to slot_off on
big-endian targets.  However, context slots are always u64 and
btf_ctx_access() requires pointer loads from the context array to be
8-byte aligned with size =3D=3D sizeof(u64), so the verifier will reject the
program.

[ ... ]

> @@ -893,6 +1258,38 @@ static int bpf_core_calc_enumval_relo(const struct =
bpf_core_relo *relo,
>   * with each other. Otherwise, libbpf will refuse to proceed due to ambi=
guity.
>   * If instruction has to be poisoned, *poison will be set to true.
>   */
> +/* Whether a target spec refers to an integer or enum function argument =
(or
> + * return value), rather than to a member of a struct passed by value, t=
hat is
> + * smaller than 8 bytes on a big-endian target. Such arguments are in the
> + * low-order bytes of their context slot, where the verifier doesn't all=
ow
> + * loads, but the calling conventions of big-endian architectures with B=
PF
> + * trampolines (s390x, powerpc64) extend them to 64 bits.
> + */

[Severity: Low]
This isn't a bug, but bpf_core_is_be_small_func_arg() is inserted between
the function comment for bpf_core_calc_relo() and bpf_core_calc_relo()
itself.  Also, the new multi-line comments in tools/lib/bpf/libbpf.c,
tools/lib/bpf/relo_core.c, and tools/lib/bpf/relo_core.h place text on the
opening /* line rather than putting /* on its own line per BPF comment
style.

> +static bool bpf_core_is_be_small_func_arg(const struct bpf_core_spec *sp=
ec,
> +					  bool *is_signed)
> +{
> +	const struct bpf_core_accessor *acc;
> +	const struct btf_type *t;
> +	__u32 id;
> +	__s64 sz;
> +
> +	if (spec->len !=3D 2 || !btf_is_big_endian(spec->btf))
> +		return false;
> +	acc =3D &spec->spec[1];
> +	t =3D btf_type_by_id(spec->btf, acc->type_id);
> +	if (!t || btf_kind(t) !=3D BTF_KIND_FUNC)
> +		return false;
> +	t =3D skip_mods_and_typedefs(spec->btf, func_arg_type(spec->btf, t, acc=
->idx), &id);
> +	if (!t || (!btf_is_int(t) && !btf_is_any_enum(t)))
> +		return false;
> +	sz =3D btf__resolve_size(spec->btf, id);
> +	if (sz <=3D 0 || sz >=3D 8)
> +		return false;
> +	*is_signed =3D (btf_is_any_enum(t) && BTF_INFO_KFLAG(t->info)) ||
> +		     (btf_is_int(t) && (btf_int_encoding(t) & BTF_INT_SIGNED));
> +	return true;
> +}
[ ... ]
> @@ -1100,6 +1506,38 @@ int bpf_core_patch_insn(const char *prog_name, str=
uct bpf_insn *insn,
>  			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
>  		}
> =20
> +		if (res->widen_func_arg && class =3D=3D BPF_LDX) {
> +			__u8 mode =3D BPF_MODE(insn->code);
> +
> +			if (insn_bpf_size_to_bytes(insn) !=3D res->orig_sz) {
> +				pr_warn("prog '%s': relo #%d: insn #%d (LDX) unexpected mem size: go=
t %d, exp %u\n",
> +					prog_name, relo_idx, insn_idx,
> +					insn_bpf_size_to_bytes(insn), res->orig_sz);
> +				return -EINVAL;
> +			}
> +			/* An 8-byte load of the whole slot yields the argument
> +			 * as extended to 64 bits by the calling convention,
> +			 * which is what the original load yields only if it
> +			 * extends it the same way.
> +			 */
> +			if (!(mode =3D=3D BPF_MEM && !res->func_arg_signed) &&
> +			    !(mode =3D=3D BPF_MEMSX && res->func_arg_signed &&
> +			      res->orig_sz =3D=3D res->new_sz)) {
> +				pr_warn("prog '%s': relo #%d: insn #%d (LDX) can't load function arg=
ument smaller than 8 bytes on big-endian target. "
> +					"Make sure to use zero-extending loads of unsigned integers or sign=
-extending loads of signed ones.\n",
> +					prog_name, relo_idx, insn_idx);
> +				return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
> +			}
> +
> +			orig_val =3D insn->off;
> +			insn->off =3D res->func_arg_slot_off;
> +			insn->code =3D BPF_LDX | BPF_MEM | BPF_DW;

[Severity: Medium]
For tp_btf programs on big-endian targets, does widening a BPF_MEMSX load
of a signed sub-8-byte argument to BPF_DW corrupt negative values?

Unlike BPF trampolines, raw tracepoint probes populate context slots via
__CAST_TO_U64() in include/trace/bpf_probe.h:

include/trace/bpf_probe.h:__CAST_TO_U64() {
#define __CAST_TO_U64(x) ({ \
	typeof(x) __src =3D (x); \
	UINTTYPE(sizeof(x)) __dst; \
	memcpy(&__dst, &__src, sizeof(__dst)); \
	(u64)__dst; })
}

Because __CAST_TO_U64() copies the argument into an unsigned integer of
the same width before casting to u64, sub-8-byte signed tracepoint
arguments are always zero-extended in their 64-bit context slot rather
than sign-extended.  Treating res->func_arg_signed as true for tp_btf
candidates causes bpf_core_patch_insn() to rewrite BPF_MEMSX loads into
BPF_DW loads that leave zeros in the upper 32/48/56 bits of negative
values, while poisoning BPF_MEM loads that would have read the
zero-extended slot value as expected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123223227.7453=
45-1-almagui@kernel.org?part=3D1
