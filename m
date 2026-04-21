Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507DE3914FD
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807638; cv=pass; b=FFvRWFkD0xkZIj+Sglh8nyRvmN3A+8oturNDJTWi97pcAMJX+KRsaG81MueaGrvIAWaPVW0CFPWXmK5JIyVVAuCvrYrDHI6UIUzMuNF/iPrGEgYxH+hCCPO83mtJqZRLVghcNlnW5J/bpJ5J8JKg7XxRxEr+SMmMhMNECrZ9x/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807638; c=relaxed/simple;
	bh=xrZJOdW5O/BYwZiNIfhSGZhQzMuKRC/EMlCJgSg6yyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRCOrsW3s5NV+1YL4m8kdNGf8xn6IRtLIjQgk8twtkQl0c8xCf2s10bBcUpheffj26f8np+40r6VtAF4uilKMGipZyJCXhnFInd9g87wKNknQlWOrPa7tHrFIgJ0wxxxYK55VK9x3dh9Hg95lG1DZl7qjxBTGpxu4H02a1Sokns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDA2unuN; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDA2unuN"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bb0d18c7f9so1583607b3.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776807636; cv=none;
        d=google.com; s=arc-20240605;
        b=RJWvMINUL8E1VYZTjLNGmOShQF9lKj4iSMtBvCvPqil9JZRDCY4conLjO8S35oLw9p
         wM1CTvpyEym/nRBPvkTnLqzD+C+HJ/0/YvmXH5qjL2SNpygPtxVFbBfReAs/T10nLfuO
         Pe7DHm0U1+eYqlIcbjk1jeIO6vx/5fLIZudpXEWu0ZByxC9k4cPtdm38yKQeCpYZO6H/
         oBq5fP9f5IISHXSpFAm191tBS/xuduWWTQFIZ/d/v0kx3s+NvMmw1ofQO76GDAv8z51H
         iz8MmvsHjYK7vRoGK3byy0vaTWUG+Zmqox/qFQ77cU2pH1tCHmqAUkmKGK0aQFInXz/e
         C1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5A4FoRg32VYtJwmHdhGTXrzPOaHOptQuMjaqR66arK0=;
        fh=DqFIOc5oqPjexbjNm4x8jVGVqluf/16pB521p3iiDmQ=;
        b=UsCUE1TzTicO9X5TxBradWl8QuQFd0eqfB0UmmVj0EOrQZvsaxdQF7SgacUKr/NQZd
         J9+HnOVjFff7u17La6vTAGitsYzv9i/hovje7Jf1hKUyOWU/9z9LnZthayZPsVO2MaG/
         FBRrLFBTpknbviz7iPDR+Et3zIe3OmKr9XUU0C7nwuoNAg7SxMgybHB+8qY069eanDZc
         YAMcAd5CR5adTWBUfDq2hysk9qhumTi92S3HViy9upmpKcQoLeuld3n8RkTmJXhsUDxH
         yW4xZXzkL3Z1VTLpoNEPahziOw4aU3koYyBg7l867LNezPay6rFnB9z4n6WMsjv2taBZ
         Y5cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776807636; x=1777412436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A4FoRg32VYtJwmHdhGTXrzPOaHOptQuMjaqR66arK0=;
        b=SDA2unuNUQY5CZVQ6oQjGkSuGBTFEW15e5FuThWLUHUMDVn/kWO9kMo7DPczx4HsLc
         XDQGDvAGC8dfpelxKtL4WbvTyt6mIiQLovx4s+t7il8SMc7alCKNKA0SolI634GFjose
         tujrb5S4eXWVyp9pqSmMH5mQ8qZrz3F8hDZzYeKEzEnsddJvzp8mUjQlyKWRnD928C3y
         jFrkzpgaISYeUWYP4b3kfveso4TxH/GE6i47RVeAjzt6oIIfX3puvcyxDzRnV3PXUrov
         RwK6Kxzjoqyoo3qmZNvmyoT6czfr0vMD3uMfabWRg1VKM69qDdtzDR7LlFOY+5lLy/8w
         Lp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807636; x=1777412436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5A4FoRg32VYtJwmHdhGTXrzPOaHOptQuMjaqR66arK0=;
        b=IwDmhRNYf+6uBDGkTMkPIA72dab6Xt8TzUICrpvx3VZ12SCbD6HlknjGLMMU6Fu+Oi
         0cdGDFK1yzaHhdqVernocqEvMbR/hYcewZhw2yo3VgyOJQOBvjJLjnGKQbxO4FAzOgbI
         bFIjMB/csqKWe8SxAaenW+5wkYeRoRTNfIFLa93lrqYQmB1ynKbzxQWQA2KjayaXw43u
         fgRays8dAOgjJmjH/nz5hcSyVO9YhgxGPz6RgBzpbJhIqnMYePl5Dn10UrIZl96s/LDD
         CtnCLWfl7uyorAywhQ9QScMddA3XEnnQcox7r+oaf7yk8r4xG4tmSi7KwCLffRAVd+ru
         /dJg==
