Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E632E730
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771024450; cv=pass; b=hcpUz1xz8vjRUXS+5tgF0LMDOtPpSiRfMM8hBCDQoXXEhDvnavH3KvNZTChuSU4H0tFVZ4ebj7DB3xqOjUmDo7qudyhH7Arhqt1H3mEE2KWCg73N3DuQKU9+ic+6LOh11XTs29ihxQ/SJIi7Gz+hxE/jmeK0iaQ1s8gsuHsALWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771024450; c=relaxed/simple;
	bh=kYt+CrX1/zgRB8QnwTtUyQ3Q3lg1PVj11o76pZ959Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHGsn/3oyWojSeg5z+G4NwHUE/wahvi0pt41AOQbK4C329vmDSl83+IZ98QhHVZSVijaa719TcXeoVj8zRY12nN8uy8u3ug8N2VEqpYXyMZaL8SvfalxXS0Hu5yIb+JJuHkw05eQmW2GMpQjbG8otSM745G6vFPuXqE4qAkf85o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfBrnPbU; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfBrnPbU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43638a3330dso1160933f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 15:14:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771024447; cv=none;
        d=google.com; s=arc-20240605;
        b=RZ1zwau1hDJemNGLKKSR6FGCgJcOcc+DCt8n8OQnMC46XukX5bTubkuRzOUv1fulyE
         PWcppt8dKX7tbsxzfi1ELvnvOy4iO8munkxznCNzM4w2SJGw6GhlAl3tCcQxd95BNKyL
         0LIkYsRj8mzhsSqJLXBTsxAcMVPQJ4eGgDGcHThwOoOd8ABvVKWoWIl+1sr4EwwZq4L7
         ZzmfnBBBWeS5OeRvnwFcSzXy9I/4guV5vQwFP+t+e/LygO6gGDqnfdalkFyD7CnM0Bo3
         UB66AaXf+IM+S1WRCdRlWOa+OsR/SUCSS35TluNh8ADuYmhW9RU5VTTJsJMr3m7iG/Fb
         cL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4/c4OeDcqUD9i2I5GANPZUpVi1/qGS06dPtLs/lHQQ=;
        fh=cYWxAO4hEA81svD5X/DiiNB7a/xE2yZ32mprOvFjECI=;
        b=dedlkB7grnd9OYsGZEiG7btQGAYHHycV92DVoaRhgzdYLTq+ucdKdJqJGpIZmvraxG
         g4aa4YTayGCiXTwSZwHQgHA4BeaBb94QVkBoXrw04/QFcwHuoEgPauIflyF64n43J/QJ
         4K7oepmUJOHPj0prpEo6gLyJuouvmiL40yAbKMcZWjFzw9koTrvTWUqYcC0354xh89rQ
         VkNdiILIwQAkRdABnIPqhbXSnoEAo70xQpXGnofa7tUH0GELWVk32hnoUOVftOfzHSeG
         Z3QXS13TpXlerbeW6klUTSMo8JXe0gsqyV17WYOrPgQqM52TpfLzFy1iyePla7huU1r8
         0UMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771024447; x=1771629247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4/c4OeDcqUD9i2I5GANPZUpVi1/qGS06dPtLs/lHQQ=;
        b=OfBrnPbUrXGTdjoq9aLsRKVC+7jWE7Fboi9dCrvrubCH905BxiJ91NI20caSt2GmAx
         Ra6Aca3X23AHcXPmF2RVAVDRJqr3LbbfPl2K8SSXik29gDPAwTeGTzq8P2DumI0U2Vyw
         Sm+Cp258sAbyH4VZl2VGvgQ/Wc9oVZSPQFSVSvdlb5JN2yc3wdF4JhL9GP7TFxd+Sr25
         l6DEjUCtgMbNSrsbJxgxwUSRcl5a42Nbvjey0jrmzCGaYBcdqZw2cFm4C+PoF0FtJS3l
         34U/VsKiy42x6TsF0hlp6qvmYAujVwtqIp9/1619J6WV1Ho/whKLW+XViktpmAFykrhZ
         oshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771024447; x=1771629247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4/c4OeDcqUD9i2I5GANPZUpVi1/qGS06dPtLs/lHQQ=;
        b=fbBD+26d7JvJiOStbb3ASewRM3ksENH9M1Y+2waE8itOymffwamJX1eDCP8wYqctn+
         fkjRskdfBxrV3LXel/C+6gkAEPGNsoLgbp8G1He1dtHDwCuo82P+DsqvH/K73dVsmgsO
         so/hUrhZ9zXi3RUWGNeCcweIBosieaMBdA6KiME0WExo55QxeULO+hIp2DmjYNHFKbJu
         CwaP794/rHsQ9ay80re116g99Cf0p4A7wRfyzXZukUMDup7WpRlpIUVIoZRRKVYFTmK1
         v1RerHX16/81cIBK5tw/nEwvE+lxt9W+mTUqGvyNUZw1UviIFnJhXW+UR/4PdHj6MMfF
         jPcQ==
