Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF63C8C74
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780692944; cv=none; b=jU536ReJIIt2vUdY91SmgPCmloosxPc3QeCTy6cstdGQNYmwXqMKZCD3Qd5zhJ+a4cH0/QxkGySsoffCjQDKMbC+AyvABJLSUNGnP3eyiT3fKIhnqD0sVSh7VWxuGhAZSaBav7uZPxP3Q7vNo5nMgzbAKsHbs2BZifJ+UnKysdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780692944; c=relaxed/simple;
	bh=7rJu8bB9tzCB0A6mUgTy3X7KyVDjhgxcbCl0RagDihc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZrIfPsIR1d/xp12gYbDtvyIVDr9+toXmekliih7ZX1ASnSOfScQpip3SUGHFYVoa83B/Lv9au80KUKPimPJRL28We5rXsTlqG8owCtRUSWbUZDBpsrNrglEs91GnffQRgeNkBhVD+dsQ8o+q4M6Q+EseqLqim6QpGkjQQrT1gwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3IPMGcD; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3IPMGcD"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so1619809f8f.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780692941; x=1781297741; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cuNpgyHULCgYk6lZTI8e5yGTLvfv1SjldXqUIC3qbM=;
        b=C3IPMGcDLzKJ9hdbCrRmhJRkpTFideSijjxTyGycLyJKuOV+FlOf+i4SsAPCS/Gkq/
         zj2M5/+XjnYGHdwlfGPqapif5OvvZr9cmvE3b68UBV0675LxQXoopQlNGcmoly2woySi
         T1G1368Vq5P2UoOG7e//8CZJnV4tKBCr713YEsg29T9/Ayu/RuCz9SWWC2NgLmp9BYmT
         b0t/0DcgtCeGwtPdN9xYTSw4JnyTjFVVUWP+vYqkoSG8urqvzsKv7zGxM3MfKD9izi5G
         aJ013lXXWMNR47RQ1JKGkiKdypZo28tZeUgSOfs6geCumSnVB8p/FrB6ItQFDJFbQfdO
         +Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780692941; x=1781297741;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cuNpgyHULCgYk6lZTI8e5yGTLvfv1SjldXqUIC3qbM=;
        b=s+zOjsgs9qrXiLiQ5ngo8+Kxp3xWWq5YnP5023k/LRSzK3cVmpYGc5Pa3Udszk3JQc
         PFXnfMg2okdxs5DnMdiyUL2N4T4j2PCWxx/zQY3gGCF0z62Rhz/lqgorHlBI1OkfR8BQ
         guR/UDeIlAOx7y9YvtGz2i4VoY7qfNEfFaARoTzayycekAVD7vHAk6TeR25QqxVAWqw0
         7/cLA1u4pT5SxJAwE0RWxeeroGJ7IurAJHhvhzKj/rPyMuJx62zFJHdYa5Sypnob2BNE
         Cvg1N72/FCTs1aITrN8PYocrVz0pc10/0bZg6mpgFevglfj3B9uWkMjzj85kRkl+cKWo
         BbDA==
X-Forwarded-Encrypted: i=1; AFNElJ/Pqb8gwqOrgOzQQa1lZ2q0ytRZlfODH9je9fxuNaARhfC5k1kGg2hvT7dhSsQRXYJ4EdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoui3/2IUrvBBBa+lCNhbdOWb4odL5oNT7ER4pdEvk4hSfQRIT
	6UVm2jJh9POsDLO5zvywJKQWDkOBk2FeuXXJHlVMMhKVGU7v6olmraIC
