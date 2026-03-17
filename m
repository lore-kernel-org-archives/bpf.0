Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC23EDADD
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766234; cv=none; b=aVBWMAN2CAOvczRNrDgUGh4EFhD0BwyOhBz5l4qxu2qbHin6cSa0idyu5lllm/vbkFrtnbBCyjZx8msKznrfrfVt0nFl6vdjxZP8+luGwGCDsyZqFdJPHCMO3jGptsCGzeU8czLohCEVuP1SW/RiiDuPGjNrKx8XF2vYSkAysno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766234; c=relaxed/simple;
	bh=br6/KaDrHbl//TgjosvxmCuB0f/59+F8gfrSdmsv538=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tpBFtf1tI0eAsCs+O2QC34Z0jB6eqiyKBonbgtopHIDMtfVVomjNi5ijb3x3UoVKHEwH5uzFbZnZdvuptp+BaNqWUvrcM1WuVQS10qT2cqngBXTcYHHet6UAaYUSXKFHIFAx/Jjry2zu3IYB4PZ4AzRA1PAEk8swj+NV54K/fWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=F3/SctUP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="F3/SctUP"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd80f56b27so526043085a.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773766232; x=1774371032; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhqBuFUD8D4bbUJ7XP7dGefZb+KALeHjrW66z2EFMQ0=;
        b=F3/SctUPyXs1q3ysV9odTdnv33uF8PGGIKkt7HyhOVxO0MJku3fhYH8qE4cnCGWJKV
         oeR3/4V5UxqWzATTIXnIHktisrgM3pcoLvgsiQk2Ikml308+jJhgjhkk5o0GYw06TABa
         Bixg7CaWQTRZthVxkZIzRyDKmZscvb3QZ3N3udbo6/OvlzQwH2FXp3ssQz+0Tc+vUWFm
         CtbVQ/AczSwW3+kibJBkVZ4XKo/bIoWPWIpF1CJ9Pknxe+rTMe+9ObOuT2+c9ZZ3bjzb
         HQ5ChB/WWtQg1UeX/RywIZI5bSm7SZqPruRRdJ3zE3RD5mzfswAg6OW/5ldUlpuFtQBl
         DWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773766232; x=1774371032;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhqBuFUD8D4bbUJ7XP7dGefZb+KALeHjrW66z2EFMQ0=;
        b=BLQ9NFXtC+qYuyIE+olCEtUNTHYE/XUhqfBDpYoMbmkEiMow3nkByTvTkcXekCBYMZ
         U6nRPzf2eKjPeUDEnrVTrODxruUkDESMw7wuK3mSoVtqBv8+8JG37MksKqdBOAxH5Tp9
         YFmeOF6krl37UGLaNsg9ggNYhsT0TSRXnfXSQUcpkdSxO8/aOrHhOLlZfs35hr4hiu0S
         739NWEZMvtXlX6bcBooW4fgB4WCl+uplmICfp6flUMya4/xsUMeVby9CxaQBRVDjZtNA
         KIEzCS12XZ00M+PkhDRBQur4VgmlqOWHj40meGNlHFlMs7DC1/r0TnKCTuckkJ3gyVgA
         icjg==
X-Forwarded-Encrypted: i=1; AJvYcCWv5hbzEtmSiOeesXGSgd9wUAFxCFOd0ZBs03/HcPdPHcAx9qDpixxxJwQj2LAv9h32dw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIoeTi8MH2LThpN/d+oKxqcwb17XXd8fzXhidb+9wBVGbU2AD
	jNP2q1j5CsKkO1joXG3BF4maTZ/rKtVS+J8JnLIbBLWYqAijVMponjgNTEykLXut7DA=
X-Gm-Gg: ATEYQzxNm9lrrCmC/crR6t6UZfW+ii1OOSM+GEizPvZDBiNwzcjTUElZzIoTQzISlZJ
	uK0zm3uxkuFBsSFEtFYFAB/N9ndHlJq7uNJjq8M6VwFuxQXRfaprJxf2yNG1xcGrh3oId+vggra
	D68knYBI8IpKjrrXj0smVbgAbhbvlp7ZZs++z9cOOEtM5z61WsXp9I2nj5FDIF0evoQz+BUQiSS
	oinjXhxNxV9GSRzqtTS9/gJAxDroSdF+gRu5ds64ZNPfMTCRcBQKgPpRer610SWsNZJVVEeKGl7
	fIWaFV4+HFiWK8wJJU0tc5e9fCVb4MY1NV/DUtEqAGawRFWXlKrWqNNQtbasDE/wm5Mb7Ptj/wi
	+SlHfONoETEFbNRaRYMct49wBfGXOXU8BXqL/debTQRz9ae30ibfa5Ut7H0WWy6Y2FqmrEfUoIo
	f7oQTqTqjPrGr214BjONaS1tO3JCZNz1nbnw==
X-Received: by 2002:a05:620a:4143:b0:8cd:b620:9be2 with SMTP id af79cd13be357-8cfad370ab1mr29198885a.38.1773766231561;
        Tue, 17 Mar 2026 09:50:31 -0700 (PDT)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad1ea568sm12028285a.47.2026.03.17.09.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 09:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 12:50:29 -0400
Message-Id: <DH57NGRHX9CO.2K2NWI7CJNN1S@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Dan Schatzberg" <dschatzberg@meta.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Reject modified syscall PTR_TO_CTX
 for global subprogs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260317111850.2107846-1-memxor@gmail.com>
 <20260317111850.2107846-4-memxor@gmail.com>
In-Reply-To: <20260317111850.2107846-4-memxor@gmail.com>

On Tue Mar 17, 2026 at 7:18 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Now that syscall programs allow modified offsets to be passed as a
> context argument, we must make sure that they are passed unmodified to
> global subprogs. The reasoning is that we can have inconsistent and
> potentially unsafe max_ctx_offset based checks if the global subprog is
> used to access the ctx, or when it is replaced by an extension prog.
> We'll need a post-processing pass to correctly identify the
> max_ctx_offset across the call graph, but it's extra work for little
> functional gain, hence just reject this case.
>
> We have to make this change now, since we opened up the checks made in
> check_func_arg_reg_off for BPF_PROG_TYPE_SYSCALL's PTR_TO_CTX in past
> commits.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Whether we end up merging it into patch #1 or not, the logic is correct.

> ---
>  kernel/bpf/verifier.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 50639bb69d91..3f34510ec183 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10778,6 +10778,17 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
>  				bpf_log(log, "arg#%d expects pointer to ctx\n", i);
>  				return -EINVAL;
>  			}
> +			/*
> +			 * We should not allow modified offset ctx to be passed
> +			 * into global subprogs, to avoid messing up the math of
> +			 * max_ctx_offset for the whole program. Supporting this
> +			 * will require a post-verification pass, not worth it.
> +			 */
> +			if (resolve_prog_type(env->prog) =3D=3D BPF_PROG_TYPE_SYSCALL &&
> +			    (!tnum_is_const(reg->var_off) || reg->var_off.value)) {
> +				bpf_log(log, "arg#%d of syscall prog must have zero offset\n", i);
> +				return -EINVAL;
> +			}
>  		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
>  			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
>  			if (ret < 0)

