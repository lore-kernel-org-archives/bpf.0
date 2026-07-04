Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DB33A005
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130253; cv=none; b=DJ5qYq/0/Vja1fhv8qfrILP6tj7kF7iD2J2+hSlSRaPed/7fd0WwEtQBo61hb92Gr5cIUHWr8rG0CCuiFYN70FfzjH3PZq/c/0gyeWNn7fOEPEhDwjit/ZdcRHBXubk/jyykq5yjKg4SEEQqIsLkXYnkT8POyT1ByZmY+WQDFQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130253; c=relaxed/simple;
	bh=b/Fl3aC5TDl3rVrInYX4p9Je0CVczDVjgx74t4I6DRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWn4+WKlIFB/f5eGprjseyPjHjFHwyIftp9OdEGHJ3EWxe/zAFza+j/nPby1nYMR2inRSu3loJJVir4qtGDC9mCfIsbPKOebsRAVT8zZz5Lf6YDzJVnjt0rusjm3tnPsBmekHzHxpZX2iHIx/jXzjWvL37bSp0hPMn2TmgNxnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jI98NDRA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jI98NDRA"
Message-ID: <2240908fb833182e502d1804b392874cccf17b6c.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783130239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/L7gc2Nc7BXcgddL6MtvIXFo01p0bWMICTC+CUAtJw=;
	b=jI98NDRAeG/I7+PlDAK6Rw6ibD9mlglYZ/8eUJQfv0U5P95Y1BrOnljlUrNWukyfFchaq4
	ikiVwBsC+kdwf5ksFEfvtkNIUi7kVsg4NA4khxgdLkfi1E2TS5d2ev8ZIcvGbambAsM9VF
	B2A2ePxqxsFI/5LwxPQA5/KpIjyE9uk=
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Leon Hwang
	 <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	 <bjorn@kernel.org>
Date: Sat, 04 Jul 2026 09:57:10 +0800
In-Reply-To: <2d1babdf-a4d9-9902-77b0-3f5640871323@loongson.cn>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
	 <20260702143656.28845-2-yangtiezhu@loongson.cn>
	 <ba5679e744e0209ca10788c2c385c6727eddb8a5.camel@linux.dev>
	 <2d1babdf-a4d9-9902-77b0-3f5640871323@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Sat, 2026-07-04 at 00:14 +0800, Tiezhu Yang wrote:
