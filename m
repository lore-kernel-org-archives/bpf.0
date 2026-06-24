Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D72320CD9
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328647; cv=none; b=ShsU4+RunhmkuEovnNgCYC9sePrJFMt2W02c8Sp2ZxdbGO1pIZAxxC+AcirzDL9GsVnHT82s9tkhkto7P5RJ26J69QqfHkUxmpU2UXiS2kDPj6SfwAZvBtBQe4qpU2T1tgBPRdC8H/yxTk8WilD5uLdweYF/ir/+ly2Wb+8uUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328647; c=relaxed/simple;
	bh=KJNXt93JYbBoyOYkqkR2Z6NM5LJ4fYJg/1me498z9EE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvPLICys+l2slXNcVvbH0aRKamRoQdHFdk0xLwEQUWEvJOcsT+ciY8afiJOfckaNOK3m2cszNY0YEzfcCQyPTxC6DiMLgk8pzyYdjNKq0U6FsXWenDIqEiNl+agatRqDBK1iLyXppFnOAQTQHE1VrtQVZo1CsW7gNZgg5FpCidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ok8ny4KE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok8ny4KE"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85822059d8so880510a12.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782328644; x=1782933444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VA+qeKnm2x4yZ0EOhxaHEAPVa6hAYbDKO12rvLolsk=;
        b=ok8ny4KE7m3l77rh/hjTOAAQCZH7605KLgm98ftYe0Sg9Hcva1MHiNWv0ij481z7ID
         2vU27CzzXXZkiojiHofwg8LCJ35FQn/VMUisFomihitmc99MuJjQdMWIZAvaCi9uBq9S
         PbI/jEzxek5Ad9EbsIFA7GNmZ1hlG4WeRw5Elt8Kt4Z/pRZFhbvFx9xpEgZvR5wdk3DP
         zRCjexftJP6CR1M9dUONNLy3ylpnDqllMBCxwPRk7b2Vl25TbvdgiYn/mrQ1Q0dI89lR
         NeWwWoI6HKTL9a+6JB6KTRo8Rz4CDCD+9fPIoGxAWwlC8YWD2VvspaYdArifCTtLRbsJ
         PL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328644; x=1782933444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VA+qeKnm2x4yZ0EOhxaHEAPVa6hAYbDKO12rvLolsk=;
        b=Hq8WmXDWSV2d5UTV00c37BUWZXqTxnHelIiXiRGLB7Bawr42IM0IqQhOgVSoAN+w4l
         ngpzSgBUh1hi2xhW/j+Oej3At355+x80IimJNU8oZYrdP71Tkmz2e/0rGvh76Q3G8om1
         MRFUqsqYkLy6QTWumivmVr4VgyQk0WH3VSRKWpA3GnEL16l2YBzpoXf3Amkh3vUg1HAs
         SHXpC3YZT9+PBRAJ5cAyn4pDlMc+Z9OfyJz4loF0Y8k0Cwh72qDyVkOVRIhHpwYoS7sl
         RSAenhIG7JjF5NuynnVr3NbV4H79vf/zG+16EKsRkvxhTq+LHK64jL9TE34XIrtSAYSa
         o9bQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/QucFwWZ5+4DSH6VZJPjiRqZJ48fM6JcJSDz95Lm/mrETB3eFH2QzdX+M7m1fUmByc88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSIxtjQTjO6kq1GyL57WAxGLIkVG+IqhwdzgIr+5foucq/UFTJ
	BzYJxZFEM86c5JL1LiQASfYDwN6DSGNAsWw7bgfzOiSvkkCiRuHGpIqi
