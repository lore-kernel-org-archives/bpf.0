Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567723ED5E
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093504; cv=none; b=pemVSMUh0UsgsG7Z6l2OMs88jtYHaVZ7o5Aksygnp3czQIor3KkJ6lf+4cq5lZ+App9x8n2nL8fhM2gZZxnuJDnH+gnohiWaZ9R+4UKng9jAzC1E+2eFcp6iXSVIsn7Re4oqcJlYy6iFDbbxRciq72MPNNdGZAVwvZVWx4Vk6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093504; c=relaxed/simple;
	bh=VzGzi7KbPwApyluImY21sTzJWxyBARDa+nJwrMUvY1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FU5ny0ckRzqNo++1ZNb8K6Tszamty04+NjPbPl714HinvDwFqtg3rbhSdo/1R3Q49KpSMHFnoHzYRV7iTuQXyO8zHFiQ0okzi8iMw+0tfLPzR9xgY+DWO2/M0xMyeVQ0BLi0hxfa1jb0YVeymDeX1yZcjplaVo6g8hQ7KJy57sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8lWy5LM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8lWy5LM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso4314745ad.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787093502; x=1787698302; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=F6oLcx7fKJ8rGoIZ9TgB/BRbMUH1GIIRGFlSlLjS6eQ=;
        b=W8lWy5LMUycxL8fz299WS0Scrwj1rYG4j9r47WaP9pP9l/bqDu5YTy0KKtMLVB/Iv0
         6Zw1ldpoOlBJZvBd4j31LmGDVjK9ey0NNInMBkCZc8zKrY50JDEJL4nm/qjWSbuye7dV
         dDZ2dzJ5ddyKfOV5nsDZFk4xTEeSiy4p0i5PFKcqHkKgzsYRmqYjXxNPOBiAUpc0PlsI
         nemfQSCfOseVc81FlhJXmoa9TKMijdpbcR3maiMEkxnLgLhc8iRaOe24AnZO+FFy0mSr
         +0SCzxGwAG0PWXDkZe5R/LIotBajjLEar9gWI2h9lQ4deee5feZ+UCYxDQMNImRVmJhU
         47Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787093502; x=1787698302;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6oLcx7fKJ8rGoIZ9TgB/BRbMUH1GIIRGFlSlLjS6eQ=;
        b=iWLAVyRQmQgfQ09wL+t+sOoT3NVIJQ8W3AkyeHH04pinpAu17VN/8fLJ8vVBZKqoTn
         5rEXX/0m9FFrQOYLYM2fGHycWriJBzgBPvPMdBDNCQqojf0jIhY5QZIwoTUO2AJ8nqa4
         VyHkx8B9qorxoiNeHVUbrR4Jj2D+8puVCKHbE7yft+lG5BYknhe/S5cjyKLiVLb8Lgli
         3mgxMvRhf02fTcuMVbW0LY193dd9rmsS/GnpMn6aUeaND94b6Vft0CstuUOe8FZdnVnQ
         hbP0egkhOblp1eo+0Y0AzcHpdwFehc9aOdG/dhYkV0PWn2U0hhdBcnZIjMEXFkO/9vBW
         Xndg==
X-Forwarded-Encrypted: i=1; AHgh+Rr7Odswl3Cp16Q5mOEE9/M//jAkqYlBzNLjUAHshQmpwASoqHmXKI5WlUgbRiBXNRDqoZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjDDFlsbX1BAf+0Ki/EfG9IcmLdlQD+brYntbs7fxj+HT8eJB
	LmM/dq2AdopldkW3msZkOSgaH7Jqwf87Nxy8pjWw//lT6vEGS3YyDgGgFhge6XSNqZg=
X-Gm-Gg: AR+sD12L3uicH5lCNHXRhJkM/KYW4MHmCUK7z8ucUz9kCmltyTCAdaboT/iUnv2GgUr
	ccPcdy98ElYtgpIk4vX2IfWUqKrecZcrwe2Y5oBIUZElQFBiqLrBN9PdccpB5nzlQHEVDE4MtTj
	micOtJcihg4FJL1XmRabWt/3bMAFhwEMZZ74i4xgkp0oF3M1sEx0koPlUC5HVYym05zYyD1edde
	4R6s1lNZ5HE1cP78R0Tw0VH750FKlDO7V8hqmwpR95Mg8va7EYhwWVkVxfbyxay8C8XA7kXpAYP
	KKyQw8PIPQLXDXZpmBir/+5Pegv3q1Mlc7t9MvesL2De5NfbT3kcX36IeDltX3SvB+WYMQiGSyJ
	zI6xwTM8UXbmK5tCUmSY7KSA+OeGH5+oLs+RW/0XlRd8TokSaNWkrCffVXRPXhbwqjctyKCxCEr
	/nP8hhY0DsvbgbFmHkILMCFwedh3m16Z2teKjkFatNTkTDGClQ8DFLZBbEVFcmDvx6CsYLe/VJv
	ax6fgv6WCOaOsxYQw==
