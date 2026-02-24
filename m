Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064732C94B
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962835; cv=none; b=CbIGvBelUEBgBzX+OMt4H/AvkGlg+ffJdrewf3xJmQuv1xUog83TRew9brYdYQR4N2QB2qbCJ7bNXdFCtWGsfhHXZwm1FXJ6sFyjF9Xvc3J3oORQWVZidLhesZ0GNkvOgE3bQPC8ZU1jdPiShRizar0r58+7STzbNpNDYHE/PDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962835; c=relaxed/simple;
	bh=CCjU8S6lsjGuCMaAsjN16QS01K4Xlt/A0FShrZNssWE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nXktkssGPH1PPue90OBeLS1+oxgYQqvBj3vHezQJ7pry+KmGGBeBWzOe/LaHo53jBnKPiYk2zxGcx0P8vcD7BDxX/61F1yl1BOOgFWnynE7mBzXoTofpf8e1SQ2wdtyOETxFFF35v03fvFHFzUFdpr8ovY3imkyi5KIqTiCDGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=b2M3OGXV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="b2M3OGXV"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb3e0093e3so581308985a.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771962832; x=1772567632; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drEVikMNesExIHat5CzTXNECw/7u3CktgSHrx0htbCk=;
        b=b2M3OGXV0mmUveZtZpSH2nyQgqsAYUnKKZgzgfi7elbA8Ej83KCh9R9/j4F5WiFkoY
         VUG/R5DLkF2gs03dsGGHvbKMULhPBUPSipRUMGdaxXiuLUFXuQx1nsMBbpMNS0io3OKE
         YcUpUJcztQ7LtFmuSY44HU3cHR/pwH+h4Srnvn+j+wwr4hBAIsKofJ1d19djfCDni9r1
         19tVXQJke2umo1DH+ABaXf6xKi5cDa7tCEHhORgRC+wcQ0BVyum9jwM6iOpFmo1mdMeb
         lN+AOx2gSvsb5FOb+83gDNNYEqBmQiy3QeWFiz1gfTLWBmuC7SFMDWin3StK7/Z/bRjD
         tPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771962832; x=1772567632;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drEVikMNesExIHat5CzTXNECw/7u3CktgSHrx0htbCk=;
        b=c1LA4RrHtTkaGfLis2GY/ZEHePwamu65iBX42kw+V4rNkrSNU5oiRYIpcX9P+pmQ9X
         ETFNjsMW5klfgS75VDVBNpTTtCshMNOoaKH71fDum5BQ46rNf6oRVkgbYE8Sf8HgjfUc
         qMHSEHd4xABWz0WJNvGhaUUSM3P3UrH0W97L1AVK9g3G6O1mEP8W4PG8qWrBbXnVcy5l
         52QHdM0vQuim/OPZdSjI04YRqjoT2H/YJ4vLz1v1Qka7pSW6bFGcUw300GmY40wMaGbI
         Eb3kG5XNgodfju2fMp78q3xRURvttKvyY1tuDpStvIWoKMVTHA+rH40IH+GxC06UniKu
         ikTw==
X-Forwarded-Encrypted: i=1; AJvYcCVCg92DaDKQ3koBIxRRqrcXGnjSXs9+pt8yg1ESLcnsdY6sQsh/LorPoOvtFl4PJg/hL8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXlqlQM6DLyrzN2g+ocRHp7RBh4ZMWUG3AxTNHED9cTG7C0gG
	T0FoKkWI4DhKKl2oogaBAlyFE49jvHCrc29WEN+cHgAyd4oz3HfpmzLvpI2Rezd1xBk=
X-Gm-Gg: AZuq6aJ7O8LWrnOd8LTQ/okQEEGwGp0C7UrntM+lRgnIPEmkxJTQbK7QN/I+YF+eKNx
	CsU7jB3VXBXwFmVGQa7k5nQTf1KnAIhv1i5PAfVvDX5eb1legIm3MhWhjXzcEN4xVb0VzzPa+Jn
	4kkfaKisE2kofGT5B6fyuh+DMWNGdhQHHQQPuM/g4MCb7qKHY0YFfI63F3TS/1Ss5R+zEWKV61m
	MYN+TwuL8jSALLF5CAkxNcv2pqyQMS9PYksJWx04UBBXevfQ4aHvKzW0O75boV7KvKlhru7xr8H
	1xbYNOB3WX4fh9vOc1EqQaLCI8x/azsByYwPhSr65pBbPX/0cWY9FAWjVU54c2o4XCQHXmJco58
	brd5RKDL7/d+YTgJK0JINtJGCzKBbV4czA56iFMVJrt3rQP0R8gqzgns2iOCFoRXKE9xJEChdA+
	SH2Vuq5iejhaR64Hm6MTXlLJU=
X-Received: by 2002:a05:620a:28d1:b0:8c6:a213:8fe0 with SMTP id af79cd13be357-8cb8c9fa4abmr1667348885a.23.1771962832091;
        Tue, 24 Feb 2026 11:53:52 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b26ccd43sm8973776d6.50.2026.02.24.11.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 11:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 14:53:50 -0500
Message-Id: <DGNGEEL4AYE5.3EF1GJDZ1JG9D@etsalapatis.com>
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
In-Reply-To: <446bbdd8c843340e496c6059d6e1432f1708af59.camel@gmail.com>

