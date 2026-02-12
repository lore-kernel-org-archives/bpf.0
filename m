Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59142A96
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914143; cv=pass; b=uxlU6/5U6heRADW8pntfwVlwW4RLAf+OjTxCVeu1SpTSxPwNrobv6105ChfGYk8+LcS79QKbjkEW+45P5O5cQFfpQKhjuBRJ+KQ0txbk/JukhJosYUBn0zE4aQ3wH/5ZEIhQeXxy2bLQpSCy2676GauJdM4A3hFbrvS3ZRpG2OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914143; c=relaxed/simple;
	bh=vEv/ZMJcAHzHljA9mJH44rhvItRC0d35r4omzNjDrZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvjLRrkNIqcHwjP8X8LWVpjEoSA/MTEvkdqUaAWJ1g7rXvV38G5iOfOp0ieouWdgxOBtsH6ouB4IH7vE4J3bXZbVS1EvmZIUv9NJu8t6e13745q5YZWxp3DN6cRiuOmtDEJtDzpwoI1XODkBf0/yDorGZINX3vWC+P/BAd5uq7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkA9YXzA; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkA9YXzA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43767807da6so33902f8f.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 08:35:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770914140; cv=none;
        d=google.com; s=arc-20240605;
        b=XhMib/AvrDhr1kPsx2lxH3HDzNh5m7V7JCuKPta3E99RxhWARuGr41V3dsmJp4OCcj
         aSsJL3BRT98gKJtgdI/lGVDKdXcp4v84E1QwxitFavoAPzgbQj0IbJllLEEvPmJE9M+i
         ZGTufgMyuLqy3qOY5MhHxvBAjCPz4KP7vhL74GLYf4jbHREMacszUz7Zif/kxADBX4Gk
         i7rQFdxkP70tu87hvuw1kToh97UnLWQ7lWvLPpFyKOZWDj69GznmXL8J/v6Yr4jnk0v4
         emnThz7BmRFF6aEc/D5yS60AHo5YzAPd9FeiiJzJxy4ChtRx8I2yTQrvEMZ6mxmPkJvd
         /ASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SXLlgDtsuPBWh09AGfOleWtW9wjfyrl4RZ9O4+mfpg=;
        fh=cYWxAO4hEA81svD5X/DiiNB7a/xE2yZ32mprOvFjECI=;
        b=TS5AQcro4HbSC5SIH04X9NQOtlbfqueedD66hdbkbtaxhz3/GxFGADdbZlUR0MZgkW
         +vupxa0Rr6++0qyyOkqa+/CDxyT4pzCfcceFp5ZeiZqkK9ph2ekhb4ZPTJZv2lSX+YLX
         MfRyGMSU+TTXv/8Y9sTDoHEOpOALWp2NrlYuys1n3oDuKWn5c9mJnzrtKQ5vicXLoSTd
         2o6hKmYp2EPG2Jceqqb9IlAZhH1cbJW8GeJKVBF47kx/QVWoOd7faA3Apnuy6XXeV8wH
         2iIC2j9Uv2jyTNnOzskQKuxLB5Z4v0w1BVrZLMfw+Dr33H4tKIhHqCoSa/MlqxYE2xiP
         FC6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770914140; x=1771518940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SXLlgDtsuPBWh09AGfOleWtW9wjfyrl4RZ9O4+mfpg=;
        b=dkA9YXzAbwIGLjGQTBy1Jcp6U/Qip+HJATQUh1a3Jm6mIW3c7DKDPRe42z19xk2ZM3
         iGljYkdU5g9a19TkjpaWHPeaBTkE5qBg/+RDfqyLjTYn0a5m4y1YQjnokxR3GV31gISm
         3/4GGbfoQCl8lxj65UlOeGmmTJxrQSluYq+IDSKd3qSIz4LNA22dCYoR+rfscgWQx0dy
         1p1b4gwZocZGBL0EuuArxMivIdBXKrKRAsmc2vMiKnP0mZ4ojbIeOnUbGiIbh2AZKOHp
         ZjwnwRuNlA6Ozu/oTQuYnuIBVYpCg25Jnn81FvpV4lKFonQG62+2VIsCH2MZYCeLCJJa
         BVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770914140; x=1771518940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SXLlgDtsuPBWh09AGfOleWtW9wjfyrl4RZ9O4+mfpg=;
        b=BQERDNROyzZw2FfLH1ETyvhZpVvIjX1CqbHy5Y5Hcp7lb4L/J3rkojvqJOKk14kbt/
         8mSE6hQNDNla99UNRUioAmoNSDFeo1bTWIwhlQ3up/iLAwuv3c5+Dyt70ENLC0UQJH5d
         0YJ7pAk1C43LyEyhtjnWRwbjNqfBPksWEViyYWatoTz3hTuUrI6MKchdoKzTvUX86mNY
         GY0GfINypoW1fJudUW4ad4lq8sIrOM/dTyQDHeGCr4rzp1ifcIksz/5d+8hL0HCEPtgc
         x2V053yKuzEyfVoX88+Sr9UqY5Bh+ajnC0qqDsDqqvpaULmeLeT+3Nst+3niWihNCTy5
         cCOQ==
