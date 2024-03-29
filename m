Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F9B3FB95
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751694; cv=none; b=ngFIbjrV8xTfMsKUxr3lk1abNOtX1Q8hzOeQk5iuwgCUUXXtMFs/WvHCpCUCWrA5Gik9aSyUboaD+pZwSbHZNFT9+/kXhi15VkLMIGCCnhyU/lWnuVRIIybMkNU+/6kmeGVKVmhEyLlR3NVxc63E36UcDfkJscNqmOMUEmEViak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751694; c=relaxed/simple;
	bh=c1D3E7+MKTjapTyt/SZObtp04+A+ffReHXWFT+rus4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmEfRb2adAAj2I8fs36UwcVAlsRogrQ7Eq0taT3GgCLKmvrjJSpMTwrpoMQzCvrnDIzx7a7F8o86kvaAMhHFMpVnNlxB4jzd06tp/caS/CXyD8cCYorlzZB4QaDuyvk7eHxxIxWv4VodlNH1oJ7p5ebx0viCk3/y+klySDYFn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jATEdOpL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jATEdOpL"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eac64f2205so2035804b3a.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711751692; x=1712356492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33GKBCvUYKjGtNxydHx8TwYNOHUOBuejSTUcg7zyXyU=;
        b=jATEdOpLjfsntB7++W8zP9bl0ivE2aU883nk6wed7zW1aZ68Zi/Ftb6qRzSaNQ3zJy
         iqrwLQV9P6vRFt2tu10UPrqjlyMcupZaJhnxGPVq3M4n074TxJ10OEbwsYYm1QF31mjG
         SvSuc3qA4c0ZPadofn7B0L+91AHPuDtSgYlMCDZvSWhDnbK+XvNNpeYUSl4E2u23nDiR
         UZTh4zuIjrLpaJWPoWGbwnFO73NbgaE9niQy1+TIHetWTRViD3/1JFqN2mCWLZaF6C4L
         ZOL3kBNcqat/INa8C5De9RbyMzRTolxe3uG/fnbngWYX6dPg+PriAP2K1rSzvNzZx1pe
         yQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711751692; x=1712356492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33GKBCvUYKjGtNxydHx8TwYNOHUOBuejSTUcg7zyXyU=;
        b=IoNxl1vcaCLzwNxy9wfWXk0pixRdX7mK2DDMktYgk5MhrbUxjjkqm8TkBQdN0mN6I6
         txyvnrXhIOEVAfT3cTzu2STmp9Irgw59u3R/Y3uc85mlGyS/IJSU2E3Hu93nQvRzn1uY
         r2sd5Kg/JphjGA55KvhMVOgm7+svlr8cT9JVQceqY0IVG+PGcnghkF8FtRDwGEct5bcs
         +MWcs0EZpdXr6C7h2P+04fmBkkosXQ4VLITj+VCunkGrZs+Mh/2a2mBXgoKW1v2Y80C2
         hnKuSbxECGYWKVtqjOftDMBaW8qIMSve866GMSpW7+bDyZt9yRVNTxJHRgsWhep6yi4W
         yqJg==
X-Forwarded-Encrypted: i=1; AJvYcCXyO/N/s6R4z58VKX5vLpnWGgJfT339PfvVAY28MXlyirrOcCKvV6vjqDHpAmDwgzkZMFBFAIRsYRyWXnC0NpCU44Nk
X-Gm-Message-State: AOJu0YxsqLCHtWnfOlzT93A8XANJsJsAHSDmgOXOIaX/5PaDolmSS+lU
	LRDYcqML4ighrobQG9ZV2+jpg4u9XX09m8TLltdDD+bdEHgHtzOummr86uDXHtc8huEDABaIjZS
	5WLEbih7hBxI++HrxKIdchQhH8AI=
X-Google-Smtp-Source: AGHT+IGkt+SJG7684t7G6mu6FJhBdKRTzUs5WLbHoMtu9thuiV5VUF+ZQXm40IrzRIZWiLff9ZDBUpkGpCyFxui1vK0=
X-Received: by 2002:a05:6a21:a59a:b0:1a3:ac89:d478 with SMTP id
 gd26-20020a056a21a59a00b001a3ac89d478mr4309371pzc.1.1711751692095; Fri, 29
 Mar 2024 15:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327102036.543283-1-jolsa@kernel.org> <20240327102036.543283-3-jolsa@kernel.org>
 <CAEf4BzZps+OdPoyRz1=7mEzh=shjVjT=ZznhMD0Y-w98GW782g@mail.gmail.com>
In-Reply-To: <CAEf4BzZps+OdPoyRz1=7mEzh=shjVjT=ZznhMD0Y-w98GW782g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:34:40 -0700
Message-ID: <CAEf4BzaL0h52aNK0+Yd+dKDh8Dxh=V-LPDfgkVep9WKhTi6FwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add uretprobe syscall test
 for regs integrity
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:30=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 27, 2024 at 3:21=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > Add uretprobe syscall test that compares register values before
> > and after the uretprobe is hit. It also compares the register
> > values seen from attached bpf program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/include/linux/compiler.h                |   4 +
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 163 ++++++++++++++++++
> >  .../selftests/bpf/progs/uprobe_syscall.c      |  15 ++
> >  3 files changed, 182 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_sysca=
ll.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
>
> [...]
>
> > +__naked unsigned long uprobe_syscall_arch_test(void)
> > +{
> > +       asm volatile (
> > +               "movq $0xdeadbeef, %rax\n"
> > +               "ret\n"
> > +       );
> > +}
> > +
> > +__naked void uprobe_syscall_arch(struct pt_regs *before, struct pt_reg=
s *after)
>
> don't you get compiler warnings for using __naked with explicit
> function arguments?
>
> > +{
> > +       asm volatile (
> > +               "movq %r15,   0(%rdi)\n"
> > +               "movq %r14,   8(%rdi)\n"
>
> [...]
>
> > +       err =3D uprobe_syscall__attach(skel);
> > +       if (!ASSERT_OK(err, "uprobe_syscall__attach"))
> > +               goto cleanup;
> > +
> > +       uprobe_syscall_arch(&before, &after);
>
> uprobe_syscall_arch() doesn't really do an explicit `syscall
> uretprobe`, it should work for int3-based uretprobes as well? Let's
> call it something a bit more generic then?
>
> Also, I think patch #1 will go through Masami's trace tree, right? But
> we can land selftests into bpf-next even before that, given they
> should work for both syscall and interrupt based uretprobes.

Regardless the decision:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> > +
> > +       pp =3D (unsigned long *) &skel->bss->regs;
> > +       cnt =3D sizeof(before)/sizeof(*pb);
> > +
>
> [...]
