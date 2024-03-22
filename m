Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E497F7FA
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144404; cv=none; b=LjllJ9EDziZ7s6tMZZkm+gN/jV4HyMX3GlUDWumholOxIPAxdW56aU+g2J3/8VO5FkAiCs1MZbCbWr1k/O096w8DV8BhYzWXhGZRbyRRCv4dV4DWNNfQT0C5x3XKSqGKPyCqzvdjC/rzP2640TyUJK4NZkNhZXWrsD2wvepcio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144404; c=relaxed/simple;
	bh=xihn3Qv79sjSdlIX71RvzuFuLyaMItjD1dcUG01KXqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLBnFH/xfgEnLOckP9rYCrdpoQM8EmA3V8J328hqScC91Ipa7OUn/nWduz+R20OWIGg5kXl9Z7/AJGw8LHOb15rPxVoSunKyP0/ODymi1woN3t2A1C5nPfw7SNDxH55AAHcYzkjp7jkS2PrROnY/3q6dWyTXqkPUXrr71HF4BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnHZ5nAy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnHZ5nAy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so538535b3a.1
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711144402; x=1711749202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg+ohytnIAnUt08QkxpOZXeGJQiYVQdzAdeuXhEJyJ4=;
        b=PnHZ5nAyIoKvLrg3QKoN9VExhaCL7sQZb2DizYvTXBXtjwCfIgh20gq17MwxMagVS7
         X0D+HgNf9edbTF7fTHUAE/lYP5w36OgmDhxvRXim34zcHYn+UqJCta5E9WHCnX0vgTux
         l1NZKOp2W7tQ0mt8QPEdbkwry+khKfbYbLkCKedOv7WPX83JN3rnENzyJfovmRFFLWB6
         eyPzDkKDVxjhFCxEQVSPutsYmliPC5iOAEP2bGv8UqIPhhd2oibE2Lx9Yr1+3VwsXYEO
         8qWS6GVF/60nrjx9+lFL24zWs2Us2UJqSMgj6olqULBO/4Xo9iBNcIFUHaN3WjHIraRB
         00Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144402; x=1711749202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg+ohytnIAnUt08QkxpOZXeGJQiYVQdzAdeuXhEJyJ4=;
        b=ZeQuwqTGDFyWZMmpJ+FXX7KG1N/rkBNDe6c99eDFc5erup9nIUJPxKKHUAUoNTZ4Qk
         xxiFQgbHmhY7J6Xh7qkeZSi/135kTqlEylsIC1nDYB7ODNVL3hLdQDM6i1WXSIQ4Pa84
         Y/a3AhpsxiCV/SVcYaotQ7qI6Qvd7KXx407uINlDGemiYsRWP3LUgA5YxNHUmMPEKcws
         YsXLKsThKPaw7HmJ41M8i99fSqyuxABU161lRdWHOQsIetrFfQC0Z/2cIWVryER+Jgex
         4wy8n3AILXqVfmWdhFoMOBifzrBwJUhes+YT7btfUObe8fxfU7KYRoIbw41uXB+VyMxn
         wW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIjrHNX3XqTMPwEWWY5szhJjmmKj96AK8hwY1vCWVNOu9B+XEhkmpup/kvQ1axL3W09cxrLPCcJnvxDjkLKXJe7Mok
X-Gm-Message-State: AOJu0Yyz4QG1/Xauk1rPQ0z5bTSU4bAIqEnCsdE5cHoVhv/VQQP7K+y9
	tdNis9mFMdJaM1gB5KDL7iapVZ95S8/xFqScIm4+efDUyDdtSzun8DMi9javboDFTj8dIGTtes/
	j/bhH3CteU7DIrGaBPNzYnZApRNHne0W/
X-Google-Smtp-Source: AGHT+IFDfSLoxWfD005WRjX/qzVN6mmi3uBUHBqOIxr4IUgVOS4Z1QwmMu1Dz+rw9XPdZkcWjXIIzpMeWIucMKXVmjY=
X-Received: by 2002:a17:90b:218e:b0:29d:e2dc:bf5d with SMTP id
 ku14-20020a17090b218e00b0029de2dcbf5dmr289596pjb.16.1711144401694; Fri, 22
 Mar 2024 14:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200119.2220027-1-yonghong.song@linux.dev> <Zf17ovmfcfAfAIBa@krava> <3c6729b3-f28c-4fc4-9f2e-4297185e8fa6@linux.dev>
