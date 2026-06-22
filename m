Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F23370D54
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163592; cv=none; b=aOvA7cV01tTVM58Y0WtsciGTFE4ACq9GMvjL7ZmTWd6R5bpiT3wn65awPZsEfOqztkn68mp2qancPA3qNevQtoRgMQsl+1e6L6YAl6tk/TbDFAtMGiRXRhhLIzxQJr39d6tCmWcYQTQ7NB+kcmv9/fTEsMua6o4FdVALQv19kao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163592; c=relaxed/simple;
	bh=ykgkBwtgk1xwVAtt+5KpHiE085orCB/U6qmobZAqZTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p0I873XQ5o7AU8kjGXLOlAaf4+FFO56Eb3iJFtyZyRl3wNUP+sXqV8IMn6QvRFTrC2V/L0EnBYwayxxD81XGD+YfAHu8o2tWi/PCvvCVF6uBY36NLM1j2BFLEmx2TSbiQYLsnY2puyy958dzv00x1I8/wMYUd/9jpVSmXqJ558o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3+naxBu; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3+naxBu"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-139a5f4ca15so3524236c88.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782163589; x=1782768389; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8cba5HQyQGiPh0UO5Bpgei15e2Wrxc2IeZ3m6b4CTFE=;
        b=d3+naxBuSQyOVKL/RI4uhrvMQc+SQojUXGU1pWsYtcHaLtOOPB4pXbtapg9Okv7zAL
         E30CAH+Ek89ZxHcpcD+x4VCORtBY9bkDI4XnY5kk4kko3CQ1w+0+fidf1ouNmLAuaGw0
         ZC6YHbhGzaPR6z05BxSrl4N5wR1xyU7j7K1JDN2T5fe6VqpyGtKnQze0Npq5jNfJmu1h
         OyIWQ5llfJRLt7z4Lis7fsD9Hc/XxY8au9pvToeQQyNb8nqSvgK+t1ndgu1w6fcA5oPJ
         jJiUGZk2RXQtpOdfD7kJ7fxY9M5yp221gdjNYL6blEqiue/wLH9Iuf/Q9/Bv4YTPb1eH
         Lt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782163589; x=1782768389;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cba5HQyQGiPh0UO5Bpgei15e2Wrxc2IeZ3m6b4CTFE=;
        b=Tg1FkRHOCxznlj476gERnmP/zneTqlNRiVuzpYU/LEBzxw39WL4kxYTY/TL6m2hGiQ
         0QiTyJCKNfQrwOw6xxURNfcqSaMnt/6A3ZYt14dT1/2DZ6JBqLFhbtov13LJF5Xnq+9Z
         0HbmPkXi/i+kWld01EgqPJ03AbXo+2P7MAKozfLve2ADcG7UJ1YdaR3JQ2gG6zX+LCp7
         kdxLI+zAlTDuK2ZHwk8jUdDcE89QM2IgtY+04CIt3cAvZGTHT2v8Cz+WqP/L4jVoY00a
         x1LPDY5OmWCgNcvwqdr2rHKuacX/nwOX36BPqDFZrfprlgIMEeTQUVJ4F7iBV1/zxL30
         AAiQ==
X-Gm-Message-State: AOJu0YwJiNCvSHMeWOH4+3X/cXIpCseoqwv4PcHEl0fXuqgv9UFNCtsR
	GLb11yYab3xBMkBr3G2zI8T2NS0ainm9vmoh2aWGK672wl42zMk52DnV
X-Gm-Gg: AfdE7cmjtShgJLolCcvuubVWJ82onIJOY6tFerQQt/AQjDUnwYJGaktsk/y54FqYor0
	WJfkhXRMzM8v2MeYTJVQWJQehDjrZrcB/2FFwTPggRD2IgjECL//JiHFtENnEyh2cTnQoHWePeo
	XrQgGzg6hPOf/g22D0ktl4Wv/lvg9fqOzqW75BXGT9ytHfCoJTcGuAfza5Wu1Smd9OGF0F0bV/f
	8rRCdiIHG2xgILadD39M+jcx3jgmgtTC9dylWU8KEnOL6HDs683YDztHqtJu45BxIe3sc1yh+4d
	IPsYzGjZQ+FScjf+FTLM7Zlm72U+leeyAldFPwyprd9QslJOXFwPiK5nGBjDv2hHtuerEtz4A4W
	T6FD4l0ur+t7aO8ifq6ca+RpF8kRCnT+QuZEPruBo5GCfjO+63vFNUAXMNYXCKIQy64tXnLSipW
	y2bqdPo0EbPD7sNjTJdaMyfS6e9GRTTYrAgIrFRZ6DLGANkI+LYpfyYE3bJATX8i1ZQpQAFw==
