Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02026738C
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023693; cv=pass; b=E7m6zJqPd+YDCoVyzaq1+/hXkBK3+nYWpJP2sSEDsmeMBKkRz7+9HU4v+/uh58cKbdwqsDBoZFlL/Udq+1zKAKLs91cIdTefBeHALJDYFQTJLZoEHyNFGNoKN73Jq6ITDwfiBmlz7e5Bt2W3noX9NApQEWoYf53oW80BDIkR2j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023693; c=relaxed/simple;
	bh=TaASV/eXbLVsyWAVTsVPoCx0LARSNxuOUJWkzAi40/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6KuLLbeTZqKix1L05hfG12wEJxzb/Ue74beVvWXR/uHHSr50/DbByz8A0i6RjjyN2x1JgsiWrFgH83CnsZoiKM9eckTU1dsiVjuOb21MZgglxpb5u5x6j2sEcxFzSQXQ9AxeicNCp3uPMoeN6TnM7tMG8kzGx+aIzWrsODslEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPrKJ7KB; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPrKJ7KB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so101626f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 20:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780023690; cv=none;
        d=google.com; s=arc-20240605;
        b=FMziEIxMxVutgg1G4Vz9MiTOMBTrOh4B0SQIZ97HTL28yeGBXpTxW7vdwSlHit+tSd
         TmgwnpHKCwUsNuQQb7q1EcfYnrN9FB1EEHUpzwRd9GcxAQmiL63sDK+d9qwU/ajzwdq8
         IIKCJrEu1txmHPS9ov4oKvBu6plQQXC+MjCYhMeq2VledawExP+aizFOGp4FW5ZYPbqS
         GMWeYuVaf3Sty9OG+d72N9SMLEdHCU/hRdzfjAbLf267ZKuLRURrt1MTuHue5ikArM7O
         y/7l+pRKpFOmAW3SC/TEvyCHdiWbs+PiecPwXxCWJMKSXDXACMhUN4GGCCnrgW+SKN1Y
         8onA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1zB4y/bbUhvUAzHR+8e/gENPCf2O6I5QEtF8WJcA+4U=;
        fh=WFwyd+W8IUNXZoeHl/78aQU6jQ/YsRl1E12Jr1mZv6M=;
        b=cqQSISRWoLdNZFGDBHiI2XbAHEgUnnVt5QhCR3iOnPco+3JovjzgDGgELdqPvyBxUU
         UcPeSzRaqWTfIWI9mrvBamn5tFVO1P86eFYETkRWjidBGjxZyvhQzNo/KEtZDTX+rhSG
         tM2IxFUORLvheyqqYiZ+Wk7lfKqk+mdjkORMVmEiLMc8i+OWKSHbxbIAvdwsjZ6w7rqg
         mUSiKbyetPc+beVrcWt+kLsKpak4b0fRRDy3TGGpKk1a00bokaF+r9SVj6stwW6vNSP2
         b8gwK9QdnN5uucJIvFdudf0ooC2DbDZpHA0sZFsFlIbf/kiq2UaxZveitHsq5RE78V+H
         nc8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780023690; x=1780628490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zB4y/bbUhvUAzHR+8e/gENPCf2O6I5QEtF8WJcA+4U=;
        b=BPrKJ7KBFJmB5Zhq5x6z6Ft2qSHnaVzCPy6glcVs0YvnoSAUZV5KbHSkv1+ydH6tCm
         pLAsA6ccEo73G77fdSA+YXJeJeFnKwLhso5lorY/xF+Stkkua633OeLV7wwPzpUdi8HW
         ZvubYzE00upQFChzHnfv5jmcAkUEt5VFchH+qmSm3bi3iWui3K2pfs07aqtqfLZPvXBB
         bx4OnGcidR8luyg+254UIcu//sjWMmut9/aVZeeydDBRcIrFe5dKuYGU6eS1oaIlPxco
         bb1RMegFNUSTKMJNfOggfF2iZ8vsS3u6iMq7xrAe8iT4ioiJXfwbfAEIRtP2+94qvHi/
         CYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780023690; x=1780628490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1zB4y/bbUhvUAzHR+8e/gENPCf2O6I5QEtF8WJcA+4U=;
        b=KG7B9NQDmuKJxZv8axcBc/8Kip/EzbcVRIxZp14TAuqHQ+oKaEMtqbdM1XILRTxaOy
         a5ApDEUlRvFLuzUE3D2xpsnfxpBii5MWpUOUjUo74SyKr0lkyyvHa8FTROO6yzDacl/X
         uV5irmNr44WF34jacrXmwgPmD4kBR+gKwJpPFVsUaHnklZtFUKUvWDLUef8YB0Lxf6n+
         B9mD8p0TRvqT4DIgIyEjWiB+TCz8U5r8oigRjykSQtX3RTCBSiLvM2zUk3snxBmqmdak
         9YnEd/AjdY+e8REbaW5YAvEQo8c83SxQx1V2seg6rcM2AhnC7GJVZUYAdKgQfqXvrYKs
         NEtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QLCe03cXYOKYlWIVi6cvQmnDG5DS6ERrmJpoKmg67aWINX2WavLh5eJJmqvL4o5gpBUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhso4q0eVA4s4zaMp6qjL0t/JSRnFHzYsIX6IlUVYk27jIrZoj
	l8W6NLtDBmCieuK0SaKy/Li81uXG22Chfmpyo5vdPzkwTk7ni/LS3Qo6mBtTAakuCkILs9FrqVE
	z/dlgUa0AViAR2lbnWlPtdwpVBE2t+vQ=
