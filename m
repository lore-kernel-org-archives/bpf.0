Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12505245019
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410089; cv=none; b=cctPEi9+N9YU/5rddtp1agoTbjz7mY/aY0gRhozclYA9eQXw6AMCS3RZQCsGnk8CUftAHAngB6i1OrUB7tdW3mGOqiGDvcL34vAT+kcFGIjE/96sNmasFKYpRf4q3gsrq7zedaMTrIAEFmOfnFRNbZWSOzAIM288Imss7rlPkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410089; c=relaxed/simple;
	bh=zkZV1eXD0QuC5QNCimQOIYMJrWBBXrW03Y7Q8o7ZtJc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFDXVURXAzP1NpGiLNQwduj6MV/2kHDbrtf9qpyWBWjc2F1IHZO66itHfIwVirokTNqXNUvdj5Ul5gNOjOOlX02mijpx1L4XLqLh5DeBAam8uaEFaFGz2T72e6C4t7N7pDtljx34y1RldQ3QAI5HqgzcveNQOCkEoZN56FyJlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVHsxEbq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVHsxEbq"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845385adf4cso17043b3a.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782410087; x=1783014887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GloosmJAxNdZMqLq1doCKGiGJI8uRKK/Lu3lZxaJX5g=;
        b=ZVHsxEbqIlSC5YcSlZ438R4IZ10uKSYL8Z1qxZUB5A3BGxFQvbq2jQp9/+HczxE1OJ
         VhQXwd8u6PM0qFbwa6uhk6QNPDp9MTCD0JRzPGyaH7uT50FKN5WbWLXsvqWMKSLeQYaW
         Xuj3pJtQP5mhmIkH88gbS3DgTkkZL7LStu/nJhhl7kf9MleZgws1weu5Dlm7+r0birKN
         tqTzV+3bKuCvMsQSQ+dTxIAyKHZqnCpGspaN4jd/5ahywuqaeYv3s4Iwl6ZSNlAxrbf9
         2kgZRczSucx8oaV9+GHH7F/fVVx9KAshk3Xpjy7h6Ys2xH1tmeXi/CHlkQm7O00figZ6
         jgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410087; x=1783014887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GloosmJAxNdZMqLq1doCKGiGJI8uRKK/Lu3lZxaJX5g=;
        b=bYw7GxLcTwSEv+68rEFlR1132y1l2PBWFt0ij0lmPqGvTsqmfWuoyak/grDGr7N4wG
         6n8dfibXWYQ10sYZhdPO+G+c2BnBqrzcq2p3KIoVObg1Jjkoxs1iUil32XySoZtV00ic
         ED05qPoDAeCnHVPr//RBIRz+UGo2EP1O2wCJqVlJBLwA+0vitO5L365/hT6ui3j5AKLI
         sfdeWN+BzJJSIMCtN5Nk13J9F8TNIndcfe9Kc/N2t1eN9MOGq179CDccb9exru1u6a6T
         n+ApFE7bJdvyIWA8wEsgNKNWEOuTTWEyMqEtJZQ20KG3LjSzOpfUh3A9nWL/K2mq+a12
         rjCA==
X-Gm-Message-State: AOJu0YwuKIJpN2QI0twLCajFPIeeKM1B2b26QeyKClBxldZ//viDeHix
	5aALFFAWqKx3NkClyEq9161Cd+5NO+0toxnQ7/EPtZp9gicX1MN8JMrc
