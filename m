Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B51FB5
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751425; cv=none; b=NhULZN+JNrtm04x6e3e5RVtCMsyTSRbsYbO8zw/OdRnvsXmrf/R+GOz99l9V8ThIJvTfL+fYlc7G+QtQRU4BEdWLOWC0/GR56OHv7oB9x+LLyZ/w9qWnp1BLJdSbtIFaHTYUfs5P+P4ZrNC9i/PMI+48LdGdwoJJBYmvMJ/VwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751425; c=relaxed/simple;
	bh=RfjKOagSpO1o3yYmbXa3C82h+GH+dWRkliYM6RspMYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9Pk5rtWFhA2cwO99gHSEAUCJfFb5yY3/UpPkbk2AcsCdBdfC/Gf1PQI3j7u1NUSI15P1H1rPfYnnhkp/yo/Yf3TCVw60VAQk60jVyC+Y5R2uXaeQyneZdoMYsI1aAlyejIHW6VK1SgDhXwHTU6BgunAiXMJsCdYGQ/13MUKeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyxqnQzD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyxqnQzD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6b22af648so2466402b3a.0
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711751423; x=1712356223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EuPvGT2iMPz7frJTO0sNehTfeVpTth/kUgXG/Uy1WE=;
        b=fyxqnQzDt1WZ3RWsli3ssoh0598a2aKyrSN27L7CoDCsyj4sKquA7yzHXE6W8Z7nh+
         qshg6nhoW+kHWmHh/PrsMjjI2fxAK4pHkiV/JDRoTCmPo+wmxDQjmpcC613LUUyiqkLx
         BLYsPenDTrkSc/1GlCKN5ZEjxCnCf0wepv4xYpD0J1/QATJVwaQBjCxl96h55R2TVbzT
         nTcxeZorOyD8m4YJcbFF1zjBB0OKF76e0ae9OyfReDKzJclRwayDG2KV4Zk7SFCNdlWy
         Ov72sAwCW8tqMa48lc0y9viXEnouOs8wguUud0NtGAges1WGF0/cxM+0nn9uxIpA1qnc
         aMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711751423; x=1712356223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EuPvGT2iMPz7frJTO0sNehTfeVpTth/kUgXG/Uy1WE=;
        b=NOnNrzrN2j4LkKzCaUTfQnrMNlo025TLBM6SQi/Qh0+KJOXYDYfM43zKddu81GCjza
         P7MO5fFyqrCYEhm0LojWheMfLONuBq0Qxw4hBmgaOFv+eIATngGCsg4V1tv96kwz8PuR
         m6uDewms+/Q2uuDLs1t4GkZn4ZJXfA9ktJM0+5Um/43XCIzJGDjTPdzRGoUehZfDqaSy
         kSVt+MXejYjTiReDr46ccOojsHkXjotyf9RGBcR1MrIWXPV0e0qhziRpG5ldipzcURQS
         cEwf+qx7kKMVVgvM5bssvHAxbcVJHWuD0+Rk7YwO61IZPm6UB1C5gdF6P5CJsFM41DJY
         lrKA==
X-Forwarded-Encrypted: i=1; AJvYcCX03osCXJwJtLXka4+U9P+Z+aPYx6NSHZJvrnNxsud/yZAvTNyHOqIj7SwyuUgPdhcvSSYqyxgP9pgv98R7KI5wvPEc
X-Gm-Message-State: AOJu0YzCLes03dq/jHTozAiVmrzfXznMx0FpI3UDeppkBylQGmH/wK6X
	wySQVOdahy0byFaDKOiJp72uz/2vn9qrwpzbjkVnFVz1d0q3hHZREeodGdGS5nkz++valqPnwOf
	nxvEzCVG3jrsL32LFB056xaorBBA=
X-Google-Smtp-Source: AGHT+IHfFY47J2LV96KYoKsQ1PW5+kHdt2LP3CEVE/tI3hFroFsKfwwUMQ9tn57rkZbzh9mVBzaJPnkIF292CdOTRFI=
X-Received: by 2002:a17:902:654f:b0:1e0:b5ee:e9cb with SMTP id
 d15-20020a170902654f00b001e0b5eee9cbmr7715514pln.22.1711751423344; Fri, 29
 Mar 2024 15:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327102036.543283-1-jolsa@kernel.org> <20240327102036.543283-3-jolsa@kernel.org>
In-Reply-To: <20240327102036.543283-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:30:11 -0700
Message-ID: <CAEf4BzZps+OdPoyRz1=7mEzh=shjVjT=ZznhMD0Y-w98GW782g@mail.gmail.com>
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

On Wed, Mar 27, 2024 at 3:21=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add uretprobe syscall test that compares register values before
> and after the uretprobe is hit. It also compares the register
> values seen from attached bpf program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/include/linux/compiler.h                |   4 +
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 163 ++++++++++++++++++
>  .../selftests/bpf/progs/uprobe_syscall.c      |  15 ++
>  3 files changed, 182 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c

[...]

> +__naked unsigned long uprobe_syscall_arch_test(void)
> +{
> +       asm volatile (
> +               "movq $0xdeadbeef, %rax\n"
> +               "ret\n"
> +       );
> +}
> +
> +__naked void uprobe_syscall_arch(struct pt_regs *before, struct pt_regs =
*after)

don't you get compiler warnings for using __naked with explicit
function arguments?

> +{
> +       asm volatile (
> +               "movq %r15,   0(%rdi)\n"
> +               "movq %r14,   8(%rdi)\n"

[...]

> +       err =3D uprobe_syscall__attach(skel);
> +       if (!ASSERT_OK(err, "uprobe_syscall__attach"))
> +               goto cleanup;
> +
> +       uprobe_syscall_arch(&before, &after);

uprobe_syscall_arch() doesn't really do an explicit `syscall
uretprobe`, it should work for int3-based uretprobes as well? Let's
call it something a bit more generic then?

Also, I think patch #1 will go through Masami's trace tree, right? But
we can land selftests into bpf-next even before that, given they
should work for both syscall and interrupt based uretprobes.

> +
> +       pp =3D (unsigned long *) &skel->bss->regs;
> +       cnt =3D sizeof(before)/sizeof(*pb);
> +

[...]
