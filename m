Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931A3A4535
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246857; cv=none; b=faHDMNShHfPs9ECZggfaDTAb7ZOzrHuSUMzjkBWgHqpVIQD86m9vKUVO5VQenxvfOujeWrzV+HP7laI/dqttcXGq7yTlLST17DyysigbKBZYqXo1C6S0qSMrkTSSjVelvEo6q/dCvdRBrVqaFr18yrNFvTZrAdp6+ICq4g8rO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246857; c=relaxed/simple;
	bh=EAGpH+AafZqNf1hG1ABrtcGlU+Q+4/PMKymriUIV1JI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bOsbbOD19Dx4Mcvu6ereGerR2M8ljaFolvPhTL6zUhaIXBnT2AhUlFFf5QlC3AKxPytoLyd/ntG5AkTaRpVC0cy3G+19YnnQyMlCyYmYabYAOm9QbJXod1G40ApFw0F7xanNEt/p3GMcN8gerPsCnD1XZqOIFQtKBN3SW87sN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKe/pymh; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKe/pymh"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-139b914bab6so340317c88.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782246854; x=1782851654; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/iZmtdB11KqN+vGhwxB8gBb6HKZyejfBzhGJSiERq0=;
        b=HKe/pymhZhPUtd8xvy5zDQeaiF7yBOjX/+bJcuGSSiT/xbfJ0w8ycaGYxCB15I2ZIl
         NutijuixmYFPFfFkylyI4ICYu0L6Ti77HXiw/BoB3ZsAeI5VUMUpP40+kq5LJyy4OWWp
         Qa4xlwJjgqihhdMCNNrng4NfU/GlAuBovlX8bcHCVfzT7NFv6Q0X1pE2A9ZVJhWtey4T
         h4oKQJNp3gaeLdQTqyXtd4PmkSe6kSg7RyyOmj2J7C8eWDZMzrXQir6DPGcHPmewfrvB
         YQWP3BSm6BjlD+M/yvCGnUQ5A2ci5gjqFvQk/f0AjZIBOxh4viagCJvIWlyyid9CwaUq
         Qvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246854; x=1782851654;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/iZmtdB11KqN+vGhwxB8gBb6HKZyejfBzhGJSiERq0=;
        b=AdZBjy7YuKX+ukLiUBx82P8xE4TCPjcTjzrVt1JupQwqoaVoNy95wUjTdaSve33kRX
         uH34tvsnwIiZ9JMBzwHiVxVui0UoBb8vTE2pHRTzBJsZNi31bKBB5oWXUHEi6o9k177G
         zxE94qzdX4CPjokF6FWT+o4v6RoTBOmyWuZScuPxIxiv4508Xf7lBBCM5QrXxpCilCfj
         LWgWhMbau/gz+p+HHmK2D+T4JlqTBRggOdx20KqK626ZbLtqgXhAlNyxc7INVvMcAf7X
         E53W6nlEiG0qWpJ+t9XIOkRouQly+wfmRJ8wCgHx99dGhG/D5sR5gqB6m9o8wJFljJCY
         bheg==
X-Forwarded-Encrypted: i=1; AFNElJ8peBhJ5PP1AE15ql/oVyUyfdEd7pTtUo1Jlm+NvRqy1g2qnlatJq32hJGEfqHVinPPSlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyfp7Jias2UhNJ6S+xRCGesYTosLSW/v1F58pG/fYnPPQIFQme
	N5PAsGt7gMML5rd0tTVkP+3aiz2/9IoVDqbpBlD66MqEW1/OLyelyA0t
