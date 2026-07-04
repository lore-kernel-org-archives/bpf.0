Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEBE1D6DA9
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783127883; cv=none; b=hj7Hk2Tf3KileizojerV1X7KoUsK1R41u++0eJk2IXbkyNvL1HU8sDmknU8DTcxA+t9JuQlQHXrW9Vzv40HFfUizXj2bJAcPGsObh52S8RABvIlWkIyvc77V3j0Hag/V07VyocM+I+heuaQ6j2WvytjlYUzfL8I/X3AHaLpN3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783127883; c=relaxed/simple;
	bh=yZx1hGLPqbJpAdk5dS5jA86PkXVweV1zJTsdEMcZt5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVQFsH1exRgPhYlfiN47OZkJ6QTQxecz+6L7472dyHCZ7SP4rN/gMSozuf2Tb/s1oHveIn2rraRRNooFrxsNXMueHOOW6em6PAqb5wgAh/t2RtcmN/7Og77NJ0JNmRw19az0O2gj33tMMPA1sloAlzL4riktINm2VTIRNLtnIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hg42CmfJ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hg42CmfJ"
Message-ID: <f9c2301fbc1f0976a0438d81a8ed694a9b348e5a.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783127870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jc7kJR7OM++klJRkEgQh4iavMNSksDIvCWklV+lvF8=;
	b=hg42CmfJC9/apxlH53DKlWCMqNAKslnGy9o0q+V19VH5LdM28oZCOPhIT7ZrRkPieeDZDu
	uXP0G8VW9hUzj2iyYSQ8bcwnSdwcxu+jA5Oze3TLNKgazzH2+qMv+z2qAdIhGKjlvisPD/
	VRLbXDaC4a1VyuVmsb0VcNUAo5z1Xtk=
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Leon Hwang <leon.hwang@linux.dev>,
  sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Date: Sat, 04 Jul 2026 09:17:45 +0800
In-Reply-To: <c56c20eb-00f9-046e-70a4-261499d0f2ae@loongson.cn>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
	 <20260702143656.28845-2-yangtiezhu@loongson.cn>
	 <20260702145855.07C6B1F000E9@smtp.kernel.org>
	 <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
	 <42e59c6f-5040-4b50-91ce-10066551a32c@linux.dev>
	 <c6aca1e2-1f7a-7e01-62c8-81d0658a20fe@loongson.cn>
	 <ed816369-e1f6-47aa-9532-5f3ccf6d6794@linux.dev>
	 <c56c20eb-00f9-046e-70a4-261499d0f2ae@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2026-07-03 at 23:53 +0800, Tiezhu Yang wrote:
> On 7/3/26 22:14, Leon Hwang wrote:
> > On 2026/7/3 14:59, Tiezhu Yang wrote:
> > [...]
> > > > > ```
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index f496b45b9da4..1f5824c1c691 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -2772,7 +2772,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_=
env
> > > > > *env, u32 func_id, u16 offset)
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0bool bpf_prog_has_kfunc_call(const struct bpf_p=
rog *prog)
> > > > > =C2=A0=C2=A0=C2=A0{
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!prog->aux->kfunc_t=
ab;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return prog->jit_required &=
& !!prog->aux->kfunc_tab;
> > > >=20
> > > >=20
> > > > When 'prog->jit_required' is used for JIT-inlineable helper call, t=
his
> > > > change could also cause false positive for the above pruned kfunc c=
ase.
> > > >=20
> > > > If you don't want bpf_fixup_call_args() rejects the program with -E=
INVAL
> > > > for the pruned kfunc case, suggest moving 'if (!func_id && !offset)=
'
> > > > before the tab allocation in bpf_add_kfunc_call().
> > >=20
> > > How about this:
> > >=20
> > > ```
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 25aea4271cd0..c34cc524651a 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -2770,7 +2770,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
> > > *env, u32 func_id, u16 offset)
> > >=20
> > > =C2=A0=C2=A0bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
> > > =C2=A0=C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!prog->aux->kfunc_tab;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return prog->aux->kfunc_tab && =
prog->aux->kfunc_tab->nr_descs > 0;
> >=20
> >=20
> > NIT: drop '> 0'
> >=20
> > Looks better.
>=20
> OK, will do it in v8.
>=20
> >=20
> > > =C2=A0=C2=A0}
> > >=20
> > > =C2=A0=C2=A0static int add_subprog_and_kfunc(struct bpf_verifier_env =
*env)
> > > ```
> > > IMO, there are no side effects for the following four cases:
> > >=20
> > > 1. Pure JIT-inlined Helper
> > > 2. Pure Pruned kfunc
> > > 3. Pruned kfunc + Inlined Helper
> > > 4. Active (Unpruned) kfunc
> > >=20
> >=20
> > This change allows pruned kfunc + interpreter fallback and pruned kfunc
> > + bpf_fixup_call_args(), when CONFIG_BPF_JIT_ALWAYS_ON is off.
> >=20
> > Does it look like a pre-existing issue?
>=20
> I think so.

no, it's not. for kfunc insn, ->imm means btf_id and ->off leads to fd of b=
tf file.
we replace ->imm to actual address and reject invalid kfunc in bpf_fixup_kf=
unc_call().=20

all pruned kfuncs allowed in bpf_add_kfunc_call() are rejected in bpf_fixup=
_kfunc_call(),=C2=A0before
call bpf_fixup_call_args(), no pruned kfuncs fall back to the interpreter.

I think we can set ->jit_required at the entry of bpf_add_kfunc_call() inst=
ead of end, make less
confusion of AI.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d46f7db20d8f..4f7b43ab3729 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2713,6 +2713,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, =
u32 func_id, u16 offset)
 			return -ENOMEM;
 		prog_aux->kfunc_tab =3D tab;
 	}
+	env->prog->jit_required =3D 1;
=20
 	/* func_id =3D=3D 0 is always invalid, but instead of returning an error,=
 be
 	 * conservative and wait until the code elimination pass before returning

>=20
> >=20
> > Pls read "Support kernel module function calls from eBPF" [1] to
> > understand the background of introducing func_id=3D0 kfunc.
> >=20
> > [1] https://lore.kernel.org/bpf/20211002011757.311265-1-memxor@gmail.co=
m/
> >=20
> > Thanks,
> > Leon
>=20
> Thanks,
> Tiezhu
>=20

--=20
Thanks,
KaFai
