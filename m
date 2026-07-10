Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC4126C03
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643481; cv=none; b=q/qQbl60b54eEky6FmVzBkweAgmT1EMMzWhXuhtBoUliaZosYFky/Yxasd73xBePVFViE7QqRkyy8N2Aqzhiu3eYLIk8Svw3AVHFyxxZIBXQc9er0CRkt4PXHOImDdLMc0KmJf/m1bfw/xcYsTnxFN1FS0zgIpeU7DplgEhOmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643481; c=relaxed/simple;
	bh=jMJ2ELIgtWS8IOOgQ/oCMeQwPCwi6/l43PUSjy6HoaU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Forq4EMKi7MlgJfPE3/MPS2Zeir6Qff+W9C9lUBnsCUuyC3PzB2XK1kAIZQY/8pkLV+k2FO2qqPqzzNBfI6GrW78d41niIYz8qKfmQz6Fr86k2N9L0ijh1gSxKG4NdAGktrQMtMZrv1Aj8zJGzNBW+Srg2YorlbetytayMTmAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvMzRI/d; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvMzRI/d"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so20283435ad.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783643479; x=1784248279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iNu2k8M3OztEU8aj6m9pY1/qek/HLrp+D5PrZxFxqhc=;
        b=lvMzRI/dNIOF2or7OkHDW0s1w0hbqie9kJLkQzahzNW49h+6+iCBCDcl8Hxboi6Cuj
         aFnU48JIqEK0WrBh66B1ffiip/6kR+plzzejjrRB1+6CgK+XCi5B5ZOCvPFEdkTLD/S2
         R+QDf0rWqb3V92EoFc4xFAd+TKmFtKk5epMBW+NgMkMeUHOWkvHX4EIS5/fHUefDJASS
         +WnE5jRqKXqZPrxGzcviaZcpX60yh8UHXhIGlupXio2PsE4RR2xmQcuVC1KRaFz8Cq8r
         VFIAqfiaMduEA3F3EbWvQWZnmzKIE5H1fL4S8p1J5mWIfRCyaKT5Ee6b36t4EmhK5P3g
         jNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643479; x=1784248279;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iNu2k8M3OztEU8aj6m9pY1/qek/HLrp+D5PrZxFxqhc=;
        b=KI3n5v4XlyM0jsLbra8lna6An04+GhEmyNdy/gfBZxwePTwyXy/YZ4Stv1ON0q1SYo
         jQAf/KshgPr51YstqSkPsHnbrpb5RF9szjTfEWNWPMa0hpEcZMyw0F0fRb0aXtVQfUaE
         Wq2ML7R3vz1ZeA3ms8KNv/wluXU/t1m4B69IXebmN4X1Up4YGcDn0d+e5TXG0RPGxhG4
         0k7JlEYWpTfrt+9VzjPyGv6NokWA6ot/ofxqgJkTxKF62R9s5R6uSgV5nhyBQ+XcXZjv
         Tn510INaVDnfBp7npl4r35TCg9ReFX3AlLm3dIKGPcr3zBgmxGleiuIyvTDIwRPwgAbA
         gmtw==
X-Forwarded-Encrypted: i=1; AHgh+RrEG3Q9UET3Y1gLhRa20K3oZi5gOvuJ0ijdJSq8hy6dkzRrmZ1jv1sNmmAMQSRFTztw2tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjw79llpsgYG0zze4jpIPkpszrNjZblTFLgPro9UhvszlWpykN
	Y24ReA7ApdHPdj1j+V4mxtmC++vFaRE+HHrNi0LA9MKRHC1QC4qlMg0M
X-Gm-Gg: AfdE7cmY8+pjhGstuJjJn6I5OVzsfNbT3XK1fWy6BolDNYfvZz70RXd/i28MC1lRivJ
	Y+8PKbVxetIIiGYbYkRFfV67phmvOo2GblPuW9BHlCyZ6H9t4RcDzi0JD7pREjdp8giyFz7i5fE
	2yyjiFapvsesGTLCuspTKddflSg5bwdxYrZ28gRrKeh6riRZ1aHN+0oe61giZ+hofhDeoO8OuKS
	F+eXfhH50OrZvk68mPjGNF9SjCeaCSqctDhDEmKXJXsmchg4lKAmJ6Oe6bibY/0fVDIesYH8aGq
	pa8vWI5c199aQ2LPrjwf6ee0X/J7Bs7U/6UCTLCauQzrLGEa+gkBA1sEw+7l6DggqJsZK5v5vwP
	FW215INbLSjJu1v0ixQsrzTD8rFd5Rj89p5fHa0wtIitxDxs7mMmJGuzQNfonNP8s7h1O1iyh4O
	UWpAiZIowsKFyE9zoBxqZvnUX5AB9HN5BZJG9olFym
