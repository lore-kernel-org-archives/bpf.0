Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5642C027C
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150584; cv=none; b=XSi6Qg/jU8H+mUzqeUzf1IInroo1A8AOjlhu6yx5j1IwswsvGanrIpC0xzgeNWdPRJeqIbXvTLey0V9sUIVtnOhdpdPXY/mhWHKJ0Z8zd9A+3/FpOyg2E9JngDlu72pf4rOotUSHxO+Wl4gcwzkQDLufRXKtkwug+kb1Kn59Lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150584; c=relaxed/simple;
	bh=iwLEjJtLe5is9jCjyXDKJbYfSDfIW15yc49oFHhXqR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oaTXP91zjgu7HYEmmckEpxaZ9rfkRr6CMtNXzHGjFcmvf8DGjC21BZ1Q4RdY8IkM85P3nBWZF+EKZFwAq3VGHnrFp7kWU1KCGorKsHTJjbuoHEUgJtxTEf3mQzoNOIxeb3MBl0mpFeuChSuyCaRD4pR4dPoUmI6QmTr1GRrkyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICbgSrA+; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICbgSrA+"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccf2360620so23319155ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784150583; x=1784755383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EICS3QCaB0DgCzQf+AQSlSdmJARgR2Tp0VhlJla/Xds=;
        b=ICbgSrA+5sAoPxLzTh8MUGfX8GYTaZWbz/yhMzcfpU5YGR/GIIZfx+5ORbBGY9BAEV
         9ep6YrrZ8NvgHCOIxNgEBowvLXgDdDUTmL5LNtJGUA1Om9B9WM7F3L45uV2aZsIj8imY
         mTSwZOAsEV7qzPt58T4itEGS+gmZBwJeCoXwpdi0dnIUUxeT1Jc4EI3yaXhe+umc/sS+
         zDd1FbmNoLj8NQoqy58DhSFx5LhXJktCWhf3visiR+ihWpLcpQG/gO6nXodwmGVx0ap6
         CDLjI5g/2gdknfFAEM0EhZxYAkVP/FyDJGBL/KG10EJicXIO5czEdveOqX+G2LpyLNI/
         ynWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784150583; x=1784755383;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EICS3QCaB0DgCzQf+AQSlSdmJARgR2Tp0VhlJla/Xds=;
        b=YMR8Z8we6AyAYfpLMrum9dz6eNQuCmuyJByD8i7jRlqkTow+ND/rjf+U4NLjP/ocwm
         F2ZhsDEKCq2kzv8fH3YEbtq75IPODRNxZo/1pv2Ua1qbC8K+J1sIHlSBNfhJY3M4bR5Q
         7G/HQv4Sed34EUiE+muEBm5g12rtFuXRu/oTSr4pfx9DMb79AA+YTvOMAVc7zjDRZNCO
         75wInYZs5sAdn7EqIRjx1r0VK+uSQONet0sVTUnrhoZfntmXkvNrOafKBNNiIfjMXmmA
         pFeE9n6zS77/Uzih/6nwRsUTcCPlnoifbXxrQ4lRN4cV91dHRcRJdb6keaW/+1o5QMLY
         0Nsg==
X-Forwarded-Encrypted: i=1; AHgh+RpEVstUssxus1wO5XSevOSi3iHb5BMRExdxLJj005J4Z5eDg3rTdAKEpMJbPMtJqSdT5DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EoghdjRSujcAWK5IvlNbNOTo/l9haP3UoG6Q8Bg54SQRJh2e
	WpYThwjCF91O+gZ35AN1l3OyV9S1SIafDxkC0sBgLy98A+kXHIrvObO2
X-Gm-Gg: AfdE7cnjrUNvbFGpeakTN7GB1ORorCsX6C6d9gZJeEIsVGCTn0AyjoK2DoRLYy7oI8y
	1IBLClWwUQASs2Bg3NpyZjCQ7UZ0+JHGJ5S3i0TKqaoIdh/5P8aoqocNIhszVJuU99Qpc5c+Mug
	uMovxpBGew9CL9ugjs8XjsnJpd6xFEVa/ZMdS1TRbEyaVvZGwUef2dU3j5pVBDTd6HOSDd+LPhF
	Ql+rw4PUEdpvPoay1NBy0aFbRaB3/sTMPwZtKrUkh3wZO2iMFhfFx5m9Pxz8Zv1fvsDMgiakuZe
	qAsv8uEStrXDC6WaE+tz3P7xXexXxHYXvNmlskx79j1Cep51cM1KqI8sYci5jOZGZh8XGLvq1op
	I3yqVXejMJhgSASocuFX6SHo5xmvonnFX5HM+VbQyFoJiK3vFKG4gEFqAxs/wFOr7ZzH8Z+d5RV
	xbigWcMSUNG1okjMSONFmjvb+SiHLG1g==
X-Received: by 2002:a17:903:384c:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2ce9ee112ffmr192122565ad.24.1784150582630;
        Wed, 15 Jul 2026 14:23:02 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf10158fcbsm8734695ad.31.2026.07.15.14.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:23:01 -0700 (PDT)