X-Gm-Gg: AfdE7cnPGBt4N226Zrw+a7GgApMCO5TRYYxuYIlX54oPIt7FO1FJ60auSPLpd2uZkR0
	GD1cUFSRWJCxvmRps8VVbOD5uZKKJMuLc3ug23tjXIAVkJak1EwO0qWHcmjzGyONjfTDjjHr28B
	Tsrr84Y4Ktd+5M8r6uqcAlD+D2el+XKJvzjRhjC1f9CtcdUbR3sFODi9rZZC+K4PZUEyZs3+1/5
	r1okTw+B6ynfuBm7BQ5SX1JANgjWmHKfhQ8zgBNv9KQNyTgJzCoJbPQIvuhpNGGWlamTn4dHWvU
	+AoqKliJEfI4iRh6F2tnTkscdCzhTSvupqlxZOF5HrzNhYUc+NDPNfSQWKGmQcp+QL0riDED6F3
	hNxkzhM0Fr6c/ZReSCEmMXTfmgWlsr4r+7Lt2a3Q2FMLflmcSfVZqqti7OJug928zsTAXaZhM+r
	Qk3aqbuilunTJwNClcBUw+D8Hujb2Fk/rsMkdno/gkx84CmcHSVNtQh3ekJu8tJ6X/aQ==
