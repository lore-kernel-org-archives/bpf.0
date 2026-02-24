Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3933A704
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771965209; cv=none; b=ty4sl3hZM3dCtxHFYXOCjPlSAa7cGRUidaootGgTah80FhS4dAw5N15wROspoHv4df7Laj1LsWH8Y+fSS5+M+evn7OXIxO/Qk+7mz2dRODjs5bGQWxZjdpD7ICyDR/l1Hl1bYE7qPZsSGVS/u3wONmsxQ8utlsxtH3F2ga6eVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771965209; c=relaxed/simple;
	bh=nSei2sTBi72yRXtQd1qn70bO+pUaTGJiQ2eERPPjD3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JS/+1LsCbBAuGgqfn8E5Z6CEBczP37W+jWXG22yWyvUlEBEj3+JgNVWsrnuhUBCpRCJ2k4My8UuXwlgP4vij7wVSt0K9IkuurjUPe8Gba6ETuPFrHBv7r+wmMo+B9BrMAK6l5cpBXCGmOR8CPx/nXDqy0DwDg+1keUD9GxhW9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeM5ouqK; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeM5ouqK"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1271195d2a7so3396494c88.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771965207; x=1772570007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLO0Xn5/H66XoaA+8sDLbSztkPH8MCQ26uzeiZ8KbpI=;
        b=TeM5ouqKWvvkHogPXEiWrUwtD3ltaWJxqO9qmEDf3IPbWthoCQbs1hkjemD9qA07gp
         Il8ghEMrjknDPbsh1TGJnBVtvH+AHPkejfIC+RZVVfNEXdq+FlpQKm/Y5gQY3P02J5lE
         o2zxD0pxrSHo2wYdlLzUA0TQ/bJzitKZyyqU6FwmTln50F/NP5EVzhr6BHOgsN/Nghgt
         Di42l3Gf4Mg2tvbCHEAV41JtvJCV+wDuzj9Eb7wWYQCD1uNIXTZ3UraJjpsP+UIFsR85
         S3Zv/eLwtGfkaDb5j7OrERTgcQU8E+5suZzeVbHGfCNGDkDGpwey9ppYMPuUAxF4LsgZ
         0iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771965207; x=1772570007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLO0Xn5/H66XoaA+8sDLbSztkPH8MCQ26uzeiZ8KbpI=;
        b=O8S/oDnpxCyTrjm1kJntZYSL/d1lRUXlVp61VFofttqlOwl8ILOtjoGc8JCb904tEg
         sxM7TatY9o509kE9HaxmszKW4hf9BSpqgy0tWamaMUO8iSjii8IgQQs7gC24HWB21dN6
         KiI/WOYRxkY+4vxQNB5rLbvgrjBEaylAr67CHbGfEEP4byj7BoO+sNl7DyZErkLA4P/H
         f3YrvxHsNMOPOleIhpGb5j3b008kitnSvAOjQhibB+g1/iGGFWPI7dZHP25aoL5r4NYs
         gytUJL/mNh4V3lY1GoaTs5kStbK1BGY0YuSK0mYXdJ14LP5nkJxVGNiP9TXnZ1tRKJmf
         MeaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUibOIetW/YCe5lSvcVsHAk/NtN8sqCKZNjbFFy6ky8cThA25cA+/gmi4gpyu+xsnbOF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEP6I+BnY95T2akw79ahEkiOy8/5jnduyB+kZ/zdatbU6Qi77X
	YdsG2AHJVq3kJCCe0BJVWf7hVq339IrppEJ3J4SROz5Imc3Tv4gXfqMT
