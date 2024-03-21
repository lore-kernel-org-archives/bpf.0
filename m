Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189F133402
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052920; cv=none; b=V0GGg0CHM3tP3m5tmmwwUnRR2Y890GAad6+Ky6BIBP/Vc4d0q0yviyjIpp6xDtGuNrk99Mk6F67TzYp8jQO59hwLa3Lzhfamq2lBOjkFymllT7+06Xfmfp6tzj0cX0HIIc3P9LIAtMJqEvZKS84HMqa2mF8sCmQkUMejMW6Y6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052920; c=relaxed/simple;
	bh=joyiRWMi1gfh98TOB7h9kvVBnVauyfiLCC+cRiBHogs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEQeklVzgadPbpp7XZPgBtLFbyYQ4JpgGnGesEqxbzAKd7tO+Dt/Gqavo199dWb6ZGIguH//cC8D+kkA7iIHPOCbl/jDw/Jr7F/bwDGr2lITNTMY2pUontQgSDNBoafvNR0Fgh0HBwh2RKGGEBRYp0XCjEpXGQ8oqi3f3NVEBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgR6bzSu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgR6bzSu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so986287b3a.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711052918; x=1711657718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ7IwhdtpIZ2FqXT+EGvDfN6UmkcNpMhR3K5Cdsd9GU=;
        b=XgR6bzSu4JRf/Dt7iHrN+kQyG06cQPqG3S2XarkgJwQm6v8Gc1U4FE7fIrs4U+CmsE
         tu71lf7fZFRzrHEEUQBB0xk4DrxlOuB4+3cDBz2xBOCwVtuknNShTyad+tZXsDTsHNRl
         /WLGF7go9FHpz1t4RT8BBK0cIPfEHJdlzv7PvZ5BlKfdJ8g9ENg8IoA3IUrhbSshIVj1
         OAnd7NukwNXQv12aW09T3+qcApnYQ8FtJEvLFNyqiFLWa/Dg1lYnUNzr8/VM4i1XIwSR
         WIdqahGwaDe/SUg/rF3tLrOOEfg3q3Jius57bBk+gOeY//s6N2gOG2T0bgewXDfKY2Ag
         leDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052918; x=1711657718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ7IwhdtpIZ2FqXT+EGvDfN6UmkcNpMhR3K5Cdsd9GU=;
        b=pa1h9NSSlq6DHLvumhvqCo/UXr+wE42ntTn094Kq5Q+uPmkox94BkwBN265TMUAdUR
         KzBce/OpuN80gfExZwZW40nNOkUaHYIkOKDwfo2+0nlNMGUVHSVc6pbXoGG5V7dr88ee
         oOlIlUQOVJW5x3F2BwYMd+k8Bqmm8iTiekN10THg4d1dwZswpzb95/aTdWnzrjSU+pC1
         rGYUQPhgORB9AQmYVV67tNww+xjq4/CWge/QvJi1EqHggkWWjgiuTNm+tZxrFE6AiKTn
         SxOg14OQ0rbxQ2exPfbLD8DX9R9Z0mTZZfj2mI2sMqSPcfUfYVSIZJ279yJXCFs436ci
         r3lw==
X-Gm-Message-State: AOJu0YxQwI1HPUr4/9PfSOgGJkuDhSt0hYlyeI1EUBmuTwGK+Kb3vNxr
	qQM4POoNjFUDzpZqBbBH5ee4Gv3GimPfGZlU9X76jk/dFwabABoCCGG1ZtU2ys0/bCoXM1gEJEV
	59rzCf6JpqJQcHrfM5FD3KQTzjQL8Dpi/E1E=
X-Google-Smtp-Source: AGHT+IHe++LLNhzh/6jHACDV3iYrNJZxTYGtvUyCVZIDVYti0PVjmsPyMdmrKDmVMFOolq2WPM46kEovfGA45MvD8Go=
X-Received: by 2002:a05:6a00:9388:b0:6e8:f9f0:2ca4 with SMTP id
 ka8-20020a056a00938800b006e8f9f02ca4mr537299pfb.2.1711052918513; Thu, 21 Mar
 2024 13:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfyEgoG3JFiOs2Fs@x1>
