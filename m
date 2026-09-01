Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5E48BD35
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284708; cv=none; b=iiRMm0xMJEf7YySQ5QvzOJSG1EJjiJHz+1yzzr7QBN+Zld/XIe52EszutG1v3J1mH1Py8Z3xs+74A6EQf0Hkrr7vPY0D9mT+3BLSunlmHF7+9cebXULZTVf4vQM7w2mi+9QmV+UEPZOLOaHZuOb8GXkLdPgB9eQucT8w+C27+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284708; c=relaxed/simple;
	bh=2RPguVjzX0PbmFhvrdRvikWG7cIhyIluUuL8QilRH4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHkuWWQ8/UZ4Ct+Ti0jH66/LBi/mMqDN8Sdq35Vm9OEZCXD8+pJDa+7byd/hvgRznXEBX2QpZh5wPZJ7Y97Vl2syYfY86wSHm3NcShcswdDuTU1+0wwxhSCgk+kLM9NRQK92WpT8SxSYILCD7JaXZWYcHkqO40eLH5FH8b4NBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a53YAxPj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a53YAxPj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4957eefd361so373985e9.1
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788284705; x=1788889505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zjdVWaNDFXESZ/X0MaSoDgYCbBInkM3rLuyj2vU/t6c=;
        b=a53YAxPjC7kXYMx/gb2mMR3sCRnfLh9ebUdboXLOiemoiXDbVMIF5NFsR6vDCdImV9
         SEpUqLAuKyP/uEEuUztiAKVVjcsBapjQdxa+e80DtBL+It8ZLJZ+JG6bMtIaHw3xttUZ
         nlE4nnc9h5wHg4uo8iTfNIIsUKPo+qGQEaysBc2Zg194EfEJyMlukfmjP5rHyn4dPhFd
         YY1aEIW/dkoHqSmmf64nd24nez0qq4Ip54D9hbp70izdyzv/TKYJl5pXvtdXGrXrRrLk
         nrIb05mbhKH22ao90mh2KnMbNlit4RZlCaLwjHmgvNqlksR9yQ4DleBXOP6lFgyXZj2Y
         fXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788284705; x=1788889505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjdVWaNDFXESZ/X0MaSoDgYCbBInkM3rLuyj2vU/t6c=;
        b=UpI6O7TIy31Vkp36VyFqHzBrpZOGAwba59xbwDwyiw5Ca1NMU4hsjWqCL2+bZmXU5K
         IHxR25+ZNrYAzQkfybhcSehuAdxda/n6hZIcjKaLGzsb547AXezO1dSe7L73JOcbmidK
         N+D/XXrwXukTQKZBXq3PslRIZ76N3gnjsqiOyYy3vP4lhH+4VSV5sElltIyWxTmaVKVQ
         DLKA4ItXJNX5HzsqI/h/UXIjC/4vXAB3i5jQKxWZVaaxGj8RsBHcdABF5ZyP6ywMqjE9
         yf05wvIkWFGvnmCqDzrJf0v4ByvnbZso+PDTpPa14HhmhyTttvRizIgwliWn0zFweENW
         SkEA==
X-Gm-Message-State: AFuF++nC1uBeg4EN87NzcNolcEvso874VizWu5VyXDBXve5yMmpJaPwK
	Z8GJ3ukOrrd7Aprch9EcQ1NwXai9BovorVuUodNggjAJKqbvdoCGWGBf
X-Gm-Gg: AR+sD12Y1Bq1j9bVy70a/+DXsWLZS/5MeRY44UStHkhnV5RT03UY2OjwEidLO+/CWOc
	eSW0Npxmye4wPHZX+Ey3ZP/Hmcjj0qqcLWqvtLhsYjJk8xLRCHdFv4S0Ib25tE4Ul2j7DxCl80q
	79NKiqpYLQzn1oy8BUA6rBoxUK/d944uuWULXIzCtWypgs5umynp0UCBDCXzQk0Jz/DJBJd/2ta
	GA/ZMaeoU09sDimxmKcs+cW9sDh7D0ZdJYRsWQQaRSw+eyC4orVbWbWJOqPCkKJ8+dPlYXG4Vml
	D+mdBSR9+XOHiwOPEfsAn4q9XkLO0X1TP5hEfXvap2tHuRehFJlcdrSrmmgxYRejMoq+QexEaB7
	f39tw5lavPkU8egdQspVspZPnZ3Hxx98NXeGjvj7rUW8+JsrqZwp7EF/EX2seVHsoCOBPMRF1ge
	Qej0BQz8TtkJQBrwgBfFEWp50S5Z+epL+j+0LyEgPpzTQ/0YI5esyFBvN9S/o0dly8Y8Dy
X-Received: by 2002:a05:600c:5288:b0:499:84fe:5f3e with SMTP id 5b1f17b1804b1-49b91c41014mr638261545e9.9.1788284704384;
        Tue, 01 Sep 2026 10:45:04 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4776131sm3126445e9.11.2026.09.01.10.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:45:03 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:55:41 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>, rlmenge@gmail.com,
	hargar@linux.microsoft.com, apais@microsoft.com
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test terminal gotox
 instructions
Message-ID: <apcRnSj7dVW1Dlsr@mail.gmail.com>
References: <20260901170144.70453-1-sidchintamaneni@gmail.com>
 <20260901170144.70453-2-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901170144.70453-2-sidchintamaneni@gmail.com>

On 26/09/01 05:01PM, Siddharth Chintamaneni wrote:
> Add tests that place gotox at the end of the main program and a
> subprogram, with each jump-table target preceding the gotox instruction.
> This tests gotox as a valid non-fallthrough terminal instruction.
> 
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_gotox.c      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> index 5b18c9a27717..cfb5b648891f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> @@ -47,6 +47,48 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
>  
> +#define DEFINE_TERMINAL_GOTOX_PROG(NAME, BASE)			\
> +	__naked void NAME(void)					\
> +	{							\
> +	asm volatile ("						\
> +	.pushsection .jumptables,\"\",@progbits;		\
> +jt0_%=:							\
> +	.quad ret0_%= - " BASE ";				\
> +	.size jt0_%=, 8;					\
> +	.global jt0_%=;						\
> +	.popsection;						\
> +								\
> +	r0 = jt0_%= ll;						\
> +	r0 = *(u64 *)(r0 + 0);					\
> +	goto end_%=;						\
> +ret0_%=:							\
> +	r0 = 0;							\
> +	exit;							\
> +end_%=:							\
> +	.8byte %[gotox_r0];					\
> +"	:							\
> +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,	\
> +					    BPF_REG_0, 0, 0, 0))	\
> +	: __clobber_all);					\
> +	}
> +
> +SEC("socket")
> +__success __retval(0)
> +DEFINE_TERMINAL_GOTOX_PROG(jump_table_terminal_gotox, "socket")
> +
> +static __noinline __used
> +DEFINE_TERMINAL_GOTOX_PROG(terminal_gotox_subprog, ".text")
> +
> +SEC("socket")
> +__success __retval(0)
> +__naked void jump_table_terminal_gotox_subprog(void)
> +{
> +	asm volatile ("						\
> +	call terminal_gotox_subprog;				\

I wonder if robot will reply the same as for v2.

The suggestion was to do

    call terminal_gotox_subprog1
    call terminal_gotox_subprog2

such that subprog1 is not the last piece of loaded prog...

> +	exit;							\
> +"	::: __clobber_all);
> +}
> +
>  /*
>   * Gotox is forbidden when there is no jump table loaded
>   * which points to the sub-function where the gotox is used
> -- 
> 2.43.0
> 
