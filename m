Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5733B6FC
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912110; cv=none; b=pWPi0GWOdDTrBPPxQ015i6/Y0n1q8ldS9Yl37bEQn9LTTrxFV5x01zqlfuHAk7xfHQBHNrNbEy28zE+PUUai8nJW8j6xGxisH++wm/R7aIkWSYZPJyGYllKPcK5uVCmrMjoORWNywAlzx2rC/HmGFmkPWZ+KziYi+J03iTN5YM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912110; c=relaxed/simple;
	bh=xx2wE6lv4pNYr1ct9cAJOMik0D7tCWUtdLR6S3LjPPU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lJlULjaz8w3DOofei+8rMoXLSbfcw3eOiiSq94eDTgbGFeHK7dh5I4BYjbjzK8vygmfiLCxmX1lb1U9cugFQeTqB7ELF08tBoPoQn7Tp8fjOler4RgwYwZTT8zONvZu1al9wBNdxVSwlFhiTXkAlZ3hmyp7PuWdv1k/7/7IzIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJpXIzWw; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJpXIzWw"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-489f3611e0cso643268b6e.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781912108; x=1782516908; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHbbHd0V4X1Uls2UNE3oToevj+hCBMMCknCF6HsteEU=;
        b=pJpXIzWwqUzAoAzyFOR5EJSsgpsFp2AxZ7Rao+7sKU+2/5f7PCFSFtpUQDLWOlf757
         e2la3qGzuLgt0j3BG6o1X633CVbtkn7jvR9NXQ19Jq2q3fttJf7av1N9aT1ErVShkLq2
         ENMCmV5t5WQFTzlDy+hpU/cZh7cFzt8ExL4o65eBjzf+b9xkiQVJBfybfiXger4eGFCB
         iy46aEGeUKdKGZ4x4MR+wQjOiwBXs/kEGtRlnYPVMa/UFBdHHAposTHHK9DvRPdJsZis
         /NDDgOYj3GuBxr5AOgxMfIi12B0sNVxwFK4sUDSaEomcCZYRshYX6GS2pGaqN2N07R9H
         MwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781912108; x=1782516908;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHbbHd0V4X1Uls2UNE3oToevj+hCBMMCknCF6HsteEU=;
        b=Asu4bUAlgY6YnHBmIK+c2DfnxmskMHM42YG9G6a6b9gPaA8BtGw6neE1gjnkHmN2um
         s61ZWFXNQN1HOA5ljNNpD7ga4Q/hOzPR6QlYlQ1oVcwJ8SHazlH+YG1K9OZFDIV9l2Pb
         sPtKUoclzxWaCqeujzedt9RNZa9ypZMZYmAI4jfh3pX4MzAhyto0Tf3+QGfXlrh7tEoe
         IlEa8TE+18YQSJzADuEEd1Qf5IMNjCaQx+pEzIgSKG4PAQuof5BaOwTdKNndBiEKDdYQ
         LAaDDbGQLOrsiQPnyT/BMkY3vJS17LMwkZKBh+ZZLt1FGjsSSeQHvqeMrcGa/mLOvn8J
         CSkA==
X-Forwarded-Encrypted: i=1; AFNElJ8kUxr4HLMPCYKPIyWnkE4dDMrD9gX0rkCmU8YZTUtmRypu7hOQjlSbxkHzcfpeqXtUaNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOJobGlTye4+ESGrZ8+pyQCH8/5qINB8Ly1f8g5SB7YjgssFm
	O86MdIt7/4xPPdenkagIZUKG5n/HtTD+9Q8mcubyZBmTmi8JZeHMdVkC