X-Received: by 2002:a17:902:cf08:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2d5fd5ec972mr5753005ad.2.1787093502245;
        Tue, 18 Aug 2026 15:51:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e52945sm18765405ad.48.2026.08.18.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:51:40 -0700 (PDT)
Message-ID: <82363647cb12b75398e34c7d66a9f0c527940c8d.camel@gmail.com>
Subject: Re: [RFC bpf-next 2/6] bpf: move the linked-scalar flags into
 bpf_reg_state->flags [NFC]
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 18 Aug 2026 15:51:37 -0700
In-Reply-To: <20260814231945.3884596-3-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
	 <20260814231945.3884596-3-vineet.gupta@linux.dev>
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

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index ebab483fc7f2..2b03fdba9acf 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

...

> @@ -166,11 +163,16 @@ struct bpf_reg_state {
> =C2=A0	 * Register state flags.
> =C2=A0	 * BPF_FLAG_PRECISE: if unset, and this is a SCALAR_VALUE, then
> =C2=A0	 * min/max/tnum don't affect safety.
> -	 *
> =C2=A0	 * PRECISE is a property of this register alone, so it is placed a=
t bit 7,
> =C2=A0	 * apart from the link flags, which grow up from bit 0 and are cle=
ared as
> =C2=A0	 * a group -- a clear-the-link-bits mask can then never reach it.
> +	 *
> +	 * BPF_FLAG_ADD_CONST{32,64}: this register is (base + ->delta) within
> +	 * its ->id set, computed with a 32- or 64-bit ALU add.
> =C2=A0	 */
> +#define BPF_FLAG_ADD_CONST32	(1U << 0)
> +#define BPF_FLAG_ADD_CONST64	(1U << 1)
> +#define BPF_FLAG_ADD_CONST	(BPF_FLAG_ADD_CONST32 | BPF_FLAG_ADD_CONST64)
> =C2=A0#define BPF_FLAG_PRECISE	(1U << 7)

I'd still suggest to use bitfields.

> =C2=A0	u8 flags;
> =C2=A0};

...

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index f7a0314fa106..d3105b9a9965 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -370,12 +370,12 @@ static bool check_ids(u32 old_id, u32 cur_id, struc=
t bpf_idmap *idmap)
> =C2=A0 * to cur_id=3D0 and pass. With temp IDs: r6 maps X->temp1, r7 trie=
s to map
> =C2=A0 * X->temp2, but X is already mapped to temp1, so the check fails c=
orrectly.
> =C2=A0 *
> - * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and =
the
> - * base id (flag stripped) must both map consistently. Example: old has
> - * r2.id=3DA, r3.id=3DA|flag (r3 =3D r2 + delta), cur has r2.id=3DB, r3.=
id=3DC|flag
> - * (r3 derived from unrelated r4). Without the base check, idmap gets tw=
o
> - * independent entries A->B and A|flag->C|flag, missing that A->C confli=
cts
> - * with A->B. The base ID cross-check catches this.
> + * ->id is a plain identifier -- the ADD_CONST relationship lives in
> + * ->flags -- so there is no compound (base | flag) key to unpack here.
> + * Registers sharing a base id go through one idmap entry, which is what
> + * catches e.g. old r2.id=3DA, r3.id=3DA (r3 =3D r2 + delta) against cur=
 r2.id=3DB,
> + * r3.id=3DC: A->B and A->C conflict. Matching ->flags and ->delta are c=
hecked
> + * by the caller in regsafe().

Nit: the above paragraph can be dropped altogether now.

> =C2=A0 */
> =C2=A0static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idm=
ap *idmap)
> =C2=A0{
> @@ -384,15 +384,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id,=
 struct bpf_idmap *idmap)
