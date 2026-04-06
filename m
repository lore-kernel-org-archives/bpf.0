Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5491482E8
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440944; cv=none; b=pX0AJpUy7TM0mYIzYDym4vIgQLSWg3kVbXf8kONXea01/lQzNQFiVyegvA0LngUKMel6UxldzPKmgl8wP/ObmRZ5vFLNs9XMRez8FGJ7+IW3JWXHf/zwAxIE0/oYgbgd9Tw2CaQ53tFxbJoPbktqDnY/jBCuLh82CURRWQ2nn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440944; c=relaxed/simple;
	bh=nQ0NWmXlcWZpkeu00fnydBn7yKwmab7WTA3K3s4axG8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ijc8uZrR+0NwUNePS8fdt/Snf/E8IlVV61T6nOJTjjjOZlI0EqRoxif1YnqONMp931BywLicqVrx0hzRUCbqWCdGTcDLa8RF28fKxJqcBXCOwfvwCILLWDkxQG8ikyB9RHpFhZXy9R+HAHq1D5B6NsWaLGVD/cEu1kv0FH+6IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=PCOy590R; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="PCOy590R"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c766a95a72dso2154502a12.1
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775440942; x=1776045742; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG564JlhXBk1H0EUEZIG+dFoJovZvBF45XOQaApDep0=;
        b=PCOy590RuTJ8zFFhMHhQ9m1yzqFVjHFBuGLABsTJFTymUYwIYqMryMeKXDwn32UJAL
         U6btKb7fFnb3W/FYYMOQH5i1ZvkfE7VtsxFhz6uUJo8OMWU9/3pDF6QSJctNUX97rn21
         8bkRFKvFcdyQvcU5WD60cYVCDsaVP5OYgRFxZU2E8775eXWpMW9ZgEFouWCkkJ3lNuDh
         ejL8s5U8FJozz+B22LtN6wIlZdU5gWTCc6M4uNeWauWO0QtjgzZfl8dIIeVrBI8Ju5so
         Yg0ZkqBGzB0JabEPfPo2eE0yAVwF+xCFL07TvFcwOcu797xcaZa9QOuNJcQvNLSaGY6F
         k4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775440942; x=1776045742;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QG564JlhXBk1H0EUEZIG+dFoJovZvBF45XOQaApDep0=;
        b=blt5i85cvTZ16j5HN5pluFPHpPwLgoV9GjCXirlgvpCOGhlaLyJwgTqDpk6zxelKWI
         sVTU87dPTPfOvsbaBS2w2fJ2/sjYASWENgPVEWTDmUWKJLrtpA7iNQ2w5OgFab0kzLb7
         mLnAyEJNlxI1JvwBiIDQjEcj1rE9S9Vla37U9OAcNba3cXmaU9OpPa0LXDRTN2K09LL/
         Gyjl57QKUb6TUvy6y2KeLXIb2E750qE1zc0V77cKxTm1whcf4B/uUd0Jute6lbC/UAaS
         /Yk08/jlt5zkp+oczvGkURjaftK9pgcisqwBraA3LYCKJDeZQUzEl/q/4jYavRCSLVlh
         uWLw==
X-Forwarded-Encrypted: i=1; AJvYcCX7B8aSxAnEd0XrJqLw5x9FJAgoFSFUinXNHTblp4ec1D5yxYWEsNwx56d0hHadUZOFjpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccV7GTu50BCzBZLshXPh7kMDv5kSWtFF3pt7AYYLKNgruQjDa
	PR+hWrlUX+8LgnLirGEnLdVUtQiMboeR88JDM8oaPzItOfhVMJiIMUxZic6QDR84bGQ=
X-Gm-Gg: AeBDievIVzC207d4MXLxanLGvMe2+facEvQa67FcFANImZFSN+Los4HDT5v4loBttlX
	uo+euemUKSFPvLqIwLSCf0ERiI+ibeEoSxs4edijBhacHaD27kF3RIGAnjhMb1qn/9cP/WOA7PR
	FYH9a3Hfy6Buj1tJp5DyagN9kGD4SSzc2J4A2581Fr1YeMb1LGWWEcAWZL0x3cj3NlD/p/saWqu
	OYJRoMpjhEQnOhj2vIv/+5EqD4+84VyP34+ST4itJkH2XOz0NBvhjxUFofcbUKvMvxZOdFt7HcR
	SS9zmUEtcuFD43OzIcbyUYnY1RxjhbiBYO5BEIGIFJNXxAiqUCOPzceYqikbXILDys8DeSmEh7G
	JmNFo2Phpxc1pQNE6yJ+nyrsS6Yghqdm1d7n67/A4SCblEjlCl5BZHl3dBXbna5Lw2/A3rfNZtF
	mUkGT5lyA=
