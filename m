Return-Path: <SRS0=uow0=RJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F27C43381
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 19:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C70C20661
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 19:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1PY/L75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfCFT7e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:59:34 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:53687 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbfCFT7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Mar 2019 14:59:33 -0500
Received: by mail-io1-f74.google.com with SMTP id z14so10582885ioh.20
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2019 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=cI2jbWFMs3OSfiiGB5bFKev5DIoNkuJDsrHE8cgYj4g=;
        b=i1PY/L75moaPQrhflCNUGXiUFBdY4p33LTEL7b9dV+CKypAOMmbO3eAUrgaYlcgRSK
         eS4v88xpbSxL2TyWdkHJAZUFLXg5ID+/vSmgCjDKAwF8mX3gkBp6aqx4KyLrrSiC1N/G
         usphvSU3FN1UwbB6bfhLeo9vzJDwQvNOPMDDG8g27Z7lz2swoTShP/1xOaqX8vp2CeL7
         oe+Wkhnx94z/svjOsbQiZTatlfNzzErTLxsXUjvkHTuT0ZcR4VuPnUGoeTT7pMsMgU0i
         5ECEM364zgOrK3AwUc8mRCbwF0HMaEVdP3wwgYhDJGr0PpagRwc8qG1WMjnJuXFY1LHN
         7rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=cI2jbWFMs3OSfiiGB5bFKev5DIoNkuJDsrHE8cgYj4g=;
        b=OqHtSrt9TII89Z7EsQvnRVnl2micsa7GC3GTB9iTgM4Cs3nJAfETqOdEjvV4o1UzBS
         vcBqOLQ1QohokCyRbL3FkbyeYx+VT8efLEQrLK04W95Di27PnqOmkEU53e5+w6DZqx6p
         zBhrOrtr+6PJOvRW04svEx0Pa+PcyxJL9g+kOP/JW4Xwe3X6B8yFXZ1l9/YUeve1LVU6
         k8J2/MvfA4q5d2If2dxZHfm67j47CsUQlx56yBLtUQoETUFKXGxi0qwDj7Huvult/YYJ
         uRsrC9l/SJlGNEPMwHWxDYqPuL695exygd8CDVYV3jaDEvoiBQO9SDih00TFSPqrkCOS
         Iy9A==
X-Gm-Message-State: APjAAAU+z5JdNeVz9Wd98eOeffGBu+7Dyddzp4WZdc9ZMh/o/Gk9FUwp
        wU2hXmE/Ky/cyUCeI0xWtp3CYHc=
X-Google-Smtp-Source: APXvYqx4esoJ62Qdk71CE4pV3DZnXha6jLnjVLcmSAm2Co7iLPuK66/uWwr7M+qE2S4OcLuq15mqyZs=
X-Received: by 2002:a24:6cd5:: with SMTP id w204mr7262937itb.16.1551902372379;
 Wed, 06 Mar 2019 11:59:32 -0800 (PST)
Date:   Wed,  6 Mar 2019 11:59:27 -0800
In-Reply-To: <20190306195927.208503-1-sdf@google.com>
Message-Id: <20190306195927.208503-2-sdf@google.com>
Mime-Version: 1.0
References: <20190306195927.208503-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf 2/2] libbpf: force fixdep compilation at the start of the build
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf targets don't explicitly depend on fixdep target, so when
we do 'make -j$(nproc)', there is a high probability, that some
objects will be built before fixdep binary is available.

Fix this by running sub-make; this makes sure that fixdep dependency
is properly accounted for.

