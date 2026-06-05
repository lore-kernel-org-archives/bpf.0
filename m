Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB420FA81
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690944; cv=none; b=DHVwFRAx2vuHGQs1TYeP5BmaViccwHroFDK4FIFvVJdS9RBApD1hXnVouBbBiSENqLKPdUr7J4kIEfI7+t1tHvAVsv5tW1zL9co+4mdveRS/pkbNCQA4A/K6nfbHEfFnu8V37euGsXECquRc7IuBlpt0knkvW34zsKGrN/4L/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690944; c=relaxed/simple;
	bh=ByxyJgh1mQHKAOBD6z0bz7m0uxe2z56Q0DpCMBqmLLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBTRrjIcBxV80hg20loBNzRR2MbwHuqssy9mENsEl7RSEKbiHxDogmke24a6VbfrW2IOTmaUBd+gX6GhKPDKFnsChf2ZLqLPvH+FLynr+ZSxa0ZUGZgoZrcLxtt8NPGHBYnCVKHktmkU7kCOLsl1+uiKafmZirgFclT2rXRbdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1sjq6Yq; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1sjq6Yq"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304cf518c9dso2972771eec.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690942; x=1781295742; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ARVgqbS9xgid8HJKEFgckMfwe0D6Z4fgBZF3ZZydQqM=;
        b=B1sjq6Yq+R4qoWze4ZYiC+kPsM2g9ABVOvpfh9KCOdwnfR8kNN4ybCTTG62Z67Y5fd
         X4JHp2g6LJP2EXaCH5yuSon+UssiIBwHCpK1K1MaUJs8EO0XY0DhLFbYSqVhPOF/RngO
         z5X7b2Y1f4XeQYi86RRew3U5M5/bSZxnqw+COiVW0HBE1gx7+FgkeYEF22bMWhGp8fgr
         h5yL/gPD4EHHymVAQpUgGv2GoXTI7uTyPqBBpRCkxKY7PttO/pVm4ry3fF39DOwKbxtc
         BoADhW/ZP+otoCrmEa/i+zSjn+yHjVnu0PYu51g7LfQz9Ju22AYeC5cDC51AIZjnGTJj
         EGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690942; x=1781295742;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARVgqbS9xgid8HJKEFgckMfwe0D6Z4fgBZF3ZZydQqM=;
        b=YRw8n2uaghM8FHiepdVd327kV0lkV+Zs5pLOQxkdUfCr6lC9lDfVPXJYbVNAO0nAj+
         obi7YXKZmHaoyE9tSUbkNB4M9WLv5ISlBMJLUInLJLe/axO63g1wQ+Cp9YnE8aq+k3gm
         LTdfu++Lq1cDdIdaWWFt8SfD3B/YAON5mCJU4hdwJaO7lsdxtVS1hWQwamNykHvIGpot
         R1eqVZ4NhcjJUnDJ1sAeWC+4DkcLu/hbBQMQQ+rb1QjolGV5iMpuTbudP3xRX/lGI3Rd
         0t/Uf3nnveMz/kbxF8SLspFj7Cq3VJgwxihmDukxFg1VmalWVxY1GRZWPEAR0dP8I1tA
         3c0w==
X-Forwarded-Encrypted: i=1; AFNElJ8Aq73BI/AuDgsT7B3d5Vj2px5Z++mPODMKtFrM+tkO+MCXPw9gRYLCziwEj9xFLGBIijA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfdIFVl+gdhXzGjMDcr+wl3EtvYWS7Ri8o2Vhi25ofNUWGwzSh
	n7uZfoQ6cQ2OLzTAkiPGh5DbB3VtNtquarTObJCcZfDxZVWZSVUTnOXG
