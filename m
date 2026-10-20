Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515472;
	b=akfYQOm3bpxCGI4H8dvYgEXdRaJIqeRfNTgaaAIGSA08EhzG9bEz2tAxqaaX+OV2lGIh
	 ciwsdX6heRD6jFEI1fDjtqku9rJyHv+u4at15mkGW/EC1W1z+IL5rIMAdBI07QQDcZPZ+
	 B94IVHBpJS79AJpooH9yY6HGLQE2qnvyYq8Vzw05mmrrmQ3kFBeZ4LtJ8eufWCU0ZI6Np
	 rcGefmjCZPOoZlQFAjlvfZ/lf8Rwoq4mrLC3pzHVLPfl55BtFtiI20RgP8XYOmUSbTRn5
	 +87ZKkjvgYeqXJXxd9onXtShGG2REyQMcOJgxoGvXkd3PCx6tJ8eo7dySOpXSsX/eTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515472;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0mP4kUJV9Dub/xcube8/VUquTAKht52U1uQexTyPAHU=;
	b=bCHaG0Jel1hDgBHViyfeSnhFawKmJq4BiLgu1pTqlmnFDWo0i1Lz4nmH3Vw9B5rYT+Ct
	 grmQLkYwTcbzr+e/a0+hjnws7SNeHQ6q6LgMx0ovKKKioNFa11aVYCHv1s4V3NQCnE0ED
	 ll78tWfG8YR5ze4PCRtS2trICGzbfQR/Ug2k792MNj7tGAiHBy2Y7zL5UgnbnsbvdRZlJ
	 Sk5d8rH4uI0NXF3zh9Vf3yUvYSrUsw6qm5m5bBbhHg5UYa+bfrqmJZ0bfwLDd+r4d3EMf
	 f8wjmS5fgrMh0ZaoJZu77/w/CeRrexK/8a7Fq/Wa89qRx8uNtdZK81m6FpIEueB22WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B22606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307EF1F000C9;
	Tue, 20 Oct 2026 16:57:52 +0000 (UTC)
Message-ID: <sashiko-outbox-179390@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 06/12] bpf: Track low-32 scalar equality
 across sign-extending movs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261020161907.2115379-7-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-7-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:57:21 +0000
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
- [Medium] bpf: empty range after reg_bounds_sync() in sync_linked_regs()
--

commit ad01f18c15eb8cfa9a97b984758db9dd254aace2
Author: Vineet Gupta <vineet.gupta@linux.dev>

bpf: Track low-32 scalar equality across sign-extending movs

