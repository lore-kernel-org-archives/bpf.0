Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4ED2EA749
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185030; cv=none; b=oKA52vqMSxha0CHAb7V+1FzSw2EvUpyalXKQaHb+mZBMksid2FNdl8sia4MPRL4f/QMIkJTlyP4mKTSTOpJPZ8shTgf03Hs2VM2D4PQgEkSuHzoNutunFTGzULfBIdjbMVuY1cxnAioq5ewY9pTbmDaK19t7Zjla6iYQtxqpJpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185030; c=relaxed/simple;
	bh=mVhMpjM36ZBKfhN049RalgC5ZZjpqnK1WcPZiHD/Ye4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8Q986Ny+kF1sExcYL9buox+fKafNb1UgJ422CNgkfGduYMsYwQn8/RNxkQQkQwIbqHm3toxniEizII4mzdRyNFy/8TzKzvaKiRAF2z+Irbj2FImFhGPersTupxdLZuEqRly+XpPxQgh5sOHb5GJQIvlILuHvZ8PHx5XjuYmI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlalsmpw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlalsmpw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceaf8a1265so56602725ad.2
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784185028; x=1784789828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wZw6gWdUSSMCNQZ4kW841Fi/65epJfEJLC2WiUmo83o=;
        b=hlalsmpwoWVzq6JRb4G/FVfpQ+W8j9Gnznpz3GUkdvPSKTF41Nm+gbZiFp2bZ8xPdR
         FdrWC2j0NHvnkLecUi9DCQjnuCVEXgag8RqaIalPO4Pn4D4J8tkjysSYJH5ogHF4fdBB
         LajTnGPrjdnqUyJ6Uv+5rUoavhUVxFJpONHqOXBJaaM8BuBzOysj3lBSxcgfG1/+jHLD
         ereLdT0v75y/QOiEci+seTAWzwPD222GBRTpm0YbyU6A1nSpX1Z3MFkZmu0WV2zXHqtZ
         XJqWUp8IPSjqQse669ulplOZz+5PBEZoDXjIO5t05k0Fy23alSyZH7Zm8//Zh0GRjWhL
         0LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185028; x=1784789828;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZw6gWdUSSMCNQZ4kW841Fi/65epJfEJLC2WiUmo83o=;
        b=EV+K4FBk0wdpnVIn3ygDh4GU9WKpt/IJ6fZdXUpvpp2/YQ3WYWIvqHKFdz4nygMJTZ
         2/PYgEHZ0b6ih4/7hXW5go7f51IioaPkIUXwsMO5fFU0dKzRl8hV0Bm0BtMbRgS/5xwJ
         JzPuGn5rNqE6Ebbl6NHhUYl/2vyUurv0SMWQCMIxB6YWMCqv0FP7D9+lddx/BN8D/U8U
         FapxPRuPOLjWVQoQ610IMoMsU3pFlCvHWLrvgjlp1XCOZAHlxmlMTNJ1fq5R/Q8QwELR
         Gb1uJnWO/GIFQkJQG20YOHBJM5+4AQSyY3fSzaEvgGfuceqHg+Trf6an2iwZjXPPk53m
         9OLw==
X-Forwarded-Encrypted: i=1; AHgh+RpTW7XWtv9okWChjSdKQXUFNvM84x2X+6V/YcT0AHlWlcg4j+iblrIwSm+xEn/Oy04IJAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyailyElJ3Jz/rn6amFhItmqo0njfYS0jqtwvFUf3c+zwOk4gYv
	ncTHp4jxUzZ5Fl2OXwbzsxIfnPNxoIrHpitrPHJt0nVSIpC0PmossEjG
X-Gm-Gg: AfdE7ckIHt+G7J0zASTlvuqRrVTtENoaoGC7HqK0iSlvPCAJKMdI3gZUljAXiAdTKaX
	tZP6b/TUIMZ2P+eU+M05LhjtuA9ioDOu99MwRgeD8ofX7LmGT31+l+9/HJK6IRCWOdGF89TsaOi
	8LX/ABoppud/r1SFbmnvz1EyVFnHwmkCy9e8WemVrXloGKJ20KpNN+vHt8K8FHSkSj7tnX4TyHL
	NoH6hSz9rBoUwQk5P0xYfIKbNyNavAwyh/FlIuh8btpcB3b5p8waVB8gTTNNmqz3Jgm1o1MYqbu
	6o6TGhUJgPC+Qu9RDJyNRikE8oFgtiwCTWaRJK6LzVlYkAz+vr9G+MKw3HRwnmaXqToUgvXbHaY
	ZLkM/U1kCmrC4PdutkZMOjTZrdsKOlaJ9qxoipE/PSAu2iRxA1f5LHpKC/K5ezbmdCSIXXnguL4
	vARWAjucH/5ACj9iq5Lq/Tc7XOflofTg==
