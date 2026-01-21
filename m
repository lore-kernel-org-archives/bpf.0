Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A925EFB6
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960919; cv=none; b=E4n7MUHLUTqmR9Ny0WmLKUO/Dj8/MFv6W5L82ykbTWZA1GJd2F0RFuaAg6rWJwKy48VL+noxzmxdkMERIg6wS0v9gCWjEm2sAigojEyNYeYTMJLNGEcSr8j0/VqJWUo/q/PNTHtVPfHcghM6HVLaewgjiK/onmMcyRy6TpDEPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960919; c=relaxed/simple;
	bh=+4mPt5tnUZrkxhN8YSKTU27Dn3KS3hdqt2JpYbyI6BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8mx7nZjQ37mDXH1ytlYHfvBXFN05orGDEG8P2LvCw6V2ZDA/QBpiwQsd/ad5ZieahVtkF1YjcgGDfYPckwSNWZ0cmDPEN+nmw+/WIdWIVpRA8ZSdBM7o3BCVllQvzkAt8oDvxyuN6fBkP7x1w7K68cd4W1NTBVeoe4282rNDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QrP7+IhS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QrP7+IhS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768960899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vk8bQow5nk5DjEsU2rc41ZIlaqZt/eGd9AP28a6QkM=;
	b=QrP7+IhSQ6rABslfUMQagbFNLm0XmFJBQLTBeT07+ezzRApxVC7+8x+5uGgUM42wtDe52I
	DtpejP7a/1IRDJ+AMnLpMWe8rkyrIi7syhPP8uthMbHn9OxZbJbRFIe6V8yAVzuiChGJlG
	ZNiT+XujARwszV2P3UWcRu+G+k02C3k=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev,
 daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v4 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Date: Wed, 21 Jan 2026 10:01:27 +0800
Message-ID: <22975924.EfDdHjke4D@7940hx>
In-Reply-To:
 <CAEf4BzZUA+5jsYGN7dA1qEXyZKZvBnESX=8fuJHYmhOVm0_QEQ@mail.gmail.com>
References:
 <20260120073046.324342-1-dongml2@chinatelecom.cn>
 <20260120073046.324342-2-dongml2@chinatelecom.cn>
 <CAEf4BzZUA+5jsYGN7dA1qEXyZKZvBnESX=8fuJHYmhOVm0_QEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/21 08:38 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Mon, Jan 19, 2026 at 11:31=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported=
 by
> > the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> > tracepoint, especially for the case that the position of the arguments =
in
> > a tracepoint can change.
> >
> > The target tracepoint BTF type id is specified during loading time,
> > therefore we can get the function argument count from the function
> > prototype instead of the stack.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v4:
> > - fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER
> >
> > v3:
> > - remove unnecessary NULL checking for prog->aux->attach_func_proto
> >
> > v2:
> > - for nr_args, skip first 'void *__data' argument in btf_trace_##name
> >   typedef
> > ---
> >  kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
> >  kernel/trace/bpf_trace.c |  4 ++++
> >  2 files changed, 32 insertions(+), 4 deletions(-)
> >
>=20
> other than stylistical choices, looks good to me
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9de0ec0c3ed9..0b281b7c41eb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23323,8 +23323,20 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                 /* Implement bpf_get_func_arg inline. */
> >                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
> > -                       /* Load nr_args from ctx - 8 */
> > -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_1, -8);
> > +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> > +                               int nr_args =3D btf_type_vlen(prog->aux=
=2D>attach_func_proto);
> > +
> > +                               /*
> > +                                * skip first 'void *__data' argument i=
n btf_trace_##name
> > +                                * typedef
> > +                                */
> > +                               nr_args--;
> > +                               /* Save nr_args to reg0 */
> > +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0=
, nr_args);
> > +                       } else {
> > +                               /* Load nr_args from ctx - 8 */
> > +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF=
_REG_0, BPF_REG_1, -8);
> > +                       }
> >                         insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_=
2, BPF_REG_0, 6);
> >                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_=
2, 3);
> >                         insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_=
2, BPF_REG_1);
> > @@ -23376,8 +23388,20 @@ static int do_misc_fixups(struct bpf_verifier_=
env *env)
> >                 /* Implement get_func_arg_cnt inline. */
> >                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                     insn->imm =3D=3D BPF_FUNC_get_func_arg_cnt) {
> > -                       /* Load nr_args from ctx - 8 */
> > -                       insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, =
BPF_REG_1, -8);
> > +                       if (eatype =3D=3D BPF_TRACE_RAW_TP) {
> > +                               int nr_args =3D btf_type_vlen(prog->aux=
=2D>attach_func_proto);
> > +
> > +                               /*
> > +                                * skip first 'void *__data' argument i=
n btf_trace_##name
> > +                                * typedef
> > +                                */
> > +                               nr_args--;
> > +                               /* Save nr_args to reg0 */
> > +                               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0=
, nr_args);
>=20
> nit: isn't this just a very verbose way of writing:
>=20
> int nr_args =3D btf_type_vlen(prog->aux->attach_func_proto);
> /* skip 'void *__data' in btf_trace_##name() and save to reg0 */
> insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
>=20
> even if you want to preserve nr_args-- for clarity, at least make that
> 4-line comment into a single-line one, please
>=20
> > +                       } else {
> > +                               /* Load nr_args from ctx - 8 */
> > +                               insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF=
_REG_0, BPF_REG_1, -8);
> > +                       }
> >
> >                         new_prog =3D bpf_patch_insn_data(env, i + delta=
, insn_buf, 1);
> >                         if (!new_prog)
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index f73e08c223b5..0efdad3adcce 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1734,10 +1734,14 @@ tracing_prog_func_proto(enum bpf_func_id func_i=
d, const struct bpf_prog *prog)
> >         case BPF_FUNC_d_path:
> >                 return &bpf_d_path_proto;
> >         case BPF_FUNC_get_func_arg:
> > +               if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> > +                       return &bpf_get_func_arg_proto;
> >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ar=
g_proto : NULL;
> >         case BPF_FUNC_get_func_ret:
> >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_re=
t_proto : NULL;
> >         case BPF_FUNC_get_func_arg_cnt:
> > +               if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> > +                       return &bpf_get_func_arg_cnt_proto;
> >                 return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ar=
g_cnt_proto : NULL;
>=20
> hm, wouldn't "has trampoline or is raw_tp" a more logical grouping?
>=20
> if (bpf_prog_has_trampoline(prog) || prog->expected_attach_type =3D=3D
> BPF_TRACE_RAW_TP)
>     return &bpf_get_func_arg_cnt_proto;
> return NULL;
>=20
> maybe you'll need to wrap that condition, but still, at least no one
> has to double check that we return exactly the same prototype in both
> cases, no?

Yeah, it looks better. I tried to write it as:
     return (bpf_prog_has_trampoline(prog) || prog->expected_attach_type =
=3D=3D  BPF_TRACE_RAW_TP) ? &bpf_get_func_arg_cnt_proto : NULL;

but found it ugly.

The way you mentioned looks nice ;)
I'll do it next version.

Thanks!
Menglong Dong

>=20
>=20
> >         case BPF_FUNC_get_attach_cookie:
> >                 if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > --
> > 2.52.0
> >
>=20




