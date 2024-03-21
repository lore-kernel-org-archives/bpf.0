Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE31133435
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047814; cv=none; b=pubO8YVVb2T9IFVXkRiWXMegQXFxDy2YWLHKRjNLFab3vuvXCVPEr3XWx144dhZx7wCUQxQrq0y9Nnl1jyyoGR2UJUi82hwHu/2miqKfz24cVBKRcfZf2dxtN3WV3Rz5n056ep93mcHKA3GsyyzgYoHG0QIxk1wfQ3LFTGwLVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047814; c=relaxed/simple;
	bh=hv/szxd7dDZoPEmemCmBb02Md+/FJNSvuafAoJgBbp8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pm27QT6QPX7l26TcKruI2adObqRt0alxQpXJLy1MAX5GQT+hLLb3aMzIKsq9VyQZwWB0arX3XQdnI93hUdn6ZyRvWqIggVPhxJjkWRbWVfn2/q3uSz/VkrvvIncJtwRjW247YgFlpnyY+o90O+x7Xhr26UFK70NenS/auP370D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO4/h/Xm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO4/h/Xm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA12C43390;
	Thu, 21 Mar 2024 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711047814;
	bh=hv/szxd7dDZoPEmemCmBb02Md+/FJNSvuafAoJgBbp8=;
	h=Date:From:To:Cc:Subject:From;
	b=gO4/h/XmTw2uR4r/loT2o7VAgfO5rzFgHihScSCpwNx+c8RhGmyc8+OAK7NCQ34qo
	 FlO6po5Fo6hAxQ7HINaPmVg7tcjymdK13gaaQtDDHP5D9zmcNl8mwSe8Ft8LWoVGfD
	 TGnrpZm6YYwPgTAXlT6QYAFNrJilSEkPH+eNmZMpAWlejqophXDfBRMQuOFxWGg8/q
	 IC3E8RvNiJeurX/W6mZrMpCZFlRIbzDWDc6awtaosf/K5d7WW9/n9iOr11HpT+7FfP
	 +QuAvReiLgSBXvToDka3flKFeEM4ZsgRLqcrtQX0hBLDb6FQSy+uuZIR2/H/obr0U0
	 PJlD73/eYP5zQ==
Date: Thu, 21 Mar 2024 16:03:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: libbpf: Build failures due to access to out of tools/ headers
Message-ID: <ZfyEgoG3JFiOs2Fs@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrii,

	I think that after this patch:

commit 9eea8fafe33eb70868f6ace2fc1e17c4ff5539c3
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Jan 25 12:55:05 2024 -0800

    libbpf: fix __arg_ctx type enforcement for perf_event programs
    
    Adjust PERF_EVENT type enforcement around __arg_ctx to match exactly
    what kernel is doing.
    
    Fixes: 76ec90a996e3 ("libbpf: warn on unexpected __arg_ctx type when rewriting BTF")
    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
    Link: https://lore.kernel.org/r/20240125205510.3642094-3-andrii@kernel.org
    Signed-off-by: Alexei Starovoitov <ast@kernel.org


I'm seeing:

  19     5.42 debian:experimental-x-arm64   : FAIL gcc version 13.2.0 (Debian 13.2.0-12) 
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or directory
        2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      LD      /tmp/build/perf/libperf/libperf-in.o
      LD      /tmp/build/perf/libapi/libapi-in.o
      AR      /tmp/build/perf/libperf/libperf.a
      AR      /tmp/build/perf/libapi/libapi.a
    In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_perf_event.h:11,
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:2:10: fatal error: ../../arch/arm64/include/uapi/asm/bpf_perf_event.h: No such file or directory
        2 | #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    make[4]: *** [/git/perf-6.8.0/tools/build/Makefile.build:105: /tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a
    make[3]: *** [Makefile:157: /tmp/build/perf/libbpf/staticobjs/libbpf-in.o] Error 2

  44     4.47 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      LD      /tmp/build/perf/libapi/libapi-in.o
      AR      /tmp/build/perf/libapi/libapi.a
      LD      /tmp/build/perf/libperf/libperf-in.o
      AR      /tmp/build/perf/libperf/libperf.a
    In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_perf_event.h:11:0,
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    /git/perf-6.8.0/tools/build/Makefile.build:105: recipe for target '/tmp/build/perf/libbpf/staticobjs/libbpf.o' failed
    make[4]: *** [/tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a
  45     4.79 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:6:10: fatal error: ../../arch/s390/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      LD      /tmp/build/perf/libapi/libapi-in.o
      LD      /tmp/build/perf/libperf/libperf-in.o
      AR      /tmp/build/perf/libperf/libperf.a
      AR      /tmp/build/perf/libapi/libapi.a
    In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_perf_event.h:11:0,
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:6:10: fatal error: ../../arch/s390/include/uapi/asm/bpf_perf_event.h: No such file or directory
     #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    /git/perf-6.8.0/tools/build/Makefile.build:105: recipe for target '/tmp/build/perf/libbpf/staticobjs/libbpf.o' failed
    make[4]: *** [/tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a


  51     4.78 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04) 
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
        8 | #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
      CC      /tmp/build/perf/libbpf/staticobjs/usdt.o
      CC      /tmp/build/perf/libbpf/staticobjs/zip.o
      CC      /tmp/build/perf/libbpf/staticobjs/elf.o
      CC      /tmp/build/perf/libbpf/staticobjs/features.o
    In file included from /git/perf-6.8.0/tools/include/uapi/linux/bpf_perf_event.h:11,
                     from libbpf.c:37:
    /git/perf-6.8.0/tools/include/uapi/asm/bpf_perf_event.h:8:10: fatal error: ../../arch/riscv/include/uapi/asm/bpf_perf_event.h: No such file or directory
        8 | #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    compilation terminated.
    make[4]: *** [/git/perf-6.8.0/tools/build/Makefile.build:105: /tmp/build/perf/libbpf/staticobjs/libbpf.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libsubcmd/libsubcmd-in.o
      AR      /tmp/build/perf/libsubcmd/libsubcmd.a
    make[3]: *** [Makefile:157: /tmp/build/perf/libbpf/staticobjs/libbpf-in.o] Error 2


When building out of the kernel sources tree, i.e. when build perf from
a tarball, which seems to indicate that tools/lib/bpf/libbpf.c is
accessing out of tools/ files from the kernel.

- Arnaldo
