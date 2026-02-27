Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499C374755
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220751; cv=none; b=K6P/yXSDyNRrLj860jzxVNeFzZ3kG4vMJGPG43JBRG+x/SqXYv05Yem3/QfktSnHWr8YefZEwhPwLtWZqXsMzOR/8M4OuAVyyzdQiF5T2ZkRtw8IHrNq803x8lNBunN9L7bhc0Qpt+/HqPs0zKg5RILLnp0PmTISmMJSqRlq2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220751; c=relaxed/simple;
	bh=6QzZcczhG4emetLmK5JUdFv2bFQ29h8ZheCtiYEOgeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sY76wert0mDiQT5H0pfXS7t4l2JwXv7BGjn2IyA3pUkcG+lhq0oE6BXHakXd/7W7i6H4vYJ6MkbMscpT5cJqtwwEWl8105sutrx9pN5/IEmk0sSdc5x42wDtkInhbIVGuoZTMCqFmkGwi09CYhDlKdGfdx3i4XgrdySPH7B/cOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgOaiKPW; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgOaiKPW"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdd80beee1so756470eec.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220749; x=1772825549; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TD5rDj0TLP1XUR1dSKjyY9kxGY2+/8HPGd28CtdnkvQ=;
        b=CgOaiKPWBEfH14TspQaUzmyz9q0Wbsh9NMIrgcJ4S6eYTXfMymd/kW2saumYtpGiSA
         9NW1mEboPmDky1khNO7c7dbDVRo2eo4CRvU0Idx6mt/fnzOM4TfOacrrzikn70cdYoSv
         XF8ocpzJcLjEpzlujBNEyaAhlqq1sp2GFWZI4+J3+vaCgizrAb8+NDsHopdsahhm3/eM
         T6juJZ8sKRQSxRBoBVvxy5aV+q9VfEoWmR/N/SQ5FNW9jZ6Nyx/YkUCCd/0gdrD6suIH
         uza6sZIRwI4Uj5c+7lQ4mBk34i6eDPyco+u3F+Z0XkrkakwxMy4BXfC05Cf9Q1FxU4hY
         yBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220749; x=1772825549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD5rDj0TLP1XUR1dSKjyY9kxGY2+/8HPGd28CtdnkvQ=;
        b=BSfBEHWmKvSchFEAjY7I8hvLgeA6mDUdxqw1hhXVFAL5om+l7bIgSlpglu2JdtclzZ
         7p0q2lHnGqzUJyn1LkdCjKMMozoCNmGNmPlqO/WlQtDQDNCQUcNro8Y168B22ZwOH6XQ
         GxVYVg00WYmEiDyj4ufBI+Ieg5cCwkkk1wKHa3cG+ro9Azk5DW4R3w47/M+iRbB/XSFw
         YFLYMi8TPnVA1U/rkuslntFzcA28g6Q4vE+E8YzcPj++1+gVglfBVuwhM2MEuJt92MQk
         WErvNLp72FiHHzmayhi3+A2zeZ52La+On8FYaL5vofQWKX02VWinY9eUdKn/fJubI7HC
         Vvyw==
X-Forwarded-Encrypted: i=1; AJvYcCX2nqKVJU3mgQ2Tv0rVUEeEWy+XHq7Dao7OUd29i7CM1sLnTus+V/Js3U0s5ZQSix893ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SiktZrPuWNgS55x2pV1goDLCYPpcGqdQ7kW8DjALAyeOa6Cg
	/cbRbulh3WvF7ANLLDB8Jb+RJy0+a7RLZia6V/fvk/TeJvybVj/5/WLz
