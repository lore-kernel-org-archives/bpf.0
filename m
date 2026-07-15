Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301F2BEC5E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137753; cv=none; b=ZmtxDFU3TS/89FNFLSw4d/4d36LKC912Vr+D5g4TQawlV+hN2nX/YF04PCMWKy+UEgK0zJJrRGy0yR/QL7hcrQguYNyrjx4vEFPb077jag1VelCE8Gmoq1oQJPOOlPIwwMTUo5ok13NVCqNrq31l297WGcau+JgajCPFjqosWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137753; c=relaxed/simple;
	bh=/lmXVjk9xRsUEOBWWJvHJXmxqSvLSH/MnSIG8Ofy34I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvAvtDoIuoIpqsfO1DIsyb6CXSm3B3yUfyq6BsclktveBHUFttiSEOD+MlzlQBYuSy9bBAl6JsXEaacjXjUjZmsUk4f5FtvgQKEh+wofIEv66yxG6GUDN4NhxbXxof9xXBeY+YsULlNjDwja4k1rBxXH/opo1ctx0FTzcN5hphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5SnEtPW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5SnEtPW"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so3305686a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784137751; x=1784742551; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/FPqRRCfKfjntNeclNmAetr80gbpJchiJLxDX/Sh5m4=;
        b=C5SnEtPWU1gW8tNKP8CX+kkSjuleCuqIY4cEBoIanNYteGrxLPhDSJui0ocjAoZ5C5
         b3pdUwuxPt6Def5cuqR5DEGFxVEBMJwl82gmRZMAaMHEopk1c90hPleQu8TXm6/rF9aI
         ppqwobRymequuMgIo/96pTEEIvSZLNxYdERHH6zwzeT9qOq9cCbKJbr2khbCYC7ponJj
         71cS8FODf6GyRc07zUQ/wGjWUvk9FdEEDsKc3nFjZoMOhmIGSs/YCgRro2kspkV5quH+
         qtR3B1vqjvhhlFo3grimBJ+BKlVas/mLfG8vrNmUPQN7g9iX79ZOw+MI2MUvc+99XPuJ
         0eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137751; x=1784742551;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/FPqRRCfKfjntNeclNmAetr80gbpJchiJLxDX/Sh5m4=;
        b=JIsUtmLekFm20hBY/xZSqHMZ9j6iQdOTs+RF99VOFbTPTDEr4Hf0PsL8oSnidmWLG9
         KV/gEQbbgg3lB2e6x07Nukpq9d8zhEtb3FUeqZ3wZPZc9dTCIWEeRiAb34Y2Q0HqRJz6
         agII+UVOrCBrZ9NcKEiRvPPlfEV2mT+Xs98XcGsxqyWj9/MzRWCh3T41GdmZfdi9S0Tq
         geyHcjaRnzkKNasaKSGlDCDM5WOzIQycVww8IyRulxCs9Lg2+Ov9wj8KnpgesM/UUneS
         H+YaG0k1BHiwLWZdH6Bf7NNoXZmPWDWR14AaMiYVWRwNgsSzSMVxbFITUvrTBWxvn4zg
         k0zQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZgwT7B4sMHyD0Yyxq7EmXu0rpLbk/FI6O+r7ZXtgLFrAiEMUvIgz4b7Jsodfn9yGLWIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Uo3zDXp/Yr5B44O0AlTg1UBO8VkBRkraNFxgqjrXu1AdSYuA
	Nkjkz4QiQlXODA3fZLJKeoeulH5k0bkTXZzkZ4cYaPKPZPU2ijt/d+he
X-Gm-Gg: AfdE7cmN1y2YQs+VAYmZCnuz0OgLSPu2l53DqPLjk3qDfrhGdr2sP/HIMQAcpcVHKMH
	8YQvOA0n6TFjks27XY3ph4HrbPS1K/7LGHf0641poioPWpDvFdoGSwAOnXZQKBb5XGOztfuIHUl
	+CFhWnroD9h/MHDkLBT5d5YnyNsaUVVJ77Ydnm3NYwsbd3eqKI8GinJvDgM0in5twcvXdiyjsh8
	CygsbV8Wi0y15N5huB7zpqT6f7KPMhiSIcmprarr/hbO9tqdR8VRTOfFGmA5oIEplzqDF+7WoDt
	rp2nXr/Ef7kgOe3OKbtoJSDZLPyE6ENWbWIdLZ0Hv3legzBPjUqHPRw4GhZFaS72LzDvVsqBsXb
	sWkVDK7nIy0Qd8KxGCBY/bXsJ1btPj0yTycgCvgGQRVncZ8+dvPwtypvKNb4MVBuXpOZh630gwb
	ePOs0Dz5p/B/uNbSFLNG10uTw3D0TqEkosXckf1+k3zA==
X-Received: by 2002:a05:6a00:94fc:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-84a672415ccmr3351530b3a.7.1784137751049;
        Wed, 15 Jul 2026 10:49:11 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dae12sm3527762b3a.44.2026.07.15.10.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:49:10 -0700 (PDT)
