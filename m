Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B13C1974
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152602; cv=none; b=QoFvlictNOXUOQo/t8IxUkMuClPzrHGLzXVlFKkUNgw1GGvIYC0NGEUDZ1RztEoyfpJrdaH3XaDD7PFGkpcwcuhT1IWBAhztOH1nUdKhkbSza516H+lCWYDC/F2YIVc+o31T8enqoaGzW67/1UHBoMRyyX7n4Auz4x0Am5xcC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152602; c=relaxed/simple;
	bh=C3x+p55peaNqYVVGmlytsyxcLlSSPBJm5iFBzUdVsJ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=dWntasHfUj9Zc6PB0ihrskMiQdpTjQHnfzSy0OxBTkUOTOaK9v/T+s5ycWUT59inBPL5mJFQXCfQ2aGYm/NjZWTj5VyaIgBKKx/lKauPjhS9xh66Ywf3P5Utu18AuJY840ZZ3eo6wG2gqPLWpD24LBO4iTENERFsE5CCxOiTB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOXLyi8U; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOXLyi8U"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so1268535e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152587; x=1790757387; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tk1PkJuXbm1k2rbLIHz3zfD1EjdVMf2khcKO+8Fg5vo=;
        b=AOXLyi8U+gqfBgtd2h7CGE+zgkrelUDyNn9D/OnxshbkYNI6Q1qfMN/ZiLttBzxEE3
         yNdI9FzF/7Fc2Q7RyGPCQ+I+9we4joJQOPOQf9w0R1QomUpr/S2vTQYJoxLw/q+KM0k3
         BgZFiclY0dkMYO9JWKTiM0hwHchf4otu6RfHcc6mnJrOPx70JZ+xlG2UDtpg475HEupM
         NGKr32vrNBHsE6UJAG7mFR15WQiNJP6/TffIQ5k6qavPQPtWH8yhcS6zvwWg9lz2xi7c
         VP52q0guMXgDRkrI2nFfspduJlLX4DzYrhOdY/kn5dJSlQ7IDX4w4RMY+C9kmH3BGFAM
         anOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152587; x=1790757387;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tk1PkJuXbm1k2rbLIHz3zfD1EjdVMf2khcKO+8Fg5vo=;
        b=MxJ166q4QCcIkioRxTJC9P3o4wq4XazTBN2feH9+DCcm8eYZF92lIiRWoPlwxzzIRl
         wjoe5HSqZcy7qO0jR13GRBtnN7Y688yepBVoawcK/aQWVEwKY8q5Qe8p3TDdmBbrJUhj
         5YlYzEnCj5daiFn4YRBexxuyqqEWSpnPqxS4ZSClE/9JZA8YRYF0ThCx7ETq8+6GuJ0K
         3kRXY13wAZwS7VZ64CwRyWVqeRK8j24yRv4iYTS7KW7pJziGhp4aE1n1UNCvo48tuOO6
         7OMS85TbqLKcAmZwkdXFu35fTfpjX/a7OmE0O6lnTd6M5B3SSArPQvfa+01lXhrjkB9+
         2D3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwd7Aws+QDsDDfv3JhvRIdguBDo6/EDP8XplOrYhU/Eh0jcNZDD9XEpT3OxFQyL96KKhOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k9Xfi2yEpAUTWS2ZXCEHxA93hu+J8ZX1hVbbwW/z9alqiKkTbk
	LiBCeqJJIxHmc3rDNK6mePMct8j2rhBjTUVZN+4NcCIG43q3NVJexZO9
X-Gm-Gg: AYBFou1McwfzmyxUXfnuHrwR1XlZQJVlRKIOM3WabSelcr47fYpkalrhKatb8QX1OFi
	IG+CgfbyOQ+eHPu3qLu0KkAqCjqPAR5mEhFdHyjYO3jYBI+53WeTuqF6nMh8pSnEj8sMfhPCGm4
	kzlMhz0h3H8LQHNjBIrSzgZ1x9sNC+SkDstkrbYMWf8P8dP6f69dSx9hdGOW9Wy8uuVOethgLId
	9a+ONDEgSmO8hp25mJB4e4PMPPG3vVwV4NJ4bJAXVAQeFKZEF9hwPYULH5qaQT6TgyKjAO7QsyR
	I9ALmxuNBH83T4o6B60XrUskfqBbprgzL5ZA9963t/aR5+KYefAx+IOaejVbojB2bJUarp29Xrh
	N5JwpsXAecBycd35ae/lGswTIJhaFjVU0wWgmSKzeXf1D+seHQq7guqHkW+8+R9vYGEg7GfsQwr
	lehd5I7tXc6Ljuwe8az6N+ynbE5skMPiANYOEAerfvPJ5ImYVVcy+i62aVcJBq4aEgK812Z1gog
	nD71FmirIbFRKMBXXHIqOFpeW+qjwQfesS4bJJFplDxSDXtcuH1OhqiO4d9CJ/HW/L0F/aDRnh7
	gdRAHnx/0cJsnXppO9ayQpbko578FALhcU+V5k/b9FppsRmB5Q==
