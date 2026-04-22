Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CF2D3EF2
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776895129; cv=none; b=PhH2Dx7JZH757Zk8lDGZXbgocADw6SR3Nc8HgfnV3vU5hzc2L1wp3BdCQE5lAFK3L3dbyti9hPErkSrIqXLUlNEiC5ApHUAKNp9/6nMjRnj9E6ipW4nVb3rdOcMKfSy3Xyg+5R53rkecZrhZlSu9+NW5G8I/QPlAmPQr4UTybOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776895129; c=relaxed/simple;
	bh=5dCq5p//AdZxYuT646BIZAIkb1A2s5GbYwuGRJD2lMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=bvJNEIdG3CC96RYtRyAJ4W0TW+6dR4Hg/eWcASyTn3CupEOY+SyYoEXdQhcVsQcmihk/q/w+oLbmvhJf7nv60JHdAlomPs6tToqLpU6UO0Akd3BpuV/j6XPIorQGDJSXZxrdJcAX+XoFckCN4XMPNG+MJRR4CVtXSCrXVAQvFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DePwgKD3; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DePwgKD3"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479d37e7d7fso1296603b6e.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776895126; x=1777499926; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z51+GoqixlUgEDqC55iwgrP4g3N//ddWg587+ogawVY=;
        b=DePwgKD3fDzbP8tg8VLcdiYCyaaVnHBompT0PVRhfyKtzoYW3sIIBgIBngDxIlEA8g
         SW+Q6LSH6febokzBU+xX8x8nrZtmWvfoTs7E6XC7LtllPzlBG1eQbsMKBjfrjLxJjDlo
         aDVBaEtztNJXlYnE2dHju+pd0yq2Sawd/J1r/DDzbYEYEs47o4jBgnKmsSnoseNigFy5
         iqx0Tj62Y5955cgVzRNshdzmLj8W0z8BTc8n9GKy052d5Ue+r4d/uPL46YJOh9sHAvQN
         LZp2rvGvWMMu2si4x1rwpdVBl3Hus0VfDqnC7GUzCPa+hsbo8NMFFg/vTRJWpUQn5k1U
         JDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776895126; x=1777499926;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z51+GoqixlUgEDqC55iwgrP4g3N//ddWg587+ogawVY=;
        b=V2cnbbHYPdd76yzaTjexLDZFk9iMqdoNqcMzac6PqSCnuO3oF+1CE0IIfxKRVTkZI7
         k/SvvKXfC2ZjWaTWTfd6N2IdHYZINDxVHucIh7dYdMsbwq341kIFRzGMeDaVnpXHMoll
         ollGIejT+9LLrNXbhXoKIlNM7OFy5Y7pdATGlykWssFMkOx3Cn2HwFU0lwy3HCa4m5kt
         r0ApO1/fEv7yFpDhUrG8VMRnhnWZhHRkKLFmwCjeRBDixZD+IFHUM8BXhBr4As31hdC1
         k81i6HYgDEbX5Lpvd4WMwaidd40deqkcupiyQB8fKtWyqKh0kCCE0g/HS2/7f1L3c8Ki
         2suA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xq3Ih4P989V6Y8XfJw9dPJ7wFJz5nJVGTdqs8SwUq8LPObYHORi2H9sZIo5sSIDdJxis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpH89KshQUGyTE0lqvK1O2bPrvW6msLP7kCf06CpbaT9RNJb1/
	7fBfPsr3tJOLgC38iGxVi22fqVVnKUdqrE3dRd4w2SIaRrG18Svj+8AD
X-Gm-Gg: AeBDieuAlWZ4cHOXqE45hEaMzWvaTx01uVGbQt5WRuY11hQ+Lbth/jAERQr1I+i6+nC
	bh/XqNNmbnD3N8r6BVokYVA42FJaUtToBQ3K0XuzmE/NNwlXZYXqN13dx9sAPugK+dpRJnrXkX+
	o6EorGph9cUYUquQvp4UXJ0YIMP6EWoI+puTF4xlYoK0dyuKoVHq/3xB/ZD8DPFP9ubaWX1+RfZ
	IpM6HmaLp8+IKh54gFZ9mVRAZwaUWzv+ym0lqpnyFY7iZV8EIa684EYI8O24iSFz2nbquiZBufn
	BnlNwnx/nV2fKPa5k6rVSf3kKfQhS3vZoQYmM85wCsyb+iUKLBAuEWjL818nGH92tAD6wzltIlj
	n4s+DlJdzmVIwJVtcNodxRgquAgjoNWXGs5pUQ1NCAZOXqh1AIZ/IU1NAsB6Zt3nX5zxGTywbau
	PjxzTsUwSGOM+dlBNXDi0Irr0Hb5FpqP+a2w/pwvHGS+NkhducY9Z5frfNAUiW9vnuVA5Ug2Mic
	kuwI6HcpJcpCdS3tKHLPUBV4HY=
