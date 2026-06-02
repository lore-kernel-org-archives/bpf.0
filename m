Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83B3E00A9
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405410; cv=none; b=d3unXSi7XbCrV11ZbljOV55yh8lkgtw7uawFVHYZZiZ9lR7JYbCopz3fGCUnxItlIvSSlMyLhPN/B/tqklbW4QdE7e+NRT4uLzvQbwgad4eKKG/5UkFEHz0v95dmqCtXH/ZM/jHMizsCT40e8hT3mYk7+MrpeWZp6jOTJxrHtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405410; c=relaxed/simple;
	bh=fbF8nQJXxB1SkRTOtp4VOVdXaJiaAS90dkQH2m8/uwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9M7Vm+huIA7nOJRNcqMKYrU51PBF4qE5P5q62OMApwWtEXNESrg4h8hUd7vbjlRibIB8gZs+YCw7TTzq00BIEpRylxOYVJ0FrlTGnaxXKOGI9HT6Zka56sgRbrjah+udZ3cM2Dv4ACTQkVBFiOIbJNCkKrHNaTS0p/rG8rJXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VXsQQh96; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VXsQQh96"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso18901344a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405406; x=1781010206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7sRCyAaG4JtB8cGdq/xLoJjiqdDEq8Sk+qOaCu1wfw=;
        b=VXsQQh96BWjQ9BTGnoywq0gDgGyeUB5+hijsP9A9QCKngLSl0nBcennCKBbc15MWf+
         p30eKfSEKtvmvoB9ZBmL1bq1yAXU2U3peDuN+Q/y8LN963ACo/T1OhvwUICijxJnfBV6
         q72H0FE86MhEchklWNS6NT4fi9CR5kuT+NOWrB7VrLjrw/TB+YokIIW92Y947Am0bKiz
         bsZLOUCa4HTm+R0yRY5A65wikBF74kj64840CNZsnQrpb7r+zt32V3gjMP1fmDwAw/Gq
         RTQ3bEyMK4O03lM/6n2X436azmLP0fmm5QENFkuf3k4QC4aTyAPDJXSHbWGO9rOpkXp/
         O8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405406; x=1781010206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7sRCyAaG4JtB8cGdq/xLoJjiqdDEq8Sk+qOaCu1wfw=;
        b=n3mD6MhBdxqdloL8CqiGkWl76yRBauhp7az2+wc7zua+c6HtuRqN0g/wqHY0+RYxDy
         Qw22BGgpQf+6mMNv41t28vD+tBZBi8CZlwQ+N0p/t3+S5VpAaTtCpcA7JhCv+7VlBGCk
         PMlmfZvNIJ2SvncZA+8Zk5ObKnyx3GhT2Vms+mJ4CVHJ968Tx32IpifpSELEgLxltU4V
         TvHV521xKXeNLhTGJv11EvAy7QmrertNxU3XmGRJsjABG1L1cMGPxAe/4/Oky82fHSdC
         2XmOLfYv3Fhw5y/2Etvl+0FzaFmvoHNC4K2kHmF/WNGejWm4RpPXtC1bYt6lhxjqvN1Y
         PBpw==
X-Gm-Message-State: AOJu0Yxbs7TQ87quCsKApxae4JnbjdpqKVteG/yZ8piVJL3rdZviM1dr
	yceILX8UjZSLzROhfvyjvAmkvwDzEJbHlJbXtBxepX6pYiL4rKq8RPOISiC+OCcTANA=
X-Gm-Gg: Acq92OH1IVJjvo9C4Q33iwRjtw1dCTKOTzZnZ6IPKostnzku6PBD6/pU0V7VsJlMoPh
	nqf7ZBQtFIfRl1/RGk/TxVNLmjYwZzZu6fwdcV+N3LQVAn0VO++otSJWM2EXhj5egjSCXJlI4TH
	YoEysuBcoc20HuLDMnYPAvxczzmc5JcPI8Idt7FjqZ+RH73IbsVachyZwJ8+KsrP1I+y1ofQGoY
	aRQrh4/WuhLtJB03INy8tw7Pr9aXeHoNWbwggqy6cHm0jYoYHZFU8J1qthID4BBxLHCn+033SA4
	eNFrRXTN6SgxTVDRa6U4KLomzyeLRkymUnfi8rLAObVh48+Jio3FPMRA++ElHQEyxU3Pmd6V0S/
	rwCA/cBMyy7xHW6kAnIgqYTA2CnBhmqcU/mDowkGSOontW2F/sJOvtSd2kJiQRRVc4ToP/CUsuy
	IUvPq9Sd2PUy5NiHBVgz2rdA==
X-Received: by 2002:a17:907:9729:b0:bda:8e57:5639 with SMTP id a640c23a62f3a-beab13c2204mr914425266b.20.1780405406008;
        Tue, 02 Jun 2026 06:03:26 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d62cbee6sm484486866b.44.2026.06.02.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:25 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 02 Jun 2026 10:02:51 -0300
Subject: [PATCH bpf-next RESEND v12 02/11] selftests/bpf: Fix test_kmods
 KDIR to honor O= and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-selftests-bpf_misconfig-v12-2-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=5932;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=fbF8nQJXxB1SkRTOtp4VOVdXaJiaAS90dkQH2m8/uwE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QI5yf7yf2KUrgMKzMpv9PNsaaemkv5a2Vsp6OYxwNHZ/EeuLg672ou+N8NZ/UkldtQNlkR1OTTJ
 LUmbr3gtU8Q0=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

