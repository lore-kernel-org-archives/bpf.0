Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B338A70A
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549852; cv=none; b=XbH37eDCx0YWAO8myx7B3cGAB47kpuw4wPrdQ05TNKLlq4ZBbk2todZz72XWrRQ3lDGg5hXUPP80kWLGWHq44yARup7Varx9uSGBugRl6HaKprhULLeftWgQuYWyGHq/M7+zXYN5l/Gbmm9c8irwQAqwVkW0q4O0yCRKM9siW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549852; c=relaxed/simple;
	bh=Rv211AAZWVf3eg5TtZvs0VcD4jYUp+BaOvOBc1iSjtA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yt94xsr1oSt3kurTHFZHM2b/J5jdxIQbsv8IRfrPopcyCfvHzOKx7S78UUtR+Po+In6JJkr5ruW36GFz0XR9KRqk2I+C2vqb4NZyqp8ThIDk11wl/Ur9IvDJet7LQ5LyclQurXDAzZr73cldj4TfE8Nj1Sdaf+czXIFGqxmajuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN1Fimjt; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN1Fimjt"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-307d0405e07so5615727eec.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781549850; x=1782154650; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NfxSmumVC7kO1aFYBkSO1/54oChlZSPcKBbevd1gdIM=;
        b=aN1FimjtBgBJXaTar9YKVG3E/SypEQ2zVAxOpaezBGTKSfr5zLI8RoAjHUxc/cJq0b
         HJQxnUnIPanqhNtsnPhEAcb3eut1SfriPuGBGvugfJW1LXvgz8w2gIa4YU3a7hR1zeDq
         rQM0YN2i3jsib96Sz5ZU/LN4gjrc19ZfXHmkm15VP2adQgjM5ke0rRHIlrzn60NCQ4Hr
         zHZIeqLPwBKUMXhtpf6VV77Kncfxj1DFsJG1opJRlxWQDR4wDjtvR15y6VeywLHCYLzk
         M47HGRlW+lpGCIT92Tni+uhdYw6LfDDrwHRAOb6HfyQ064ULpG6zdaFzjQGmql+IHtHY
         exHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781549850; x=1782154650;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfxSmumVC7kO1aFYBkSO1/54oChlZSPcKBbevd1gdIM=;
        b=ka46n9+7o+V56aFbIDkOwQysU2Nms/2YujD+jBMD7uI2xDq0ACjyJTXWbyG1tfxqW3
         zmn2cvaTdwzNQLj+GVSltU3/Cp4qukxkxRO9UcK7dIfsftXp7SltZFY+3wo4pVW6JUgv
         1wz8NRpnqZ/QIQr/VufdGQsiI4K9FHaexfpgQc2Zj9Nyz439EsXTLjqyiBB5TAiiMRQg
         8sor0sqwGwMZpg4RURXRlHBC6JznVdh/wIlZsseCQWyyG3pB9FGjUeyV8+YpC0H0pbvn
         FZecdn5negU//ySgkHsrgMnTPI1lzUJ00NJ/OeHeHwfNhHI4V5O9PEo0iYmbpHxGHtwY
         1TBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UjB2vT/QCJxwKywzkiule75gPFq8IxiuhgSlPAzufi9p9j3XhukeBAwTyQYJjICUwXMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4OWNehaF4GzM97a3lXaTapQt/aCNYQmJNc6m6CFfW01CGNlD
	7sEYB/q1PMXxhvQmHmVYGLqp9igrHyZMmiO5w8RJDmv7ohYpiLSa1JAr
X-Gm-Gg: Acq92OFzneQv9xD1FGak/MWQ1YqL5/LShFkVe/qKYATAYMtwAMfMtAJ1mm44DPR6+Jb
	8dvRnqG8ETSMhK335Sgfysi/ecfzZ6nMt88i3yavCH/LLpkxNnYUs9UR3oEgYSoZ+UJmrms2X2i
	qaM/QO2OouFXnHyKYaKsMWBdCiwP0ZZLMniVJI87v9hAdYKiM9VY6E3qxQPHrkKSN88QYf1dkLV
	mBCfowX5LmuGRdwmKyLVS0MQ02/CJpH9q/0V8UTituqVpRD/wGa8HDPdgVNMZtmS0a+lxLNHCy1
	KMwS9lXFpvWJcs8VWoAc7YyYJSN93KWogqL5UbkCqm1RHp8flY2KaasJGlS8uT4KJ09SS4u1n9w
	NQYcu5oLlLS+Bctgg41nD6MVwgg719odz5DhWnbdD9AsHxSUxfooSyYukbHW0tFQmAHloakjiwO
	XnMxeMD0LE41JjjN79tkMmuBNkAcNUS1yPBXaf81NFZ/Xdl5p89CiLIo7ldRaPpC+0rrXDtOvY1
	xkT9fo=