X-Gm-Gg: Acq92OHZASCL66kZX5QaYR0jyqn5/WraAzyVo/PoAg9BRP9PR/KV4yoNacW5XQgjlQG
	ShbC82hBOviH7CoL7ERovfutqMoa8hN29PoBCeCsXSjPFXZoAd0ilxCD/GlICXrbLRtDgkB0FtO
	211KbWHXIIIO+2UJ9woihnKZ/LKs1Vk/RORP41zJR4mX51+EffybfYstlTiV0qG0WLjnoyuO5xL
	tfwmNXnpNUErFtHLrzUyX697iZDteZEgXSkBVDVprTFwkMazn4d9SzHnudFSaCVgbruVdzSWwz0
	v+A9VHOyhJ4EN3Wkyfg16WA50KCp0I35AeoebXrQ2kwul6CD9hxfKtLRLoKhrRT2WRdTT51OHOs
	GnrfVPxjG60RdyLzguluHEojUk7dzgWSgaLw+QCPXkioFig5KwhArmnU2t0ybOuqSn2q8ZIj67s
	3m1iBYEguH0RcIMxx2IT0rYE9KLk4FKb/wn68/5tg0d5oJ6byDY8jPd1ppnDzZeg5s9xp/ZzqlM
	h/M/cw2CSDZoyxkEw==