X-Received: by 2002:a05:6808:e645:b0:479:e9d2:26c8 with SMTP id 5614622812f47-479e9d23fc4mr4529946b6e.22.1776895126474;
        Wed, 22 Apr 2026 14:58:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479f3cf40d1sm3791738b6e.12.2026.04.22.14.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 14:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 14:58:45 -0700
Message-Id: <DI00R3E7C8FD.1U98NQCWU1BW4@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bot+bpf-ci@kernel.org>,
 <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <jose.marchesi@oracle.com>, <kernel-team@fb.com>, <martin.lau@kernel.org>,
 <eddyz87@gmail.com>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 7/9] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
X-Mailer: aerc
References: <20260422054224.3127905-1-yonghong.song@linux.dev>
 <25c10a6b1a6f9703f2b2c943ab42245cb9de30d2004eb301d85d9de0ca6ca7b3@mail.kernel.org> <715fcb76-c1ba-44e2-9b6f-e3133f2a5610@linux.dev> <cb70fcff-2e3e-4132-ada7-7af4e8a4ab35@linux.dev>
In-Reply-To: <cb70fcff-2e3e-4132-ada7-7af4e8a4ab35@linux.dev>

On Wed Apr 22, 2026 at 8:37 AM PDT, Yonghong Song wrote:
>
>
> On 4/22/26 7:57 AM, Yonghong Song wrote:
>>
>>
>> On 4/21/26 11:25 PM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/include/linux/bpf_verifier.h=20
>>>> b/include/linux/bpf_verifier.h
>>>> index b148f816f25b..d5b4303315dd 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * e.g., in reg_type_str() to gene=
rate reg_type string
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char tmp_str_buf[TMP_STR_BUF_LEN];
>>>> +=C2=A0=C2=A0=C2=A0 char tmp_arg_name[32];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_insn insn_buf[INSN_BUF_SIZE]=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_insn epilogue_buf[INSN_BUF_S=
IZE];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_scc_callchain callchain_buf;
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index c777a294302a..e7f5f0bb499b 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -261,6 +261,30 @@ struct bpf_kfunc_meta {
>>>>
>>>> =C2=A0 struct btf *btf_vmlinux;
>>>>
>>>> +typedef struct argno {
>>>> +=C2=A0=C2=A0=C2=A0 int argno;
>>>> +} argno_t;
>>>> +
>>>> +static argno_t argno_from_reg(u32 regno)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return (argno_t){ .argno =3D regno };
>>>> +}
>>>> +
>>>> +static argno_t argno_from_arg(u32 arg)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return (argno_t){ .argno =3D -arg };
>>>> +}
>>>> +
>>>> +static int reg_from_argno(argno_t a)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return a.argno >=3D 0 ? a.argno : -1;
>>>> +}
>>>> +
>>>> +static int arg_from_argno(argno_t a)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return a.argno < 0 ? -a.argno : -1;
>>>> +}
>>> [ ... ]
>>>
>>>> @@ -7026,8 +7068,8 @@ static int check_helper_mem_access(struct=20
>>>> bpf_verifier_env *env, struct bpf_reg_
>>>> =C2=A0=C2=A0 */
>>>> =C2=A0 static int check_mem_size_reg(struct bpf_verifier_env *env,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_reg_state *mem_reg=
,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_reg_state *size_reg, u32 mem_r=
egno,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 size_regno, enum bpf_access_type acce=
ss_type,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_reg_state *size_reg, argno_t m=
em_argno,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 argno_t size_argno, enum bpf_access_type=
=20
>>>> access_type,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool zero_size_allowed,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_call_arg_meta *met=
a)
>>>> =C2=A0 {
>>> [ ... ]
>>>
>>>> @@ -7052,31 +7094,31 @@ static int check_mem_size_reg(struct=20
>>>> bpf_verifier_env *env,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta =3D NULL;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size_reg->smin_value < 0) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "R%d min valu=
e is negative, either use=20
>>>> unsigned or 'var &=3D const'\n",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze_regno);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "%s min value=
 is negative, either use unsigned=20
>>>> or 'var &=3D const'\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
g_arg_name(env, size_argno));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size_reg->umin_value =3D=3D 0 && !z=
ero_size_allowed) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "R%d invalid =
zero-sized read: u64=3D[%lld,%lld]\n",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze_regno, size_reg->umin_value, size_reg->umax_value);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "%s invalid z=
ero-sized read: u64=3D[%lld,%lld]\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
g_arg_name(env, size_argno), size_reg->umin_value,=20
>>>> size_reg->umax_value);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size_reg->umax_value >=3D BPF_MAX_V=
AR_SIZ) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "R%d unbounde=
d memory access, use 'var &=3D=20
>>>> const' or 'if (var < const)'\n",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze_regno);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "%s unbounded=
 memory access, use 'var &=3D=20