X-Gm-Gg: AZuq6aLTvXroKbI5D63ia5WkUreAxs1DZN58djaO1xV8k6f/ZFrRbSZ62c/zKbefIYF
	6PCU1g/h8AqWjtcLLtqWi6w9R8PLWEjGzeZPyASJ2rRcjzPSqXVn/c1K8EhMDpatluOKQ/hJqEY
	Fdtt1sSaAKRyc4wlFfTaVolAI08eYwF9oQvC8qMdAkMqeuhjh4KsBY7Tm7EhndgjKUTUvKEnTOb
	z82LmIwI9mR3r3Z0lagLJ1W8Zzlrx8RvW8r9gNIDExXm+KvwHsgjYsKIvuVebcRjuFHnLvTpVMe
	M4bViITbRnAUn+5BbC6JXK2zx6OyyinmQG44By1BxAb85cyacSbkCLL59Qi5fSWlynfJCdRqLNU
	J69pfA5C4qvI8HCElAhhSrhSyNc4c7pQmCbHgx7cc1h1NwR93IR7anuJyx5eLgsPkMN8rfGZsII
	2LsUmqM7vrMhU91iUoYThoOa+V6DgGJS8DjQmDFnpdtaQQQboPQqswFZ0qQRoNJm3Cc3Q6m5/GD
	qrO5EZytl0BEgDo
X-Received: by 2002:a05:7022:e0d:b0:127:5cfd:785 with SMTP id a92af1059eb24-1276acb3200mr4879358c88.4.1771965206750;
        Tue, 24 Feb 2026 12:33:26 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276afa0bedsm11563053c88.16.2026.02.24.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 12:33:26 -0800 (PST)
Message-ID: <e3449e28b1c8d37eb54431668aea7f237c137437.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow void global functions in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Tue, 24 Feb 2026 12:33:24 -0800
In-Reply-To: <DGNGEEL4AYE5.3EF1GJDZ1JG9D@etsalapatis.com>
References: <20260223215046.1706110-1-emil@etsalapatis.com>
	 <20260223215046.1706110-2-emil@etsalapatis.com>
	 <7fcfdf81aa76d816f7b5032d5b8a85302621fe64.camel@gmail.com>
	 <DGNEYQZUKR83.25MVGRAQ05NSU@etsalapatis.com>
	 <446bbdd8c843340e496c6059d6e1432f1708af59.camel@gmail.com>
	 <DGNGEEL4AYE5.3EF1GJDZ1JG9D@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 14:53 -0500, Emil Tsalapatis wrote:
