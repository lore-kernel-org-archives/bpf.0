Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFF1509AB
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293016; cv=none; b=ZusJjGXU0R6MI0EBf1gJl5/5EHyKeiGZ3Ydhe6sIROLuEHuEFN0TVBBHsJ0AFdRFMYXTOuRCfzZo6ZG7On9p7dUl+tiacdEO9IHNjNRoCfomcCeHJFCSl17BA6b72R9U8dmuTOh9dl2pMoS7A/dwX3LMMKRrrogEn2wt/79j0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293016; c=relaxed/simple;
	bh=3PJKQs/QyhMjgeDPJq5mMS69yO0s41UIJaukt09MZ6I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=bZ3jpyhR9jzo0lnUrbJCq3UBS3IzE4eBbhc2NBSrrxIL20RlGEoIcLecv2EVFWa5OZelfBi0IRVPTPt3KiHH2tCTpgNRpRs7vCUGTm+SJxhh6O0T2z5MuAyYFUfBaiiWkCNUFjxgaC47brFUCpI3nXXojetXzdvxF+xCiy5dJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=kTw2Mea6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="kTw2Mea6"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-841882f8f4bso3236295b3a.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780293014; x=1780897814; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkiBc5fUnbWbucj4pStEU+4MXeU/cF+jih4Bg70/rhE=;
        b=kTw2Mea6Y8pZZlYNjEX+dDx8H0be8PRp2OgyxiHhxpWAyPwVbaY3AgfjDkPzIXXT7h
         a50xl+czHNKdw+Cu9Avjf5lmIxoNLocuwoKaiYuLNiUnfrg4Kxs19VNR+n0qkL4fDc8H
         bNutdbpyKVhQquG9oSZkcdqEwYr58fxUmI1gsNAd7Nxux46reFCm1BQdwgtQfmSuhMCi
         ipOjDUTSNX4Fmi2h+2rgDCkhDZesuAeplVksFgvAUDkavr8j/f7BJZTx3Yyc0BmZN0zJ
         /sp8TPbIL5M7dmheIaNHi5Pq3Y9juxjn/yZyW2eMiH5GQbYM5qjxv88egj+ptEahq3dB
         WDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780293014; x=1780897814;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkiBc5fUnbWbucj4pStEU+4MXeU/cF+jih4Bg70/rhE=;
        b=AhbC8J7stHK3NsVEbZKhRZjWRn+jSsCo+bY084mvgQAT/n+12piDzwJAdNqCL3myv+
         POcX8rCOEKToop1FBrUnGT075BDl7A0Ef+/6CaGxq+tcwco/3qtlUFYL6Ak+buxkNtVo
         +8nz+sX/zCdi0jF5T5Muv62ucpbkEx+MN8jjtpMxRvu4EBuf7tCySpRatDSYH+lvBUgT
         8hcDulcyWnCiXnGcBilEUSr26laqRawNY/CXPF96nERNuZSIxb0+6vIoN4JkgOi/GrvV
         NSCdP3dOP0Wk43GMGkO+anSSA6Nosk0k2wi/0B39gdbuvOG23/MDhvQzC9HHW8uz2Jis
         Mcng==
X-Forwarded-Encrypted: i=1; AFNElJ+QRRb2Kc4sXad6S3P9piTx8lgK1KB8yyLBagn2bbzC3+DS5vp2UFX5bz6iC404YcK3EK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjoJc3+n3EVJdYBV5nGxPrL4H7R0u5QUwDZnbx4QbxQoc7HAh
	xHe08a7YOgi6XtmmwUK3fbghAQCqTUQUtjwOv0wmprOgbsYqMDNV0CWB0OHgpoTw1EA=
X-Gm-Gg: Acq92OFRyKS782exMl47XTxRsI9e6baN/UsY6DU7uDUZGJoPn5fzuRWGLNA4DNSuCTX
	HzluWZ8ta+Ozh8nq07+JWljynZFl7eLeKjBycZFYUFXxzknEh/6hy2XoNMy7MartHTlOYERXeLb
	UCO60p8uXR+5KS5rmM7KUYEIS8CAr9djkfsu0TZ7x1Syy2xxkiOaouq7ryoXefS5HRg+RExPwi1
	iZ2PIMkNXSK/fD2od+PosooC819dJ3Tt1Jmwb9z+U6vX+/ruQFDuXOeohx0iTl93r/sY5z3QI7Z
	Fm6Gvk5aM5TOc4CjpnHs2g/F+zD7KC6EscMZffqyeBcD1DSePKEElv2XSCRK4L6BDqoBJuaLBEa
	ZOjZAhGMY2/ac1BlZzg8WpiQNCYJZeT5DDaI5a35CAHQ0hO8A/iFWf3sF/tpZnMI8kVqw1uYSQ/
	yC7PqeYJ728Wj7PqKjolMHnLOHuu5Eha89f2Q=