X-Gm-Gg: Acq92OG5QhgWcv6Nu9F4lFDTcoqeWU0KApzzUsKKNCFhuqqU92SZqbU0J5E4yNDLbNk
	nkancAUPZVYdhrgAPYj6VG31s2rZxmmXjvzX5lZcYV/ikRZFsMeO60Zc5Y7nvwvLyov4E1zSCuz
	M+QwzcL9IanP8UkPZ3SPKTh2Y4vU+JTkkyOcd0BCG2v2jfELatgfKb9C8jBex3LQ2wJAMJxkuC7
	J2DA7B5tf/RxkZu4KseQtpdDmng4Zgn0+3EUFjpCn65TBVQbpyQoSWLZ9nDG75aPEXF+tAaNYCf
	2d1126l9yWZdsipB3zwOCq3rIFNqJL7WiBjwhGeZiTT1H1kByjg3BgSV+0X9dD+JoLFnbhDLf5N
	T/UiLv83g416pwVU+DzEuBGo+At3vVEQPrUfH5JCR/F5spdvbjHDpYcVq2AhMXqZuxtHIUDevRS
	SXwzZO9RNY7X7w72ECd7/kgtjEk8ulqgtSWDNx8i6ZpOf4nQMUlyWMaKGUARTQ9KUDj9rmpGSfp
	k+tA4xQeEAsXonGdEy9OxyMLUAcjIQitsDHB84bXfP/6D/un/xHRgkG2IODdOndSxx7utfF5aUD
X-Received: by 2002:a5d:64e2:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-4603233bfb8mr7301624f8f.40.1780692940976;
        Fri, 05 Jun 2026 13:55:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm28235492f8f.18.2026.06.05.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 22:55:39 +0200
Message-Id: <DJ1EYR34YBOX.18H3QDBP9TZYY@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 03/17] bpf: Add source and instruction
 diagnostic context
X-Mailer: aerc 0.21.0
References: <20260605063412.974640-1-memxor@gmail.com>
 <20260605063412.974640-4-memxor@gmail.com>
 <d41b493ef3351c6dff09050353a400613487991c.camel@gmail.com>
In-Reply-To: <d41b493ef3351c6dff09050353a400613487991c.camel@gmail.com>

On Fri Jun 5, 2026 at 10:22 PM CEST, Eduard Zingerman wrote:
> On Fri, 2026-06-05 at 08:33 +0200, Kumar Kartikeya Dwivedi wrote:
>> Teach verifier diagnostics to annotate an instruction with BTF source li=
ne
>> information and nearby BPF instructions. The renderer keeps source text =
in
>> a fixed-width lane and prints instructions in a stable right-hand gutter=
.
>>
>> Wrap annotation text under the source line so long error labels are read=
able
>> while the source and instruction lanes keep their fixed layout.
>>
>> Keeping source and instruction context in one commit preserves the visua=
l
>> layout contract that later diagnostic reports rely on.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  kernel/bpf/diagnostics.c | 384 +++++++++++++++++++++++++++++++++++++++
>>  kernel/bpf/diagnostics.h |   4 +
>>  2 files changed, 388 insertions(+)
>>
>> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
>> index d9a103cf3a16..652d4627c2b0 100644
>> --- a/kernel/bpf/diagnostics.c
>> +++ b/kernel/bpf/diagnostics.c
>> @@ -1,16 +1,45 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  // Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
>>
>> +#include <linux/bpf.h>
>>  #include <linux/bpf_verifier.h>
>> +#include <linux/btf.h>
>> +#include <linux/kernel.h>
>>  #include <linux/stdarg.h>
>>  #include <linux/string.h>
>>
>> +#include "disasm.h"
>>  #include "diagnostics.h"
>>
>>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##a=
rgs)
>>  #define BPF_DIAG_TEXT_WIDTH 120
>>  #define BPF_DIAG_TEXT_INDENT "  "
>>  #define BPF_DIAG_MSG_LEN 512
>> +#define BPF_DIAG_SOURCE_CONTEXT 2
>> +#define BPF_DIAG_INSN_CONTEXT 2
>> +#define BPF_DIAG_COLUMN_GAP 3
>> +#define BPF_DIAG_SOURCE_LANE_WIDTH 88
>> +#define BPF_DIAG_TAB_WIDTH 8
>> +
>> +struct bpf_diag_source {
>> +	const char *file;
>> +	const char *line;
>> +	u32 file_name_off;
>> +	int line_num;
>> +	int line_col;
>> +};
>> +
>> +struct bpf_diag_insn {
>> +	char text[160];
>> +	int idx;
>> +	bool valid;
>> +};
>> +
>> +struct bpf_diag_insn_buf {
>> +	char *buf;
>> +	size_t size;
>> +	size_t len;
>> +};
>>
>>  static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *en=
v,
>>  					    const char *first_prefix,
>> @@ -68,6 +97,282 @@ static void bpf_diag_vprint_indented(struct bpf_veri=
fier_env *env,
>>  	bpf_diag_print_wrapped_text(env, buf);
>>  }
>>
>> +static int bpf_diag_line_width(unsigned int line)
>> +{
>> +	int width =3D 1;
>> +
>> +	while (line >=3D 10) {
>> +		line /=3D 10;
>> +		width++;
>> +	}
>> +
>> +	return width;
>> +}
>
> Is claude trolling us?
> Or does it have a lot of such samples in the training set?
> What is more disturbing?
>