X-Gm-Gg: AfdE7cld4C39COMIoQapTza9KDzi2HAuiiNZl9AbBgRJwX7L/o4Nsd1tlQnj2oY5k8Y
	OH5sAfv8Ti0/dlxvLTdpw4T9kAHqNxNlc2XY6LcDahpKby2lJazrLzIUUoNNsSt/fBu3haq0Gyg
	+eMgGh8G7JfkX2qoZyvrSGo2WkI+9PwiPOxYoG6nTpoxLgzk0S4BXB5CDqosQW047D8D+f2qMU5
	jWMfbSaHg9vK3Nc0EMDPnpdwvE3ZSgwv3qF2FLYQilQQ7bo0BzCWYi6bl5+W7SsDoFNzPqu6X4D
	lPLsFPAKJi2J9t3fq06F+M1bullbbxqwam9onRkHWuJvwqU19px2jeo8u8p8kPVBVtMLNiJIG6M
	aL2K7zuHGIM/6y9GveUq7fbap6dvE+rxL3kLJnP+nrrFFQGYTDM1vNwEG7UjsJFOJKlGcDXI8fW
	rYR2cOyMdMcE7JmnTmOdJYack4QTdtcHs+1bx3WOSiEQ==
X-Received: by 2002:a05:6a21:7d03:b0:3b4:7aae:1ef4 with SMTP id adf61e73a8af0-3bd2cffd2f7mr5587546637.9.1782328644009;
        Wed, 24 Jun 2026 12:17:24 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b96ec739sm357661a12.2.2026.06.24.12.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:17:23 -0700 (PDT)
Message-ID: <2b1106db8b63e52dc58f7d9284c26b4ff8b9b05f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/17] bpf: Track verifier register
 diagnostic events
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 12:17:18 -0700
In-Reply-To: <20260619205934.1312876-6-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-6-memxor@gmail.com>
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

So, this very Claudy to my taste, so I left a bunch of nits.
Nits are nits, but please give it some thought, I'm not sure we are
going to revisit this code once it lands.

Of the real issues I'd ask to cover the varying offset stack access to
avoid misleading error messages. Also please take a look at structures
layout: pahole -C bpf_diag_<...> vmlinux.

[...]

>  kernel/bpf/diagnostics.c | 766 ++++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/diagnostics.h | 113 +++++-
>  kernel/bpf/verifier.c    | 269 +++++++++++++-
>  3 files changed, 1137 insertions(+), 11 deletions(-)

