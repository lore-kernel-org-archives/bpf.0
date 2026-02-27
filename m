Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F725B1CB
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156557; cv=none; b=K2miMnFJI79P8qwF54nCcVZbkIhTVIIql0yKd+pbHGS0YN2g+EdEECW9k3nbn4VC5fRKZlIrH0ergopVhvlv2HTDp+lyOHUJrf24x53MIfCUHKZIs/05J0kYeBNMvpeo8MdZ6AVW+t/C1ioeS7agL4NiljnNXioTipf35icKj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156557; c=relaxed/simple;
	bh=TLugaVXuQoNSQ+bsTdlCUDm9aJ2X/gYaR3lf3+AwiJ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tN+g7bsz4WXd8Y2alRjNdarqnPaT0eeqR9OZLMwlAxPBUWU8c6nRip9ISa2WzT8n91qwLn+DpNDLEuJ72/6T5OCAN7n/qpILc4y6ydlApJBRxPC6jyfP1AqSlgHtcL4UdlKA4QcQEJ0smaljrCiOEyEhzdjYGU8OUnN3f0ycZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=lAHAXW1F; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="lAHAXW1F"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899a9f445cbso20441516d6.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772156554; x=1772761354; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m/9z7kJLPFDqetRFZ4eeSgRtS3KpHzf3VgBKbnJ850=;
        b=lAHAXW1FXB4iVIENY5pqmXziTK0Ck0xelq5ekwn4x7lY1hvuBnmxLmrXW3EaDtV6HZ
         3cDznr5gtVHDjknpB+DdmtO975zqfVv0ZYrBhOctHS3lTW9/QWkr+Ek7hlyHO/76lmJk
         3SCeHiZgbjHXDISH3f3e5CvmQccWmTkbNzhZkD6L9LPJcIy3tM0JIX4ixUKebDfWQZkk
         tmPgSLkY92P65CH2VHrjNxyVXqQDeGGqnx49C0gEgwK3FBKaPFs/Tr75FWb04GLcvT6j
         AbAj84lAO/xR5gbDNptRtDMXDd0la3GuYeNNoeXjXnTp9uz1Krb2Qwnj06VXH89+JLCm
         nFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156554; x=1772761354;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6m/9z7kJLPFDqetRFZ4eeSgRtS3KpHzf3VgBKbnJ850=;
        b=ehKe1ckFH5nAdCXKgT4fPPXQfbxgfClZ2xSNuKL9w+iOixhHjOaRhS8G1jHqCT/QRn
         SKXnPP5GN+foeU89XuZMFLFQjrX75CaTzxfbJ4tkFb4zwgps2TCTm7tmY2N1hXxuNl4B
         Qll+sxLJA5YnxgN12ee6e3PZDtMDWP4f8c0qTmhJPnQ2cHPz4zX12Df0tW/vOqAQNqir
         SFspzr3BfbrP+vu7INRG0L5GSdhBVJLvQKH1h5Gs/xQNI24tdvzBrpGhfuih/WYAEdac
         J4viQrRl6m8WnaNeKvfCpYCajY9aJSW8yuV9fWXW/LdIc+yDhKijBaOIaZqHi7/+ujg1
         xt+g==
X-Forwarded-Encrypted: i=1; AJvYcCWIm4e9WgEB6LQ/8w2n7liBM7O99RT4V4I15dTtjrcN/HAIMxxWEvpZp36R8rwIHWhbBhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XR8KMSnDKtnc2iDPY16l8k18S2oIhstTBQUN3Z3shz0Eluym
	XmWIx++mBtqJa/xdo6mGlZMCJTD2qsCTJ9mfvjYlEKNckCkK8RhkTT3bAdLZl5nqYoo=
X-Gm-Gg: ATEYQzz2tQWBudtjoFV6Xe+vfEo1knsa8+L9UtWel0iV1xPmie79CjQRs4lQxJTpmN5
	Fmlym7996QZqTY0kk2a0s4+kasE4XnuxoZWGJKr1JtAY0pcmzylTXXI6VsXDzEBPL6Qv0qSTcqc
	vriSZKZMPBDNHSIxtwA6fft+yL3LZQSo4J6Kr0J3H+nhSkv2jDhT9RdvsqoPakJ8wkUUB4QZPrU
	lqvAyvEh+SOcRDAc/erze8n/PocynUQKhxWFSXt4RaBmTPrVFwj6r/zHBp5WaQjCvNZX0W9gOaZ
	l/Fy1wcXjyYwo6bjikyxzGGSewkW3fYky7j0TCZzkL1kOGHOnFOdwlsmXlBDsu2WYMxF8D5zs45
	n5dq6SY2Q8lEUdGYN7ybtuby6mDIgRHITws8voEOQe+ggtLAS1FCnxL1De2FgnCrrexxmqlxVET
	BS8NmDuqBJB7euVFpAS7n5OgE=
