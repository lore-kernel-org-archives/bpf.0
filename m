Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B913590B8
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765938; cv=none; b=gsOTG6oLNeF2dQXtOVFgee0D39JSN/EfiGIGCMmwWlZl5eJDUqeFvJ7GU5zWbAj3FBt5xMI3dXLOaMchsiggBVrv7zvgeXYMbNGkcA8MAZgFpHcQ//jVB6tLganiaH15mTMNd0E9g6U67IVSNo+CF1ekFKf54s/0KixDiJQP/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765938; c=relaxed/simple;
	bh=Mn+rexhdWhnUsPTZb3Xo/DYOjuyGfhhdanLs9XvCdzo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Mh/vPmPNgtCUhGA03AlP8Jc8ZwR86gv5BCAht8VzaZfHF9X/WZe4ha7/BebA4J+JElOfT6jCHcAXoidj6REmP+qFwVoCygK4REI0BXwNtFnRltU6TyvkRLu8I+fqkEktTmTt+gDYWh5RmsB3/R7Z0/l6+LUVQHby2GOFScTKGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Y/CZZyJM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Y/CZZyJM"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd830404c2so618660285a.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773765935; x=1774370735; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS2IfjHCIqSWql8XDYi2AtAuzBRe9xR/tGX3Mm7Lt2U=;
        b=Y/CZZyJMU2yp7Lo4iAfUGMSJeABPcX08rkhqIyzot9ePXa438Tjq4FrxXcykwPsVY2
         RjTjzubvPKbKeZ4K/2Rq5GmD8+WPHHxK65QyqXRivER/vC34kfFrZqT3jI4ucRPwdcrZ
         BOEajU/2zZaJkRJZpD9efOdxabu+YMBOvvLNird9W+H0xCemRgJUovQpQj9iDS/wDGYB
         c5GjjlaqypCGy1UyPtox++MKJKShhdF9WgJtERyEooqSmnS45J/aNCIE+2oMi0oYDi+T
         /8hvLxBtGJdCvveDJf6D2Sni0U4E8Rz1mj/CkF/qmDXdJOy1cXuSP44ahXLnczyckPAE
         W4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773765935; x=1774370735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fS2IfjHCIqSWql8XDYi2AtAuzBRe9xR/tGX3Mm7Lt2U=;
        b=LU/1095/0XEd8M283YU7kRo0X4GEgTdkEGyk8rB0/tCRp6akhXq2WnOZAsTXy/iolb
         CgBmZn/HVDOQwqFW738vBWnM8L6sZRCseHpWeLrIhFlqzRcnQDDOHWUvRGVC1Ou1RtV0
         HPYLggxmmGQX7zdel9pN75rNZTRIVEsiBmXe5GRl5PrV2NTxd2WT1ooqOQ7BOhBp/PP/
         ZAG2ay/ZRArYABrzh9fdnS/uBo051n9ULOSeV4uOgPoa6GB0lzNsL11YDHWGX5F9fzWS
         uhXzaPhUWMSOjM9k41dby5+YdRxgUOPFXLCr1VGvuzBbzdzocUWcw4CG8QIHPH+/thJa
         Kojg==
X-Forwarded-Encrypted: i=1; AJvYcCX1jatW8lD+pGRLxvDTbRzB5FPOul9bYePi8BNs9Bn73ousa4SgDnYJ05yY6iA6T3FGiWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVLN2DcIDa2WM6jWuKadsrumJXP3nsCzY3mgMeNOq7DWdmKVLQ
	qtXs2WYRFtraV3TycNAQhhBPM26VeI5uNOQZTcxpO5BZ3bQF0fndSASc617wh7/Zlug=
X-Gm-Gg: ATEYQzxqvPrxu4Eex9oiKJy5OfeO2bED1UPAxg9BxLmva0xYSAbMvh7dxZMY5EmZNx5
	ypxreNxS6q9s5WxwbInsFeS7O+ZbY4YC6fqCJEBbLiu/dx+ep3wu9ydJC7ra4DzA3cvnFJ9+Mbe
	XLzwLKtfRB8lkbqpijv5eZqcA7wqM4cCisktrGs9LarLYdrsNumGoKTk649ifKW3c/NZ6yPlUTH
	NFA+sJC11cMxMH91pIzl89x4fgLyWR+I3dgTwXd7zFzeHa0MGjfRf6kfcqFTSo4yZhblo39CJV2
	RWyThHg8QRHvWTSIt8AoWHQ1zudmH6ohm8Lu1T3zhYt2/ZQ/0qzzgvC3UwTLfzmZ0cTaGUngJEC
	iEE1SAECxzAO1Vf8JtnX2af/W1hYvnLIJNNqwFK8Ic+oAZT4pxlizE6AAvF11xnmSIN+Y5hxPyi
	R7RtzKKFfkxccsuLmArA5jJqEhy1GFz20mww==
X-Received: by 2002:a05:620a:444b:b0:8cb:5176:ee5 with SMTP id af79cd13be357-8cfad3734c6mr26519385a.62.1773765935102;
        Tue, 17 Mar 2026 09:45:35 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfacdacf9dsm20104285a.3.2026.03.17.09.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 09:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 12:45:32 -0400
Message-Id: <DH57JO6V5L54.I3CL1UF0FKAE@etsalapatis.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Support variable offsets for
 syscall PTR_TO_CTX
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260317111850.2107846-1-memxor@gmail.com>
 <20260317111850.2107846-2-memxor@gmail.com>
In-Reply-To: <20260317111850.2107846-2-memxor@gmail.com>