This is a huge patch-set :( I'll proceed tomorrow.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index fa5a25b314a0..f51b2860c11d 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -75,11 +75,24 @@ struct bpf_diag_log {
>  	u32 cap;
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
> +
>  struct bpf_diag_scratch {
>  	char str[BPF_DIAG_SCRATCH_STR_CNT][BPF_DIAG_SCRATCH_STR_LEN];
>  	struct bpf_diag_source source;
>  	struct bpf_diag_source_line source_lines[BPF_DIAG_SOURCE_LINE_CNT];
>  	struct bpf_diag_insn insns[BPF_DIAG_INSN_CNT];
> +	struct bpf_diag_reg_fmt reg_fmt;
>  };
> =20
>  struct bpf_diag {
> @@ -299,6 +312,47 @@ static void bpf_diag_print_wrapped_text(struct bpf_v=
erifier_env *env,
>  					BPF_DIAG_TEXT_INDENT, text);
>  }
> =20
> +static void bpf_diag_trim_btf_show_name(char *buf)
> +{
> +	size_t len =3D strlen(buf);
> +
> +	if (len && buf[len - 1] =3D=3D '{')
> +		buf[len - 1] =3D '\0';
> +}

Let's inline this function.
Also, can the btf_show_name produce '{' at all?

> +
> +void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *=
btf,
> +			      u32 type_id)
> +{
> +	int ret;
> +
> +	if (!size)
> +		return;

I think Claude is overly defensive here (and elsewhere).

> +
> +	buf[0] =3D '\0';
> +	ret =3D btf_type_snprintf_show_name(btf, type_id, buf, size);
> +	if (ret < 0 || !buf[0]) {
> +		scnprintf(buf, size, "BTF type ID %u", type_id);

Tbh, this looks like something that btf_type_snprintf_show_name() can do,
w/o introduction of an additional call level.

> +		return;
> +	}
> +
> +	bpf_diag_trim_btf_show_name(buf);
> +}
> +
> +const char *bpf_diag_format_btf_type_scratch(struct bpf_verifier_env *en=
v,
> +					     unsigned int slot,
> +					     const struct btf *btf,
> +					     u32 type_id)
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
>  static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
>  				     const char *fmt, va_list args)
>  {
> @@ -795,11 +849,703 @@ void bpf_diag_record_branch(struct bpf_verifier_en=
v *env, u32 insn_idx,
>  	bpf_diag_append_history(env, &event);
>  }
> =20
> -void bpf_diag_print_history(struct bpf_verifier_env *env)
> +static void bpf_diag_snapshot_one_reg(struct bpf_diag_reg_snapshot *snap=
shot,
> +				      const struct bpf_reg_state *reg)

Nit: "bpf_diag_snapshot_reg" and "bpf_diag_snapshot_regs".

Also, please drop "bpf_diag_" prefix for static functions.

> +{
> +	snapshot->type =3D reg->type;
> +	if (base_type(reg->type) =3D=3D PTR_TO_MAP_VALUE ||
> +	    base_type(reg->type) =3D=3D CONST_PTR_TO_MAP ||
> +	    base_type(reg->type) =3D=3D PTR_TO_MAP_KEY)

log.c has type_is_map_ptr(), shall we make it non-static and reuse here?

> +		snapshot->map_ptr =3D reg->map_ptr;
> +	if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID && reg->btf && reg->btf_i=
d) {
> +		snapshot->btf =3D reg->btf;
> +		snapshot->btf_id =3D reg->btf_id;
> +	}
> +	snapshot->var_off =3D reg->var_off;
> +	snapshot->r64 =3D reg->r64;
> +}
> +
> +static void bpf_diag_snapshot_reg(struct bpf_diag_history_event *event,
> +				  enum bpf_diag_reg_mod_reason reason,
> +				  const struct bpf_reg_state *old_reg,
> +				  const struct bpf_reg_state *new_reg)
> +{
> +	event->reg.reason =3D reason;
> +	bpf_diag_snapshot_one_reg(&event->reg.old, old_reg);
> +	bpf_diag_snapshot_one_reg(&event->reg.new, new_reg);
> +}
> +
> +static bool bpf_diag_snapshot_eq(const struct bpf_diag_reg_snapshot *old=
,
> +				 const struct bpf_diag_reg_snapshot *new)
> +{
> +	return old->type =3D=3D new->type &&
> +	       old->map_ptr =3D=3D new->map_ptr &&
> +	       old->btf =3D=3D new->btf &&
> +	       old->btf_id =3D=3D new->btf_id &&
> +	       old->var_off.value =3D=3D new->var_off.value &&
> +	       old->var_off.mask =3D=3D new->var_off.mask &&
> +	       old->r64.base =3D=3D new->r64.base &&
> +	       old->r64.size =3D=3D new->r64.size;
> +}
> +
> +static bool bpf_diag_reg_snapshot_eq(const struct bpf_diag_history_event=
 *event)
> +{
> +	return bpf_diag_snapshot_eq(&event->reg.old, &event->reg.new);
> +}

I'm curious, does the _eq-based filtering fire often?
Also, I'd just make sure that the event is properly zeroed out before
filling and memcmp it ('log->events[log->cnt++] =3D *event' won't copy
holes, as far as I remember).

> +
> +static void bpf_diag_record_reg_mod_reason(struct bpf_verifier_env *env,
> +					   u32 insn_idx, u32 frameno,
> +					   u8 dst_reg, bool src_valid,
> +					   u8 src_reg, u8 opcode,
> +					   bool stack_slot_valid,
> +					   u32 stack_frameno,
> +					   u16 stack_spi,
> +					   enum bpf_diag_reg_mod_reason reason,
> +					   const struct bpf_reg_state *old_reg,
> +					   const struct bpf_reg_state *new_reg)
> +{
> +	struct bpf_diag_history_event event =3D {
> +		.insn_idx =3D insn_idx,
> +		.kind =3D BPF_DIAG_HISTORY_REG_MOD,
> +		.reg.frameno =3D frameno,
> +		.reg.dst_reg =3D dst_reg,
> +		.reg.src_reg =3D src_reg,
> +		.reg.opcode =3D opcode,

Let's infer opcode from instruction itself, no need to pass it.

> +		.reg.src_valid =3D src_valid,

src_reg and src_valid are never read.

> +		.reg.stack_slot_valid =3D stack_slot_valid,
> +		.reg.stack_frameno =3D stack_frameno,
> +		.reg.stack_spi =3D stack_spi,
> +	};
> +
> +	bpf_diag_snapshot_reg(&event, reason, old_reg, new_reg);

Let's inline 'bpf_diag_snapshot_reg', there is only one caller.

> +	if (reason =3D=3D BPF_DIAG_REG_MOD_WRITE &&
> +	    bpf_diag_reg_snapshot_eq(&event))
> +		return;
> +
> +	bpf_diag_append_history(env, &event);
> +}
> +

