Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B674611C0
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221376; cv=none; b=WG6eafSP1qx1LGZVkOUqTckafGpIu2dleS/InPIfZUudXx3FlGtFm6q5T658on+P0siHD1DcHQcfPq+rTyczsVZ+cI0ZLqkuglEPCewS0MyuIMQSpCc6MrRlRMhskDoky0QO5WwVz2Sk7wn4ueExyQ/eKneohgkzANU/U91EbYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221376; c=relaxed/simple;
	bh=P83yXcG3q75yqwa59IlosbbKR39QHid0c/qqNmCbYog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Su2JdzM8Gl+1kaplZWAv5gFz485MPq2Lgj5NsrPkeOnolsSuMM4/lji+3ct0MyTSfWNDjgzcrB62uQRRT4TBEd3QnbEnlE6haNb5pu7neLYok8+HC7Fp4JKZTmgz+80VEsPJ/O91W8BH8doLjSWNk3dyeqJW6623TYXqWTfdwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZSucV+d; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZSucV+d"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bddf5091c0so2463064eec.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 11:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772221373; x=1772826173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rwvQ3DO34Efx+M3oSQtNmjZHdlMen3kWA8U3vjL5U+o=;
        b=EZSucV+du0FU80f4j6ghN8HMaKbIw+ahuJlYhGXm1VuNTsr621LPsrWx/Gq7bst8j8
         Qc1MhZMjpmF3cZSAV5LTV8mAeN4dqL6//9zNcdq8YHJ9EgKHCTD3PdNKsiPFAI1QN+Iz
         ZmlKcjctD2CEQhNAGtF2H5qAnXyZSBbOOmexAod+0VVWWV6O0pL6jAwQ5a2QChDHVodv
         laVoQacO3Ys0LA3wXNKLnMp+xfIL499GV3A1+KFUNeYrxKQ9TjCYrxiWqypx5GCywYAt
         /kDRFYge8YDzVveU5lAMcwNvCCeT3quZBdxTG+uG+unRwr+E8PlVtmGmWAMIJMtRx3rD
         wh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772221373; x=1772826173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwvQ3DO34Efx+M3oSQtNmjZHdlMen3kWA8U3vjL5U+o=;
        b=vYqRMeHsigloWAnAFh6w2w38yxjpN/EhHSD8cw7bCPU6Kuidf9HA4Eifmkkg08guxQ
         hU2wPSJ0/2GThCWvHhy78IBFqyhoc7h4Juq1fIt8f093vJL1bUiFch7jNniL3ocap23E
         Ttrk/8WRvODy1e+szz5eKzhs/AZLKlBrzzFRHy36xjplC3KndYaFvKKnZlUvtniA7VFp
         dkC9QxTxrGsV2sg4XwfAoDGiA3cPMoK3CHQxIounZt3j+5NCO5gQly7SBg2r1Z62x3dP
         69lsotDCsBLBBKJQfTkvhKwbUjjM3MLnFA773rulCDtTezM7QXcspvEbCpJ22c7x7CYU
         3aBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsmZQDlaEufj9IHI4jbSLk+No3uFMftmWcLDVt7CLnfcoQi6Pc8wnXKNYpShNjHBzvtsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjB4GcQKkWRQ5m2+KmtpHymjYCRmaBkmcd7ctxvELrM5C7yeR
	8v/y80iIitqM9SifLMDk3xWcZjaH9QiLvvFg5H3wnG57ozhqA1iCpTT1
X-Gm-Gg: ATEYQzxQBc7OxOnaeHiTee8kzNb3EujwpYoZW5hU0w7COtKDyK+d20ImBL37tHg1RC0
	i4pT5RHvHBQB9ih2nOfyUcjq2A7lJeR+5kz8XHSEfMNyNtVE5kQ2p/yt/a7HncF4Lb9g7sr2xIa
	EeYX9ihVvCQA8Z3h6FmBH3w4mBwkzAUeLdsURpfkgV2ZKi80vUkLVf+B06nJJSMzYYa6qpopFA3
	muHclbMBvMwymn/xzeuDpVoO/ngitE2hB+j5Oue2/GSwfnYAmHs6yKfF8sZtSL0N2XmcgVDJy6t
	UOtmCPSiurOaJ1U2CWgoutjioF5IiQMjNqijrHEhQDkJh2Z0jOfTigYDKxwW46gYSzUwqkm9lRw
	zhyNqyxItwizsOCuG9g1sA474Cts0G2swiX29PPNdpObjB9qzugx2UkSdlB9H5srw8kWPf5+aWr
	UM3B/UxTTN8j44CL6rX8HFvs8+eGBiEsn2jrVm29tHzrdiLagI844dxT2MZ0h/318qNnjYGlU2+
	rjzsW7p
X-Received: by 2002:a05:7300:a890:b0:2ba:96d8:530b with SMTP id 5a478bee46e88-2bde1e84338mr1783861eec.32.1772221373359;
        Fri, 27 Feb 2026 11:42:53 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dacf:39ea:b35b:a26e? ([2620:10d:c090:500::1:1089])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f46c21sm4309592eec.23.2026.02.27.11.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:42:53 -0800 (PST)
Message-ID: <77261542d4c8c6ba64b14fd6662a4bb2f6ba6829.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: extract
 check_subprogram_return_code() for clarity
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Fri, 27 Feb 2026 11:42:51 -0800
In-Reply-To: <20260227154616.6846-4-emil@etsalapatis.com>
References: <20260227154616.6846-1-emil@etsalapatis.com>
	 <20260227154616.6846-4-emil@etsalapatis.com>
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

[...]

> @@ -17979,19 +17979,15 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
>  	struct bpf_reg_state *reg =3D reg_state(env, regno);
>  	struct bpf_retval_range range =3D retval_range(0, 1);
>  	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
> -	int ret, err;
>  	struct bpf_func_state *frame =3D env->cur_state->frame[0];
> -	const bool is_subprog =3D frame->subprogno;
> -	bool return_32bit =3D false;
>  	const struct btf_type *reg_type, *ret_type =3D NULL;
> +	int ret, err;
> =20
>  	/* LSM and struct_ops func-ptr's return type could be "void" */
> -	if (!is_subprog || frame->in_exception_callback_fn) {
> -		if (program_returns_void(env))
> -			return 0;
> -	}
> +	if (!frame->in_async_callback_fn && program_returns_void(env))
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Just a note to other reviewers:
Emil caught that I missed this condition when suggesting the patch.
It appears that further simplification would be to factor out
check_async_callback_return_code(), but that is not actually possible.
This point is reachable both from regular program return and bpf_throw().
Hence such simplification would push the same check to both points :( .

> +		return 0;
> =20
> -	if (!is_subprog && prog_type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> +	if (prog_type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
>  		/* Allow a struct_ops program to return a referenced kptr if it
>  		 * matches the operator's return type and is in its unmodified

[...]
