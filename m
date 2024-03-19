Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B522C8E1
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710810983; cv=none; b=D650hy/03U0rcytFhUK87ON+VcJs2xg8RucVLtHL3McZcsHvBfidVbGeuDrQXKo670YEj/SmrDH8IsZsciv7P2cctwwv2s1Rh/ePb8wl0ZIPQtnG02xfS766ABuM+ykhWUvnLFwAEXZglrNgCEPYWymdsSYCmf9ygLZFhjlypFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710810983; c=relaxed/simple;
	bh=aaRaRgLL9OKAxPksE6h3hS0+vGkgHkbIrDiQAWCFDvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlwEZnDAh2zHW9bZiiUJaOa3spLA/e0bL2uqZ/Fqg79S7xGC62oUS3eK7Vgjy+gvrMcb5S4NBgthMhP5OCvugeeaG0tLFCAX0AclqYwCkxR2YeeGVSec0iUjsbdhNv43APUynFMYgihazfF0Eu3Xlj/M8f+hZQfFO0WjQ9Y7E7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZwo6cLR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZwo6cLR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dff837d674so18028395ad.3
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710810981; x=1711415781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3/pYdbNwGysQ5llS3OHmWatyvuPpGNUmgH+uuYCKxQ=;
        b=fZwo6cLRoCsPaYKMhS04AP9rLNe9kNypYjBeqBCl7ApqXqbhly9LTe4ZirDggTPiM/
         1r3X7CDllvqtSr+sr0Awob3WQvDF72DMY6hbrQDJtEmTJRnypzVtbsiRcUl2yjqkmDRc
         ATC7WQRQWEPIHzPIo+3Bhv6kvnDLNC86dgUj14MRRs1ij2X/c879eigVyQn1wfFJHuRV
         xuthOXBMlEN75UuMYh9TcaBgcrgc6h7TyytSIKwGBsD67A16S1dVniuEnfjJ/HCrJ6NU
         zV0Lw4NKOtSKLYasqE5tS2J+8m6G3rTpCz3h1JjNNVaeSAfbxnxhZWtIiS3BoTHpSMcl
         GNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710810981; x=1711415781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3/pYdbNwGysQ5llS3OHmWatyvuPpGNUmgH+uuYCKxQ=;
        b=QgYbw1De8robf5IoGy3N0AywFPbq+ZO9JS9GkOS6N/x6flWu6M3Doqkb7BgsFOYmG7
         vm6hJ0tYWZGYLYPYHi5PEW6gAeP9SiKbrnZiGTLYq0kTw48AXHVIv7L9ddNBeL5IZlU2
         pD7VWzZaT6x+d0l00Z7XNIWxUMuz2qjLgsK2IUb6ddxpXx7E3zmhGaUcf/P2oQsRkVPS
         zjVzrIFB4RATQRpBv6UcwlJhfAJvrQEheYaaLOFSBLAPyk/NaC5LBGipunCSrROH891D
         +3MbLtOiYlugM5JqbJva6SmwmJ9AQydO/6fbrCpYlj1JTGxdUQN9Uinbt6Nw6NpidsRK
         HUjA==
X-Forwarded-Encrypted: i=1; AJvYcCUaGwPkhCjAuRdRJw3Cs/woX9zk4CrkJSUTP3zzXV5qzzSg+oioFF8+w0ffccNvwth/jfvIW28LJiyE0tIpSwCLggBa
X-Gm-Message-State: AOJu0YwW4auIpS09DGbDJkF3K9iovjsQV/HwMMmvz8cZt5+dG3SNFxA3
	aeHFaj62reIyqARt4ZB26dNEmZ8AnGF0gfsY27b2hpK5KexfRUbgNG/2fI4yfexRXVSB0je2chS
	AopFu58G2u1fqKLr282pA87nXz/x3qrGn
X-Google-Smtp-Source: AGHT+IEKLGFLDiKHoEFBEj81hpn/jzD6oKWqGoY8CNHKAFBAoFyBlr2yWQ8mIVL4bNyaZw+GK6NuD8KeXaIJUbMxGtQ=
X-Received: by 2002:a17:90b:180f:b0:29b:a292:6c44 with SMTP id
 lw15-20020a17090b180f00b0029ba2926c44mr1238236pjb.10.1710810981145; Mon, 18
 Mar 2024 18:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318093139.293497-1-jolsa@kernel.org> <20240318093139.293497-3-jolsa@kernel.org>
In-Reply-To: <20240318093139.293497-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Mar 2024 18:16:09 -0700
Message-ID: <CAEf4BzZBkCxrwS=nuXnY5_g_BgNQkYYsVGcGp_zhn=CF4ypPdg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] selftests/bpf: Add uretprobe syscall test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:32=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add uretprobe syscall test and compare register values before
> and after the uretprobe is hit. Also compare the register values
> seen from attached bpf program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          | 13 ++-
>  .../bpf/prog_tests/arch/x86/uprobe_syscall.S  | 89 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 84 +++++++++++++++++
>  .../selftests/bpf/progs/uprobe_syscall.c      | 15 ++++
>  4 files changed, 200 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arch/x86/uprob=
e_syscall.S
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
>

Can all the above be achieved with inline assembly inside .c files? It
would probably simplify logistics overall. We can guard with
arch-specific #ifdefs, of course.

[...]

> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/t=
esting/selftests/bpf/progs/uprobe_syscall.c
> new file mode 100644
> index 000000000000..0cc7e8761410
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <string.h>
> +
> +struct pt_regs regs;
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("uretprobe//proc/self/exe:uprobe_syscall_arch_test")
> +int uretprobe(struct pt_regs *ctx)
> +{
> +       memcpy(&regs, ctx, sizeof(regs));

nit: please use __builtin_memcpy(), given this is BPF code. And we
don't need string.h include.

> +       return 0;
> +}
> --
> 2.44.0
>
