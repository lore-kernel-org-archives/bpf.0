Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8416241B8F4
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050778; cv=none; b=HGrczBY4HRkE3T0/4YbNgkFf4WSVAo7RH8g5jzrXQI6BZtCYpX3AwzhIXsgldSdNPx0ilMYAmjnjKnfbZHtm84naYRE3Fcoo9fOcsSrElKZEd4RHl40YpxUudTgTH/+9MTAHrWloIK3OIS8JJrSHeCzCXBUKIPpKBGJFO2t/elE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050778; c=relaxed/simple;
	bh=jF9sM2KGUPrViboMEuXywEQzYJ0EJG+JXLKzMoq4gpg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdJ0rJ4reul2ZiXLcdkSr476QmuBiuxC1vnUdYpmdh+Gxz2K8nA3KHmT7eVzjr/smAiXPCw09E02JWn6VV1ibjRF2oCpTM+ffZx5LmYHO7G+kc+8QvusoWFhMr6oA5JIg9S/sKXWRW9lS8t2ZUMCdquRTvW8WW9BGhjkqJ7SR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBUtJ/uU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBUtJ/uU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso2403791b3a.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786050777; x=1786655577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FnfCtSdD2a2D+StGQOVSC/uz3IZgq+8deCehP+D0G5I=;
        b=fBUtJ/uUIioO/IR9MJtEImJlriUKAiSYYlCuq3/euhuJbyU8l6KoG0jyuzqrlbxhdw
         PBYVX8BXs3TrgfbAO4rX5LDzM5brr7Ima344SJts8/RnYbedajyiMdi4GFY90d63F2tP
         ghINVj5nmQjNjzT+uBt4MNZ83+pLjpkN6JoOYx2kPOTdcssKsVU9J3aFZgh9NsgZMFdK
         SxaI7t5hJSNI6UCJIfi/G8r4XsTfJh343vsFCop9uH1/f/fxwecXUYVLmWMseY5N5YGS
         nqFB30tIMspnCRJRTPQdVuxKG7GQbgzW1dpp9mNZsrElNNBu5Z43zNzWdpbFYflmpfc5
         yNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050777; x=1786655577;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FnfCtSdD2a2D+StGQOVSC/uz3IZgq+8deCehP+D0G5I=;
        b=j+Wm2TPC5CPjV+WxiX9YAFyufTNNtgvAVNdIVY8c7VvWnBURpPF/PVB5CmwDctS3Oe
         cKzAahoY7i3bSPWf4UIZNqP+40sjc2R9GzQolcSxHIsHF0IF+tBnVsgf2Dh5RbV0pcMK
         hQkfzWqH5FwyhiSjmSelayVm5v0Ov2BO+j3p5wceBgTzzNbqThcJ8ABFLom0pSmvrw6G
         o8wFL7ZG6vB2dYjqp1MTRbggDdTMcmKecj0sFGmsK6/dxpKHYuK+0eZX+HyjfKxyXW/l
         Nq7d4GK+duCVPr+ob5jOumQ6Xzcf++gPMhSEngnm0UbbqwSJY85JYJGAbORg+OxEvJlL
         G1Zw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Ivq8M5VDosbD4wQWnb0P97kBvqFtemBa/tGTfXrY3UUUz4orl0IAPC8QTHOpTQAfIwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4qs8ztuvlly4dwHYS9mRKx5Q8XyXBFbnOsyrlBDmiYaeyZpA
	Nb3FMsf+uFky32teniwYuI5OJydN3eZqBIe20xkAovIopIva89MXTT8G
X-Gm-Gg: AR+sD10zo6oU7Sr3l5rd+w79ftRYqzAZg9+l9oSVf/CBZhfY823VlOGlwUpG4Q2rMOZ
	nUELl6EVNmy9eRkQI02ebuJVUtvPeFlZskvUdlOc7pfRZv7FCxQYpFCtAnRINyTtHkIpoIqhqKP
	6cIBIKUBiTFA3DEl7fe6Yr4BFSj9SaAKKT9AgavLmn5Odauw744b/BMrw7YE1/AFamIOyviiG52
	NOk1R5K5WJuM8lxewY+dqJEuIdI4bQVL78MQ8Vs8LJhFAARMnH769OTT9aXVRX/9N4dLEzIidUE
	MN8Nd7hAdtBoXfd66hEnRBMj0k/NHXDOlKRHNXE1WDZT+IM8Wjs7GyHe0Ia0CgXhfQZHulHbCAA
	z/u0G+V/K8xJV0+nER2ilqGWd3tqLJGYloIjK0HpihVxUiPT+DbgB/AMBOYrpbzDHs/2wyr6mzx
	To6kbyqkF5BEkM0VtHMtVvTC1bJ1zdqFby7RsUQ1ApLkH9nxE/FVSCfmLwQYQX0KU6HfRk1Vymt
	1ZQtAb5ktMxWD4DoYeBuuJWnIo=
