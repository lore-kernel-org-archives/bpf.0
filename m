Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107136E47A
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253312; cv=pass; b=LUcL9eFSSZhqGVMuMkt2opRcafEbJ7Eb4vcWc/47z0AXINlwXwMLyg66B+VqZSGdPowYG3QpZz+xK+kpCkr05CxNgEoQA9501YxXBUAIjQC0bXaIdFzWBjRptSMSIY4h37GffFCJXme6aTNuqp0O8Juvypy2QQnbwhqXPnU4VF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253312; c=relaxed/simple;
	bh=GUFtaxAw8M8F9zmMRYpac2RCtb+oR7+8BionIa+Cflw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efieBNnBLSUwcs8IKB/X2YLt6eJM5z88F4ToPAiVh75RLHaaSjuRPJ4JsdrIi/9mUmZuNqNRtO7KbfHNKnOCVNaH0IMkBQmB6/9dGOwc33z6e0lGv7gb3jA5++XPwofWa8ST3Cd4kFQSyhMquyAnTNkV5k87QqIhb6JA6q7TTo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbgasgUQ; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbgasgUQ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fc4425b6bso34221317b3.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 01:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774253310; cv=none;
        d=google.com; s=arc-20240605;
        b=WhTVaQx/srJT7dpLmWY8HMo7MvWvqrjfSKHreeA4fIuC55SBScSZhVQ1paLuFYHfQC
         3CJnzmEaf+NX/A8PtPvGmj78KB+8XQJUE5FsjW8aVDVwu1Bzh6Lmk2vYaNSe3lSZoG8G
         U7suqUKOcrcc4rOcwTWVWZY9LQpLWYSb7Nu5P7VFvSut4SNDmqgydUa8oFwBClCs7icY
         txrNSylKGhw49/IyIw4DJ5TS9x8e640NZe4fIOAOSiO5rOgIym2ATcjNWYbE2whYiPk0
         QMgvPCiX0vlzdoLdtTHnCmceDgm6IeldHHSv3LB86tPQTBHC78a2b+t0lQTSXMeElTCz
         PTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKOsqFldeivWVY99I9doXJDS2mjmgWeAt9GGNke0S7A=;
        fh=fIxl9SP0nyA5/6nDsUE1VLUVIsl9U6euMiL+hGRFlD8=;
        b=Bk55Yvdpkj1C1M8IXPvb8Wn93AEn9bmcMQkOKYXRvjja8LWsqZXNyt3OAcs8fhH4F4
         jNC3t4FiohVUU1g+IF51988pVJfn/0c7jHV8t9K+mKffK3NG6IsC8OXFHaz21JQHK1X5
         jqGcTRLmiTKuYcixA4k0jy3tvhYWQ/V87eV9Aj4xHbIKZmd3XH7AKwryc6D/lFhxwRN4
         jVsTOPNG6pvLv1Fv9Rk/c+/iTVtqzZiutZthKxn+/sdZEfydrllshMO4sz9IFkikqBAl
         9reauOtdkk2guN6uKzZaO70bJIjBOQxhJUncpl2H7+M+terickhP3/ELTBBWhzqyfMnt
         2Wjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253310; x=1774858110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKOsqFldeivWVY99I9doXJDS2mjmgWeAt9GGNke0S7A=;
        b=KbgasgUQo/bQJQINtaSCal5n9Tlcwda8n+RPShwZ9XkMb7WU2AGAiuUwpdqMdrWmUg
         ZHbe51DV4ZDWV2szgYvmYjQ9AoZSHJu/vcD6iP7WMfsGbu6uIKMohIicFzCZ+OySyv3r
         YnuQP/xVD4b4ksbJn0jdXxQE17V474b7txdf8qTDCL9CPSqESGsR6LkpVxeVi3x6/6pm
         oYnbe/FG8a9p57ITzW4zg3d3Z21y7LVTwdvtKkH5e2ImunMtwBovepbE1Q2PRxWfFspC
         rksXLKtOtiepjnf+6v9fWuzrA4F+z7sgRcVjY+GNUgB0SnOjUhaT0iuonWbN/zTAH6Wr
         WCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253310; x=1774858110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uKOsqFldeivWVY99I9doXJDS2mjmgWeAt9GGNke0S7A=;
        b=fFsaf1aCxRYMghNEDOQ6ox6Q43oMrwmw3P/WCXN9f37nDDTo6CtFeDOjWRhWPPRBko
         HUjt8LyMfHNkSD3s2bvgeNlHxpsRwF0PojTPnvBT6oKBOZ7QjIVWgpgw/iLpmS2P5BoR
         J3KXJ/RK0aY4TTrEKcV1mGbomli1MDCS0wJwvEpc1yI8RTzSqhlkonuGvIJTLh7mvvlN
         wiSMmSZYdmzROrN+62CmavgoW7CmaXlRftuOfvs3HUu0cARb86VB9Ybwg12oxYJ1hdfp
         UD2HTMk+z6A6wp1dvv40wNocsgdBGnr3i1owGbmmKOsi8XQma+Jiax7jA5cKT4hajC7x
         Kx6w==
