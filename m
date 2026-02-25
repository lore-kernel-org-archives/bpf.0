Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872824A0C
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771980935; cv=none; b=Ri6DAHFQpnAHLBKXFV/6YMsxBHNqJovwaLZjfJPU2eLefph/qRh0mwmBlxeGcw25jGIILjhZTpYejoKqeTtyTGeJG8ciB3038pL76mbynSuvKzF4cN0/CudmGw0nmnQN1gOpO0vmhdCSHvIL4ivXue3ZktoFV9taYYfPGEMTMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771980935; c=relaxed/simple;
	bh=J2q9YHyy64+JSfd4Bb3Wtesxv3uqGqYI5RYmSkZ1bFg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KI8ScsE6J9goZw+XyE5sBI4QOjL78njfA4Av6WF+DTC2BzPqsdw7Jzl5WtjWVBBdmu4BFZRxGf8FqmrKJSONdxMQRbgvFPQUdNsWJbmqCbR5sIpe9z48Hflaj7Ib8HNBfb+CNUzA3lKHs1TweH7STePryITtYb+HKUsNav6fOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=eiK6Zf9q; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="eiK6Zf9q"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899a5cb04f9so18025396d6.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771980932; x=1772585732; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k14QqCSK8VVl4ULyhdlOmcHbBfRXiBeXPS1reAyIDM=;
        b=eiK6Zf9qOE01NJ18yChwYVkt+zBEil5XIECQKdW534Sse4HqDCmxYxeKTZyE0WOfUb
         mPiMNoQlq9SAf8mOvjCRqsRjuTARvmZLdl9FrhITORHzwtFii9sMrj7Nri/eG8jeIQyH
         bwQ2VuOwRv27UdLueqf1bMXBrKarMu8envqmNqVPHjY2hSoKMpVHA9FVm7/EAq6a47Me
         3jOMOl2X6Ag247zBQRqeIyyV0RT0lXcHD9T8SFs/0lF/19UdNuXRf5brtc+QazKg5YwL
         X6nMVQc78w3uY7B40RrP0IhUFDuDHuu9Vy2GoFGlkOoaVlNlMbMqa1QYMKT13bOuVEPC
         RTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771980932; x=1772585732;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1k14QqCSK8VVl4ULyhdlOmcHbBfRXiBeXPS1reAyIDM=;
        b=tatKo9vu7A0r0uS4tSz3McwoZJK5Vsa6czg4407oNEJcHgyeV7qbs3vDWgeGS1bFxi
         8CTgNq5yYIjY/hqWJUNPRwQQjZfq+8tnkTygwc1Ud0iud2ZIOusV9uiplIgrOQrQdndE
         qoHAhRp6BkTkuAzw02BOiKmO2o+oJ4LprkwbuNpYDgTT1/Z0ccwGy0XnPnkrtPma7JfL
         5WeOX4YBIcHdkufGrH0B8JqZ/6o3T1sjv1wbuPGP9Fqm2P8pbfbHxWbY/8qF/8Xx6uKa
         eBxnqjfP/2nMLgC2a1dNa6yNG+IMrsRXYrcbpZfGn6z1q0E5DMs7kJ6TrP2CqiiTpPLC
         zV1A==
X-Forwarded-Encrypted: i=1; AJvYcCWRsu7QaHOy0MZaQf9FXGu5VeCCyhqrfdhjnD+8iRZ5VkW+ABBJrxp+i3yvX7EWrLJSDpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvo1lT9LW7/iIRllUGVRQC74Jmh9W2/IGSVIEsCpc/FSIkEvq/
	DoO9ni/5HfO9gr+aZxJD1NHXXjxXiqylpf7mzc3Qz9WHg0L0Ypvr27uQhzI9fi8JRIU=
X-Gm-Gg: ATEYQzxUizJzlHul/ZfqiljJ76rtuWosvIiLit4uc7aFjwAd4Nu0DofCQfKdcgCmD4T
	OLupqib/9jHcvHQaOmpZ9xpXwwK/t6pOA2N2jf8FRRhiz4POMN7kAOUbXW5l+93o6boYLYoClFm
	F6aA9iN5fXFSkPAXU1SojOnf5Bu2uQQUvzdWSkmSYCuQOi18i0Ilyg2ib/GqL2k6HrEXFj6q48n
	IK7tkcAlTJE2bPZegFXFgEIGRqpOAdUkAagmRck3q9ZnbhvNB+3G8N5jtMeoU+ZRi6BEbtWtkCP
	3FC4G3ix1RU49Ier/4jCiAI389O2/vizuLkxqj5b7uOjnCxgAtBNUR15tbFxkSHBYa9q+vTC8lp
	v8RLzxLpQwxaksVgxhrqUD475hNr7LC5KceyVNzdlBpDVqZmehJczVdcsYzBotDv/jwmb2ghcts
	NCO8xvCpgBMMcpqLd2FfAY0jQ=