In-Reply-To: <ZfyEgoG3JFiOs2Fs@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 13:28:26 -0700
Message-ID: <CAEf4Bzapg3=uyyCeWYs+D=7O1jcr9=JO2B11+WAcbS=7F=T4JQ@mail.gmail.com>
Subject: Re: libbpf: Build failures due to access to out of tools/ headers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:03=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Andrii,
>
>         I think that after this patch:
>
> commit 9eea8fafe33eb70868f6ace2fc1e17c4ff5539c3
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Thu Jan 25 12:55:05 2024 -0800
>
>     libbpf: fix __arg_ctx type enforcement for perf_event programs
>
>     Adjust PERF_EVENT type enforcement around __arg_ctx to match exactly
>     what kernel is doing.
>
>     Fixes: 76ec90a996e3 ("libbpf: warn on unexpected __arg_ctx type when =
rewriting BTF")
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>     Link: https://lore.kernel.org/r/20240125205510.3642094-3-andrii@kerne=
l.org
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org
>
>
> I'm seeing:
>
>   19     5.42 debian:experimental-x-arm64   : FAIL gcc version 13.2.0 (De=
bian 13.2.0-12)
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal e=
rror: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or d=
irectory
>         2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>       LD      /tmp/build/perf/libperf/libperf-in.o
>       LD      /tmp/build/perf/libapi/libapi-in.o
>       AR      /tmp/build/perf/libperf/libperf.a
>       AR      /tmp/build/perf/libapi/libapi.a
>     In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_pe=
rf_event.h:11,
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal e=
rror: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or d=
irectory
>         2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>     make[4]: *** [/git/perf-6.8.0/tools/build/Makefile.build:105: /tmp/bu=
ild/perf/libbpf/staticobjs/libbpf.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>       LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
>       AR      /tmp/build/perf/libsubcmd/libsubcmd.a
>     make[3]: *** [Makefile:157: /tmp/build/perf/libbpf/staticobjs/libbpf-=
in.o] Error 2
>
>   44     4.47 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubu=
ntu 7.5.0-3ubuntu1~18.04)
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal e=
rror: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or d=
irectory
>      #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>       LD      /tmp/build/perf/libapi/libapi-in.o
>       AR      /tmp/build/perf/libapi/libapi.a
>       LD      /tmp/build/perf/libperf/libperf-in.o
>       AR      /tmp/build/perf/libperf/libperf.a
>     In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_pe=
rf_event.h:11:0,
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal e=
rror: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or d=
irectory
>      #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>     /git/perf-6.8.0/tools/build/Makefile.build:105: recipe for target '/t=
mp/build/perf/libbpf/staticobjs/libbpf.o' failed
>     make[4]: *** [/tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>       LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
>       AR      /tmp/build/perf/libsubcmd/libsubcmd.a
>   45     4.79 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubu=
ntu 7.5.0-3ubuntu1~18.04)
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:6:10: fatal e=
rror: ../../arch/s390/include/uapi/asm/bpf_perf_event.h: No such file or di=
rectory
>      #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>       LD      /tmp/build/perf/libapi/libapi-in.o
>       LD      /tmp/build/perf/libperf/libperf-in.o
>       AR      /tmp/build/perf/libperf/libperf.a
>       AR      /tmp/build/perf/libapi/libapi.a
>     In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_pe=
rf_event.h:11:0,
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:6:10: fatal e=
rror: ../../arch/s390/include/uapi/asm/bpf_perf_event.h: No such file or di=
rectory
>      #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>     /git/perf-6.8.0/tools/build/Makefile.build:105: recipe for target '/t=
mp/build/perf/libbpf/staticobjs/libbpf.o' failed
>     make[4]: *** [/tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>       LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
>       AR      /tmp/build/perf/libsubcmd/libsubcmd.a
>
>
>   51     4.78 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.4.0 (Ub=
untu 11.4.0-1ubuntu1~22.04)
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal e=
rror: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or d=
irectory
>         8 | #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>       CC      /tmp/build/perf/libbpf/staticobjs/usdt.o
>       CC      /tmp/build/perf/libbpf/staticobjs/zip.o
>       CC      /tmp/build/perf/libbpf/staticobjs/elf.o
>       CC      /tmp/build/perf/libbpf/staticobjs/features.o
>     In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_pe=
rf_event.h:11,
>                      from libbpf.c:37:
>     /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal e=
rror: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or d=
irectory
>         8 | #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>     make[4]: *** [/git/perf-6.8.0/tools/build/Makefile.build:105: /tmp/bu=
ild/perf/libbpf/staticobjs/libbpf.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>       LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
>       AR      /tmp/build/perf/libsubcmd/libsubcmd.a
>     make[3]: *** [Makefile:157: /tmp/build/perf/libbpf/staticobjs/libbpf-=
in.o] Error 2
>
>
> When building out of the kernel sources tree, i.e. when build perf from
> a tarball, which seems to indicate that tools/lib/bpf/libbpf.c is
> accessing out of tools/ files from the kernel.

It's an UAPI header (linux/bpf_perf_event.h), and it includes
arch-specific asm/bpf_perf_event.h. Any suggestions how it should be
handled in a way that works for you?

>
> - Arnaldo