X-Gm-Gg: Acq92OHzxCwtQUegSMGUfQi6mg5QdnYgcgIvbG7OTJiKBj34jg88eOzupnXvUwkXeq3
	OxUdKOXmEc8stV+FcTYu+u3Zog7RoqK8phP7AUehHcS0HajumcsckR0hrcmwfqO+xB8/EBsWWSm
	BgTnsRjr5Ki7vOmDYWD2Tnp3BA4NwAAFP0OBcWzcSl2EPLoJBZUEtTZZEo6m2DI6/qMrHxadZlt
	KV1T/GCyvp+ix3pIdTsJ5EnnwKRmSE1ueKMSWnl9tQ+9Cj14auGBRv0iPhMsuYAcZSR2e/ppCmJ
	NTKdyo7/rpArcd/YM/bN78TgMWXj9Lh0iQ+Pu6iWa94BNv5Bc1MCR9tCvLrKDi0XdkM4NpZzTYu
	6O17BbDkjPTvc83qlkOyLPbeh4Qq2/MatJlsF
X-Received: by 2002:a05:600c:1f93:b0:48f:e230:8cad with SMTP id
 5b1f17b1804b1-4909ca8958dmr12309145e9.33.1780023689961; Thu, 28 May 2026
 20:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524082944.10625-1-chensong_2000@126.com> <757e24eb-45d3-4e05-9aa2-f077bec8fea9@linux.dev>