On Tue Mar 17, 2026 at 7:18 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Allow accessing PTR_TO_CTX with variable offsets in syscall programs.
> Fixed offsets are already enabled for all program types that do not
> convert their ctx accesses, since the changes we made in the commit
> de6c7d99f898 ("bpf: Relax fixed offset check for PTR_TO_CTX"). Note
> that we also lift the restriction on passing syscall context into
> helpers, which was not permitted before, and passing modified syscall
> context into kfuncs.
>
> The structure of check_mem_access can be mostly shared and preserved,
> but we must use check_mem_region_access to correctly verify access with
> variable offsets.
>
> The check made in check_helper_mem_access is hardened to only allow
> PTR_TO_CTX for syscall programs to be passed in as helper memory. This
> was the original intention of the existing code anyway, and it makes
> little sense for other program types' context to be utilized as a memory
> buffer. In case a convincing example presents itself in the future, this
> check can be relaxed further.
>
> We also no longer use the last-byte access to simulate helper memory
> access, but instead go through check_mem_region_access. Since this no
> longer updates our max_ctx_offset, we must do so manually, to keep track
> of the maximum offset at which the program ctx may be accessed.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Dan Schatzberg <dschatzberg@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

One nit (along with the bot's point which seems correct, patch 3 can be rol=
led
into this one). Given those:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  kernel/bpf/verifier.c                         | 51 +++++++++++--------
>  .../bpf/progs/verifier_global_subprogs.c      |  1 -
>  2 files changed, 31 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268de..50639bb69d91 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7843,6 +7843,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>  		 * Program types that don't rewrite ctx accesses can safely
>  		 * dereference ctx pointers with fixed offsets.
>  		 */
> +		bool var_off_ok =3D resolve_prog_type(env->prog) =3D=3D BPF_PROG_TYPE_=
SYSCALL;
>  		bool fixed_off_ok =3D !env->ops->convert_ctx_access;
>  		struct bpf_retval_range range;
>  		struct bpf_insn_access_aux info =3D {
> @@ -7857,15 +7858,25 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
>  			return -EACCES;
>  		}
> =20
> -		err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> -		if (err < 0)
> -			return err;
> +		if (var_off_ok) {
> +			err =3D check_mem_region_access(env, regno, off, size, U16_MAX, false=
);
> +			if (err)
> +				return err;
> +		} else {
> +			err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> +			if (err < 0)
> +				return err;
> +		}
> =20
>  		/*
>  		 * Fold the register's constant offset into the insn offset so
> -		 * that is_valid_access() sees the true effective offset.
> +		 * that is_valid_access() sees the true effective offset. If the
> +		 * register's offset is not constant, then the maximum possible
> +		 * offset is simulated.
>  		 */
> -		if (fixed_off_ok)
> +		if (var_off_ok)
> +			off +=3D reg->umax_value;
> +		else if (fixed_off_ok)

Nit: Can we move the offset adjustment into the if-else above? We're
essentially repeating the if (var_off_ok) check twice.


>  			off +=3D reg->var_off.value;
>  		err =3D check_ctx_access(env, insn_idx, off, size, t, &info);
>  		if (err)
> @@ -8442,22 +8453,16 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, int regno,
>  		return check_ptr_to_btf_access(env, regs, regno, 0,
>  					       access_size, BPF_READ, -1);
>  	case PTR_TO_CTX:
> -		/* in case the function doesn't know how to access the context,
> -		 * (because we are in a program of type SYSCALL for example), we
> -		 * can not statically check its size.
> -		 * Dynamically check it now.
> -		 */
> -		if (!env->ops->convert_ctx_access) {
> -			int offset =3D access_size - 1;
> -
> -			/* Allow zero-byte read from PTR_TO_CTX */
> -			if (access_size =3D=3D 0)
> -				return zero_size_allowed ? 0 : -EACCES;
> -
> -			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
> -						access_type, -1, false, false);
> +		/* Only permit reading or writing syscall context using helper calls. =
*/
> +		if (resolve_prog_type(env->prog) =3D=3D BPF_PROG_TYPE_SYSCALL) {
> +			int err =3D check_mem_region_access(env, regno, 0, access_size, U16_M=
AX,
> +							  zero_size_allowed);
> +			if (err)
> +				return err;
> +			if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
> +				env->prog->aux->max_ctx_offset =3D reg->umax_value + access_size;
> +			return 0;
>  		}
> -
>  		fallthrough;
>  	default: /* scalar_value or invalid ptr */
>  		/* Allow zero-byte read from NULL, regardless of pointer type */
> @@ -9401,6 +9406,7 @@ static const struct bpf_reg_types mem_types =3D {
>  		PTR_TO_MEM | MEM_RINGBUF,
>  		PTR_TO_BUF,
>  		PTR_TO_BTF_ID | PTR_TRUSTED,
> +		PTR_TO_CTX,
>  	},
>  };
> =20
> @@ -9710,6 +9716,11 @@ static int check_func_arg_reg_off(struct bpf_verif=
ier_env *env,
>  		 * still need to do checks instead of returning.
>  		 */
>  		return __check_ptr_off_reg(env, reg, regno, true);
> +	case PTR_TO_CTX:
> +		/* Allow fixed and variable offsets for syscall context. */
> +		if (resolve_prog_type(env->prog) =3D=3D BPF_PROG_TYPE_SYSCALL)
> +			return 0;
> +		fallthrough;
>  	default:
>  		return __check_ptr_off_reg(env, reg, regno, false);
>  	}
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index f02012a2fbaa..2250fc31574d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_stru=
ct_t *t)
> =20
>  SEC("?tracepoint")
>  __failure __log_level(2)
> -__msg("invalid bpf_context access")
>  __msg("Caller passes invalid args into func#1 ('subprog_user_anon_mem')"=
)
>  int anon_user_mem_invalid(void *ctx)
>  {

