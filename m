Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98537F303
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955436; cv=pass; b=eC5+/Z9j2dZf1DGg2JN1xm9STMpm22ykuAocmFoXdI0iWQunjxYwKShAR0JyK9vWK7d/nH+21vR81WDLauGpjS/ZegOBFYq7rzNQ48Ohoj8JkKNyzACRgi9jyymyoqTbBZnSXOIHwfPGrKmiwpSsS9BgjybIFD6iXlpxt8qiBgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955436; c=relaxed/simple;
	bh=MvfHwldl+sKOvPMGeLPbW5TmXZpkmZZZPFaHoGLdSEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDJi8EiVKnatgddjiG1268AK/OI3LzzWPrNwNxZBNrQZ887TmTMqoNxQpZckxUAvz5Iv/5DpNRkrStyr+fjGS2y3xWwIqrJzLq9yyF4dpe+p9rA+H0eVH5cRqGGSFBnS4sOrSzla+XzqI2OnpPEjA217FQHU2TtDf+P5Fjexkko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkZ0HcpY; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkZ0HcpY"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1074105a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 11:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785955435; cv=none;
        d=google.com; s=arc-20260327;
        b=noHqaNTh/cx4zgmFQgZPsd3nMSXKH65OaZO3mnzZi4OKM4XkZaXjqE7MkF7Xf1MfPJ
         kIdgnvmPFQBTOjli0af5tNqKTf4b50sb6OrgjfHMPNSYhJjsNdmPReYIkZz0TRDC1Zat
         fTRBc8kNLhQVeZ7ZPSW/TPASsoy8s6bvlAOQ41s7YVGUItpreoLQyvvHIHYnyxLKfmqn
         xblfnDlZwmH7dqvcYjhqnfSVTVkOJF9MMHQyrUpkdRr70i0TRjk4y74YmOlrx8juh35i
         5IbsChomKQJqgrLF71WEsEShquk21GccYrUFQFplEzpQ5pveI0tm4bVF8+2mZZmW9v7c
         LpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rjZmjlLbn1kLRhPVzAyMKnMduCUyDwdPV9G0AGtrxWY=;
        fh=NJukW21Jw36Q5SCaZG2svWBS9jYkaauvrcyuZb+I48k=;
        b=ewv1oATAW0PkVSA1j9/0ZM0ewpgZp4ixZmBOyEB650L/0evwZHqJa4QjIE3yg6C0PF
         yTCNiKsyTLgXWmoO6kyF625N8Z46vROZCNk10VQDseU5N19estRYFd67LJp4w+cYU5Lo
         ycAupUimIE5SNnk0WieYrsJgXXKatG2A4ugNj4RcljDJid9O6MCUYudkilPNTxpLwxN0
         SXSwD/7d1yvcm8OyddiCxtJAuq0XY/hDo58Fg0eol5I8+Z3BtkCniw51m0TeNopbN62B
         Thr6WAeM8zqsiFNaaapzN/OMTW98WbX8nz7IUkeRkK/A3JV+IXWq0kcYXX1Nu/tYpNlh
         X39Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785955435; x=1786560235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rjZmjlLbn1kLRhPVzAyMKnMduCUyDwdPV9G0AGtrxWY=;
        b=CkZ0HcpYnZMQUuk4Iz1qr9YM0BdHh9mgcAnkVVv041AO9M5NCEwHQi5iLi1xhhgh4c
         WTLiezZR7rx1CsNHfg8nLiBskbEh7Pd54/ZYr9VbtNTEFBpdr2rSFa53jZWfrd4KMusW
         TDMNJllV0mKICyYLvtQS+r0uXw6amDtJShp4ZRrOr7rzgoqsslWUuhgFtyuPSDMISaAQ
         HOvGhyfxPYPso5yqc7sotzj5ATGMa8q62oEF8nAvKyqej8S4iA8a9pwxY13GlrQaerPb
         U3gxMrKxR4x3mUMvVIHTQPRC5R1EgdwL3GH35yadGhgH1Im9rWVkN78y62d9FHd9vj0G
         Qf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955435; x=1786560235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rjZmjlLbn1kLRhPVzAyMKnMduCUyDwdPV9G0AGtrxWY=;
        b=kZ8Vq9KjNLvnFwLxIqEYILQ6PxyJAcLPXhoCfG1xbzNr+E4N7UzV9j0rcwUtWbr8Ms
         vLF3VN6badMEUODo8L3z6IXcTEczJtZ6CHTENCXcaxApSFHEydC+8Cos8ti91dfxBqfr
         VHz8DffGUAe33wmp390Fucf01/OEZae5CpqTOVJizC6EjWWB2UF7fkIMT0t8zcgDfsnw
         jy7ULOMVAWQ/W9Nb0b4VK0jZZUhJcxBQCSR738Jw3fuBQy6mWbnljWbzwGzcWJjGLsK0
         hBEWRnq+lTu4Id4hJXmm/PbmGcIGI5DtGUWTz/nYF8No+nkMXZ+iHoXqZFNSuhJM7U2C
         C3Mw==
X-Forwarded-Encrypted: i=1; AHgh+RrQ5+0kmS9Cu5LoQxdw2CsVf3CftG8VrFVaLc/Ph+Upv9B4peru1e4hYJJEZEukF0IFiAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4vF3DvKIL/gFRiO6jc1fQ/jfex49kM52M7dVJVkT9hSaWT13
	PJyiDHp1WGeirLzNKkDuFpjsMSZ4/Npy1f+WQ+dDD1SizX84023f2AgROHfUkwiJSw1rTpTzJho
	UhWYtFHr9W0ZgMua6tnuShUtvXOc7AJ0=