[...]

> +static void bpf_diag_history_follow_reg_stack(const struct bpf_diag_log =
*log,
> +					      struct bpf_diag_history_filter *filter)
> +{
> +	const struct bpf_diag_history_opts *opts =3D filter->opts;
> +	int i;
> +
> +	if (!opts || opts->scope !=3D BPF_DIAG_HISTORY_SCOPE_REG)
> +		return;
> +
> +	for (i =3D log->cnt; i > 0; i--) {
> +		const struct bpf_diag_history_event *event;
> +
> +		event =3D bpf_diag_history_event(log, i - 1);
> +		if (!bpf_diag_reg_event_matches(event, opts))
> +			continue;
> +
> +		if (event->reg.stack_slot_valid) {
> +			filter->stack_slot_valid =3D true;
> +			filter->stack_frameno =3D event->reg.stack_frameno;
> +			filter->stack_spi =3D event->reg.stack_spi;
> +			filter->stack_until_idx =3D i - 1;
> +			return;
> +		}
> +
> +		if (!bpf_diag_reg_event_keeps_lineage(event))
> +			return;
> +	}
> +}

Nit: a comment stating "find the nearest spill to the target stack slot"
     would be helpful.

> +static int bpf_diag_history_stack_start_idx(const struct bpf_diag_log *l=
og,
> +					    const struct bpf_diag_history_filter *filter)
> +{
> +	int fallback =3D filter->stack_until_idx;
> +	int i;
> +
> +	for (i =3D filter->stack_until_idx + 1; i > 0; i--) {
> +		const struct bpf_diag_history_event *event;
> +
> +		event =3D bpf_diag_history_event(log, i - 1);
> +		if (!bpf_diag_stack_slot_matches(event, filter))
> +			continue;
> +
> +		fallback =3D i - 1;
> +		if (event->stack_slot.reason =3D=3D BPF_DIAG_STACK_SLOT_SPILL)
> +			return fallback;
> +	}
> +
> +	return fallback;
> +}

[...]

