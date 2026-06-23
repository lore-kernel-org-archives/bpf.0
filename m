Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961D3AEF37
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249635; cv=none; b=uE5Yz81VNZS9rcNtYkJWSqYbZPfvuRFsYRq3Nn0XgVb3DAYY9tOB9zwV5F1nmVlWghxKu8SBRK9Sr+5aYKnAi+2G0Jiwp1bx+74yakKSmm9LmGe2cQ6TpuKxpy27p565xRXNfurxXjxdRRkLfYXY8xnMiSMyFN4T8WBKqJw4UM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249635; c=relaxed/simple;
	bh=heCvUk4cU6TW11kyzlttDxEAlLuvzwLEKepx1ZO1aQ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nsna/ld+vG3kZjqNiMma2g2VuRPnSIbXRt8+9Sq+HZPhQhm8F6/wji6CM9JWsZpGATf3t1/oq6XEV8Oy2tOov20MTT1nZu3kFUKxEcJBKPPqHLduactvQMva3K0Pjag2fa9OJaJ0FmVkWkRTZyMWiyE0l8FRzUweSNOwyosc1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjVVS/PS; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjVVS/PS"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bcdf8232fso619531eec.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782249633; x=1782854433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a/+S9qr7nE6bK+Cd6tfPFb7vlgszY5h4mIVFvhxbHBA=;
        b=GjVVS/PSNDhi9esajvw/ZTrZG0DFllBLlb+xLtfWFscctMLGODGp8/VBwtlxOSAPko
         DoQ14RUyWPAwLRw3M8PvHxqNZDkIbkBupR1U/WopKZpC9V2tNs3ocXzQBW0ivi44yjXR
         mJlv0QOTkovhZFEuujawmRlnE3+htoJNr6IVGSq8t1fHfKtiplWzx8W/7J+hrWl/xGG2
         jUefL4Ol7dHdcUMGLexpEklgspihn9XeiZVoxJs/su3RpfHjcv7KL1bNMkE7PzmC4N1T
         R0r2x28b6ZkPOiBUoiQUw4MTDm9hSSzIDjcc19V/nNSMzKPdmq1dFyNgtXDmbAoA04VL
         FwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782249633; x=1782854433;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/+S9qr7nE6bK+Cd6tfPFb7vlgszY5h4mIVFvhxbHBA=;
        b=kzD+ztPWdP/7GlrvPQ0i/vnn3ct+ykscTSjgb8fZIMn3S80ylZRgaQi/Hc1uVNp74k
         mMWk3RMSZDwSlRbrvyB1OJ0C8vhI55h48s+eisMhnDk8I9sq5sN8lJPE6XkMtsODlw4B
         w2e97HNWnsD3eUNpt4IpRq7MlZvWipInydFFQTEuR1J3fBkguH16lv5nRGqr619zFoNr
         lnqQph63uiots0ePqMhsb+RUBQyk/ysVi6VMAMpHoQiX9p6ztnN2MABW0Ir52cjZ1z4f
         ZLMMFL0KqHAJJiQc9zNUtWT+FTjh6xr6jPt66sV7qvgBkb0KPSMXL+aKtcKFj0sww32k
         lvSQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6M5uVfwRfLXTTjemlK2p6jO0pf2yxomDAVo0QIQ2s94pa8CJkLKiSxbEw98hBE8s/XpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKddcIqOYQY7r3EHnuPM5OmPrhw5qDL5WW4hUta5vf2IOcjeh
	OAM1O2jgdQfGMMIQiZlA1cW8o6Ns+ZJrnWlNfQu2tQ+jNCYdCl+jFyG6
X-Gm-Gg: AfdE7ck6RInKlGQ/cGJxbL3D11HK6Ls3WcoNGz0YWyvGaPsMA16y63EZmufYAmmY951
	o7ZDue6Ey7Ny6DS6D0Aap79HCaPMBrAliPdfS7DRwFQGEOyM3iNLt4WEK8HaMVe4R+P3AhXSToQ
	+mnPUN7UAv8/d0tXf6CtVTNBYALKWBd/5BnD4A7psWLV84VjNAzb0sC8cdSPniqUamk6TIkU3Fn
	3I3N4+HJPMMqRC1ia1rjYlC/zXrzChF1+y7S0brbn24IST9IS+yY0bakdJT8Xpkpzw0r3IyWYVR
	+WFqrkFGImROO00iSe+OT0YMs6QY5IeiZG4bUGHJ94XdSRz4gxnygK6UeCluKVgcMSdTYw7JRNs
	A4gL37NHfRsPtyRTCB/FMlV5gXwv3Oi7RAAoQFwm67co3PXnsCJ50G6+33LrNdREdMDaTBx1iHV
	GVfwxWknEvp4vgBtrTUprjPAYr8gfuc/EYujCHEVo3m6h5ih84U7Pa0hcDzM6rYgCtZniShVmAD
	bKb
