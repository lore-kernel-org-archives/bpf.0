Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCD1E834B
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555695; cv=pass; b=E6CZPLHScJ+hKNi5AdMEXLlkPRkB9i7XYkwi/Ug1h2weCdTaOGoxVe4f4R09Zm41HQIYq0Nceki1AzJtOQRjA3L4zQFELcCVEvM+8cqKL+zP8TB7c2xXInOtLMKWAigqKWeZ3fKvSmGOQiN6rwgbPrraKXDqnEP1Rnt8w/nRMNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555695; c=relaxed/simple;
	bh=cEmrk462oGjeu+ADXPndK8LVZiOJEDqSfM9ebCI1RUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcXyD2yzEZ5lqMsWjaOPOgXFw9crFYHhILeHzqjapj88mlvrm8imuW0t2uKqsRPlk+pcXdLXGSJg4LQPtgeKoQ+LBFeWmtjPWCXYbROZlzgS89Oh/uKAnQsiR48Rod0TzCgUVuUPQxlAxvb96nHG6lVGrJs/nc2DJM0KqpSSNjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRmK7I7C; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRmK7I7C"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49048e043e5so10083545e9.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 10:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779555692; cv=none;
        d=google.com; s=arc-20240605;
        b=gQLi2BCQR+tg22mTT8j8ViMo+hml9MS+xPAiQcYQSoXo4A6rEyGxkywM2QPF+cMqBG
         WsEgu7zTZG8i72MXtibQHk3+usn4xj6M/p7s5Ik9lgaYD+ckKs48Io6ePj3k6FGE7zHx
         H6SMV8bJ/aBqfTD5O+F5jCPmegWFvY2ZKOTUzNVwwlHcsBz3AiJuwh7PvobjfG4sCT+V
         wXyRyIjzHh3vHs0i8pqIG1TM5z3bSWHGWVIm6n/IW0YbZqjbGr+59HT1S7d/TVdW1tNA
         ZEEfgHolliYnDSJsozN1yebgxE2NcErklGUxaz8rZXdNLBsVw41wnXTV2ApBlFQ0juJa
         znVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9f5AmCFliRhUxxEAOVXzXyssTmCJ1zSC0wsG9UgnqpE=;
        fh=Gw3mdSJIJMH8iXTVOz1Fzr83AlflwdmAqIc/sRvPB8s=;
        b=FM7IdeHGT8e6t9SrPvZCcwyzc080PndxCy1b7TSDBu3n7Pla+hrRT3WgeZRqis/n7H
         L1mc6UqWv5YAtRoYCXXHydqJvpgX2L4ddhx8Q8Bg79UB0YcyJzLHgRzG7ZY5QeJzk/kC
         k744k8ShdQq1RCGM/CrHss6tZlhLsRxMrZdmc+GMxxVGRbHR/CZKe4ZKy8MtyiA35B8c
         KVBKKw+eE55IyUrHaXZZhpsLVKjFdjlMCZo+v+AS18JL6ah4nrOJ6kAvw5VdLfOhMdur
         QCAq3UfGvxIV1sxPq6VaYWvVz/p7xm+Q5vYaCnapLKyP75SVTANI6HR1Umy5w4t6Ii5p
         Si/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779555692; x=1780160492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f5AmCFliRhUxxEAOVXzXyssTmCJ1zSC0wsG9UgnqpE=;
        b=eRmK7I7Ci+1ZHCBfOE6TqXmx1WnX8k/s/25k+RvvbZSBZrGLCK2UmhERI17R+1mzhi
         yMPtfgobEMqgqGE4UkXvYgA70wHXqIoKi/VDjKGUsib8Kd+VinhYBwfAlKYfmr8HSgmc
         Ev1f2rrtsA8gs7iaxzVTko7kczgjU4jpFXQt+Ei2iRSNFS8eSm+ujoFy0lkDkWX/SdF7
         jTnCsTZbQ7B9EV6Tj2t7faEMluaSKSxCYJRr33aklE2eyo8ilfFVEZKkqbvee5oLOOqq
         8oVyUSQghUI88sm9v5Z7/m0xmpPN6/ne8BgBTbgTwZvLrbRtsB6+GgpnGpfGZ4DbB1MX
         ytNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555692; x=1780160492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9f5AmCFliRhUxxEAOVXzXyssTmCJ1zSC0wsG9UgnqpE=;
        b=iBar0WNW06foFRVFDbtd7N7fuP3pRC6QQbBmU+B2gZyruY+BvBFomwlauv1hOEqwMT
         X2Zw8/xLGRBxdtGLNGQhf89jyitVM2Xut6oNMZOF14j9xja2uAEyQTAzX/U239rEB+1y
         GUtZKKXjTDp0DV3wDHrLCVqn97Phgte3j1sq97lkW+E7yESpwnYrh6w+1HCtdmh4r/nh
         Mofv9c6Q7WU9OU1idBuYjLnJJciM6griL2Y59EHMYfjhY1kfgrI3MpxQ74eHLMPS5H/M
         fkG7xzF1Ai13T/fFev+D2QZj2nwCwlyNmMHJU53d4KoAE+mP9xzGDmXNqdGq9SRkZ7ld
         3jTA==
