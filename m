Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8A346E66
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029960; cv=pass; b=Ajjntey9EhNE4eYWh8mTGbyMdUm30FxCFZfG9I3X0Hd/z35lEmsaukwkVui7pLJMEeiojPEExcmqWaWWi612lHuzpu3t5yxWXpbZ3x4OSeRkDnMahWAROBwMdh2aMM1RB91gOKxHvqw5OwBuG1niSB0WaAeUTmpYCmM7X4Cj2Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029960; c=relaxed/simple;
	bh=DdUpUIIlNtC1GkgxJocJ0L2ZBOuRrEs3lNvLItd+uIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcHZbwXPlXTy1DgKT0mGpi9u9fPjF/qbfDVIWwUxQ/jUB7q5rwmOUvwmwM2grLVsAqZKSLuf8Se96gJiB8thNqW6jSLGVLXA+Y7lLcN8AgdUDspiGOPa4e7xe/NrWD/unbjEnlB17VL3PNquvBqrOrA9JrJE3aQcxIRJ9BRge28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9so0iqI; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9so0iqI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso7233745e9.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779029957; cv=none;
        d=google.com; s=arc-20240605;
        b=P+cF+mvQZd7RsFDZUoGxJun2mBJENN6g+enwhv+op8bvN0pDcPnJ8A30Hj6LeTu9Ie
         SkqVQzZcIAUY/fQFZ1oT3A6sk/j2ZqwStRqq0Bx0cBkrB9s+8O8/61vEextICtboGS4h
         Iih0qAmuEQCcfuYLXy0vd+vL6ZKsg2X0JRgfdZxuRDFyK1FCtpA2ufwUWMQd7iIto3Nz
         avIWTJwvYPp4eoYl+HNQREoQsmgoemrUs0NtKAoIz3fBBem3JBPAIc6SVXqtHv47ucMK
         CnPO+9UmlOWI/DQJblEotkYPJ3+12M5MCtTSbYicG/Hs5hxiuHuPcWnYUGUcCvc/X3o7
         zAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gR3NlGyuSJvM4hb6gvAcKREcl/fs8ArQUfaiv0RDIQ=;
        fh=OXXnMnByOLDk4Ad8IXVqUCN8TicNm1RC8CklRAt3/gs=;
        b=EVumnZ3ILgT4FWKQDvO+yxPaRNlq4LkuEG1m48vwTspY5qhOIrPWFbs0TxI+lFQxLt
         vhXNNds5y6Z0EJ+kI1qvNYsWZryfpUh9DTjhuVv/kwmnIIL0UsWbReaEkYbogWOvn0Vk
         76NIDPqUQK9cGhXflPWQdhhHKmVeUkXpctXTC3ABfK4S5BtWglfwAWJ2vs9DxhiIty0n
         qOYspHdv/u4ms3RopZysU8L8zqXtdZ32ezmvYl9BMpYq0TgGtr9i8WqZDML1OtAwxlgU
         34nZv9ZTR7RAqsfZTkoovBKKVuxSDd10mAeZvjDtrxqRMjDK3HT0qtXcjqaeRtVwX10z
         SP8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029957; x=1779634757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gR3NlGyuSJvM4hb6gvAcKREcl/fs8ArQUfaiv0RDIQ=;
        b=O9so0iqIyxgCXAsGeLyexnVMrnig+jOL5V2DWTb7bn2I4HnwY9k5uyRgHWOvEI+LiB
         kkGeSBwGDIvrmJZ2PILV1m2S8tNO0hvcgxNZbllXGWKiBCZTJf8e1YYaoSRNcDpYEWz1
         0IFJe+qaFqjkXtiBYLRqby0pAr4xn2tl7j/c8Nl833+VlbLTdAoPql1Jgagz+fGwT0ny
         /gG2QGGFftSVcEAgLm4EzP6TwX3sOBtvRffVTKiWr94mC9ztjppbtUQ57At1Z0bEivMg
         pkBYtCd/UNVQSpl6Bd8V+U7S2pwwDLQaQtaJtDhawz+jyPcZJ3qlZINM6I5LgJj8+a/d
         jwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029957; x=1779634757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0gR3NlGyuSJvM4hb6gvAcKREcl/fs8ArQUfaiv0RDIQ=;
        b=H2LGlz5A7fgaTJ6dBLU877V5d70ArfLRuoZe9lPc8w9d+hurqfTmL2WDGePUtwL6a2
         Q715NHU2sjbYYlnfnwjiq20flmQie3ioEIIyj9oE9gN1kRRtSMMGE/QVx490VSb5S58o
         dYMPFBPP0POClD27sUcHrgmLEmhQAPMcN5EZIlg/K5MKpzMJFy1SDk0T8vwTT1RtTelB
         S0izzk7g59QL7qnIHVTbNZW7dXLJg6sve//jYpEtBNIvguHt8Q0HY7ogpt9n3SGYFODF
         ZJEx0B5uMGlkn94SStNIW9CEtp4uL3oz+Is8H20VcXDiNdGChQCwDWlMcPuv+OevMy88
         td0g==