Message-ID: <2978385544ba62298a8f0323ba22e70b9096e4f9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: Add source and instruction
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 15 Jul 2026 10:49:07 -0700
In-Reply-To: <20260713153910.2556007-3-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
		 <20260713153910.2556007-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 17:38 +0200, Kumar Kartikeya Dwivedi wrote:

More nits, since you asked for nits :)

...

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 47fe047ad30b..b35721ab3712 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3460,24 +3460,30 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);

...

> +void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info=
 *linfo, const char **filep,
> +			     const char **linep, int *nump, u32 flags)

Nit: it would be better to just move the callers to use
     struct bpf_linfo_source.

...

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 6d28a3481cfa..49106115621d 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -1,12 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> =20
> +#include <linux/bpf.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/btf.h>
>  #include <linux/ctype.h>
> +#include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/stdarg.h>
>  #include <linux/string.h>
> =20
> +#include "disasm.h"
>  #include "diagnostics.h"
> =20
>  #define CATEGORY_MEMORY_SAFETY "Memory Safety"
> @@ -21,12 +25,136 @@
> =20
>  #define BPF_DIAG_TEXT_WIDTH 100
>  #define BPF_DIAG_TEXT_INDENT "  "
> +#define BPF_DIAG_MSG_LEN 512
> +#define BPF_DIAG_CONTEXT 2
> +#define BPF_DIAG_CONTEXT_CNT (1 + BPF_DIAG_CONTEXT * 2)
> +#define BPF_DIAG_SOURCE_LANE_WIDTH 88
> +#define BPF_DIAG_TAB_WIDTH 8
> +#define BPF_DIAG_REG_DESC_LEN 512
> +#define BPF_DIAG_REG_TMP_LEN 192
> +#define BPF_DIAG_SCRATCH_STR_CNT 3
> +#define BPF_DIAG_SCRATCH_STR_LEN 256
> +#define BPF_DIAG_TEXT_LEN 160
           ^^^^^^^^^

Let's drop the BPF_DIAG_ here.
In general, there a lot of places in this file with bpf_diag_ prefix
that can be dropped to improve readability. E.g. struct definitions
below, some of the utility functions, etc.

> +
> +struct bpf_diag_source_line {
> +	const char *line;
> +	int line_num;
> +};
> +
> +struct bpf_diag_insn {

Nit: bpf_diag_insn -> disasm_line

> +	char text[BPF_DIAG_TEXT_LEN];
> +	int idx;
> +	bool valid;
> +};
> +
> +struct bpf_diag_insn_buf {
> +	char *buf;
> +	size_t size;
> +	size_t len;
> +};
> +
> +struct bpf_diag_insn_ctx {
> +	struct bpf_verifier_env *env;
> +	struct bpf_diag_insn_buf buf;
> +};
> +
> +struct bpf_diag_scratch {
> +	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
> +	struct bpf_linfo_source source;
> +	struct bpf_diag_source_line source_lines[BPF_DIAG_CONTEXT_CNT];

Nit: drop the 'struct bpf_diag_source_line' and use 'bpf_linfo_source',
     just to keep things simpler?

> +	struct bpf_diag_insn insns[BPF_DIAG_CONTEXT_CNT];
> +};
> +
> +struct bpf_diag {
> +	struct bpf_diag_scratch scratch;
> +};
> =20
>  bool bpf_diag_enabled(const struct bpf_verifier_env *env)
>  {
>  	return env->log.level & BPF_LOG_LEVEL;
>  }
> =20
> +static struct bpf_diag *diag_env(struct bpf_verifier_env *env)
> +{
> +	return env->diag;
> +}
> +
> +int bpf_diag_init(struct bpf_verifier_env *env)
> +{
> +	if (!bpf_diag_enabled(env))
> +		return 0;
> +
> +	env->diag =3D kzalloc_obj(struct bpf_diag, GFP_KERNEL_ACCOUNT);
> +	return env->diag ? 0 : -ENOMEM;
> +}
> +
> +static struct bpf_diag_scratch *diag_scratch(struct bpf_verifier_env *en=
v)
> +{
> +	struct bpf_diag *diag =3D diag_env(env);
> +
> +	return diag ? &diag->scratch : NULL;
> +}
> +
> +char *bpf_diag_scratch_buf(struct bpf_verifier_env *env, unsigned int sl=
ot, size_t *size)
                                                            ^^^^^^^^^^^^^^^=
^^

Still think that manual slot number management here is inconvenient.
Can do some kind of `&scratch->str[scartch->next_slot++]` and avoid
the 'slot' parameter.

The 'size' parameter is used inconsistently, at some callsites a local
variable is passed, at some callsites BPF_DIAG_SCRATCH_STR_LEN is used
directly.

