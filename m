Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B59350D55
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523419; cv=pass; b=S6snlbsb+bq4TfvOhnWvD9xlBmKQbDs8R1vfeh01o/uORCm/hdLNimVddwWW+Fp12Qtre7t/uEObDKOSpA5GYXOT6VvfEz2oco+o7uZVqU2vPdemtwY5bJbGuZKkYkQFfRa5MVzGZaWe4cqjRi3/XChOg+LnWAjQU+fKva4mFTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523419; c=relaxed/simple;
	bh=gHUWgff7WmvTx55hmvJ5HXD9obcxHan7DBI288vZwm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeiplBrm5YZLxmvHsOCds8kiM0Q0pbGVeJxztd8teYWsirAdsq6/smjud9gNKrij/YPFiJ6X/NLejFWR6tkeY72ypY35hSPb8eGVfN1EAspp3RAaR5zaoCDfMHQGuAUkuuHB8yHrBetA6JLJ6C6AjMQasQOIlsxl2RfeHc/so4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhMOtR1+; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhMOtR1+"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so828885f8f.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 09:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771523416; cv=none;
        d=google.com; s=arc-20240605;
        b=cxNqq6PpjJrL3FjrSruvfgtyuDJt4LAdKIj/yXxPsgckcUoe6QLpRq9ncirHvb2C2r
         okmV6fyZFG8nlsIVx910r7nYVI8Ek4sFAhaS1puad5WVw98rUV3tbANGZj+Qa9DbR1T6
         Fvb9AAbpNRMzcgz6W1KO0ZYh0+IMUXKguvip41FCxV1e5el35ti9227Q3+w+aMwziuEo
         wpOWiiD1Pd7nXANsGeUWjjFRTHbdpL6ls/lyUJZ0jV1lWxcEsxDfhTyPqxHYolBnsP31
         EixvleRhegj5oUPOji+t90scePeZ44RiTJ6WQ62gB1urseCFfmwvKfS5Afu1nkC5VqZp
         qs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J7HYm9xMVGBBywh4oao6tB7DD0AcczRTLXxlLGbI01c=;
        fh=RfyL9753mxwlFzZ2AM2nqAyVKxmRN7jY8rNOcnPmHW4=;
        b=aM7ex1NB9iK3+o/+EqpFfRdcRKJMD6I7Gi0ooFe7O8qjb3ZIm5KpKzq410Zv60FsfK
         OPoMCaK00QZcXavrq/ZIZb4cBFN1OB4FBwEY5ln/52zRTe+GYpsdKZMUtVRYkxY/Ihow
         PhgVg46b/nXifHOKg7y+S6ojSLQm39qrZu1UaDp807PNTOG8fJTxWGBSG96/dQmelhzd
         KLgf8P2XHp17SdJ0560czC+Uf85KprllihA85xwDmo7A3DsqpU1h6R0MP9V0x6c4jPrl
         dtpoYLu3o0yjVGBE/N0RivVlZTfiPgILZh2+O80moys7uRYF3bT07wXYPS0BuSH70PRW
         MTTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523416; x=1772128216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7HYm9xMVGBBywh4oao6tB7DD0AcczRTLXxlLGbI01c=;
        b=LhMOtR1+9guo1eQK1OTU359aYVJIzWHP+A6INFY5Ngm9CKD5Rh9RH5719/aDkuiIGZ
         wG/wPUtrGauG5iD1/uFuAP6GpCvyxNTmB0PG2CISjEQElUk9lrHCLcwDzlPWbbRv7UEW
         59DquBhiP6PTDtMovW2C9vLYjWgA76mCX3m+CBOgPzAL2eEr93kdsHuL9H2gEEL6FaJP
         HtY6kAvaKRRn9qLxnfOmM0+kiNHrYd54yPtPeBKyuvoj/1CsT4RbLjRG1unJN860svwb
         vawH19/uNZGdqr0N1/+QU7c5LW+UwS+bObPjhxI/Apva2IV8PYwLYjZ/H0I6zmv7uWKJ
         gRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523416; x=1772128216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J7HYm9xMVGBBywh4oao6tB7DD0AcczRTLXxlLGbI01c=;
        b=U8rOrDoG+sGc7vS+QS7VTI/ws5oGMVlAr9QUmFW8vbCMToBTnMGyrw3wwsxanb44Qp
         Ei2qbSd5lFDeu8c5WJhF/HU34+NizFx5vfiLQHJGStQJtvH/PwpSpXd1jZXO1S5bz61x
         Vd9E6NKDTqzI5tpZY7LEjgXfPP6n+ryICOmStjZhzVOqdAAJwY92Biw6jKmAgWzq2aul
         jlZkYDPNfk5JDmZzeH7GB62Gzvojq//EFPyTuQdX/e2v1Wqr86jL1sr68s/uzNfIcFe/
         X19r/oPAh3HtBmn47dU/mXTT+ScbV2KCUcAmAvNVOYUwo/qS/A9vgqXYlgwMc95V1ur4
         5dVg==