For the same issue in perf, see commit abb26210a395 ("perf tools: Force
fixdep compilation at the start of the build").

Before:

$ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=3D/tmp/bld -C tools/li=
b/bpf/

Auto-detecting system features:
...                        libelf: [ on  ]
...                           bpf: [ on  ]

  HOSTCC   /tmp/bld/fixdep.o
  CC       /tmp/bld/libbpf.o
  CC       /tmp/bld/bpf.o
  CC       /tmp/bld/btf.o
  CC       /tmp/bld/nlattr.o
  CC       /tmp/bld/libbpf_errno.o
  CC       /tmp/bld/str_error.o
  CC       /tmp/bld/netlink.o
  CC       /tmp/bld/bpf_prog_linfo.o
  CC       /tmp/bld/libbpf_probes.o
  CC       /tmp/bld/xsk.o
  HOSTLD   /tmp/bld/fixdep-in.o
  LINK     /tmp/bld/fixdep
  LD       /tmp/bld/libbpf-in.o
  LINK     /tmp/bld/libbpf.a
  LINK     /tmp/bld/libbpf.so
  LINK     /tmp/bld/test_libbpf

$ head /tmp/bld/.libbpf.o.cmd
 # cannot find fixdep (/usr/local/google/home/sdf/src/linux/xxx//fixdep)
 # using basic dep data

/tmp/bld/libbpf.o: libbpf.c /usr/include/stdc-predef.h \
 /usr/include/stdlib.h /usr/include/features.h \
 /usr/include/x86_64-linux-gnu/sys/cdefs.h \
 /usr/include/x86_64-linux-gnu/bits/wordsize.h \
 /usr/include/x86_64-linux-gnu/gnu/stubs.h \
 /usr/include/x86_64-linux-gnu/gnu/stubs-64.h \
 /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h \

After:

$ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=3D/tmp/bld -C tools/li=
b/bpf/

Auto-detecting system features:
...                        libelf: [ on  ]
...                           bpf: [ on  ]

  HOSTCC   /tmp/bld/fixdep.o
  HOSTLD   /tmp/bld/fixdep-in.o
  LINK     /tmp/bld/fixdep
  CC       /tmp/bld/libbpf.o
  CC       /tmp/bld/bpf.o
  CC       /tmp/bld/nlattr.o
  CC       /tmp/bld/btf.o
  CC       /tmp/bld/libbpf_errno.o
  CC       /tmp/bld/str_error.o
  CC       /tmp/bld/netlink.o
  CC       /tmp/bld/bpf_prog_linfo.o
  CC       /tmp/bld/libbpf_probes.o
  CC       /tmp/bld/xsk.o
  LD       /tmp/bld/libbpf-in.o
  LINK     /tmp/bld/libbpf.a
  LINK     /tmp/bld/libbpf.so
  LINK     /tmp/bld/test_libbpf

$ head /tmp/bld/.libbpf.o.cmd
cmd_/tmp/bld/libbpf.o :=3D gcc -Wp,-MD,/tmp/bld/.libbpf.o.d -Wp,-MT,/tmp/bl=
d/libbpf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY -=
Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat=
-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-exter=
ns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -W=
shadow -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-s=
trings -Wformat -Wstrict-aliasing=3D3 -Werror -Wall -fPIC -I. -I/usr/local/=
google/home/sdf/src/linux/tools/include -I/usr/local/google/home/sdf/src/li=
nux/tools/arch/x86/include/uapi -I/usr/local/google/home/sdf/src/linux/tool=
s/include/uapi -fvisibility=3Dhidden -D"BUILD_STR(s)=3D$(pound)s" -c -o /tm=
p/bld/libbpf.o libbpf.c

source_/tmp/bld/libbpf.o :=3D libbpf.c

deps_/tmp/bld/libbpf.o :=3D \
  /usr/include/stdc-predef.h \
  /usr/include/stdlib.h \
  /usr/include/features.h \
  /usr/include/x86_64-linux-gnu/sys/cdefs.h \
  /usr/include/x86_64-linux-gnu/bits/wordsize.h \

Reported-by: Eric Dumazet <edumazet@google.com>
Fixes: 7c422f557266 ("tools build: Build fixdep helper from perf and basic =
libs")

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index a05c43468bd0..61aaacf0cfa1 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -147,7 +147,8 @@ endif
=20
 TARGETS =3D $(CMD_TARGETS)
=20
-all: fixdep all_cmd
+all: fixdep
+	$(Q)$(MAKE) all_cmd
=20
 all_cmd: $(CMD_TARGETS) check
=20
--=20
2.21.0.352.gf09ad66450-goog