X-Gm-Message-State: AOJu0YzxK4Rk5yOiQp877W4zG+BqP15wh+9v0HysTRg0BBA1CcRS6cn3
	dxezi/82YaByFtbyp1jz/vycYZ17NXGmoRgvTbFRBaVjUfYY6kFF/s57sQg0oKGjLwvtB089M9i
	53JINqAmpYE/Gz3fTwModi3+i3+Gntz4=
X-Gm-Gg: AZuq6aJPqr9zne1Qb8ZchE6m2kM7wKg0i0IhCpsn/jtfLv+RzSpj58mcZJiT0XmAfPa
	fVgZknftRaTyt8oK+0DruEulqjhi5GhIyXT/VH9D/CzPcfuBmEmvA2ol6n5iIO8E6hTalf8MUfn
	ChN5fkQd94VYqZZUhPa4EMd5flU6ACIyNMEuxRB5QqciiXZCvXufX1QZRFGvnbIBOeYo8RU0zXN
	Z81weKCgT5vzFhtGu53vJkB/DyOcp6I7p+cZTdDSptlygBK6DSIBY5wHry76ty+DtDpFliwmi1v
	nfXUX3j7wcxFyoz2iL2znR2rz0XDhiHzjeTjVMhFeSCBpcOisaKvp5Hcyu1c7eZb5oj4ZhIDSri
	GhfR1VbCj4jsLsdsrETeX2CfYWw==
X-Received: by 2002:a05:6000:22c9:b0:436:1989:a1ba with SMTP id
 ffacd0b85a97d-4379db31007mr2129250f8f.10.1771024447014; Fri, 13 Feb 2026
 15:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770736390.git.vmalik@redhat.com> <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
 <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com> <CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com>
 <582944ed-ddd6-4843-ba36-b4aed03c5b2f@redhat.com> <CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com>
 <d2706604-1674-49fd-a150-7ace8839657f@redhat.com>
In-Reply-To: <d2706604-1674-49fd-a150-7ace8839657f@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Feb 2026 15:13:56 -0800
X-Gm-Features: AaiRm500opmcMkOPNh1VIWgJSsVt9kx648LgsH3lNotumLbICCojKhQvvACuglU
Message-ID: <CAADnVQLT7cGgExtaqusyk+XwrD=-x15kL0veJB5YPewjPo=PUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Separate tests that need error injection
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jordan Rome <linux@jordanrome.com>, 
	Qais Yousef <qyousef@layalina.io>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 1:22=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 2/12/26 17:35, Alexei Starovoitov wrote:
