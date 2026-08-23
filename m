Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3863AE6E2
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514189; cv=none; b=J1eOzfXGunoZ73DS0zmVe+cpY76PqxHAihG2Up3eqOQzEawSc5dDjY0P9rSb0Y2JssHcQ/9uqqlrPTnKlvvbNABIsPfqvf2gIG5W3UUKncwnhkKjvEZupBoVQExxJjimJw1oBrmOL1hoYqQ5i4r/C2UO64mLjZ0MQwZ4ePo8qwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514189; c=relaxed/simple;
	bh=Ity4FHSgN/zMXqzsTfEV+8GUJ2OF9pbJutKzIvxr75A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VG8gm+fwdEFzS3xXoBs3eBdCWScqSiCXrXn+489y8FfB2y07ERqzgZctqxQRU2L4pKcFK/QQrSQrPTFvVG2dUaWxx0CCd/aUzVx4KB88F8LpzSuukJgplq+AsTJ0LPWThqEqDd9HceLR22tWQ3lmLUXIFb5iN6WwYKE860mGosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEnJ9aiV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEnJ9aiV"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3088529a91.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514187; x=1788118987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwVM5hM84kZaxojLqepslYUjP5WP1gcDJ7RcoM4IYrg=;
        b=MEnJ9aiVPjIB5H986rf0ox8BGO8OlnKlH5TcIy3t97WXvaavpLLmTfXFosI1d+6YW4
         dJbgWHvyFGAlHF+bx0FdEPGQ39WGe9rgPIhbRyEU32aFUEyiq68hMSeWsntlhtQfiDYM
         6meWKm7XQ9LQSLaWF7ZDnOwvj023RZRqp3CwDCNbJ8UO99Enq7kL0ANlcDN3z/YhlVWG
         90xx6O22fFSjTHgG4SKNFF/YbJ0yrm6qYl31le2dmAH2mwD58wPHGRhWKnC1gIrol/3M
         Z9KqXm253T8PoWumG3mx7fS9X4nVWud7DKk1yUKRibDyq7JJ1hXZKiStdtTr9v5ODbQR
         Eqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514187; x=1788118987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwVM5hM84kZaxojLqepslYUjP5WP1gcDJ7RcoM4IYrg=;
        b=cwxrQtXbHW+M+QgbnuyKPaQI42ocbMG8G8SFBterS267XyCgss6mikNsy946d8od3g
         /4GLV1kXn4IZCxBInLsx1BPDKEuf2/A+o2QWoee0kf7ojtHMqvg0Y6ed2FYMlkIBf262
         5KF2Z+YPiSciOay5yd4cXAqYuDEJw5yb207OrL9eW2GwE8V1Ao9OrhTP6JWbCfsCM5HA
         2/sJe1+Fa/9RvY1v/AFpYOuCY5p02ldWgclGQkA+OXD7JusQ5ExE7Bpw1JbLvefCikgA
         alh63hLtpR2zNNSKw+dno5U94qNDVirWjy56cQkR9oploJ3jOkVL+nVcVPSl+Sz/p7Ul
         leoQ==
X-Gm-Message-State: AFuF++l5Ano3KqRofQItX1XFoKSpBgCHtrKr9VN6HMsyRZeZrA4s9tgb
	1I4N9zmfT1w83xHU/739N7KBnaFddAXJtO9JsCXFpi4CcTuKrOUubgZHSImR+tX9
X-Gm-Gg: AR+sD13sSDyGDa3XJZIfJu08W1Tcz6eaTO8QtlVaw06TCm7e0Wcn5qyqBs964bTxBa3
	C0Y0KVRux8+FtvcF41Z0cUjYZk2+xZ++p5A7+AGHb1QOVwOBeOLBhc9Sinptxo9XQkfWx+EtESh
	wsm4Q0lQyW4Zxs0B0TnjwqFs6yDkHLIjSiYvME5ofr/T83t9D94FCCCxty0qn6y6LReqpEPNc94
	5YDSqiOU/URoo0hK+n4D6h9I7PEhNqkOsvS1ZE6Gmp/ZH/Mp8UdMlhX5YBv3rlEah3FD2jkI44j
	JKGtasXeUOfzwMmlcyAAu+KYRWu7AVsyz8qLCBP7x11usJLY1vCyS8+GKfGCo70zFUKUTFZ6Csr
	xr2AtGNlndygRm119oybJwzSvCkXeMuSW13O04+sa63LybEJSZwEjfMDVbABUL5tRd13cUbz8Wf
	xtVn4ytmmdHGheYfQmath46NvOdAE0qTSd7N3Vp6wimXtABwFkBZf1OKoroy1u/+kI/stmq9/tT
	K0983oXnRqTFECqRtgvZIiR+B7L5zGtcwI3OEhjwqJBqbb5L6+9wZU=
