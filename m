Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238F42A80
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156309; cv=none; b=cQT0EGvqrWahW3sB29rLqa3i2bdJiywf0PjgkTynW0Rja7eTpShGLqu5ZCbw4iKj9f/WVHEGrTj055GLL8uDSMxfMx7K6ckSAZkr3h0aOeSjl9wa6deiBJqUigNXvUj9GJbiUk1ykN+US+mgjlbqRtx53zELuhyukLhEoZMmf4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156309; c=relaxed/simple;
	bh=ucJkiEjX+Usg9Z+h9MsrXwKKwEx/Gl8MkFzHKGvd51g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=euUq8zGPM7T0sm4jZj4kE7cAeiRz78ch+ZFG/OYzOWCL56UP4mMIxLgTDGBkYuCgBZ8IT/hUZAq0+uVQbV+/ePF2Qegx2mK1RvEOoOm6JUm0U3Bgav1dW6GizBCFbxxn4PEx41v+0NAaHAtpjEmqgAum1eHbb/lXtcN7vsNTpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Wb3P0p6T; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Wb3P0p6T"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c710439535so90920385a.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 17:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772156307; x=1772761107; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMY8Ubb9SS7Y3XHbQflKJFGU8HjKanmjaFhjCuSBTXs=;
        b=Wb3P0p6T3pl7BkvZd8XFUdeaOtXX0AwHNyDrTUayapXlSUZwk+npMW/GHlp67+Fg/B
         rGFa8yTUW2Yz3BtcZ3I6C6TAfQ5Dt8Iye5r7cLCTDB0UNFSrTQHuCKmD7l94JKImmgVT
         xbMktcjBkoHi8OFZpl3VKfoKYQ9k+0uVSva3H9faCu32Mu5hgHvon9nmTy2/C6uwcDl8
         Eqw35QBurveOKuj5/0yLXtSiZEDfko4QHjuEdfVnv96ftpWyOqV9w6oHlKUUh/mDVCaN
         LKYqb5WkudxPLvLU68CQTxSTBgSLt7AFm50dSS0b8WJBTOXvhtIpore+F2XI2QaVVCz6
         mMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156307; x=1772761107;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMY8Ubb9SS7Y3XHbQflKJFGU8HjKanmjaFhjCuSBTXs=;
        b=NeCjiUDaJQUdTYmgCDAGMKik1O+J16qk++xeeul2sa1EBI6lTlUs+iCilONm0N6KDk
         ARkMVcfrk+CMzoSMzpYCIjZF7Dhs5OfMjs0g8bxd0D8buSgYgoKZP7ZF7l5fWw63EOf3
         32J0XEb4/FjKHnDmhiL2Y+wjS5TgNwVE+KsM7PewbHD2R1ni2yjRx/0L5d77meV+we5t
         JWc3ohOwJe5TbASq1wkqlyRRTQyG633JV7/Gg5MOXrIm+ZZpdW1VJojK0TkYFLJRH4kA
         sYUrU64jU3oPWv5bPFrAh+DbUw0rKL0Eq3tAI4WlW/CzWw9uYtv3ZhO1IeQnXLyXtsDM
         ZLBA==
X-Forwarded-Encrypted: i=1; AJvYcCULc5iJCwZbK2e8hSnAn7jqEJK8K4qVOQbw5ta8lMO1qAJlz/u9lWrxOmffUrnhvTk/1fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Aij+F10fmZv0w09qj7+nIpbrt2sqeTmd1ju2RChk1YOUmX3T
	waGBsA4xb93F+iAopbCrzl/gUCJWx8p4Z6+LHlXcmAcFKK4/PGkIO9VbSEL+3QnC4mM=