In-Reply-To: <3c6729b3-f28c-4fc4-9f2e-4297185e8fa6@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 14:53:09 -0700
Message-ID: <CAEf4Bzbz3Z-NfcJM3h4mLV43E1rFEAO4hY7PmpnMTZxct0TkEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Fix kprobe_multi_bench_attach
 test failure with LTO kernel
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:01=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 3/22/24 5:37 AM, Jiri Olsa wrote:
> > On Thu, Mar 21, 2024 at 01:01:19PM -0700, Yonghong Song wrote:
> >> In my locally build clang LTO kernel (enabling CONFIG_LTO and
> >> CONFIG_LTO_CLANG_THIN), kprobe_multi_bench_attach/kernel subtest
> >> failed like:
> >>    test_kprobe_multi_bench_attach:PASS:get_syms 0 nsec
> >>    test_kprobe_multi_bench_attach:PASS:kprobe_multi_empty__open_and_lo=
ad 0 nsec
> >>    libbpf: prog 'test_kprobe_empty': failed to attach: No such process
> >>    test_kprobe_multi_bench_attach:FAIL:bpf_program__attach_kprobe_mult=
i_opts unexpected error: -3
> >>    #117/1   kprobe_multi_bench_attach/kernel:FAIL
> >>
> >> There are multiple symbols in /sys/kernel/debug/tracing/available_filt=
er_functions
> >> are renamed in /proc/kallsyms due to cross file inlining. One example =
is for
> >>    static function __access_remote_vm in mm/memory.c.
> >> In a non-LTO kernel, we have the following call stack:
> >>    ptrace_access_vm (global, kernel/ptrace.c)
> >>      access_remote_vm (global, mm/memory.c)
> >>        __access_remote_vm (static, mm/memory.c)
> >>
> >> With LTO kernel, it is possible that access_remote_vm() is inlined by
> >> ptrace_access_vm(). So we end up with the following call stack:
> >>    ptrace_access_vm (global, kernel/ptrace.c)
> >>      __access_remote_vm (static, mm/memory.c)
> >> The compiler renames __access_remote_vm to __access_remote_vm.llvm.<ha=
sh>
> >> to prevent potential name collision.
> >>
> >> The kernel bpf_kprobe_multi_link_attach() and ftrace_lookup_symbols() =
try
> >> to find addresses based on /proc/kallsyms, hence the current test fail=
ed
> >> with LTO kenrel.
> >>
> >> This patch removed __access_remote_vm and other similar functions from
> >> kprobe_multi_attach by checking if the symbol like __access_remote_vm
> >> does not exist in kallsyms with LTO kernel. The test succeeded after t=
his change:
> >>    #117/1   kprobe_multi_bench_attach/kernel:OK
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   .../selftests/bpf/prog_tests/kprobe_multi_test.c     | 12 ++++++++++=
++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.=
c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> index 05000810e28e..f6130f4f3d88 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> >> @@ -345,6 +345,9 @@ static int get_syms(char ***symsp, size_t *cntp, b=
ool kernel)
> >>      FILE *f;
> >>      int err =3D 0;
> >>
> >> +    if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> >> +            return -EINVAL;
> >> +
> >>      /*
> >>       * The available_filter_functions contains many duplicates,
> >>       * but other than that all symbols are usable in kprobe multi
> >> @@ -393,6 +396,15 @@ static int get_syms(char ***symsp, size_t *cntp, =
bool kernel)
> >>              if (!strncmp(name, "__ftrace_invalid_address__",
> >>                           sizeof("__ftrace_invalid_address__") - 1))
> >>                      continue;
> >> +            /*
> >> +             * In certain cases, e.g., clang lto kernel, the 'name' h=
ere
> >> +             * may be different from the one in /proc/kallsyms due to
> >> +             * /proc/kallsyms name might be "<name>.llvm.<hash>" inst=
ead
> >> +             * of "<name>". Exclude these 'name's since they will cau=
se
> >> +             * later kprobe_multi_attach failure.
> >> +             */
> >> +            if (ksym_get_addr(name) =3D=3D 0)
> >> +                    continue;
> > curious how many symbols like that are there?
>
> The number of entries in /sys/kernel/tracing/available_filter_functions: =
50654
> After existing filtering ('arch_cpu_idle') etc: 50513 (filtering 141)
> After above ksym_get_addr(name) check: 49437 (further filtering 1076)
>

alternatively, you could have found matching func.llvm.* for any func
in available_filter_functions. Have you considered that?

> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > jirka
> >
> >>
> >>              err =3D hashmap__add(map, name, 0);
> >>              if (err =3D=3D -EEXIST) {
> >> --
> >> 2.43.0
> >>
> >>
