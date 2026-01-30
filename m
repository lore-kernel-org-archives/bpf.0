Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908052459E5
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741707; cv=pass; b=A6SPzK1gh27C9CIzp4HgNUFRc8TpW0GHwer39EYAELPq3/4502WT758tzayncFJoPNQT2czf0ybw9IEHsmX/FLY+kyEP2mecK2BPrbUmTwb3B1amPqpcuqy7h0REpSqscAt1n65FiENOJriwMlkG76h+crSAxJvpTNC1XSyyi6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741707; c=relaxed/simple;
	bh=kJKJK8yXwVf7oA9hIzwd9XxhkgLa9D4k/Xc+Xbapcoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Djcoe5gVfsQXaC9tVLv08fq/dl6/OpUGQgov1k/2PF/exWXUUu1HSYPfS9kN3Fwz1uDELN+nawfzvblA27MY0jVMLN8fD6qpdt+O/t6jGotQuKrX/fcxrVoCDmWh3abStv1uSVtgW06JJAzeMAS3U7Qei/b6hiUe5O3mRTnWaXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez52DzDI; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez52DzDI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso13595565e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 18:55:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769741704; cv=none;
        d=google.com; s=arc-20240605;
        b=DRAXrTUBV+ZnoutQGVr7tq4UEuOvzOKIPU33qNcbNIgvMM583K8NItYK1WVdmCEcOX
         LD7QVUJ/nJjsV9Yvv/xubYa31W40OiGNzN8s5dtJCa4Hro4YMekp5gmYETtAEzDWgYpX
         zh41M4MSmo5ueXjpblMV5rSPO0VzE/NlQEG/5N0PVz1ZuWW9qnwexKFtVArKL1GYm4Z3
         jbK9jumfYeJk80NPoXjP98DFQFSLToigeM0sx6XpXjZO9kdhz0Cak+hiipSydSy+aawt
         82xv9FZLJTIJyX12ujDJPtjAQr1maW6GQ5/IU51AoyWjcB54/i7kDbFd5h4c5elnCj4P
         SrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aqc4/JgO/L2yASX+EfoFtwsrTxbuA8Anwx4RR8/I6bw=;
        fh=8uIDLsOyhRTespFVzBEKHnhmC13owIopg7E6dKMswVY=;
        b=bm3532b57ExekM9WjJsSzBpnPn5NwbFOA43pFWlLWUIuVaQYTsikWGrVaM4KWYUYBE
         eGYEJJqzsHrwJQtCn/Hhxhxz0iepad1kwJmYZjmXAfnZ9wYEDrOpof42ka6xnWHrMLmX
         udStLVXdBFG6Q5CKqh6+QZMWwJ1iITu5b9sSjXlqEHJzT+c7ZNE8gMuZ0WO/+3S1Ky4u
         OpSCf8PtI1BuA6YMILAFQWpjh5bdd1pDlZEVBBenEiHJiHU6HHbza7w++woxhWiedELO
         xfd6P4lNlLEpM9u2UvKfuJaR8LfgwofLsWtJlL2Fpt9Nq7cWl3wkGWkf95LA/uviRnT/
         3YJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769741704; x=1770346504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqc4/JgO/L2yASX+EfoFtwsrTxbuA8Anwx4RR8/I6bw=;
        b=ez52DzDIdtJF6lhfkoaYD0GHWMHMptTW7EuOT1/k8QdnyE7U9g/30FKkPFiMHBBrzV
         6AuF4KeGtYWPg2I5cYyfi1b5acUiFsWgQCuE7hBAW6NYgh/81rJOHccuUU80RQxsEk4s
         r+jN2J3s940RHGGxRlyZZj7XuBZXSrf7xcrP/wnc3BYlGkcux9A7ZI64A0bDR4gq1uKv
         gSk8qnCMwcNNESvctTmdu87B3sDMOFp/ylt6jLOOZ0BOjUWgUSoPdhqQO6DJYbAvpwKp
         pC/Lvcj1heikfVw+BBNdBAJ12K79CYxsm41hcEu/QjFiv3PQ3Rw9i8z/Y8ufxCaBz+84
         ks2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769741704; x=1770346504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aqc4/JgO/L2yASX+EfoFtwsrTxbuA8Anwx4RR8/I6bw=;
        b=dOMHzDEzSi47wyV8mTtiZhaTWoOGLo5nOV3PlE+J4rWgE4rpiBSFexpiRTy3pPBDus
         g5o9Nin+XQRwxvTyFXeC1QlQ5gu5N8Hp2ZszO/So7zXgN1UgP36dNP3m8XbAgIHmCu9L
         1DrFUAxA8to9p1opzPu+wxPivPb7NCSFNmgeiOHPVqtYc9i1/NT2YKhivM85MzBN/cx7
         MHhmCgMJFXPYsg0x+yLbOlyz+afXsMRV23fpFsThPme/+2fnRNZ3a7sb+/t/J+h0RPZS
         Dgjo9krRg7HqVyJVohtzSbmYRjDaqXokSkF3hzpnFdlNvOwRd8QbI58DLt7KyK02YDjx
         CUPg==
X-Forwarded-Encrypted: i=1; AJvYcCV2XgyfbydY1iSzBx0BnnM1upUHMxJG9N1v9NOaMwb0umV28ZmAdrwrNAdAd8SYUdCqpck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV17gkHzj6LWyRDISTjWT+AFn8ncPzqfS0n8ra5HyyiV5CEzBN
	jLdiPWDnItNmmhO/1Rw7t38sQBj74dV4XR5sV1ZQsxDH/SgZEfzyp3DCWqee3oGadzBgmX5vY4o
	KfCoUYOcAC6GZQLbu7JUnsMjYXqbgmcs=