X-Received: by 2002:a17:90a:16d6:b0:395:f0b1:1fb6 with SMTP id 98e67ed59e1d1-395f0b11feemr13206565a91.3.1787514186970;
        Sun, 23 Aug 2026 12:43:06 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:06 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [PATCH bpf-next v7 2/9] selftests/bpf: drop stale lines, restore two header dependencies
Date: Sun, 23 Aug 2026 12:42:34 -0700
Message-ID: <20260823194241.3415152-3-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four target-specific lines name objects nothing builds. Three name
the BPF objects by their pre-rename names: commit afef88e65554
("selftests/bpf: Store BPF object files with .bpf.o extension") left
them without a target; the flow_dissector_load.o dependency names an
intermediate the generic one-step compile+link rule does not produce.

Three linked-skeleton dependency map entries (xsk_xdp_progs,
xdp_hw_metadata, xdp_features) were dead on arrival: commit
f0a249df1b07 ("selftests/xsk: get rid of built-in XDP program"),
commit 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX
metadata") and commit 4dba3e7852b7 ("selftests/bpf: introduce XDP
compliance test tool") each added one, mimicking the neighboring
entries without adding the skeleton to LINKED_SKELS, the only place
the -deps map is read from; these three skeletons are generated by
the regular pattern rule, which never consults it.

The '-fno-inline' pair (test_l4lb_noinline, test_xdp_noinline) had
stopped taking effect even earlier, with commit 74b5a5968fe8
("selftests/bpf: Replace test_progs and test_maps w/ general rule"):
since then the BPF compile recipe expands TRUNNER_BPF_CFLAGS, a
simply-expanded copy of BPF_CFLAGS taken when the runner rules are
instantiated, which a target-specific 'BPF_CFLAGS +=' cannot reach.
Both programs have compiled without the flag since, and nothing was
lost: every function they define
carries a noinline annotation, except the SEC() entry points, which
nothing in the file calls, and the single __always_inline helper in
each, a deliberate exception the flag never overrode; and
compiling with -fno-inline restored yields byte-identical objects.

The two header dependencies with remaining value are restored in
working form. flow_dissector_load.h moves to the binary itself, which
is linked straight from its .c by the generic '$(OUTPUT)/%:%.c' rule
- editing the header now rebuilds it - on the line that already lists
the binary's helper object. cgroup_getset_retval_hooks.h -
added by commit e7215f574079 ("selftests/bpf: Make sure
bpf_{g,s}et_retval is exposed everywhere") days before the rename
orphaned it - lived in the top directory, outside the progs/*.h
blanket prerequisite of the BPF object rules, so editing it never
rebuilt the BPF object. Move it under progs/, next to its only BPF
consumer, where the blanket prerequisite covers it - the arrangement
several other headers shared between progs/ and prog_tests/ already
use. Its userspace consumer is tracked exactly by the
compiler-generated dependency files.

'CURDIR := $(abspath .)' redefines make's builtin to the value it
already has, and 'OBJCOPY ?= $(CROSS_COMPILE)objcopy' defines a
variable nothing in the selftests build or the included kselftest
infrastructure ever reads; drop both.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile                | 13 +------------
 .../selftests/bpf/prog_tests/cgroup_getset_retval.c |  2 +-
 .../bpf/{ => progs}/cgroup_getset_retval_hooks.h    |  0
 3 files changed, 2 insertions(+), 13 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/cgroup_getset_retval_hooks.h (100%)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 118a7c356e26..c7c7f27dd860 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,9 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
-OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
-CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
 LIBDIR := $(TOOLSDIR)/lib
 BPFDIR := $(LIBDIR)/bpf
@@ -342,7 +340,7 @@ $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELP
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
 $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
-$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
+$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS) flow_dissector_load.h
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
@@ -480,12 +478,6 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
-$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
-$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
-
-$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
-$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
-
 # Build BPF object using Clang
 # $1 - input .c file
 # $2 - output .o file
@@ -546,9 +538,6 @@ linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
 test_subskeleton.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o test_subskeleton.bpf.o
 test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton_lib.bpf.o
 test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
-xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
-xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
-xdp_features.skel.h-deps := xdp_features.bpf.o
 tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
 tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
index 2bb5773d6f99..ea342859d6ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
@@ -465,7 +465,7 @@ struct exposed_hook {
 		.expected_err = EXPECTED_ERR, \
 	},
 
-#include "cgroup_getset_retval_hooks.h"
+#include "progs/cgroup_getset_retval_hooks.h"
 
 #undef BPF_RETVAL_HOOK
 };
diff --git a/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.h
similarity index 100%
rename from tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
rename to tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.h
-- 
2.43.0