X-Gm-Message-State: AOJu0Yy/GAQC9OPJrZrWIIK+BqZVxmy7NAlhLoqauzQfvXdxSQlp2EIj
	SxXMqXA7zrB5OyHiHn7L5w3c2oA6J6TP++avUIDkms/feKghFNUW7Koam5fsepHoLX/tIBUFoDm
	0zzqOecdCplAOv5rOlylGbvEjQzcWVus=
X-Gm-Gg: AeBDievbB1v37rcf8IVc+6jnIf7uD8hNzeIfY+FzwQn3zn/1FRo+kyJcC4SWjfX5Z7G
	c0npsdlgV+XNQTLMQL0pYfgjGahR7o88onXlzShWwnGZuIlbWrvbtb4GoRNHvkQ37/sWvZ3aRyI
	2AvLEigwcVsZRLD8V6+7bQB0p0ywG8ifVqCKPNJWF1RyAE3AagJxIyrfYkbRds9vMcz11IDux9q
	XSJKGBzlt3ArHsEBfzdK04bvrD5QgjU5CXH4TGMGjcwP/biNAW2KV33m2K1PWQ73sSKiFkJNCI1
	kA7KZ3fcDYLSRYhQNKdGlRTyfUHXMh1Imxn9i24FGg==
X-Received: by 2002:a05:690c:680f:b0:79b:e1e1:9e4d with SMTP id
 00721157ae682-7b9ecfdb0c9mr216650377b3.40.1776807636217; Tue, 21 Apr 2026
 14:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421171927.3507554-1-yonghong.song@linux.dev> <20260421171947.3509118-1-yonghong.song@linux.dev>