X-Gm-Message-State: AOJu0Yzj/IpN3dqfOOC1UmILHS5ED2L8uhsrg5+ksuB+a6xCU6BygmNL
	i0NXn7ISzxQDDPY70ayq/bxzz/1zkUawGwfLcOFZxZ/PwnheKIQnjVptkMZ2Uad2ndAv0O1y8+x
	2GLfZXz1XpzZn4tlVhkZP8BPfeq2o5Gqkxg==
X-Gm-Gg: AZuq6aJp/oO5efX6f3X8ugIvaf8Bpmbu9gGMkECrbo6pztT/qha3uolaPTaeX5AUKy3
	0k6l8j4iks6sGRu12IMokf0EW03HvoHVaSr4H7eAhFcvZ8p6pQ3AmXuQI7h0m8jz3prnqiIVXXo
	Ztl8d+4NYxgIeLnay0HB7ZOVLtMg55l7OgJATtCTpMdvzx5wtgaqieGMpnQAwAOtCEwvGPTrC/Z
	lAmohGyft4OwzXnbAwxwtJzVIB1oqGTvS5xvWsoominwJ5EyusYUnqfiDua/s6HfWre5rU/aG7s
	XG41jZ+pPzfJx/EWDWV9ijxFhHnNUj3ciOcj6jUJ563Z8lkOxqS6eJLZ/kcTExRZvtIOzOpmOLP
	XdLSWWPUr
X-Received: by 2002:a05:6000:40db:b0:436:cea:6165 with SMTP id
 ffacd0b85a97d-43958df4415mr9935730f8f.6.1771523416533; Thu, 19 Feb 2026
 09:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219142933.13904-1-leon.hwang@linux.dev> <20260219142933.13904-2-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 09:50:05 -0800
X-Gm-Features: AaiRm52i-YIC0PVoZrigOcdI1PlDGl9FQnJThWLdjntzeSoTM5oZkoYI1MwTO7Q
Message-ID: <CAADnVQK=5Gb3w_QG4Vq32EfvpqAK_DPwCHtzzt7DzRkJ5_h6JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 6:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
> +static bool bpf_kfunc_is_fastcall(struct bpf_verifier_env *env, u32 func=
_id, u32 flags)
> +{
> +       if (!(flags & KF_FASTCALL))
> +               return false;
> +
> +       if (!env->prog->jit_requested)
> +               return true;
> +
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_clz64])
> +               return bpf_jit_inlines_kfunc_call(bpf_clz64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_ctz64])
> +               return bpf_jit_inlines_kfunc_call(bpf_ctz64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_ffs64])
> +               return bpf_jit_inlines_kfunc_call(bpf_ffs64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_fls64])
> +               return bpf_jit_inlines_kfunc_call(bpf_fls64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_bitrev64])
> +               return bpf_jit_inlines_kfunc_call(bpf_bitrev64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_popcnt64])
> +               return bpf_jit_inlines_kfunc_call(bpf_popcnt64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_rol64])
> +               return bpf_jit_inlines_kfunc_call(bpf_rol64);
> +       if (func_id =3D=3D special_kfunc_list[KF_bpf_ror64])
> +               return bpf_jit_inlines_kfunc_call(bpf_ror64);

This is too ugly. Find a way to do it differently.