> +{
> +	struct bpf_diag_scratch *scratch =3D diag_scratch(env);
> +	char *buf =3D NULL;
> +	size_t buf_size =3D 0;
> +
> +	if (!scratch)
> +		goto out;
> +
> +	if ((unsigned int)slot >=3D BPF_DIAG_SCRATCH_STR_CNT)
> +		goto out;
> +
> +	buf =3D scratch->str[slot];
> +	buf_size =3D sizeof(scratch->str[slot]);
> +
> +out:
> +	if (size)
> +		*size =3D buf_size;
> +	return buf;
> +}
> +
> +const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env, unsign=
ed int slot,
> +				    const char *str)

There are no users.

> +{
> +	size_t size;
> +	char *buf =3D bpf_diag_scratch_buf(env, slot, &size);
> +
> +	if (!buf)
> +		return "";
> +	strscpy(buf, str ?: "", size);
> +	return buf;
> +}
> +
> +const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env, unsign=
ed int slot,
> +				    const char *fmt, ...)

...

> +static const char *diag_func_name(struct bpf_verifier_env *env, u32 insn=
_idx)

Nit: I'd inline this function, would be less code in the end.

> +{
> +	const struct bpf_subprog_info *subprog;
> +	int subprogno;
> +
> +	subprog =3D bpf_find_containing_subprog(env, insn_idx);
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
           there is bpf_find_subprog() that returns index directly

> +	if (!subprog)
> +		return NULL;
> +
> +	subprogno =3D subprog - env->subprog_info;
> +	return bpf_verifier_subprog_name(env, subprogno);
> +}
> +
> +static bool diag_fill_source(struct bpf_verifier_env *env, const struct =
bpf_line_info *linfo,
> +			     struct bpf_linfo_source *src)
> +{

Nit: I'd inline this function.

> +	if (!env->prog->aux->btf)
> +		return false;
> +
> +	bpf_get_linfo_source(env->prog->aux->btf, linfo, src, 0);
> +	return src->file && *src->file && src->line && *src->line;
> +}
> +
> +static bool diag_get_source(struct bpf_verifier_env *env, u32 insn_idx,
> +			    struct bpf_linfo_source *src)
> +{
> +	const struct bpf_line_info *linfo;
> +
> +	linfo =3D bpf_find_linfo(env->prog, insn_idx);
> +	if (!linfo)
> +		return false;
> +
> +	return diag_fill_source(env, linfo, src);
> +}

...

> +static void diag_print_source_line(struct bpf_verifier_env *env, const c=
har *source_prefix,
> +				   int source_line_width, const struct bpf_diag_source_line *line)

Nit: and here, there is a single small caller now

> +{
> +	size_t source_lane_size;
> +	char *source_lane;
> +
> +	source_lane =3D bpf_diag_scratch_buf(env, 0, &source_lane_size);
> +	diag_format_source_lane(source_lane, source_lane_size, source_prefix, s=
ource_line_width,
> +				line->line_num, line->line);
> +	diag_write(env, "  %s\n", source_lane);
> +}
> +
> +static void diag_print_insn_line(struct bpf_verifier_env *env,
> +				 const struct bpf_diag_insn *diag_insn, int focus_insn_idx,
> +				 int insn_width)
> +{
> +	if (!diag_insn->valid)
> +		return;
> +	diag_write(env, "  %s%*d | %s\n", diag_insn->idx =3D=3D focus_insn_idx =
? ">>> " : "    ",
> +		   insn_width, diag_insn->idx, diag_insn->text);
> +}
> +

...

> +void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx, =
const char *label,
> +			    const char *fmt, ...)
> +{

...

> +	/*
> +	 * Source lines and BPF instructions are independent context windows.
> +	 * Only their focused entries describe the same location, so render
> +	 * separate blocks instead of pairing neighboring rows.
> +	 */

This is a remnant from the prompt.

> +	diag_write(env, "  Source context:\n");
> +	for (i =3D 0; i < BPF_DIAG_CONTEXT_CNT; i++) {
> +		const char *source_prefix;
> +
> +		source_prefix =3D source_lines[i].line_num =3D=3D src->line_num ? ">>>=
 " : "    ";
> +		diag_print_source_line(env, source_prefix, width, &source_lines[i]);
> +		if (source_lines[i].line_num =3D=3D src->line_num)
> +			diag_print_source_annotation(env, width, indent, label, msg);
> +	}
> +	diag_write(env, "  Instruction context:\n");
> +	for (i =3D 0; i < BPF_DIAG_CONTEXT_CNT; i++)
> +		diag_print_insn_line(env, &diag_insn[i], insn_idx, insn_width);
> +
> +out_free_msg:
> +	kfree(msg);
> +}

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03e2202cca13..4f127c8db134 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -425,7 +426,7 @@ static bool subprog_returns_void(struct bpf_verifier_=
env *env, int subprog)
>  	return btf_type_is_void(type);
>  }
> =20
> -static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
> +const char *bpf_verifier_subprog_name(const struct bpf_verifier_env *env=
, int subprog)

bpf_verifier_subprog_name -> bpf_subprog_name

>  {
>  	struct bpf_func_info *info;
> =20

...