X-Gm-Message-State: AOJu0Yz6HbY43P6cueUWXx16Qs6W1frOCmpwqH8VBzFKkbYBOQp9xKpr
	nJdvSHgptJOPnZ+fMAAk3SDPupjVikvb7Ki1H11Ejmfngw+bZoFH2moutRwdE8Baa8uKqpoJICF
	iQRNRy/QcQC0YiC9Rkw/Q77VFUmVLLVw=
X-Gm-Gg: AZuq6aL9GiXDiEABu8GM/WcI3EbWGBBHS8Ufy98gFJOT6Zp5djRsM1Jf6dNZ01StSva
	0y8Snc3f/T43UMdenn30f8ZPy8RLHm5J3BOvNZOBpkXQ9UL8+m35++vHO1YwPmXNo5YfWXZMZUg
	AOmOzalDibAhjKHUqZ6CTHG1ULzLt1HbUbEwHtszqPvzt8dkQLXaAw1cuWsKlG+rhvxSkfShO2Q
	kJG2f6PaGSjHAWCIwlbLPwY9Jax9XZXC+wWdjrzUud5rTLDbenjv4i/Hat33mJPhnA5A4MR3Qbp
	75wUKVuzaJCASQyj2Z/uLS2O7El3PCWMZygrxiAGTsy/adUh9Udfrq1CEEDccKW+6J36UHv2UNC
	A5LdrzBbD
X-Received: by 2002:a05:6000:1a8f:b0:437:678a:5921 with SMTP id
 ffacd0b85a97d-4378f112e23mr4720188f8f.1.1770914139514; Thu, 12 Feb 2026
 08:35:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770736390.git.vmalik@redhat.com> <CAADnVQLfV3PPYA8=EXDKwoQ925_W9HANf7gSn2=_fd42HD_FiA@mail.gmail.com>
 <d92e60ea-d590-4ce4-961f-4e8ce1cb0c42@redhat.com> <CAADnVQK6qP8izg+k9yV0vdcT-+=axtFQ2fKw7D-2Ei-V6WS5Dw@mail.gmail.com>
 <582944ed-ddd6-4843-ba36-b4aed03c5b2f@redhat.com>
In-Reply-To: <582944ed-ddd6-4843-ba36-b4aed03c5b2f@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Feb 2026 08:35:28 -0800
X-Gm-Features: AZwV_QhgaRUwAN1jVt_e-C3Ddhk2SiyjjNpgoYF_gJ4k2cWO9SLnVGWd8tAWW2E
Message-ID: <CAADnVQJ4PU7bCb5XO9+zMZhLRSdbCKwxG6Rtojh2Rc3UZ8H43Q@mail.gmail.com>
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

On Wed, Feb 11, 2026 at 11:22=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> On 2/12/26 02:42, Alexei Starovoitov wrote:
> > On Wed, Feb 11, 2026 at 5:55=E2=80=AFAM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> On 2/11/26 03:42, Alexei Starovoitov wrote:
> >>> On Tue, Feb 10, 2026 at 7:14=E2=80=AFAM Viktor Malik <vmalik@redhat.c=
om> wrote:
> >>>>
> >>>> Some enterprise kernels (such as RHEL) do not enable error injection=
 via