X-Received: by 2002:a17:90b:3b92:b0:36b:769c:c037 with SMTP id 98e67ed59e1d1-38d18ff7096mr1040022a91.5.1783643478571;
        Thu, 09 Jul 2026 17:31:18 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a52238e12sm1936118a91.0.2026.07.09.17.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:31:18 -0700 (PDT)
Message-ID: <3f321b452fb19417ac317da7e8e55cb26b9488ef.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/12] bpf: Track R2 of register-pair returns
 in precision backtracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 17:31:15 -0700
In-Reply-To: <20260708201000.2157684-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201000.2157684-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
> A function returning a value larger than 8 bytes (a struct/union, or an
> __int128) uses R2 as a second return register alongside R0. Previous
> precision backtracking only treated R0 as a return register at a
> call/return boundary, so marking the second half of such a return precise
> would trip the "unexpected regs" checks in backtrack_insn() and reject a
> valid program with -EFAULT.
>=20
> Handle R2 like R0 in the three boundaries where a call defines the return
> registers:
>=20
> =C2=A0- static subprog exit (BPF_EXIT): R2 is a return register, not a le=
ftover
> =C2=A0=C2=A0 argument; clear it before the args check and propagate its p=
recision
> =C2=A0=C2=A0 into the callee.
> =C2=A0- global subprog call: a global subprog returning >8 bytes also set=
s R2;
> =C2=A0=C2=A0 clear it before the args check.
> =C2=A0- kfunc call (BPF_CALL): a kfunc returning >8 bytes (model ret_size=
 > 8)
> =C2=A0=C2=A0 also sets R2; clear it like R0.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 2e4ae0ef0860..c46c2778bf60 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@ -424,6 +424,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
> =C2=A0				 */
> =C2=A0				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
> =C2=A0						"extra insn from subprog");
> +				if (bpf_ret_reg_pair(env, subprog))
> +					bt_clear_reg(bt, BPF_REG_2);

Nit: please move this a few lines below, so that r0 and r2 are handled near=
by.

> =C2=A0				/* r1-r5 are invalidated after subprog call,
> =C2=A0				 * so for global func call it shouldn't be set
> =C2=A0				 * anymore
> @@ -507,6 +509,12 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
> =C2=A0				return -ENOTSUPP;
> =C2=A0			/* regular helper call sets R0 */
> =C2=A0			bt_clear_reg(bt, BPF_REG_0);
> +			/* On error the return is negative, R2 stays set, and the
> +			 * check below catches it as an unexpected register.
> +			 */

Nit: I don't understand the above comment (the code is fine). Maybe drop it=
 altogether?

> +			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +			=C2=A0=C2=A0=C2=A0 bpf_get_kfunc_ret_size(env->prog, insn->imm, insn-=
>off) > 8)
> +				bt_clear_reg(bt, BPF_REG_2);
> =C2=A0			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> =C2=A0				/* if backtracking was looking for registers R1-R5
> =C2=A0				 * they should have been found already.
> @@ -521,7 +529,25 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
> =C2=A0					return -EFAULT;
> =C2=A0			}
> =C2=A0		} else if (opcode =3D=3D BPF_EXIT) {
> -			bool r0_precise;
> +			bool r0_precise, r2_precise =3D false;
> +
> +			/* A subprog returning a value larger than 8 bytes (a
> +			 * struct/union or an __int128) uses R2 as a second
> +			 * return register alongside R0. When exiting such a
> +			 * subprog, R2 is a return register rather than a
> +			 * leftover argument, so handle it like R0 below.
> +			 */

Nit: the comment is too verbose.

> +			if (subseq_idx - 1 >=3D 0 &&
> +			=C2=A0=C2=A0=C2=A0 bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]=
)) {
> +				int call_idx =3D subseq_idx - 1;
> +				int tgt =3D call_idx + env->prog->insnsi[call_idx].imm + 1;
> +				int subprog =3D bpf_find_subprog(env, tgt);
> +
> +				if (subprog >=3D 0 &&
> +				=C2=A0=C2=A0=C2=A0 bpf_ret_reg_pair(env, subprog) &&
> +				=C2=A0=C2=A0=C2=A0 bt_is_reg_set(bt, BPF_REG_2))
> +					r2_precise =3D true;
> +			}
> =C2=A0
> =C2=A0			/* Backtracking to a nested function call, 'idx' is a part of
> =C2=A0			 * the inner frame 'subseq_idx' is a part of the outer frame.

[...]
