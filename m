Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9B3BFAE7
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977583; cv=none; b=E2fj5aweuu0QCmERsvVCSNedkwbn32MQ5chYuhHWr9kNcklsUK01gj50oNJV1sb/Jxcc7a6NOrNaaR2uH1zchEmRFzU3lyBoZpJ5lJ8x6FxEC9cStfzylab1N1CEgZafZ6TfTJvFCgq1l9N+o+H2iLcT8k01vK+/tOeGqbxwkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977583; c=relaxed/simple;
	bh=iqbM1Am7BdmbR2YOVO6poK4yRuebLrq0jUQsEfl2Ldo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+EhCWt9K1XhVE3vo/C19nqGCjHh+VRLBq5sLjeNuIV/7OlS2O/p8VYLVzN5T91iywvXDp9pZccPNsvAsqKDCCnHAo/LMEnXujkIHHEl5X72+bD6lR0gyFDSI/u2PA1bviIz/0GHARDBnqBnEJryPD46nmQXNn/f1my/X/7+ZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdVWdDyh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdVWdDyh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398beb616f5so1133333a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977581; x=1790582381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtmTvuGPXYozzm4HijCaftBESaVUk+HkJn0dH/38cvk=;
        b=bdVWdDyhYwgeZBYhOjOJs35QhCDKSgdqu9GEbyoOwfWQL0ARh7WkaSIV1kuiBpZOAO
         PBVpqFfG2mHWk2FzFBadluWLkDmKKAIEfyA26bCIASRXgeVuzTqUf89NKpZEMuVpRz++
         0tBEMfq38gI5DtIpPItxwR66cHGv2/G7gctZWheUlfP+C+yZqwQUi/i13N2mB4oSQ0IZ
         WmJX+c31JTPgYnED8GG8djUXV0uKB6Utc7sUNY92ENdvZgFkJZl8Wv9HyWsr+7R++ED+
         fp/r4FkkPkkvjmK3p4k1YHdWSICy9xPmrCaAGuJQmnYQv2fnYz47FghTEwixpPGLNo1i
         ukfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977581; x=1790582381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CtmTvuGPXYozzm4HijCaftBESaVUk+HkJn0dH/38cvk=;
        b=YK1hly2q16ipXN+Kf1zOfQ7TkuduFPhHpyr7QDFJrrkcMYQ9b7bMXZuRoDe6hdNgff
         TaGU8HRbNsEjSr07vTJ25+DcuTqtVQAJMni2g8dSa7GRSrlgdmRz/6TYh/C8rTjzT/+A
         e+1D5jEyVUwybeNSy+z0EV73w1B1O6gqxF98pLPdMXzcgcRePnciEA/T8mEbHXt8tzck
         KgFAZfpKkdzvKHRdOWDb91NY6pfL+/yXbiLbF25yNvXBmPkIMXE/QdDqDp2cEyAiXKdt
         lyEgn2bNXWc2XYH0OPcO14DVb1OZTZTMU50N7Si20Gd7SljbP+HQwFXtJ/QXF6iGuM6w
         ca+w==
X-Gm-Message-State: AFuF++lZ2auyuQY2ZvmPb4dS1KisCokRWs8yIKMW8AukGZUhaPNrk3I+
	5hagKyJ+1Chk2vg3goIlW1W/FJWHBqImfXFmRLZwnpl5bVoGpGsZGQ+NYWtbvTqlNG4=
X-Gm-Gg: AYBFou1JCYclbmEJc3R2jxLncSsSEMul9oTnf4/bat0qNAOekVUeoz/9LrqwWKYyaPW
	R4oNe2bOhX4ByJnk7a/sCKWy48YXPyhr6fsGSpGTy/BKu4r/NJRxSSa3FSrc4xcFTL22P4K/5HR
	DukkvYC4wZ1Pj/pTQ+GOP4spCwDb33zA8U6a+kQb/7zSA3S989AO/5HE4QcXqDOCJ4gvU+Y6ZR5
	au8ctMX+q7MuBctx0H2cke8RsPWWTRTt29E4YWY7/9eBH0s+vA2kVheywsc3/mQRly6ZtyJXBW/
	KxaPhhgUnX/MW1VrQMOCCw/hcfX8lLRDT3ugryR+WOxQk3GLreJ0sqY05lkZ6ooZ0MYqDE2FTFg
	nb4HaGWIy3vmBCrq6cEx68+n+XCCmTgWGtegKd75pzcjH1VxME52fafNVf84HbqDU7ipwaBoaHG
	5325QUilaljbnnSavnwKYXI6djiWLbhU5vwRdAQTKrh6nXZH45yrA7gePmHGoO4SYDigURI1Xta
	jg/NtXHBUKZwflRhC+Aj/LoOKMCM0NBX0Wq6kYLYaBZVtCcewozX7yHMMoKPbFj/A==
X-Received: by 2002:a17:90b:4b87:b0:39e:6c68:fd8f with SMTP id 98e67ed59e1d1-39e6c68ff16mr6540995a91.36.1789977581500;
        Mon, 21 Sep 2026 00:59:41 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm12843830a91.6.2026.09.21.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:59:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 2/9] selftests/bpf: drop stale lines, restore two header dependencies
Date: Mon, 21 Sep 2026 00:58:48 -0700
Message-ID: <20260921075855.2065871-3-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four target-specific lines name objects nothing builds.
Commit afef88e65554 ("selftests/bpf: Store BPF object files with .bpf.o
extension") left three naming the old BPF objects; flow_dissector_load.o
names an intermediate the one-step compile and link rule does not
produce.

The xsk_xdp_progs, xdp_hw_metadata and xdp_features dependency-map
entries are unused: none is listed in LINKED_SKELS, and the regular
skeleton rule does not consult the map.

The test_l4lb_noinline and test_xdp_noinline '-fno-inline' settings had
already stopped taking effect with commit 74b5a5968fe8 ("selftests/bpf:
Replace test_progs and test_maps w/ general rule"). The compile recipe
uses TRUNNER_BPF_CFLAGS, a simply-expanded copy of BPF_CFLAGS that the
target-specific additions cannot affect. The intended functions already
carry noinline annotations; restoring the flag produces byte-identical
objects.

Restore flow_dissector_load.h as a prerequisite of the binary, which is
compiled and linked directly from its .c file. Move
cgroup_getset_retval_hooks.h under progs/, where the BPF rules' blanket
header prerequisite tracks it. Its userspace consumer remains tracked by
compiler-generated dependencies.

Drop the redundant CURDIR assignment and the unused OBJCOPY definition.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile               | 14 +-------------
 .../bpf/prog_tests/cgroup_getset_retval.c          |  2 +-
 .../bpf/{ => progs}/cgroup_getset_retval_hooks.h   |  0
 3 files changed, 2 insertions(+), 14 deletions(-)
 rename tools/testing/selftests/bpf/{ => progs}/cgroup_getset_retval_hooks.h (100%)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index bfb788ea6561..3606ee8ab794 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -3,9 +3,6 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-OBJCOPY ?= $(CROSS_COMPILE)objcopy
-
-CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
 LIBDIR := $(TOOLSDIR)/lib
 BPFDIR := $(LIBDIR)/bpf
@@ -339,7 +336,7 @@ $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
-$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
+$(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS) flow_dissector_load.h
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
@@ -477,12 +474,6 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 
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
@@ -543,9 +534,6 @@ linked_maps.skel.h-deps := linked_maps1.bpf.o linked_maps2.bpf.o
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