> +static void bpf_diag_print_stack_slot(struct bpf_verifier_env *env,
> +				      const struct bpf_diag_history_event *event)
> +{
> +	struct bpf_diag_scratch *scratch =3D bpf_diag_scratch(env);
> +	struct bpf_diag_reg_fmt *fmt =3D &scratch->reg_fmt;
> +	const char *reason =3D NULL;
> +	int off =3D bpf_diag_stack_slot_off(event->stack_slot.spi);
> +
> +	memset(fmt, 0, sizeof(*fmt));
> +
> +	bpf_diag_format_reg_snapshot(env, fmt, fmt->old_buf,
> +				     sizeof(fmt->old_buf),
> +				     &event->stack_slot.old);
> +	bpf_diag_format_reg_snapshot(env, fmt, fmt->new_buf,
> +				     sizeof(fmt->new_buf),
> +				     &event->stack_slot.new);
> +
> +	switch (event->stack_slot.reason) {
> +	case BPF_DIAG_STACK_SLOT_REF_RELEASE:
> +		reason =3D "resource release invalidated this spilled value";
> +		break;
> +	case BPF_DIAG_STACK_SLOT_PKT_DATA_CHANGE:
> +		reason =3D "packet data may have moved";
> +		break;
> +	case BPF_DIAG_STACK_SLOT_NON_OWN_REF:
> +		reason =3D "leaving the protected region invalidated this borrowed poi=
nter";
> +		break;
> +	case BPF_DIAG_STACK_SLOT_WRITE:
> +		reason =3D "a later stack write overwrote this spilled value";
> +		break;

I think this patch has to handle varying offset writes to stack as well,
otherwise the reported history might be somewhat misleading.

> +	case BPF_DIAG_STACK_SLOT_SPILL:
> +	default:
> +		break;
> +	}
> +
> +	if (reason) {
> +		bpf_diag_report_source(env, event->insn_idx, "invalidated",
> +				       "stack slot fp%d: %s; previous value was %s",
> +				       off, reason, fmt->old_buf);
> +		return;
> +	}
> +
> +	bpf_diag_report_source(env, event->insn_idx, "spilled",
> +			       "stack slot fp%d changed from %s to %s",
> +			       off, fmt->old_buf, fmt->new_buf);
> +}
> +
> +void bpf_diag_print_history(struct bpf_verifier_env *env,
> +			    const struct bpf_diag_history_opts *opts)
>  {
>  	const struct bpf_diag_history_event *event;
> +	struct bpf_diag_history_filter filter =3D {
> +		.opts =3D opts,
> +	};
>  	const struct bpf_diag_log *log;
>  	bool printed =3D false;
> +	int start_idx;
>  	u32 i;
> =20
>  	bpf_diag_report_section(env, "Causal path");
> @@ -810,8 +1556,12 @@ void bpf_diag_print_history(struct bpf_verifier_env=
 *env)
>  	}
>  	log =3D &env->diag->log;
> =20
> -	for (i =3D 0; i < log->cnt; i++) {
> +	bpf_diag_history_follow_reg_stack(log, &filter);
> +	start_idx =3D bpf_diag_history_start_idx(log, &filter);

This logic follows the 'reg -> spill -> fill' chain, but does not
unroll further to the origin of the 'fill', which I think is necessary
to justify the unrolling.

A broader question, the filtering logic looks a bit ad-hoc,
can it be implemented as some sort of 'find_back()' function:

  find_back(reason_mask, key=3D{...register or spi...})

And a loop driving it from the top, such that it replaces active key
while following spill/fill chain?

> +	for (i =3D start_idx; i < log->cnt; i++) {
>  		event =3D bpf_diag_history_event(log, i);
> +		if (!bpf_diag_history_event_visible(event, i, &filter))
> +			continue;
> =20
>  		switch (event->kind) {
>  		case BPF_DIAG_HISTORY_BRANCH:

[...]

> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index 4bc44be757c4..7af0a694890b 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -5,9 +5,49 @@
>  #define __BPF_DIAGNOSTICS_H
> =20
>  #include <linux/compiler_attributes.h>
> +#include <linux/cnum.h>
> +#include <linux/tnum.h>
>  #include <linux/types.h>
> =20
> +struct bpf_map;
> +struct bpf_reg_state;
>  struct bpf_verifier_env;
> +struct btf;
> +struct btf_type;
> +
> +void bpf_diag_format_btf_type(char *buf, size_t size, const struct btf *=
btf,
> +			      u32 type_id);
> +
> +struct bpf_diag_reg_snapshot {
> +	u32 type;
> +	const struct bpf_map *map_ptr;
> +	const struct btf *btf;
> +	u32 btf_id;

Let's put this after 'type' to avoid a 4-byte hole.

> +	struct tnum var_off;
> +	struct cnum64 r64;
> +};

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ca4bba163418..fedabb6bb515 100644

[...]

> @@ -3533,6 +3551,11 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>  		/* Break the relation on a narrowing spill. */
>  		if (!reg_value_fits)
>  			state->stack[spi].spilled_ptr.id =3D 0;
> +		if (bpf_is_spilled_reg(&state->stack[spi]))
> +			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
> +						   spi, BPF_DIAG_STACK_SLOT_SPILL,
> +						   &old_spill,
> +						   &state->stack[spi].spilled_ptr);

Would it be possible to assign the 'reason' variable in the different
branches of the enclosing if condition and do a single call to
bpf_diag_record_stack_slot() in the end?

>  	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
>  		   env->bpf_capable) {
>  		struct bpf_reg_state *tmp_reg =3D &env->fake_reg[0];
> @@ -3541,6 +3564,11 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>  		__mark_reg_known(tmp_reg, insn->imm);
>  		tmp_reg->type =3D SCALAR_VALUE;
>  		save_register_state(env, state, spi, tmp_reg, size);
> +		if (bpf_is_spilled_reg(&state->stack[spi]))
> +			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
> +						   spi, BPF_DIAG_STACK_SLOT_SPILL,
> +						   &old_spill,
> +						   &state->stack[spi].spilled_ptr);
>  	} else if (reg && is_spillable_regtype(reg->type)) {
>  		/* register containing pointer is being spilled into stack */
>  		if (size !=3D BPF_REG_SIZE) {
> @@ -3553,6 +3581,11 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>  			return -EINVAL;
>  		}
>  		save_register_state(env, state, spi, reg, size);
> +		if (bpf_is_spilled_reg(&state->stack[spi]))
> +			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
> +						   spi, BPF_DIAG_STACK_SLOT_SPILL,
> +						   &old_spill,
> +						   &state->stack[spi].spilled_ptr);
>  	} else {
>  		u8 type =3D STACK_MISC;
> =20
> @@ -3577,6 +3610,11 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>  		for (i =3D 0; i < size; i++)
>  			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =3D type;
>  		insn_flags =3D 0; /* not a register spill */
> +		if (old_was_spill && !bpf_is_spilled_reg(&state->stack[spi]))
> +			bpf_diag_record_stack_slot(env, insn_idx, state->frameno,
> +						   spi, BPF_DIAG_STACK_SLOT_WRITE,
> +						   &old_spill,
> +						   &state->stack[spi].spilled_ptr);
>  	}
> =20
>  	if (insn_flags)