X-Gm-Gg: AR+sD11uQiL5PEfkIpxOpBu1IYMTV/oFnpmGUkY/PpCUEhU+MsC2i5p/Ive0k4MhKMp
	q3XqDMONHWBHzwcQMe5YhqXpS2NtLE+TCaVmV/QsyKYR/yXUxlUdheFfrL17dTSPZOJl53REXGU
	ryhALIa9CQZJEDqcjR/GjozvsIFxrnTJGo57tTz/FLFG2VGGoNX4F5mVyZbmY3GPUJxmCAsTl0A
	bmkE5mySs8brPhWFTxP9SqAN8qBR2TdqkcRlFYQJw2TkOyJGYPVj/MfAj7Nb8UmHBp6a5Q1FYCa
	hQOV3JwiIAwIYUd/rZ9XmkYGF+5IsmOmQjD4QA02XdEgaBkjA9ZaOUtw7Sq0gMF6fUsxAaiCNOK
	usJZsQZPiyA5SXkMwyYB6JlwzXQ==
X-Received: by 2002:a05:6a00:3a25:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-84f2e022854mr9421724b3a.7.1785955434936; Wed, 05 Aug 2026
 11:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805150810.34907-2-leon.hwang@linux.dev> <5a4179a9944f6e1e30be7a68a74d9c9f8c9c0eb986419fa2803ab99ce1362378@mail.kernel.org>
In-Reply-To: <5a4179a9944f6e1e30be7a68a74d9c9f8c9c0eb986419fa2803ab99ce1362378@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Aug 2026 11:43:42 -0700
X-Gm-Features: AUfX_mzXG4GLNDuqez_EPP8GlBtiNhXVVyZGknmpb4tC2iKU7RCHdElwgOf5ZIM
Message-ID: <CAEf4BzYcwjrToBRhQ3r_cuNByRY4-cxpdOVr16JmhnC3iMtdTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix sleepable check for tracing/lsm prog
To: bot+bpf-ci@kernel.org
Cc: leon.hwang@linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, shuah@kernel.org, rhkrqnwk98@gmail.com, 
	varunrmallya@gmail.com, vmalik@redhat.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:44=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > Similar issue could be applied to lsm prog, when the
> > prog->aux->attach_btf_id is in the LSM allowing list but the attach_btf=
 is
> > a malicious bpf prog's btf.
>
> Can this LSM scenario actually occur? Looking at the code,
> prog->aux->attach_btf appears to be validated to be kernel BTF at program
> load time in bpf_prog_load():
>
> kernel/bpf/syscall.c:2991
>         attach_btf =3D btf_get_by_fd(attr->attach_btf_obj_fd);
>         ...
>         if (!btf_is_kernel(attach_btf)) {
>                 /* attaching through specifying bpf_prog's BTF
>                  * objects directly might be supported eventually
>                  */
>                 btf_put(attach_btf);
>                 err =3D -ENOTSUPP;
>
> The only other assignment is the bpf_get_btf_vmlinux() fallback at
> syscall.c:3007, so attach_btf is never a bpf prog's BTF.
>
> The other path for non-kernel BTF reaching btf_id_allow_sleepable() is
> the tgt_prog branch in bpf_check_attach_target():
>
> kernel/bpf/verifier.c:19149
>         btf =3D tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
>
> But can an LSM program have a tgt_prog? bpf_prog_load_check_attach()
> appears to reject it at load:
>
> kernel/bpf/syscall.c:2752
>         if (dst_prog && prog_type !=3D BPF_PROG_TYPE_TRACING &&
>             prog_type !=3D BPF_PROG_TYPE_EXT)
>                 return -EINVAL;
>
> And bpf_tracing_prog_attach() only accepts tgt_prog_fd for BPF_PROG_TYPE_=
EXT
> (syscall.c:3673). So the BPF_PROG_TYPE_LSM arm of btf_id_allow_sleepable(=
)
> appears to be only ever reached with kernel BTF, making the 'malicious bp=
f
> prog's btf' case unreachable.
>
> > Fix it by disallowing sleepable tracing/lsm prog always when its target
> > btf is not kernel's btf.
> >
> > Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls"=
)
> > Fixes: 1e6c62a88215 ("bpf: Introduce sleepable BPF programs")
>
> Does the second Fixes: tag point at the commit that introduced the bug?
> Looking at 1e6c62a88215 and up through 16d9c5660692, the tracing arm read=
:
>
>         if (!check_non_sleepable_error_inject(btf_id) &&
>             within_error_injection_list(addr))
>
> On the tgt_prog path, addr is JIT text (tgt_prog->bpf_func /
> aux->func[subprog]->bpf_func, verifier.c:19409-19412), which is never on
> the error-injection list. With CONFIG_FUNCTION_ERROR_INJECTION=3Dn,
> within_error_injection_list() is a stub returning false
> (include/linux/error-injection.h:16).
>
> The fmodret fallback also does not help, because
> btf_kfunc_is_modify_return() checks __btf_kfunc_is_allowed(), which retur=
ns
> false when btf->kfunc_set_tab is NULL (kernel/bpf/btf.c:9021), and
> kfunc_set_tab is only populated for vmlinux/module BTF
> (__register_btf_kfunc_id_set() calls btf_get_module_btf(), btf.c:9160).
>
> So a sleepable tracing prog attaching to another BPF program was already
> rejected before 16d9c5660692. Only the has_arch_syscall_prefix(tname) pat=
h
> added by 16d9c5660692 opened the hole. Keeping the 1e6c62a88215 tag could
> direct AUTOSEL and stable at trees back to 5.10 that do not contain the
> bug.
>
> Would Fixes: 16d9c5660692 alone be more accurate?

Yes, I dropped second Fixes and reworded patch #1 and cover letter a
tiny bit. pushed to bpf-next

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/310206=
55174