X-Received: by 2002:a05:701b:4550:10b0:138:407c:1d1a with SMTP id a92af1059eb24-139d0cf79e4mr174252c88.38.1782246853842;
        Tue, 23 Jun 2026 13:34:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:20e3:c15b:de5e:66e6? ([2620:10d:c090:500::e22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcc5f14sm16320799c88.6.2026.06.23.13.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:34:13 -0700 (PDT)
Message-ID: <30801da14c1f4a745623e4e2ce5b2d1d34e1b156.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/17] bpf: Add source and instruction
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 23 Jun 2026 13:34:11 -0700
In-Reply-To: <20260619205934.1312876-3-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Teach verifier diagnostics to annotate an instruction with BTF source
> line information and nearby BPF instructions. The renderer keeps source
> text in a fixed-width lane and prints instructions in a stable right-hand
> gutter.
>=20
> Wrap annotation text under the source line so long error labels remain
> readable while the source and instruction lanes keep their fixed layout.
>=20
> Keeping source and instruction context in one commit preserves the visual
> layout contract that later diagnostic reports rely on.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15ae7c43f594..6f08bf383c11 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8255,6 +8255,17 @@ int btf_type_snprintf_show(const struct btf *btf, =
u32 type_id, void *obj,
>  	return ssnprintf.len;
>  }
> =20
> +int btf_type_snprintf_show_name(const struct btf *btf, u32 type_id,
> +				char *buf, int len)
> +{
> +	struct btf_show show =3D {
> +		.btf =3D btf,
> +		.state.type_id =3D type_id,
> +	};

fwiw, this is a big structure (200 bytes), but we already have it used
on stack in several places.

> +
> +	return snprintf(buf, len, "%s", btf_show_name(&show));
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  static void bpf_btf_show_fdinfo(struct seq_file *m, struct file *filp)
>  {
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..7883449ead89 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[...]

> @@ -3498,7 +3499,8 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, u=
nsigned long ip, const char *
>  	if (idx =3D=3D -1)
>  		return -ENOENT;
> =20
> -	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump);
> +	bpf_get_linfo_file_line(btf, &linfo[idx], filep, linep, nump,
> +				BPF_LINFO_LINE_TRIM);

Nit: line width limit is 100 characters.

>  	return 0;
>  }
> =20
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index a18fd5aa395d..534a7bc58781 100644
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
>  #define BPF_DIAG_CATEGORY_MEMORY_SAFETY "Memory Safety"
> @@ -21,12 +25,147 @@
> =20
>  #define BPF_DIAG_TEXT_WIDTH 100
>  #define BPF_DIAG_TEXT_INDENT "  "
> +#define BPF_DIAG_MSG_LEN 512
> +#define BPF_DIAG_SOURCE_CONTEXT 2
> +#define BPF_DIAG_SOURCE_LINE_CNT (1 + BPF_DIAG_SOURCE_CONTEXT * 2)
> +#define BPF_DIAG_INSN_CONTEXT 2
> +#define BPF_DIAG_INSN_CNT (1 + BPF_DIAG_INSN_CONTEXT * 2)
> +#define BPF_DIAG_COLUMN_GAP 3
> +#define BPF_DIAG_SOURCE_LANE_WIDTH 88
> +#define BPF_DIAG_TAB_WIDTH 8
> +#define BPF_DIAG_REG_DESC_LEN 512
> +#define BPF_DIAG_REG_TMP_LEN 192
> +#define BPF_DIAG_SCRATCH_STR_CNT 3
> +#define BPF_DIAG_SCRATCH_STR_LEN 256
> +#define BPF_DIAG_TEXT_LEN 160
> +
> +struct bpf_diag_source {
> +	const char *file;
> +	const char *line;
> +	u32 file_name_off;
> +	int line_num;
> +	int line_col;
> +};
> +
> +struct bpf_diag_source_line {
> +	const char *line;
> +	int line_num;
> +};
> +
> +struct bpf_diag_insn {
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
> +	struct bpf_diag_source source;
> +	struct bpf_diag_source_line source_lines[BPF_DIAG_SOURCE_LINE_CNT];
> +	struct bpf_diag_insn insns[BPF_DIAG_INSN_CNT];
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
> +static struct bpf_diag *bpf_diag_env(struct bpf_verifier_env *env)
> +{
> +	if (!bpf_diag_enabled(env))
> +		return NULL;
> +	if (env->diag)
> +		return env->diag;
> +
> +	env->diag =3D kzalloc_obj(struct bpf_diag, GFP_KERNEL_ACCOUNT);

Given that there is no way to report this allocation failure and that
struct bpf_diag takes <4Kb, I'd suggest allocating it at the time of
bpf_verifier_env creation.

> +	return env->diag;
> +}
> +
> +static struct bpf_diag_scratch *bpf_diag_scratch(struct bpf_verifier_env=
 *env)
> +{
> +	struct bpf_diag *diag =3D bpf_diag_env(env);
> +
> +	return diag ? &diag->scratch : NULL;
> +}
> +
> +char *bpf_diag_scratch_buf(struct bpf_verifier_env *env,
> +			   unsigned int slot, size_t *size)
> +{
> +	struct bpf_diag_scratch *scratch =3D bpf_diag_scratch(env);
> +	char *buf =3D NULL;
> +	size_t buf_size =3D 0;
> +
> +	if (!scratch)
> +		goto out;

Nit: in case of a NULL exit, maybe set `*size =3D 0;`, just in case?

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
> +const char *bpf_diag_scratch_strcpy(struct bpf_verifier_env *env,
> +				    unsigned int slot,
> +				    const char *str)
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
> +const char *bpf_diag_scratch_printf(struct bpf_verifier_env *env,
> +				    unsigned int slot,
> +				    const char *fmt, ...)
> +{
> +	size_t size;
> +	va_list args;
> +	char *buf =3D bpf_diag_scratch_buf(env, slot, &size);
> +
> +	if (!buf)
> +		return "";
> +
> +	va_start(args, fmt);
> +	vscnprintf(buf, size, fmt, args);
> +	va_end(args);
> +	return buf;
> +}
> +
> +void bpf_diag_free(struct bpf_verifier_env *env)
> +{
> +	struct bpf_diag *diag =3D env->diag;
> +
> +	if (!diag)
> +		return;
> +
> +	kfree(diag);
> +	env->diag =3D NULL;
> +}
> +
>  static void bpf_diag_log(struct bpf_verifier_env *env, const char *fmt, =
...)
>  {
>  	va_list args;
> @@ -38,7 +177,6 @@ static void bpf_diag_log(struct bpf_verifier_env *env,=
 const char *fmt, ...)
>  	bpf_verifier_vlog(&env->log, fmt, args);
>  	va_end(args);
>  }
> -

Looks like a squash/patch reordering artifact.

>  static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env=
,
>  					    const char *first_prefix,
>  					    const char *next_prefix,
> @@ -103,6 +241,287 @@ static void bpf_diag_vprint_indented(struct bpf_ver=
ifier_env *env,
>  	kfree(buf);
>  }
> =20
> +static int bpf_diag_line_width(unsigned int line)
> +{
> +	int width =3D 1;
> +
> +	while (line >=3D 10) {
> +		line /=3D 10;
> +		width++;
> +	}
> +
> +	return width;
> +}
> +
> +static const char *bpf_diag_func_name(struct bpf_verifier_env *env, u32 =
insn_idx)
> +{
> +	const struct bpf_subprog_info *subprog;
> +	const struct bpf_func_info *info;
> +	const struct btf_type *type;
> +	int subprogno;
> +
> +	subprog =3D bpf_find_containing_subprog(env, insn_idx);
> +	if (!subprog)
> +		return NULL;
> +	if (subprog->name && *subprog->name)
> +		return subprog->name;

The code below repeats what check_btf_func() does to compute
subprogram names, would it be possible to move subprog->name
initialization somewhere earlier? Or add an accessor that optionally
populates the name?

> +
> +	if (!env->prog->aux->func_info || !env->prog->aux->btf)
> +		return NULL;
> +
> +	subprogno =3D subprog - env->subprog_info;
> +	if (subprogno < 0 || subprogno >=3D env->prog->aux->func_info_cnt)
> +		return NULL;
> +
> +	info =3D &env->prog->aux->func_info[subprogno];
> +	type =3D btf_type_by_id(env->prog->aux->btf, info->type_id);
> +	if (!type)
> +		return NULL;
> +
> +	return btf_name_by_offset(env->prog->aux->btf, type->name_off);
> +}
> +
> +static bool bpf_diag_fill_source(struct bpf_verifier_env *env,
> +				 const struct bpf_line_info *linfo,
> +				 struct bpf_diag_source *src)
> +{
> +	const char *file, *line;
> +	int line_num;
> +
> +	if (!env->prog->aux->btf)
> +		return false;
> +
> +	bpf_get_linfo_file_line(env->prog->aux->btf, linfo, &file, &line,
> +				&line_num, 0);

Nit: I'd refactor bpf_get_linfo_file_line into a function that fills
     bpf_diag_source (renamed to something generic) and used everywhere.

> +	if (!file || !*file || !line || !*line)
> +		return false;
> +
> +	src->file =3D file;
> +	src->line =3D line;
> +	src->file_name_off =3D linfo->file_name_off;
> +	src->line_num =3D line_num;
> +	src->line_col =3D BPF_LINE_INFO_LINE_COL(linfo->line_col);
> +	return true;
> +}
> +
> +static bool bpf_diag_get_source(struct bpf_verifier_env *env, u32 insn_i=
dx,
> +				struct bpf_diag_source *src)
> +{
> +	const struct bpf_line_info *linfo;
> +
> +	linfo =3D bpf_find_linfo(env->prog, insn_idx);
> +	if (!linfo)
> +		return false;
> +
> +	return bpf_diag_fill_source(env, linfo, src);
> +}
> +
> +static void bpf_diag_fill_source_lines(struct bpf_verifier_env *env,
> +				       const struct bpf_diag_source *src,
> +				       int start_line, int end_line,
> +				       struct bpf_diag_source_line *lines)
> +{
> +	const struct bpf_line_info *linfo =3D env->prog->aux->linfo;
> +	struct btf *btf =3D env->prog->aux->btf;
> +	u32 i;
> +
> +	for (i =3D 0; i < BPF_DIAG_SOURCE_LINE_CNT; i++)
> +		lines[i].line_num =3D start_line + i;
> +
> +	if (!btf || !env->prog->aux->nr_linfo)
> +		return;
> +
> +	for (i =3D 0; i < env->prog->aux->nr_linfo; i++) {
> +		const char *file, *line;
> +		int line_num, idx;
> +
> +		if (linfo[i].file_name_off !=3D src->file_name_off)
> +			continue;
> +
> +		bpf_get_linfo_file_line(btf, &linfo[i], &file, &line,
> +					&line_num, 0);
> +		if (line_num < start_line || line_num > end_line)
> +			continue;
> +
> +		idx =3D line_num - start_line;
> +		if (lines[idx].line)
> +			continue;
> +		if (line && *line)
> +			lines[idx].line =3D line;
> +	}
> +}
> +
> +static int bpf_diag_line_indent(const char *line)
> +{
> +	int indent =3D 0;
> +
> +	while (*line =3D=3D ' ' || *line =3D=3D '\t') {
> +		if (*line =3D=3D '\t')
> +			indent =3D round_up(indent + 1, BPF_DIAG_TAB_WIDTH);
> +		else
> +			indent++;
> +		line++;
> +	}
> +
> +	return indent;
> +}
> +
> +static void bpf_diag_insn_print(void *private_data, const char *fmt, ...=
)
> +{
> +	struct bpf_diag_insn_ctx *ctx =3D private_data;
> +	struct bpf_diag_insn_buf *buf =3D &ctx->buf;
> +	va_list args;
> +
> +	if (buf->len >=3D buf->size)
> +		return;
> +
> +	va_start(args, fmt);
> +	buf->len +=3D vscnprintf(buf->buf + buf->len, buf->size - buf->len,
> +			       fmt, args);
> +	va_end(args);
> +}
> +
> +static const char *bpf_diag_disasm_kfunc_name(void *private_data,
> +					      const struct bpf_insn *insn)
> +{
> +	struct bpf_diag_insn_ctx *ctx =3D private_data;
> +
> +	return bpf_disasm_kfunc_name(ctx->env, insn);
> +}
> +
> +static void bpf_diag_format_insn(struct bpf_verifier_env *env, int insn_=
idx,
> +				 struct bpf_diag_insn *diag_insn)
> +{
> +	struct bpf_insn *insn;
> +	struct bpf_diag_insn_ctx ctx =3D {
> +		.env =3D env,
> +		.buf =3D {
> +			.buf =3D diag_insn->text,
> +			.size =3D sizeof(diag_insn->text),
> +		},
> +	};
> +	const struct bpf_insn_cbs cbs =3D {
> +		.cb_call =3D bpf_diag_disasm_kfunc_name,
> +		.cb_print =3D bpf_diag_insn_print,
> +		.private_data =3D &ctx,
> +	};
> +
> +	diag_insn->idx =3D insn_idx;
> +	diag_insn->valid =3D false;
> +	diag_insn->text[0] =3D '\0';
> +
> +	if (insn_idx < 0 || insn_idx >=3D env->prog->len)
> +		return;
> +
> +	if (insn_idx > 0 && bpf_is_ldimm64(&env->prog->insnsi[insn_idx - 1]))
> +		return;
> +
> +	insn =3D &env->prog->insnsi[insn_idx];
> +	if (bpf_is_ldimm64(insn) && insn_idx + 1 >=3D env->prog->len)
> +		return;
> +
> +	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> +	while (ctx.buf.len && diag_insn->text[ctx.buf.len - 1] =3D=3D '\n')
> +		diag_insn->text[--ctx.buf.len] =3D '\0';
> +
> +	diag_insn->valid =3D true;
> +}
> +
> +static void bpf_diag_format_source_text(char *buf, size_t size,
> +					const char *line, int width)
> +{
> +	int col =3D 0, len =3D 0;
> +
> +	if (!size)
> +		return;
> +	if (width <=3D 0) {
> +		buf[0] =3D '\0';
> +		return;
> +	}
> +
> +	line =3D line ?: "...";
> +	while (*line && col < width && len + 1 < size) {
> +		if (*line =3D=3D '\t') {
> +			int next =3D round_up(col + 1, BPF_DIAG_TAB_WIDTH);
> +
> +			while (col < next && col < width && len + 1 < size) {
> +				buf[len++] =3D ' ';
> +				col++;
> +			}
> +			line++;
> +			continue;
> +		}
> +
> +		buf[len++] =3D *line++;
> +		col++;
> +	}
> +
> +	if (*line) {
> +		int ellipsis_len =3D min(3, width);
> +
> +		while (len > 0 && col > width - ellipsis_len) {
> +			len--;
> +			col--;
> +		}
> +		while (ellipsis_len-- && len + 1 < size) {
> +			buf[len++] =3D '.';
> +			col++;

'col' unused.

> +		}
> +	}
> +
> +	buf[len] =3D '\0';
> +}
> +
> +static void bpf_diag_format_source_lane(char *buf, size_t size,
> +					const char *source_prefix,
> +					int source_line_width,
> +					int line_num, const char *line)
> +{
> +	int len, text_width;
> +
> +	if (line_num <=3D 0) {
> +		buf[0] =3D '\0';
> +		return;
> +	}
> +
> +	len =3D scnprintf(buf, size, "%s%*d | ",
> +			source_prefix, source_line_width, line_num);

Please add a post-processing pass to claude, fixing the line width to 100.

> +	if (len >=3D (int)size)
> +		return;
> +
> +	text_width =3D BPF_DIAG_SOURCE_LANE_WIDTH - len;
> +	bpf_diag_format_source_text(buf + len, size - len, line, text_width);
> +}
> +
> +static void bpf_diag_print_source_insn_line(struct bpf_verifier_env *env=
,
> +					    const char *source_prefix,
> +					    int source_line_width,
> +					    const struct bpf_diag_source_line *line,
> +					    const struct bpf_diag_insn *diag_insn,
> +					    int focus_insn_idx,
> +					    int insn_width)
> +{
> +	size_t source_lane_size;
> +	char *source_lane;
> +
> +	source_lane =3D bpf_diag_scratch_buf(env, 0,
> +					   &source_lane_size);
> +	if (!source_lane)
> +		return;
> +
> +	bpf_diag_format_source_lane(source_lane, source_lane_size,
> +				    source_prefix, source_line_width,
> +				    line->line_num, line->line);
> +
> +	bpf_diag_log(env, "  %-*s%*s", BPF_DIAG_SOURCE_LANE_WIDTH,
> +		     source_lane, BPF_DIAG_COLUMN_GAP, "");
> +	if (diag_insn->valid)
> +		bpf_diag_log(env, "%s%*d | %s",
> +			     diag_insn->idx =3D=3D focus_insn_idx ? ">>> " : "    ",
> +			     insn_width, diag_insn->idx, diag_insn->text);
> +	bpf_diag_log(env, "\n");
> +}
> +
>  void bpf_diag_report_header(struct bpf_verifier_env *env,
>  			    const char *category, const char *problem)
>  {
> @@ -168,3 +587,120 @@ static void bpf_diag_report_suggestion(struct bpf_v=
erifier_env *env,
>  	va_end(args);
>  	bpf_diag_log(env, "\n");
>  }

Nit: it would be nice to have a comment here with a sample of what this
     function actually prints (would be nice with other functions as well).

> +static void bpf_diag_print_source_annotation(struct bpf_verifier_env *en=
v,
> +					     int line_width, int indent,
> +					     const char *label,
> +					     const char *msg)
> +{
> +	size_t first_prefix_size, next_prefix_size;
> +	char *first_prefix, *next_prefix;
> +	char *text;
> +
> +	first_prefix =3D bpf_diag_scratch_buf(env, 0,
> +					    &first_prefix_size);
> +	next_prefix =3D bpf_diag_scratch_buf(env,
> +					   1,
> +					   &next_prefix_size);
> +	if (!first_prefix || !next_prefix)
> +		return;
> +
> +	indent =3D min_t(int, indent,
> +		       max_t(int, 0, BPF_DIAG_SOURCE_LANE_WIDTH -
> +			     line_width - 8));
> +	text =3D kasprintf(GFP_KERNEL_ACCOUNT, "%s: %s", label, msg);
> +	if (!text) {
> +		bpf_diag_log(env, "  %*s | %*s^-- %s\n",
> +			     line_width + 4, "", indent, "", label);

Should the error path print the 'msg' as well?

> +		return;
> +	}
> +
> +	scnprintf(first_prefix, first_prefix_size, "  %*s | %*s^-- ",
> +		  line_width + 4, "", indent, "");
> +	scnprintf(next_prefix, next_prefix_size, "  %*s | %*s    ",
> +		  line_width + 4, "", indent, "");
> +
> +	bpf_diag_print_wrapped_prefixed(env, first_prefix, next_prefix, text);
> +	kfree(text);
> +}
> +
> +void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
> +			    const char *label, const char *fmt, ...)
> +{
> +	struct bpf_diag_scratch *scratch;
> +	struct bpf_diag_source_line *source_lines;
> +	struct bpf_diag_insn *diag_insn;
> +	struct bpf_diag_source *src;
> +	char *msg;
> +	const char *func;
> +	int start_line, end_line, width, indent, insn_width, i;
> +	va_list args;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	va_start(args, fmt);
> +	msg =3D kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
> +	va_end(args);
> +	if (!msg)
> +		msg =3D kstrdup("<failed to allocate diagnostic text>",
> +			      GFP_KERNEL_ACCOUNT);
> +	if (!msg)
> +		return;
> +
> +	label =3D label ?: "note";
> +	scratch =3D bpf_diag_scratch(env);
> +	if (!scratch)
> +		goto out_free_msg;
> +
> +	src =3D &scratch->source;
> +	source_lines =3D scratch->source_lines;
> +	diag_insn =3D scratch->insns;
> +	memset(source_lines, 0, sizeof(scratch->source_lines));
> +	memset(diag_insn, 0, sizeof(scratch->insns));
> +
> +	if (!bpf_diag_get_source(env, insn_idx, src)) {
> +		bpf_diag_log(env, "  insn %u\n", insn_idx);
> +		bpf_diag_print_source_annotation(env, 0, 0, label, msg);
> +		goto out_free_msg;
> +	}
> +
> +	func =3D bpf_diag_func_name(env, insn_idx);
> +	if (func && *func)
> +		bpf_diag_log(env, "  %s @ %s:%d:%d\n", func, src->file,
> +			     src->line_num, src->line_col);
> +	else
> +		bpf_diag_log(env, "  %s:%d:%d\n", src->file, src->line_num,
> +			     src->line_col);
> +
> +	start_line =3D src->line_num - BPF_DIAG_SOURCE_CONTEXT;
> +	end_line =3D src->line_num + BPF_DIAG_SOURCE_CONTEXT;
> +	width =3D bpf_diag_line_width(end_line);
> +	indent =3D bpf_diag_line_indent(src->line);
> +	insn_width =3D bpf_diag_line_width(env->prog->len ? env->prog->len - 1 =
: 0);
> +	bpf_diag_fill_source_lines(env, src, start_line, end_line,
> +				   source_lines);
> +
> +	for (i =3D 0; i < BPF_DIAG_INSN_CNT; i++) {
> +		int row =3D i - BPF_DIAG_INSN_CONTEXT;
> +
> +		bpf_diag_format_insn(env, insn_idx + row, &diag_insn[i]);
> +	}
> +
> +	for (i =3D 0; i < BPF_DIAG_SOURCE_LINE_CNT; i++) {

This loop iterates both source_lines and diag_insn arrays,
but these arrays are bounded by different constants: BPF_DIAG_INSN_CNT
vs BPF_DIAG_SOURCE_LINE_CNT. Is there a reason to keep these constants
separate?

> +		const char *source_prefix;
> +
> +		source_prefix =3D source_lines[i].line_num =3D=3D src->line_num ?
> +				">>> " : "    ";
> +		bpf_diag_print_source_insn_line(env, source_prefix, width,
> +						&source_lines[i],
> +						&diag_insn[i],

This is misleading, apart from the line corresponding to the insn_idx
the source_lines[i] is not guaranteed to be aligned with diag_insn[i].
Or I misread the intention and the goal is to just show some context?

> +						insn_idx, insn_width);
> +		if (source_lines[i].line_num =3D=3D src->line_num)
> +			bpf_diag_print_source_annotation(env, width, indent,
> +							 label, msg);
> +	}
> +
> +out_free_msg:
> +	kfree(msg);
> +}

[...]
