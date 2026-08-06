Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D37035675E
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043564; cv=none; b=j0y0ljU6M6AO2Nnrs+HqLnXwpOfZHKhgiwp0LZaqq5Fd6kj4awmqZ2KDv48hLjAxrkLG4ClCUCaZ6VW+dSNqLaPnDiFzx6KTvEFgzMV2ThcaWj0Iv/32k+ApYGau/nEIx47oDwiOWgQMI+fyGqd9ZUaQp5Mk3Nc71d6aM5bLvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043564; c=relaxed/simple;
	bh=GXQerxWjNIM5H3SA+zXS5uW7Vn8jiPQJJqOLePX1lj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+71ncn6xJQJq9YArBlACGDddRp/jlqmCjo/691/gWUFf/7calad4pXwMacNR6r+Xb2mgxYy7SjEmlpHuoNRCY1i5x54slgAteqQN3V1+ipOi1s262hBcV1EKXmsWIedQB2mV6CZ93I7dxMZeJeU+lR7rfKUv6DaRtVjHFLFe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVBcE846; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVBcE846"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceab75934dso34417295ad.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786043562; x=1786648362; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=42K9e6pkrRWd0a7t21njqQbNY887O6DkzKqpP2iupHw=;
        b=bVBcE846GfC2TuoyHya8thrMt2bCHXGn0QiQhpLmgp/TmIt+RYcVB12YikfyGJppiQ
         d4LDhejBKTiRgzQ2HQZJ2pe7IC/I8wMP7kIEcfB+avoLc74TbY8lraOJuCfqvOhCpo1O
         rjvWv9RviKF5cswT7bIDi6fHmuDomRVk1BEHvpr2fJ2iCrvyMTyUgB9lUzNBK53/WJ0H
         pSnEXLHIfQimfOnp9uGcsRFTGP/1gHUyez1iqc1qv0kZB4His4fktvpDMYIpajKc3ozl
         j8/sCH9K8fIYy92HWsRUCu8xjfFFud+afF3w6F6z6OfNI6E0KZW4V+BG8rA6jQ50xnQJ
         siug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043562; x=1786648362;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42K9e6pkrRWd0a7t21njqQbNY887O6DkzKqpP2iupHw=;
        b=Hrcos/BeO8XnmTfJVWm/HAq817zh8faRgNVosGS3h8dwtDryEL8boR5SjiZ2vd8Hbg
         dWfBmfBreZgyM53UPjP8+uueSJ8rKEKiPtjMmYVaEFpzUWEMnKBySkeFc3Ah/6IUF97y
         JeWY5C1etH35CQghWQJBZEFC5UQoqdYUkgqrR9w7HDKZzTg5yo6+Vaw4NzbGtv7yy6mV
         BmHGUMlSMt5dtD3w9ui/pxZFRN4RTvZG4Avcu8+AXx4ysrJeyDyo3m96VReWKYTty8kB
         NgXxNL2Xw+UBw1a/L+hETV10k9J3/lbQBZXKdMFJTTpYzD+rTaNeeLE1GGkaz7EJB04z
         vreA==
X-Forwarded-Encrypted: i=1; AHgh+RoFyqMGJdbdPD/Kc165UkBK4LZqh0bGn2qvk1qUDrOzvxxyeByTLUWuzv8ti8u8/7da0yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0vJe67Tpxj4LtWYdRUhzuImTWaHh3e+m98ps+7HPswyvfFbG
	9uRWLkWw5z2VZ4KscNPcR73jsckyA3Z4N4e5Semtwp1Kr3jKadhzmEfl
X-Gm-Gg: AR+sD11HX2WiUSPA2LUh8DNX8O269tisqfXJShykCKI9bAmSVJZrdYsUGsVY5pg7k5S
	T0f5n+yUMSr6P1gLny2z3MCdLSRA7bjk4Z0MrrX2pgw6dZrq+F8xL0lQH4zkQs7IfbG+f754Ktf
	ryjJLzRwzIprcvoTRuTeoMhBMd+gOQTjz/UUsdmF942QQwT+jaKJ7XmlhEb841UvPq/i2KItoKl
	Z/aYR9WC5E20VL2o17Pf0sv83J4NvCV7wV/i5fRVZ4lGYE22sIi6ibdgaotmiL28ecCQSronvmx
	ONILKdTcQJB+Tp/LCkxYcieb4MroCOWlHQk3U5TY1s2XGrDFK9s2kj3CNSfLBdLEtNRbPeZs5yv
	jak+TVeENq9/NTSEAXc+qSqbC/i0S9+6BVkolVcyaPbL3dOSvAFd+7oCMDrdK3CTAQVk1O+J62O
	CKTXRmmpVYS21tLYRgcyms7zB85PCVfJOWl3hR1ykPubW4TqTYcazR/z9gsL/uSrBDPG08xngZm
	qui4fjsMbxYFepGIA8jQQOQ3yA=