X-Gm-Gg: ATEYQzyDXfH2QFuUo8PPyaGLh2HPQ+QlMxmxYgcZuEyID0NbjTKozW+Uua/DmfIOB96
	DpQFBs7+oRBTuvzFK6i8q0eVOJu0Y7T4yoOyJ0yVMgDyamt1pqKVLCU+fhhXd83MAyVuxU8GV8o
	vccsn54cj2XPKtn6QUPXVuuv1OaLJ7nU6v0F5cQSNYHM+XtThca+RZQ5sXxljxqT1/J0ccbw9JZ
	XSiPNKNpjMn+EVgPzyk7z/pH5qlzzKZi8DP9NM4X2xPo5h6OcfFJB4Lt1Bcz/KHb9jWbAZEakJJ
	OwNMXWmXB7okwKLy7YYkp7leKxlsRwEKP9sa/n9UnexYhsPYBH1OE2JQVzvkaQrpP/Yemo/x/K6
	OwA04Y4pIGo+5RXroTbfEr56STq8QvpjA7ScD2xgDTroiQqHGm5dj53hRfAXxDENP3sXf/D3/nN
	0LseYkQRqjpsZm+RhJxkuVvmfHaHmg6Ayn7WgjHzlwVCY6zj+1NU8roy8n1W3Qz67XtASJMeYAA
	U3Zn/hk
X-Received: by 2002:a05:7300:7316:b0:2ba:a58b:b6fd with SMTP id 5a478bee46e88-2bde20f9bf7mr1528089eec.19.1772220748444;
        Fri, 27 Feb 2026 11:32:28 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dacf:39ea:b35b:a26e? ([2620:10d:c090:500::1:1089])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f48c77sm5092321eec.26.2026.02.27.11.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:32:28 -0800 (PST)
Message-ID: <706fc0b28de247fdaf302a5156d5d5cf7f0e6993.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Allow void global functions in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Fri, 27 Feb 2026 11:32:26 -0800
In-Reply-To: <20260227154616.6846-5-emil@etsalapatis.com>
References: <20260227154616.6846-1-emil@etsalapatis.com>
	 <20260227154616.6846-5-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-27 at 10:46 -0500, Emil Tsalapatis wrote:
> Global subprogs are currently not allowed to return void. Adjust
> verifier logic to allow global functions with a void return type.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fb4d14516043..702b3583cd78 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -17952,7 +17977,7 @@ static bool return_retval_range(struct bpf_verifi=
er_env *env, struct bpf_retval_
>  static bool program_returns_void(struct bpf_verifier_env *env)
>  {
>  	const struct bpf_prog *prog =3D env->prog;
> -	enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
> +	enum bpf_prog_type prog_type =3D prog->type;
> =20
>  	switch (prog_type) {
>  	case BPF_PROG_TYPE_LSM:
> @@ -17965,6 +17990,16 @@ static bool program_returns_void(struct bpf_veri=
fier_env *env)
>  		if (!prog->aux->attach_func_proto->type)
>  			return true;
>  		break;
> +	case BPF_PROG_TYPE_EXT:
> +		/*
> +		 * If the actual program is an extension, let it
> +		 * return void - attaching will succeed only if the
> +		 * program being replaced also returns void, and since
> +		 * it has passed verification its actual type doesn't matter.
> +		 */
> +		if (subprog_returns_void(env, 0))
> +			return true;
> +		break;
>  	default:
>  		break;
>  	}

Agree with above two hunks because of what bpf_check_attach_target() does.

[...]

> @@ -18059,8 +18094,13 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
>  static int check_subprogram_return_code(struct bpf_verifier_env *env)
>  {
>  	struct bpf_reg_state *reg =3D reg_state(env, BPF_REG_0);
> +	struct bpf_func_state *cur_frame =3D cur_func(env);
>  	int err;
> =20
> +	if (subprog_is_global(env, cur_frame->subprogno) &&
   	    ^^^^^^^^^^^^^^^^^
Nit:	    This check is now redundant, right?
	    check_return_code() is called from process_bpf_exit_full()
	    only when env->cur_state->curframe =3D=3D 0 and cur_frame->subprogno >=
 0,
	    meaning that it only applies to global subprogs.
	    (Maybe even rename the func to check_global_subprog_return_code() to a=
void confusion?)

> +	    subprog_returns_void(env, cur_frame->subprogno))
> +			return 0;
> +
>  	err =3D check_reg_arg(env, BPF_REG_0, SRC_OP);
>  	if (err)
>  		return err;

[...]
