Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD4359A8B
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120345; cv=none; b=fTnmodEbGILE2Yi1c3Z9U+aTfT4MAJdPdui1HAlOxWBXPfMclIN0o5d8z4yrXKynmEmnHmyO3NC6rgcT93TFVL7F+8PwhTw06dp1l2BbndIQ1NoTQIXnt6OYsXbVL3PBGOy5SK/tDkZae3vpLzgVdOjO8EFmaHY3ER9QR9HNJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120345; c=relaxed/simple;
	bh=jLpM1i05WChNJ6WZ+7jJqGYliIwUpFZOD2bWQhAfGDM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISB212uPxa+E1B3VWFt67vL7FQ/pxXkpooniOy8rnVm/sc1FkuVu8osP/vn2zT+QsKXm7dqnq+31N11Ul0tlT29twX9vFjo8GdH7zlBHReMc3ylVjFieeIffpoHsycUv64ith1pamC78nVAj5Us3fahTqhJ58R1uqQAEe10xcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfllF4r4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfllF4r4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d53197d8b5so6259375ad.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 23:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787120343; x=1787725143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u5l8dnkr/yHalhwaTD/AI1VND/JkaBHroOE0z5e0vto=;
        b=nfllF4r4YfqAcKrlEKUAWNdzDZM7+gUGZSCsc7dHP+JfFUVopj7qRi7NkTaa14+2ZF
         LG1uF0MoI3o7MOgsbU2BuSeSCfhHahuwo036We/owLYjVP9S8IlpXvB7+HX4bkbuf6Iy
         NWYbQOybQ8Mf4Cq08NESlkZgZqKiwKZ1F0B/nUx1n2H3Yw40cesk9mhQr24PI0DtTVuR
         fnQzbGKmjNjigkXgdAXYAMSTna5q5vUQPoNJEbql/Z0AG+mXIctbR6INEvyrttUOvR+W
         PQ9o9egTwwFVwC1W9jUP1H+bZ8SdnzRg2mBMuNLYurewTbbZzH7/rPcmeegp3TSJze48
         Vfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787120343; x=1787725143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u5l8dnkr/yHalhwaTD/AI1VND/JkaBHroOE0z5e0vto=;
        b=lYhwxoK7KAq4YhSxE2EKX469cdxDxILtIocoi9dgB1gXlGp51cSAAcEEkctyhYh0OZ
         iPlty4VRJnrWSOk1/JGgrIe/3x+bxJBiLWxEJf/x001kNPjLU3A05H5VQRkertIDinpN
         oiRjb4dD2+NIfgw0SwjI3uOe1FDX3IJ9FuqPyd4SObm/GQTWnI6qp+QjdWo09qC4o/8J
         CcG0JSDNeizNRsecVWy1yR3Dlhkd51iV0dM5Y1z+fTD1wLZrTIV9hlL7+zz4S9BP6Fcv
         J4BM7NPzcA1jljages+GdlrVagUf6tTbr8+i0ORnHqH74NfSkdG8gFuxH2k+vARRNn2d
         icmg==
X-Forwarded-Encrypted: i=1; AHgh+RqgEDUkkl/ost+Pz7Gdos4/pNYKR66+hAcMAGTBK/s6yHq8IPBYI1qoZIv3hmAmSNwlUQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+3V3Cjr/614hd/yWv4JD397aQ8012qijPU96ZHnnSZsbreFME
	eH1vxzuLeowuacxwMWwNYFX6BPOKjfsm4TyrpyHOMYL+ELbCGlPok1fF