X-Gm-Gg: ATEYQzx9z+ENuHttiCbQyeRPsPvB5Qsm07AfbJ1ljtu0+no4z9sm3ZRpL+4sA0j1cwW
	IgQOq8tZAVE7gdGoswn9xnhWigKl1L45CtBUo45cLdqD/hKKQQr6JR2gPI4WlOFAVyLUGguYeic
	Awsd4JT3WyGqzuhDkzl0TJReCeij3yRITbgqy4YKY1GPiyhQljGuMVOG+iyIEOtgoYZdGZE/1nh
	B6VTZuZhHc9Wm9N2MQ1DPfO+4Yw810EnM8MlvMCrVqxNrTRVtZX28LcFzjBc0X6H1dUOAzRnIyM
	IL1hKWeQjHSp2dn/Kjo0h+jXUgOHBr635txLd/A/bwDZjcQepg4NiJr4Ny4HvntOSG2TTTDV/CU
	MZmqy4RTlv3neYbQX4Juf9nrNCZZKxxv62h/USx3pO0hzm+J4BhA4rE3UpbJ5Qu4V+7MHf/4kG2
	8LzbIDv+VofqCA6PxQS+KagyA=
X-Received: by 2002:a05:620a:1aa9:b0:8c6:e224:d55b with SMTP id af79cd13be357-8cbc8f15d06mr129282685a.41.1772156306572;
        Thu, 26 Feb 2026 17:38:26 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f6950sm357914385a.27.2026.02.26.17.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 17:38:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 20:38:24 -0500
Message-Id: <DGPCZB864GLP.2WMKZWOWZOH2K@etsalapatis.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Relax fixed offset check for
 PTR_TO_CTX
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260227005725.1247305-1-memxor@gmail.com>
 <20260227005725.1247305-2-memxor@gmail.com>
In-Reply-To: <20260227005725.1247305-2-memxor@gmail.com>

On Thu Feb 26, 2026 at 7:57 PM EST, Kumar Kartikeya Dwivedi wrote:
> The limitation on fixed offsets stems from the fact that certain program
> types rewrite the accesses to the context structure and translate them
> to accesses to the real underlying type. Technically, in the past, we
> could have stashed the register offset in insn_aux and made rewrites
> work, but we've never needed it in the past since the offset for such
> context structures easily fit in the s16 signed instruction offset.
>
> Regardless, the consequence is that for program types where the program
> type's verifier ops doesn't supply a convert_ctx_access callback, we
> unnecessarily reject accesses with a modified ctx pointer (i.e., one
> whose offset has been shifted) in check_ptr_off_reg. Make an exception
> for such program types (like syscall, tracepoint, raw_tp, etc.).
>
> Pass in fixed_off_ok as true to __check_ptr_off_reg for such cases, and
> accumulate the register offset into insn->off passed to check_ctx_access.
> In particular, the accumulation is critical since we need to correctly
> track the max_ctx_offset which is used for bounds checking the buffer
> for syscall programs at runtime.
>
> Reported-by: Tejun Heo <tj@kernel.org>
> Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/bpf/verifier.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1153a828ce8d..63872b981dcb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7722,6 +7722,11 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>  		if (!err && value_regno >=3D 0 && (t =3D=3D BPF_READ || rdonly_mem))
>  			mark_reg_unknown(env, regs, value_regno);
>  	} else if (reg->type =3D=3D PTR_TO_CTX) {
> +		/*
> +		 * Program types that don't rewrite ctx accesses can safely
> +		 * dereference ctx pointers with fixed offsets.
> +		 */
> +		bool fixed_off_ok =3D !env->ops->convert_ctx_access;
>  		struct bpf_retval_range range;
>  		struct bpf_insn_access_aux info =3D {
>  			.reg_type =3D SCALAR_VALUE,
> @@ -7735,10 +7740,16 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
>  			return -EACCES;
>  		}
> =20
> -		err =3D check_ptr_off_reg(env, reg, regno);
> +		err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  		if (err < 0)
>  			return err;
> =20
> +		/*
> +		 * Fold the register's constant offset into the insn offset so
> +		 * that is_valid_access() sees the true effective offset.
> +		 */
> +		if (fixed_off_ok)
> +			off +=3D reg->var_off.value;
>  		err =3D check_ctx_access(env, insn_idx, off, size, t, &info);
>  		if (err)
>  			verbose_linfo(env, insn_idx, "; ");

