Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A02E62D9
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959758; cv=none; b=HP3KBFRwP0Oqu4RWH83sBek5QUQ+bVDoUn1bxuRQqs5vIVs961a4Nopdb083xiNTOpzASRXgoC8EAcQi0HKqRTA+MMnqv0zAS6BAsAucxQdQWh4qE0d9OrkgYpThJnzW5k/5VPD1MlvPnBJY0WfRyzIgJCn9ist7/dxZ+YEMao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959758; c=relaxed/simple;
	bh=wXudmcdJ9wZKsuXXffS9X8smnNClwy+IVu+Rv8Vet0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=frDmutpt6u2geWO074kKwJQeGjC6cVfyohrCbsUj95V3/S1RUYV5Ph7WjMHSsKSJkdDBoxRvazPDpfVBZDFxSxadJeaZg19kNLhbbpos/kfTE30IX1DxEIJT0rQ6ogk/4DZTkb08yH8e4/6+VT7bol0oUCAeJO0t+G+oPTuwYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIsArgez; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIsArgez"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2baa098ffc6so5296710eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771959757; x=1772564557; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YfRf34eoPRSCmQ5VEU5afmMqWM/ErIUOvmbn2JauAzI=;
        b=aIsArgezZm0oUqVhgAKzmzI8cYX10iihztXCmYjDHmJ+6U6LpC9F8OIh89fc4kXtLm
         sGk8UZ7qVOeah/LJkaTS6H5X9dfnCHJicBtcH+5VJzxTBcCtJsga6yGpr4xbRZkK6Bly
         YFnHC/q863z82PzMwpVkOhksu39Kg1CNerDexpJDiZ92sQQhstO6XL7on8GGJ5sJdqMY
         k/JDoJ5rWu3Khh/n+HFCGKYTOv417DosBSWmIx0KhdDJYFqVpBLn3mTUTSMmQC6bLL+W
         pXswRnKeZgrvcVAilzkBR6fmZErNzI68CzYDo2VgCCSue4ZD7rYiRhw5lRx3/AkLLVNB
         gbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959757; x=1772564557;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfRf34eoPRSCmQ5VEU5afmMqWM/ErIUOvmbn2JauAzI=;
        b=U+BmdO9Vs+jwSOH5wEWWNUJ40/QMEGWsQiMK+X/F6C0n77yb/FH5UJgQHBPritvM0P
         Thv25IED986fYLkQwV/PVnggHRL3avHViX4A8B3ZT/zNBZvFji8bhI1VcRvV38+eXvdy
         x1Wiw9/wCkboLqZxHBlOvSJxdrX06bymfB+d9IfJJpT6KBpn6DPNP43iqWL/xy+jzB6C
         PH5QIAhjq6pg5cTIKFsgP7C5NCd7YWW2QgmwrNwm8l613I9KSPl54YOZxskAy08SmK5Q
         eJOD938Rb7cmEIOh+2ZLGwbvyAFtwGuvmaL7k3YnlpuGXQjGx2UQmp0YaFkE1tsoyi32
         YEgA==
X-Forwarded-Encrypted: i=1; AJvYcCVGNySPCveQaNqaKVoPA5qALBgbSXygXNRy9I2+kyzchjwUCz4b5VAsVOQ20Oh8hHw6gj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyh71N+JfMdq3WIj0DkAOp9b5PbAS2mN3a7lMHyWD2dc4KiHZ1
	8DE/+5lmAaTP7lWH75h4S2lkp6lr6isfjWUUZXIB/MBx4X60PnTgBV65
X-Gm-Gg: ATEYQzzFWJPaNO1zTvOadRKe6R9Vc4I9TEhtuZOFWlBy+LQ4k/3zmxBjr2bLIc3w4Cj
	UskHnrb39y+ajUMeB0dTMhBQd5xahBcu0QW3fxxkZqi7fIxfpOojC7+Ar5RHmGnnOyPZ9VaUoTh
	U2nMOJFTPYYBuTVbRBBY5ERC2Xs8+fg0xaf3vUm4HMb2Xl46aARH/qvRhYohNOTJPqn5a+8D1HL
	GPn1CD0ed9iYEcxm7EUFdBqHRDHA+Cs/pa9zAtInnj9Dslfr0thi1PEzqTstvAEh1DCpZhvrGaq
	Nu5Pa0nvLtJuT5eIGFardHno0At3aF6So9RXy7nETwfss1AJXMesfYM40oUXn3bB8w6/vd/xexP
	KOB6MdYvtyYHGPdtmaL31/9fiXiRM60f0hXxgstqScG744y+aphGyjUS+RCr7CYUrsbESHgCAyo
	+L4VnZejEr2NExRO+UBylatc92yXPGs3wKPoF9nVYw68a/EfJfiUxx2yuBORdXBoK1oe3K4/vZ1
	fri+F9Vo1SwrkjC
X-Received: by 2002:a05:7300:3083:b0:2ba:6d87:cf68 with SMTP id 5a478bee46e88-2bd7bb56653mr5552266eec.16.1771959756589;
        Tue, 24 Feb 2026 11:02:36 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe82desm7946693eec.20.2026.02.24.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:02:36 -0800 (PST)