X-Gm-Message-State: AOJu0YyP0sG8W8UcO11U+YuJQH4o4rjfitAclddT7v8SsLlV1Oy4euEn
	QjxPTm/8UUn4wZTqzd6FObBY/aZ76m8iFLyy/NB6rOyDwTMv60xR8aaPa/m6lppbx0eGv/DPDa/
	V+0/bDwcX0sXijwLld1JstPpUHVzTX1E=
X-Gm-Gg: ATEYQzwxIM10yWGQG056NJjkUG40UMpiJEUcHVk2SnntxRJub0HeHYOm9x/189omZ3w
	221JeAS77IiwaxsfQZXjs2S9aTb6E7Si4rnd/QHwq84qlJqWGkC20hR0+JtO29pGr/DDBQdUYqm
	r18mNPKN0w1FoIyqcY55HM0UEEF+RJd4uu/55RdhhPn/5b/9EP8GGz36Mx145obAp6VSsei4j/4
	bQpbZIpz0XhlX3/wIc4d3DnB7EYVBliZXheS2gavn1+FeJKJ0YP9JaY0olc803PbG3kgpHIlXqW
	8BBfYEN6TKq7ZMPL0iMPiUCCopIwQYLSRH5y54pb7RRKE0IINXKrNbG5XAw=
X-Received: by 2002:a0d:dc07:0:b0:798:5b22:ecb0 with SMTP id
 00721157ae682-79a90b09f20mr82630987b3.22.1774253309891; Mon, 23 Mar 2026
 01:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320074150.628094-1-sun.jian.kdev@gmail.com> <87zf42k3b8.fsf@gmail.com>
In-Reply-To: <87zf42k3b8.fsf@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 23 Mar 2026 16:08:18 +0800
X-Gm-Features: AQROBzA6OOX7Inx6uQ1FL5BimIdPhKIiBQego0N7c8ug70xfbWSZE9b50Lo2xHI
Message-ID: <CABFUUZEW5ecbRJGstkCNsG_B-RA4DNj4-RMGrHtyiTNXp5n-ug@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, shuah@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	paul.chaignon@gmail.com, jolsa@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 10:01=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Sun Jian <sun.jian.kdev@gmail.com> writes:
>
> > trampoline_count fills all trampoline attachment slots for a single
> > target function and verifies that one extra attach fails with -E2BIG.
> >
> > It currently targets bpf_modify_return_test, which is also used by
> > other selftests such as modify_return, get_func_ip_test, and
> > get_func_args_test. When such tests run in parallel, they can contend
> > for the same per-function trampoline quota and cause unexpected attach
> > failures. This issue is currently masked by harness serialization.
> >
> > Move trampoline_count to a dedicated bpf_testmod target and register it
> > for fmod_ret attachment. Also route the final trigger through
> > trigger_module_test_read, so the execution path exercises the  same
> > dedicated target.
> >
> > This keeps the test semantics unchanged while isolating it from other
> > selftests, so it no longer needs to run in serial mode. Remove the
> > TODO comment as well.
> Is it really worth it just for ditching serial mode, does it improve
> test_progs speed? Either way it's worth adding a comment for
> bpf_testmod_trampoline_count_test() explaining that no other test should
> attempt attaching to it.
The main point here is not to speed up test_progs. The trampoline
count limit is a
 per-func, system-wide quota. The purpose of this change is to avoid
