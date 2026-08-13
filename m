Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14413F413E
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659663; cv=none; b=PAVaTbqCMFH7M+oQe271cqTxyTHJJR1rtSrRSQX3UomMd/gNAyfO4I/RrpJgk/QlPSTcgdcgWxoe6d/lub98BPH4A082COqeqtsNPghIgj2SGEzbTrFfPY7wC6exqCTdW4YT2foWNO3nnUALUK9RlJD/3boduG+9swYSAPwMBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659663; c=relaxed/simple;
	bh=iZKErpQzI4tDZrpeIQNh/+s3N3EqpIhdMpaciqwacI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTXyaGjG8Jt3hjPMmg1tgxW1aXM+Y87wEK/PzvyeFh7gQeg0ZE0Sv2hWp3tVg/sixvJOYbs4KWJD//eLUSepb/l3tJKYqUMONDM6baM+MF6AjfkY9IcsKjY3PCE7Js3w2IVorOp3dWTGM7ZQiTWc1IRjBtZglssiLmI7/t5hJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne1bpUXx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne1bpUXx"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb7926836eso254032a12.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786659660; x=1787264460; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WepUfyZKcLY19XSoHXGt/PunK9EJ0crkwO9xBirgo0M=;
        b=ne1bpUXxSASuDEsrVklR3a5dq4AWtodLM6o1q0F+XIZU+26vOQCkXGSS+k5jYw/Xij
         3DM06NnUJqiX+QoDR0PLJLvrEdoEFb5d0Gc7Ig4RN51DZZxDWWXNkjcKsNGUeIjjJ5HK
         3o7IzN6Kv7nKdUBOUF8CwtP0FlVdcx0+d9VFNQhivjXaW11JvK2phYCzZt4qVIzOFRjU
         MXcb9iQhUTB8608gAIiT2rrPKPJ4dlwiM+j+SY12zm6oL9SNHfqtlA7zTT7w5Y52xqsZ
         N+AiGZxMMXyw3BC7aQ3Od4kGHPV6stzzL/GdFXnSCDzMaH2jnXyyWp0kplOX+Eiu1sQp
         8tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786659660; x=1787264460;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WepUfyZKcLY19XSoHXGt/PunK9EJ0crkwO9xBirgo0M=;
        b=Yx9ecocAqYR7DQeAKnuSPIc2At8SY0FgKEyyyQvDKSodYVNiTcuV3DG9F9YZwIxjaS
         La9pSYYxTAltMZ9PKEDEU7xU9ZfBc6bIaSWern1DOsQ5Sw/tVmkuiSDjgkFOez02BmJ1
         lmQydJBg1MqY0QsiuXC+WhaDM5hVcI5SLNPFCnZfSuiMROF/r6kvEg+lTHfJJHSrYpbi
         OoAat221UOCU0J+ss0rBD1WAzAtJkCKUignBp6ePbuPbhY+3+jvdkThHkoIvB+hyTSL1
         FYqFhrM+31f0+saSvaU8XZk9qDIDjGmkILhuPRLM8Drcpwiykr+1wat7dIbbfkKwDRUu
         fv5g==
X-Gm-Message-State: AOJu0YyCZWsLctXE68K0/lTP9aVsAJMUOwls63fCA1rDhyz8nHgXK1Sp
	CT1vZ/Virh4xv/chYyclrwEcELZVIvwCQC74900bmmch+gdcMrVba5IY
X-Gm-Gg: AR+sD11nPPjRFFEdRuwxz5V+n4tMeS6KkD8XpA3iluBNER5VVoUDe8IIvntMbD5VQgV
	Pqm4sTet+zEDRuF9fG4LmAauPpzyLSwKsgOzGAc6mcxSnXuLrb1JTY72vktKJpuq1DInk97T0ML
	jfE1hYovfZnLrA62hXDlnpLUc7Dw9YjKfkNl4M5qTfBAYnC9zgdSmAwMRRc2GkGRVDex2xdvDle
	xaxvgIdNYRroGqq/B2G9u25Gf1aeAfc9uTPg8n1HfbgFiYiZi6PFUmwlG1KqhFR8rWrJZh6SvgQ
	mDqEEgvbvdnvNVPDMwWlbflyjeOI0diS7GygHq0Fyzhz0toETCyvi8l69Q2fCBLWQTwDz03mvJh
	N1YARN75wvyhlfRfjfl/x/AEvqDfioYuz5o1kikOa6/nPBi4WZGgvDZQFRu4AjPzrvporBgpukg
	xKwficyMngMq+3Tdr/D1B7/ICp94nlx8YEY3PBcq3Wi2brBK1hM1dFiaoZG1f2wcUEOhwJj+lUd
	q/B1mfCqLWXmGwiay8L3gEGWtFygXmXRoMMWgOfNHwxhg==