Message-ID: <446bbdd8c843340e496c6059d6e1432f1708af59.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow void global functions in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
Date: Tue, 24 Feb 2026 11:02:34 -0800
In-Reply-To: <DGNEYQZUKR83.25MVGRAQ05NSU@etsalapatis.com>
References: <20260223215046.1706110-1-emil@etsalapatis.com>
	 <20260223215046.1706110-2-emil@etsalapatis.com>
	 <7fcfdf81aa76d816f7b5032d5b8a85302621fe64.camel@gmail.com>
	 <DGNEYQZUKR83.25MVGRAQ05NSU@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 13:46 -0500, Emil Tsalapatis wrote:
> On Mon Feb 23, 2026 at 7:09 PM EST, Eduard Zingerman wrote:
> > On Mon, 2026-02-23 at 16:50 -0500, Emil Tsalapatis wrote:
>=20
> Ack on the comments for 2/2. For here:
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0162f946032f..e997c3776fa7 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -444,6 +444,29 @@ static bool subprog_is_global(const struct bpf_v=
erifier_env *env, int subprog)
> > >  	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
> > >  }
> > > =20
> > > +static bool subprog_returns_void(struct bpf_verifier_env *env, int s=
ubprog)
> > > +{
> > > +	const struct btf_type *type, *func, *func_proto;
> > > +	const struct btf *btf =3D env->prog->aux->btf;
> > > +	u32 btf_id;
> > > +
> > > +	btf_id =3D env->prog->aux->func_info[subprog].type_id;
> > > +
> > > +	func =3D btf_type_by_id(btf, btf_id);
> > > +	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
> > > +		return false;
> > > +
> > > +	func_proto =3D btf_type_by_id(btf, func->type);
> > > +	if (verifier_bug_if(!func_proto, env, "btf_id %u not found", func->=
type))
> > > +		return false;
> > > +
> > > +	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
> > > +	if (verifier_bug_if(!type, env, "btf_id %u not found", func_proto->=
type))
> > > +		return false;
> > > +
> >=20
> > Nit: I there there are a few unnecessary 'verifier_bug_if()' checks her=
e,
> >      e.g. btf.c:btf_check_all_types() guarantees that func->type and fu=
nc_proto->type
> >      would be valid.
> >=20
>=20
> Ack, just to make sure I got it right at all the verifier_bug_if() are
> unnecessary. unnecessary because the BTF is already checked. There's no w=
ay we
> have an existing type with invalid fields. We also know the subprog btf
> ID is valid from check_btf_func_early that happens way before
> do_check_subprogs where subprog_returns_void is used.

Certainly not needed for 'func->type' and 'func_proto->type' access.
For 'func_info[subprog].type_id', idk -- depends on how defensive you
want to be, I'd skip it as well.

>=20
> > > +	return btf_type_is_void(type);
> > > +}
> > > +
> > >  static const char *subprog_name(const struct bpf_verifier_env *env, =
int subprog)
> > >  {
> > >  	struct bpf_func_info *info;
> >=20
> > [...]
> >=20
> > > @@ -17812,6 +17837,16 @@ static int check_return_code(struct bpf_veri=
fier_env *env, int regno, const char
> > > =20
> > >  	/* LSM and struct_ops func-ptr's return type could be "void" */
> > >  	if (!is_subprog || frame->in_exception_callback_fn) {
> > > +
> > > +		/*
> > > +		 * If the actual program is an extension, let it
> > > +		 * return void - attaching will succeed only if the
> > > +		 * program being replaced also returns void, and since
> > > +		 * it has passed verification its actual type doesn't matter.
> > > +		 */
> > > +		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && subprog_returns_vo=
id(env, frame->subprogno))
> > > +			return 0;
> > > +
> > >  		switch (prog_type) {
> > >  		case BPF_PROG_TYPE_LSM:
> > >  			if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> > > @@ -17841,6 +17876,10 @@ static int check_return_code(struct bpf_veri=
fier_env *env, int regno, const char
> > >  		default:
> > >  			break;
> > >  		}
> > > +	} else {
> > > +		/* If this is a void global subprog, there is no return value. */
> > > +		if (subprog_is_global(env, frame->subprogno) && subprog_returns_vo=
id(env, frame->subprogno))
> > > +			return 0;
> >=20
> > Suppose a global subprogram is verified and it calls bpf_throw().
> > check_return_code() is called from check_kfunc_call() in such case
> > with R1 as a parameter.  This check acts on the return type of the
> > program, will it miss proper return value check for the program?
> >=20
>=20
> Due to the short-circuiting herea a void global program can bpf_throw()=
=20
> with no issue. This is what we want, correct? The return type we check=
=20
> in that case would always be that of the u64 cookie AFAICT.

I mean the following situation:

  SEC(<I want some special return code>)
  int foo(...) {
    ... bar(...) ...;
    return ...;
  }

  // global func
  void bar(...) {=20
    ... bpf_throw(<bad return code>) ...
  }

In this case 'bar' would correspond to 'frame' in the check above and
<bad return code> won't be checked.

>=20
> > >  	}
> > > =20
> > >  	/* eBPF calling convention is such that R0 is used
> >=20
> > [...]