X-Received: by 2002:a05:7301:678c:b0:304:54d6:20f3 with SMTP id 5a478bee46e88-30c06d4b6c2mr10278702eec.4.1782163588310;
        Mon, 22 Jun 2026 14:26:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e520:295b:47ea:ebb1? ([2620:10d:c090:500::2:e7b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d799sm11031846eec.19.2026.06.22.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:26:27 -0700 (PDT)
Message-ID: <8a14129295fdbcfe16e811455317108b7b029884.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover var-offset stack
 reads from zero spills
From: Eduard Zingerman <eddyz87@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, John Fastabend	
 <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Date: Mon, 22 Jun 2026 14:26:26 -0700
In-Reply-To: <20260613-bpf-stack-var-off-zero-v1-v2-2-a324af0f00ea@gmail.com>
References: <20260613-bpf-stack-var-off-zero-v1-v2-0-a324af0f00ea@gmail.com>
	 <20260613-bpf-stack-var-off-zero-v1-v2-2-a324af0f00ea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-13 at 20:16 +0900, Woojin Ji wrote:
> Add verifier_var_off coverage for variable-offset stack reads from
> spilled scalar constant zero values.
>=20
> Cover single-slot and cross-slot spilled zero reads, a sub-8-byte spill
> with neighbouring STACK_ZERO bytes, and a sub-8-byte spill with
> neighbouring STACK_MISC bytes that must not be treated as zero. Add a
> state-pruning negative test to ensure the verifier marks the spilled
> zero stack slot precise before using it to derive a const-zero register.
>=20
> Use verifier log assertions to check both the zero result and the
> precision backtracking trail.
>=20
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Could you please fix a few nits below?
pw-bot: cr.


> ---
>  .../testing/selftests/bpf/progs/verifier_var_off.c | 148 +++++++++++++++=
++++++
>  1 file changed, 148 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools=
/testing/selftests/bpf/progs/verifier_var_off.c
> index f345466bc..f0052d831 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> @@ -59,6 +59,154 @@ __naked void stack_read_priv_vs_unpriv(void)
>  "	::: __clobber_all);
>  }
> =20
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves spilled zero")
> +__success
> +__log_level(2)
> +__msg("mark_precise: frame0: regs=3D stack=3D-8")
> +__msg("R3=3D0")
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")

Nit: can drop the __failure_unpriv check

> +__retval(0)
> +__naked void stack_read_var_off_preserves_spilled_zero(void)
> +{
> +	asm volatile ("\
                      ^^^ please keep these similar to other tests in the f=
ile.
> +	r0 =3D 0;\
> +	*(u64*)(r10 - 8) =3D r0;\
> +	r2 =3D *(u32*)(r1 + 0);\
> +	r2 &=3D 7;\
> +	r2 -=3D 8;\
> +	r2 +=3D r10;\
> +	r3 =3D *(u8*)(r2 + 0);\
> +	r1 =3D r10;\
> +	r1 +=3D -1;\
> +	r1 +=3D r3;\
> +	*(u8*)(r1 + 0) =3D r3;\
> +	r0 =3D 0;\
> +	exit;\
> +"	::: __clobber_all);
> +}
> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves spilled zero across =
slots")
> +__success
> +__log_level(2)
> +__msg("mark_precise: frame0: regs=3D stack=3D-8,-16")
> +__msg("R3=3D0")
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__retval(0)
> +__naked void stack_read_var_off_preserves_spilled_zero_across_slots(void=
)
> +{
> +	asm volatile ("\
> +	r0 =3D 0;\
> +	*(u64*)(r10 - 8) =3D r0;\
> +	*(u64*)(r10 - 16) =3D r0;\
> +	r2 =3D *(u32*)(r1 + 0);\
> +	r2 &=3D 15;\
> +	r2 -=3D 16;\
> +	r2 +=3D r10;\
> +	r3 =3D *(u8*)(r2 + 0);\
> +	r1 =3D r10;\
> +	r1 +=3D -1;\
> +	r1 +=3D r3;\
> +	*(u8*)(r1 + 0) =3D r3;\
> +	r0 =3D 0;\
> +	exit;\
> +"	::: __clobber_all);
> +}
> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves partial spilled zero=
")
> +__success
> +__log_level(2)
> +__msg("mark_precise: frame0: regs=3D stack=3D-8")
> +__msg("R3=3D0")
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__retval(0)
> +__naked void stack_read_var_off_preserves_partial_spilled_zero(void)
> +{
> +	asm volatile ("\
> +	r0 =3D 0;\
> +	*(u8*)(r10 - 9) =3D r0;\
> +	*(u8*)(r10 - 10) =3D r0;\
> +	*(u8*)(r10 - 11) =3D r0;\
> +	*(u8*)(r10 - 12) =3D r0;\
> +	*(u8*)(r10 - 13) =3D r0;\
> +	*(u8*)(r10 - 14) =3D r0;\
> +	*(u8*)(r10 - 15) =3D r0;\
> +	*(u32*)(r10 - 8) =3D r0;\
> +	r2 =3D *(u32*)(r1 + 0);\
> +	r2 &=3D 15;\
> +	if r2 > 10 goto l0_%=3D;\
> +	r2 -=3D 15;\
> +	r2 +=3D r10;\
> +	r3 =3D *(u8*)(r2 + 0);\
> +	r1 =3D r10;\
> +	r1 +=3D -1;\
> +	r1 +=3D r3;\
> +	*(u8*)(r1 + 0) =3D r3;\
> +l0_%=3D: r0 =3D 0;\
> +	exit;\
> +"	::: __clobber_all);
> +}
> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read partial spill with misc data")
> +__failure
> +__msg("invalid variable-offset write to stack R1")
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__naked void stack_read_var_off_partial_spill_with_misc_data(void)
> +{
> +	asm volatile ("\
> +	r0 =3D 0;\
> +	*(u32*)(r10 - 8) =3D r0;\
> +	r2 =3D *(u32*)(r1 + 0);\
> +	r2 &=3D 7;\
> +	r2 -=3D 8;\
> +	r2 +=3D r10;\
> +	r3 =3D *(u8*)(r2 + 0);\
> +	r1 =3D r10;\
> +	r1 +=3D -1;\
> +	r1 +=3D r3;\
> +	*(u8*)(r1 + 0) =3D 0;\
> +	r0 =3D 0;\
> +	exit;\
> +"	::: __clobber_all);
> +}
> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read tracks spilled zero precisely"=
)
> +__failure
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__log_level(2)
> +__msg("mark_precise: frame0: regs=3D stack=3D-8")
> +__msg("invalid variable-offset write to stack R1")
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__naked void stack_read_var_off_tracks_spilled_zero_precisely(void)

I don't think this test is necessary, tbh.

> +{
> +	asm volatile ("\
> +	r6 =3D *(u32*)(r1 + 0);\
> +	r6 &=3D 1;\
> +	r0 =3D 0;\
> +	if r6 !=3D 0 goto l0_%=3D;\
> +	*(u64*)(r10 - 8) =3D r0;\
> +	goto l1_%=3D;\
> +l0_%=3D: r0 =3D 1;\
> +	*(u64*)(r10 - 8) =3D r0;\
> +l1_%=3D: r0 =3D 0;\
> +	r2 =3D *(u32*)(r1 + 4);\
> +	r2 &=3D 7;\
> +	r2 -=3D 8;\
> +	r2 +=3D r10;\
> +	r3 =3D *(u8*)(r2 + 0);\
> +	r1 =3D r10;\
> +	r1 +=3D -1;\
> +	r1 +=3D r3;\
> +	*(u8*)(r1 + 0) =3D 0;\
> +	r0 =3D 0;\
> +	exit;\
> +"	::: __clobber_all);
> +}
> +
>  SEC("cgroup/skb")
>  __description("variable-offset stack read, uninitialized")
>  __success