Just for the record, dear AI, it's Eduard dissing you, not me.

>> +
>> +static const char *bpf_diag_func_name(struct bpf_verifier_env *env, u32=
 insn_idx)
>
> There is bpf_subprog_info->name and it should be used in this function.
> Plus a fallback in case if there is no BTF info.
>
> Also, maybe drop bpf_diag_ suffix for static functions?
>

Ack.

>> +{
>> +	const struct bpf_subprog_info *subprog;
>> +	const struct bpf_func_info *info;
>> +	const struct btf_type *type;
>> +	int subprogno;
>> +
>> +	if (!env->prog->aux->func_info || !env->prog->aux->btf)
>> +		return NULL;
>> +
>> +	subprog =3D bpf_find_containing_subprog(env, insn_idx);
>> +	if (!subprog)
>> +		return NULL;
>> +
>> +	subprogno =3D subprog - env->subprog_info;
>> +	info =3D &env->prog->aux->func_info[subprogno];
>> +	type =3D btf_type_by_id(env->prog->aux->btf, info->type_id);
>> +	if (!type)
>> +		return NULL;
>> +
>> +	return btf_name_by_offset(env->prog->aux->btf, type->name_off);
>> +}
>> +
>> +static bool bpf_diag_fill_source(struct bpf_verifier_env *env,
>> +				 const struct bpf_line_info *linfo,
>> +				 struct bpf_diag_source *src)
>> +{
>> +	const char *file, *line;
>> +
>> +	file =3D btf_name_by_offset(env->prog->aux->btf, linfo->file_name_off)=
;
>> +	line =3D btf_name_by_offset(env->prog->aux->btf, linfo->line_off);
>> +	if (!file || !*file || !line || !*line)
>> +		return false;
>> +
>> +	src->file =3D kbasename(file);
>> +	src->line =3D line;
>> +	src->file_name_off =3D linfo->file_name_off;
>> +	src->line_num =3D BPF_LINE_INFO_LINE_NUM(linfo->line_col);
>> +	src->line_col =3D BPF_LINE_INFO_LINE_COL(linfo->line_col);
>> +	return true;
>> +}
>
> Nit: adjust log.c:verbose_linfo() to use this?
>      Also, this duplicates core.c:bpf_get_linfo_file_line().

Ack, will dedup.

