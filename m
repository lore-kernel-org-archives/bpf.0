Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77683E8C5B
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073874; cv=none; b=tB/VU5TXvpVNgr2WO1nAGqmr2b9+4bDysLdQHwltx4CKuScy4HnkCBLJpCUb7RDYkF8hu/f27zT+mDLL+eB2XC5vvpEhTEBk1fpsaKnK3A2KZzeczU6gsbKRkZbtJIoYOXcgGR8QXI+OVmG3mzyhTDdAsks6dj3dI7KMXOHqVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073874; c=relaxed/simple;
	bh=84i5nfc82xyFEpRFLImnyC5Hsi7ThBgRgl75tYsocVc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kzMGRf7W5D+GV8xM+yE1lIYatUJ5/x9KCfhYqP+Mqw13pFZfQJbtsW4gUPg8gkfd6O3V8buaTBRjaiLjsZXxZ0zAHgxaZFV62L0zzuMOBI4T8sRXJL6+ZRAh5Cw5EdVJOpx7+sNReGIy9d7J/67xahO9zssdHFlV+wOj6GZB5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Zm+DZQKe; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Zm+DZQKe"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3664df32e91so15737608a91.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780073872; x=1780678672; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsMb8WE6XRZll1c2imUj/iER+mJvdvIjpDUBV8SoITg=;
        b=Zm+DZQKeNanfNXLwq0rENsNDWBmfqsPowH92YIBpyBjXDHPath1vVKQLyU6Cuj8xda
         /TKYiMguc7DrynL3dpup7q440OWpkzC3+m5yQYr8Od257kweie49I198NEmfnGnB+hKm
         b4RcmZHMyp0rl4Dgoc3odBxvIEzOtk8wDd88PEMjVtqf5iWA3fL+nk+RFpUIHrOchdbt
         osiNn6izzPMYvCX15/BV8lAemFi7vZUbu9nvrq218oOpBsUGYqMP1IgzleYs2f+Vg3jQ
         wBVpqoDmoduunOurqSWF6xoRRto11JaYJX79TpL5HUKxIgOypRVGAvJ95UOa3eoBx6Nb
         St2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073872; x=1780678672;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsMb8WE6XRZll1c2imUj/iER+mJvdvIjpDUBV8SoITg=;
        b=Vn0nrwswOqDILB+q83H5zomDuMaCfUQszr/R20ANwrn7sGghK21QSNQRp/6rlbhpd4
         az2JlJqobN0C2Ek25H2D/rrL3zBTLgdIqHVHWRdYlPppLHWPiHxrFIACsW8LGjjmvKNN
         1/0Fic6Ae8Ffe+8IH261PWc75PfWlTkH0IbIYpJWf47tEcDMuVMfFc5kLSqS1EbHB4rJ
         KfUGn4we2HtyOLabpH0uWd7bJttGM4R3oZ5kGoAyBGePPJBopheiMoJ0X2nfMuJ6tqlj
         7paDaCYfb5YStqtTJMFN7HfKVzyc11g9/bi4VM90PSQb146McaBxvS25y8lsceNCzsAl
         rOFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+coOvtW4v6IeVcRfdsc7ShO942zd0f02PYMv17jSUeY6w5pPCP9o9wHpMNwH8iPZp91E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGViwIx+pZTM10tZfLuoCiN7/UPKdKXSdJh44ZKkH4fri2MM+i
	HuGqSeZpZBbx9Ek6vo7UQSc88QeNyxl3twD/p2jIlqVMEwdL2gD5pHE1XCjvM3f5nyw=
X-Gm-Gg: Acq92OEQE27B8y8CiatUEAySUdxS9O7nGipDXLGJmmo3O9NPrPXCr4apaOOxfaYH/Vp
	Kw1Nr0AO4w3wprAFUItmzJdWJ/gwAtsoIvgBOl0rmSyYh+tI5MMZwKJVPMGCgPot2XKBoPs/3H2
	rV2trwq2EqKid8fTxg8nalFNpwIwOhmjdZf5jCDZSU4v237PfLxrSciANM9OLCXRiezXqPm0wTF
	EA336W7qC6Ks5CgxeN6oPM4P/BzN2UoyWsuBrYjbnBN1aEdVKV/Wqu04+qTGwbLl3E/dsqLCppr
	bZDJwtZWaIk7e1yYTFGTSsyYFX4B6rVgFjY+caXdwhvsQx8Xk02Zky0TX5D0QbMUy0ad9vA5Nze
	XLFcMmqkTXiEmbNucsZ1dHU8ER+U+zDCbTYJLoFRgaInkwWtONlOROkSod3nQzm7aUJOUFpDwXg
	kFR3ADvUirKc9eWxspy394z/QVEttwXznR1ew=
X-Received: by 2002:a05:6a20:9c89:b0:398:9662:110e with SMTP id adf61e73a8af0-3b427f88b6cmr64755637.8.1780073871802;
        Fri, 29 May 2026 09:57:51 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a789bsm2709958a12.4.2026.05.29.09.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 09:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 12:57:50 -0400
Message-Id: <DIVBIUT61B5D.12NSZC90AYN67@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, <zhuyifei@google.com>
Subject: Re: [PATCH bpf 1/2] bpf: fork state when comparing sign crossing
 ranges with zero
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
 <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
In-Reply-To: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>