> > On Wed, Feb 11, 2026 at 11:22=E2=80=AFPM Viktor Malik <vmalik@redhat.co=
m> wrote:
> >>
> >> On 2/12/26 02:42, Alexei Starovoitov wrote:
> >>> On Wed, Feb 11, 2026 at 5:55=E2=80=AFAM Viktor Malik <vmalik@redhat.c=
om> wrote:
> >>>>
> >>>> On 2/11/26 03:42, Alexei Starovoitov wrote:
> >>>>> On Tue, Feb 10, 2026 at 7:14=E2=80=AFAM Viktor Malik <vmalik@redhat=
.com> wrote:
> >>>>>>
> >>>>>> Some enterprise kernels (such as RHEL) do not enable error injecti=
on via
> >>>>>> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRID=
E).
> >>>>>> When running test_progs on such kernels, a lot of test cases fail =
since
> >>>>>> they use sleepable fentry or fmod_ret program types which require =
error
> >>>>>> injection to be enabled. While it is possible to skip these via cu=
stom
> >>>>>> DENYLIST, some test_progs are not properly split into subtests and
> >>>>>> therefore must be entirely skipped.
> >>>>>
> >>>>> Something is wrong.
> >>>>> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> >>>>> -int do_probe_read(void *ctx)
> >>>>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
> >>>>> +int probe_read(void *ctx)
> >>>>>  {
> >>>>>         char buf[8];
> >>>>>
> >>>>> @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
> >>>>>         return 0;
> >>>>>  }
> >>>>>
> >>>>> -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> >>>>> -int do_copy_from_user(void *ctx)
> >>>>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> >>>>>
> >>>>> sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJE=
CTION.
> >>>>
> >>>> I may be missing something but I think it is directly dependent, at
> >>>> least for fentry.
> >>>>
> >>>> In bpf_check_attach_target (kernel/bpf/verifier.c), we have:
> >>>>
> >>>>     if (prog->sleepable) {
> >>>>             ret =3D -EINVAL;
> >>>>             switch (prog->type) {
> >>>>             case BPF_PROG_TYPE_TRACING:
> >>>>
> >>>>                 /* fentry/fexit/fmod_ret progs can be sleepable if t=
hey are
> >>>>                  * attached to ALLOW_ERROR_INJECTION and are not in =
denylist.
> >>>>                  */
> >>>>                 if (!check_non_sleepable_error_inject(btf_id) &&
> >>>>                     within_error_injection_list(addr))
> >>>
> >>> Oh. That's an annoying side effect of disabling error inject.
> >>> fentry progs are not injecting any errors. They just use that
> >>> list as allowlist of good attach points.
> >>> Let's explicitly allow all syscalls here.
> >>
> >> Ok, I'll post a patch.
> >>
> >>>
> >>>>                     ret =3D 0;
> >>>>                 /* fentry/fexit/fmod_ret progs can also be sleepable=
 if they are
> >>>>                  * in the fmodret id set with the KF_SLEEPABLE flag.
> >>>>                  */
> >>>>                 else {
> >>>>                     u32 *flags =3D btf_kfunc_is_modify_return(btf, b=
tf_id,
> >>>>                                         prog);
> >>>>
> >>>>                     if (flags && (*flags & KF_SLEEPABLE))
> >>>>                         ret =3D 0;
> >>>>                 }
> >>>>                 break;
> >>>>             [...]
> >>>>             }
> >>>>             if (ret) {
> >>>>                 module_put(mod);
> >>>>                 bpf_log(log, "%s is not sleepable\n", tname);
> >>>>                 return ret;
> >>>>             }
> >>>>     }
> >>>>
> >>>> If I read that correctly, fentry must be on the error injection list
> >>>> (which is populated by functions marked with ALLOW_ERROR_INJECTION w=
hen
> >>>> CONFIG_FUNCTION_ERROR_INJECTION=3Dy) to be allowed as sleepable.
> >>>>
> >>>> The other branch for fmodret id set seems to be only relevant for
> >>>> kernel modules which explicily register their functions into
> >>>> BTF_KFUNC_HOOK_FMODRET set.
> >>>>
> >>>>> While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
> >>>>>
> >>>>> Both fentry and fentry.s should work fine on sys_nanosleep.
> >>>>> fmod_ret is also completely independent of these two flags.
> >>>>
> >>>> For fmod_ret, we have a very similar code:
> >>>>
> >>>>     } else if (prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN) =
{
> >>>>             [...]
> >>>>             ret =3D -EINVAL;
> >>>>             if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
> >>>>                 !check_attach_modify_return(addr, tname))
> >>>>                 ret =3D 0;
> >>>>             if (ret) {
> >>>>                 module_put(mod);
> >>>>                 bpf_log(log, "%s() is not modifiable\n", tname);
> >>>>                 return ret;
> >>>>             }
> >>>>     }
> >>>>
> >>>> with
> >>>>
> >>>>     static int check_attach_modify_return(unsigned long addr, const =
char *func_name)
> >>>>     {
> >>>>         if (within_error_injection_list(addr) ||
> >>>>             !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PRE=
FIX) - 1))
> >>>
> >>> Same thing here.
> >>> Let's wrap within_error_injection_list() with bpf specific helper
> >>> that in case of !CONFIG_FUNCTION_ERROR_INJECTION
> >>> will allow syscalls anyway.
> >>
> >> I would argue that fmod_ret should remain gated behind
> >> CONFIG_ERROR_INJECTION. It's a similar concept to kprobe override - it
> >> allows to override the execution of the original syscall and return a
> >> custom error code.
> >
> > Definitely not. fmod_ret and error injection are two orthogonal concept=
s.
> > fmod_ret was introduced to be independent of error injection in the
> > first place. fmod_ret is a deliberate spot to allow bpf to change
> > return code
> > in production.
>
> I'm not sure that was the original intention of fmod_ret. Even the
> original patch set mentions that error injection needs to be explicitly
> enabled [1,2]. Changing that is IMHO a significant shift which needs
> discussion.

That discussion already happened when error_injection was forked
as a config flag and went to default N.

>
> > While error injection is a debug feature to stress test the kernel.
> > syscalls are in fmod_ret territory, since this is not debugging
> > and not stressing the kernel. ptrace can change syscall returns without
> > bpf, without fmod_ret, and without error injection.
>
> The thing I'm worried about here is that allowing BPF programs override
> syscalls will esentially allow to implement a BPF-based rootkit. I'm
> well aware that BPF is root-only (although there are ways to allow
> unprivileged users run BPF, such as tokens) but if a potential attacker
> gains root access even for a short time, they can install the rootkit
> which may live unnoticed from that moment. Which is not something we
> really want to enable in production. For ptrace, my understanding is
> that it is significantly easier to detect if it is used.
>
> If you don't mind, I'd start with only allowing sleepable syscalls (when
> error injection is disabled) for now.

I mind and I hate the reasoning that in kernels with error_injection=3Dy
bpf is prone to be a rootkit. This is just a security circus
detached from reality.
