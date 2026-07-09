Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721003C988D
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629056; cv=none; b=mlSuv+EykdR8GgvGtR64ub0wBvD0pW4vnpgvc3LaozKAMm7n/bFVbNtXwAI7MthINHPvXUEqU413J6oJfdpRAY+05NlL6Q/aeuyG9mQ2d50P2JUE6gTqfvACNdjDF40A/KXjQ1cfYjRm5zu9AZs1Ua0volm7hSf0MdOD8ySTfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629056; c=relaxed/simple;
	bh=LhRbTa1JCRaVysxcWDDO9GBESm9YgyTQnEW921oGtGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhQNBey2DuPQuifEjCUyLPRPCLtSLbK5vF2eda52ujBpA0dzbQAR1p3XcGwWqpE/Ty2Xm+fbE8r27Asi75JW6S2tL5x5/mjSfTu1solUGtGfYtm8ImxzJxQRsj7MjGZVXH7JXHv54KvP5Izvo+H5gYw69xXuhkIv3Inj/RtuE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8dRgkHD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8dRgkHD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so271772b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783629051; x=1784233851; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YFTJ3iFIEVLgVtqCtgYrenWC6k6NLMHltAnZJM5wBso=;
        b=N8dRgkHDmq+Om7aObE79NvGvxxpzrOW6jHDH+V3GUXpkUFTEYHqPPdI9wsGTZhn9HG
         uuelTZac3fNvS+wgluh0Hzoh8fu/QOx53O2SdYR1q3/sNwBzz0x5Rh+jkt/RLDVsHUXE
         QJh+zL7FSI8EjwDuRaTPdJ8SuOew6XJ0VEJPpmxeR4kh5rYGAMlOMmHlPwrHUhkT5QGt
         c+w8CXuWjVReDo8MYjSCZtzdX5/B+0yyeaLsUpbwFBRS50TQApufulnw4vbcMcxU5ZGK
         XmuuKNbP49Nu8MFQ4pJZLsnANn7qZ5gkOohs2jkNs4agZfocbxarcLG9vZlAPc+LbomJ
         9+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629051; x=1784233851;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFTJ3iFIEVLgVtqCtgYrenWC6k6NLMHltAnZJM5wBso=;
        b=Kd9mYKqxpLWnDO+9t1qKBS+LRmxr22lJ70SRxnp+ZgiOTS9DeP4mBSjjyUArCXr8AN
         qTjzk+twvHLaisJdMYkKCZbcn2cq5NWGM/RfRtq2mDZT7ogXWv+v43Xsa1NLC0HCvovT
         9j5LXOmx4XLpV7Dca2TCl4gotRgLa1uRWlaCr7NEWtKvTNx0JMLvwiBObEFDRWwFYZtq
         3yjvXbi17RVKm3I1aaHaZRsayGEoJx/BIVmZgGtQfzSUpPpWuNfRItdv8PH/2MReKFPC
         ux7+6zLT7q10uWqs9NuJLqTNDs5LMJuLHUllhU5cTxfzFrpfnH33HoUmynLf3CR9FU1j
         IiEA==
X-Forwarded-Encrypted: i=1; AHgh+RpzJlRq1wtiPB8ipV6IAZqRek6LRtcbMkq425Zsy5Ugz+BlTIu85aGLeDliMgSx9EfKNiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Bl+f25nP/1nftrE3DkS11gLIrK4lDMQzCN4pfG8k0pUR9dKB
	KPl0952O10yfdpzHEJlKuwrDHPD00HVPQlsACqwfzU5FysdI3fl9aU2j
X-Gm-Gg: AfdE7clY5ffVOqKDUCQImVDbPia8PoxuCZ/izSeFhzdhd6K8BbGcDau5XpeFAFkZxDF
	4zpKNYPBNr/ViTPHYCH3qH84KoBvON74GbAHLEX3SytuT7e0rQ5wT5NrX9d5ah3M3fbWH/hOAMB
	yOwBdtUmNThFtewCFNKKe3L+8zRwQSeHfFbdMS2h8T49o0EaZIcVqlSTPf4REV08UFtf3+gX9A1
	0WfVLwY8fTyZ6KlRQQ2UK2E2VsuUV7A3Gkd0MIbRRL5hf5pDcgkOLdzT0he3rJOUaDNhJQUh/uC
	wI0CgLzRKOQxH944BIvKQIHoHwYv3q/sT/ih7eUoYGMoxc2C7vZEgpEvYFWD4rww8sr3LAW/1R5
	P88lpkTzzy2NoPeMPz33DDWA25HGq+q/WVgOBLG+IKZoW1RV1Ks+ZICWUJC9P8ZL3FGJU2aAtiM
	bCO64RhRmxS34yjDfJc4j+Ffog2cksd7F3aNudLmU+
X-Received: by 2002:a05:6a00:181b:b0:82f:51e8:b38e with SMTP id d2e1a72fcca58-8487071880bmr494070b3a.24.1783629050841;
        Thu, 09 Jul 2026 13:30:50 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848429d65fasm3261759b3a.51.2026.07.09.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:30:50 -0700 (PDT)
Message-ID: <d4ec45ab714f14870749f5ada1afe44fea49a83c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 06/12] bpf: Force JIT for programs using the
 R0:R2 register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 13:30:47 -0700
In-Reply-To: <20260708201010.2158718-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201010.2158718-1-yonghong.song@linux.dev>
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

[...]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 73dc3ee879de..819a97d25173 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2676,7 +2676,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
> =C2=A0		goto finalize;
> =C2=A0
> =C2=A0	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	=C2=A0=C2=A0=C2=A0 bpf_prog_has_kfunc_call(fp))
> +	=C2=A0=C2=A0=C2=A0 bpf_prog_has_kfunc_call(fp) || fp->aux->ret_reg_pair=
)

This has a conflict with one of the very recent bpf-next commits.
While reading locally I fixed the conflict by removing this hunk
and adjusting bpf_ret_reg_pair_mark() as below.

> =C2=A0		jit_needed =3D true;
> =C2=A0
> =C2=A0	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fcbf532159a5..ca8b2f436c20 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -453,6 +453,15 @@ bool bpf_ret_reg_pair(struct bpf_verifier_env *env, =
int subprog)
> =C2=A0	return false;
> =C2=A0}
> =C2=A0
> +static bool bpf_ret_reg_pair_mark(struct bpf_verifier_env *env, int subp=
rog)
> +{
> +	if (!bpf_ret_reg_pair(env, subprog))
> +		return false;
> +
> +	env->prog->aux->ret_reg_pair =3D true;

Added:
	env->prog->jit_required =3D true;

> +	return true;
> +}
> +

You probably would want to do the same in v2.

[...]