> On 7/3/26 21:55, KaFai Wan wrote:
> > On Thu, 2026-07-02 at 22:36 +0800, Tiezhu Yang wrote:
> > > Introduce a 'jit_required' bitfield flag at the end of the
> > > flags group in struct bpf_prog. This bit tracks whether a
> > > program strictly requires the JIT compiler.
> > >=20
> > > Set this flag to 1 when a kfunc call is added at the end of
> > > bpf_add_kfunc_call().
> > >=20
> > > In __bpf_prog_select_runtime(), check with fp->jit_required
> > > rather than bpf_prog_has_kfunc_call() to unify the logic.
> > >=20
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > > =C2=A0=C2=A0include/linux/bpf.h=C2=A0=C2=A0 | 3 ++-
> > > =C2=A0=C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +--
> > > =C2=A0=C2=A0kernel/bpf/verifier.c | 2 ++
> > > =C2=A0=C2=A03 files changed, 5 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index ba09795e0bfd..4e2b059d71f3 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1880,7 +1880,8 @@ struct bpf_prog {
> > > =C2=A0=C2=A0				call_get_func_ip:1, /* Do we call get_func_ip() */
> > > =C2=A0=C2=A0				call_session_cookie:1, /* Do we call bpf_session_cook=
ie() */
> > > =C2=A0=C2=A0				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_t=
ype */
> > > -				sleepable:1;	/* BPF program is sleepable */
> > > +				sleepable:1,	/* BPF program is sleepable */
> > > +				jit_required:1;	/* program strictly requires JIT
> > > compiler
> > > */
> >=20
> > In v6 you're using 'u8 jit_required', I thought it would be 'u8 jit_req=
uired:1', so we use one
> > byte
> > and left 3 byte hole for future use.
> >=20
> > This version left 2 bytes hole, same as v5, but it can easily be mislea=
ding because of the u16
> > type,
> > since we used 17 bits. I prefer v5, it has better readability.
>=20
> OK, I will use the previous layout in v8, like this:
>=20
> ```
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ba09795e0bfd..463fae6a5c33 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1865,8 +1865,9 @@ struct bpf_prog_aux {
>=20
> =C2=A0 struct bpf_prog {
> =C2=A0=C2=A0	u16			pages;		/* Number of allocated pages */
> -	u16			jited:1,	/* Is our filter JIT'ed? */
> +	u32			jited:1,	/* Is our filter JIT'ed? */
> =C2=A0=C2=A0				jit_requested:1,/* archs need to JIT the prog */
> +				jit_required:1, /* program strictly requires JIT compiler */
> =C2=A0=C2=A0				gpl_compatible:1, /* Is filter GPL compatible? */
> =C2=A0=C2=A0				cb_access:1,	/* Is control block accessed? */
> =C2=A0=C2=A0				dst_needed:1,	/* Do we need dst entry? */
> ```
>=20
> >=20
> > > =C2=A0=C2=A0	enum bpf_prog_type	type;		/* Type of BPF program */
> > > =C2=A0=C2=A0	enum bpf_attach_type	expected_attach_type; /* For some p=
rog types */
> > > =C2=A0=C2=A0	u32			len;		/* Number of filter blocks */
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 649cce41e13f..5fcd19ccb41a 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(stru=
ct bpf_verifier_env *env,
> > > struct
> > > =C2=A0=C2=A0	if (fp->bpf_func)
> > > =C2=A0=C2=A0		goto finalize;
> > > =C2=A0=20
> > > -	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> > > -	=C2=A0=C2=A0=C2=A0 bpf_prog_has_kfunc_call(fp))
> > > +	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
> > > =C2=A0=C2=A0		jit_needed =3D true;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	if (!bpf_prog_select_interpreter(fp))
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 25aea4271cd0..f496b45b9da4 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -2765,6 +2765,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env =
*env, u32 func_id, u16
> > > offset)
> > > =C2=A0=C2=A0	desc->func_model =3D func_model;
> > > =C2=A0=C2=A0	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> > > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 kfunc_desc_cmp_by_id_off, NULL)=
;
> > > +
> > > +	env->prog->jit_required =3D 1;
> >=20
> > That's ok, and I think Sashiko is right about this patch.
> >=20
> > > =C2=A0=C2=A0	return 0;
> > > =C2=A0=C2=A0}
>=20
> As discussed in another thread, I will update bpf_prog_has_kfunc_call()
> in v8, like this:
>=20
> ```
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd0..c34cc524651a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2770,7 +2770,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
> *env, u32 func_id, u16 offset)
>=20
> =C2=A0=C2=A0 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
> =C2=A0=C2=A0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!prog->aux->kfunc_tab;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return prog->aux->kfunc_tab && prog=
->aux->kfunc_tab->nr_descs;
> =C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0 static int add_subprog_and_kfunc(struct bpf_verifier_env *en=
v)
> ```
>=20
> IIUC, there are two places to modify so far:
> (1) struct bpf_prog

yes

> (2) bpf_prog_has_kfunc_call()

I think we can remove this func.

actually, I feed your patch to dsv4-pro and gpt-5.4 yesterday, both point o=
ut the we should do this
and change the log message.

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 12a8a4eb757f..7fb92b5fa415 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1378,7 +1378,6 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	struct bpf_prog *prog =3D env->prog;
 	struct bpf_insn *insn =3D prog->insnsi;
-	bool has_kfunc_call =3D bpf_prog_has_kfunc_call(prog);
 	int depth;
 #endif
 	int i, err =3D 0;
@@ -1404,7 +1403,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 			return err;
 	}
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-	if (has_kfunc_call) {
+	if (prog->jit_required) {
 		verbose(env, "calling kernel functions are not allowed in non-JITed prog=
rams\n");
 		return -EINVAL;
 	}

I think we can change the log message for general purpose no just for kunc,=
 so we can know why prog
failed in patch#2 as you test yesterday.

>=20
> If you have any more comments, please let me know.
>=20
> Thanks,
> Tiezhu
>=20

--=20
Thanks,
KaFai
