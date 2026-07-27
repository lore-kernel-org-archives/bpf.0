Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4A3CBE84
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195579; cv=none; b=n52AvHhRv+qwmEIjrO4HLJB1KIl/tppY7XgRO/6aMEMNt4SZ3sT18p5E2fVQCjPy4vI9Ef40kTOOjFDVr6HwhJcKX61QOJqUKVg4X3zbR9tfvWUATHb+bXAlSRPfWGDeLsfau60+7SNPj3PezKPYLYHUNMYsU2aK+K9p7BccSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195579; c=relaxed/simple;
	bh=JVVLC5wl4LtXtJ/BwQmn1pu0mImw4sup1U6+UB6yZms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cfl4PMUBPj9NJTHy6A6z9hWAKr99Icb3vwWSdMlTKZIyCk+usjh7ufo+Rgrxvzt1+p0koIl8TEgFCXEDkcTpykf1O1fuVDIVlnhD+rZo6DxtMH5qlk6MvClEXqQFDT8jpSBGVum/pYVCpudgX09vHgo5lGFb74DrB5Dzy2GVBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grQf84/n; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grQf84/n"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cad4170e8eso49648455ad.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785195578; x=1785800378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BFXfY7XYH2qOGiygfboC6D10GntiV449DP8sqmxx5u8=;
        b=grQf84/niXTnCHDcmrjC5xqs7CCTZrTgIwoZPTsm6fpiqPiek1DjYHWT3kQ7sLUGY8
         ljW7Xxwr2+87lDo6mZk5VjMDBScPnaXLQHU1i0GWatYSfeVUTJ6jZAhV/Jy06NpW2jKF
         231ZloutoWmzJz8wBHdgzLW/fDcqP9vCokBKiXqbPHhTgNKsxtaFtNyWpwW0FCPhaVsH
         FTluTqfp2uYLFfu72dTLDQTdK6mHuytGHuN07Cz2PF+qL9XKOz4IW0EWGcjkyzkGDzAn
         TZzKYw9g9/JJ8Q0UXofowXZdtwsR4VlDPHtpz25UJzWLR3BbDVOtb4uuBOAEJvSegw/J
         d7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195578; x=1785800378;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFXfY7XYH2qOGiygfboC6D10GntiV449DP8sqmxx5u8=;
        b=qak4BpdwwL1YMV19LdgxsqRwdihzvWwXiYRWgFMil8illiDji67mJnr3oTXBHG5LIY
         PToE+Ku7CMKU7jOBOOEke5m/u7SqOmUmr0hObTiPpztXHq8QO84Hb1+zqxvKC1M0a/cn
         wwSt4AXFlnZoY9PRNsHBMVBpJUm8hqLRNiYF3DenQPglWW8dFbdM60rqJ1NYpGnNigk6
         y6jLLd3OQrNfCLmBO9epaPcb2nG6Ap7W647kJbvcbgTiw8iXUmfniYnkGtJdy81Q4FSX
         /Fo2/7ZzMBK/VsF8tnoSAX4BtUKkdpDSrFyY9ltZtsmMMcIcJ489jI3z3d6hngofzD3K
         EvuA==
X-Forwarded-Encrypted: i=1; AHgh+RrSo0G3KakEv6UA5gV9jdluqZk2NhnvLbX4LS6Ybqe1/hhkfEJeRgkzYaAObfim8Rj/s7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26ixFr9bVy0LmiBfCQHgUx72J+LFp2cAZPqQUDXil4lqS/tcy
	N8+Na5k8rF7qtvABppuRNfxt1fbG2NcuZethaT2/0gz0MJCqJOTXtar8
X-Gm-Gg: AR+sD11hZVZvXSouxC03tvmayVydAnOJWOwfMB7QuYLjVCU2itqqjPK7VeR/qFSVPs5
	pLyJaOYZ2nOBvY6CHVl7L5uomgCTFuh85CXq5r49RVTCICerOIImnE2toxRwcTBJONNx/nwtxY8
	suLXQUWRjqztt8azdTyQKZ2i+vXfAFJG4iS0zevUFnd9wyHBwMfylcBKAxTsgckVHsJv/B+ojbZ
	cQr8dpXXKdr2l0ETExXB6Kq5zIAOOK7WHz9DjWoDqcIqsktTRkSZOeYwUDzAPCU76riSgQotOCu
	+liAzCQ1OslWzeAQsJIU6ulfUqXG2wU9hZ7RD3AvCMjUioDVAlhntQ6ZvzlacUAXIg7wf3LFUVh
	/KDE++0lLtB5868N0IMdLC6ac2XHhOk6jg1eWT+SbNbX7nYohB1u6EQEiY1DHRryoRwDsrMKT8z
	Xv/s1BN+3KFZhvaSkSmGDkj7KolZ+b1Q==
X-Received: by 2002:a17:902:d98f:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d015a317a8mr268995ad.8.1785195577789;
        Mon, 27 Jul 2026 16:39:37 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2a78sm43116535ad.26.2026.07.27.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:39:37 -0700 (PDT)
Message-ID: <2fb1dd524daa3d74dcfc007af30f275ed431ce2a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 14/18] bpf: Check helper mem+size in
 ARG_PTR_TO_MEM case
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 16:39:34 -0700
In-Reply-To: <20260724190813.1458271-15-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-15-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:

...

> =C2=A0kernel/bpf/verifier.c | 16 +++++++---------
> =C2=A01 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 144c2d8aa492..2326b12a1531 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8505,9 +8505,6 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
> =C2=A0		meta->subprogno =3D reg->subprogno;
> =C2=A0		break;
> =C2=A0	case ARG_PTR_TO_MEM:
> -		/* The access to this pointer is only checked when we hit the
> -		 * next is_mem_size argument below.
> -		 */
> =C2=A0		if (arg_type & MEM_FIXED_SIZE) {
> =C2=A0			err =3D check_mem_reg(env, reg, argno_from_reg(regno), fn->arg_s=
ize[arg],
> =C2=A0					=C2=A0=C2=A0=C2=A0 arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ=
, meta);
> @@ -8515,14 +8512,15 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> =C2=A0				return err;
> =C2=A0			if (arg_type & MEM_ALIGNED)
> =C2=A0				err =3D check_ptr_alignment(env, reg, 0, fn->arg_size[arg], tru=
e);
> +		} else {
> +			struct bpf_reg_state *size_reg =3D reg_state(env, regno + 1);
> +
> +			err =3D check_mem_size_reg(env, reg, size_reg, argno,
> +						 argno_from_reg(regno + 1),
> +						 arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
> +						 fn->arg_type[arg + 1] & SCALAR_MAYBE_ZERO, meta);
> =C2=A0		}
> =C2=A0		break;
> -	case ARG_MEM_SIZE:

Nit:
The ARG_MEM_SIZE would be ignored by this switch after the change, right?
This is a correct thing to do, but I'd be a little bit more defensive.
Let's modify this switch to:
- explicitly skip ARG_MEM_SIZE
- have default clause signalling a verifier error in case of unknown arg ty=
pe.

> -		err =3D check_mem_size_reg(env, reg_state(env, regno - 1), reg,
> -					 argno_from_reg(regno - 1), argno,
> -					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
> -					 arg_type & SCALAR_MAYBE_ZERO, meta);
> -		break;
> =C2=A0	case ARG_PTR_TO_DYNPTR:
> =C2=A0		err =3D process_dynptr_func(env, reg, argno, insn_idx, arg_type, =
&meta->ref_obj,
> =C2=A0					=C2=A0 &meta->dynptr);
