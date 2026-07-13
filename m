Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A83859EF
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980774; cv=none; b=l+EZubyVUBDG7sdll1D0EElQkoPhXVbCm+coeNXyhI12fx6yiBfaBN4peY31HLLaN8nF1ZjV0U4gZa7NlRURWdh9aVbWSj+UT+dYGXbo2sn3XoUuv2YKsGHd0o2gRgxhjg0ZugRDSsd/FqbZLKK/OzcD22kyN51KKwVP1dtx7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980774; c=relaxed/simple;
	bh=mYidOFErwe8XH9CnmqqlwhT4wTP0xLaCDcmZL7YtxAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WwNLLCW+2C8L3Sd3Kcpai2lBxacMFDSPA0hqZc4xQv9bfMEdiNOw/VtT6Gm0NcH1yCIpoIAsF1FdjTEY1q2sMXZ0ZcMcwSRs95p28cWRFOJA9ulQDdhvXp/GH/LRP5UaGjJpcnzLuxyw3aetVOX2NJsYY7a56yZz/rH15xdcCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qB1dsdvt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB1dsdvt"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1234325a91.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980773; x=1784585573; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lnK70i1C9aIl1cpxDVKHYtJijlCbjXSvhvYuGxcBSCc=;
        b=qB1dsdvt8SvMSlf16S7/dAZiXlEZaFrMbTQLy4Rba0EVTeV5egvli4wx8YdXiVZMoE
         Wlvc+m9zj1VcOXxiofcHKOh47Ev0y6zZ0RDDc4swRunWF+Z5jyZFKPyq3thX0hsqH+0R
         SYX3aoHUlBbC6ligKV0O1I1MWiEIUPViG2uTCG/Fd0llMrgdu+m5XL23F34RslOCWkDA
         KJsYp0V8M9BKAnyw7RD8HC31uTJlNyFzSpomPzroLyx+KdLweW11sZ7ZQE//Cb73w4Co
         GwT+zY6wpy2eWVRmCsCokKEQanhlEjS7uu9EOSZJn68ovCDqW9WFYPd9p8lEE5LESMYr
         +0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980773; x=1784585573;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnK70i1C9aIl1cpxDVKHYtJijlCbjXSvhvYuGxcBSCc=;
        b=k0k4qLC+NoSlzdpyhEr/2/OcGmXouDwq1bQSz6e2xy9999/3RvDK6EUM5XBdk5yxv3
         KAE4orLB0pNDdGhT1KcDEsDSrLfG8Pa6RIL7Ls39OGtI+9XKaskWgqb3cxTN2l9q/Vwe
         LWVebG2kZ4M081u8l52XIJ7dpuD/oaaJnYW/UzY8hgX7cfA15Kw7lm3hJtQnQzwojI5L
         zx+nnq105ue4GVaTxGI9w3RhatxF3RAU+YWm6kK2+Nk7DoPBLdjnKm0aw0GMSWIVyujZ
         f878DvNkkcReXptSevpNGaK5EZ2NIMa22HzeiHNN0aUFZtEKI9dw/OqMwc1NOWeWwvsv
         LgUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpAT+Kn6LknFw30igcLnK7xpqnCp0aEkc23QuQNZ76P4KfX9X3ImxTkc9jrfgG34GBuXzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNk8vMouvLqAtCtARFYRBT7c3D4ekJcA1IZ40wREfEdOxDrl2w
	rCQ6i/Po+oShvIB6uwlSMbjHZGfxlkSEzKcQukyRKLWkxzW670mGksTS4kkYMg==
X-Gm-Gg: AfdE7ck1u7jI0p6SEWqoMlrr+3YXTAyk7bVMUORwo1jqpwM7mLTa2puiugUoxLW+x/m
	qIYOTZTIvhdDcXcEjUvI6N40IgGa1onsM49+3KsqTUD4qfAie6eSi8TIdFg4QPzXogLbmDNcXMC
	JPDKiq4EHcCxIDrPr6Au5OEWZ3zKlzmftiUKyEJwKaJAEn7vO7tVbr4Qlxcft/En3TRCKV+MiD+
	fdH3oEos2QySUEZQ2Zt70UD3LtQlkTWmtV6rMGXRDrFmZhEErXW1rsbxKdL8S0r4StVhj2ioh4D
	sSqIQsHzaw1Y8IZBe+qwAzJQEHxlebC+khcynFXkVzhOhejUkEDViSJG57plmtm8EaLZiDdUwEg
	DFCwl0IvHtyTOgBBpvQ3oXbWUuBWOFFO6mX7EA5IikrBuS/uUMISuGunw4q9PB/BCqsifOXeAZf
	mVCfYBbrP885Ocf1SRes444OPtBLPATENWDW/ysB3+Zp49xJl6tUY=
X-Received: by 2002:a05:6a21:517:b0:3bf:a0e5:99a0 with SMTP id adf61e73a8af0-3c34d71bd31mr1203285637.47.1783980772756;
        Mon, 13 Jul 2026 15:12:52 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3a2bf6bsm9152559a12.27.2026.07.13.15.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:12:52 -0700 (PDT)
Message-ID: <6befa724e4fdc197f4a603246b4f95b65748882f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcases for callback
 with tailcall
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
 <bjorn@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Yonghong
 Song <yonghong.song@linux.dev>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Song Liu	 <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	 <emil@etsalapatis.com>, Pu
 Lehui <pulehui@huawei.com>
Date: Mon, 13 Jul 2026 15:12:49 -0700
In-Reply-To: <20260711104727.4023420-3-pulehui@huaweicloud.com>
References: <20260711104727.4023420-1-pulehui@huaweicloud.com>
	 <20260711104727.4023420-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-07-11 at 10:47 +0000, Pu Lehui wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/t=
esting/selftests/bpf/prog_tests/tailcalls.c
> index a5a226d0104c..c66037162da5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c

[...]

> =C2=A0void test_tailcalls(void)
> =C2=A0{
> =C2=A0	if (test__start_subtest("tailcall_1"))
> @@ -1967,4 +1973,5 @@ void test_tailcalls(void)
> =C2=A0		test_tailcall_cgrp_storage_no_storage_leaf();
> =C2=A0	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge")=
)
> =C2=A0		test_tailcall_cgrp_storage_no_storage_bridge();
> +	test_tailcall_callback();

Please use test__start_subtest().

> =C2=A0}
> diff --git a/tools/testing/selftests/bpf/progs/tailcall_callback.c b/tool=
s/testing/selftests/bpf/progs/tailcall_callback.c
> new file mode 100644
> index 000000000000..504d8e7a6996
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_callback.c

[...]

> +/* callback involving 1 subprog with tail call is rejected */
> +SEC("tc")
> +__failure __msg("cannot tail call within callback")
> +int tailcall_bpf2bpf_callback_1(struct __sk_buff *skb)
> +{
> +	clobber_regs_stack();
> +
> +	bpf_loop(1, callback_loop_2, &skb, 0);
> +	return 0;
> +}

I think having all three is a bit redundant,
let's settle on tailcall_bpf2bpf_callback_1?
