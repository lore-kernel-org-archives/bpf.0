Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE875801
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666102; cv=none; b=bi7eJ/d0lzBg3GQuY4DIlc+H6dWay010kLhDydKn7r746697pNIIyau33csD7AZ5mkbuobHBjlHia0NMySRkPXrcnoiOt2vJMWJS81iLIK8rqnbLUj4uxcQo2rC7toPF6g347fc2FPaGg5zJZqy7MANmk/3+FnV5bjoEjPUIXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666102; c=relaxed/simple;
	bh=thT9veJlEFUXFyZE4D3W0ExYSXgbbC6YbK7BM2hUrI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mkz/fPb8hmePAbEx6Pg+TQe/ARyHNGWKhMOMZtHgeh+Oc0avIlESf9pCRuHzbE09CQwXvrMRJCykjqT7vQMssYqrWirTgPjcR6Jmmtj9n1ZIHHWGalbOXw6YH/Z3+qWhLiQbOontV4MLrWtoe6GtTAzcPOpXXVCgeBRGfWRA3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1W7cjNz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1W7cjNz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso312534a91.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 17:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786666101; x=1787270901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Sa+W7iYjUcVw4I49Nw5YFtoYhV3kuBAR6n2sFJIaYWY=;
        b=Z1W7cjNzEpdYELGimjY8A+X2RUfsjUztS0D3HosKmAN9zHBcDyFnwy7XDjMfWK66OL
         qjE89YU7MHMyrktfo0h/f0vuFs5A2upB7Z1Qk8XDVkER5l/EIZHzlS6YNqShK3G9QXHm
         6ix6Ep00cbCOg1jbv9qpkoFxyF7vph4np5N17k6I5tDbXJjlFG1e31IiRk2LDvATEK8a
         ylEyNqiDoiapksyUHTVPDi5N/wMlbiWoOAMDPMzASeX2oLVYapKsxKs+1cRashEMi3Wd
         0X6MxbVBkfdP0/KamdFitg2CisnGZ3uFRY2Ok79IpdM1zgCGTgBEGnRLk3bJdUuY8K/R
         cxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786666101; x=1787270901;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sa+W7iYjUcVw4I49Nw5YFtoYhV3kuBAR6n2sFJIaYWY=;
        b=aBaSqrvLOQ0kN12iXY6TKo8P7EhkJNjEvc93cSRH6iaNR9iEXd9GhnVcuLuzjrOGN2
         eckgVPWSm/y1ycXth0WUSAQwqVYya6e1v8D8MVqSAiDjNoc+iwxIt4g26Ot49H+gyiov
         XtFj3+9IPAYg6zXbFp8ZZpGmwmE7UMo066MmDfKOku49atUyQ7m1L87Mr5Ak+tfWS3Eo
         TR2dSfd3drfHGIGPk0cstuo8YCfguFkWqcXa8N7o3qMY3/5zlZ9/GgMUKFak8wQRhhT9
         Vbak/7wFbkRdaya/KfvIOe98m6ljUS7JH3L7vAnXN2hz4LVvu0NwBimxvYsNzmotrnmo
         mQMw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6JCnpg0PNcsgXf5OyhXZEaqLxtkQPp64fSaUZC5pdEJdz0gvtNid8KO7F91Wyy1gVtKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqqUSX0XLQnLqFMH62vLPmN5C++cF5ozgdsVoQUzIqpW6lpmj7
	Wu6PlxLbDFO+kmygxG3W/yVwIYDtYVQNzk7iCcCWfRxkCxyBFUj14u7w
X-Gm-Gg: AR+sD11e+K8Jv/PgFA1zWuCrxWRdyteqjW6GRPC9xNJgPanAVKLSor2fRk2dei0aLWS
	oKu8w7OLP2IZxEZ5hempYeg98daLDnD5qYMgDVOl0ItqEMAafFoaYFiB58Y9n7pAvwYjQJtOiVb
	5LpWPl7Jr3s7n5ijJ2DBl70W5B9ZhixiXi3a/4TOSLX6z9VtANgeKuUprr0GYTAxfpfrov11i+Y
	U2pv40Fx4nwNZcMuZphWAMsHjTAUGPLPVbwnmEmu/KT1k4fLMe+R03xNu6TMdJK85DFT3QQ+dbc
	afbRtVlvSXCX8BAfQ+H65umlAMkcn6ZEC7j8HSAC07kxJSOQIIERjjAQgqLXPA+9M9yS3z4BN47
	bmzpNv5EdH/t/VSm/BMzUvZjMy8E2QSJug61Tkv1sBKWwrRSlT3cGiXg8Ji62ugYf3C9V4RWBry
	Gi61w2Izs0kif0dkXetflMaTBoplU6zReA+iKITSfSW6xagA0Opr0IEe4CQ/SfQ6z9Qh+tdws1b
	C/tJTvMVeSCI+U99kOF5Fjbfalcwic5ZWJR7iqKGDHZrw==