X-Received: by 2002:a17:903:182:b0:2cf:b066:7de2 with SMTP id d9443c01a7336-2d0ca945b0cmr187960985ad.22.1786043562426;
        Thu, 06 Aug 2026 12:12:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d120850aabsm1074785ad.28.2026.08.06.12.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:12:42 -0700 (PDT)
Message-ID: <b18f90989ea2632b36c41eef646541881c9bb767.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] resolve_btfids: Process KF_ARENA_*
 flags in resolve_btfids
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 12:12:39 -0700
In-Reply-To: <20260805230648.2354989-3-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:

...

> +static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
> +{
> +	const struct btf_type *func =3D btf__type_by_id(btf, kfunc->btf_id);
> +	u32 proto_id =3D func->type;
> +	const struct btf_type *proto =3D btf__type_by_id(btf, proto_id);
> +	const struct btf_param *params =3D btf_params(proto);
> +	u32 nr_params =3D btf_vlen(proto);
> +	s32 arg0_type_id =3D nr_params > 0 ? (s32)params[0].type : -1;
> +	s32 arg1_type_id =3D nr_params > 1 ? (s32)params[1].type : -1;
> +	s32 new_proto_id, id, param_type_id;
> +	s32 ret_type_id =3D proto->type;
> +	const char *name;
> +	int err;
> +
> +	if (kfunc->flags & KF_ARENA_RET) {
> +		id =3D arena_tag_ptr(btf, ret_type_id);
> +		if (id < 0) {
> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_RET but return type=
 is not a pointer\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> +			return id;
> +		}
> +		ret_type_id =3D id;
> +	}
> +
> +	if (kfunc->flags & KF_ARENA_ARG1) {

Nit: let's avoid the copy paste and make this code prepared for the
     __arena suffixes by moving the logic inside the parameter
     processing loop below:

     for (i in params) {
       bool add_tag =3D false;

       param_type_id =3D params[i].type;
       switch(i) { 0: add_tag =3D kfunc->flags & KF_ARENA_ARG1; break; ... =
}
       if (add_tag)
          param_type_id =3D arena_tag_ptr(btf, param_type_id);
       if (param_type_id < 0)
         ...
     }

> +		if (nr_params < 1) {
> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but it has no =
argument 1\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> +			return -EINVAL;
> +		}
> +		id =3D arena_tag_ptr(btf, arg0_type_id);
> +		if (id < 0) {
> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but argument 1=
 is not a pointer\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);

Nit: not a pointer is not the only error condition, btf__add_*()
     functions might fail as well, maybe just push pr_err() down
     to the arena_tag_ptr()?

> +			return id;
> +		}
> +		arg0_type_id =3D id;
> +	}
> +
> +	if (kfunc->flags & KF_ARENA_ARG2) {
> +		if (nr_params < 2) {
> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but it has no =
argument 2\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> +			return -EINVAL;
> +		}
> +		id =3D arena_tag_ptr(btf, arg1_type_id);
> +		if (id < 0) {
> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but argument 2=
 is not a pointer\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> +			return id;
> +		}
> +		arg1_type_id =3D id;
> +	}
> +
> +	new_proto_id =3D btf__add_func_proto(btf, ret_type_id);
> +	if (new_proto_id < 0) {
> +		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a func proto to=
 BTF\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> +		return new_proto_id;
> +	}
> +
> +	for (u32 i =3D 0; i < nr_params; i++) {
> +		proto =3D btf__type_by_id(btf, proto_id);
> +		params =3D btf_params(proto);

Nit: these two do not need to be in the loop body.

> +		name =3D btf__name_by_offset(btf, params[i].name_off);
> +
> +		switch (i) {
> +		case 0:
> +			param_type_id =3D arg0_type_id;
> +			break;
> +		case 1:
> +			param_type_id =3D arg1_type_id;
> +			break;
> +		default:
> +			param_type_id =3D params[i].type;
> +			break;
> +		}
> +
> +		err =3D btf__add_func_param(btf, name ?: "", param_type_id);
> +		if (err < 0) {
> +			pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a proto param =
to BTF\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> +			return err;
> +		}
> +	}
> +
> +	pr_debug("added arena-tagged proto for kfunc %s: %d\n", kfunc->name, ne=
w_proto_id);
> +
> +	return new_proto_id;
> +}

...
