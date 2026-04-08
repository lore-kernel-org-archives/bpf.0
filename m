Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE93B27F6
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644815; cv=none; b=jsvX5z+dNT1P2+vbWfPR8jEQvIuiY7yOqjAWAXCJGgsLAGPCrl5z3wDHj4Y+HW8wsr8KSG5iMT9JsrJ/PxPHEcAX6f/BjPq6sAabM/KIs11hNz2QlZ5bIqsw4UmqkovspzSuEL3d8zjRAfkIbubxM6sucHbiiCEYtK9ASE3/qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644815; c=relaxed/simple;
	bh=xIR7IoxC/PUo+yqsNYp92UtHscgl2+Cd6ol8dKn6Vo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx5uwBmNRrPogheaHvt3+Azsx2FPdGb6Zy6XM219j1+jNUm0KiUobIE9I594dBbIchAGx1kNBGQV5D1wIG/SRJ9I+qustvVZ/XG2Uw7m3mLXvJRr6ynr4lE3kUpo+hgdxpg1rotsj5qV0CCULe6WSHTYdb8YynMJAzNgSo59WRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PkaIM7FS; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PkaIM7FS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775644801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L63z0NHl2S2e/bp+oxmot6ob0zW1fhu5gW81yBi6usc=;
	b=PkaIM7FS6fd7TN0fFWnlxl2GPZmeMGmKlnn8sx/HKRAEQW3Cz4qAp/OgyhPWlukFxz84+v
	vxXKTBoR6WSiScWB58mcDTs8eyYZWDjS0MN76pI159y1yRrpC2t0+UlU8M5zeNtJ9GzZEa
	+zgY79uAzxF0o8T9XR8FRrxQDgXiTN8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Chengkaitao <pilgrimtao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject:
 Re: [PATCH bpf-next 1/3] bpf: add missing fsession to the verifier log
Date: Wed, 08 Apr 2026 18:39:47 +0800
Message-ID: <2405060.ElGaqSPkdT@7940hx>
In-Reply-To:
 <CAAWJmAbhbD68JmFFwL5HLPMVaJyGi1w7hK6t84+DL-snQ+ASmQ@mail.gmail.com>
References:
 <20260408031416.266229-1-dongml2@chinatelecom.cn>
 <20260408031416.266229-2-dongml2@chinatelecom.cn>
 <CAAWJmAbhbD68JmFFwL5HLPMVaJyGi1w7hK6t84+DL-snQ+ASmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/8 17:52 Chengkaitao <pilgrimtao@gmail.com> write:
> On Wed, Apr 8, 2026 at 11:16=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The fsession attach type is missed in the verifier log in
> > check_get_func_ip(), bpf_check_attach_target() and check_attach_btf_id(=
).
> > Update them to make the verifier log proper. Meanwhile, update the
> > corresponding selftests.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/bpf/verifier.c                               | 8 ++++----
> >  tools/testing/selftests/bpf/prog_tests/exceptions.c | 8 ++++----
> >  tools/testing/selftests/bpf/verifier/sleepable.c    | 2 +-
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 594260c1f382..707eaf262307 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> Some comments in bpf_check_attach_target still need to be added or update=
d.

Hi, Kaitao. Thanks for the reviewing.

Right, the comments for fsession are not updated, as I'm not sure if
it worth it. There are around a dozen of comments that we
need to update.

Thanks!
Menglong Dong