X-Gm-Gg: AfdE7cmvJt4TDVTBuVORh5zXpsF9yM/5PuxQqu2+//GecqXXZMfdbXfeEEdDqUbPP5g
	rupMQ9qg4vnp+BZcc8vYPoejqdG+rAt9G0X2ErhQv9IdjczmiajZ4uLcC7H4zJnddVWbVkkUs51
	2w/TYhZCcByLs7kF7IT4RB4uw7lJKQRR/3eNt2m3fett3NyKkTlfuaywj5TC18aLRbD9UfdGAE2
	GvniOGc4sJym9nxnTdhkVlatqHpDc1+Q6wu2nvsDt3PfCYIdPwLnbjdbp2K6Wcbo1YYJDW+Xdw2
	h1ZHmivKJzp1b73yRABBX5NXjY+/bKRyi+xgUCt8d91aD7q47/FYu0M/lMtuQWE8cPRFQNPN1Vk
	pplPShqGT003GG+/SaGWHxfVR8V0Cu7hRhcwYVo/u7BeYoYDWltC0stWbVn4kfTphcpcYkpfLlU
	enndzdppLXZLU4ziug69+h6PSvWTrFOJFJQaYMuSpc3Q==
X-Received: by 2002:a05:6a00:7612:b0:845:b5c3:4c1b with SMTP id d2e1a72fcca58-845b5c3530fmr2943180b3a.44.1782410087211;
        Thu, 25 Jun 2026 10:54:47 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40ee417sm4881157b3a.40.2026.06.25.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:54:46 -0700 (PDT)
Message-ID: <052ab509ca71ec07af75690d72144f8b7273b73b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover stack reads from
 zero spills
From: Eduard Zingerman <eddyz87@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, John Fastabend	
 <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Date: Thu, 25 Jun 2026 10:54:36 -0700
In-Reply-To: <20260625-bpf-stack-var-off-zero-v1-v3-2-a068210a761b@gmail.com>
References: <20260625-bpf-stack-var-off-zero-v1-v3-0-a068210a761b@gmail.com>
	 <20260625-bpf-stack-var-off-zero-v1-v3-2-a068210a761b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-25 at 19:25 +0900, Woojin Ji wrote:
> Add verifier_var_off coverage for variable-offset stack reads from spille=
d
> scalar constant zero values.
>=20
> Cover single-slot and cross-slot spilled zero reads, a sub-8-byte spill
> with neighbouring STACK_ZERO bytes, and a sub-8-byte spill with
> neighbouring STACK_MISC bytes that must not be treated as zero.
>=20
> Add verifier_spill_fill coverage for a fixed-offset stack read spanning
> both STACK_ZERO bytes and scalar const-zero STACK_SPILL bytes.
>=20
> Use verifier log assertions to check both the zero result and the precisi=
on
> backtracking trail.
>=20
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/progs/verifier_spill_fill.c      |  26 +++++
>  .../testing/selftests/bpf/progs/verifier_var_off.c | 110 +++++++++++++++=
++++++
>  2 files changed, 136 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 6bc721acc..34ea6c405 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -634,6 +634,32 @@ __naked void partial_stack_load_preserves_partial_ze=
ros(void)
>  	: __clobber_common);
>  }
> =20
> +SEC("raw_tp")
> +__log_level(2)
> +__success
> +__msg("mark_precise: frame0: regs=3D stack=3D-8")
> +__msg("R2=3D0")
> +__naked void stack_load_preserves_mixed_zero_and_zero_spill(void)
> +{
> +	asm volatile (
> +		/* fp-8 has scalar const-zero spill bytes and STACK_ZERO bytes. */
> +		".8byte %[fp4_st_zero];" /* LLVM-18+: *(u32 *)(r10 -4) =3D 0; */

Why not "*(u32 *)(r10 -4) =3D r0;" as below and avoid the __imm_insn?
Please cleanup the code after LLMs.
pw-bot: cr.

> +		"r0 =3D 0;"
> +		"*(u32 *)(r10 -8) =3D r0;"
> +
> +		"r1 =3D %[single_byte_buf];"
> +		"r2 =3D *(u64 *)(r10 -8);"
> +		"r1 +=3D r2;"
> +		"*(u8 *)(r1 + 0) =3D r2;" /* this should be fine */
> +
> +		"r0 =3D 0;"
> +		"exit;"
> +	:
> +	: __imm_ptr(single_byte_buf),
> +	  __imm_insn(fp4_st_zero, BPF_ST_MEM(BPF_W, BPF_REG_FP, -4, 0))
> +	: __clobber_common);
> +}
> +

[...]