X-Gm-Gg: AZuq6aI0e6W1bnDp+uyoWRk2VTMUyu1ZAIO7E4gjKRUqVyHwPKeqMmbVqHKkPSf37Il
	73D18oenvXI8gTbtBaWIiefHAANiDJi3msZfLPNeo4RiLPKbB+Fht7OEE/rWErZRh/pAx+XkBC1
	1PlmzbFbsUt8sQ+7gketMvVIM3dhY6oMAkQ4IQs6zHrlyDqqrj51fvPFXS3lrqhm+jlzziXD2if
	v2GgwNSNVvEMZr8jYALNQcQi6p1fFWiUcRjngKNhS3ATxOrvqbHYprf8nzGKlF/vXwlqcRtcjtp
	vciGZ1HaVbghwjFc3GbpYX0lidStBG3t7aQS1sIJ60mJpEC8IamFDCQhrKITjJ9/atcGmIHtVvq
	Xi8DJ4zzvrrRYQA==
X-Received: by 2002:a05:600c:c0cd:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-482db623765mr9839665e9.25.1769741703829; Thu, 29 Jan 2026
 18:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122090404.15553-1-chensong_2000@189.cn> <CAADnVQLVQW-Mb_d+zT+aSpPOZ042erPVcSHVBx9PMGET+a754Q@mail.gmail.com>
 <bb4a868d-d4e2-40dc-aed4-4788b159a7f6@189.cn>
In-Reply-To: <bb4a868d-d4e2-40dc-aed4-4788b159a7f6@189.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Jan 2026 18:54:52 -0800
X-Gm-Features: AZwV_QhnkvK8R0bACiNe6wa5s9EDQm392iBMpKKMP5BBt1a7A993m1m0gPSzL-U
Message-ID: <CAADnVQJEjhJH6+2cLJ0jM_fZ366oU3yoK1b5aMk=VgksXhJtoQ@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/bpf/btf.c: reject to register duplicated kfunc
To: Song Chen <chensong_2000@189.cn>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 6:18=E2=80=AFPM Song Chen <chensong_2000@189.cn> wr=
ote:
>
> hi,
>
> my comments are in line, thanks.
>
> Song
>
> =E5=9C=A8 2026/1/28 12:28, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Thu, Jan 22, 2026 at 1:04=E2=80=AFAM <chensong_2000@189.cn> wrote:
> >>
> >> From: Song Chen <chensong_2000@189.cn>
> >>
> >> I had an ebpf program which calls a kfunc defined and
> >> implemented in one of my kernel modules, they were working
> >> fine in 6.16, but was broken by libbpf in 6.19, the error
> >> message was:
> >>
> >> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
> >> incompatible with vmlinux [94389]
> >>
> >> yes, the reason is there is a new added kfunc in kernel 6.19
> >> which happens to be the same name with my kfunc. However the
> >> error message is not obvious enough to address problem
> >> immediately.
> >
> > I don't quite understand what you're trying to say.
> > "broken by libbpf"?! You mean that kernel 6.19 got
> > new kfunc bpf_strstr() ?
> > Why libbpf error is relevant?
> > You mean you had your own custom .h file where
> > you defined your own kfunc from a custom module
> > and libbpf complained that your bpf_strstr() kfunc
> > definition doesn't match the kernel 6.19 ?
>
> let me explain:
>
> I had a module, defined a kfunc(bpf_strstr) in its c file and register
> it through register_btf_kfunc_id_set.I also had a ebpf program to use
> bpf_strstr in this module.
>
> They were working fine in kernel 6.16, but kernel 6.19 has its own
> bpf_strstr, so when i ran my ebpf program in kernel 6.19, libbpf broke
> it here:
>
> bpf_object__resolve_ksym_func_btf_id
>    --bpf_core_types_are_compat
>      --__bpf_core_types_are_compat
>
> yes, your understanding is pretty much correct.
>
> >
> > and your proposed solution is ...
> >
> >> Therefore, this patches searches duplicated kfunc in
> >> btf_vmlinux before a kernel module attempts to register kfuncs
> >> through register_btf_kfunc_id_set, it prints clear error message
> >> and returns error code if same name kfunc has already implemented
> >> and registered, then developer knows at the first place.
> >
> > Are you saying that the kernel module that supplied bpf_strstr
> > shouldn't be allowed to register its kfunc if kfunc with
> > the same name exists in vmlinux. So insmod will fail?
>
> yes, two kfuncs of bpf_strstr are registered in the system and one of
> them is never used, this is a problem.
>
> >
> > This is debatable. I guess we can add such sanity check,
>
> agree, even it's not a big deal.
>
> > but what about kfunc in module A with the same name as kfunc
> > in module B?
>
> It's in my plan, also go through "list_for_each_entry_safe(btf_mod, tmp,
> &btf_modules, list)", but i haven't gone that far yet, i can add it.

I'm not convinced that we should be doing it.

> > Currently libbpf tells kernel both btf FD and kfunc btf ID,
> > though there is a single namespace for all kfuncs from bpf
> > program pov the kernel and libbpf api-s allow a selection.
> >
> > Technically we can hack something in bpf.c to "namespace" kfuncs
> > and say that the kfunc "foo" is in the module "bar".
> > It won't be pretty in C, but possible in principle.
> >
> > Maybe a kfunc with the same name in the module should be allowed
> > to override a kfunc in the kernel.
> > It can be seen as livepatching of kfuncs.
> > imo that's a more interesting use case than helping
> > out-of-tree module to produce nicier error.

because ^^^ is what I think we should be doing instead.
Since it is more applicable and useful.

I'd like to hear what other folks are thinking.
