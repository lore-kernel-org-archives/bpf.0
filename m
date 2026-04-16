Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6013B19CD
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367875; cv=none; b=BNFiFzzl7frCyJvKvNFJseu4sXZnUIdLfj4eoqsGZdwOEooyu+DXy3RxrSdpk8Tv3wee8K1gv7Rmu04KlcsUg3HMkctJOIuLYhPacs5xUl2oPbh/fYqLBdKvPMlEsjYHItqkGZ9pFsZWX5l9NDuCMG2f0U8xbrxYWhXbFU+MvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367875; c=relaxed/simple;
	bh=f11SXZe+WQHJaklmN8C/g2Xt195t+y0z9AhtKSHsNYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UV5AM3nBrpyZlGN3HpkIZ2TQ9OKc0p6sZudTRG8hj78Ppi31yv042OADUwN6NjgZgQVYcW/lu1+UPaY3D11TJt3ngEcxYNk90d+lL3uqIELwVorvLP1RMuAmviPIIVf9jogTk2iwsINNN5/chnGWv4l7Z7F42ysIt5MexNYrbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D8L3gqFH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D8L3gqFH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so81682935e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367865; x=1776972665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oR0RAEV+sroGN90lpwROKTuzfL00axzp/LpV4EpeGlc=;
        b=D8L3gqFH8W1HvvUGbDXOHXMW7tP1UVzCbFUChAcCimIcUAmqTIzJp2xzHET/20C+Gc
         wLiu0Y3hPP+RH6DBIesz7/PC0KLn3BYVB0bs6IC5xP1KtaSy9M+YeYcnWX4BVa/tV/gG
         GUxYWIxf7/XrlmgKggRs33I+JhkohPoS+NNNW/BbLPV5bybrdWybQdtE6OrtejKQnCwG
         LB1qL94knhidNVHHqEP+CQckkKpuGlFyfouNZ5bx5vAvygAltqQj8YLNWEYMck1iIanZ
         GP80JgR689BZJAJpOe9f2kPg/bIzh1Z1YdvfwOb9mmcpImEi2+U5lSY8/eFZCUONLNbO
         vXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367865; x=1776972665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oR0RAEV+sroGN90lpwROKTuzfL00axzp/LpV4EpeGlc=;
        b=Hm2ZP2rR5NIuKhNp8jSg0Z88ny42rHyQ+QHq9kfoeYufaweQhdGKVDXQOiZbhTXSmQ
         iVai8HEH7+3Y8MdAm5ytuFFND+HRM4txcWKaqv58McF814wG+hRZ6FctHTiAU0fKVgsq
         9lMdPpRPLBQKEOeUxujIn3lzxq+tknFge/i8dr+yODDFTqL2A+WY8IH7yragmtqbCmVS
         IZ5U73Mvm3JBGL3lgnb2hSLckXNO1ZqADtCDXo1ZzJh4wO4q8fmpY5FonKy1os/VL7hm
         4/LvUJvrR0NFSFaOeCSxequ0tZCP2H26nqaWqU6qWTld4x13ogV1OFZ/PGVhg4MZ6FZG
         WjAw==
X-Gm-Message-State: AOJu0YyZPa4vhYIHR36FpBQ8KCNUpeyX+AORru28LYb+ArhtB5HrewoY
	S0bdBZuQkQ8kDP3SBBV4xmWJdCmJOaV4qotrLr2+paEdEXTvNK50dXftCTf6AjX0OXY=