This commit adds BPF_REG_LINK_SEXT to track low-32 scalar equality across
32-bit sign-extending moves, using sext_32_to_64() and tnum_sext() to
propagate bounds in sync_linked_regs().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6afd718ede647..4621b476b206e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -6090,6 +6090,25 @@ static void zext_32_to_64(struct bpf_reg_state *re=
g)
>  	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
>  }
> =20
> +/*
> + * The sign-extending counterpart. Signed bounds carry over directly bec=
ause
> + * sign extension is monotonic over the signed 32-bit range.
> + */
> +static void sext_32_to_64(struct bpf_reg_state *reg)
> +{
> +	/*
> +	 * See comment at reg_step_check_unsigned(). Sign extension subtracts
> +	 * 2^32 from every value with bit 31 set, which preserves a residue
> +	 * mod step only when step divides 2^32, so the line cannot be kept.
> +	 * The zero-extending twin calls reg_step_check_unsigned(reg, 32) for
> +	 * the same reason; the unsigned form does not apply here because the
> +	 * result is not the low 32 bits but the low 32 bits moved.
> +	 */
> +	reg_step_reset(reg);
> +	reg->var_off =3D tnum_sext(reg->var_off, 4);
> +	reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
> +}
[ ... ]
> @@ -18795,9 +18843,26 @@ static void sync_linked_regs(struct bpf_verifier=
_env *env, struct bpf_verifier_s
>  			scalar32_min_max_add(reg, &fake_reg);
>  			scalar_min_max_add(reg, &fake_reg);
>  			reg->var_off =3D tnum_add(reg->var_off, fake_reg.var_off);
> -			if (reg->link_kind =3D=3D BPF_REG_LINK_ZEXT ||
> -			    known_reg->link_kind =3D=3D BPF_REG_LINK_ZEXT)
> +			if (reg->link_kind =3D=3D BPF_REG_LINK_SEXT) {
> +				sext_32_to_64(reg);
> +			} else if (reg->link_kind =3D=3D BPF_REG_LINK_ZEXT ||
> +				   known_reg->link_kind =3D=3D BPF_REG_LINK_ZEXT ||
> +				   known_reg->link_kind =3D=3D BPF_REG_LINK_SEXT) {
> +				/*
> +				 * Either @reg is itself the zero extension, or
> +				 * @reg has no 32-bit kind and @known_reg does
> +				 * -- the reverse direction, where the guard
> +				 * above has already proved @reg fits 32 bits.
> +				 * Then @reg is @known_reg's low half with
> +				 * nothing above it, whichever way @known_reg
> +				 * filled its own high half, so the zero
> +				 * extension is the reconstruction for both
> +				 * kinds. BPF_REG_LINK_FULL is not here on
> +				 * purpose: it relates all 64 bits and must not
> +				 * be truncated.
> +				 */
>  				zext_32_to_64(reg);
> +			}
>  			/*
>  			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
>  			 * link over a wide base does not propagate back, so the

[Severity: Medium]
Can sync_linked_regs() leave reg with CNUM64_EMPTY and CNUM32_EMPTY after
reg_bounds_sync(), triggering a register invariants violation on the next
instruction that inspects the register?

At the end of the differencing block in sync_linked_regs():

	cnum64_intersect_with(&reg->r64, prev.r64);
	cnum32_intersect_with(&reg->r32, prev.r32);
	reg->var_off =3D tnum_intersect(reg->var_off, prev.var_off);
	if (range_bounds_violation(reg))
		*reg =3D prev;
	reg_bounds_sync(reg);

range_bounds_violation(reg) is only checked before reg_bounds_sync(reg),
and tnum_intersect() is called without checking tnum_overlap(). When a
contradiction occurs across domains (between r64, r32, and var_off) rather
than within r64 or r32 individually, the pre-sync range_bounds_violation()
check passes, and reg_bounds_sync(reg) then turns the cross-domain
disjointness into CNUM64_EMPTY / CNUM32_EMPTY without restoring prev.

This can be triggered in two ways with BPF_REG_LINK_SEXT:

1. Cross-domain contradiction between r64 and r32 via sext_32_to_64():

   Suppose r6 is a 64-bit unknown scalar and r7 =3D (s32)r6 links r7 to r6
   with BPF_REG_LINK_SEXT.

   - Narrow r7 with signed 64-bit jumps to [-0x7ffffff0, 0x7ffffff0], so
     r7.r64 is [-0x7ffffff0, 0x7ffffff0] and r7.r32 is the arc
     [0x80000010, 0x7ffffff0].
   - Execute if w6 < 0x7ffffff0 goto out. Because [0x7ffffff0, 0xffffffff]
     and [0x80000010, 0x7ffffff0] overlap in two disjoint arcs,
     cnum32_intersect() over-approximates by keeping the smaller arc
     [0x7ffffff0, 0xffffffff] for r6.r32 and r7.r32, while r7.r64 remains
     [-0x7ffffff0, 0x7ffffff0].
   - Execute if w6 !=3D w8 goto out where w8 has r32 =3D [0x7ffffff8, 0x800=
00007].
   - In sync_linked_regs() for r7, reg->r32 is [0x7ffffff8, 0x80000007],
     which straddles S32_MAX / S32_MIN. sext_32_to_64(reg) sets reg->r64 to
     [S32_MIN, S32_MAX].
   - Intersecting reg->r64 with prev.r64 gives [-0x7ffffff0, 0x7ffffff0]
     (non-empty) and intersecting reg->r32 with prev.r32 gives
     [0x7ffffff8, 0x80000007] (non-empty).
   - range_bounds_violation(reg) is false, so *reg =3D prev is skipped.
   - reg_bounds_sync(reg) calls deduce_bounds_32_from_64(reg), which
     intersects [0x7ffffff8, 0x80000007] with [0x80000010, 0x7ffffff0] and
     leaves reg->r32 =3D CNUM32_EMPTY and reg->r64 =3D CNUM64_EMPTY.

2. Contradiction between var_off and r64/r32 via tnum_intersect():

   Suppose r6 is a 64-bit unknown scalar, r7 =3D (s32)r6, and r7 is narrowed
   to [-4, 3].

   - Execute if w6 & 8 goto out. On the fallthrough branch,
     regs_refine_cond_op() calls __mark_reg_unbounded(&r6) and clears bit 3
     in var_off; sync_linked_regs() narrows r7 to [0, 3] with
     var_off =3D TNUM(0, 3).
   - Execute if w6 & 4 goto target. On the taken branch, r6 gets low-32
     var_off =3D TNUM(4, 0xfffffff3) and r32 =3D [-0x7ffffffc, 0x7ffffff7].
   - In sync_linked_regs() on r7, cnum64_intersect_with() and
     cnum32_intersect_with() both produce [0, 3] (non-empty), while
     tnum_intersect() without a tnum_overlap() check combines
     TNUM(4, 0xfffffffffffffff3) and TNUM(0, 3) into TNUM(4, 3) ([4, 7]).
   - range_bounds_violation(reg) is false before reg_bounds_sync(reg), and
     __update_reg_bounds() inside reg_bounds_sync(reg) then intersects
     [0, 3] with [4, 7], leaving r7 with CNUM32_EMPTY and CNUM64_EMPTY.

Should sync_linked_regs() check !tnum_overlap(reg->var_off, prev.var_off)
and also check range_bounds_violation(reg) after reg_bounds_sync(reg) before
committing the updated state?

>  			/*
>  			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
>  			 * link over a wide base does not propagate back, so the

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020161907.2115=
379-1-vineet.gupta@linux.dev?part=3D6