X-Forwarded-Encrypted: i=1; AFNElJ9P3C77lCRuC0y40C5IaVifqEu0ZCljd5jYCkInz2D/E50mII/+NuwWOSXX4Q0b0UNvFmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Exybon/xz+5YsOa658uHfQytyQiRzWkc5uuYkDFH+aWfbud6
	ApkZus2V7U/NF82LPkrSC59jBK/aopJYAWkPiqEvnx446vQq5bRZbJIYg8vJ2CrHq2OLaSh0i0V
	5QwE/07o2WK2ZUZOuQ8r45RPy7aYd9pI=
X-Gm-Gg: Acq92OEye10vJVEUfOylcuc3py3K/brUgHZdi1rmH4Mj5Dyc3ZwI5zHRujGzIjr1koX
	LV5eST6fH72VOR9HBVimDbiGDCZVgADLkqQ5/5esjyzBcnb8AqetlnwNC1ax230wGJ/DYYf83Hk
	7CrDOmmhbYsrUJlZHuM21bvn+9Bqo2TL0tetQGMJPvk9JlR1ASCcZJrEmq6Q3OsMD+FL06ccHVi
	Clw1qTUf0h977I4+/jTUjFqAp9CSx3gu+wuqt3rmN/26/C/c5/kfRRtP4iqpAbjaaoui8tErHnp
	zHF4EtdLQEzyixSrBp5U2mwxeLF4eLOUOIY0OV9nX49+75DQPvaZqTlUZLB/JRfCJyw+J6wla+F
	+184=
X-Received: by 2002:a05:600c:4ecc:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490426d4bf0mr129148105e9.18.1779555691921; Sat, 23 May 2026
 10:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <20260522023234.3778588-7-kpsingh@kernel.org>
In-Reply-To: <20260522023234.3778588-7-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 19:01:20 +0200
X-Gm-Features: AVHnY4IgpP9nB-uNXblxkUX447jJ_6u_pp-3jTyj86wvJ9EN9xcferBciMbRCrA
Message-ID: <CAADnVQ+CN1vOxaEOY_uTAXOc1wVkh9_tXR69CeEBmm4f10y=ZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/13] bpf: resolve loader-style kfunc CALLs
 against prog BTF