test_kmods/Makefile always pointed KDIR at the kernel source tree root,
ignoring O= and KBUILD_OUTPUT. On distro kernels where the source tree has
not been built, the Makefile had no fallback and would fail
unconditionally.

When O= or KBUILD_OUTPUT is set and points at a prepared kernel build
directory (one containing Module.symvers), pass it through so kbuild can
locate the correct build infrastructure (scripts, Kconfig, etc.). Note
that the module artifacts themselves still land in the M= directory,
which is test_kmods/; O= only controls where kbuild finds its build
infrastructure. Fall back to /lib/modules/$(uname -r)/build when neither
an explicit valid build directory nor an in-tree Module.symvers is
present.

A selftests-only O= value (one that does not contain Module.symvers, e.g.
a private output directory) is intentionally not treated as a kernel
build directory. Without this guard, a user invoking
"make -C tools/testing/selftests/bpf O=/tmp/out" would have test_kmods
try to use /tmp/out as the kernel build dir and fail.

The parent bpf/Makefile resolves O= and KBUILD_OUTPUT to absolute paths
before invoking the test_kmods sub-make. Without this, $(abspath ...)
inside test_kmods/Makefile would resolve relative paths against the
sub-make's CWD (test_kmods/) rather than the user's invocation directory.

When O= is passed to kbuild, also pass KBUILD_OUTPUT=$(KMOD_O_VALID)
explicitly. The parent invocation lifts KBUILD_OUTPUT into MAKEFLAGS as
a command-line variable, which would otherwise suppress kbuild's own
"KBUILD_OUTPUT := $(O)" assignment and cause it to use the inherited
KBUILD_OUTPUT instead of the validated O=.

Guard both all and clean against a missing KDIR so the step is silently
skipped rather than fatal. Make the parent Makefile's cp conditional so it
does not abort when modules were not built.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile            | 10 +++++----
 tools/testing/selftests/bpf/test_kmods/Makefile | 30 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 75036c1b5c4f..e912526a65dd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -296,13 +296,15 @@ $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 # subst() turns the rule into a pattern matching rule
 $(addprefix test_kmods/,$(subst .ko,%ko,$(TEST_KMODS))): $(VMLINUX_BTF) $(RESOLVE_BTFIDS) $(wildcard test_kmods/Makefile test_kmods/*.[ch])
 	$(Q)$(RM) test_kmods/*.ko test_kmods/*.mod.o # force re-compilation
-	$(Q)$(MAKE) $(submake_extras) -C test_kmods	\
-		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)	\
+	$(Q)$(MAKE) $(submake_extras) -C test_kmods				\
+		$(if $(O),O=$(abspath $(O)))					\
+		$(if $(KBUILD_OUTPUT),KBUILD_OUTPUT=$(abspath $(KBUILD_OUTPUT)))\
+		RESOLVE_BTFIDS=$(RESOLVE_BTFIDS)				\
 		EXTRA_CFLAGS='' EXTRA_LDFLAGS=''
 
 $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
 	$(call msg,MOD,,$@)
-	$(Q)cp test_kmods/$(@F) $@
+	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/$(@F) $@$(if $(PERMISSIVE),; fi)
 
 
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
@@ -718,7 +720,7 @@ $(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
 ifneq ($2:$(OUTPUT),:$(shell pwd))
 	$$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
-	$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
+	$(Q)rsync -aq $(if $(PERMISSIVE),--ignore-missing-args) $$^ $(TRUNNER_OUTPUT)/
 endif
 
 # some X.test.o files have runtime dependencies on Y.bpf.o files
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..031c7454ce65 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -1,5 +1,16 @@
 TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
+SRCTREE_KDIR := $(abspath $(TEST_KMOD_DIR)/../../../../..)
+# Honor O=/KBUILD_OUTPUT only if they point at a prepared kernel build
+# directory (one containing Module.symvers); otherwise treat the value as a
+# selftests-only output directory and fall back to in-tree or distro headers.
+# The parent bpf/Makefile resolves O=/KBUILD_OUTPUT to absolute paths before
+# invoking this sub-make so relative paths still anchor to the user's
+# invocation directory.
+KMOD_O := $(or $(O),$(KBUILD_OUTPUT))
+KMOD_O_VALID := $(if $(KMOD_O),$(if $(wildcard $(KMOD_O)/Module.symvers),$(KMOD_O)))
+KDIR ?= $(if $(KMOD_O_VALID),$(SRCTREE_KDIR), \
+	    $(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR), \
+		/lib/modules/$(shell uname -r)/build))
 
 ifeq ($(V),1)
 Q =
@@ -14,8 +25,21 @@ $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
 CFLAGS_bpf_testmod.o = -I$(src)
 
+# When BPF_STRICT_BUILD != 0, a missing KDIR is fatal (the default).
+# When permissive, skip silently.
+PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
+
 all:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) modules
+ifeq ($(PERMISSIVE),)
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID) KBUILD_OUTPUT=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) modules
+else ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID) KBUILD_OUTPUT=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) modules
+endif
 
 clean:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) clean
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID) KBUILD_OUTPUT=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) clean
+endif

-- 
2.54.0