X-Forwarded-Encrypted: i=1; AFNElJ/FylWA/lY/FFS5GRV/fnjRMOu5DOq0LfIfYFV+BPGE7AWosclo7Eyf/65jyePb0KwLOIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbpvfortRuF6Nf4M4eTcJZV4inMyo/CminTPsl/KVLrS0vr1d
	OEHyv3HBvC2nJjqT4LaGBJ9Ta7PuIAM5224u6eo72yQd3Gdobsn7Qno+K+HHUjAk9mDhzbGSYj0
	U35+SxRZU6k+HD8ufu9W19X4EiJyoeCU=
X-Gm-Gg: Acq92OEIWvW9piDBpicm5Zhs9vGBcdFY2nN7BiCdShssevmmmNkZ2DxDQnGAdJjgL/c
	On+Qd873pk4czqe2nGOxhZMdHNZB8LRwaA6sFpb4WdAqcb6yNO72RQjX0EYfzms/zi2q4PSfXV7
	CoV1xH9A6lWRzQo7Z5MPM/r01EWmTew2+ZZARgrJ95feg1sFrIdWF6BqLhgKugCH7PnRKNnJA+7
	9fhYHfUoMlbzDmuD5IiezKbahal0RgIbH/X+4KyJrNhl2f0l/c/oIcAACq8kBTKXpGDsyGyR7jc
	uKiKbFe6wOEeCtUiwmLm/KbX5K9pxcb1R7kDyDQQIsz1FzpadE/ofyNdF/4hqoKJXwRZj+Zy7CK
	FDCuaxDrkxy7E183P/FEZQHfhMw==
X-Received: by 2002:a05:600c:c10b:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48fe60d55c4mr117370815e9.9.1779029957276; Sun, 17 May 2026
 07:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510030136.27876-1-chensong_2000@126.com> <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
 <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com>
 <505473d8-85ed-434f-a863-8ecad2ab1d6a@linux.dev> <419f6871-d66b-421d-ba81-804e162309f8@126.com>
In-Reply-To: <419f6871-d66b-421d-ba81-804e162309f8@126.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 17 May 2026 07:59:04 -0700
X-Gm-Features: AVHnY4LUD7EDXzBL2L5t2qNLTBOSdoSdK-M7NwrzFKq4yVzlS4kMml5Ne6_LtS4
Message-ID: <CAADnVQ+jYGMjAC9aNygmhyppUO9foWN4z9cjSpwCEXAFHpRVJQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Song Chen <chensong_2000@126.com>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>, 
	KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 11:32=E2=80=AFPM Song Chen <chensong_2000@126.com> =
