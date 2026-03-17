Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BA12B94
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764026; cv=none; b=qq5W9TLUAdz8AP9Vn86d/RKsw9fW+3s8S3RqI0ChGtdoMlja55sY7zkcQLrjkRPEpATIwG7h+expdWoN3GeeLfuNe24IxLNhGWjCnmbwRUwX4lbhD9BOfGX0FMSq7BDb1Fyi9Vy8wiDyeUa/WeAaLpjIcguLYxCah2k3e1xJWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764026; c=relaxed/simple;
	bh=sE6Iy1U8OcYonjWF3Alah/QrxntZKK4QVWPq+kBma+s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hxd7bH4Eko1Xr3JPtWrZ8JI8cRA1pENv61d1LRL8BRh2L1Dor+kd5QQ+ADvuNOtGD3pl8OR9qKbXilskLe/cjUzaLMA/ww4uaYzARViOul2YnJYEopmgT3zJXir50XT2rei3XKSdJdzhaZXCMOK/CLDrq6b2jCD7dxlzoMoVpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=OHofn14O; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="OHofn14O"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cbb6d5f780so579366685a.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773764024; x=1774368824; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeKDN4Bhps5OCTXgeyWDV827xYlViqP58rCZUhJ7VZ0=;
        b=OHofn14OK09SCJ/Wzv0a29fR5kaX+bKIkYCbOZ5WYmhrJHYPfkCQVINZTnzsNwgbMi
         IWa/1L7tGXCIfqJy9pSM+T03TMprI6T+ka6zdBUZqqbJOExA/+IHnzemgDs2Ii4nCTUw
         Kpkm6t8fx+jCPwxHgdsX4EVbmj2hFt9HK937ZcYUyLOAEQJpIr4piAIfqPQUg0mmEuoN
         dlMT4wpGgEtRMUNnMtfv9opIL1tV9g5FRRe42RfBEx7D+Bm8HVBUs8sm6IL5u6q8BO8O
         zY7uIFMuLLkHuTFpYVLz91O+c64xjqSEZnq/L6hUCpNMY9iv2gy1AsM7PDZOvURHqxla
         QvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773764024; x=1774368824;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeKDN4Bhps5OCTXgeyWDV827xYlViqP58rCZUhJ7VZ0=;
        b=slj74iKkItbtwjNCLMze2SdEXJgHHvei7Z7Lgsmn7tQ3HKStq4DaMo71Xy4+nNh2P1
         SFd3cczmwDNWCATjgsc53vqwwYFIdWe/dKh901y9mzBK3IHFSJn4JlwIGV+6TlAO9YgE
         0jxr0pGjOII/LLgTJ9aTa06AR1sw7he5CMM+8JzI6KBUv91kJEL1Y4l26hmJiBGPsE4d
         SgqN1MCaWY13h2wmT9hn1m5Nd9KSLfjDEBUulbGYZD9Es5++dzuysX6qgdrNMi6ZNv/l
         eFthZsbtKE1SfgtrrHh6qz1KAj8+04H68r9mCLSVmFN0vrUFnHLLT48KXKejeqx2pfk1
         mH6g==
X-Forwarded-Encrypted: i=1; AJvYcCVnP13UIIgOvFRCM3jnVvUMytRUvZN3/l/blfs0JwVp8bt08PnAdiQ2LygH0S1CXD7nv1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1/aElyvKm/yM2yflFxwCbmy9QmG/g0bB4DeawZNIFzH8mlCy
	g9S9YYYO1FL4vqpwAcBejKZcy+PrvHGgwWeEUTp4A9pFf15yVKib7N2+3jmHKV2uHQY=
X-Gm-Gg: ATEYQzyk8KtDYqHdOkd3Jv9HSF54UwGN2OIAfvGeyVXorEZkUGifqADYeWW/gxZ5tjY
	HaGcX1KF4oG8qgbQWJzpib6YNgRdbgvhSAgxFGkPZoRJRYSyEmwTK6EF5l/bhB7lKqTFjs+BXi6
	BRlew3E+RxFOe0JQ5V2dYI5XRv5W0wnrpgNolgBFMDRFiMvXGzEnAh2BpWdaGu9DAAzZEBb/2jg
	7mUgpVYWDpd1ZD1vKXydKzODF7PQAfWD62Pcnk6S37rZdVc5eE8cLO/5b2rQStwERghTdL9S7/I
	dY881FmoMUy8WNLlnyPbZBzkcNnuPZunZ3+xEVPXNK1IIJSBTWQA7j4VDuTNcJN03tgeAWWOE6q
	pNuKIfUqJHQnD/ghXsI25Gq2rebzhMR3NCWVEOHPuv1IT3QSsngbsSuM2bduu4CPsyYgtg4LcbJ
	StUJKyysz4yywsiyROUFsQXZE=
X-Received: by 2002:a05:620a:440b:b0:8cd:8142:b7d3 with SMTP id af79cd13be357-8cfad3dfd6dmr7465985a.72.1773764023581;
        Tue, 17 Mar 2026 09:13:43 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfacde4598sm12567085a.15.2026.03.17.09.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 09:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 12:13:41 -0400
Message-Id: <DH56VAB98LZ1.1AZSVSH14DOR3@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Test modified syscall
 ctx for global subprog
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.20.1
References: <20260317111850.2107846-1-memxor@gmail.com>
 <20260317111850.2107846-5-memxor@gmail.com>
In-Reply-To: <20260317111850.2107846-5-memxor@gmail.com>

On Tue Mar 17, 2026 at 7:18 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Ensure that global subprogs can only accept an unmodified PTR_TO_CTX for
> syscall programs. For all other program types, fixed or variable offsets
> on PTR_TO_CTX is rejected when passed into an argument of any call
> instruction type, through the unified logic of check_func_arg_reg_off.
>
> Finally, add a positive example of a case that should succeed with all
> our previous changes.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  .../bpf/progs/verifier_global_subprogs.c      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index 2250fc31574d..0c14adaddb90 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -357,6 +357,48 @@ int arg_tag_ctx_syscall(void *ctx)
>  	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx) + tp_whatev=
er(ctx);
>  }
> =20
> +__weak int syscall_array_bpf_for(void *ctx __arg_ctx)
> +{
> +	int *arr =3D ctx;
> +	int i;
> +
> +	bpf_for(i, 0, 100)
> +		arr[i] *=3D i;
> +
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__success __log_level(2)
> +int arg_tag_ctx_syscall_bpf_for(void *ctx)
> +{
> +	return syscall_array_bpf_for(ctx);
> +}
> +
> +SEC("?syscall")
> +__failure __log_level(2)
> +__msg("arg#0 of syscall prog must have zero offset")
> +int arg_tag_ctx_syscall_fixed_off_bad(void *ctx)
> +{
> +	char *p =3D ctx;
> +
> +	p +=3D 8;
> +	return subprog_ctx_tag(p);
> +}
> +
> +SEC("?syscall")
> +__failure __log_level(2)
> +__msg("arg#0 of syscall prog must have zero offset")
> +int arg_tag_ctx_syscall_var_off_bad(void *ctx)
> +{
> +	__u64 off =3D bpf_get_prandom_u32();
> +	char *p =3D ctx;
> +
> +	off &=3D 4;
> +	p +=3D off;
> +	return subprog_ctx_tag(p);
> +}
> +
>  __weak int subprog_dynptr(struct bpf_dynptr *dptr)
>  {
>  	long *d, t, buf[1] =3D {};