X-Received: by 2002:a05:6214:4117:b0:899:af01:c2f7 with SMTP id 6a1803df08f44-899d1de4313mr19576376d6.9.1772156554558;
        Thu, 26 Feb 2026 17:42:34 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6fb519sm345530685a.29.2026.02.26.17.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 17:42:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 20:42:33 -0500
Message-Id: <DGPD2HI0C4S2.KBIKCYURS7P@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin
 KaFai Lau" <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for ctx fixed
 offset support
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260227005725.1247305-1-memxor@gmail.com>
 <20260227005725.1247305-3-memxor@gmail.com>
In-Reply-To: <20260227005725.1247305-3-memxor@gmail.com>

On Thu Feb 26, 2026 at 7:57 PM EST, Kumar Kartikeya Dwivedi wrote:
> Add tests to ensure PTR_TO_CTX supports fixed offsets for program types
> that don't rewrite accesses to it. Ensure that variable offsets and
> negative offsets are still rejected. An extra test also checks writing
> into ctx with modified offset for syscall progs. Other program types do
> not support writes (notably, writable tracepoints offer a pointer for a
> writable buffer through ctx, but don't allow writing to the ctx itself).
>
> Before the fix made in the previous commit, these tests do not succeed,
> except the ones testing for failures regardless of the change.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  .../selftests/bpf/progs/verifier_ctx.c        | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/tes=
ting/selftests/bpf/progs/verifier_ctx.c
> index 5ebf7d9bcc55..371780290c0d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> @@ -292,4 +292,80 @@ padding_access("cgroup/post_bind4", bpf_sock, dst_po=
rt, 2);
>  __failure __msg("invalid bpf_context access")
>  padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
> =20
> +SEC("syscall")
> +__description("syscall: write to ctx with fixed offset")
> +__success
> +__naked void syscall_ctx_fixed_off_write(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 0;						\
> +	*(u32*)(r1 + 0) =3D r0;				\
> +	r1 +=3D 4;					\
> +	*(u32*)(r1 + 0) =3D r0;				\
> +	exit;						\
> +"	::: __clobber_all);
> +}
> +
> +/*
> + * Test that program types without convert_ctx_access can dereference
> + * their ctx pointer after adding a fixed offset. Variable and negative
> + * offsets should still be rejected.
> + */
> +#define no_rewrite_ctx_access(type, name, off, ld_op)			\
> +	SEC(type)							\
> +	__description(type ": read ctx at fixed offset")		\
> +	__success							\
> +	__naked void no_rewrite_##name##_fixed(void)			\
> +	{								\
> +		asm volatile ("						\
> +		r1 +=3D %[__off];						\
> +		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> +		r0 =3D 0;							\
> +		exit;"							\
> +		:							\
> +		: __imm_const(__off, off)				\
> +		: __clobber_all);					\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject variable offset ctx access")	\
> +	__failure __msg("variable ctx access var_off=3D")			\
> +	__naked void no_rewrite_##name##_var(void)			\
> +	{								\
> +		asm volatile ("						\
> +		r6 =3D r1;						\
> +		call %[bpf_get_prandom_u32];				\
> +		r1 =3D r6;						\
> +		r0 &=3D 4;						\
> +		r1 +=3D r0;						\
> +		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> +		r0 =3D 0;							\
> +		exit;"							\
> +		:							\
> +		: __imm(bpf_get_prandom_u32)				\
> +		: __clobber_all);					\
> +	}								\
> +	SEC(type)							\
> +	__description(type ": reject negative offset ctx access")	\
> +	__failure __msg("negative offset ctx ptr")			\
> +	__naked void no_rewrite_##name##_neg(void)			\
> +	{								\
> +		asm volatile ("						\
> +		r1 +=3D %[__neg_off];					\
> +		r0 =3D *(" #ld_op " *)(r1 + 0);				\
> +		r0 =3D 0;							\
> +		exit;"							\
> +		:							\
> +		: __imm_const(__neg_off, -(off))			\
> +		: __clobber_all);					\
> +	}
> +
> +no_rewrite_ctx_access("syscall", syscall, 4, u32);
> +no_rewrite_ctx_access("kprobe", kprobe, 8, u64);
> +no_rewrite_ctx_access("tracepoint", tp, 8, u64);
> +no_rewrite_ctx_access("raw_tp", raw_tp, 8, u64);
> +no_rewrite_ctx_access("raw_tracepoint.w", raw_tp_w, 8, u64);
> +no_rewrite_ctx_access("fentry/bpf_modify_return_test", fentry, 8, u64);
> +no_rewrite_ctx_access("cgroup/dev", cgroup_dev, 4, u32);
> +no_rewrite_ctx_access("netfilter", netfilter, offsetof(struct bpf_nf_ctx=
, skb), u64);
> +
>  char _license[] SEC("license") =3D "GPL";