X-Gm-Gg: AR+sD13KWAiY4lrBYTPnbA7vO4eXXQBs25EqgYKMniVX6HvJPGowTLNv0XtqeCQqlp4
	iIK1l7XUYd9ICYA+GSSiVZke/sRXXXyf3MKP451BlyZNrwU3S2D7plAXIr7blW9QVljVsHL/H7X
	yKnzazl+IcwQLOeWW2o1NBZLGJ1R0WpXg5Q42VHduHYY3PfcykApw3ekGH4RS4UbzYsuvvj12Ys
	EQRMvchkRY75i2gouWRmzA6h9QgwFHeqlrzcSoutrVV0kKNlZ7m2beJ+qJAEJ6jbTA/il/1qtSs
	mdrZZ4tcWVPQkXcskS/MHc4nOxFdo46E8CZC1s3m5ySbXnNR/caFoiLNaj3M5WlFWAdlsDPLXfu
	6mqRbQDLygnlas2OENiqiIv0RNmBJg3VnUoIP91s9HRyPJ1VvEW9qmYvMUPwms8SAPKT5Nk+nGJ
	EEDuEGTcArKJB7ITU+6TR7bQj6tXBa/W/YiStwhLbF9iZ9OHYyLG4v9XvlTLdh+LuHqNRTxOClu
	MBOW0l+CsM9KAN2kojjjQrHL8A=
X-Received: by 2002:a17:90b:4ac9:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-395810cad6amr4131402a91.14.1787120342961;
        Tue, 18 Aug 2026 23:19:02 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fbbb8d5sm1501529a91.14.2026.08.18.23.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 23:19:02 -0700 (PDT)
Message-ID: <d43e9adedfeced52ccf5eafea9f2aec01b79f413.camel@gmail.com>
Subject: Re: [RFC bpf-next 5/6] bpf: support low-32 subreg scalar linking
 for sign-extending movs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 18 Aug 2026 23:18:59 -0700
In-Reply-To: <20260814231945.3884596-6-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
	 <20260814231945.3884596-6-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:

...

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index ef71999c4695..6aaedde6e9d1 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

...

> @@ -570,9 +572,18 @@ static bool regsafe(struct bpf_verifier_env *env, st=
ruct bpf_reg_state *rold,
> =C2=A0		 * on a path that predates this series, which is a pruning change
> =C2=A0		 * that wants measuring on its own; it is deliberately left
> =C2=A0		 * alone here.
> +		 *
> +		 * Only demand a match when the old state carries a link at all.
> +		 * These flags are only ever set together with an ->id, so
> +		 * rold->id =3D=3D 0 implies none is set, and the only case this
> +		 * admits is "old knows no low-32 relationship, cur does" -- cur
> +		 * is then strictly more constrained than old, which is the safe
> +		 * direction for pruning. The reverse is still rejected. Without
> +		 * this a register that first acquires a link inside a loop would
> +		 * never match its pre-loop state and pruning would not converge.
> =C2=A0		 */
> =C2=A0		if (rold->id &&
> -		=C2=A0=C2=A0=C2=A0 (rold->flags & BPF_FLAG_SUBREG_ZEXT) !=3D (rcur->fl=
ags & BPF_FLAG_SUBREG_ZEXT))
> +		=C2=A0=C2=A0=C2=A0 (rold->flags & BPF_FLAG_SUBREG) !=3D (rcur->flags &=
 BPF_FLAG_SUBREG))
> =C2=A0			return false;

Same comment as for ZEXT patch.