X-Received: by 2002:a05:6a00:2e19:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84f2e0edaddmr17108349b3a.39.1786050776759;
        Thu, 06 Aug 2026 14:12:56 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f459ba2b9sm2049156b3a.48.2026.08.06.14.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:12:56 -0700 (PDT)
Message-ID: <afb7cff918f93e754a873344d9794446e4ac4f9f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] resolve_btfids: Process KF_ARENA_*
 flags in resolve_btfids
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 14:12:53 -0700
In-Reply-To: <d3b34173-d3fa-489b-958d-f56bd541b838@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-3-ihor.solodrai@linux.dev>
	 <b18f90989ea2632b36c41eef646541881c9bb767.camel@gmail.com>
	 <d3b34173-d3fa-489b-958d-f56bd541b838@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 14:02 -0700, Ihor Solodrai wrote:

...

> > > +		if (nr_params < 1) {
> > > +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but it has=
 no argument 1\n",
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> > > +			return -EINVAL;
> > > +		}
> > > +		id =3D arena_tag_ptr(btf, arg0_type_id);
> > > +		if (id < 0) {
> > > +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but argume=
nt 1 is not a pointer\n",
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> >=20
> > Nit: not a pointer is not the only error condition, btf__add_*()
> > =C2=A0=C2=A0=C2=A0=C2=A0 functions might fail as well, maybe just push =
pr_err() down
> > =C2=A0=C2=A0=C2=A0=C2=A0 to the arena_tag_ptr()?
>=20
> I guess the question is how much details do we want from the error
> messages here. Since this is a part of kernel build pipeline that can
> block it, I'd err on the side of more details.
>=20
> I'll see if I can simplify this though.

Well, we don't want the errors to lie either :)

> >=20
> > > +			return id;
> > > +		}
> > > +		arg0_type_id =3D id;
> > > +	}
> > > +
> > > +	if (kfunc->flags & KF_ARENA_ARG2) {
> > > +		if (nr_params < 2) {
> > > +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but it has=
 no argument 2\n",
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> > > +			return -EINVAL;
> > > +		}
> > > +		id =3D arena_tag_ptr(btf, arg1_type_id);
> > > +		if (id < 0) {
> > > +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but argume=
nt 2 is not a pointer\n",
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> > > +			return id;
> > > +		}
> > > +		arg1_type_id =3D id;
> > > +	}
> > > +
> > > +	new_proto_id =3D btf__add_func_proto(btf, ret_type_id);
> > > +	if (new_proto_id < 0) {
> > > +		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a func prot=
o to BTF\n",
> > > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> > > +		return new_proto_id;
> > > +	}
> > > +
> > > +	for (u32 i =3D 0; i < nr_params; i++) {
> > > +		proto =3D btf__type_by_id(btf, proto_id);
> > > +		params =3D btf_params(proto);
> >=20
> > Nit: these two do not need to be in the loop body.
>=20
> They do, because btf__add_func_param() below may move the proto
> pointer, no?

Huh, indeed.

> > > +		name =3D btf__name_by_offset(btf, params[i].name_off);
> > > +
> > > +		switch (i) {
> > > +		case 0:
> > > +			param_type_id =3D arg0_type_id;
> > > +			break;
> > > +		case 1:
> > > +			param_type_id =3D arg1_type_id;
> > > +			break;
> > > +		default:
> > > +			param_type_id =3D params[i].type;
> > > +			break;
> > > +		}
> > > +
> > > +		err =3D btf__add_func_param(btf, name ?: "", param_type_id);
> > > +		if (err < 0) {
> > > +			pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a proto pa=
ram to BTF\n",
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfunc->name);
> > > +			return err;
> > > +		}
> > > +	}
> > > +
> > > +	pr_debug("added arena-tagged proto for kfunc %s: %d\n", kfunc->name=
, new_proto_id);
> > > +
> > > +	return new_proto_id;
> > > +}
> >=20
> > ...
