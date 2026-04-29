Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95378364943
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473251; cv=none; b=bASC0ZnM8y/OaSgn01pDGOlhQux64NvDfrsQ4EaDH3C+j4aJ4Gqb27uhKoSCDwbpjb9kr57jHScoMXplDI90hYlmpv/78mTPvs9IzTrWzaEAwXa2VQBuk1waDsm5kLQ4sKpXCvEg3eoubw+M5IcwdYNrIuBWrsMhP+YigCLahI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473251; c=relaxed/simple;
	bh=0QJYdccmCS5Xa21Yb/0zhA86xvgSH0oN6kSd6sMETRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDZwTjTOsY8TihvS8+p7ZmiQHlOGJso2S2eX0nJQyfMqjvISSJpZ5ahI7IN437+xRyuKsO54npqvKOC/MKhe9u+uN1ECxXPO3r/jhyzfKwtsVXhdbYwhbyvdBijgyojUnvh2PyTTk+dG1bkhFU64fQwyZ/a5HzAG/maXbTMX1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qnt93c5M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qnt93c5M"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so114740625e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473248; x=1778078048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd4Mjpp2AlESfBnJvdKqbI6D/125UdC7Iwt7tAYiysY=;
        b=Qnt93c5Mu1IVRnvYfKMfwcH6QrxTlRyvISXmaNbbG+hdEpTloX0Z6Cwn4Hcxit5Sze
         A9gDLjDGoCjdKBkPEiV8aHJHY3CAPEBVU3my+wBjqrQqwBjAlJWPQYB/GiQXM2uNWLNE
         KzO50C9UUOlIxRFUBwVX/Yt1+hYfNHnFtF2s8r1U1nWsAevsdC1jIn1sAmS6pDmAIco9
         G7fcpEoP2u2zq/xMR94+ytnvF6GRIBzB5yACRPymmXa8+xdEwT8mzcBaT65mcyEgGC9k
         9EKldKj87S5H8Xco3PmqbAbppriZ6nwoyimnCsLHxezaLhZYJsS9MH9TF/lJn85N4+/F
         Zuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473248; x=1778078048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gd4Mjpp2AlESfBnJvdKqbI6D/125UdC7Iwt7tAYiysY=;
        b=CO5S+U/NL7TKB6Bb2CNjm1Gk1wQu5hc089wndhsZIIKLQclg88D6ROwdm8bLY4vArx
         Jb8BCEMkayYbp32OWGRGWSLLUXSQyD8Pkg3yAwTgiAAWnWqpuO0EecSA6qz+D8yVZl88
         CdHZQ9N1Z+dnGVlDiIxFlyg9OZs85DH3JntPmas9NvVX9YthKrXsrecM0nyNIfb44Po5
         MacwO5GQ51XK7VDyarD3b1poPaB21J9yaTCiPOaeS60wlW0+CYggKECNu99GACwdj8v2
         zpxGXO9xRhYZAm8TEIc7XuHNXBx/fGLUNX4FM+CsfUSqwH4L+Lw+PImqMkiiXmiZ399P
         AqTg==
X-Gm-Message-State: AOJu0YwKhtH+MDpq6sLWQTvHFFZWh2gYxRXqSd+eaW6zbG7iw6e4LiX9
	WrwVB4zoctGddKMv7m5PNIRI7wA4UezGMSzzmMruvfy9coD5oXKbd204/iFII4wpNpw=
X-Gm-Gg: AeBDievldfu9ZtX6X53++fIKGRVoeVyGwK4q2pCfWfJ5XiRrzu3ngAy1yO4W6aYauYs
	tWwNv1+/Q7C0nPpdBEFIKv0e0FvNXp/VOmrOq/VwfFTnaIG/mFrq0UXo0OTyac522FH+A2IO5Tr
	SJPVwaBGhKNmNY9iZxukGndF4m+9ZgpSIBMGz/B8Pw43TMEcDtUAJv5h8tnLCptT5x5EPKSGFsg
	5xhBJvirHYDMd8me/W99jtQMLyx1ofzeOKf7XoN120PdWd797dwFUlzdGWEv/4bi4fK6L+sdYw9
	4KkXhhV2dJbMzRpmM5+HQmzV3vtNZUUTXg6NtJ9ULpsoLMgJ/uhcWLXqy4bIX75T4ZVLbzeQzI7
	k7wzKKcnmToT/nZwRvuMC/yH+DQQ9L/hzTdGhl19g/nc8sOG3Mdfj9fMg3guPBOKwe8sGtD8CqH
	YWM/mpPY+JJgS1djTv5FhPaPeI
X-Received: by 2002:a05:600c:609a:b0:48a:54a6:b29f with SMTP id 5b1f17b1804b1-48a77b1da9dmr122150555e9.17.1777473247860;
        Wed, 29 Apr 2026 07:34:07 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95cb75c4030sm1101951241.4.2026.04.29.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:06 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:44 -0300
Subject: [PATCH bpf-next v9 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-2-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=5932;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=0QJYdccmCS5Xa21Yb/0zhA86xvgSH0oN6kSd6sMETRU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIIXqPwZ6ExpslMPO1MR43Ruy2Jbcu3QNC05NyM6eOf1W2txNKHJeNFUtuamW+QsExFZX1vF5ys
 Il9RpPp6txwM=
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
index 6094fe99b5f6..cc6ee7a2df93 100644
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