> >>>> BPF (CONFIG_FUNCTION_ERROR_INJECTION and CONFIG_BPF_KPROBE_OVERRIDE)=
.
> >>>> When running test_progs on such kernels, a lot of test cases fail si=
nce
> >>>> they use sleepable fentry or fmod_ret program types which require er=
ror
> >>>> injection to be enabled. While it is possible to skip these via cust=
om
> >>>> DENYLIST, some test_progs are not properly split into subtests and
> >>>> therefore must be entirely skipped.
> >>>
> >>> Something is wrong.
> >>> -SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> >>> -int do_probe_read(void *ctx)
> >>> +SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
> >>> +int probe_read(void *ctx)
> >>>  {
> >>>         char buf[8];
> >>>
> >>> @@ -37,19 +37,19 @@ int do_probe_read(void *ctx)
> >>>         return 0;
> >>>  }
> >>>
> >>> -SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> >>> -int do_copy_from_user(void *ctx)
> >>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
> >>>
> >>> sleepable should have nothing to do with CONFIG_FUNCTION_ERROR_INJECT=
ION.
> >>
> >> I may be missing something but I think it is directly dependent, at
> >> least for fentry.
> >>
> >> In bpf_check_attach_target (kernel/bpf/verifier.c), we have:
> >>
> >>     if (prog->sleepable) {
> >>             ret =3D -EINVAL;
> >>             switch (prog->type) {
> >>             case BPF_PROG_TYPE_TRACING:
> >>
> >>                 /* fentry/fexit/fmod_ret progs can be sleepable if the=
y are
> >>                  * attached to ALLOW_ERROR_INJECTION and are not in de=
nylist.
> >>                  */
> >>                 if (!check_non_sleepable_error_inject(btf_id) &&
> >>                     within_error_injection_list(addr))
> >
> > Oh. That's an annoying side effect of disabling error inject.
> > fentry progs are not injecting any errors. They just use that
> > list as allowlist of good attach points.
> > Let's explicitly allow all syscalls here.
>
> Ok, I'll post a patch.
>
> >
> >>                     ret =3D 0;
> >>                 /* fentry/fexit/fmod_ret progs can also be sleepable i=
f they are
> >>                  * in the fmodret id set with the KF_SLEEPABLE flag.
> >>                  */
> >>                 else {
> >>                     u32 *flags =3D btf_kfunc_is_modify_return(btf, btf=
_id,
> >>                                         prog);
> >>
> >>                     if (flags && (*flags & KF_SLEEPABLE))
> >>                         ret =3D 0;
> >>                 }
> >>                 break;
> >>             [...]
> >>             }
> >>             if (ret) {
> >>                 module_put(mod);
> >>                 bpf_log(log, "%s is not sleepable\n", tname);
> >>                 return ret;
> >>             }
> >>     }
> >>
> >> If I read that correctly, fentry must be on the error injection list
> >> (which is populated by functions marked with ALLOW_ERROR_INJECTION whe=
n
> >> CONFIG_FUNCTION_ERROR_INJECTION=3Dy) to be allowed as sleepable.
> >>
> >> The other branch for fmodret id set seems to be only relevant for
> >> kernel modules which explicily register their functions into
> >> BTF_KFUNC_HOOK_FMODRET set.
> >>
> >>> While CONFIG_BPF_KPROBE_OVERRIDE affects a single helper.
> >>>
> >>> Both fentry and fentry.s should work fine on sys_nanosleep.
> >>> fmod_ret is also completely independent of these two flags.
> >>
> >> For fmod_ret, we have a very similar code:
> >>
> >>     } else if (prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN) {
> >>             [...]
> >>             ret =3D -EINVAL;
> >>             if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
> >>                 !check_attach_modify_return(addr, tname))
> >>                 ret =3D 0;
> >>             if (ret) {
> >>                 module_put(mod);
> >>                 bpf_log(log, "%s() is not modifiable\n", tname);
> >>                 return ret;
> >>             }
> >>     }
> >>
> >> with
> >>
> >>     static int check_attach_modify_return(unsigned long addr, const ch=
ar *func_name)
> >>     {
> >>         if (within_error_injection_list(addr) ||
> >>             !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFI=
X) - 1))
> >
> > Same thing here.
> > Let's wrap within_error_injection_list() with bpf specific helper
> > that in case of !CONFIG_FUNCTION_ERROR_INJECTION
> > will allow syscalls anyway.
>
> I would argue that fmod_ret should remain gated behind
> CONFIG_ERROR_INJECTION. It's a similar concept to kprobe override - it
> allows to override the execution of the original syscall and return a
> custom error code.

Definitely not. fmod_ret and error injection are two orthogonal concepts.
fmod_ret was introduced to be independent of error injection in the
first place. fmod_ret is a deliberate spot to allow bpf to change
return code
in production.
While error injection is a debug feature to stress test the kernel.
syscalls are in fmod_ret territory, since this is not debugging
and not stressing the kernel. ptrace can change syscall returns without
bpf, without fmod_ret, and without error injection.