X-Received: by 2002:a17:903:984:b0:2ca:d658:d874 with SMTP id d9443c01a7336-2cef12fe200mr100454665ad.23.1784185028197;
        Wed, 15 Jul 2026 23:57:08 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055f193sm14898535ad.46.2026.07.15.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:57:07 -0700 (PDT)
Message-ID: <483012fa37560779be9dd772a9d6db19a9cfc356.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/17] bpf: Track verifier register
 diagnostic events
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 15 Jul 2026 23:57:05 -0700
In-Reply-To: <20260713153910.2556007-6-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
	 <20260713153910.2556007-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 17:38 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index ed19220aca9a..1a45ec926c71 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

...

> @@ -34,23 +35,64 @@
> =C2=A0#define BPF_DIAG_REG_TMP_LEN 192
> =C2=A0#define BPF_DIAG_SCRATCH_STR_CNT 3
> =C2=A0#define BPF_DIAG_SCRATCH_STR_LEN 256
> +#define BPF_DIAG_SCRATCH_REG_CNT CALLER_SAVED_REGS
> =C2=A0#define BPF_DIAG_TEXT_LEN 160
> =C2=A0
> +struct bpf_diag_reg_snapshot {
> +	u32 type;
> +	u32 btf_id;
> +	const struct bpf_map *map_ptr;
> +	const struct btf *btf;
> +	struct tnum var_off;
> +	struct cnum64 r64;
> +};
> +
> =C2=A0enum bpf_diag_history_kind {
> =C2=A0	BPF_DIAG_HISTORY_BRANCH,
> +	BPF_DIAG_HISTORY_MOD,
> +};
> +
> +struct bpf_diag_event_hdr {
> +	u32 insn_idx : 24;
> +	u32 kind : 8;
> =C2=A0};
> =C2=A0
> =C2=A0struct bpf_diag_history_event {
> -	u32 insn_idx;
> -	u8 kind;

Let's keep this as a single common part instead of bpf_diag_event_hdr
(again, the prefixes are completely unnecessary). Every event in the
series relies on such header, so there is no need to keep it spread
across struct and a union.

> =C2=A0	union {
> =C2=A0		struct {
> +			u32 insn_idx : 24;
> +			u32 kind : 8;
> +		};
> +		struct {
> +			struct bpf_diag_event_hdr hdr;
> =C2=A0			bool cond_true;
> =C2=A0		} branch;
> +		struct {
> +			struct bpf_diag_event_hdr hdr;
> +			struct bpf_diag_mod_target target;
> +			struct bpf_diag_mod_target origin;
> +			struct bpf_diag_reg_snapshot old, new;
> +			u8 reason;
> +			bool origin_valid;
> +		} mod;
> =C2=A0	};
> =C2=A0};

...

> @@ -81,11 +123,27 @@ struct bpf_diag_log {
>  	int error;
>  };
> =20
> +struct bpf_diag_reg_fmt {
> +	char old_buf[BPF_DIAG_REG_DESC_LEN];
> +	char new_buf[BPF_DIAG_REG_DESC_LEN];
> +	char offset_desc[BPF_DIAG_REG_DESC_LEN];
> +	char btf_type[BPF_DIAG_REG_TMP_LEN];
> +	char range[BPF_DIAG_REG_TMP_LEN];
> +	char smin_buf[32];
> +	char smax_buf[32];
> +	char umin_buf[32];
> +	char umax_buf[32];
> +};

The amount of scratch buffers of various kind is a bit high throughout
the series, wdyt about the following unification for the string scratch
buffers handling:

  https://github.com/kernel-patches/bpf/commit/078fbf9471c1f9d59c61877afd5b=
9a8e7f189462

?

I played with bump allocator for strings but it does not show much
difference compared to plain kasprintf(). At least not with current
hot points (more on this separately).

> +
> =C2=A0struct bpf_diag_scratch {
> =C2=A0	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
> +	struct bpf_reg_state regs[BPF_DIAG_SCRATCH_REG_CNT];
> =C2=A0	struct bpf_linfo_source source;
> =C2=A0	struct bpf_diag_source_line source_lines[BPF_DIAG_CONTEXT_CNT];
> =C2=A0	struct bpf_diag_insn insns[BPF_DIAG_CONTEXT_CNT];
> +	unsigned long *history_bitmap;
> +	u32 history_bitmap_nbits;

Instead of maintaining a standalone bitmap, one can dedicate a bit in
the event entry itself.

> +	struct bpf_diag_reg_fmt reg_fmt;
> =C2=A0};