contention with
other selftests attaching to the same target function. Allowing this
test to run in parallel
is just a consequence, not the goal, as the TODO comment already indicated.
Adding a short comment is not a bad idea, but
bpf_testmod_trampoline_count_test()
is already fairly self-descriptive.
> >
> > Tested:
> >   ./test_progs -t trampoline_count -vv
> >   ./test_progs -t modify_return -vv
> >   ./test_progs -t get_func_ip_test -vv
> >   ./test_progs -t get_func_args_test -vv
> >   ./test_progs -j$(nproc) -t trampoline_count -vv
> >   ./test_progs -j$(nproc) -t
> >     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,=
\
> > kprobe_multi_test -vv
> >   20 runs of:
> >     ./test_progs -j$(nproc) -t
> >     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,=
\
> > kprobe_multi_test
> >
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> > Link:https://lore.kernel.org/bpf/abicUI4YQ5KkQ_Ro@mail.gmail.com/T/#m62=
53b7fe96fe1a4df65b274c95aac786598a9857
> >
> > v3:
> > - route the final trigger through trigger_module_test_read() and make
> >   bpf_testmod_test_read() call the dedicated trampoline_count target,
> >   as suggested by Jiri
> >
> > v2:
> > - rewrite the subject to describe the change
> > - resend with the correct patch content
> >
> >  .../bpf/prog_tests/trampoline_count.c         | 17 ++++----------
> >  .../bpf/progs/test_trampoline_count.c         |  6 ++---
> >  .../selftests/bpf/test_kmods/bpf_testmod.c    | 23 +++++++++++++++++++
> >  3 files changed, 30 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c =
b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> > index 6cd7349d4a2b..dd2e5c84a4b5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> > @@ -30,16 +30,14 @@ static struct bpf_program *load_prog(char *file, ch=
ar *name, struct inst *inst)
> >       return prog;
> >  }
> >
> > -/* TODO: use different target function to run in concurrent mode */
> > -void serial_test_trampoline_count(void)
> > +void test_trampoline_count(void)
> >  {
> >       char *file =3D "test_trampoline_count.bpf.o";
> >       char *const progs[] =3D { "fentry_test", "fmod_ret_test", "fexit_=
test" };
> > -     int bpf_max_tramp_links, err, i, prog_fd;
> > +     int bpf_max_tramp_links, i;
> >       struct bpf_program *prog;
> >       struct bpf_link *link;
> >       struct inst *inst;
> > -     LIBBPF_OPTS(bpf_test_run_opts, opts);
> >
> >       bpf_max_tramp_links =3D get_bpf_max_tramp_links();
> >       if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
> > @@ -80,17 +78,10 @@ void serial_test_trampoline_count(void)
> >               goto cleanup;
> >
> >       /* and finally execute the probe */
> > -     prog_fd =3D bpf_program__fd(prog);
> > -     if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd"))
> > +     if (!ASSERT_OK(trigger_module_test_read(256),
> > +                    "trigger_module_test_read"))
> >               goto cleanup;
> >
> > -     err =3D bpf_prog_test_run_opts(prog_fd, &opts);
> > -     if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
> > -             goto cleanup;
> > -
> > -     ASSERT_EQ(opts.retval & 0xffff, 33, "bpf_modify_return_test.resul=
t");
> > -     ASSERT_EQ(opts.retval >> 16, 2, "bpf_modify_return_test.side_effe=
ct");
> > -
> >  cleanup:
> >       for (; i >=3D 0; i--) {
> >               bpf_link__destroy(inst[i].link);
> > diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c =
b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> > index 7765720da7d5..14ad2f53cf33 100644
> > --- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> > +++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> > @@ -3,19 +3,19 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> >
> > -SEC("fentry/bpf_modify_return_test")
> > +SEC("fentry/bpf_testmod_trampoline_count_test")
> >  int BPF_PROG(fentry_test, int a, int *b)
> >  {
> >       return 0;
> >  }
> >
> > -SEC("fmod_ret/bpf_modify_return_test")
> > +SEC("fmod_ret/bpf_testmod_trampoline_count_test")
> >  int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
> >  {
> >       return 0;
> >  }
> >
> > -SEC("fexit/bpf_modify_return_test")
> > +SEC("fexit/bpf_testmod_trampoline_count_test")
> >  int BPF_PROG(fexit_test, int a, int *b, int ret)
> >  {
> >       return 0;
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index e62c6b78657f..47583577e021 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > @@ -470,6 +470,8 @@ noinline void bpf_testmod_stacktrace_test_1(void)
> >
> >  int bpf_testmod_fentry_ok;
> >
> > +noinline int bpf_testmod_trampoline_count_test(int a, int *b);
> > +
> >  noinline ssize_t
> >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> >                     const struct bin_attribute *bin_attr,
> > @@ -548,6 +550,10 @@ bpf_testmod_test_read(struct file *file, struct ko=
bject *kobj,
> >                       21, 22, 23, 24, 25, 26) !=3D 231)
> >               goto out;
> >
> > +     i =3D 2;
> > +     if (bpf_testmod_trampoline_count_test(1, &i) !=3D 4 || i !=3D 3)
> > +             goto out;
> > +
> Do we need to add this test for the bpf_testmod_trampoline_count_test(),
> if it's supposed to be used only for the trampoline count test, which
> probably does not care what function actually does internally.
This part was only added to keep the execution path conceptually aligned
with the dedicated target change. As for this and the above comment suggest=
ion,
 I'm fine leaving both to maintainer preference.

Sun Jian
> >       bpf_testmod_stacktrace_test_1();
> >
> >       bpf_testmod_fentry_ok =3D 1;
> > @@ -581,6 +587,12 @@ noinline int bpf_fentry_shadow_test(int a)
> >  }
> >  EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
> >
> > +noinline int bpf_testmod_trampoline_count_test(int a, int *b)
> > +{
> > +     *b +=3D 1;
> > +     return a + *b;
> > +}
> > +
> >  __bpf_hook_end();
> >
> >  static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init =
=3D {
> > @@ -1843,6 +1855,16 @@ struct bpf_struct_ops testmod_multi_st_ops =3D {
> >
> >  extern int bpf_fentry_test1(int a);
> >
> > +BTF_KFUNCS_START(bpf_testmod_trampoline_count_ids)
> > +BTF_ID_FLAGS(func, bpf_testmod_trampoline_count_test)
> > +BTF_KFUNCS_END(bpf_testmod_trampoline_count_ids)
> > +
> > +static const struct
> > +btf_kfunc_id_set bpf_testmod_trampoline_count_fmodret_set =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set =3D &bpf_testmod_trampoline_count_ids,
> > +};
> > +
> >  static int bpf_testmod_init(void)
> >  {
> >       const struct btf_id_dtor_kfunc bpf_testmod_dtors[] =3D {
> > @@ -1859,6 +1881,7 @@ static int bpf_testmod_init(void)
> >       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &=
bpf_testmod_kfunc_set);
> >       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &=
bpf_testmod_kfunc_set);
> >       ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS=
, &bpf_testmod_kfunc_set);
> > +     ret =3D ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampolin=
e_count_fmodret_set);
> >       ret =3D ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_=
testmod_ops);
> >       ret =3D ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_tes=
tmod_ops2);
> >       ret =3D ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_tes=
tmod_ops3);
> >
> > base-commit: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
> > --
> > 2.43.0