To: KP Singh <kpsingh@kernel.org>
Cc: LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:32=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> gen_loader-emitted signed loaders cannot bake vmlinux BTF ids into
> kfunc CALL imm at sign time. Add a new pseudo
> BPF_PSEUDO_KFUNC_CALL_PROG_BTF that gen_loader emits in src_reg, with
> imm holding the FUNC type id in the loader's own prog BTF.
>
> In add_subprog_and_kfunc, look the FUNC up by name in vmlinux BTF,
> patch imm with the resolved id, and rewrite src_reg back to
> BPF_PSEUDO_KFUNC_CALL so downstream passes see a normal kfunc CALL.
> Leave standard src_reg calls unchanged.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_verifier.h   |  6 ++++
>  include/uapi/linux/bpf.h       |  5 ++++
>  kernel/bpf/verifier.c          | 54 ++++++++++++++++++++++++++++++++--
>  tools/include/uapi/linux/bpf.h |  5 ++++
>  4 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 185b2aa43a42..396b85830996 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -959,6 +959,12 @@ static inline bool bpf_pseudo_kfunc_call(const struc=
t bpf_insn *insn)
>                insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL;
>  }
>
> +static inline bool bpf_pseudo_kfunc_call_prog_btf(const struct bpf_insn =
*insn)
> +{
> +       return insn->code =3D=3D (BPF_JMP | BPF_CALL) &&
> +              insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL_PROG_BTF;
> +}
> +
>  __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
>                                       const char *fmt, va_list args);
>  __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 552bc5d9afbd..06056e714e8e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1382,6 +1382,11 @@ enum {
>   * bpf_call->imm =3D=3D btf_id of a BTF_KIND_FUNC in the running kernel
>   */
>  #define BPF_PSEUDO_KFUNC_CALL  2
> +/* when bpf_call->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL_PROG_BTF,
> + * bpf_call->imm =3D=3D btf_id of a BTF_KIND_FUNC in the program's
> + * prog BTF. The verifier resolves it to a vmlinux btf_id by name.
> + */
> +#define BPF_PSEUDO_KFUNC_CALL_PROG_BTF 3
>
>  enum bpf_addr_space_cast {
>         BPF_ADDR_SPACE_CAST =3D 1,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0e45cfa5b34..1b5d06b9d74a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3088,6 +3088,47 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog=
 *prog)
>         return !!prog->aux->kfunc_tab;
>  }
>
> +/*
> + * Resolve a gen_loader-emitted kfunc CALL by FUNC name in vmlinux BTF,
> + * then rewrite src_reg back to BPF_PSEUDO_KFUNC_CALL. Caller must have
> + * already filtered for BPF_PSEUDO_KFUNC_CALL_PROG_BTF.
> + */
> +static int resolve_loader_kfunc(struct bpf_verifier_env *env,
> +                               struct bpf_insn *insn, int insn_idx)
> +{
> +       struct btf *prog_btf =3D env->prog->aux->btf;
> +       const struct btf_type *t;
> +       const char *name;
> +       s32 vmlinux_id;
> +
> +       if (!prog_btf || !btf_vmlinux || insn->off) {
> +               verbose(env, "kfunc call insn %d: PROG_BTF resolution req=
uires prog BTF and insn->off =3D=3D 0\n",
> +                       insn_idx);
> +               return -EINVAL;
> +       }
> +       t =3D btf_type_by_id(prog_btf, insn->imm);
> +       if (!t || !btf_type_is_func(t)) {
> +               verbose(env, "kfunc call insn %d: imm %d is not a FUNC in=
 prog BTF\n",
> +                       insn_idx, insn->imm);
> +               return -EINVAL;
> +       }
> +       name =3D btf_name_by_offset(prog_btf, t->name_off);
> +       if (!name || !name[0]) {
> +               verbose(env, "kfunc call insn %d: prog-BTF FUNC has no na=
me\n",
> +                       insn_idx);
> +               return -EINVAL;
> +       }
> +       vmlinux_id =3D btf_find_by_name_kind(btf_vmlinux, name, BTF_KIND_=
FUNC);
> +       if (vmlinux_id < 0) {
> +               verbose(env, "kfunc call insn %d: %s not found in vmlinux=
 BTF\n",
> +                       insn_idx, name);
> +               return vmlinux_id;
> +       }
> +       insn->imm =3D vmlinux_id;
> +       insn->src_reg =3D BPF_PSEUDO_KFUNC_CALL;
> +       return 0;

Ohh. So this patch does it.
Probably worth squashing the patches then?

Also since the resolution into kernel kfunc is by name only,
it feels odd to create a fake prog BTF proto just for the name.
What is an alternative?

Also note that we were discussing allowing the replacement of kfuncs
by modules with the same name. This kfunc should be
immutable?