X-Received: by 2002:a05:600c:1988:b0:49f:ce78:3565 with SMTP id 5b1f17b1804b1-49fdee0a1d4mr22339985e9.22.1790152586504;
        Wed, 23 Sep 2026 01:36:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde197466sm54725785e9.7.2026.09.23.01.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 01:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 10:36:25 +0200
Message-Id: <DLMK4OKUQVYZ.2WG2LPON31FB6@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 14/21] libbpf: Resolve the compiler's
 _Unwind_Resume to the kernel's kfunc
X-Mailer: aerc 0.21.0
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
 <20260923045958.2420847-1-yonghong.song@linux.dev>
In-Reply-To: <20260923045958.2420847-1-yonghong.song@linux.dev>

On Wed Sep 23, 2026 at 6:59 AM CEST, Yonghong Song wrote:
> LLVM terminates a cleanup landing pad with a call to _Unwind_Resume: the
> base unwind ABI's entry point for carrying an unwind on once a frame's
> cleanups have run. The kernel provides that terminator as a kfunc, but
> not under that name: claiming _Unwind_Resume in the kernel's own symbol
> table, for a function whose body never runs, would be needlessly confusin=
g,
> so it is called bpf_unwind_resume.
>
> Both load paths take the detour. A direct load resolves the name against
> the kernel's BTF while libbpf runs. A light skeleton instead writes the
> name into the loader program's blob of bytes, for that program to resolve
> when it runs, so the name recorded there has to be translated as well.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cd1ea1bb53cb..2d0081784445 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8379,6 +8379,16 @@ static void fixup_verifier_log(struct bpf_program =
*prog, char *buf, size_t buf_s
>  	}
>  }
>
> +/*
> + * LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, =
the
> + * base unwind ABI's entry point for carrying an unwind on once a frame'=
s
> + * cleanups have run. The kernel knows it as bpf_unwind_resume.
> + */
> +static const char *kern_extern_name(const char *name)
> +{
> +	return strcmp(name, "_Unwind_Resume") ? name : "bpf_unwind_resume";
> +}
> +
>  static int bpf_program_record_relos(struct bpf_program *prog)
>  {
>  	struct bpf_object *obj =3D prog->obj;
> @@ -8395,12 +8405,12 @@ static int bpf_program_record_relos(struct bpf_pr=
ogram *prog)
>  				continue;
>  			kind =3D btf_is_var(btf__type_by_id(obj->btf, ext->btf_id)) ?
>  				BTF_KIND_VAR : BTF_KIND_FUNC;
> -			bpf_gen__record_extern(obj->gen_loader, ext->name,
> +			bpf_gen__record_extern(obj->gen_loader, kern_extern_name(ext->name),
>  					       ext->is_weak, !ext->ksym.type_id,
>  					       true, kind, relo->insn_idx);
>  			break;
>  		case RELO_EXTERN_CALL:
> -			bpf_gen__record_extern(obj->gen_loader, ext->name,
> +			bpf_gen__record_extern(obj->gen_loader, kern_extern_name(ext->name),
>  					       ext->is_weak, false, false, BTF_KIND_FUNC,
>  					       relo->insn_idx);
>  			break;
> @@ -8876,17 +8886,20 @@ static int bpf_object__resolve_ksym_func_btf_id(s=
truct bpf_object *obj,
>  	struct module_btf *mod_btf =3D NULL;
>  	const struct btf_type *kern_func;
>  	struct btf *kern_btf =3D NULL;
> +	const char *local_name, *kern_name;
>  	int ret;
>
>  	local_func_proto_id =3D ext->ksym.type_id;
>
> -	kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_K=
IND_FUNC, &kern_btf,
> -				    &mod_btf);
> +	local_name =3D ext->essent_name ?: ext->name;
> +	kern_name =3D kern_extern_name(local_name);
> +
> +	kfunc_id =3D find_ksym_btf_id(obj, kern_name, BTF_KIND_FUNC, &kern_btf,=
 &mod_btf);

Compiler doesn't directly emit it in .ksyms section, right? How does this w=
ork
in practice? It's a bit confusing and not clear from the commit log.

> [...]
