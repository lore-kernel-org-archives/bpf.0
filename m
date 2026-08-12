Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACC388E4D
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569382; cv=none; b=eT5ZnelDqBWzKGkxZ/CvnfegrrxZTZyeOxzugX8aKAbo+r7VJIe6V/MxosiVxixuqwcmFGMpm38ZJndZLBD+r7NmjADrivQOCGfQbGk2NCMg+LPt0j2ddE+1EVLitTBnmuUZO/RkNwQIZbwTmBpdo8BOqZCg0bdAq1v4AJ15fxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569382; c=relaxed/simple;
	bh=+iP89Ru77srU8zGS6ukoLla/uMXYHFAQCtQHOqmV468=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QI3/fnZFuTiHkhRQwQ8Dgvo0n6jel63Am3tjouY44odT3bCZMgVTnn1xtOkrZXijPjb9qsq9qay2WOkJ/YXl8B9Z97MB7UKDRmLnxdmwU3l/Z5aJStwQ3C/hjB3oFLb1dD93YdnGRnw7G3MV1+IdXEvjRueVXeDQ2VCJgsAvIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOmwk16H; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOmwk16H"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc73e322dbso1045025ad.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786569380; x=1787174180; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=waPavddOxs4ONK4hJG43C6PjtafrQg1J5yve0ys5Dvs=;
        b=kOmwk16HEA9bE5pXom20Y0bSAknNthzTNU2WzKL9hPKq24ylOA/8vq2gMqlrqPSGmk
         CUgE38ICC7jJAa10GxADRA/jscajfHyL3OCE8HNRN1/WZ9Iu9+XuuzN7eGncOdvAd4JA
         zEYM5IdoQL/vAaSMTebwVgEn4XHkTowjCbk7AaPsoAgIsyEv3IOIsMctkWt6oM5DY3+x
         jhhvrT26SR+wyzm8DcpOmAhWPmjhzcOcU8hCk0hkc13Rrn3ttUbARnaMCR+9MUzs8li1
         4FDJCXZWyGgQ041JNDXl/yki6nHq+yZmMhy/hvZjaGO6Fb6dHGhcEG1s6JdD0fUptPSO
         OR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786569380; x=1787174180;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=waPavddOxs4ONK4hJG43C6PjtafrQg1J5yve0ys5Dvs=;
        b=Ula162GqnKt3htSl92sZtTQwlvyrJglqqamrpD/QoEGsCGB5Aezikxd7sJJ/4vLza2
         AnXeX6pr+CNBGLnyFZvDtxkFrMOX6UK9qNYZcM79lmjTskJBeVolSzcvOhbn90oNCN9g
         ojFcrPxpqlGysQjrZ3wyS5iqmcrwK8UhA99bhg2NPvqfOKFodmRhjQ2Vx4NQrrlFvLhL
         IxPGvkyhPOAz8ziFzRv3XPA14yIDJdaPBT6NQF4ZcWYmOao625Dr45zd7KggZgX569WS
         CR5wWudJV+0X/A9ejq5xai9T+LMtpnsMHCOolGgG0pvDeGHWhOVbOrUz9mos0WG14x+I
         X2Sw==
X-Forwarded-Encrypted: i=1; AHgh+RoNW5OM3UUJERSMUA7npzoPupc4aD+Rkk/ay/yr93pvgGuw7s5ek9EDMNkHZP6WdTdwdFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Wz/zOViJ/Zix6I9wlZ/aSFSHkuNJnFA0MC866yDsWAZy8sXp
	JqtlGSNU9YxeiYA2B9Zafh7L8UFyDl6/JQoES6SjYM7fz20suK0b8Lj+upiLLW7u
X-Gm-Gg: AR+sD12xWfvK83rqyh2MOQRv6l9pdhT7i7cTS4wITBMcV1dswQBph/qAGjoHEQawWpK
	4g2PVYXl8Jx7N5OUsY1vZwCEmml9OlONq6xhQX7Ic5aCf09Qp5DBoEKMG149TD6vdN4Ix9NJv9s
	n8uJPAldJLf82ut0SkhbInuElae/WLR2nKWScaOW+sQIpu6hXWWfYbr1HMDFP6XeNm0IGd0ovoY
	0Z+AeglojVnlq1D7a00BxrBR3YqVd1oXzPom/G3MCxMBduePwb1aIc950BcOmBJS2cjRoL7qHt6
	ktdPMI/Ob3yOWR6KOtgbq/Y3YbeTBHgnwBMZmFTAROG3vwplWxu3K3M/DxaGWz4HbKIajoAKpEk
	7cSyB6Uy6lpzisrTCxZ4cKggIUMcRIr2S773+0hyGV+faDEUzufCHc1PWGuP7RVHfHDjmk+Z8Mc
	01sBfN1/+Ut8xHaqiqtIAMFGtGew5XC+76Gc5ZxRX3MzZtodxTqB755cUQzwWneiMvTZNAwmcOI
	+kz2bm834N+fbaRWkZoj9b77cY=
