Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625541D6DA9
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770860592; cv=pass; b=f6uc5zjs72XwG98vROcFwzyBPW3fm5dYLGY3aFglcHAZoS/EvICUHbYMciWiCmH3n3gFraItCM47FWPKdVlsfaChqHMIx8liDoZRyLJtAsaN5g0KVMUYaGHMIMdpF4vIYDOCyjlUs6L8A9Sc5wQ8UOMwsctF/8f527YO4XNEmLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770860592; c=relaxed/simple;
	bh=NZT+GO2XJ3y87Hl8F1Wzv/VcZcdeOwzcQnx3S4TrXtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHt0wRxP69Ck7u9Q6uUqMMVekQbwcwfSch1tut9vN/wh0owXDIUfYuK/KPr9cZXSban/+pP9p6Dt41c7JrMDz33GaDNk1u4RtJNvoBEZZs6FbSLN/Eoa36HIyyFDfFQyhG3x4kIUSKg+4mmhf9riHBcHVo1E3WdcGyBYfXsmplQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxFrP+oG; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxFrP+oG"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-437711e9195so2860148f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 17:43:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770860590; cv=none;
        d=google.com; s=arc-20240605;
        b=F46Z8uGJbzcathJ2wgqu0isZwutPQpBYGReMhNGbmKBbLNxmzfd/415ukauKFR/jBA
         QKJyr2mU6eYXLd+vJlWpbhUnvogT5RpYgqnRQQ2WYVGHYXD6z4TnZeBHqqe8GNlW9XIY
         HHjhjh8zA3pWrTui9LMrsXAyV0dr+XIM7s3p+XxSPHcSl1JfS3WvqSxLOTWo/i3dHnju
         zNe+1oH46AmvzFEHflyx97xqGPIKWVFXr04c0H+LFAAgB8JVakfY+/ECXH9r+MbTMENm
         Wbbboev+CRZbxXrLmD0Fp19q/6eKIPdtuGcl8Rix51gkmp3Y55V763ZVlLDSYHtqsjVR
         Z+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsGPPBHLumw6Xn3i+431WdG0RmWVttXI/r+yU5JenzM=;
        fh=cYWxAO4hEA81svD5X/DiiNB7a/xE2yZ32mprOvFjECI=;
        b=bFBoQG3QS/L8lSKv0S99YdXGCuIHVZaaru4TsvgWQFwrqK0FwdV6F4HsCEPTHIWZJT
         UTmB3xplJTR/2uI27XjYob46G2Nx4RU4v41XeLe0HdhYMZBmUV8FT4MO6fQxXT5in4/9
         GGfud+YufD2vVsjMqA1zg7Vj+HMquNgFt1j8o9Bl3CaQSuIl0zA8uEjCvATDhTUirJvU
         7X6GnceqRMi5uSCeNnpNUIp+rAT1mEutU4dqLMooJFxveNinwV471ZBTyNbcdSHJhq23
         WjoNDxDNBPuAIR5CWaQ2zBwAaXe2zt1cmarnCNhMDOLWlFhsLfL5sjr/XekoP2KuAHyS
         KfHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770860590; x=1771465390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsGPPBHLumw6Xn3i+431WdG0RmWVttXI/r+yU5JenzM=;
        b=dxFrP+oGy70ccYYfdK0XraSqZw8OXJTUF4tD0qaqiX3GdzbKUMKBun3MG1T98vj2CL
         DIJFgxUl6ufyEssqD/sVfYpAZBGe+yMVbrzabUB2gqu7Tx/zrbVGqJouy0jyEghDe3pL
         bYtalF1hEHc7n9lWBs1SC0V4nAukpbhV7xX4fUAFBLVa3WSLOJaVSHeFimcyWZMJzI0F
         cWkOzDPc0YwRlrcYeBqW/YceyqU/aUBEdHitVj4eNH4yS0UKf/QylLI6eXUFJ3piMoPH
         iq4rsBmy7J+a9IxNfcXItZr8Uklnsid8VFmOZkzlEN6EvhyY260auA/zGS2xa5bWcA8K
         hXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770860590; x=1771465390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rsGPPBHLumw6Xn3i+431WdG0RmWVttXI/r+yU5JenzM=;
        b=GBIexeL5wrsLu7a2Zzhv69vjJ5E2jrwWaUPe0xyiVeWUWSj1xqoRZL9rZuUzh2Uv4a
         KXA+KGjFVfE17y1Tt3UADZynTyEfU9EWfY/Ua0rxp6phzGc+/5F3jlzlBsTb34/FhwMa
         hev7ISOuMhIVGx4fXZUrPnEps0kT6wKWv5Zp7JktpFKeQYf159ahhuTJqqC/E9nGkWGs
         ri7zyOdyCYdOzN2pozA3P8tgFabph4nFMc5eFpFBHayNZblS/qqah458ugLx4TIqoL2T
         W9O2ltorplQlpKwNtly1Ik/PgxgkVOyMfyEgqNHxwWWHplxEYbM/8tMnIBllInTjJG23
         w8tQ==
X-Gm-Message-State: AOJu0Yw1B1OERElV23dn6kCtvzhQ5AToPxyNPaViVZMwJS/1SliILD+P
	aU7baJxTNa2mmQLQCndkJRTLm/ROfFEnkKP1o3xBkMYT8Z7PsVEZcoH2tZ6817qbeGK/S45sx7r
	SzPvZj6aGQIaWfeMZKdC8oeBUfPXGKLLkP0tr