X-Received: by 2002:a05:7300:ec15:b0:2ed:e14:7f5c with SMTP id 5a478bee46e88-3077b2d99efmr2732334eec.32.1780690941550;
        Fri, 05 Jun 2026 13:22:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:de9b:77c7:f63f:9d5? ([2620:10d:c090:500::1:feb2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm11829519eec.5.2026.06.05.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:22:21 -0700 (PDT)
Message-ID: <d41b493ef3351c6dff09050353a400613487991c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/17] bpf: Add source and instruction
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 05 Jun 2026 13:22:19 -0700
In-Reply-To: <20260605063412.974640-4-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 08:33 +0200, Kumar Kartikeya Dwivedi wrote:
> Teach verifier diagnostics to annotate an instruction with BTF source lin=
e
> information and nearby BPF instructions. The renderer keeps source text i=
n
> a fixed-width lane and prints instructions in a stable right-hand gutter.
>=20
> Wrap annotation text under the source line so long error labels are reada=
ble
> while the source and instruction lanes keep their fixed layout.
>=20
> Keeping source and instruction context in one commit preserves the visual
> layout contract that later diagnostic reports rely on.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/diagnostics.c | 384 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/diagnostics.h |   4 +
>  2 files changed, 388 insertions(+)
>=20
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index d9a103cf3a16..652d4627c2b0 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -1,16 +1,45 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> =20
> +#include <linux/bpf.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/btf.h>
> +#include <linux/kernel.h>
>  #include <linux/stdarg.h>
>  #include <linux/string.h>
> =20
> +#include "disasm.h"
>  #include "diagnostics.h"
> =20
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
>  #define BPF_DIAG_TEXT_WIDTH 120
>  #define BPF_DIAG_TEXT_INDENT "  "
>  #define BPF_DIAG_MSG_LEN 512
> +#define BPF_DIAG_SOURCE_CONTEXT 2
> +#define BPF_DIAG_INSN_CONTEXT 2
> +#define BPF_DIAG_COLUMN_GAP 3
> +#define BPF_DIAG_SOURCE_LANE_WIDTH 88
> +#define BPF_DIAG_TAB_WIDTH 8
> +
> +struct bpf_diag_source {
> +	const char *file;
> +	const char *line;
> +	u32 file_name_off;
> +	int line_num;
> +	int line_col;
> +};
> +
> +struct bpf_diag_insn {
> +	char text[160];
> +	int idx;
> +	bool valid;
> +};
> +
> +struct bpf_diag_insn_buf {
> +	char *buf;
> +	size_t size;
> +	size_t len;
> +};
> =20
>  static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env=
,
>  					    const char *first_prefix,
> @@ -68,6 +97,282 @@ static void bpf_diag_vprint_indented(struct bpf_verif=
ier_env *env,
>  	bpf_diag_print_wrapped_text(env, buf);
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

Is claude trolling us?
Or does it have a lot of such samples in the training set?
What is more disturbing?

> +
> +static const char *bpf_diag_func_name(struct bpf_verifier_env *env, u32 =
insn_idx)

There is bpf_subprog_info->name and it should be used in this function.
Plus a fallback in case if there is no BTF info.

Also, maybe drop bpf_diag_ suffix for static functions?

> +{
> +	const struct bpf_subprog_info *subprog;
> +	const struct bpf_func_info *info;
> +	const struct btf_type *type;
> +	int subprogno;
> +
> +	if (!env->prog->aux->func_info || !env->prog->aux->btf)
> +		return NULL;
> +
> +	subprog =3D bpf_find_containing_subprog(env, insn_idx);
> +	if (!subprog)
> +		return NULL;
> +
> +	subprogno =3D subprog - env->subprog_info;
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
> +
> +	file =3D btf_name_by_offset(env->prog->aux->btf, linfo->file_name_off);
> +	line =3D btf_name_by_offset(env->prog->aux->btf, linfo->line_off);
> +	if (!file || !*file || !line || !*line)
> +		return false;
> +
> +	src->file =3D kbasename(file);
> +	src->line =3D line;
> +	src->file_name_off =3D linfo->file_name_off;
> +	src->line_num =3D BPF_LINE_INFO_LINE_NUM(linfo->line_col);
> +	src->line_col =3D BPF_LINE_INFO_LINE_COL(linfo->line_col);
> +	return true;
> +}

Nit: adjust log.c:verbose_linfo() to use this?
     Also, this duplicates core.c:bpf_get_linfo_file_line().
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
> +static const char *bpf_diag_find_source_line(struct bpf_verifier_env *en=
v,
> +					     u32 file_name_off, int line_num)
> +{

Maybe pass an array of size BPF_DIAG_SOURCE_CONTEXT and a range to fill?
Just to avoid scanning multiple times.

> +	const struct bpf_line_info *linfo =3D env->prog->aux->linfo;
> +	struct bpf_diag_source src;
> +	u32 i;
> +
> +	for (i =3D 0; i < env->prog->aux->nr_linfo; i++) {
> +		if (linfo[i].file_name_off !=3D file_name_off ||
> +		    BPF_LINE_INFO_LINE_NUM(linfo[i].line_col) !=3D line_num)
> +			continue;
> +		if (bpf_diag_fill_source(env, &linfo[i], &src))
> +			return src.line;

Nit:
		if (linfo[i].file_name_off =3D=3D file_name_off &&
		    BPF_LINE_INFO_LINE_NUM(linfo[i].line_col) =3D=3D line_num &&
		    bpf_diag_fill_source(env, &linfo[i], &src))
			return src.line;


> +	}
> +
> +	return NULL;
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
> +static const char *bpf_diag_marker_label(char marker)

That's a bit of an obfuscation exercise.
Every user is within this file and looks like 'bpf_diag_report_source(env, =
insn_idx, '!', ...)'.
Why not use some #define and 'bpf_diag_report_source(env, insn_idx, ERROR, =
...)'?

> +{
> +	switch (marker) {
> +	case '!':
> +		return "error";
> +	case '?':
> +		return "branch";
> +	case '~':
> +		return "update";
> +	case '+':
> +		return "acquired";
> +	case '-':
> +		return "released";
> +	default:
> +		return "note";
> +	}
> +}
> +
> +static void bpf_diag_insn_print(void *private_data, const char *fmt, ...=
)
> +{
> +	struct bpf_diag_insn_buf *buf =3D private_data;
> +	va_list args;
> +
> +	if (buf->len >=3D buf->size)
> +		return;
> +
> +	va_start(args, fmt);
> +	buf->len +=3D vscnprintf(buf->buf + buf->len, buf->size - buf->len,
> +			       fmt, args);

Nit: here and in many other places, the maximum line width is 100.

> +	va_end(args);
> +}
> +
> +static const char *bpf_diag_kfunc_name(void *private_data,
> +				       const struct bpf_insn *insn)
> +{

There is already an verifier.c:disasm_kfunc_name().

> +	const struct btf_type *func;
> +	struct btf *btf;
> +
> +	(void)private_data;
> +
> +	if (insn->src_reg !=3D BPF_PSEUDO_KFUNC_CALL || insn->off)
> +		return NULL;
> +
> +	btf =3D bpf_get_btf_vmlinux();
> +	if (IS_ERR_OR_NULL(btf))
> +		return NULL;
> +
> +	func =3D btf_type_by_id(btf, insn->imm);
> +	if (!func)
> +		return NULL;
> +
> +	return btf_name_by_offset(btf, func->name_off);
> +}
> +
> +static void bpf_diag_format_insn(struct bpf_verifier_env *env, int insn_=
idx,
> +				 struct bpf_diag_insn *diag_insn)
> +{
> +	struct bpf_insn *insn;
> +	struct bpf_diag_insn_buf buf =3D {
> +		.buf =3D diag_insn->text,
> +		.size =3D sizeof(diag_insn->text),
> +	};
> +	const struct bpf_insn_cbs cbs =3D {
> +		.cb_call =3D bpf_diag_kfunc_name,
> +		.cb_print =3D bpf_diag_insn_print,
> +		.private_data =3D &buf,
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
> +	while (buf.len && (diag_insn->text[buf.len - 1] =3D=3D '\n' ||
> +			   diag_insn->text[buf.len - 1] =3D=3D '\r'))

Nit: disasm.c does not produce '\r'.

> +		diag_insn->text[--buf.len] =3D '\0';
> +
> +	diag_insn->valid =3D true;
> +}
> +
> +static void bpf_diag_format_source_text(char *buf, size_t size,
> +					const char *line, int width)
> +{
> +	bool truncated =3D false;
> +	int col =3D 0, len =3D 0;

Is 'col' ever different from 'len' in this function?
Seem to be always updated in sync.

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
> +	if (*line)
> +		truncated =3D true;
> +	if (truncated) {

No need for the 'truncated' variable?

  if (*line) { /* truncated */
    ...
  }

> +		int ellipsis_len =3D min(3, width);
> +
> +		while (len > 0 && col > width - ellipsis_len) {
> +			len--;
> +			col--;
> +		}

Use math? Or snprintf?

> +		while (ellipsis_len-- && len + 1 < size) {
> +			buf[len++] =3D '.';
> +			col++;
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
> +	len =3D scnprintf(buf, size, "%s%*d | ",
> +			source_prefix, source_line_width, line_num);
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
> +					    int line_num, const char *line,
> +					    const struct bpf_diag_insn *diag_insn,
> +					    int focus_insn_idx,
> +					    int insn_width)
> +{
> +	char source_lane[BPF_DIAG_SOURCE_LANE_WIDTH + 1];
> +
> +	bpf_diag_format_source_lane(source_lane, sizeof(source_lane),
> +				    source_prefix, source_line_width,
> +				    line_num, line);
> +
> +	verbose(env, "  %-*s%*s", BPF_DIAG_SOURCE_LANE_WIDTH,
> +		source_lane, BPF_DIAG_COLUMN_GAP, "");
> +	if (diag_insn->valid)
> +		verbose(env, "%s%*d | %s",
> +			diag_insn->idx =3D=3D focus_insn_idx ? ">>> " : "    ",
> +			insn_width, diag_insn->idx, diag_insn->text);
> +	verbose(env, "\n");
> +}
> +
>  static const char *bpf_diag_category_name(enum bpf_diag_category categor=
y)
>  {
>  	switch (category) {
> @@ -93,6 +398,7 @@ static const char *bpf_diag_category_name(enum bpf_dia=
g_category category)
>  	}
>  }
> =20
> +
>  void bpf_diag_report_header(struct bpf_verifier_env *env,
>  			    enum bpf_diag_category category,
>  			    const char *problem)
> @@ -134,3 +440,81 @@ void bpf_diag_report_suggestion(struct bpf_verifier_=
env *env, const char *fmt, .
>  	va_end(args);
>  	verbose(env, "\n");
>  }
> +
> +static void bpf_diag_print_source_annotation(struct bpf_verifier_env *en=
v,
> +					     int line_width, int indent,
> +					     const char *label,
> +					     const char *msg)
> +{
> +	char first_prefix[128], next_prefix[128], text[BPF_DIAG_MSG_LEN];
> +
> +	scnprintf(first_prefix, sizeof(first_prefix), "  %*s | %*s^-- ",
> +		  line_width + 4, "", indent, "");
> +	scnprintf(next_prefix, sizeof(next_prefix), "  %*s | %*s    ",
> +		  line_width + 4, "", indent, "");
> +	scnprintf(text, sizeof(text), "%s: %s", label, msg);
> +
> +	bpf_diag_print_wrapped_prefixed(env, first_prefix, next_prefix, text);
> +}
> +
> +void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
> +			    char marker, const char *fmt, ...)
> +{
> +	struct bpf_diag_source src;
> +	struct bpf_diag_insn diag_insn[1 + BPF_DIAG_INSN_CONTEXT * 2];
> +	char msg[BPF_DIAG_MSG_LEN];

Nit: reminder about large buffers belonging to bpf_verifier_env.

> +	const char *func, *label;
> +	int start_line, end_line, line_num, indent, width;
> +	int insn_width, i;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vscnprintf(msg, sizeof(msg), fmt, args);
> +	va_end(args);
> +	label =3D bpf_diag_marker_label(marker);
> +
> +	if (!bpf_diag_get_source(env, insn_idx, &src)) {
> +		verbose(env, "  insn %u\n", insn_idx);
> +		bpf_diag_print_source_annotation(env, 0, 0, label, msg);
> +		return;
> +	}
> +
> +	func =3D bpf_diag_func_name(env, insn_idx);
> +	if (func && *func)
> +		verbose(env, "  %s @ %s:%d:%d\n", func, src.file,
> +			src.line_num, src.line_col);
> +	else
> +		verbose(env, "  %s:%d:%d\n", src.file, src.line_num,
> +			src.line_col);
> +
> +	start_line =3D max_t(int, 1, src.line_num - BPF_DIAG_SOURCE_CONTEXT);
> +	end_line =3D src.line_num + BPF_DIAG_SOURCE_CONTEXT;
> +	width =3D bpf_diag_line_width(end_line);
> +	indent =3D bpf_diag_line_indent(src.line);
> +	insn_width =3D bpf_diag_line_width(env->prog->len ? env->prog->len - 1 =
: 0);

I don't understand, why is 'width =3D=3D end_line / 10 + 1;' and why is 'in=
sn_width =3D=3D prog->len / 10 + 1;'?

> +
> +	for (i =3D 0; i < ARRAY_SIZE(diag_insn); i++) {
> +		int row =3D i - BPF_DIAG_INSN_CONTEXT;
> +
> +		bpf_diag_format_insn(env, insn_idx + row, &diag_insn[i]);
> +	}
> +
> +	for (line_num =3D start_line; line_num <=3D end_line; line_num++) {
> +		const char *line;
> +		int row =3D line_num - src.line_num;
> +
> +		line =3D line_num =3D=3D src.line_num ?
> +		       src.line :
> +		       bpf_diag_find_source_line(env, src.file_name_off, line_num);
> +
> +		bpf_diag_print_source_insn_line(env,
> +						line_num =3D=3D src.line_num ?
> +						">>> " : "    ",
> +						width, line_num, line,
> +						&diag_insn[row + BPF_DIAG_INSN_CONTEXT],
> +						insn_idx, insn_width);
> +		if (line_num =3D=3D src.line_num)
> +			bpf_diag_print_source_annotation(env, width, indent,
> +							 label, msg);
> +	}
> +}
> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index 8bfc7104eeec..ba60cc3af548 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -5,6 +5,7 @@
>  #define __BPF_DIAGNOSTICS_H
> =20
>  #include <linux/compiler_attributes.h>
> +#include <linux/types.h>
> =20
>  enum bpf_diag_category {
>  	BPF_DIAG_CATEGORY_MEMORY_SAFETY,
> @@ -28,5 +29,8 @@ void bpf_diag_report_reason(struct bpf_verifier_env *en=
v, const char *fmt, ...)
>  void bpf_diag_report_section(struct bpf_verifier_env *env, const char *t=
itle);
>  void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char=
 *fmt, ...)
>  	__printf(2, 3);
> +void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
> +			    char marker, const char *fmt, ...)
> +	__printf(4, 5);
> =20
>  #endif /* __BPF_DIAGNOSTICS_H */