On Tue Feb 24, 2026 at 2:02 PM EST, Eduard Zingerman wrote:
> On Tue, 2026-02-24 at 13:46 -0500, Emil Tsalapatis wrote:
>> On Mon Feb 23, 2026 at 7:09 PM EST, Eduard Zingerman wrote:
>> > On Mon, 2026-02-23 at 16:50 -0500, Emil Tsalapatis wrote:
>>=20
>> Ack on the comments for 2/2. For here:
>> >=20
>> > [...]
>> >=20
>> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> > > index 0162f946032f..e997c3776fa7 100644
>> > > --- a/kernel/bpf/verifier.c
>> > > +++ b/kernel/bpf/verifier.c
>> > > @@ -444,6 +444,29 @@ static bool subprog_is_global(const struct bpf_=
verifier_env *env, int subprog)
>> > >  	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
>> > >  }
>> > > =20
>> > > +static bool subprog_returns_void(struct bpf_verifier_env *env, int =
subprog)
>> > > +{
>> > > +	const struct btf_type *type, *func, *func_proto;
>> > > +	const struct btf *btf =3D env->prog->aux->btf;
>> > > +	u32 btf_id;
>> > > +
>> > > +	btf_id =3D env->prog->aux->func_info[subprog].type_id;
>> > > +
>> > > +	func =3D btf_type_by_id(btf, btf_id);
>> > > +	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
>> > > +		return false;
>> > > +
>> > > +	func_proto =3D btf_type_by_id(btf, func->type);
>> > > +	if (verifier_bug_if(!func_proto, env, "btf_id %u not found", func-=
>type))
>> > > +		return false;
>> > > +
>> > > +	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> > > +	if (verifier_bug_if(!type, env, "btf_id %u not found", func_proto-=
>type))
>> > > +		return false;
>> > > +
>> >=20
>> > Nit: I there there are a few unnecessary 'verifier_bug_if()' checks he=
re,
>> >      e.g. btf.c:btf_check_all_types() guarantees that func->type and f=
unc_proto->type
>> >      would be valid.
>> >=20
>>=20
>> Ack, just to make sure I got it right at all the verifier_bug_if() are
>> unnecessary. unnecessary because the BTF is already checked. There's no =
way we
>> have an existing type with invalid fields. We also know the subprog btf
>> ID is valid from check_btf_func_early that happens way before
>> do_check_subprogs where subprog_returns_void is used.
>
> Certainly not needed for 'func->type' and 'func_proto->type' access.
> For 'func_info[subprog].type_id', idk -- depends on how defensive you
> want to be, I'd skip it as well.
>
>>=20
>> > > +	return btf_type_is_void(type);
>> > > +}
>> > > +
>> > >  static const char *subprog_name(const struct bpf_verifier_env *env,=
 int subprog)
>> > >  {
>> > >  	struct bpf_func_info *info;
>> >=20
>> > [...]
>> >=20
>> > > @@ -17812,6 +17837,16 @@ static int check_return_code(struct bpf_ver=
ifier_env *env, int regno, const char
>> > > =20
>> > >  	/* LSM and struct_ops func-ptr's return type could be "void" */
>> > >  	if (!is_subprog || frame->in_exception_callback_fn) {
>> > > +
>> > > +		/*
>> > > +		 * If the actual program is an extension, let it
>> > > +		 * return void - attaching will succeed only if the
>> > > +		 * program being replaced also returns void, and since
>> > > +		 * it has passed verification its actual type doesn't matter.
>> > > +		 */
>> > > +		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && subprog_returns_v=
oid(env, frame->subprogno))
>> > > +			return 0;
>> > > +
>> > >  		switch (prog_type) {
>> > >  		case BPF_PROG_TYPE_LSM:
>> > >  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>> > > @@ -17841,6 +17876,10 @@ static int check_return_code(struct bpf_ver=
ifier_env *env, int regno, const char
>> > >  		default:
>> > >  			break;
>> > >  		}
>> > > +	} else {
>> > > +		/* If this is a void global subprog, there is no return value. */
>> > > +		if (subprog_is_global(env, frame->subprogno) && subprog_returns_v=
oid(env, frame->subprogno))
>> > > +			return 0;
>> >=20
>> > Suppose a global subprogram is verified and it calls bpf_throw().
>> > check_return_code() is called from check_kfunc_call() in such case
>> > with R1 as a parameter.  This check acts on the return type of the
>> > program, will it miss proper return value check for the program?
>> >=20
>>=20
>> Due to the short-circuiting herea a void global program can bpf_throw()=
=20
>> with no issue. This is what we want, correct? The return type we check=
=20
>> in that case would always be that of the u64 cookie AFAICT.
>
> I mean the following situation:
>
>   SEC(<I want some special return code>)
>   int foo(...) {
>     ... bar(...) ...;
>     return ...;
>   }
>
>   // global func
>   void bar(...) {=20
>     ... bpf_throw(<bad return code>) ...
>   }
>
> In this case 'bar' would correspond to 'frame' in the check above and
> <bad return code> won't be checked.
>

I see, yes this spuriously passes. Since the check_error_code only runs
for BPF_EXIT and bpf_throw, can we just check if we're inspecting
bpf_throw()'s return value like so?

bool is_bpf_throw =3D regno =3D=3D BPF_REG_1;
...
if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(env, f=
rame->subprogno)
	&& !is_bpf_throw)
...

We only need to use this check in two places in check_error_code
to solve the problem. With the fix we can also still throw from
void global() functions.

>>=20
>> > >  	}
>> > > =20
>> > >  	/* eBPF calling convention is such that R0 is used
>> >=20
>> > [...]