> =C2=A0
> =C2=A0		if (env->explore_alu_limits) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8a802d49d0a4..45cb67dc3999 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14976,6 +14976,8 @@ static int adjust_reg_min_max_vals(struct bpf_ver=
ifier_env *env,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static void reconstruct_sext32(struct bpf_reg_state *reg, struct bpf_reg=
_state *src);

Nit: is it possible to avoid forward declaration?

> +
> =C2=A0/* check validity of 32-bit and 64-bit arithmetic operations */
> =C2=A0static int check_alu_op(struct bpf_verifier_env *env, struct bpf_in=
sn *insn)
> =C2=A0{
> @@ -15052,15 +15054,65 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> =C2=A0							insn->src_reg);
> =C2=A0						return -EACCES;
> =C2=A0					} else if (src_reg->type =3D=3D SCALAR_VALUE) {
> +						int sz =3D insn->off >> 3;
> =C2=A0						bool no_sext;
> +						bool subreg_link;
> =C2=A0
> =C2=A0						no_sext =3D reg_umax(src_reg) < (1ULL << (insn->off - 1));
> -						if (no_sext)
> +						/*
> +						 * When no_sext, dst =3D=3D src exactly, so link them
> +						 * (existing behavior). When !no_sext for a 32-bit sign
> +						 * extension the low 32 bits are still identical (sext
> +						 * preserves them), so form a BPF_FLAG_SUBREG_SEXT
> +						 * link: a later narrowing of the low 32 bits
> +						 * propagates here, and sync_linked_regs() rebuilds
> +						 * the high half via reconstruct_sext32().
> +						 *
> +						 * An ADD_CONST-linked src is excluded for the same
> +						 * reason as in the zero-extending arm below:
> +						 * assign_scalar_id_before_mov() would clear its
> +						 * base+delta link, and a combined subreg+delta link
> +						 * isn't modeled anyway. Unlike that arm a self-mov is
> +						 * NOT excluded -- r0 =3D (s32)r0 is the case this is
> +						 * here for.
> +						 */
> +						subreg_link =3D (sz =3D=3D 4) &&
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(src_reg->flags & BPF_FLAG_ADD_CO=
NST);
> +
> +						if (no_sext || subreg_link)
> =C2=A0							assign_scalar_id_before_mov(env, src_reg);
> =C2=A0						*dst_reg =3D *src_reg;
> -						if (!no_sext)
> -							clear_scalar_id(dst_reg);
> -						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
> +						if (!no_sext) {
> +							if (subreg_link && src_reg->id) {
> +								/* ->id already copied above */
> +								dst_reg->flags =3D (dst_reg->flags & ~BPF_FLAG_SUBREG) |
> +										 BPF_FLAG_SUBREG_SEXT;
> +							} else {
> +								clear_scalar_id(dst_reg);
> +							}
> +						}
> +						/*
> +						 * coerce_reg_to_size_sx() falls back to the full sext
> +						 * range when smin/smax straddle the sign boundary (e.g.
> +						 * an errno-or-zero value clamped to [-4095, 0]). For a
> +						 * register tracked as the sign-extension of its low 32
> +						 * bits the high half IS that sign-extension, so rebuild
> +						 * the tighter 64-bit range from the low bounds, taken
> +						 * from a snapshot because coerce overwrites them.
> +						 *
> +						 * Gated on sz =3D=3D 4, not on the flag alone: an (s8)/(s16)
> +						 * mov whose src is already SEXT-linked copies the flag
> +						 * across in the *dst_reg =3D *src_reg above, and a 32-bit
> +						 * reconstruction must not run for a narrower operation.
> +						 */
> +						if (sz =3D=3D 4 && (dst_reg->flags & BPF_FLAG_SUBREG_SEXT)) {
> +							struct bpf_reg_state sext_src =3D *dst_reg;
> +
> +							coerce_reg_to_size_sx(dst_reg, sz);
> +							reconstruct_sext32(dst_reg, &sext_src);

It does not make sense to maintain two functions that do register sign
extension. If coerce_reg_to_size_sx() is not precise enough for the
32-bit case, then it should be adapted instead of special-cased.

> +						} else {
> +							coerce_reg_to_size_sx(dst_reg, sz);
> +						}
> =C2=A0					} else {
> =C2=A0						mark_reg_unknown(env, regs, insn->dst_reg);
> =C2=A0					}
> @@ -15107,7 +15159,15 @@ static int check_alu_op(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
> =C2=A0						if (!is_src_reg_u32) {
> =C2=A0							if (wide_subreg_link && src_reg->id) {
> =C2=A0								/* ->id already copied above */
> -								dst_reg->flags |=3D BPF_FLAG_SUBREG_ZEXT;
> +								/*
> +								 * Zero-extension: high bits are 0, not a
> +								 * sign-extension of the low field. Drop any
> +								 * SUBREG_SEXT copied from a sext-linked src
> +								 * so sync_linked_regs() rebuilds dst by
> +								 * zero-extension, not reconstruct_sext32().
> +								 */
> +								dst_reg->flags =3D (dst_reg->flags & ~BPF_FLAG_SUBREG) |
> +										 BPF_FLAG_SUBREG_ZEXT;

Nit: please find a way to reduce indentation (e.g. less if-nesting, or a ut=
ility function).

> =C2=A0							} else {
> =C2=A0								clear_scalar_id(dst_reg);
> =C2=A0							}
> @@ -15961,6 +16021,32 @@ static void collect_linked_regs(struct bpf_verif=
ier_env *env,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +/*
> + * Set @reg to the sign-extension of the low 32 bits currently held by @=
src.
> + * A BPF_FLAG_SUBREG_SEXT-linked register came from a 32-bit sign
> + * extension (r0 =3D (s32)r0): it shares @src's low 32 bits and its high=
 bits are
> + * the sign-extension of that low field. Only the value fields are writt=
en;
> + * @reg's linkage fields (id, delta, flags) are left intact by
> + * the caller (___mark_reg_known touches only var_off/r64/r32). Callers =
must
> + * ensure no ADD_CONST delta is involved (see sync_linked_regs()).
> + */
> +static void reconstruct_sext32(struct bpf_reg_state *reg, struct bpf_reg=
_state *src)

Nit: let's rename src -> known_reg, to make reading sync_linked_regs() simp=
ler.

> +{
> +	s32 s32min =3D reg_s32_min(src);
> +	s32 s32max =3D reg_s32_max(src);
> +
> +	if (s32min =3D=3D s32max) {
> +		/* Low 32 bits are constant -> the whole value is the sext constant. *=
/
> +		___mark_reg_known(reg, (u64)(s64)s32min);
> +	} else {
> +		/* Sign-extension is monotonic over the signed-32 range. */
> +		reg_set_srange64(reg, (s64)s32min, (s64)s32max);
> +		reg_set_srange32(reg, s32min, s32max);
> +		reg->var_off =3D tnum_range((u64)(s64)s32min, (u64)(s64)s32max);

Note that known lower 32-bits of the known_reg->var_off are lost,
we might benefit from adding a dedicated tnum_sext().

> +		reg_bounds_sync(reg);
> +	}
> +}
> +
> =C2=A0/* For all R in linked_regs, copy known_reg range into R
> =C2=A0 * if R->id =3D=3D known_reg->id.
> =C2=A0 */
> @@ -15984,17 +16070,21 @@ static void sync_linked_regs(struct bpf_verifie=
r_env *env, struct bpf_verifier_s
> =C2=A0		 * A low-32 linked register shares only the base's low 32 bits;
> =C2=A0		 * the flag says how its high bits are derived. For
> =C2=A0		 * BPF_FLAG_SUBREG_ZEXT they are zero (32-bit zero-extending mov)=
.
> +		 * For BPF_FLAG_SUBREG_SEXT they are the sign-extension of the low
> +		 * field (32-bit sign extension).
> =C2=A0		 * Rebuild it from known_reg's low 32 bits accordingly, but only
> =C2=A0		 * when neither side carries an ADD_CONST delta -- with a delta
> =C2=A0		 * the low bits differ from the base by that delta and the combin=
ed
> =C2=A0		 * subreg+ADD_CONST reconstruction isn't modeled here, so leave r=
eg
> =C2=A0		 * unchanged (sound, just less precise).
> =C2=A0		 */
> -		if (reg->flags & BPF_FLAG_SUBREG_ZEXT) {
> +		if (reg->flags & BPF_FLAG_SUBREG) {
> =C2=A0			if (!((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST)) {
> -				{
> +				if (reg->flags & BPF_FLAG_SUBREG_SEXT) {
> +					reconstruct_sext32(reg, known_reg);
> +				} else {

Let's move this branch to a dedicated utility function as well.

> =C2=A0					u32 saved_id =3D reg->id;
> -					u8 saved_subreg =3D reg->flags & BPF_FLAG_SUBREG_ZEXT;
> +					u8 saved_subreg =3D reg->flags & BPF_FLAG_SUBREG;
> =C2=A0
> =C2=A0					/*
> =C2=A0					 * reg =3D zext32(known_reg): its low 32 bits come from

...
