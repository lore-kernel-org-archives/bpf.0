Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE624A067
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533477; cv=none; b=WfS7YDMhVKcEZiQltCydhjp5bkojirW58oVcTa5JX8+KAO9l9IyTfCGgAbGVdTcOo6Cum2rqbAjUajGflFE6+q0xRaQr4VXhBQWsTmE1690n5g7No0Ob7ojlEt6gYkMf//ikWpff5BEn/LXLq4Ky7AyogGlSFoO/AFr26Z1TuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533477; c=relaxed/simple;
	bh=Vl4fMH/xNRZHf96sUYP39tES5BqRAY8TjfN0w9cbPi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqIacb6wZFgxXPBuT9WbJI5relBnI7plrc6sXKU6QHKCbAdqq1zfMKuIIVPkiY5Kqts7+D1yo3mkDLjubBGB5o9OeSz9+Rq3cYnPYtb5Ow9L/EcUEb+grNjJTaQuDcV+V4g2j/L/1da9FqM2MdwwXpq24YREW+FvHL856zs1DOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ6/T4O/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ6/T4O/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824c9da9928so725121b3a.3
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771533476; x=1772138276; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tBilp6uEJnBSqx/iWLpCCeRitunhKhme0ZhgqWgSfUU=;
        b=NZ6/T4O/PwCXqfwFPy0cRi5Dlk8NT8FF49z1gjMpJOj5GuRPhkfveEyXPIkcjjxcah
         hCdh/t9KRPtpsJYqeNqiiZPfC4GREH582V9Mz7OwZuhSQz8kiRSHJ0VaYbQcAr291g9a
         /59plO2kutQh0980voOu9q4QDzB+vfXhmbSVP4/YdfD3tnz4RXNAQaLe1Mz3zq6GpDvq
         k9c2Ap7pO116zFoPhQHuD4kP/VqeegSdhsCwfL2gjMQ8ldCSWSUnn7Aur/+Xqlz6pvtr
         R8OowZG8rJnmie/grjF/iZztlxAngxx7MqdeU+igDZIiDfpXbwGnig5icN3r7Ip2rHa2
         t0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771533476; x=1772138276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBilp6uEJnBSqx/iWLpCCeRitunhKhme0ZhgqWgSfUU=;
        b=WwEX1nUbAWIQfmHZNmWy11nSb4gtTHNRl3xDpDyrY3Dram2IxIlljPUgzQUpVhXLND
         1RZkb9SifxB9t0OQlNSzc154Uu4hve1HQJeXp3gZcBuXgQHc1DMdkKbM3/0KPSeP4xK3
         8I/iYcibdxaAnTwlcd5ScCJIYyYXHV7KdA5Ewn9bSZ6ByFhGiDU3HPgh0gkAMsawevc6
         S2hjujrXXeqwqbhAfWAQt7IcyNlyjXCp5j5Jcz73ziAiFoWx+On/Ht5EdaDBPPBYw85k
         lN701JnIIfsfSSt901HuIhYVMI5CCJ7HMGt/HDDQTOEsjUctR1uL2JVkVeS5x5NDtjCs
         DReA==
X-Forwarded-Encrypted: i=1; AJvYcCX+RbN6rmiLwac2LUtw5Zv+bygkkFL89Y0Wk2HK2wv97nog0vYMs8tCoLL6Mfx2WnU2sD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9a2aW1k1H5eraKC/gsfP1igYNRlyWuCFo8jV3TOuI7Twi1Lwu
	X74mcjKC5k5tN3Dfm7D3b544sYMBq3bKcgK7oSzpZqwgreXBbQWwlHQB
X-Gm-Gg: AZuq6aJl3AtfgbLbEy2qR8aQvU4GPHXcrwaDlzpPbLuMT3UViIXN48w61b9w+FGAtRD
	93k7dWFykdLCH4dAHu9kzffLot62Xh90698KYKYSR2cA+25JwT+aUlqgHdADg9+/6ZxgF8YthBx
	q2QGTa8MmYAXhsi7lDoM9q5xeh4h9X+nN4tCFbszJCExlJ6IBd3KBDcZeT2a1pCRxsNy9lVjLym
	R+vHaCyCYeGM47W80tIgOEZDldGbX4spzst2WV6EEoq3YQiWMwkM7u/ZbbaVEQw8lofFYkZJhy2
	OIosh5TbI74A5jrIjZiDo6K0SWkblAAMQzsWkXZOS19IXfdVgzBlujaUdRVlFoIFcM1ZzneOIXK
	nQhTmgQjybco2USG+ZyUtAm1ihYZIQ8nCsRHIsy2rK07DTFQOir6KmYCOXhD+fFml/TS0fbedNA
	n/zP6OUC518GIGvPZQBdNOi4UrS2ZUfKdCIoYB/5s+tIk/A8zGYQjY
X-Received: by 2002:a05:6a20:6a1f:b0:35e:3cac:858c with SMTP id adf61e73a8af0-3951213dc01mr3730099637.33.1771533475737;
        Thu, 19 Feb 2026 12:37:55 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6bb55adsm20080606b3a.62.2026.02.19.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:37:55 -0800 (PST)
Message-ID: <b36ca4ba2eada11a9b5cd5dc1f44e9217a86add3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add KF_ACQUIRE and KF_RELEASE support
 for iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Thu, 19 Feb 2026 12:37:52 -0800
In-Reply-To: <20260218182555.1501495-2-puranjay@kernel.org>
References: <20260218182555.1501495-1-puranjay@kernel.org>
	 <20260218182555.1501495-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 10:25 -0800, Puranjay Mohan wrote:

[...]

> @@ -13797,7 +13826,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  		}
>  	}
> =20
> -	if (is_kfunc_release(meta) && !meta->release_regno) {
> +	if (is_kfunc_release(meta) && !meta->release_regno && !meta->has_iter_a=
rg) {

This makes the check too strict, right?
E.g. for most of the release kfuncs there would be no iter arg,
hence the check won't ever be true for those kfuncs.
Do we have tests for this check?
Either we don't have the tests or the check itself is redundant.

>  		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF=
_ID\n",
>  			func_name);
>  		return -EINVAL;

[...]

> @@ -14356,6 +14400,18 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].id =3D ++env->id_gen;
>  		}
>  		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
> +		/* For iterators with KF_ACQUIRE, auto-release the previous
> +		 * iteration's ref before acquiring a new one, and after
> +		 * acquisition track the new ref on the iter slot.
> +		 */
> +		struct bpf_reg_state *iter_acquire_st =3D NULL;
> +
> +		if (is_iter_next_kfunc(&meta) && is_kfunc_acquire(&meta)) {
> +			iter_acquire_st =3D get_iter_from_state(env->cur_state, &meta);
> +			err =3D iter_release_acquired_ref(env, iter_acquire_st);
> +			if (err)
> +				return err;
> +		}

I second Mykyta's points here.

[...]
