Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84A466B5B
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564944; cv=none; b=Er0UCzuw0mbqQxx8czvwbvo8JylBMaowp80Pt6nKivg1KnnH3a3yzopOWmm+VYicuXgCDc5j/oZpIKedyAxxGa+L6oju9tsZaItMsaPeBMOSNYBvXMojVOxm4gyLstBKwso2s1j27gPHfEpBcuSdjirl3ivDchrlRlFjvV5ommU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564944; c=relaxed/simple;
	bh=0QJYdccmCS5Xa21Yb/0zhA86xvgSH0oN6kSd6sMETRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7Fyzh5f4QLPjQ77hx2KRScBC78Tj1UMb/CggqA+CRdqLXGlgXsX0h/iSny4y+6M/SUkW0TiPsi73DykyAdaiCJih/44FqYWLdoaHcZJIKqraB3gaw9AFa79wb8xiwOOW8fwxy9RXt4pT+u4ojIz1+lqlr12GbHMcJB0OgzasgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qi70fw/i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qi70fw/i"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba92146cc86so194376366b.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777564940; x=1778169740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd4Mjpp2AlESfBnJvdKqbI6D/125UdC7Iwt7tAYiysY=;
        b=Qi70fw/ihfBRW0+Q2wbBM5CZaALqnLywVXHP8M/OnSNiHsPWppN0oXtODJezm8vY1Y
         jF7vxF8P4/Vv11zzQ9cLi97JILJADQeSSdJc6rN2RYDHEfo4D6WOMxPhuv80p1cKJJTl
         ID7ikeLbBIAmsEP4irIrVI6WUNeOBUGD8g8lx8FLSrkRJI9bDJ+vAJMz3DXKWQTjL1sF
         k2DgFhsTbZwoIeh5Fm38ZJh/e3ivAuwSmbwF//szu9syLwn82N2ZjW4LtOmrDH6hRGCx
         OKq+60EulaYRnu/jmkWn9KiMxSJJIm8YXBoyJoBee9AOiC7I0+CyuRIZ34MincKWOMIk
         BxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564940; x=1778169740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gd4Mjpp2AlESfBnJvdKqbI6D/125UdC7Iwt7tAYiysY=;
        b=NjiinK8Qm9Jickrloq/L2JHlSoi4OdiMUk/2iv52aPjfOmCyoscPzGLi9ifvA4JH2s
         9TX/CSrh60In6+wLga3YS/b4XhiERV3qme3a9UtOEsHiCqRa+UlI2WumzK2oiNaCSup/
         0mWsQonMGp1ICE/cv/aIXJMkeqMZxzbQPnq8Kd5NwmFtVupCGxvohAQEKm7GEhwl3Z3w
         XZVLsU20rnXPPMmsiXtra7JfphER208OQk93tm4IfN4MDBaAJG4sikVKneaGFHCaQswe
         Dq7r5UctUC3EDn6eU5YRQ3do6bR9Ciyw2rN/U3XhKxsvFC/cNF7qvNJfm1b5rnVDzeNs
         JttA==
X-Gm-Message-State: AOJu0YzUf6h0dyh7Pa9bDZgEzLv5GxVck+cADIM3IzNU5AGz9rJJQLKO
	s11mnf2J56TQ/wxbRVSl9mMbcNJpvEk76xUXvj+jLGfmkQvFljgfX6pNS6dzRfxS12s=
X-Gm-Gg: AeBDietqM+hYuB2uRiRD0q9Ug34duryPeQ5bGYR6dfzE5mIkgbfnr7LjXRVwe/4BHsD
	o/hptkxdj+eWuLsC4NG9BzPdUOfSpJY191p8+w+FNBKj6RMim0Rhq5F8QPMtJSag3wmfGikRoI1
	oq9aLToYVU+tvUvGwr2dC7lDZoWr9kMV8JBzg+Z4XP0iupz+3cBdR9ETa9JHVaIbzWLZ8ISkoJb
	am4AvGfu0k0rKuh7hEiieMeIOZjwwhn5dd3NCh1Qkh+kyL6XhKP4PE7ngKTVv3KCpgCba2KBxog
	Cwx6wT+0PYPMymTE84z/oV664WvMzyRJOq3YRgyATgINpdthzVWZujohXiwGDO/BG9VNFT5O2e6
	vtvY9C2mOYZgMvkCnWUmGCWpnmcyDHrzzeSf7ypsJLL4vwea+m6oeZ9aiU2nNcf6zErWIdV4Ouh
	A62QHd1a0AJx1LpFgssq0xIgkE
X-Received: by 2002:a17:906:f588:b0:ba9:2611:31e6 with SMTP id a640c23a62f3a-bbac47d4771mr267906366b.6.1777564939701;
        Thu, 30 Apr 2026 09:02:19 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5512bea4sm10122857b3.35.2026.04.30.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:02:18 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 13:02:03 -0300
Subject: [PATCH bpf-next v11 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v11-2-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777564926; l=5932;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=0QJYdccmCS5Xa21Yb/0zhA86xvgSH0oN6kSd6sMETRU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHFJG2W2igv98If20IRJKII1EhuAUKdgowbWUrCs9ZRJ8UjjdvQo164W21WEYaJyKUyxUH90Es+
 QbKQn0xy6kA0=
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