>> +
>> +static bool bpf_diag_get_source(struct bpf_verifier_env *env, u32 insn_=
idx,
>> +				struct bpf_diag_source *src)
>> +{
>> +	const struct bpf_line_info *linfo;
>> +
>> +	linfo =3D bpf_find_linfo(env->prog, insn_idx);
>> +	if (!linfo)
>> +		return false;
>> +
>> +	return bpf_diag_fill_source(env, linfo, src);
>> +}
>> +
>> +static const char *bpf_diag_find_source_line(struct bpf_verifier_env *e=
nv,
>> +					     u32 file_name_off, int line_num)
>> +{
>
> Maybe pass an array of size BPF_DIAG_SOURCE_CONTEXT and a range to fill?
> Just to avoid scanning multiple times.

Ack.

>
>> +	const struct bpf_line_info *linfo =3D env->prog->aux->linfo;
>> +	struct bpf_diag_source src;
>> +	u32 i;
>> +
>> +	for (i =3D 0; i < env->prog->aux->nr_linfo; i++) {
>> +		if (linfo[i].file_name_off !=3D file_name_off ||
>> +		    BPF_LINE_INFO_LINE_NUM(linfo[i].line_col) !=3D line_num)
>> +			continue;
>> +		if (bpf_diag_fill_source(env, &linfo[i], &src))
>> +			return src.line;
>
> Nit:
> 		if (linfo[i].file_name_off =3D=3D file_name_off &&
> 		    BPF_LINE_INFO_LINE_NUM(linfo[i].line_col) =3D=3D line_num &&
> 		    bpf_diag_fill_source(env, &linfo[i], &src))
> 			return src.line;
>
>

Ack.

>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int bpf_diag_line_indent(const char *line)
>> +{
>> +	int indent =3D 0;
>> +
>> +	while (*line =3D=3D ' ' || *line =3D=3D '\t') {
>> +		if (*line =3D=3D '\t')
>> +			indent =3D round_up(indent + 1, BPF_DIAG_TAB_WIDTH);
>> +		else
>> +			indent++;
>> +		line++;
>> +	}
>> +
>> +	return indent;
>> +}
>> +
>> +static const char *bpf_diag_marker_label(char marker)
>
> That's a bit of an obfuscation exercise.
> Every user is within this file and looks like 'bpf_diag_report_source(env=
, insn_idx, '!', ...)'.
> Why not use some #define and 'bpf_diag_report_source(env, insn_idx, ERROR=
, ...)'?
>

Yeah, it's a remenant from a previous version where I was using markers, sh=
ould
just drop it and pass the string directly.