X-Gm-Gg: AZuq6aI5d+8/vo3g7OtGtTsWuuxtVLkMQ5fFXZVU/q7BMjzGWVGa0t0pvnenI3MHPVo
	7Ke8mpAvTt2n8PRfzCdrTpIpWqTPKNELPu8GHxOyIRDvQv2M4AQbl82/bZpNEq7YFf8fkGJ6j9s
	Y1Hatga4FtkPxASdKFjkswNSlW7wMH/kMecQGbv3JRqzLFtREogN1CkTRZPiz0TZS3DNVwYbVIw
	gMyJjoh/Yg4F2Nkvyu0hROR7mJ7BylbgrwVqVV7JVjU1jIXPet7fxWeennaY56IKdWgOkSwXLpB
	EFX07v1b8psF4fWzI5gXOiBWMmT06yK7zJUh8aBukLVsDIDyKHHf9nd2ZepgxSM/0gEjlL4KFpg
	UTtf9nBuw/kcOngJHxnwf1p2Igw==
X-Received: by 2002:a5d:5c8a:0:b0:436:7a5:aac with SMTP id ffacd0b85a97d-4378a96d13fmr1844268f8f.0.1770860589674;
 Wed, 11 Feb 2026 17:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770736390.git.vmalik@redhat.com> <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
 <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com>
In-Reply-To: <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 17:42:58 -0800
X-Gm-Features: AZwV_QjZHUJ4OirLYzq0ghgx0YNvUnbenRcGgiG7I3i8y1HkzLAjMybNp-_FapY
Message-ID: <CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com>
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

On Wed, Feb 11, 2026 at 5:55=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 2/11/26 03:42, Alexei Starovoitov wrote:
> > On Tue, Feb 10, 2026 at 7:14=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> Some enterprise kernels (such as RHEL) do not enable error injection v=
ia
> >> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE).
> >> When running test_progs on such kernels, a lot of test cases fail sinc=
e
> >> they use sleepable fentry or fmod_ret program types which require erro=
r
> >> injection to be enabled. While it is possible to skip these via custom
> >> DENYLIST, some test_progs are not properly split into subtests and
> >> therefore must be entirely skipped.
> >
> > Something is wrong.
> > -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> > -int do_probe_read(void *ctx)
> > +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
> > +int probe_read(void *ctx)
> >  {
> >         char buf[8];
> >
> > @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
> >         return 0;
> >  }
> >
> > -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> > -int do_copy_from_user(void *ctx)
> > +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> >
> > sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECTIO=
N.
>
> I may be missing something but I think it is directly dependent, at
> least for fentry.
>
> In bpf_check_attach_target (kernel/bpf/verifier.c), we have:
>
>     if (prog->sleepable) {
>             ret =3D -EINVAL;
>             switch (prog->type) {
>             case BPF_PROG_TYPE_TRACING:
>
>                 /* fentry/fexit/fmod_ret progs can be sleepable if they a=
re
>                  * attached to ALLOW_ERROR_INJECTION and are not in denyl=
ist.
>                  */
>                 if (!check_non_sleepable_error_inject(btf_id) &&
>                     within_error_injection_list(addr))

Oh. That's an annoying side effect of disabling error inject.
fentry progs are not injecting any errors. They just use that
list as allowlist of good attach points.
Let's explicitly allow all syscalls here.

>                     ret =3D 0;
>                 /* fentry/fexit/fmod_ret progs can also be sleepable if t=
hey are
>                  * in the fmodret id set with the KF_SLEEPABLE flag.
>                  */
>                 else {
>                     u32 *flags =3D btf_kfunc_is_modify_return(btf, btf_id=
,
>                                         prog);
>
>                     if (flags && (*flags & KF_SLEEPABLE))
>                         ret =3D 0;
>                 }
>                 break;
>             [...]
>             }
>             if (ret) {
>                 module_put(mod);
>                 bpf_log(log, "%s is not sleepable\n", tname);
>                 return ret;
>             }
>     }
>
> If I read that correctly, fentry must be on the error injection list
> (which is populated by functions marked with ALLOW_ERROR_INJECTION when
> CONFIG_FUNCTION_ERROR_INJECTION=3Dy) to be allowed as sleepable.
>
> The other branch for fmodret id set seems to be only relevant for
> kernel modules which explicily register their functions into
> BTF_KFUNC_HOOK_FMODRET set.
>
> > While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
> >
> > Both fentry and fentry.s should work fine on sys_nanosleep.
> > fmod_ret is also completely independent of these two flags.
>
> For fmod_ret, we have a very similar code:
>
>     } else if (prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN) {
>             [...]
>             ret =3D -EINVAL;
>             if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
>                 !check_attach_modify_return(addr, tname))
>                 ret =3D 0;
>             if (ret) {
>                 module_put(mod);
>                 bpf_log(log, "%s() is not modifiable\n", tname);
>                 return ret;
>             }
>     }
>
> with
>
>     static int check_attach_modify_return(unsigned long addr, const char =
*func_name)
>     {
>         if (within_error_injection_list(addr) ||
>             !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) =
- 1))

Same thing here.
Let's wrap within_error_injection_list() with bpf specific helper
that in case of !CONFIG_FUNCTION_ERROR_INJECTION
will allow syscalls anyway.

> My question is: are sleepable and fmod_ret functions supposed to work
> without error injection turned on?

Yes. since they're not injecting errors.
