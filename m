Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5C28DC1
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751079; cv=none; b=owEFPd3/A7A/77Du7wEf13hYec/Z7CJ6YntPHW6XjA5J8dS/sbByDneFxQYzatmcp2rfXNqJTWqopOeR5Ku56o+5BFaVLV1EBejiETIy2toL8ioVgC0Kgh2tuc6dYHIp/KOigq3vBCpFete8Bksdvx8YHH0htZ2v/uq7+UnF9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751079; c=relaxed/simple;
	bh=iZOtJzg8K1icR2/0aS96DfbalxXpy8vDTbdV+OCD93A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrGkWY0WBFvEQHKAd2IQ0VXmQ3OvB7xxlFvtGOgGIXI2+yUTlc0wA1KvIDXEdSoImKwuMtxShfWMGLKSRQh9AhrwHbWEm/gWtwlZM/CIZXSHWJt5x7jOiujX/6SxmGYs6ozUP0dsGrYJ516sjlMpQkMHTSeN+PomGcvQ1Riuplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlELE9VA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlELE9VA"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1684498a12.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711751077; x=1712355877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9yG8XjU7MloqXzmL7VIUnYlW55ptSST+5pV2/6iufo=;
        b=dlELE9VAiHNWNj2CZENJ7zqzCJ0+C3zx8fcVJIGUf9T1hxlhcwL9cKrjjaDnEpikSF
         1ospu6y4BeO7pydC3wi9DD17lVfupaQTIId8feLaQJxnkRLIEEiBrinprwBzOWUZGuVE
         CiCu+ODa39sA/DpGrlKWSty/PyHpyU6dOMsqKvtgMCR7skAeSd6IrJhs2xTFU43WEtkk
         Wtyz+JAYF0ckgsdFWhqgj4R8ygLmO53/foG504GJa9HALeQKPe6uRj8iUd8EJKWe/RFk
         3zKWVU9YB9Qz9ZA1rL9viGGtQiS5zH+ICS2cqtzc6i0zHyeuLxeyX3cn6vxQkNX3SHcG
         ZX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711751077; x=1712355877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9yG8XjU7MloqXzmL7VIUnYlW55ptSST+5pV2/6iufo=;
        b=PBbM03EtIngySeP7mZWTEukoAWA225inmLyshAhgsEEfVaF+xxW7Ez9Q1eikpxSFKm
         9dG6Gx8F8xFgvEXoKEmH3YklXIRvY8IrU3J5qkpOafm0/TgqzZEPAlZfZ/7i5Lfx94Yj
         UGFrKW2vnFmDfacepzOJyMxdlrpQcpLe+rQ56+MagdZQ0dPdt77fR7xySHj/a+/s7+VJ
         GmCnl15Ud9qFK2uPo4whjOITSV8QNPUc7hLoj6s2S3h5wSYaU4lfeczIX11vY+Q/jtld
         m7j64L+dQfdDDGIa+UlgjKEhqHDmTSz7xp00GMVEN58v4+vrmqnKEE0a0/rV57inDHKB
         aYLg==
X-Forwarded-Encrypted: i=1; AJvYcCWVt/TgjYUkYKAQ1kWjL/EXMeAuBZjz5mb6/hEo5i5TkmSEOHmgIUnitQTFegnBfd78h8aex7y83WQydXqGlNaa2huV
X-Gm-Message-State: AOJu0YzkWqZfJxRIomnMm2upFhSq+FirT2pRnew9BCzndO7tweRAVGwZ
	goFYOK7QeTLCG2+Nvmh0U/yg4OUsRGgX8oNZ+1mjUaseJdUtrRAe48B6kD4lytPLc0AfNM9zgtF
	qKPREMGiMbuLh+XBtc8z3ZywsoQa6iyw9AAE=
X-Google-Smtp-Source: AGHT+IElqPyQ8gGPj7TCrZfMfKCYzRKgyKxn6ClIRC/jSdnI6qVuCA5DttWghTvX1VwlN7PEoo4gQ0rGyyS9nZmPxAc=
X-Received: by 2002:a17:90a:134b:b0:2a1:fe2c:75e9 with SMTP id
 y11-20020a17090a134b00b002a1fe2c75e9mr3554574pjf.42.1711751077248; Fri, 29
 Mar 2024 15:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327102036.543283-1-jolsa@kernel.org> <20240327102036.543283-2-jolsa@kernel.org>