X-Gm-Gg: AfdE7cmCE6DoyjnhpRbGlpH83zBsi1oKsFHp+xwJRX0FwHMG43wDTKVnbHmrX8f9esx
	t6wpbWx9wlmjUg7HGmcNxYoZGpwH86CYIre/Zt0cu0JGAtsC4ENg15nFist3E3pGLgkQHp8V1+/
	stURiy5sOJGjJYvjnTlznlb7IdCqVKffouafOOi+u12Nwysgs6Sy/2bPg3K4qoGUSm0tcbS/QVe
	XeE39kFINjMouV2bCB/lLVGohLc5VOLoWdMUAiFGMn/H8EbA2j8lwYKOJ03pOb8M9dbCabhKw66
	9cWNhXDrS/xqX2hWuKQsHL5CRZzMr/OKq8nXYAAlmOag9GYFrr7NnePlHwgL5/opcIqVZiKGX8l
	799zygLaWzoaz8T6PRuEu00JJ2p2DBkCpTtId6C0msKLv/QwnSKl6uajZCtr5eP7KCzO3zwgOow
	6aNYdNnxL8FaIa7+kKNweZFFKO6qwYb15S5Mwj0dfIXmD8vFz6roh89ZEvqhyG82vH3EJHt8KQD
	XeN7Fw=
X-Received: by 2002:a05:6808:1b0a:b0:489:93ff:9ea0 with SMTP id 5614622812f47-489940ef971mr3864325b6e.2.1781912108220;
        Fri, 19 Jun 2026 16:35:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0dd2bbsm343157b6e.6.2026.06.19.16.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 16:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 16:35:06 -0700
Message-Id: <DJDF4GPUK21C.1CJBD94DNCGD4@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 05/17] bpf: Track verifier register
 diagnostic events
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-6-memxor@gmail.com>
In-Reply-To: <20260619205934.1312876-6-memxor@gmail.com>

On Fri Jun 19, 2026 at 1:59 PM PDT, Kumar Kartikeya Dwivedi wrote:
> @@ -10179,6 +10403,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  	const struct bpf_func_proto *fn =3D NULL;
>  	enum bpf_return_type ret_type;
>  	enum bpf_type_flag ret_flag;
> +	struct bpf_reg_state old_r0;
>  	struct bpf_reg_state *regs;
>  	struct bpf_call_arg_meta meta;
>  	int insn_idx =3D *insn_idx_p;
> @@ -10253,6 +10478,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  		return err;
> =20
>  	regs =3D cur_regs(env);
> +	old_r0 =3D regs[BPF_REG_0];

This adds extra 120 bytes to stack.
Please use scratch reg in env.

> =20
>  	/* Mark slots with STACK_MISC in case of raw mode, stack offset
>  	 * is inferred from register state.
> @@ -10603,6 +10829,10 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  	if (err)
>  		return err;
> =20
> +	bpf_diag_record_reg_mod(env, insn_idx, env->cur_state->curframe,
> +				BPF_REG_0, false, 0, 0, &old_r0,
> +				&regs[BPF_REG_0]);
> +
>  	err =3D check_map_func_compatibility(env, meta.map.ptr, func_id);
>  	if (err)
>  		return err;
> @@ -12918,6 +13148,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  	const struct btf_type *t, *ptr_type;
>  	struct bpf_kfunc_call_arg_meta meta;
>  	struct bpf_insn_aux_data *insn_aux;
> +	struct bpf_reg_state old_r0;

same thing. Let's avoid stack increase.

>  	int err, insn_idx =3D *insn_idx_p;
>  	const struct btf_param *args;
>  	u32 i, nargs, ptr_type_id;
> @@ -13114,6 +13345,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  		}
>  	}
> =20
> +	old_r0 =3D regs[BPF_REG_0];
>  	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
>  		u32 regno =3D caller_saved[i];
> =20
> @@ -13282,6 +13514,10 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  			return err;
>  	}
> =20
> +	bpf_diag_record_reg_mod(env, insn_idx, env->cur_state->curframe,
> +				BPF_REG_0, false, 0, 0, &old_r0,
> +				&regs[BPF_REG_0]);
> +
>  	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_session_cookie])
>  		env->prog->call_session_cookie =3D true;
> =20
> @@ -14915,10 +15151,17 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>  /* check validity of 32-bit and 64-bit arithmetic operations */
>  static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *i=
nsn)
>  {
> +	struct bpf_func_state *state =3D cur_func(env);
>  	struct bpf_reg_state *regs =3D cur_regs(env);
> +	struct bpf_reg_state old_dst =3D {};

and here

>  	u8 opcode =3D BPF_OP(insn->code);
> +	bool have_old_dst;
>  	int err;
> =20
> +	have_old_dst =3D insn->dst_reg < MAX_BPF_REG;
> +	if (have_old_dst)
> +		old_dst =3D regs[insn->dst_reg];
> +