X-Received: by 2002:a05:6a20:3942:b0:39f:5ef7:f0e1 with SMTP id adf61e73a8af0-39f5ef7f674mr5314000637.57.1775440941944;
        Sun, 05 Apr 2026 19:02:21 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659bedesm10420988a12.30.2026.04.05.19.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 19:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 22:02:20 -0400
Message-Id: <DHLPAC9YAG4Z.39R1IWNUVLK74@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 7/7] selftests/bpf: Add tests for syscall
 ctx accesses beyond U16_MAX
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260401122818.2240807-1-memxor@gmail.com>
 <20260401122818.2240807-8-memxor@gmail.com>
In-Reply-To: <20260401122818.2240807-8-memxor@gmail.com>

On Wed Apr 1, 2026 at 8:28 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Ensure we reject programs that access beyond the maximum syscall ctx
> size, i.e. U16_MAX either through direct accesses or helpers/kfuncs.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/progs/verifier_ctx.c        | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/tes=
ting/selftests/bpf/progs/verifier_ctx.c
> index 887cd07ed885..7856dad3d1f3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> @@ -406,6 +406,37 @@ int syscall_ctx_unaligned_var_off_write(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: reject ctx access past U16_MAX with fixed offset=
")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_u16_max_fixed_off(void *ctx)
> +{
> +	char *p =3D ctx;
> +	volatile __u32 val;
> +
> +	p +=3D 65535;
> +	val =3D *(__u32 *)p;
> +	(void)val;
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__description("syscall: reject ctx access past U16_MAX with variable off=
set")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_u16_max_var_off(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +	volatile __u32 val;
> +
> +	off &=3D 0xffff;
> +	off +=3D 1;
> +	p +=3D off;
> +	val =3D *(__u32 *)p;
> +	(void)val;
> +	return 0;
> +}
> +
>  SEC("?syscall")
>  __description("syscall: reject negative variable offset ctx access")
>  __failure __msg("min value is negative")
> @@ -530,6 +561,56 @@ int syscall_ctx_helper_unaligned_var_off_write(void =
*ctx)
>  	return bpf_probe_read_kernel(p, 4, 0);
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: reject helper read ctx past U16_MAX with fixed o=
ffset")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_helper_u16_max_fixed_off_read(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 65535;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("?syscall")
> +__description("syscall: reject helper write ctx past U16_MAX with fixed =
offset")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_helper_u16_max_fixed_off_write(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 65535;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
> +SEC("?syscall")
> +__description("syscall: reject helper read ctx past U16_MAX with variabl=
e offset")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_helper_u16_max_var_off_read(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xffff;
> +	off +=3D 1;
> +	p +=3D off;
> +	return bpf_strncmp(p, 4, ctx_strncmp_target);
> +}
> +
> +SEC("?syscall")
> +__description("syscall: reject helper write ctx past U16_MAX with variab=
le offset")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_helper_u16_max_var_off_write(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xffff;
> +	off +=3D 1;
> +	p +=3D off;
> +	return bpf_probe_read_kernel(p, 4, 0);
> +}
> +
>  SEC("?syscall")
>  __description("syscall: helper read zero-sized ctx access")
>  __success
> @@ -599,6 +680,33 @@ int syscall_ctx_kfunc_unaligned_var_off(void *ctx)
>  	return 0;
>  }
> =20
> +SEC("?syscall")
> +__description("syscall: reject kfunc ctx access past U16_MAX with fixed =
offset")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_kfunc_u16_max_fixed_off(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 65535;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__description("syscall: reject kfunc ctx access past U16_MAX with variab=
le offset")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_kfunc_u16_max_var_off(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 0xffff;
> +	off +=3D 1;
> +	p +=3D off;
> +	bpf_kfunc_call_test_mem_len_pass1(p, 4);
> +	return 0;
> +}
> +
>  SEC("?syscall")
>  __description("syscall: kfunc access zero-sized ctx")
>  __success