...

> @@ -311,6 +379,36 @@ static void diag_print_wrapped_text(struct bpf_verif=
ier_env *env, const char *te
> =C2=A0	diag_print_wrapped_prefixed(env, BPF_DIAG_TEXT_INDENT, BPF_DIAG_TE=
XT_INDENT, text);
> =C2=A0}
> =C2=A0
> +void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *=
btf, u32 type_id)

All callers are internal for diagnostics.c

> +{
> +	size_t len;
> +	int ret;
> +
> +	buf[0] =3D '\0';
> +	ret =3D btf_type_snprintf_show_name(btf, type_id, buf, size);
> +	if (ret < 0 || !buf[0]) {
> +		scnprintf(buf, size, "BTF type ID %u", type_id);
> +		return;
> +	}
> +
> +	len =3D strlen(buf);
> +	if (len && buf[len - 1] =3D=3D '{')
> +		buf[len - 1] =3D '\0';
> +}
> +
> +const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *en=
v, unsigned int slot,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 const struct btf *btf, u32 type_id)

There are no callers for this function.

> +{
> +	size_t size;
> +	char *buf =3D bpf_diag_scratch_buf(env, slot, &size);
> +
> +	if (!buf)
> +		return "";
> +
> +	bpf_diag_format_btf_type(buf, size, btf, type_id);
> +	return buf;
> +}
> +
> =C2=A0static void diag_vprint_indented(struct bpf_verifier_env *env, cons=
t char *fmt, va_list args)
> =C2=A0{
> =C2=A0	char *buf;
> @@ -727,47 +825,628 @@ void bpf_diag_report_source(struct bpf_verifier_en=
v *env, u32 insn_idx, const ch

...

> +static bool diag_snapshot_eq(const struct bpf_diag_reg_snapshot *old,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct bpf_diag_reg_snapshot *new)
> +{
> +	return old->type =3D=3D new->type && old->map_ptr =3D=3D new->map_ptr &=
& old->btf =3D=3D new->btf &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old->btf_id =3D=3D new->btf_id && =
old->var_off.value =3D=3D new->var_off.value &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old->var_off.mask =3D=3D new->var_=
off.mask && old->r64.base =3D=3D new->r64.base &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old->r64.size =3D=3D new->r64.size=
;
> +}
> +
> +static bool diag_mod_snapshot_eq(const struct bpf_diag_history_event *ev=
ent)

This wrapper is useless.

> +{
> +	return diag_snapshot_eq(&event->mod.old, &event->mod.new);
> +}
> +
> +static bool diag_mod_insn_origin(struct bpf_verifier_env *env, u32 insn_=
idx,
> +				 const struct bpf_diag_mod_target *target,
> +				 struct bpf_diag_mod_target *origin)
> +{
> +	const struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
> +	u8 class =3D BPF_CLASS(insn->code);
> +	u32 frameno;
> +
> +	if (target->kind =3D=3D BPF_DIAG_MOD_TARGET_REG && (class =3D=3D BPF_AL=
U || class =3D=3D BPF_ALU64) &&
> +	=C2=A0=C2=A0=C2=A0 BPF_OP(insn->code) =3D=3D BPF_MOV && BPF_SRC(insn->c=
ode) =3D=3D BPF_X) {
> +		*origin =3D bpf_diag_reg_target(target->frameno, insn->src_reg);
> +		return true;
> +	}
> +
> +	if ((target->kind !=3D BPF_DIAG_MOD_TARGET_STACK_ARG &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0 target->kind !=3D BPF_DIAG_MOD_TARGET_STACK_SL=
OT) ||
> +	=C2=A0=C2=A0=C2=A0 class !=3D BPF_STX)
> +		return false;
> +
> +	frameno =3D env->cur_state->frame[env->cur_state->curframe]->frameno;
> +	*origin =3D bpf_diag_reg_target(frameno, insn->src_reg);
> +	return true;
> +}
> +
> +void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
> +			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
> +			 const struct bpf_reg_state *old_reg, const struct bpf_reg_state *new=
_reg,
> +			 const struct bpf_diag_mod_target *origin)
> +{

I need to reflect some more on the rest of the patch, it appears that
this record_mod function should be integrated with existing
mark_{reg,stack}_scratched calls:
- extended with some additional parameters, like frameno
- possibly reordered, such that at the callsite the old register state
  is saved and after do_check_insn() is complete the old and new states
  pair is fed into bpf_diag_record_mod().
But I need to think some more.

...