Message-ID: <f7655f0cc9181ea102fa9405ceba96a3ae0faa01.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/17] bpf: Add verifier diagnostic event log
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 15 Jul 2026 14:22:58 -0700
In-Reply-To: <20260713153910.2556007-4-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
	 <20260713153910.2556007-4-memxor@gmail.com>
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
> index 49106115621d..ed19220aca9a 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -36,6 +36,22 @@
> =C2=A0#define BPF_DIAG_SCRATCH_STR_LEN 256
> =C2=A0#define BPF_DIAG_TEXT_LEN 160
> =C2=A0
> +enum bpf_diag_history_kind {
> +	BPF_DIAG_HISTORY_BRANCH,
> +};
> +
> +struct bpf_diag_history_event {
> +	u32 insn_idx;
> +	u8 kind;

In the patch #5 you have this as:

	u32 insn_idx:24;
	u8 kind:8;

Let's keep it like that from the beginning.

> +	union {
> +		struct {
> +			bool cond_true;
> +		} branch;
> +	};
> +};

...

> @@ -144,6 +168,51 @@ const char *bpf_diag_scratch_printf(struct bpf_verif=
ier_env *env, unsigned int s
> =C2=A0	return buf;
> =C2=A0}
> =C2=A0
> +static void diag_write(struct bpf_verifier_env *env, const char *fmt, ..=
.)

This supersedes diag_log(), let's not add diag_log in a first place.

> +{
> +	va_list args;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	va_start(args, fmt);
> +	bpf_verifier_vlog(&env->log, fmt, args);
> +	va_end(args);
> +}

...

> @@ -619,3 +723,51 @@ void bpf_diag_report_source(struct bpf_verifier_env =
*env, u32 insn_idx, const ch
> =C2=A0out_free_msg:
> =C2=A0	kfree(msg);
> =C2=A0}
> +
> +int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, b=
ool cond_true)
> +{
> +	struct bpf_diag_history_event event =3D {
> +		.insn_idx =3D insn_idx,
> +		.kind =3D BPF_DIAG_HISTORY_BRANCH,
> +		.branch.cond_true =3D cond_true,
> +	};
> +
> +	return diag_append_history(env, &event);
> +}
> +
> +static void diag_print_history(struct bpf_verifier_env *env)
> +{
> +	const struct bpf_diag_history_event *event;
> +	const struct bpf_diag_log *log;
> +	bool printed =3D false;
> +	u32 i;
> +
> +	diag_report_section(env, "Causal path");
> +
> +	if (!env->diag) {
> +		diag_write(env, "=C2=A0 no recorded diagnostic events on this path\n")=
;
> +		return;
> +	}
> +	log =3D &env->diag->log;
> +
> +	for (i =3D 0; i < log->cnt; i++) {
             ^^^^^
As far as I understand, when the complete patch-set is applied
the start index for branch history events is zero as well.
Do we want to cap the amount of printed events by e.g. 10/50/100
or some reasonable amount?

> +		event =3D diag_history_event(log, i);
> +
> +		switch (event->kind) {
> +		case BPF_DIAG_HISTORY_BRANCH:
> +			if (printed)
> +				diag_write(env, "\n");
> +			bpf_diag_report_source(env, event->insn_idx, "branch",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "took the %s branch of this co=
nditional, goto %s",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event->branch.cond_true ? "tru=
e" : "false",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event->branch.cond_true ? "fol=
lowed" : "not followed");
> +			printed =3D true;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (!printed)
> +		diag_write(env, "=C2=A0 no retained diagnostic events on this path\n")=
;
> +}

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4f127c8db134..d0d399b879e5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16135,6 +16135,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
> =C2=A0		}
> =C2=A0		if (env->log.level & BPF_LOG_LEVEL)
> =C2=A0			print_insn_state(env, this_branch, this_branch->curframe);
> +		err =3D bpf_diag_record_branch(env, *insn_idx, true);
> +		if (err)
> +			return err;

I'd try to avoid having spreading these calls across the code-base.
How about checking prev_insn_idx and insn_idx in the do_check()
in the same block where the following happens:

		if (bpf_is_jmp_point(env, env->insn_idx)) {
			err =3D bpf_push_jmp_history(env, state, 0, 0, 0, 0);
			if (err)
				return err;
		}

?         =20

> =C2=A0		*insn_idx +=3D insn->off;
> =C2=A0		return 0;
> =C2=A0	} else if (pred =3D=3D 0) {

...

> @@ -17437,6 +17443,10 @@ static int do_check(struct bpf_verifier_env *env=
)
> =C2=A0		/* reset current history entry on each new instruction */
> =C2=A0		env->cur_hist_ent =3D NULL;
> =C2=A0
> +		err =3D bpf_diag_error(env);
> +		if (err)
> +			return err;
> +

Let's not do this and propagate errors properly instead,
would that lead to a big diff?

> =C2=A0		env->prev_insn_idx =3D prev_insn_idx;
> =C2=A0		if (env->insn_idx >=3D insn_cnt) {
> =C2=A0			verbose(env, "invalid insn idx %d insn_cnt %d\n",

...