X-Received: by 2002:aa7:9a86:0:b0:824:afe1:f7e3 with SMTP id d2e1a72fcca58-84225376606mr9595704b3a.15.1780293013912;
        Sun, 31 May 2026 22:50:13 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842222e2394sm7157346b3a.2.2026.05.31.22.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 01:50:12 -0400
Message-Id: <DIXH7BB4EYQ0.19OXXSU8J49EO@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC bpf-next v3 1/6] bpf: move live registers and scc
 printout to a standalone function
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-1-b3ede0588a75@gmail.com>
In-Reply-To: <20260527-better-1m-reporting-v3-1-b3ede0588a75@gmail.com>

On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> Tests for multiple analyses performed by the verifier need the
> verifier log to contain analysis results alongside the program
> disassembly. This patch moves log level 2 program dump from
> bpf_compute_live_registers() to a standalone function called from
> bpf_check(), in order to provide a common logging function for such
> analyses (and thus avoid printing program disassembly multiple times).
>
> This is a preparatory refactoring, subsequent commit extends this log
> with loop hierarchy.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/liveness.c                              | 22 +--------------
>  kernel/bpf/verifier.c                              | 31 ++++++++++++++++=
++++++
>  .../selftests/bpf/progs/verifier_live_stack.c      |  2 +-
>  3 files changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 0aadfbae0acc..16d030fdd83a 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -2209,7 +2209,7 @@ int bpf_compute_live_registers(struct bpf_verifier_=
env *env)
>  	struct bpf_insn *insns =3D env->prog->insnsi;
>  	struct insn_live_regs *state;
>  	int insn_cnt =3D env->prog->len;
> -	int err =3D 0, i, j;
> +	int err =3D 0, i;
>  	bool changed;
> =20
>  	/* Use the following algorithm:
> @@ -2270,26 +2270,6 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
>  	for (i =3D 0; i < insn_cnt; ++i)
>  		insn_aux[i].live_regs_before =3D state[i].in;
> =20
> -	if (env->log.level & BPF_LOG_LEVEL2) {
> -		verbose(env, "Live regs before insn:\n");
> -		for (i =3D 0; i < insn_cnt; ++i) {
> -			if (env->insn_aux_data[i].scc)
> -				verbose(env, "%3d ", env->insn_aux_data[i].scc);
> -			else
> -				verbose(env, "    ");
> -			verbose(env, "%3d: ", i);
> -			for (j =3D BPF_REG_0; j < BPF_REG_10; ++j)
> -				if (insn_aux[i].live_regs_before & BIT(j))
> -					verbose(env, "%d", j);
> -				else
> -					verbose(env, ".");
> -			verbose(env, " ");
> -			bpf_verbose_insn(env, &insns[i]);
> -			if (bpf_is_ldimm64(&insns[i]))
> -				i++;
> -		}
> -	}
> -
>  out:
>  	kvfree(state);
>  	return err;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd709..3d569e36128c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19619,6 +19619,34 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>  	return 0;
>  }
> =20
> +/* Various log level 2 information about the program */
> +static void log_program(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *insn_aux =3D env->insn_aux_data;
> +	struct bpf_insn *insns =3D env->prog->insnsi;
> +	u32 insn_cnt =3D env->prog->len;
> +	u32 i, j;
> +
> +	verbose(env, "Program dump (scc? insn#: live_regs_before):\n");
> +	for (i =3D 0; i < insn_cnt; ++i) {
> +		verbose_linfo(env, i, "    ; ");
> +		if (env->insn_aux_data[i].scc)
> +			verbose(env, "%3d ", env->insn_aux_data[i].scc);
> +		else
> +			verbose(env, "    ");
> +		verbose(env, "%3d: ", i);
> +		for (j =3D BPF_REG_0; j < BPF_REG_10; ++j)
> +			if (insn_aux[i].live_regs_before & BIT(j))
> +				verbose(env, "%d", j);
> +			else
> +				verbose(env, ".");
> +		verbose(env, " ");
> +		bpf_verbose_insn(env, &insns[i]);
> +		if (bpf_is_ldimm64(&insns[i]))
> +			i++;
> +	}
> +}
> +
>  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uat=
tr,
>  	      struct bpf_log_attr *attr_log)
>  {
> @@ -19771,6 +19799,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
> =20
> +	if (env->log.level & BPF_LOG_LEVEL2)
> +		log_program(env);
> +
>  	ret =3D mark_fastcall_patterns(env);
>  	if (ret < 0)
>  		goto skip_full_check;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/to=
ols/testing/selftests/bpf/progs/verifier_live_stack.c
> index 401152b2b64f..923572df4bbf 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> @@ -64,7 +64,7 @@ SEC("socket")
>  __log_level(2)
>  __msg("stack use/def subprog#0 must_write_not_same_slot (d0,cs0):")
>  __msg("6: (7b) *(u64 *)(r2 +0) =3D r0{{$}}")
> -__msg("Live regs before insn:")
> +__msg("Program dump")
>  __naked void must_write_not_same_slot(void)
>  {
>  	asm volatile (