On Fri May 29, 2026 at 4:13 AM EDT, Eduard Zingerman wrote:
> YiFei Zhu reported the verifier regression after switch to cnum based
> scalar representation. When the following sequence of instructions is
> processed:
>
>     1: ... rX setup with [negative, positive] bounds ...
>     2: if rX =3D=3D 0 goto ...
>     3: if rX > C  goto ...
>     4: ... code relying on rX being in range [1, C] ...
>
> The comparison at (2) is processed by cnum{32,64}_intersect(), which
> can't punch a hole in [negative, positive] range and over approximates
> by leaving rX range unchanged, leading to a deduction of range [0, C]
> at (4). The pre-cnum signed/unsigned ranges based representation could
> always deduct from 'rX !=3D 0' that umin bound is 1.
>
> This patch introduces a workaround: when'if rX =3D=3D/!=3D 0 goto ...' is
> processed and rX has [negative, positive] range, fork the verifier
> state and use current and forked states to split rX representation
> in negative and non-negative parts.
>
> The fork is placed before the branch is evaluated, so that the forked
> state re-enters check_cond_jmp_op() and gets mark_ptr_or_null_regs(),
> sync_linked_regs(), precision tracking processing w/o additional code
> changes.
>
> Reported-by: YiFei Zhu <zhuyifei@google.com>
> Closes: https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f10=
6e3.camel@gmail.com/T/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Minor nit below.

> ---
>  kernel/bpf/verifier.c | 71 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd709..7998e8da5e55 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15965,6 +15965,73 @@ static void sync_linked_regs(struct bpf_verifier=
_env *env, struct bpf_verifier_s
>  	}
>  }
> =20
> +/*
> + * This is a workaround for a specific pattern:
> + *
> + *   1: ... rX setup with [negative, positive] bounds ...
> + *   2: if rX =3D=3D 0 goto ...
> + *   3: if rX > C  goto ...
> + *   4: ... code relying on rX being in range [1, C] ...
> + *
> + * The comparison at (2) is processed by cnum{32,64}_intersect(),
> + * which can't punch a hole in [negative, positive] range and
> + * over approximates by leaving rX range unchanged,
> + * leading to a deduction of range [0, C] at (4).
> + *
> + * The workaround is to fork verifier state when:
> + * - 'if rX =3D=3D/!=3D 0 goto ...' is processed
> + * - rX has [negative, positive] range
> + * The current and forked states are used to split rX representation
> + * in negative and non-negative parts.
> + */
> +static int maybe_fork_cmp_with_zero(struct bpf_verifier_env *env,
> +				    struct bpf_insn *insn,
> +				    struct bpf_reg_state *src_reg,
> +				    struct bpf_reg_state *dst_reg)
> +{
> +	struct bpf_verifier_state *fork, *cur =3D env->cur_state;
> +	struct bpf_reg_state *fork_dst_reg;
> +	bool is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> +	u8 opcode =3D BPF_OP(insn->code);
> +	bool swapped =3D false;
> +	u32 fork_dst_regno;
> +
> +	if (opcode !=3D BPF_JEQ && opcode !=3D BPF_JNE)
> +		return 0;
> +
> +	if (!is_reg_const(src_reg, is_jmp32)) {
> +		swap(src_reg, dst_reg);
> +		swapped =3D true;
> +	}
> +
> +	if (!is_reg_const(src_reg, is_jmp32) || reg_const_value(src_reg, is_jmp=
32) !=3D 0)
> +		return 0;
> +
> +	bool cross_sign32 =3D is_jmp32 &&
> +		dst_reg->r32.size < S32_MAX &&
> +		cnum32_smin(dst_reg->r32) < 0 && cnum32_smax(dst_reg->r32) > 0;
> +	bool cross_sign64 =3D !is_jmp32 &&
> +		dst_reg->r64.size < S64_MAX &&
> +		cnum64_smin(dst_reg->r64) < 0 && cnum64_smax(dst_reg->r64) > 0;

Nit: Hoist the bool definitions to the beginning of the function?

> +	if (!cross_sign32 && !cross_sign64)
> +		return 0;
> +
> +	fork =3D push_stack(env, env->insn_idx, env->insn_idx, cur->speculative=
);
> +	if (!fork)
> +		return -ENOMEM;
> +
> +	fork_dst_regno =3D swapped ? insn->src_reg : insn->dst_reg;
> +	fork_dst_reg =3D &fork->frame[fork->curframe]->regs[fork_dst_regno];
> +	if (is_jmp32) {
> +		cnum32_intersect_with_srange(&dst_reg->r32, S32_MIN, -1);
> +		cnum32_intersect_with_srange(&fork_dst_reg->r32, 0, S32_MAX);
> +	} else {
> +		cnum64_intersect_with_srange(&dst_reg->r64, S64_MIN, -1);
> +		cnum64_intersect_with_srange(&fork_dst_reg->r64, 0, S64_MAX);
> +	}
> +	return 0;
> +}
> +
>  static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  			     struct bpf_insn *insn, int *insn_idx)
>  {
> @@ -16038,6 +16105,10 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  			insn_flags |=3D INSN_F_DST_REG_STACK;
>  	}
> =20
> +	err =3D maybe_fork_cmp_with_zero(env, insn, src_reg, dst_reg);
> +	if (err)
> +		return err;
> +
>  	if (insn_flags) {
>  		err =3D bpf_push_jmp_history(env, this_branch, insn_flags, 0, 0, 0);
>  		if (err)