X-Gm-Gg: AeBDievTF9HbUNgX3CXwcm6k44hkq+1rSAdkMPYXBakiy6ZvJSNDACYVt6WWNE47dKn
	Y/b96WrB3B1Mv0XFPz45Y61hVnbgJl4EvLio/cLZ1rdIgSIOTS/xbsg0AktxEFH/PJAeLiqJ/R4
	wB83QxVDUi/XIc7nU/9lVQQTMJqcGHLWoQLDmt/f59ZgOzEs/2CEY5tXyFqgY/VgdPOFwI5iPiU
	o0tXAZhuZuX19yKrN+5fx6W0tljc/b2Yl2Elo1nYnI78we75Nz5Y7YZTTAHfmb/uHHgzllzZvWX
	U03jFPBhvYGwTZv12Hds+G+pXbLT992FBE7gZ/fRgNuPAz1k7iwndlhemxZ5D2tlmXS3Z8HQqX1
	lyDX5yDHBbtajtWB1Yie81kuVA91tXPZv8RK98pU8Jseu9HJ/JPMO75SNRIl+1tvkdg2a/K696Q
	8AbqQcACzONqoHx5+KI2Wc6SA=
X-Received: by 2002:a05:600c:35d6:b0:488:ba5f:984f with SMTP id 5b1f17b1804b1-488fb25687emr3801095e9.6.1776367865550;
        Thu, 16 Apr 2026 12:31:05 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c606222sm10959044eec.8.2026.04.16.12.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:04 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:30:51 -0300
Subject: [PATCH bpf-next v7 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-2-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=3692;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=f11SXZe+WQHJaklmN8C/g2Xt195t+y0z9AhtKSHsNYI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGEqwf9dlE76lZ5IeGnsI6DMxcaVhpenNsPLey7kjYgCDwh8n/q3cOelnT/IV1dCgTNowTPqcOp
 uGrPga6130Qs=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

test_kmods/Makefile always pointed KDIR at the kernel source tree root,
ignoring O= and KBUILD_OUTPUT. On distro kernels where the source tree has
not been built, the Makefile had no fallback and would fail
unconditionally.

When O= or KBUILD_OUTPUT is set, pass it through so kbuild can locate the
correct kernel build directory (Module.symvers, scripts, etc.). Note that
the module artifacts themselves still land in the M= directory, which is
test_kmods/; O= only controls where kbuild finds its build infrastructure.
Fall back to /lib/modules/$(uname -r)/build when neither an explicit build
directory nor an in-tree Module.symvers is present.

Guard both all and clean against a missing KDIR so the step is silently
skipped rather than fatal. Make the parent Makefile's cp conditional so it
does not abort when modules were not built.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile            |  4 ++--
 tools/testing/selftests/bpf/test_kmods/Makefile | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c8ba8ccc2c6d..52176dc226f1 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -296,7 +296,7 @@ $(addprefix test_kmods/,$(subst .ko,%ko,$(TEST_KMODS))): $(VMLINUX_BTF) $(RESOLV
 
 $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
 	$(call msg,MOD,,$@)
-	$(Q)cp test_kmods/$(@F) $@
+	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/$(@F) $@$(if $(PERMISSIVE),; fi)
 
 
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
@@ -711,7 +711,7 @@ $(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
 ifneq ($2:$(OUTPUT),:$(shell pwd))
 	$$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
-	$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
+	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args) $$^ $(TRUNNER_OUTPUT)/
 endif
 
 # some X.test.o files have runtime dependencies on Y.bpf.o files
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..ba6f6ed6ab8c 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -1,5 +1,7 @@
 TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
+SRCTREE_KDIR := $(abspath $(TEST_KMOD_DIR)/../../../../..)
+KMOD_O := $(abspath $(or $(O),$(KBUILD_OUTPUT)))
+KDIR ?= $(if $(KMOD_O),$(SRCTREE_KDIR),$(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR),/lib/modules/$(shell uname -r)/build))
 
 ifeq ($(V),1)
 Q =
@@ -14,8 +16,21 @@ $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
 CFLAGS_bpf_testmod.o = -I$(src)
 
+# When BPF_STRICT_BUILD != 0, a missing KDIR is fatal (the default).
+# When permissive, skip silently.
+PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
+
 all:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) modules
+ifeq ($(PERMISSIVE),)
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) modules
+else ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) modules
+endif
 
 clean:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) clean
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) clean
+endif

-- 
2.53.0