>
> =C2=A0	cur_id =3D cur_id ? cur_id : ++idmap->tmp_id_gen;
>
> -	if (!check_ids(old_id, cur_id, idmap))
> -		return false;
> -	if (old_id & BPF_ADD_CONST) {
> -		old_id &=3D ~BPF_ADD_CONST;
> -		cur_id &=3D ~BPF_ADD_CONST;
> -		if (!check_ids(old_id, cur_id, idmap))
> -			return false;
> -	}
> -	return true;
> +	return check_ids(old_id, cur_id, idmap);
> =C2=A0}

I think sashiko is correct when it comments about:

> Does the explore_alu_limits verification path also need a similar update?

Both check_scalar_ids() call sites need an update.
That being said, I'd say that the following case in regsafe()

		if (env->explore_alu_limits) {
			/* explore_alu_limits disables tnum_in() and range_within()
			 * logic and requires everything to be strict
			 */
			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =3D=3D 0 &=
&
			       check_scalar_ids(rold->id, rcur->id, idmap);
		}


can be replaced with `if (...) return regs_exact(rold, rcur, idmap)`,
parent_id should be zero for SCALAR_VALUE.

>
> =C2=A0static void __clean_func_state(struct bpf_verifier_env *env,
> @@ -488,11 +480,32 @@ static int clean_verifier_state(struct bpf_verifier=
_env *env,
> =C2=A0	return 0;
> =C2=A0}
>
> +/*
> + * Do rold and rcur describe the same relationship to their ->id set?
> + *
> + * The link flags live in ->flags, which sits past the end of every memc=
mp()
> + * window used for state comparison.

--- 8< ----------------------------
                                        and check_ids() only ever sees the =
plain
> + * ->id. So unlike when these bits rode along in the top of ->id, they h=
ave to
> + * be compared explicitly everywhere ->id is.

---------------------------- >8 ---

Nit: let's drop this sentence.

> + *
> + * Only meaningful when rold carries an id: the flags are only ever set
> + * together with one, so rold->id =3D=3D 0 implies none of them is set.
> + */
> +static bool link_flags_match(const struct bpf_reg_state *rold,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct bpf_reg_state *rcur)
> +{
> +	if (!rold->id)
> +		return true;
> +
> +	return (rold->flags & BPF_FLAG_ADD_CONST) =3D=3D (rcur->flags & BPF_FLA=
G_ADD_CONST);
> +}
> +

...

> @@ -590,17 +603,24 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
> =C2=A0		 */
>
> =C2=A0		/*
> -		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
> -		 * BPF_ADD_CONST64 have different linking semantics in
> +		 * ADD_CONST flags must match exactly: BPF_FLAG_ADD_CONST32 and
> +		 * BPF_FLAG_ADD_CONST64 have different linking semantics in
> =C2=A0		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
> =C2=A0		 * so pruning across different flag types is unsafe.
> =C2=A0		 */
> -		if (rold->id &&
> -		=C2=A0=C2=A0=C2=A0 (rold->id & BPF_ADD_CONST) !=3D (rcur->id & BPF_ADD=
_CONST))
> +		if (!link_flags_match(rold, rcur))
> =C2=A0			return false;
>
> -		/* Both have offset linkage: offsets must match */
> -		if ((rold->id & BPF_ADD_CONST) && rold->delta !=3D rcur->delta)
> +		/*
> +		 * Both have offset linkage: offsets must match. The rold->id
> +		 * test is redundant today -- BPF_FLAG_ADD_CONST is only ever set
> +		 * together with an id -- but it used to be structural, because
> +		 * the flag lived in the id itself. Keep it explicit so the
> +		 * invariant does not rest on every ->id =3D 0 site remembering to
> +		 * clear ->flags too.
> +		 */

Nit: Let's shorten this comment to it's original form.
     A comment on ->flags field saying that "->flags !=3D 0 iff ->id !=3D 0=
" should suffice.
     Let's also drop the 'rold->id && ' part.

> +		if (rold->id && (rold->flags & BPF_FLAG_ADD_CONST) &&
> +		=C2=A0=C2=A0=C2=A0 rold->delta !=3D rcur->delta)
> =C2=A0			return false;
>
> =C2=A0		if (!check_scalar_ids(rold->id, rcur->id, idmap))
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8925749d636e..93e69116ca9e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1806,6 +1806,7 @@ static void __mark_reg_known(struct bpf_reg_state *=
reg, u64 imm)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(struct bpf_reg_state=
, var_off) - sizeof(reg->type));
> =C2=A0	reg->id =3D 0;
> =C2=A0	reg->parent_id =3D 0;
> +	reg->flags &=3D ~BPF_FLAG_ADD_CONST;
> =C2=A0	___mark_reg_known(reg, imm);
> =C2=A0}
>
> @@ -3308,6 +3309,7 @@ static void clear_scalar_id(struct bpf_reg_state *r=
eg)
> =C2=A0{
> =C2=A0	reg->id =3D 0;
> =C2=A0	reg->delta =3D 0;
> +	reg->flags &=3D ~BPF_FLAG_ADD_CONST;
> =C2=A0}