>=20
> Reviewed-by: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> > @@ -11757,7 +11757,7 @@ static int check_get_func_ip(struct bpf_verifie=
r_env *env)
> >
> >         if (type =3D=3D BPF_PROG_TYPE_TRACING) {
> >                 if (!bpf_prog_has_trampoline(env->prog)) {
> > -                       verbose(env, "func %s#%d supported only for fen=
try/fexit/fmod_ret programs\n",
> > +                       verbose(env, "func %s#%d supported only for fen=
try/fexit/fsession/fmod_ret programs\n",
> >                                 func_id_name(func_id), func_id);
> >                         return -ENOTSUPP;
> >                 }
> > @@ -25561,7 +25561,7 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
> >         btf =3D tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
> >         if (!btf) {
> >                 bpf_log(log,
> > -                       "FENTRY/FEXIT program can only be attached to a=
nother program annotated with BTF\n");
> > +                       "FENTRY/FEXIT/FSESSION program can only be atta=
ched to another program annotated with BTF\n");
> >                 return -EINVAL;
> >         }
> >         t =3D btf_type_by_id(btf, btf_id);
> > @@ -25686,7 +25686,7 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
> >         case BPF_TRACE_RAW_TP:
> >                 if (tgt_prog) {
> >                         bpf_log(log,
> > -                               "Only FENTRY/FEXIT progs are attachable=
 to another BPF prog\n");
> > +                               "Only FENTRY/FEXIT/FSESSION progs are a=
ttachable to another BPF prog\n");
> >                         return -EINVAL;
> >                 }
> >                 if (!btf_type_is_typedef(t)) {
> > @@ -25952,7 +25952,7 @@ static int check_attach_btf_id(struct bpf_verif=
ier_env *env)
> >         }
> >
> >         if (prog->sleepable && !can_be_sleepable(prog)) {
> > -               verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, up=
robe, and struct_ops programs can be sleepable\n");
> > +               verbose(env, "Only fentry/fexit/fsession/fmod_ret, lsm,=
 iter, uprobe, and struct_ops programs can be sleepable\n");
> >                 return -EINVAL;
> >         }
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tool=
s/testing/selftests/bpf/prog_tests/exceptions.c
> > index 84ab73e08b0e..94a62fcd4543 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> > @@ -128,7 +128,7 @@ static void test_exceptions_success(void)
> >                                        bpf_program__fd(skel->progs.exce=
ption_ext_mod_cb_runtime),
> >                                        "exception_cb_mod"), "set_attach=
_target"))
> >                                 goto done;
> > -               }), "FENTRY/FEXIT programs cannot attach to exception c=
allback", 0);
> > +               }), "FENTRY/FEXIT/FSESSION programs cannot attach to ex=
ception callback", 0);
> >
> >         if (test__start_subtest("throwing fentry -> exception_cb"))
> >                 RUN_EXT(-EINVAL, true, ({
> > @@ -138,7 +138,7 @@ static void test_exceptions_success(void)
> >                                        bpf_program__fd(skel->progs.exce=
ption_ext_mod_cb_runtime),
> >                                        "exception_cb_mod"), "set_attach=
_target"))
> >                                 goto done;
> > -               }), "FENTRY/FEXIT programs cannot attach to exception c=
allback", 0);
> > +               }), "FENTRY/FEXIT/FSESSION programs cannot attach to ex=
ception callback", 0);
> >
> >         if (test__start_subtest("non-throwing fexit -> exception_cb"))
> >                 RUN_EXT(-EINVAL, true, ({
> > @@ -148,7 +148,7 @@ static void test_exceptions_success(void)
> >                                        bpf_program__fd(skel->progs.exce=
ption_ext_mod_cb_runtime),
> >                                        "exception_cb_mod"), "set_attach=
_target"))
> >                                 goto done;
> > -               }), "FENTRY/FEXIT programs cannot attach to exception c=
allback", 0);
> > +               }), "FENTRY/FEXIT/FSESSION programs cannot attach to ex=
ception callback", 0);
> >
> >         if (test__start_subtest("throwing fexit -> exception_cb"))
> >                 RUN_EXT(-EINVAL, true, ({
> > @@ -158,7 +158,7 @@ static void test_exceptions_success(void)
> >                                        bpf_program__fd(skel->progs.exce=
ption_ext_mod_cb_runtime),
> >                                        "exception_cb_mod"), "set_attach=
_target"))
> >                                 goto done;
> > -               }), "FENTRY/FEXIT programs cannot attach to exception c=
allback", 0);
> > +               }), "FENTRY/FEXIT/FSESSION programs cannot attach to ex=
ception callback", 0);
> >
> >         if (test__start_subtest("throwing extension (with custom cb) ->=
 exception_cb"))
> >                 RUN_EXT(-EINVAL, true, ({
> > diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/t=
esting/selftests/bpf/verifier/sleepable.c
> > index 1f0d2bdc673f..c2b7f5ebf168 100644
> > --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> > +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> > @@ -85,7 +85,7 @@
> >         .expected_attach_type =3D BPF_TRACE_RAW_TP,
> >         .kfunc =3D "sched_switch",
> >         .result =3D REJECT,
> > -       .errstr =3D "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and=
 struct_ops programs can be sleepable",
> > +       .errstr =3D "Only fentry/fexit/fsession/fmod_ret, lsm, iter, up=
robe, and struct_ops programs can be sleepable",
> >         .flags =3D BPF_F_SLEEPABLE,
> >         .runs =3D -1,
> >  },
> > --
> > 2.53.0
> >
> >
>=20
>=20
> --=20
> Yours,
> Chengkaitao
>=20