In-Reply-To: <20240327102036.543283-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:24:24 -0700
Message-ID: <CAEf4BzbLaeTcDUWrB91kSRLDuA9dwvjv_kAewHBWW9HFnTWWgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] uprobe: Add uretprobe syscall to speed up
 return probe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:20=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding uretprobe syscall instead of trap to speed up return probe.
>
> At the moment the uretprobe setup/path is:
>
>   - install entry uprobe
>
>   - when the uprobe is hit, it overwrites probed function's return addres=
s
>     on stack with address of the trampoline that contains breakpoint
>     instruction
>
>   - the breakpoint trap code handles the uretprobe consumers execution an=
d
>     jumps back to original return address
>
> This patch replaces the above trampoline's breakpoint instruction with ne=
w
> ureprobe syscall call. This syscall does exactly the same job as the trap
> with some more extra work:
>
>   - syscall trampoline must save original value for rax/r11/rcx registers
>     on stack - rax is set to syscall number and r11/rcx are changed and
>     used by syscall instruction
>
>   - the syscall code reads the original values of those registers and
>     restore those values in task's pt_regs area
>
> Even with the extra registers handling code the having uretprobes handled
> by syscalls shows speed improvement.
>
>   On Intel (11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz)
>
>   current:
>
>     base           :   15.888 =C2=B1 0.033M/s
>     uprobe-nop     :    3.016 =C2=B1 0.000M/s
>     uprobe-push    :    2.832 =C2=B1 0.005M/s
>     uprobe-ret     :    1.104 =C2=B1 0.000M/s
>     uretprobe-nop  :    1.487 =C2=B1 0.000M/s
>     uretprobe-push :    1.456 =C2=B1 0.000M/s
>     uretprobe-ret  :    0.816 =C2=B1 0.001M/s
>
>   with the fix:
>
>     base           :   15.116 =C2=B1 0.045M/s
>     uprobe-nop     :    3.001 =C2=B1 0.045M/s
>     uprobe-push    :    2.831 =C2=B1 0.004M/s
>     uprobe-ret     :    1.102 =C2=B1 0.001M/s
>     uretprobe-nop  :    1.969 =C2=B1 0.001M/s  < 32% speedup
>     uretprobe-push :    1.905 =C2=B1 0.004M/s  < 30% speedup
>     uretprobe-ret  :    0.933 =C2=B1 0.002M/s  < 14% speedup
>
>   On Amd (AMD Ryzen 7 5700U)
>
>   current:
>
>     base           :    5.105 =C2=B1 0.003M/s
>     uprobe-nop     :    1.552 =C2=B1 0.002M/s
>     uprobe-push    :    1.408 =C2=B1 0.003M/s
>     uprobe-ret     :    0.827 =C2=B1 0.001M/s
>     uretprobe-nop  :    0.779 =C2=B1 0.001M/s
>     uretprobe-push :    0.750 =C2=B1 0.001M/s
>     uretprobe-ret  :    0.539 =C2=B1 0.001M/s
>
>   with the fix:
>
>     base           :    5.119 =C2=B1 0.002M/s
>     uprobe-nop     :    1.523 =C2=B1 0.003M/s
>     uprobe-push    :    1.384 =C2=B1 0.003M/s
>     uprobe-ret     :    0.826 =C2=B1 0.002M/s
>     uretprobe-nop  :    0.866 =C2=B1 0.002M/s  < 11% speedup
>     uretprobe-push :    0.826 =C2=B1 0.002M/s  < 10% speedup
>     uretprobe-ret  :    0.581 =C2=B1 0.001M/s  <  7% speedup
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  arch/x86/kernel/uprobes.c              | 83 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  2 +
>  include/linux/uprobes.h                |  2 +
>  include/uapi/asm-generic/unistd.h      |  5 +-
>  kernel/events/uprobes.c                | 18 ++++--
>  kernel/sys_ni.c                        |  2 +
>  7 files changed, 108 insertions(+), 5 deletions(-)
>

Great work and results, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