[...]

> @@ -4077,13 +4118,25 @@ static int check_stack_arg_write(struct bpf_verif=
ier_env *env, struct bpf_func_s
>  	if (spi + 1 > subprog->max_out_stack_arg_cnt)
>  		subprog->max_out_stack_arg_cnt =3D spi + 1;
> =20
> +	arg =3D &state->stack_arg_regs[spi];
> +	if (slot_exists)
> +		old_arg =3D *arg;
> +	else
> +		bpf_mark_reg_not_init(env, &old_arg);
> +
>  	if (value_reg) {
>  		state->stack_arg_regs[spi] =3D *value_reg;
> +		bpf_diag_record_stack_arg(env, env->insn_idx, state->frameno,
> +					  spi, BPF_DIAG_STACK_ARG_WRITE,
> +					  &old_arg,
> +					  &state->stack_arg_regs[spi]);

Same question here.

>  	} else {
>  		/* BPF_ST: store immediate, treat as scalar */
> -		arg =3D &state->stack_arg_regs[spi];
>  		arg->type =3D SCALAR_VALUE;
>  		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
> +		bpf_diag_record_stack_arg(env, env->insn_idx, state->frameno,
> +					  spi, BPF_DIAG_STACK_ARG_WRITE,
> +					  &old_arg, arg);
>  	}
>  	state->no_stack_arg_load =3D true;
>  	return bpf_push_jmp_history(env, env->cur_state,
> @@ -6349,6 +6402,32 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, struct b
>  static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_=
type type,
>  			     bool allow_trust_mismatch);
> =20
> +static bool bpf_diag_stack_read_origin(struct bpf_verifier_env *env,
> +				       const struct bpf_reg_state *reg,
> +				       int off, int size,
> +				       u32 *frameno, u16 *spi)

Nit: please rename to 'is_single_slot_read' or similar.

> +{
> +	struct bpf_func_state *state;
> +	int first_slot, last_slot;
> +
> +	if (reg->type !=3D PTR_TO_STACK || !tnum_is_const(reg->var_off))
> +		return false;
> +
> +	off +=3D reg->var_off.value;
> +	if (off >=3D 0 || off + size > 0)
> +		return false;
> +
> +	first_slot =3D -off - 1;
> +	last_slot =3D -off - size;
> +	if (first_slot / BPF_REG_SIZE !=3D last_slot / BPF_REG_SIZE)
> +		return false;
> +
> +	state =3D bpf_func(env, reg);
> +	*frameno =3D state->frameno;
> +	*spi =3D first_slot / BPF_REG_SIZE;
> +	return true;
> +}
> +
>  static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn =
*insn,
>  			  bool strict_alignment_once, bool is_ldsx,
>  			  bool allow_trust_mismatch, const char *ctx)

