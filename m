Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F83C7E58C
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846587; cv=none; b=tvrQlAo4zb+oMa82+VFLagY+Nbyz/gloZkgXD4QuYuzHq8aQw2DYQaAIeX5V2yM4QhHBEgBG3lEfJHamJnj2f3QP0RK6s6NGQkeK5e0NcQSKh9EoL5Rr8dbkL0u0i3bjeZffd9m2mmBXko0ssbLgcH0OqYtL3lYnIY/DGOTT60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846587; c=relaxed/simple;
	bh=taw3dZ4nty8i+Hr2F9bo6ZVU+8h54TZWaTer0RJ/CeY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtyF6uKsXhg642druLNqfUKiVUIIWYeznq3iNsW0PdQNLhLVdWGbVViYytvdkmOh0c93JRfC2L2FK1cbmO9sNRyqAPhE+LFrnSYqw7GIjXgL3xjAgRTuqFj2U3HjegLyyQhmS9zYtp6OkPqOO33kfjOnY0wvLbN+NL1dXZ4/jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqLKx6+s; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqLKx6+s"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so59932931fa.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710846584; x=1711451384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LqwbKH+peqkSr3Sy/szTNpc3PA2H7tpF1tnS28ss3Oo=;
        b=OqLKx6+sYlOSREuFHBfjv1weBlBqhmrO5JquXpqemQCgPAd8PGRmKXNfprboHTn6Le
         IydvbeN2IhGBdA8tRI7ZIwD2+sloKuHQeZrviSYFz++i2XXuNyuw+E5ywEdGw1K8hVWx
         7Q5HGl3W5kUN0icGpH4kjoLp9CZs/KXy7o+xQl0AP7GQOfIG8cVuJ4koqGtoKjoHvPxD
         MLSTlbXmRGP6it3ARBQ9HACJXoGPvcwxxzmEXdusnZ8jXR/Zy+z82EtKDdUSi7KS91e+
         x4CaJHzZMypxTbMv0uG23QL0w46UtjBOrSY8iGMkjPiaQpXgpvIa28gpArZx+hDsSO/+
         1leg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846584; x=1711451384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqwbKH+peqkSr3Sy/szTNpc3PA2H7tpF1tnS28ss3Oo=;
        b=nyc7tapfiTVc2GLJVTcbZjVM+9ue0xNvJFzwJChJ+s2JFZ9oSORG3Te+QHROgu+ecP
         4kSpggaG6gffWokr47FbOIml5Y4K8dFzcnEtWrJQ6BRiSIN+uJJJkB0tST07NpRMUwM3
         r2k6uX5tFpR84ui2CL6JaqfgbzTWEZGGvSx2jVlQqNtfMvFaEMJgFo8EcTr8qSpKOxyF
         FwxJS84Zm7qK6RLbxrNSmaiZ7N6ThEGfXBL/Utu249jo2DXEScPaWmqebLUChmSJYSUZ
         3jnFmyt3z7pF80B1a6OpGVzz6vhV2ImDFFtousjEXrPJMgVAKAjvkeKtDEgiH3lVxsnu
         omyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/tMgid9i1fFkkkkue46/MzlR276UYp14r/5QuUAFyFHFNic5NHGBmXsdHGwTPWRaeLHn4sXtX+nXY8SmuVKf/3Xq1
X-Gm-Message-State: AOJu0Yx+VpJfkYSFwIwM9P6YPmMZVCr3sMYXa6G0Lo5uZglcX/0N+E15
	2rrK4IVUdvDiQyQcAjwC2QI31zEbuaB8qn9/O3cuvBcNQToZNA/8
X-Google-Smtp-Source: AGHT+IGfQ9wcbTDT9qRLQW61PYAaUkvcROJGuqugDDVm7+Qhian7WelIyNJkwCM/Q8bPoq0FNO0Xog==
X-Received: by 2002:a2e:9357:0:b0:2d3:f3bc:bb65 with SMTP id m23-20020a2e9357000000b002d3f3bcbb65mr9122874ljh.11.1710846583385;
        Tue, 19 Mar 2024 04:09:43 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h13-20020a0564020e0d00b00568b163c4easm4547153edh.11.2024.03.19.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:09:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 12:09:41 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 2/3] selftests/bpf: Add uretprobe syscall
 test
Message-ID: <ZflydR1hmBzbaPY2@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240318093139.293497-3-jolsa@kernel.org>
 <CAEf4BzZBkCxrwS=nuXnY5_g_BgNQkYYsVGcGp_zhn=CF4ypPdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZBkCxrwS=nuXnY5_g_BgNQkYYsVGcGp_zhn=CF4ypPdg@mail.gmail.com>

On Mon, Mar 18, 2024 at 06:16:09PM -0700, Andrii Nakryiko wrote:
> On Mon, Mar 18, 2024 at 2:32 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add uretprobe syscall test and compare register values before
> > and after the uretprobe is hit. Also compare the register values
> > seen from attached bpf program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile          | 13 ++-
> >  .../bpf/prog_tests/arch/x86/uprobe_syscall.S  | 89 +++++++++++++++++++
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 84 +++++++++++++++++
> >  .../selftests/bpf/progs/uprobe_syscall.c      | 15 ++++
> >  4 files changed, 200 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/arch/x86/uprobe_syscall.S
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
> >
> 
> Can all the above be achieved with inline assembly inside .c files? It
> would probably simplify logistics overall. We can guard with
> arch-specific #ifdefs, of course.

ok, probably yes.. I'll check

> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> > new file mode 100644
> > index 000000000000..0cc7e8761410
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <string.h>
> > +
> > +struct pt_regs regs;
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +SEC("uretprobe//proc/self/exe:uprobe_syscall_arch_test")
> > +int uretprobe(struct pt_regs *ctx)
> > +{
> > +       memcpy(&regs, ctx, sizeof(regs));
> 
> nit: please use __builtin_memcpy(), given this is BPF code. And we
> don't need string.h include.

right, thanks

jirka

> 
> > +       return 0;
> > +}
> > --
> > 2.44.0
> >