X-Received: by 2002:a05:620a:1990:b0:8b2:2066:ffd3 with SMTP id af79cd13be357-8cb8ca93207mr1753510185a.81.1771980932122;
        Tue, 24 Feb 2026 16:55:32 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d059502sm1149252985a.11.2026.02.24.16.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 16:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 19:55:30 -0500
Message-Id: <DGNMTDCT1502.3936P6LM2E5EP@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow void global functions in the
 verifier
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260223215046.1706110-1-emil@etsalapatis.com>
 <20260223215046.1706110-2-emil@etsalapatis.com>
 <7fcfdf81aa76d816f7b5032d5b8a85302621fe64.camel@gmail.com>
 <DGNEYQZUKR83.25MVGRAQ05NSU@etsalapatis.com>
 <446bbdd8c843340e496c6059d6e1432f1708af59.camel@gmail.com>
 <DGNGEEL4AYE5.3EF1GJDZ1JG9D@etsalapatis.com>
 <e3449e28b1c8d37eb54431668aea7f237c137437.camel@gmail.com>
In-Reply-To: <e3449e28b1c8d37eb54431668aea7f237c137437.camel@gmail.com>

On Tue Feb 24, 2026 at 3:33 PM EST, Eduard Zingerman wrote:
> On Tue, 2026-02-24 at 14:53 -0500, Emil Tsalapatis wrote:
>> On Tue Feb 24, 2026 at 2:02 PM EST, Eduard Zingerman wrote:
>> > On Tue, 2026-02-24 at 13:46 -0500, Emil Tsalapatis wrote:
>> > > On Mon Feb 23, 2026 at 7:09 PM EST, Eduard Zingerman wrote:
>> > > > On Mon, 2026-02-23 at 16:50 -0500, Emil Tsalapatis wrote:
>> > >=20
>> > > Ack on the comments for 2/2. For here:
>> > > >=20
>> > > > [...]
>> > > >=20
>> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> > > > > index 0162f946032f..e997c3776fa7 100644
>> > > > > --- a/kernel/bpf/verifier.c
>> > > > > +++ b/kernel/bpf/verifier.c
>> > > > > @@ -444,6 +444,29 @@ static bool subprog_is_global(const struct =
bpf_verifier_env *env, int subprog)
>> > > > >  	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
>> > > > >  }
>> > > > > =20
>> > > > > +static bool subprog_returns_void(struct bpf_verifier_env *env, =
int subprog)
>> > > > > +{
>> > > > > +	const struct btf_type *type, *func, *func_proto;
>> > > > > +	const struct btf *btf =3D env->prog->aux->btf;
>> > > > > +	u32 btf_id;
>> > > > > +
>> > > > > +	btf_id =3D env->prog->aux->func_info[subprog].type_id;
>> > > > > +
>> > > > > +	func =3D btf_type_by_id(btf, btf_id);
>> > > > > +	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id)=
)
>> > > > > +		return false;
>> > > > > +
>> > > > > +	func_proto =3D btf_type_by_id(btf, func->type);
>> > > > > +	if (verifier_bug_if(!func_proto, env, "btf_id %u not found", f=
unc->type))
>> > > > > +		return false;
>> > > > > +
>> > > > > +	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> > > > > +	if (verifier_bug_if(!type, env, "btf_id %u not found", func_pr=
oto->type))
>> > > > > +		return false;
>> > > > > +
>> > > >=20
>> > > > Nit: I there there are a few unnecessary 'verifier_bug_if()' check=
s here,
>> > > >      e.g. btf.c:btf_check_all_types() guarantees that func->type a=
nd func_proto->type
>> > > >      would be valid.
>> > > >=20
>> > >=20
>> > > Ack, just to make sure I got it right at all the verifier_bug_if() a=
re
>> > > unnecessary. unnecessary because the BTF is already checked. There's=
 no way we