X-Received: by 2002:a17:90a:dfd0:b0:38f:23d6:b4ad with SMTP id 98e67ed59e1d1-3933b792985mr1801849a91.8.1786666100706;
        Thu, 13 Aug 2026 17:08:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3203ce11a8csm361827eec.29.2026.08.13.17.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 17:08:20 -0700 (PDT)
Message-ID: <2f1954701ed6685ac9102f724f7379c13956ad93.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Keep fault protection when merging
 pointer types
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Thu, 13 Aug 2026 17:08:18 -0700
In-Reply-To: <20260813204032.644949-1-daniel@iogearbox.net>
References: <20260813204032.644949-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 22:40 +0200, Daniel Borkmann wrote:

...

> +static bool may_fault_on_deref(enum bpf_reg_type type)
> +{
> +	/*
> +	 * The pointer types which must not be dereferenced without fault
> +	 * protection, that is, the ones bpf_convert_ctx_accesses() has to
> +	 * turn a BPF_LDX into a BPF_PROBE_MEM one for. Slightly wider than
> +	 * the list matched there, which relies on an untrusted PTR_TO_MEM
> +	 * always carrying MEM_RDONLY as well.
> +	 */
> +	return type =3D=3D PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
> +}
> +
>  static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
>  			       struct bpf_insn *insn)
>  {

...

> @@ -17021,11 +17025,24 @@ static bool is_ptr_to_mem(enum bpf_reg_type typ=
e)
>  	return base_type(type) =3D=3D PTR_TO_MEM;
>  }
> =20
> +static enum bpf_reg_type merge_ptr_types(enum bpf_reg_type type_a,
> +					 enum bpf_reg_type type_b)
> +{
> +	bool to_mem =3D is_ptr_to_mem(type_a) || is_ptr_to_mem(type_b);
> +	enum bpf_reg_type type_merged =3D to_mem ? PTR_TO_MEM : PTR_TO_BTF_ID;
> +
> +	if (may_fault_on_deref(type_a) || may_fault_on_deref(type_b))
> +		type_merged |=3D to_mem ? MEM_RDONLY | PTR_UNTRUSTED :
> +					PTR_UNTRUSTED;
> +	else
> +		type_merged |=3D ((type_a | type_b) & MEM_RDONLY);
> +	return type_merged;
> +}
> +
>  static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_=
type type,
>  			     bool allow_trust_mismatch)
>  {
>  	enum bpf_reg_type *prev_type =3D &env->insn_aux_data[env->insn_idx].ptr=
_type;
> -	enum bpf_reg_type merged_type;
> =20
>  	if (*prev_type =3D=3D NOT_INIT) {
>  		/* Saw a valid insn
> @@ -17046,20 +17063,12 @@ static int save_aux_ptr_type(struct bpf_verifie=
r_env *env, enum bpf_reg_type typ
>  		    is_ptr_to_mem_or_btf_id(*prev_type)) {
>  			/*
>  			 * Have to support a use case when one path through
> -			 * the program yields TRUSTED pointer while another
> -			 * is UNTRUSTED. Fallback to UNTRUSTED to generate
> -			 * BPF_PROBE_MEM/BPF_PROBE_MEMSX.
> -			 * Same behavior of MEM_RDONLY flag.
> +			 * the program yields a TRUSTED pointer while another
> +			 * is UNTRUSTED. Merge them into a type which keeps
> +			 * the BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when
> +			 * either side needs it.
>  			 */
> -			if (is_ptr_to_mem(type) || is_ptr_to_mem(*prev_type))
> -				merged_type =3D PTR_TO_MEM;
> -			else
> -				merged_type =3D PTR_TO_BTF_ID;
> -			if ((type & PTR_UNTRUSTED) || (*prev_type & PTR_UNTRUSTED))
> -				merged_type |=3D PTR_UNTRUSTED;
> -			if ((type & MEM_RDONLY) || (*prev_type & MEM_RDONLY))
> -				merged_type |=3D MEM_RDONLY;
> -			*prev_type =3D merged_type;
> +			*prev_type =3D merge_ptr_types(type, *prev_type);
>  		} else {
>  			verbose(env, "same insn cannot be used with different pointers\n");
>  			return -EINVAL;

Given that we don't document the list of all valid flag and type
combinations, I think that extending bpf_convert_ctx_accesses() to
match base type and checking UNTRUSTED flag on it is more future proof
solution.