X-Received: by 2002:a05:7300:2d15:b0:30c:52c5:6e52 with SMTP id 5a478bee46e88-30c6930b55fmr969763eec.22.1782249632833;
        Tue, 23 Jun 2026 14:20:32 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:20e3:c15b:de5e:66e6? ([2620:10d:c090:500::e22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be5c5desm18886627eec.28.2026.06.23.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 14:20:32 -0700 (PDT)
Message-ID: <58241a30cf4ca5caf71ecde235c0d1967086fbd5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/17] bpf: Add verifier diagnostic event log
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 23 Jun 2026 14:20:30 -0700
In-Reply-To: <20260619205934.1312876-4-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-4-memxor@gmail.com>
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

> Add an environment-owned diagnostic history for verifier reports. Event
> payloads keep the user-facing branch history shape, but storage lives in
> bpf_verifier_env instead of verifier states so explored states do not cop=
y
> diagnostic buffers.

Nit: the line about "do not copy ..." is an implementation detail from v1.

[...]

> @@ -162,21 +214,46 @@ void bpf_diag_free(struct bpf_verifier_env *env)
>  	if (!diag)
>  		return;
> =20
> +	kfree(diag->log.events);
>  	kfree(diag);
>  	env->diag =3D NULL;
>  }
> =20
> -static void bpf_diag_log(struct bpf_verifier_env *env, const char *fmt, =
...)
> +static const struct bpf_diag_history_event *
> +bpf_diag_history_event(const struct bpf_diag_log *log, u32 idx)
>  {
> -	va_list args;
> +	return &log->events[idx];
> +}
> =20
> -	if (!bpf_diag_enabled(env))
> +static void bpf_diag_append_history(struct bpf_verifier_env *env,
> +				    const struct bpf_diag_history_event *event)
> +{
> +	struct bpf_diag_history_event *events;
> +	struct bpf_diag_log *log;
> +	u32 cap;
> +
> +	log =3D bpf_diag_event_log(env);
> +	if (!log)
>  		return;
> =20
> -	va_start(args, fmt);
> -	bpf_verifier_vlog(&env->log, fmt, args);
> -	va_end(args);
> +	if (log->cnt < log->cap) {
> +		log->events[log->cnt++] =3D *event;
> +		return;
> +	}
> +
> +	cap =3D log->cap ? log->cap * 2 : 64;
> +	if (cap < log->cap)
> +		return;
> +
> +	events =3D krealloc_array(log->events, cap, sizeof(*events),
> +				GFP_KERNEL_ACCOUNT);

I think we should report -ENOMEM here and in callers. If the execution
gets to this point the user had requested the logging explicitly.

> +	if (!events)
> +		return;
> +	log->events =3D events;
> +	log->cap =3D cap;
> +	log->events[log->cnt++] =3D *event;
>  }
> +
>  static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env=
,
>  					    const char *first_prefix,
>  					    const char *next_prefix,
> @@ -203,7 +280,7 @@ static void bpf_diag_print_wrapped_prefixed(struct bp=
f_verifier_env *env,
>  		    last_space > 0)
>  			len =3D last_space;
> =20
> -		bpf_diag_log(env, "%s%.*s\n", prefix, len, line);
> +		bpf_diag_write(env, "%s%.*s\n", prefix, len, line);

This is probably a merge/squash/reorder artifact.
Let's pick the name and use it throughout the series.

> =20
>  		text =3D line + len;
>  		while (*text =3D=3D ' ')
> @@ -232,8 +309,8 @@ static void bpf_diag_vprint_indented(struct bpf_verif=
ier_env *env,
> =20
>  	buf =3D kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
>  	if (!buf) {
> -		bpf_diag_log(env, "%s<failed to allocate diagnostic text>\n",
> -			     BPF_DIAG_TEXT_INDENT);
> +		bpf_diag_write(env, "%s<failed to allocate diagnostic text>\n",
> +			       BPF_DIAG_TEXT_INDENT);
>  		return;
>  	}
> =20

[...]

> @@ -704,3 +782,53 @@ void bpf_diag_report_source(struct bpf_verifier_env =
*env, u32 insn_idx,
>  out_free_msg:
>  	kfree(msg);
>  }
> +
> +void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
> +			    bool cond_true)
> +{
> +	struct bpf_diag_history_event event =3D {
> +		.insn_idx =3D insn_idx,
> +		.kind =3D BPF_DIAG_HISTORY_BRANCH,
> +		.branch.cond_true =3D cond_true,
> +	};
> +
> +	bpf_diag_append_history(env, &event);
> +}
> +
> +void bpf_diag_print_history(struct bpf_verifier_env *env)
> +{
> +	const struct bpf_diag_history_event *event;
> +	const struct bpf_diag_log *log;
> +	bool printed =3D false;
> +	u32 i;
> +
> +	bpf_diag_report_section(env, "Causal path");
> +
> +	if (!env->diag) {
> +		bpf_diag_write(env, "  no recorded diagnostic events on this path\n");
> +		return;
> +	}
> +	log =3D &env->diag->log;
> +
> +	for (i =3D 0; i < log->cnt; i++) {
> +		event =3D bpf_diag_history_event(log, i);
> +
> +		switch (event->kind) {
> +		case BPF_DIAG_HISTORY_BRANCH:
> +			bpf_diag_report_source(env, event->insn_idx, "branch",
> +					       "explored as %s, goto %s",
> +					       event->branch.cond_true ? "true" :
> +					       "false",
> +					       event->branch.cond_true ? "followed" :
> +					       "not followed");

Nit: "the true branch of" / "the false branch of" ?

> +			printed =3D true;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (!printed)
> +		bpf_diag_write(env,
> +			       "  no retained diagnostic events on this path\n");
> +}
> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index 7f1380508789..4bc44be757c4 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -9,6 +9,20 @@
> =20
>  struct bpf_verifier_env;
> =20
> +struct bpf_diag_history_event {
> +	u32 insn_idx;
> +	u8 kind;

Nit: pahole report for this structure (in it's final form) shows a lot
     of holes, maybe declare this as:

       u32 insn_idx:24;
       u32 kind:8;

     for now?

> +	union {
> +		struct {
> +			bool cond_true;
> +		} branch;
> +	};
> +};
> +
> +enum bpf_diag_history_kind {
> +	BPF_DIAG_HISTORY_BRANCH,

Nit: it looks like this enum is private for diagnostics.c,
     maybe put it there and drop the BPF_DIAG_ prefix?

[...]