X-Received: by 2002:a05:6a21:a0c:b0:3c9:1c1f:f516 with SMTP id adf61e73a8af0-3cc71fa84fbmr1010869637.19.1786659659729;
        Thu, 13 Aug 2026 15:20:59 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2cae:4c28:2903:b6f9? ([2620:10d:c090:500::7:1c5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ac9b1sm2272210c88.2.2026.08.13.15.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:20:58 -0700 (PDT)
Message-ID: <7d608380ec448046a6783c96583cd493ca639a15.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover mixed arena and
 map-value atomics
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi
	 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Thu, 13 Aug 2026 15:20:56 -0700
In-Reply-To: <20260813-bpf-next-038-mixed-atomic-v1-v1-2-e79aadb46a8a@mails.tsinghua.edu.cn>
References: 
	<20260813-bpf-next-038-mixed-atomic-v1-v1-0-e79aadb46a8a@mails.tsinghua.edu.cn>
	 <20260813-bpf-next-038-mixed-atomic-v1-v1-2-e79aadb46a8a@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 12:01 +0000, Yiyang Chen wrote:
> Add a verifier test with one atomic RMW instruction reached through
> PTR_TO_ARENA and PTR_TO_MAP_VALUE paths. The verifier must reject the
> shared instruction with the existing incompatible-pointer diagnostic.
>=20
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  tools/testing/selftests/bpf/progs/verifier_arena.c | 44 ++++++++++++++++=
++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index b241bbcf54a8a..2e43da188194b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -25,6 +25,15 @@ struct {
>  	__ulong(map_extra, ARENA_VM_START); /* start of mmap() region */
>  } arena SEC(".maps");
> =20
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} atomic_map SEC(".maps");

Please use existing arena map.

> +
> +static __u64 arena_atomic_target SEC(".addr_space.1");

The bot is right, verifier_arena tests are failing.
Did you test this patch before sending?

>  SEC("socket")
>  __success __retval(0)
>  int basic_alloc1_nosleep(void *ctx)
> @@ -637,6 +646,41 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
> =20
>  #endif
> =20
> +SEC("socket")
> +__description("arena and map value atomic at the same instruction")
> +__failure __msg("same insn cannot be used with different pointers")
> +__arch_x86_64
> +__load_if_JITed()
> +__naked void mixed_arena_map_value_atomic(void)
> +{
> +	asm volatile ("					\
> +	r1 =3D 0;					\
> +	*(u32 *)(r10 - 4) =3D r1;			\
> +	r2 =3D r10;					\
> +	r2 +=3D -4;					\
> +	r1 =3D %[atomic_map] ll;				\
> +	call %[bpf_map_lookup_elem];			\
> +	if r0 =3D=3D 0 goto 1f;				\
> +	r6 =3D r0;					\
> +	r7 =3D %[arena_atomic_target] ll;			\
> +	.byte 0xbf; .byte 0x77; .short 1; .long 1;	\

Please use __imm_insn, see examples in the test suite.

> +	call %[bpf_get_prandom_u32];			\
> +	if w0 !=3D 0 goto 2f;				\
> +	r8 =3D r6;					\
> +	goto 3f;					\
> +2:	r8 =3D r7;					\
> +3:	r9 =3D 1;					\
> +	lock *(u64 *)(r8 + 0) +=3D r9;			\
> +1:	r0 =3D 0;					\
> +	exit;						\
> +"	:
> +	: __imm_addr(atomic_map),
> +	  __imm_addr(arena_atomic_target),

You can conjure an arena pointer as in non_arena_ptr_add_to_arena_ptr()
w/o the need for the variable.

> +	  __imm(bpf_map_lookup_elem),
> +	  __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  static __noinline
>  u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
>  {

pw-bot: cr.