>> > > have an existing type with invalid fields. We also know the subprog =
btf
>> > > ID is valid from check_btf_func_early that happens way before
>> > > do_check_subprogs where subprog_returns_void is used.
>> >=20
>> > Certainly not needed for 'func->type' and 'func_proto->type' access.
>> > For 'func_info[subprog].type_id', idk -- depends on how defensive you
>> > want to be, I'd skip it as well.
>> >=20
>> > >=20
>> > > > > +	return btf_type_is_void(type);
>> > > > > +}
>> > > > > +
>> > > > >  static const char *subprog_name(const struct bpf_verifier_env *=
env, int subprog)
>> > > > >  {
>> > > > >  	struct bpf_func_info *info;
>> > > >=20
>> > > > [...]
>> > > >=20
>> > > > > @@ -17812,6 +17837,16 @@ static int check_return_code(struct bpf=
_verifier_env *env, int regno, const char
>> > > > > =20
>> > > > >  	/* LSM and struct_ops func-ptr's return type could be "void" *=
/
>> > > > >  	if (!is_subprog || frame->in_exception_callback_fn) {
>> > > > > +
>> > > > > +		/*
>> > > > > +		 * If the actual program is an extension, let it
>> > > > > +		 * return void - attaching will succeed only if the
>> > > > > +		 * program being replaced also returns void, and since
>> > > > > +		 * it has passed verification its actual type doesn't matter.
>> > > > > +		 */
>> > > > > +		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && subprog_retur=
ns_void(env, frame->subprogno))
>> > > > > +			return 0;
>> > > > > +
>> > > > >  		switch (prog_type) {
>> > > > >  		case BPF_PROG_TYPE_LSM:
>> > > > >  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>> > > > > @@ -17841,6 +17876,10 @@ static int check_return_code(struct bpf=
_verifier_env *env, int regno, const char
>> > > > >  		default:
>> > > > >  			break;
>> > > > >  		}
>> > > > > +	} else {
>> > > > > +		/* If this is a void global subprog, there is no return value=
. */
>> > > > > +		if (subprog_is_global(env, frame->subprogno) && subprog_retur=
ns_void(env, frame->subprogno))
>> > > > > +			return 0;
>> > > >=20
>> > > > Suppose a global subprogram is verified and it calls bpf_throw().
>> > > > check_return_code() is called from check_kfunc_call() in such case
>> > > > with R1 as a parameter.  This check acts on the return type of the
>> > > > program, will it miss proper return value check for the program?
>> > > >=20
>> > >=20
>> > > Due to the short-circuiting herea a void global program can bpf_thro=
w()=20
>> > > with no issue. This is what we want, correct? The return type we che=
ck=20
>> > > in that case would always be that of the u64 cookie AFAICT.
>> >=20
>> > I mean the following situation:
>> >=20
>> >   SEC(<I want some special return code>)
>> >   int foo(...) {
>> >     ... bar(...) ...;
>> >     return ...;
>> >   }
>> >=20
>> >   // global func
>> >   void bar(...) {=20
>> >     ... bpf_throw(<bad return code>) ...
>> >   }
>> >=20
>> > In this case 'bar' would correspond to 'frame' in the check above and
>> > <bad return code> won't be checked.
>> >=20
>>=20
>> I see, yes this spuriously passes. Since the check_error_code only runs
>> for BPF_EXIT and bpf_throw, can we just check if we're inspecting
>> bpf_throw()'s return value like so?
>>=20
>> bool is_bpf_throw =3D regno =3D=3D BPF_REG_1;
>> ...
>> if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(env=
, frame->subprogno)
>> 	&& !is_bpf_throw)
>> ...
>>=20
>> We only need to use this check in two places in check_error_code
>> to solve the problem. With the fix we can also still throw from
>> void global() functions.
>
> Would it be possible to split check_return_code() in two:
> - check_return_code() that checks program return code
> - check_throw_return_code() with throw specific logic,
>   referring back to check_return_code() if necessary?
>

I will do that, check_return_code will need some refactoring but
the overall code will be cleaner (e.g., the retval_range() calculation
can be factored out into a pure function). I will tack on the patches
with the non-functional changes at the front of this series.

>> > >=20
>> > > > >  	}
>> > > > > =20
>> > > > >  	/* eBPF calling convention is such that R0 is used
>> > > >=20
>> > > > [...]