X-Received: by 2002:a05:7300:6d21:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-30935239b09mr5981695eec.2.1781549849677;
        Mon, 15 Jun 2026 11:57:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:755:4880:8bc0:de02? ([2620:10d:c090:500::3:317a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d810fsm16201007eec.12.2026.06.15.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:57:29 -0700 (PDT)
Message-ID: <0930f05c6aff27dd5680c10fed14bd369df42400.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow type tag BTF records to succeed
 other modifier records
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, 	mattbobrowski@google.com, Yonghong Song
 <yonghong.song@linux.dev>, Vineet Gupta	 <vineet.gupta@linux.dev>
Date: Mon, 15 Jun 2026 11:57:27 -0700
In-Reply-To: <20260615180614.4376-1-emil@etsalapatis.com>
References: <20260615180614.4376-1-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-15 at 14:06 -0400, Emil Tsalapatis wrote:
> As of recently, Clang is able to attach type tag records to modifier BTF
> records. This is useful for using typedefs that encompass a base type
> and a type tag, e.g.:
>=20
> typedef struct rbtree __arena rbtree_t;
>=20
> Modify btf_check_type_tags() so that it allows this sequence of records.
> The function now only checks for record loops in BTF modifier record
> chains. Rename to btf_check_modifier_chain_length to reflect this.
>=20
> Also expand the BTF modifier traversal code to take into account that
> type record can be interleaved with other modifier records. In effect
> this means traversing all modifiers to collect the type tags.
>=20
> Also modify existing selftests to now accept modifier records (const,
> typedef) that point to type tag records.
>=20
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Vineet Gupta <vineet.gupta@linux.dev>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Looks correct, two nits below.

[...]

> @@ -5860,11 +5866,10 @@ struct btf_struct_meta *btf_find_struct_meta(cons=
t struct btf *btf, u32 btf_id)
>  	return bsearch(&btf_id, tab->types, tab->cnt, sizeof(tab->types[0]), bt=
f_id_cmp_func);
>  }
> =20
> -static int btf_check_type_tags(struct btf_verifier_env *env,
> +static int btf_check_modifier_chain_length(struct btf_verifier_env *env,
>  			       struct btf *btf, int start_id)
                             ^^^^
Nit:                      formatting

>  {
>  	int i, n, good_id =3D start_id - 1;
> -	bool in_tags;
> =20
>  	n =3D btf_nr_types(btf);
>  	for (i =3D start_id; i < n; i++) {

[...]

> @@ -7024,19 +7021,43 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
>  	info->btf_id =3D t->type;
>  	t =3D btf_type_by_id(btf, t->type);
> =20
> -	if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
> -		tag_value =3D __btf_name_by_offset(btf, t->name_off);
> -		if (strcmp(tag_value, "user") =3D=3D 0)
> +	while (btf_type_is_modifier(t)) {

Nit: similar logic is repeated in the btf_struct_walk()
     Can it be abstracted away? E.g. by adding some sort
     of `collect_type_tag_flags` that would accumulate the
     bits for MEM_USER, MEM_PERCPU, MEM_RCU?

> +		const char *new_tag;
> +
> +		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
> +			goto skip_modifier;
> +
> +		new_tag =3D __btf_name_by_offset(btf, t->name_off);
> +		if (strcmp(new_tag, "user") =3D=3D 0) {
>  			info->reg_type |=3D MEM_USER;
> -		if (strcmp(tag_value, "percpu") =3D=3D 0)
> +		} else if (strcmp(new_tag, "percpu") =3D=3D 0) {
>  			info->reg_type |=3D MEM_PERCPU;
> -	}
> +		} else {
> +			/*
> +			 * If we fail to match on the tag value just ignore it.
> +			 * Tracing programs have the same BTF as the function
> +			 * being traced, possibly including type tags BPF is not
> +			 * aware of. We cannot possibly account for them so ignore
> +			 * them.
> +			 */
> +			goto skip_modifier;
> +		}
> =20
> -	/* skip modifiers */
> -	while (btf_type_is_modifier(t)) {
> +		/* Only a single tag value supported. */
> +		if (tag_value) {
> +			bpf_log(log,
> +				"func '%s' arg%d type %s has multiple type tags\n",
> +				tname, arg, btf_type_str(t));
> +			return false;
> +		}
> +
> +		tag_value =3D new_tag;
> +
> +skip_modifier:
>  		info->btf_id =3D t->type;
>  		t =3D btf_type_by_id(btf, t->type);
>  	}
> +
>  	if (!btf_type_is_struct(t)) {
>  		bpf_log(log,
>  			"func '%s' arg%d type %s is not a struct\n",

[...]