[...]

> @@ -6385,9 +6481,32 @@ static int check_load_mem(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>  	err =3D check_mem_access(env, env->insn_idx, regs + insn->src_reg, argn=
o_from_reg(insn->src_reg), insn->off,
>  			       BPF_SIZE(insn->code), BPF_READ, insn->dst_reg,
>  			       strict_alignment_once, is_ldsx);
> +	size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> +	stack_origin =3D !err &&
> +		       bpf_diag_stack_read_origin(env, regs + insn->src_reg,
> +						  insn->off, size,
> +						  &stack_frameno, &stack_spi);
>  	err =3D err ?: save_aux_ptr_type(env, src_reg_type,
>  				       allow_trust_mismatch);
>  	err =3D err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
> +	if (!err && have_old_dst) {
> +		if (stack_origin)
> +			bpf_diag_record_reg_stack_fill(env, env->insn_idx,
> +						       state->frameno,
> +						       insn->dst_reg,
> +						       stack_frameno,
> +						       stack_spi, true,
> +						       insn->src_reg,
> +						       BPF_OP(insn->code),
> +						       &old_dst,
> +						       &regs[insn->dst_reg]);

Nit: is there a way to reduce the number of parameters passed to these
     event constructors? E.g. stack_frameno and stack_spi can be inferred
     from the source register, src/dst/opcode registers from insn_idx.

> +		else
> +			bpf_diag_record_reg_mod(env, env->insn_idx,
> +						state->frameno, insn->dst_reg,
> +						true, insn->src_reg,
> +						BPF_OP(insn->code), &old_dst,
> +						&regs[insn->dst_reg]);
> +	}
> =20
>  	return err;
>  }
> @@ -8867,6 +8986,34 @@ static int check_func_proto(const struct bpf_func_=
proto *fn, struct bpf_call_arg
>  	       check_btf_id_ok(fn) ? 0 : -EINVAL;
>  }
> =20
> +static int bpf_diag_stack_arg_slot(const struct bpf_func_state *state,
> +				   const struct bpf_reg_state *reg)
> +{
> +	unsigned long start, end, addr;
> +
> +	if (!state->stack_arg_regs)
> +		return -1;
> +
> +	addr =3D (unsigned long)reg;
> +	start =3D (unsigned long)state->stack_arg_regs;
> +	end =3D (unsigned long)(state->stack_arg_regs + state->out_stack_arg_cn=
t);
> +	if (addr < start || addr >=3D end)
> +		return -1;
> +	return reg - state->stack_arg_regs;
> +}
> +
> +static int bpf_diag_func_regno(const struct bpf_func_state *state,
> +			       const struct bpf_reg_state *reg)
> +{
> +	unsigned long start =3D (unsigned long)state->regs;
> +	unsigned long end =3D (unsigned long)(state->regs + MAX_BPF_REG);
> +	unsigned long addr =3D (unsigned long)reg;
> +
> +	if (addr < start || addr >=3D end)
> +		return -1;
> +	return reg - state->regs;
> +}
> +
>  /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
>   * are now invalid, so turn them into unknown SCALAR_VALUE.
>   *
> @@ -8875,12 +9022,38 @@ static int check_func_proto(const struct bpf_func=
_proto *fn, struct bpf_call_arg
>   */
>  static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
>  {
> +	struct bpf_stack_state *stack;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> =20
> -	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
> -		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg))
> +	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack,
> +					1 << STACK_SPILL, ({
> +		if (reg_is_pkt_pointer_any(reg) || reg_is_dynptr_slice_pkt(reg)) {
> +			struct bpf_reg_state old_reg =3D *reg;
> +			int regno =3D bpf_diag_func_regno(state, reg);
> +			int slot =3D bpf_diag_stack_arg_slot(state, reg);
> +			int spi =3D bpf_diag_stack_slot(state, stack);
> +
>  			mark_reg_invalid(env, reg);
> +			if (regno >=3D 0)
> +				bpf_diag_record_reg_invalidate(env,
> +							       env->insn_idx,
> +							       state->frameno,
> +							       regno,
> +							       BPF_DIAG_REG_MOD_PKT_DATA_CHANGE,
> +							       &old_reg, reg);
> +			if (slot >=3D 0)
> +				bpf_diag_record_stack_arg(env, env->insn_idx,
> +							  state->frameno,
> +							  slot,
> +							  BPF_DIAG_STACK_ARG_PKT_DATA_CHANGE,
> +							  &old_reg, reg);
> +			if (spi >=3D 0)
> +				bpf_diag_record_stack_slot(env, env->insn_idx,
> +							   state->frameno, spi,
> +							   BPF_DIAG_STACK_SLOT_PKT_DATA_CHANGE,
> +							   &old_reg, reg);

Would it be possible to avoid cross-product between modified entity
kind and modification reason? E.g.:

    -enum bpf_diag_reg_mod_reason {
    -       BPF_DIAG_REG_MOD_WRITE,
    -       BPF_DIAG_REG_MOD_REF_RELEASE,
    -       BPF_DIAG_REG_MOD_PKT_DATA_CHANGE,
    -       BPF_DIAG_REG_MOD_NON_OWN_REF,
    -};
    -enum bpf_diag_stack_arg_reason { ... WRITE, REF_RELEASE, PKT_DATA_CHAN=
GE, NON_OWN_REF };
    -enum bpf_diag_stack_slot_reason { ... SPILL, WRITE, REF_RELEASE, PKT_D=
ATA_CHANGE, NON_OWN_REF };
    +enum bpf_diag_mod_reason {
    +       BPF_DIAG_MOD_WRITE,
    +       BPF_DIAG_MOD_SPILL,            /* only with kind =3D=3D STACK_S=
LOT */
    +       BPF_DIAG_MOD_REF_RELEASE,
    +       BPF_DIAG_MOD_PKT_DATA_CHANGE,
    +       BPF_DIAG_MOD_NON_OWN_REF,
    +};
   =20
    +struct bpf_diag_mod_target {
    +       u8  kind;                      /* enum bpf_diag_history_kind */
    +       u32 frameno;
    +       union { u8 regno; u8 stack_arg; u8 spi; };
    +};
    +void bpf_diag_record_mod(env, insn_idx, const struct bpf_diag_mod_targ=
et *t,
    +                        enum bpf_diag_mod_reason reason, old_reg, new_=
reg);
   =20
    -       if (regno >=3D 0)
    -               bpf_diag_record_reg_invalidate(env, env->insn_idx, stat=
e->frameno,
    -                                              regno, BPF_DIAG_REG_MOD_=
PKT_DATA_CHANGE, ...);
    -       if (slot >=3D 0)
    -               bpf_diag_record_stack_arg(env, env->insn_idx, state->fr=
ameno,
    -                                         slot, BPF_DIAG_STACK_ARG_PKT_=
DATA_CHANGE, ...);
    -       if (spi >=3D 0)
    -               bpf_diag_record_stack_slot(env, env->insn_idx, state->f=
rameno,
    -                                          spi, BPF_DIAG_STACK_SLOT_PKT=
_DATA_CHANGE, ...);
    +       if (resolve_mod_target(state, reg, stack, &t))
    +               bpf_diag_record_mod(env, env->insn_idx, &t,
    +                                   BPF_DIAG_MOD_PKT_DATA_CHANGE, &old_=
reg, reg);

?

> +		}
>  	}));
>  }
> =20

[...]