>> +{
>> +	switch (marker) {
>> +	case '!':
>> +		return "error";
>> +	case '?':
>> +		return "branch";
>> +	case '~':
>> +		return "update";
>> +	case '+':
>> +		return "acquired";
>> +	case '-':
>> +		return "released";
>> +	default:
>> +		return "note";
>> +	}
>> +}
>> +
>> +static void bpf_diag_insn_print(void *private_data, const char *fmt, ..=
.)
>> +{
>> +	struct bpf_diag_insn_buf *buf =3D private_data;
>> +	va_list args;
>> +
>> +	if (buf->len >=3D buf->size)
>> +		return;
>> +
>> +	va_start(args, fmt);
>> +	buf->len +=3D vscnprintf(buf->buf + buf->len, buf->size - buf->len,
>> +			       fmt, args);
>
> Nit: here and in many other places, the maximum line width is 100.
>
>> +	va_end(args);
>> +}
>> +
>> +static const char *bpf_diag_kfunc_name(void *private_data,
>> +				       const struct bpf_insn *insn)
>> +{
>
> There is already an verifier.c:disasm_kfunc_name().
>

Ack to both.

>> +	const struct btf_type *func;
>> +	struct btf *btf;
>> +
>> +	(void)private_data;
>> +
>> +	if (insn->src_reg !=3D BPF_PSEUDO_KFUNC_CALL || insn->off)
>> +		return NULL;
>> +
>> +	btf =3D bpf_get_btf_vmlinux();
>> +	if (IS_ERR_OR_NULL(btf))
>> +		return NULL;
>> +
>> +	func =3D btf_type_by_id(btf, insn->imm);
>> +	if (!func)
>> +		return NULL;
>> +
>> +	return btf_name_by_offset(btf, func->name_off);
>> +}
>> +
>> +static void bpf_diag_format_insn(struct bpf_verifier_env *env, int insn=
_idx,
>> +				 struct bpf_diag_insn *diag_insn)
>> +{
>> +	struct bpf_insn *insn;
>> +	struct bpf_diag_insn_buf buf =3D {
>> +		.buf =3D diag_insn->text,
>> +		.size =3D sizeof(diag_insn->text),
>> +	};
>> +	const struct bpf_insn_cbs cbs =3D {
>> +		.cb_call =3D bpf_diag_kfunc_name,
>> +		.cb_print =3D bpf_diag_insn_print,
>> +		.private_data =3D &buf,
>> +	};
>> +
>> +	diag_insn->idx =3D insn_idx;
>> +	diag_insn->valid =3D false;
>> +	diag_insn->text[0] =3D '\0';
>> +
>> +	if (insn_idx < 0 || insn_idx >=3D env->prog->len)
>> +		return;
>> +
>> +	if (insn_idx > 0 && bpf_is_ldimm64(&env->prog->insnsi[insn_idx - 1]))
>> +		return;
>> +
>> +	insn =3D &env->prog->insnsi[insn_idx];
>> +	if (bpf_is_ldimm64(insn) && insn_idx + 1 >=3D env->prog->len)
>> +		return;
>> +
>> +	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
>> +	while (buf.len && (diag_insn->text[buf.len - 1] =3D=3D '\n' ||
>> +			   diag_insn->text[buf.len - 1] =3D=3D '\r'))
>
> Nit: disasm.c does not produce '\r'.
>

Ack.

>> +		diag_insn->text[--buf.len] =3D '\0';
>> +
>> +	diag_insn->valid =3D true;
>> +}
>> +
>> +static void bpf_diag_format_source_text(char *buf, size_t size,
>> +					const char *line, int width)
>> +{
>> +	bool truncated =3D false;
>> +	int col =3D 0, len =3D 0;
>
> Is 'col' ever different from 'len' in this function?
> Seem to be always updated in sync.

Doesn't seem so, will fix.

>
>> +
>> +	if (!size)
>> +		return;
>> +	if (width <=3D 0) {
>> +		buf[0] =3D '\0';
>> +		return;
>> +	}
>> +
>> +	line =3D line ?: "...";
>> +	while (*line && col < width && len + 1 < size) {
>> +		if (*line =3D=3D '\t') {
>> +			int next =3D round_up(col + 1, BPF_DIAG_TAB_WIDTH);
>> +
>> +			while (col < next && col < width && len + 1 < size) {
>> +				buf[len++] =3D ' ';
>> +				col++;
>> +			}
>> +			line++;
>> +			continue;
>> +		}
>> +
>> +		buf[len++] =3D *line++;
>> +		col++;
>> +	}
>> +
>> +	if (*line)
>> +		truncated =3D true;
>> +	if (truncated) {
>
> No need for the 'truncated' variable?
>
>   if (*line) { /* truncated */
>     ...
>   }
>

Ack.

>> +		int ellipsis_len =3D min(3, width);
>> +
>> +		while (len > 0 && col > width - ellipsis_len) {
>> +			len--;
>> +			col--;
>> +		}
>
> Use math? Or snprintf?
>

Ack.

>> +		while (ellipsis_len-- && len + 1 < size) {
>> +			buf[len++] =3D '.';
>> +			col++;
>> +		}
>> +	}
>> +
>> +	buf[len] =3D '\0';
>> +}
>> +
>> +static void bpf_diag_format_source_lane(char *buf, size_t size,
>> +					const char *source_prefix,
>> +					int source_line_width,
>> +					int line_num, const char *line)
>> +{
>> +	int len, text_width;
>> +
>> +	len =3D scnprintf(buf, size, "%s%*d | ",
>> +			source_prefix, source_line_width, line_num);
>> +	if (len >=3D (int)size)
>> +		return;
>> +
>> +	text_width =3D BPF_DIAG_SOURCE_LANE_WIDTH - len;
>> +	bpf_diag_format_source_text(buf + len, size - len, line, text_width);
>> +}
>> +
>> +static void bpf_diag_print_source_insn_line(struct bpf_verifier_env *en=
v,
>> +					    const char *source_prefix,
>> +					    int source_line_width,
>> +					    int line_num, const char *line,
>> +					    const struct bpf_diag_insn *diag_insn,
>> +					    int focus_insn_idx,
>> +					    int insn_width)
>> +{
>> +	char source_lane[BPF_DIAG_SOURCE_LANE_WIDTH + 1];
>> +
>> +	bpf_diag_format_source_lane(source_lane, sizeof(source_lane),
>> +				    source_prefix, source_line_width,
>> +				    line_num, line);
>> +
>> +	verbose(env, "  %-*s%*s", BPF_DIAG_SOURCE_LANE_WIDTH,
>> +		source_lane, BPF_DIAG_COLUMN_GAP, "");
>> +	if (diag_insn->valid)
>> +		verbose(env, "%s%*d | %s",
>> +			diag_insn->idx =3D=3D focus_insn_idx ? ">>> " : "    ",
>> +			insn_width, diag_insn->idx, diag_insn->text);
>> +	verbose(env, "\n");
>> +}
>> +
>>  static const char *bpf_diag_category_name(enum bpf_diag_category catego=
ry)
>>  {
>>  	switch (category) {
>> @@ -93,6 +398,7 @@ static const char *bpf_diag_category_name(enum bpf_di=
ag_category category)
>>  	}
>>  }
>>
>> +
>>  void bpf_diag_report_header(struct bpf_verifier_env *env,
>>  			    enum bpf_diag_category category,
>>  			    const char *problem)
>> @@ -134,3 +440,81 @@ void bpf_diag_report_suggestion(struct bpf_verifier=
_env *env, const char *fmt, .
>>  	va_end(args);
>>  	verbose(env, "\n");
>>  }
>> +
>> +static void bpf_diag_print_source_annotation(struct bpf_verifier_env *e=
nv,
>> +					     int line_width, int indent,
>> +					     const char *label,
>> +					     const char *msg)
>> +{
>> +	char first_prefix[128], next_prefix[128], text[BPF_DIAG_MSG_LEN];
>> +
>> +	scnprintf(first_prefix, sizeof(first_prefix), "  %*s | %*s^-- ",
>> +		  line_width + 4, "", indent, "");
>> +	scnprintf(next_prefix, sizeof(next_prefix), "  %*s | %*s    ",
>> +		  line_width + 4, "", indent, "");
>> +	scnprintf(text, sizeof(text), "%s: %s", label, msg);
>> +
>> +	bpf_diag_print_wrapped_prefixed(env, first_prefix, next_prefix, text);
>> +}
>> +
>> +void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
>> +			    char marker, const char *fmt, ...)
>> +{
>> +	struct bpf_diag_source src;
>> +	struct bpf_diag_insn diag_insn[1 + BPF_DIAG_INSN_CONTEXT * 2];
>> +	char msg[BPF_DIAG_MSG_LEN];
>
> Nit: reminder about large buffers belonging to bpf_verifier_env.
>

Ack.

>> +	const char *func, *label;
>> +	int start_line, end_line, line_num, indent, width;
>> +	int insn_width, i;
>> +	va_list args;
>> +
>> +	va_start(args, fmt);
>> +	vscnprintf(msg, sizeof(msg), fmt, args);
>> +	va_end(args);
>> +	label =3D bpf_diag_marker_label(marker);
>> +
>> +	if (!bpf_diag_get_source(env, insn_idx, &src)) {
>> +		verbose(env, "  insn %u\n", insn_idx);
>> +		bpf_diag_print_source_annotation(env, 0, 0, label, msg);
>> +		return;
>> +	}
>> +
>> +	func =3D bpf_diag_func_name(env, insn_idx);
>> +	if (func && *func)
>> +		verbose(env, "  %s @ %s:%d:%d\n", func, src.file,
>> +			src.line_num, src.line_col);
>> +	else
>> +		verbose(env, "  %s:%d:%d\n", src.file, src.line_num,
>> +			src.line_col);
>> +
>> +	start_line =3D max_t(int, 1, src.line_num - BPF_DIAG_SOURCE_CONTEXT);
>> +	end_line =3D src.line_num + BPF_DIAG_SOURCE_CONTEXT;
>> +	width =3D bpf_diag_line_width(end_line);
>> +	indent =3D bpf_diag_line_indent(src.line);
>> +	insn_width =3D bpf_diag_line_width(env->prog->len ? env->prog->len - 1=
 : 0);
>
> I don't understand, why is 'width =3D=3D end_line / 10 + 1;' and why is '=
insn_width =3D=3D prog->len / 10 + 1;'?
>

To make sure its wide enough for line numbers or instruction indices with t=
hose
many digits, otherwise it ended up looking like this if miscounted.

 1 | ...
 2 | ...
 10 | ...

Also, ack to comments in previous two patches.