In-Reply-To: <20260421171947.3509118-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 21 Apr 2026 14:40:23 -0700
X-Gm-Features: AQROBzA_kiMDDxj4ENau246NXSA1JXu8-sb7oXicybbnq8eD2hiG1YpZwYM7RHE
Message-ID: <CAMB2axNsVNX2hRp0wMJvSfhpryH-vEFB23ACk0x8T8hcFE7VdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] bpf: Refactor to avoid redundant calculation
 of bpf_reg_state
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:20=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> In many cases, once a bpf_reg_state is defined, it can pass to
> callee's. Otherwise, callee will need to get bpf_reg_state again
> based on regno. More importantly, this is needed for later stack
> arguments for kfuncs since the register state for stack arguments does
> not have a corresponding regno. So it makes sense to pass reg state
> for callee's.
>
> The following is the only change to avoid compilation warning:
>    static int sanitize_check_bounds(struct bpf_verifier_env *env,
>                                    const struct bpf_insn *insn,
>   -                                const struct bpf_reg_state *dst_reg)
>   +                                struct bpf_reg_state *dst_reg)
>
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 213 ++++++++++++++++++------------------------
>  1 file changed, 93 insertions(+), 120 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed04fef49f6c..b56a11fc3856 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3929,13 +3929,13 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
>  static int check_stack_write_var_off(struct bpf_verifier_env *env,
>                                      /* func where register points to */
>                                      struct bpf_func_state *state,
> -                                    int ptr_regno, int off, int size,
> +                                    struct bpf_reg_state *ptr_reg, int o=
ff, int size,
>                                      int value_regno, int insn_idx)
>  {

The comment needs to be updated.

>         struct bpf_func_state *cur; /* state of the current function */
>         int min_off, max_off;
>         int i, err;
> -       struct bpf_reg_state *ptr_reg =3D NULL, *value_reg =3D NULL;
> +       struct bpf_reg_state *value_reg =3D NULL;
>         struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
>         bool writing_zero =3D false;
>         /* set if the fact that we're writing a zero is used to let any
> @@ -3944,7 +3944,6 @@ static int check_stack_write_var_off(struct bpf_ver=
ifier_env *env,
>         bool zero_used =3D false;
>
>         cur =3D env->cur_state->frame[env->cur_state->curframe];
> -       ptr_reg =3D &cur->regs[ptr_regno];
>         min_off =3D ptr_reg->smin_value + off;
>         max_off =3D ptr_reg->smax_value + off + size;
>         if (value_regno >=3D 0)
> @@ -4241,7 +4240,7 @@ enum bpf_access_src {
>         ACCESS_HELPER =3D 2,  /* the access is performed by a helper */
>  };
>
> -static int check_stack_range_initialized(struct bpf_verifier_env *env,
> +static int check_stack_range_initialized(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg,
>                                          int regno, int off, int access_s=
ize,
>                                          bool zero_size_allowed,
>                                          enum bpf_access_type type,
> @@ -4265,18 +4264,16 @@ static struct bpf_reg_state *reg_state(struct bpf=
_verifier_env *env, int regno)
>   * offset; for a fixed offset check_stack_read_fixed_off should be used
>   * instead.
>   */

Same here

> -static int check_stack_read_var_off(struct bpf_verifier_env *env,
> +static int check_stack_read_var_off(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg,
>                                     int ptr_regno, int off, int size, int=
 dst_regno)
>  {
> -       /* The state of the source register. */
> -       struct bpf_reg_state *reg =3D reg_state(env, ptr_regno);
>         struct bpf_func_state *ptr_state =3D bpf_func(env, reg);
>         int err;
>         int min_off, max_off;
>
>         /* Note that we pass a NULL meta, so raw access will not be permi=
tted.
>          */
> -       err =3D check_stack_range_initialized(env, ptr_regno, off, size,
> +       err =3D check_stack_range_initialized(env, reg, ptr_regno, off, s=
ize,
>                                             false, BPF_READ, NULL);
>         if (err)
>                 return err;
> @@ -4298,10 +4295,9 @@ static int check_stack_read_var_off(struct bpf_ver=
ifier_env *env,
>   * can be -1, meaning that the read value is not going to a register.
>   */
>  static int check_stack_read(struct bpf_verifier_env *env,
> -                           int ptr_regno, int off, int size,
> +                           struct bpf_reg_state *reg, int ptr_regno, int=
 off, int size,
>                             int dst_regno)
>  {
> -       struct bpf_reg_state *reg =3D reg_state(env, ptr_regno);
>         struct bpf_func_state *state =3D bpf_func(env, reg);
>         int err;
>         /* Some accesses are only permitted with a static offset. */
> @@ -4337,7 +4333,7 @@ static int check_stack_read(struct bpf_verifier_env=
 *env,
>                  * than fixed offset ones. Note that dst_regno >=3D 0 on =
this
>                  * branch.
>                  */
> -               err =3D check_stack_read_var_off(env, ptr_regno, off, siz=
e,
> +               err =3D check_stack_read_var_off(env, reg, ptr_regno, off=
, size,
>                                                dst_regno);
>         }
>         return err;
> @@ -4354,10 +4350,9 @@ static int check_stack_read(struct bpf_verifier_en=
v *env,
>   * The caller must ensure that the offset falls within the maximum stack=
 size.
>   */

Ditto

>  static int check_stack_write(struct bpf_verifier_env *env,
> -                            int ptr_regno, int off, int size,
> +                            struct bpf_reg_state *reg, int off, int size=
,
>                              int value_regno, int insn_idx)
>  {
> -       struct bpf_reg_state *reg =3D reg_state(env, ptr_regno);
>         struct bpf_func_state *state =3D bpf_func(env, reg);
>         int err;
>
> @@ -4370,16 +4365,15 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
>                  * than fixed offset ones.
>                  */
>                 err =3D check_stack_write_var_off(env, state,
> -                                               ptr_regno, off, size,
> +                                               reg, off, size,
>                                                 value_regno, insn_idx);
>         }
>         return err;
>  }
>

Otherwise looks good to me.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