> On Tue Feb 24, 2026 at 2:02 PM EST, Eduard Zingerman wrote:
> > On Tue, 2026-02-24 at 13:46 -0500, Emil Tsalapatis wrote:
> > > On Mon Feb 23, 2026 at 7:09 PM EST, Eduard Zingerman wrote:
> > > > On Mon, 2026-02-23 at 16:50 -0500, Emil Tsalapatis wrote:
> > >=20
> > > Ack on the comments for 2/2. For here:
> > > >=20
> > > > [...]
> > > >=20
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 0162f946032f..e997c3776fa7 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -444,6 +444,29 @@ static bool subprog_is_global(const struct b=
pf_verifier_env *env, int subprog)
> > > > >  	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
> > > > >  }
> > > > > =20
> > > > > +static bool subprog_returns_void(struct bpf_verifier_env *env, i=
nt subprog)
> > > > > +{
> > > > > +	const struct btf_type *type, *func, *func_proto;
> > > > > +	const struct btf *btf =3D env->prog->aux->btf;
> > > > > +	u32 btf_id;
> > > > > +
> > > > > +	btf_id =3D env->prog->aux->func_info[subprog].type_id;
> > > > > +
> > > > > +	func =3D btf_type_by_id(btf, btf_id);
> > > > > +	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
> > > > > +		return false;
> > > > > +
> > > > > +	func_proto =3D btf_type_by_id(btf, func->type);
> > > > > +	if (verifier_bug_if(!func_proto, env, "btf_id %u not found", fu=
nc->type))
> > > > > +		return false;
> > > > > +
> > > > > +	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
> > > > > +	if (verifier_bug_if(!type, env, "btf_id %u not found", func_pro=
to->type))
> > > > > +		return false;
> > > > > +
> > > >=20
> > > > Nit: I there there are a few unnecessary 'verifier_bug_if()' checks=
 here,
> > > >      e.g. btf.c:btf_check_all_types() guarantees that func->type an=
d func_proto->type
> > > >      would be valid.
> > > >=20
> > >=20
> > > Ack, just to make sure I got it right at all the verifier_bug_if() ar=
e
> > > unnecessary. unnecessary because the BTF is already checked. There's =
no way we
> > > have an existing type with invalid fields. We also know the subprog b=
tf
> > > ID is valid from check_btf_func_early that happens way before
> > > do_check_subprogs where subprog_returns_void is used.
> >=20
> > Certainly not needed for 'func->type' and 'func_proto->type' access.
> > For 'func_info[subprog].type_id', idk -- depends on how defensive you
> > want to be, I'd skip it as well.
> >=20
> > >=20
> > > > > +	return btf_type_is_void(type);
> > > > > +}
> > > > > +
> > > > >  static const char *subprog_name(const struct bpf_verifier_env *e=
nv, int subprog)
> > > > >  {
> > > > >  	struct bpf_func_info *info;
> > > >=20
> > > > [...]
> > > >=20
> > > > > @@ -17812,6 +17837,16 @@ static int check_return_code(struct bpf_=
verifier_env *env, int regno, const char
> > > > > =20
> > > > >  	/* LSM and struct_ops func-ptr's return type could be "void" */
> > > > >  	if (!is_subprog || frame->in_exception_callback_fn) {
> > > > > +
> > > > > +		/*
> > > > > +		 * If the actual program is an extension, let it
> > > > > +		 * return void - attaching will succeed only if the
> > > > > +		 * program being replaced also returns void, and since
> > > > > +		 * it has passed verification its actual type doesn't matter.
> > > > > +		 */
> > > > > +		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && subprog_return=
s_void(env, frame->subprogno))
> > > > > +			return 0;
> > > > > +
> > > > >  		switch (prog_type) {
> > > > >  		case BPF_PROG_TYPE_LSM:
> > > > >  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> > > > > @@ -17841,6 +17876,10 @@ static int check_return_code(struct bpf_=
verifier_env *env, int regno, const char
> > > > >  		default:
> > > > >  			break;
> > > > >  		}
> > > > > +	} else {
> > > > > +		/* If this is a void global subprog, there is no return value.=
 */
> > > > > +		if (subprog_is_global(env, frame->subprogno) && subprog_return=
s_void(env, frame->subprogno))
> > > > > +			return 0;
> > > >=20
> > > > Suppose a global subprogram is verified and it calls bpf_throw().
> > > > check_return_code() is called from check_kfunc_call() in such case
> > > > with R1 as a parameter.  This check acts on the return type of the
> > > > program, will it miss proper return value check for the program?
> > > >=20
> > >=20
> > > Due to the short-circuiting herea a void global program can bpf_throw=
()=20
> > > with no issue. This is what we want, correct? The return type we chec=
k=20
> > > in that case would always be that of the u64 cookie AFAICT.
> >=20
> > I mean the following situation:
> >=20
> >   SEC(<I want some special return code>)
> >   int foo(...) {
> >     ... bar(...) ...;
> >     return ...;
> >   }
> >=20
> >   // global func
> >   void bar(...) {=20
> >     ... bpf_throw(<bad return code>) ...
> >   }
> >=20
> > In this case 'bar' would correspond to 'frame' in the check above and
> > <bad return code> won't be checked.
> >=20
>=20
> I see, yes this spuriously passes. Since the check_error_code only runs
> for BPF_EXIT and bpf_throw, can we just check if we're inspecting
> bpf_throw()'s return value like so?
>=20
> bool is_bpf_throw =3D regno =3D=3D BPF_REG_1;
> ...
> if (subprog_is_global(env, frame->subprogno) && subprog_returns_void(env,=
 frame->subprogno)
> 	&& !is_bpf_throw)
> ...
>=20
> We only need to use this check in two places in check_error_code
> to solve the problem. With the fix we can also still throw from
> void global() functions.

Would it be possible to split check_return_code() in two:
- check_return_code() that checks program return code
- check_throw_return_code() with throw specific logic,
  referring back to check_return_code() if necessary?

> > >=20
> > > > >  	}
> > > > > =20
> > > > >  	/* eBPF calling convention is such that R0 is used
> > > >=20
> > > > [...]