In-Reply-To: <757e24eb-45d3-4e05-9aa2-f077bec8fea9@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 May 2026 20:01:18 -0700
X-Gm-Features: AVHnY4KDNPX8j40VI8j2KdICWSeUhVeIKHxj9KOxvBn_tP2rpWL55Qhj2zLPO0Y
Message-ID: <CAADnVQKWjqmEw6rZNQ5O8SBFs2tfK4q_UX78ZV2pH2fgdq_c2g@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: Song Chen <chensong_2000@126.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 2:20=E2=80=AFAM Kaitao Cheng <kaitao.cheng@linux.de=
v> wrote:
>
> =E5=9C=A8 2026/5/24 16:29, Song Chen =E5=86=99=E9=81=93:
> > I had an ebpf program which calls a kfunc defined and
> > implemented in one of my kernel modules, it was working
> > fine in 6.16, but was rejected to run by libbpf in 6.19,
> > the error message was:
> >
> > libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
> > incompatible with vmlinux [94389]
> >
> > The reason is there is a new added kfunc in kernel 6.19
> > which happens to be the same name with my kfunc. However the
> > error message is not obvious enough to address problem
> > immediately.
> >
> > Therefore, this patches searches duplicated kfunc in
> > both btf_vmlinux and btf_modules list before a kernel module
> > attempts to register kfuncs through register_btf_kfunc_id_set,
> > it prints clear error message and returns error code if same name
> > kfunc has already implemented and registered, then developer
> > knows at the first place.
> >
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Suggested-by: Kaitao Cheng <kaitao.cheng@linux.dev>
> > Signed-off-by: Song Chen <chensong_2000@126.com>
> >
> > ---
> > changelog:
> > v1 --- v2:
> > libbpf has already specified which module this kfunc belongs to as
> > ebpf code onwer's expectation, then verifier uses
> > find_kallsyms_symbol_value to search kfunc's addr.
> >
> > v2 --- v3:
> > After v2, I tried a new idea of introducing a namespace in libbpf
> > to specify kfunc owner in an ebpf program suggested by Kaitao Cheng,
> > please see [1]. Alex suggested to go back to report an error during
> > kmod load on conflicting kfunc name for now. What's more, v2 only
> > searched bpf_vmlinux, v3 also traverses btf_modules list.
> >
> > [1]:https://lore.kernel.org/all/CAADnVQ+jYGMjAC9aNygmhyppUO9foWN4z9cjSp=
wCEXAFHpRVJQ@mail.gmail.com/
> > ---
> >  kernel/bpf/btf.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 43 insertions(+), 1 deletion(-)
> >
>
> btf: reject to register duplicated kfunc
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 4872d2a6c42d..a14ad3720872 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -8618,6 +8618,47 @@ static int btf_check_iter_kfuncs(struct btf *btf=
, const char *func_name,
> >       return 0;
> >  }
> >
> > +static int btf_check_kfunc_name(struct btf *btf, const char *func_name=
, u32 kind)
> > +{
> > +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > +     struct btf_module *btf_mod, *tmp;
> > +#endif
> > +     s32 id;
> > +     int ret =3D 0;
>
> This ret variable may be unnecessary.
>
> > +
> > +     if (!btf_is_module(btf))
> > +             goto out;
> > +
> > +     id =3D btf_find_by_name_kind(bpf_get_btf_vmlinux(),
> > +                                     func_name, kind);
>
> It seems unnecessary to split this call across multiple lines. Also,
> some of the continuation-line indentation elsewhere does not appear
> to follow the kernel coding style.
>
> > +     if (id >=3D 0) {
> > +             pr_err("kfunc %s (id: %d) is already present in vmlinux.\=
n",
> > +                                     func_name, id);
> > +             ret =3D -EINVAL;
> > +             goto out;
>
> return -EINVAL;
>
> > +     }
> > +
> > +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> > +     mutex_lock(&btf_module_mutex);
> > +     list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
> > +             if (btf_mod->btf =3D=3D btf)
> > +                     continue;
> > +             id =3D btf_find_by_name_kind(btf_mod->btf,
> > +                                     func_name, kind);
> > +             if (id >=3D 0) {
> > +                     pr_err("kfunc %s (id: %d) is already present in m=
odule %s.\n",
> > +                                     func_name, id, btf_mod->module->n=
ame);
>
> follow the kernel coding style
>
> > +                     ret =3D -EINVAL;
> > +                     break;
>
> mutex_unlock(&btf_module_mutex);
> return -EINVAL;
>
> > +             }
> > +     }
> > +     mutex_unlock(&btf_module_mutex);
> > +#endif
> > +
> > +out:
> > +     return ret;
> > +}
> > +
> >  static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 fu=
nc_flags)
> >  {
> >       const struct btf_type *func;
> > @@ -8631,7 +8672,8 @@ static int btf_check_kfunc_protos(struct btf *btf=
, u32 func_id, u32 func_flags)
> >
> >       /* sanity check kfunc name */
> >       func_name =3D btf_name_by_offset(btf, func->name_off);
> > -     if (!func_name || !func_name[0])
> > +     if (!func_name || !func_name[0]
> > +                     || btf_check_kfunc_name(btf, func_name, BTF_INFO_=
KIND(func->info)))
>
> follow the kernel coding style

yeah. formatting is way off.
pls respin.