>>>> const' or 'if (var < const)'\n",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
g_arg_name(env, size_argno));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 err =3D check_helper_mem_access(env, mem_reg, mem_=
regno,=20
>>>> size_reg->umax_value,
>>>> +=C2=A0=C2=A0=C2=A0 err =3D check_helper_mem_access(env, mem_reg, mem_=
argno,=20
>>>> size_reg->umax_value,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acces=
s_type, zero_size_allowed, meta);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!err)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D mark_chain_precisi=
on(env, size_regno);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D mark_chain_precisi=
on(env, reg_from_argno(size_argno));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>> =C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^^^^^^^
>>>
>>> Does mark_chain_precision(env, reg_from_argno(size_argno)) properly=20
>>> handle
>>> kfunc size arguments?
>>>
>>> Before this patch, check_mem_size_reg() was called with size_regno=20
>>> being a
>>> u32 register number. For kfuncs with KF_ARG_PTR_TO_MEM_SIZE, the=20
>>> pre-patch
>>> call at check_kfunc_args was check_kfunc_mem_size_reg(env, reg,=20
>>> size_reg,
>>> regno, regno+1), passing real register numbers like R2..R5.
>>>
>>> After this patch, check_kfunc_args constructs size_argno via
>>> argno_from_arg(i+2) for the size parameter of a KF_ARG_PTR_TO_MEM_SIZE
>>> pair. The argno_from_arg() helper creates a negative encoding (-.argno)=
.
>>> When reg_from_argno(size_argno) is called, it checks a.argno >=3D 0 and
>>> returns -1 for negative values.
>>>
>>> mark_chain_precision(env, -1) then reaches bpf_mark_chain_precision in
>>> backtrack.c, where the "if (regno >=3D 0)" guard causes it to skip mark=
ing
>>> the register, and the subsequent "if (bt_empty(bt)) return 0;" silently
>>> returns success without doing any precision tracking.
>>>
>>> For helpers, this works correctly because check_func_arg calls
>>> check_mem_size_reg with argno_from_reg(regno), which produces a=20
>>> non-negative
>>> encoding that reg_from_argno() correctly extracts back to the register
>>> number.
>>>
>>> Can you verify whether the loss of precision tracking for kfunc size
>>> registers might cause programs that previously verified to hit the
>>> BPF_COMPLEXITY_LIMIT_INSNS threshold? Kfuncs with __sz/__szk size
>>> arguments are widely used in-tree.
>>
>> This is indeed a problem.
>> Function check_mem_size_reg() is the one which does
>> =C2=A0=C2=A0 mark_chain_precision(env, reg_from_argno(size_argno))
>>
>>
>> There are two callers for check_mem_size_reg():
>> =C2=A0=C2=A0 - check_kfunc_mem_size_reg() <- check_kfunc_args
>> =C2=A0=C2=A0=C2=A0=C2=A0 so arg_from_argno() should be used here to get =
the value
>> =C2=A0=C2=A0 - check_func_arg() <- check_helper_call()
>> =C2=A0=C2=A0=C2=A0=C2=A0 in this case, since helper_call is fixed at mos=
t 5 registers,
>> =C2=A0=C2=A0=C2=A0=C2=A0 so argno_from_reg() is used in check_func_arg()=
, so later
>> =C2=A0=C2=A0=C2=A0=C2=A0 on it should use reg_from_argno() should be use=
d to get value.
>>
>> There are two options to fix:
>> =C2=A01. do proper check like
>> =C2=A0=C2=A0=C2=A0 int reg_val =3D reg_from_argno(size_regno);
>> =C2=A0=C2=A0=C2=A0 if (reg_val >=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mark_chain_precision(env, reg_val);
>> =C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mark_chain_precision(env, arg_from_argno(=
size_regno));
>>
>> 2. for arguments in check_helper_call(), we also use
>> =C2=A0=C2=A0 arg_from_argno() instead of reg_from_argno().
>> =C2=A0=C2=A0 This way, we can just do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mark_chain_precision(env, arg_from_argno(=
size_regno));
>>
>> Not sure which is preferred or there are some other better alternatives.
>
> The following should work.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e7f5f0bb499b..2ead411b949d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7112,8 +7112,12 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
>          }
>          err =3D check_helper_mem_access(env, mem_reg, mem_argno, size_re=
g->umax_value,
>                                        access_type, zero_size_allowed, me=
ta);
> -       if (!err)
> -               err =3D mark_chain_precision(env, reg_from_argno(size_arg=
no));
> +       if (!err) {
> +               int regno =3D reg_from_argno(size_argno);
> +
> +               regno =3D regno >=3D 0 ? regno : arg_from_argno(size_argn=
o);
> +               err =3D mark_chain_precision(env, regno);
> +       }

Both options are not great and=20
regno =3D arg >=3D 0 ? arg : reg_from_argno(argno);
in reg_arg_name() points to the same issue.

I think it should be:
static int reg_from_argno(argno_t a)
{
   if (a.argno >=3D 0)
      return a.argno;
   if (a.argno >=3D -MAX_BPF_FUNC_REG_ARGS)
      return -a.argno;
   return -1;
}

whether arg_from_argno() should do similar logic is something to think abou=
t.