sashiko is correct about the following branch in the
check_stack_write_fixed_off():

		if (!reg_value_fits)
			state->stack[spi].spilled_ptr.id =3D 0;

this seem to be the only missing location, the rest deals with
pointers, where ->flags should already be zero.

...

> @@ -15950,18 +15951,19 @@ static void sync_linked_regs(struct bpf_verifie=
r_env *env, struct bpf_verifier_s
> =C2=A0				: &vstate->frame[e->frameno]->stack[e->spi].spilled_ptr;
> =C2=A0		if (reg->type !=3D SCALAR_VALUE || reg =3D=3D known_reg)
> =C2=A0			continue;
> -		if ((reg->id & ~BPF_ADD_CONST) !=3D (known_reg->id & ~BPF_ADD_CONST))
> +		if (reg->id !=3D known_reg->id)
> =C2=A0			continue;
> =C2=A0		/*
> =C2=A0		 * Skip mixed 32/64-bit links: the delta relationship doesn't
> =C2=A0		 * hold across different ALU widths.
> =C2=A0		 */
> -		if (((reg->id ^ known_reg->id) & BPF_ADD_CONST) =3D=3D BPF_ADD_CONST)
> +		if (((reg->flags ^ known_reg->flags) & BPF_FLAG_ADD_CONST) =3D=3D BPF_=
FLAG_ADD_CONST)
> =C2=A0			continue;
> -		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) |=
|
> +		if ((!(reg->flags & BPF_FLAG_ADD_CONST) && !(known_reg->flags & BPF_FL=
AG_ADD_CONST)) ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 reg->delta =3D=3D known_reg->delta) {
> =C2=A0			*reg =3D *known_reg;
> =C2=A0		} else {
> +			u8 saved_add_const =3D reg->flags & BPF_FLAG_ADD_CONST;
      ---------------------^
> =C2=A0   |         	s32 saved_off =3D reg->delta;
> =C2=A0   | 		u32 saved_id =3D reg->id;
> =C2=A0   |
> @@ -|5976,11 +15978,12 @@ static void sync_linked_regs(struct bpf_verifie=
r_env *env, struct bpf_verifier_s
> =C2=A0   | 		 */
> =C2=A0   | 		reg->delta =3D saved_off;
> =C2=A0   | 	        reg->id =3D saved_id;
> +   | 		reg->flags =3D (reg->flags & ~BPF_FLAG_ADD_CONST) | saved_add_con=
st;
> =C2=A0   -----------------------^
      I'm not sure we need to inherit flags from known_reg here.
      Let's avoid that and go with just saved_flags.

> =C2=A0			scalar32_min_max_add(reg, &fake_reg);
> =C2=A0			scalar_min_max_add(reg, &fake_reg);
> =C2=A0			reg->var_off =3D tnum_add(reg->var_off, fake_reg.var_off);
> -			if ((reg->id | known_reg->id) & BPF_ADD_CONST32)
> +			if ((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST32)
> =C2=A0				zext_32_to_64(reg);
> =C2=A0			reg_bounds_sync(reg);
> =C2=A0		}

...

> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> @@ -349,8 +349,9 @@ l0_%=3D:							\
> =C2=A0}
>
> =C2=A0/*
> - * Test that sync_linked_regs() checks reg->id (the linked target regist=
er)
> - * for BPF_ADD_CONST32 rather than known_reg->id (the branch register).
> + * Test that sync_linked_regs() consults reg->flags (the linked target
                                   ^^^^^^^^
                               nit: checks
> + * register) for BPF_FLAG_ADD_CONST32, not just known_reg->flags (the br=
anch
> + * register): the gate is (reg->flags | known_reg->flags).
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
               nit: please drop.
> =C2=A0 */
> =C2=A0SEC("socket")
> =C2=A0__success

...