wrote:
>
> Hi,
>
> On 5/14/26 21:29, Kaitao Cheng wrote:
> >
> >
> > =E5=9C=A8 2026/5/13 05:41, Alexei Starovoitov =E5=86=99=E9=81=93:
> >> On Mon, May 11, 2026 at 8:19=E2=80=AFPM Kaitao Cheng <kaitao.cheng@lin=
ux.dev> wrote:
> >>>
> >>> It seems that there are two problems to solve here:
> >>>
> >>> 1. Allowing kernel modules to override vmlinux kfuncs with the same
> >>>     name.
> >>>
> >>>     This should be relatively straightforward to implement by matchin=
g
> >>>     names in kernel modules first, and then falling back to vmlinux.
> >>>
> >>> 2. Handling the case where different kernel modules have kfuncs with
> >>>     the same name.
> >>>
> >>>     Could we use a new libbpf API to establish the mapping manually?
> >>>     for example:
> >>>         bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")
> >>>
> >>>     Or define a new attribute, for example:
> >>>         extern void kfunc_name(void) __ksym __module("module_name");
> >>>
> >>>     We probably need to hear suggestions from other developers on thi=
s.
> >>
> >> I'm not excited about 2.
> >> Two different modules are not allowed to have two different functions
> >> with the same name.
> >> The kernel has only one global namespace.
> >> Hence I don't think we should be introducing such namespacing concept
> >> into kfuncs.
> >>
> >> But 1, I feel, is useful for experiments and mitigations,
> >> but it probably should be done transparently to libbpf.
> >>
> >> register_btf_kfunc_id_set() should be changed to return an error
> >> when a module attempts to register a kfunc with a name that already
> >> exists in the kernel.
> >> We also introduce override_btf_kfunc_set() that would register
> >> a replacement kfunc.
> >> override_btf_kfunc_set() would check that all overriding kfuncs
> >> have the exact same kfunc already in vmlinux BTF: proto and name shoul=
d match.
> >> Then the kernel will just remember that the address of that kfunc
> >> is in the module.
> >> libbpf doesn't need to be aware of this substitution.
> >> It will find kfunc in the vmlinux BTF, but the verifier will supply
> >> implementation from the module to bpf prog.
> >> 2nd module should be able to override_btf_kfunc_set() from vmlinux
> >> and from 1st module that replaced some kfuncs.
> >
> > If multiple modules are allowed to call override_btf_kfunc_id_set()
> > for the same vmlinux kfunc, the effective implementation becomes
> > dependent on module load order.
> >
> > For example, module A overrides a vmlinux kfunc and an A BPF program
> > is written with the expectation that this kfunc resolves to module A's
> > implementation. Later, developer B loads module B, which overrides the
> > same kfunc so that B's BPF program can work. If developer A then reload=
s
> > or reruns the A BPF program without knowing about module B's override,
> > the same kfunc may now resolve to module B's implementation. This can
> > make the behavior hard to debug and increase the maintenance cost of th=
e
> > system.
> >
> > If this is the intended semantics, I think override_btf_kfunc_id_set()
> > should have clear comments documenting that later overrides replace
> > earlier ones for future BPF program loads. It may also be useful to
> > expose some debugging visibility, e.g. through verifier logs, debugfs,
> > or bpftool, so users can tell whether a given kfunc currently resolves
> > to vmlinux or to a specific module.
>
> I agree with you. I have already had a solution for this proposal:
> define a new attribute, for example:
>         extern void kfunc_name(void) __ksym __module("module_name");
>
> 1) introduce a tag in bpf_helpers.h
> #define __kmod(name) __attribute__((btf_decl_tag("kmod:" name)))
>
> 2) add module_name in struct extern_desc
> struct extern_desc {
>      enum extern_type type;
> ....
>                  const char *module_name;
>     } ksym;
> 3) read tag in bpf_object__collect_externs:
>    tag =3D btf__name_by_offset(btf, t->name_off);
>    ext->ksym.module_name =3D tag + strlen("kmod:");
> 4) search kfunc in modules in find_ksym_btf_id if ext->ksym.module_name
> is valid, otherwise, search it in vmlinux.
>
> This proposal solves the kfunc priority gracefully, if ebpf program
> declares the kfunc module explicitly like this:
>
> extern int foo(const char *str, const char *substr) __ksym __kmod("hello"=
);
>
> then use foo in module hello, if no __kmod after declaration,
> ext->ksym.module_name is NULL, the behavior of find_ksym_btf_id remains
> same, no impact to its original logic.

I don't like it for the same reasons as before.
This is a half measure of namespaces.
If override is not clear win, let's do error during kmod load
on conflicting kfunc name for now.
