Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7E393DD9
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419929; cv=none; b=Zza9TZwUYHwW628dMbSlP2x2gLtnwUWNAggAyj0SvI9ey63pCaq4w5wt11ix8YJ9vs3EkoZI7SXDhJ3DH5J7ncft7uVO8FQ3rJjCRbayuSqW2j9DG3+32YSkuOx6t7OL7SLfOlk6G03AgXQa11Twi+OXFwqpsXLidvzel8qr6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419929; c=relaxed/simple;
	bh=GPft9EUuymX/ePLsx8D1NAl+xxMNBZzC0iSHAXYAKbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caC3D/+QoQXJ6ms4ssdYTQ64VCjdA1U9bKn8eP2o8a4Z9k0ahE3eKkv7XUeV6ppc4nN8nGGAZa7cEhZ8RFljyvNt9j1XWWPU/1eqskP+E0GsFuqcgGdUebqvaAmMEmN7L2eeAv+goXjlfHZ0882QW0D+B16FrOhyWnSYX0Di4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aSGM2rii; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aSGM2rii"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso82696715e9.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777419926; x=1778024726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtYCp4rJQ2CdnwGIUcHG8UWOZSQ5VpjJC/jcAlis1wY=;
        b=aSGM2riiQPW3ChMEFl4lcCBOb1uMeJ9DpZKyRWB/Qwk60G8WkBXuRB/DCR5kJFKd5T
         PSjVTnzmglcEkCdGPz1O72UdU5+vYn9HUlQFWsGalojaRg3eQ04SS2CgMR6ZlhEx5c/R
         6PHOo+MryevHHa+3lPQ2wPLOFyHdExWc3kXwJFBUMR5ZNr2Bt4T/r0bvK2H9TLg3+VAF
         8cQWmWvsXpk6hsJdTuLjIJRJaa+DYXsJBOlPfxycnjlLEU2GTvVrtbykvIvJkXtoixts
         Z6tUR1+LtgjaUTTrMOzXEH9Cderrk8lXK4sXBixjetK1vKdkotfv9NcRWEya8v4Q4Cuj
         jTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419926; x=1778024726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GtYCp4rJQ2CdnwGIUcHG8UWOZSQ5VpjJC/jcAlis1wY=;
        b=WfIv7TnpwIRtcqpTSF+mTtFoMoF9iix9vfym/ej55FDrDocSBCu7+awVE3UeeNXm+O
         SroGoHs7a87OmlmEvgZ+75WsBDyWyt3itpIx+fCnUJ7BQZFEKUQ9Wzni759YYonypPHs
         5IYCIdgPX6i8by+jH3xnBOBKaXAW/X6EMngf5wPqirubLVKNqlgVTS4dkoDwJ045fGV/
         dBn/BEKJu3KgpDZPVf7dTaSOpD8oDmrXGWvKJgMKUsp32e8sry2fkUWV+b8s3SYA1xaP
         mY0WN5Aqk2RRy6wBuji4xfFiOmONlZ2vpjIynpMy6/31OlbUZVTy01yMmhGkaBiJnS6Z
         SPFQ==
X-Gm-Message-State: AOJu0Ywt0O7CaTjLXYqpw4mmGcXJ7CGdChKfBfJl1de8EQWJEPfWBGeb
	kClCimvfOBmc3SOppKiPTnQgS610yTxy/rvegZmCbm6GFyecqhd+xsMrV5OxMI1nqeI=
X-Gm-Gg: AeBDieu2GakhiuGkKxVz85ZfHzbl5K3GeQCguj6//m5xS4etkecBGZ/dYTo4VPwhEWA
	iWYBY0jEVW7bO4+i2v352PTC44ZayQh6NQAlaf+rno/z7Kdmp8a1hL3JgpDKLbEXo941o5TXMZZ
	dmyZRbiV2TP47z5MVGjOhqENS5t1GmY5VvsPG3xyaMQq3mw87slJ1cGmPtk5nhy4elVr5JjOTT8
	/JoK+zLJd/v75UsbZDgdww8Tr0eQyzIapY99eE2k4EIjlYy2oXw9YptkD8YdZn6HjMubPOQbN1B
	G7rYNV6+W1jpVP8k8olTDXnTB7TQ4LJGqu5ykfCRVazWiIRx0wqQ+vzhvU7wh4PFWFh0nui85eX
	PXq7hX+htK5tt15wNiQTxDLpkLfglDMN9RKXMKUXaC5RBribRJcOU4S5Etl8YzyptTiegRhD+SN
	iHXYjhW/pzndrHXfenmWbbfOSe
X-Received: by 2002:a05:600c:6304:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48a77ae04aamr79854575e9.6.1777419926057;
        Tue, 28 Apr 2026 16:45:26 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62982135e26sm225938137.3.2026.04.28.16.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:45:25 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 28 Apr 2026 20:45:03 -0300
Subject: [PATCH bpf-next v8 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-selftests-bpf_misconfig-v8-2-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777419912; l=5258;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=GPft9EUuymX/ePLsx8D1NAl+xxMNBZzC0iSHAXYAKbI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBh0V0v/XirpUaW7a5NSaeQFZb0bBC0Q55UNG58qrd0MeApRr3pt6OFEYcVcT9EYRkUjvrhb2qL
 z7+F/KpaTBAI=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

test_kmods/Makefile always pointed KDIR at the kernel source tree root,
ignoring O= and KBUILD_OUTPUT. On distro kernels where the source tree has
not been built, there was no fallback and the build would fail
unconditionally.

When O= or KBUILD_OUTPUT points at a prepared kernel build directory (one
containing Module.symvers), pass it through so kbuild can locate the
correct build infrastructure. Note that module artifacts still land in the
M= directory (test_kmods/); O= only controls where kbuild finds its build
infrastructure. Fall back to /lib/modules/$(uname -r)/build when neither an
explicit valid build directory nor an in-tree Module.symvers is present.

A selftests-only O= value (one that does not contain Module.symvers) is
intentionally not treated as a kernel build directory to avoid passing an
unrelated directory to kbuild. The parent bpf/Makefile resolves O= and
KBUILD_OUTPUT to absolute paths before invoking the test_kmods sub-make so
relative paths anchor to the user's invocation directory rather than the
sub-make's CWD.

Guard the clean target against a missing KDIR unconditionally. In
permissive mode, also guard the all target and make the parent Makefile's
cp step conditional so that a missing or unbuilt module does not abort the
build.

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
index 63c4d3f6a12f..dcba595b4b99 100644
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
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) modules
+else ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) modules
+endif
 
 clean:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) clean
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O_VALID),O=$(KMOD_O_VALID),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) clean
+endif

-- 
2.54.0

