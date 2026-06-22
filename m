Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C1369D65
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167238; cv=none; b=Ja+olOSiNVXM1FJi9KCPJNcbcMbqZdzRqrB0UYHABuNCEh+C7b4qYK06QWrxM/v9ksxcP3AkfoHsBSz61UXSSoZQIyZp6yPiVVF5gEYMKZqLQ1pSoLgGeTSWnSs2e4XO2hOCQS94iyjOy0u0X36DIaTGPV8ynuMskJXncBnW4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167238; c=relaxed/simple;
	bh=/tVkvwERQ5Ln4nwdML8M/9De92U0MHKhf3CNldLpgu8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCEj5A2dbzouQ0jdXgi7e+nNmYSrSYq5hrRQIEjEbS4idCcEiOI1skozs6pi6C/+dvfeu/KjY9ScSipxji2n1gHrhr85R/6QCZLeAtHsbEL+bIcgKoB/IwZ5b/uFZ/DJfFmUTdO0ke56HpZtgMv+Rgo0WQNvuJfExyY60e/jGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO+7ys/F; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO+7ys/F"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3078e0dcd67so5842909eec.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782167237; x=1782772037; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=68bd0s/HDhL9fFkyParx82/swCBZhwBtVpT9ZYWzL1Y=;
        b=lO+7ys/Fq17/o7Tspe/IdBQ6qwqnjBG+jM/9DYFO8GtPR6woUCDxPGeOfLgt7BOfzn
         eZK1M3ZESF0Y5PsCl9UwziisEAd7Qc2Mq5pql9+hvYf2adQM9xXl+sjp9u88IMdiyKXH
         CQPsQ0YnKW+wJXrQMfVtT6sFcEZK8KgOVcihZ6Q1OmTo25YVKw8jj4n0AAAak+AEZ4YD
         5s4tRPRMGuwXSwVPy7lPw8NsJ3TBAtTFTZi+3aEiiuvUSCsmNWTzg7G91vohEcnXGUS2
         3Q0ThIxoB3OqbFHovQvDzbAw8jxzHFkFM1hnGYpEtmIjPpVC0i5w5EXWYUESREM57RGK
         Ae6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167237; x=1782772037;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68bd0s/HDhL9fFkyParx82/swCBZhwBtVpT9ZYWzL1Y=;
        b=mmHpzWH1HtOVAcAyl124A4LDQQRzu9jQv4iREZh1gH4PGuKBh1k0lfZ/XIjl2DPRAI
         a0fVVWUHSssDCC7+L0DBcWYhjh+eGPn1Y38IL9JiIRS5k7Q+NLAdDdmBy7ZkL6lNd6Oi
         13LPPMnGJ7UM6In5DElk8MNt1Mameix3BQSCk+YoudWJlUJMY9q4+aS75EPvBURt91Az
         bM/jcY5d7sA4cSL4j6jgapxFHdOROyFwa/FLE6KwKTlDpiLifZg1Kc+akoC5BOUOH0na
         vi9k6qKeQWW+p7KCbe7bte5W753UEXOGWJGkeWW8ZbtElhNxumrMUY9rLi1ldxz599wi
         /58g==
X-Forwarded-Encrypted: i=1; AHgh+RocBsfM+/K+7Q2p6ZXWm0jfs6TemEX9yoJySYAOtySVVhcUqyEQvoXnXRDclWp8hzYMqrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYw69Cgr7fZdiLwAkYTm6IkfegMweU8nRuOPNI0r8vW/MdCAv
	cz9Zw6zVTCPZQYI5ftZAmHq9e8f6trn0k9Qg+HQveNmXKCqG+cd7AxvR
X-Gm-Gg: AfdE7cniWOaB6UBnNVWsM7rDTmTJf8ISIUg1GWEebpuQyE85AApjIa/MRk1r7t90Gy0
	+KEHfVqEoB1IpXVNChcIbCYcCCNsJwf9W9eF/djHvSF023CXS9cvgc8vaG2yTY8LTzl8MUe8PCo
	Yzw28FLqniYHeRHRxNx+o6ctJy+TkQBVndwjG3lIUni39BQi2rVOjfT8zBHO7eksWlIE8+eeN+H
	O6jtDcmHO891yJ5fe7VT7PCj+WnA2Ic2eHIzrZ+gy65+Lu7rkp4JegN65gXpPU3sVDe5nez6sgo
	zs5FZYcclM0wTEPLKETTdCMYN0z8yke9gp+12rGPaDIDTAVRmgYGf1ouPs9YxvQpZEHwXp4DBBO
	b065uiQ2zhu6FtOWUcNjwpxMWxGwDoOPdFiz7whtyHtwzTSykX8sZ68f8OykdzTp7OKcBoyJYK8
	NWJ7py+TuZ5V4MomK86W8WRG3gbRwDu1RpqCcr9h0htLcWa8twFtxwe1ARNAkuSri2FHs00g==
X-Received: by 2002:a05:7300:a897:b0:304:9b48:53d8 with SMTP id 5a478bee46e88-30c0702c5ddmr11700284eec.10.1782167236649;
        Mon, 22 Jun 2026 15:27:16 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c4f4:7a34:78e2:a600? ([2620:10d:c090:500::2:e8d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f8b2sm12054660eec.4.2026.06.22.15.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:27:16 -0700 (PDT)
Message-ID: <c1f98c60f6326364716f993c16aa556b5a225aa3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reject offset refcount acquire
 arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Viktor Malik	
 <vmalik@redhat.com>, Leon Hwang <leon.hwang@linux.dev>, Dave Marchevsky	
 <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 15:27:14 -0700
In-Reply-To: <f5d4097299d00f3dc6bf93f01257778da828604d.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
	 <cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
	 <f5d4097299d00f3dc6bf93f01257778da828604d.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 02:25 +0000, Yiyang Chen wrote:
> bpf_refcount_acquire() increments the refcount at the caller-supplied
> pointer plus the refcount field offset, then returns the caller-supplied
> pointer unchanged.
>=20
> The verifier records the return value as a base pointer to the refcounted
> object.
>=20
> bpf_list_pop_front() and bpf_rbtree_remove() can return embedded
> graph-node pointers as PTR_TO_BTF_ID | MEM_ALLOC with a fixed offset equa=
l
> to the node field offset. Passing such a pointer directly to
> bpf_refcount_acquire() currently passes the refcounted-kptr type check.
>=20
> That makes the runtime operation start from base + node_off while the
> verifier models the returned pointer as the object base.
>=20
> Require refcount-acquire arguments to have zero fixed offset by carrying
> the requirement through check_func_arg_reg_off() to __check_ptr_off_reg()=
.
> Programs can still acquire a refcount from a graph-node-derived pointer
> after normalizing it with container_of().
>=20
> Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

This is a bit ugly, but I don't have alternative suggestions.

[...]

> @@ -12135,7 +12146,8 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
> =20
>  		if (regno =3D=3D meta->release_regno)
>  			arg_type |=3D OBJ_RELEASE;
> -		ret =3D check_func_arg_reg_off(env, reg, argno, arg_type);
> +		ret =3D __check_func_arg_reg_off(env, reg, argno, arg_type,
> +					       btf_id_fixed_off_ok);

Nit: line length limit is 100 characters.

>  		if (ret < 0)
>  			return ret;
> =20