X-Received: by 2002:a17:902:ea0b:b0:2ca:e3f:6a4a with SMTP id d9443c01a7336-2d37e9ae53fmr9963005ad.21.1786569379648;
        Wed, 12 Aug 2026 14:16:19 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c40d73bsm1522795ad.42.2026.08.12.14.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:16:19 -0700 (PDT)
Message-ID: <6e48cbadf7fb90cce2da403266e4a962928b7c88.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Track R2 of register-pair
 returns in precision backtracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 14:16:16 -0700
In-Reply-To: <20260811000932.2381351-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000932.2381351-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:

...

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 79680f3b4c74..911d57ce2488 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1447,6 +1447,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
> =C2=A0struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env=
, u32 idx);
> =C2=A0void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
> =C2=A0bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int =
subprog);
> +int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id,
> +			=C2=A0=C2=A0 u16 btf_fd_idx, u8 *ret_size);
> =C2=A0
> =C2=A0int bpf_find_subprog(struct bpf_verifier_env *env, int off);
> =C2=A0bool bpf_is_throw_kfunc(struct bpf_insn *insn);
> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index 40bd04421a99..fc8ecad6f01b 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@ -425,6 +425,15 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
> =C2=A0				 */
> =C2=A0				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
> =C2=A0						"extra insn from subprog");
> +				/*
> +				 * a global subprog returning more than 8 bytes
> +				 * sets R2 as well. R2 is part of the args mask
> +				 * checked just below, so it has to be cleared
> +				 * here rather than next to R0.
> +				 */
> +				if (bt_is_reg_set(bt, BPF_REG_2) &&
> +				=C2=A0=C2=A0=C2=A0 bpf_ret_reg_pair(env, subprog))
> +					bt_clear_reg(bt, BPF_REG_2);

Nit: Tbh, I don't see a need in the bpf_ret_reg_pair() check.
     I'd call bt_clear_reg(r2) unconditionally.
     Don't find verifier_bug() justification all that compelling.

> =C2=A0				/* r1-r5 are invalidated after subprog call,
> =C2=A0				 * so for global func call it shouldn't be set
> =C2=A0				 * anymore
> @@ -508,6 +517,19 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
> =C2=A0				return -ENOTSUPP;
> =C2=A0			/* regular helper call sets R0 */
> =C2=A0			bt_clear_reg(bt, BPF_REG_0);
> +			/* a kfunc returning more than 8 bytes also sets R2 */
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +			=C2=A0=C2=A0=C2=A0 bt_is_reg_set(bt, BPF_REG_2)) {
> +				u8 ret_size;
> +				int err;
> +
> +				err =3D bpf_get_kfunc_ret_size(env->prog, insn->imm, insn->off,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 &ret_size);
> +				if (verifier_bug_if(err, env, "no kfunc desc for insn %d", idx))
> +					return -EFAULT;
> +				if (ret_size > 8)
> +					bt_clear_reg(bt, BPF_REG_2);
> +			}

And same here, too much code for bug detection that fired once or
twice in my memory.

> =C2=A0			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> =C2=A0				/* if backtracking was looking for registers R1-R5
> =C2=A0				 * they should have been found already.
> @@ -522,7 +544,30 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
> =C2=A0					return -EFAULT;
> =C2=A0			}
> =C2=A0		} else if (opcode =3D=3D BPF_EXIT) {
> -			bool r0_precise;
> +			bool from_subprog_call, r0_precise, r2_precise =3D false;
> +
> +			/*
> +			 * BPF_EXIT in subprog or callback always returns
> +			 * right after the call instruction, so by checking
> +			 * whether the instruction at subseq_idx-1 is subprog
> +			 * call or not we can distinguish actual exit from
> +			 * *subprog* from exit from *callback*. In the former
> +			 * case, we need to propagate the precision of the
> +			 * return registers, if necessary. In the latter we
> +			 * never do that.
> +			 */
> +			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
> +					=C2=A0=C2=A0=C2=A0 bpf_pseudo_call(&env->prog->insnsi[subseq_idx - =
1]);
> +			if (from_subprog_call && bt_is_reg_set(bt, BPF_REG_2)) {
> +				struct bpf_subprog_info *callee;
> +
> +				/* 'idx' is the exit insn, so it is in the callee */
> +				callee =3D bpf_find_containing_subprog(env, idx);
> +				if (verifier_bug_if(!callee, env,
> +						=C2=A0=C2=A0=C2=A0 "no subprog contains exit insn %d", idx))
> +					return -EFAULT;
> +				r2_precise =3D bpf_ret_reg_pair(env, callee - env->subprog_info);
> +			}

And here, if the verifier_bug check is ignored r0/r2 can be handled togethe=
r.

> =C2=A0
> =C2=A0			/* Backtracking to a nested function call, 'idx' is a part of
> =C2=A0			 * the inner frame 'subseq_idx' is a part of the outer frame.

...
