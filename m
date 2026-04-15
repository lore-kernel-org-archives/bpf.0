Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDF38C430
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286780; cv=none; b=ntp3pmGjEz2hDu+tJsV+8PwPx7EhANn6cvYv3f2VbpUDdad4WLUPSLXUUWejn0EA36nITQk6h5fReml7giZZ4/wXNMgihXk2Mr8pSwykRqfWjKNhLFPm7bZS1Ko72tCMt3Bj8TkBhxEKtJy2ZKLLh60ZGskRg4JBnzl4ExodTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286780; c=relaxed/simple;
	bh=+kWvOBx4rqawz2mTUlUsnpWSyI2UI+9G8NEPnIz/3AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDRgN5Xv4A8sk+x7zu3bZi2f6pu0chx/R3+UA0mEk0g87Z5D1obj6drCT2iVhGauizSBA74QQz/zCmJ+8fc8UT8Mn+udlkxzFGuJAMA8FkwSjD83/De8dfPPBSMROhEW5DpYIni62DnVGXybvcUUte3kqogIyzknYTeeRhkLBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UpJ2t6bq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UpJ2t6bq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so111363255e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286778; x=1776891578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhxRSOXgksPtZIm+YtJv0n+SeIRWIfViVplH8pw/2xg=;
        b=UpJ2t6bqLLggg8d5fS9iP2LqeGJxTmGLRrv2ZlDTMchtEadAB/b2m++kFtJXT+AYHh
         tW7Yx09DXE0vj0CA+9be9sGqn7pzOlWqEZA0sWyyABAxO+GSpzlbo7q+KNXfOuCIcEfs
         q/uXd0uzNUt+dINSwxlO1xnadJyWLChOV81DPfOdAyCD1XECmkwT890+7N33HMATlNP+
         juT4eqQ2Vqz/ww+m5wZS+5xruWjQYsbgnAph3+F2baad1jgZBsgp3tAILzJnKDZJLKgZ
         JzAk8kVYcQLeDv3m57n0U5eNcX8aZ7509rEA2FoM5q+XhPmBIGS17du/27rQIazxmL3V
         dlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286778; x=1776891578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nhxRSOXgksPtZIm+YtJv0n+SeIRWIfViVplH8pw/2xg=;
        b=FAlhUxsDTVFgPU0fOEArggxNrX9FyvJsOf+H0sYRxz1yAU182X3X3X9vIjisXDbG5Z
         B9FxCWnuVDtNJ5dS3KDc/S6KPYXDIoCjGq2VG3Bt8DQx+XMXZyzpJDAzztYuRB4XjtBS
         Nd/3QO1L/dbNAjIEVIGmvyaAWhOu4VqzCbYWNDWpYKeyADXEXbbpAoOPaIH2pTjcnaWE
         NB+tP8miLnWyV8KaxWzr35mbgrXgy5H00O6TiEv73XAzxQgkIeYGQ0vkIfkmFu2QZcSB
         +0+BrvTnhwoTGAM7R5qdYhqx8JDcZHpSndTbOb/xDa87UNyJe4AS5/o5nEK4DgHuvh45
         ElOA==
X-Gm-Message-State: AOJu0Ywej7CRbCQrYOJtG5fiwaaQfFUHh4sBvMI01KfG1CG25tjwqmrm
	HrEanUusLBYW4vXdRHafc3MPmzhOQqQ9aZp09oZBaE+Pbvsf/XOK2kSU4rWoAFpfEsQ=
X-Gm-Gg: AeBDiev/hNmJNtfEA+ZLpuVyQvAZw+EGFo4lVEC7RuYovQqUSSFOGl9DDCFt1Mmo270
	Nse9mxQrGbkMdbjSRunAR77fWMwPIWNiUUVHsIaSEgtOGDyAk6FeQM02XWE+KH/Xx3DVoyrzNZ/
	R1/JSjT2/Pyfs+2M84Z2NbkDlVL7+hdbQtMY11S6dc6ZXuJafGAypJhHon1ZsEp8dlK9rbLFJEG
	DTE0O2+hwr2XPhe8nfIaAmZ6ncJ7vA+7HnIWUetjPCKfYP63onkC6Ila0s+vS5P+r2+lMdM3HYP
	yvgXFp6rAvqSgyIk/nF2mrZVv7r+t+3ue9tp+BHsB8JDckuSnykhIjAdHhHwTvdpZERzIVPE16W
	bq2XF3D+xIwj7mn8HAZ0U7cRDyR+XKHDyMojbFzdt5oqBEpgNCKLnz5r/ut2CenGoUAN2ujBIfM
	m15y7vLU3847dFXR8JGiggwg==
X-Received: by 2002:a05:600c:4215:b0:488:d9ea:3da7 with SMTP id 5b1f17b1804b1-488d9ea3e0cmr186909635e9.10.1776286777618;
        Wed, 15 Apr 2026 13:59:37 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f960dd1sm4349265eec.25.2026.04.15.13.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:59:36 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 15 Apr 2026 17:59:20 -0300
Subject: [PATCH bpf-next v5 02/11] selftests/bpf: Fix test_kmods KDIR to
 honor O= and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-selftests-bpf_misconfig-v5-2-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286764; l=3353;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=+kWvOBx4rqawz2mTUlUsnpWSyI2UI+9G8NEPnIz/3AE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHw9iObBL2lYNYLPF4X+24/9V1YHI1I/Iy4F5roXbaVvsXhqCbcE4EIjR5Dj196KLRJ7pvW5mKf
 AXaBLXgqEDwQ=
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
 tools/testing/selftests/bpf/Makefile            |  2 +-
 tools/testing/selftests/bpf/test_kmods/Makefile | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c8ba8ccc2c6d..5c4cdf1dafc8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -296,7 +296,7 @@ $(addprefix test_kmods/,$(subst .ko,%ko,$(TEST_KMODS))): $(VMLINUX_BTF) $(RESOLV
 
 $(TEST_KMOD_TARGETS): $(addprefix test_kmods/,$(TEST_KMODS))
 	$(call msg,MOD,,$@)
-	$(Q)cp test_kmods/$(@F) $@
+	$(Q)$(if $(PERMISSIVE),if [ -f test_kmods/$(@F) ]; then )cp test_kmods/$(@F) $@$(if $(PERMISSIVE),; fi)
 
 
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..10f202bd0d8c 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -1,5 +1,7 @@
 TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
+SRCTREE_KDIR := $(abspath $(TEST_KMOD_DIR)/../../../../..)
+KMOD_O := $(or $(O),$(KBUILD_OUTPUT))
+KDIR ?= $(if $(KMOD_O),$(SRCTREE_KDIR),$(if $(wildcard $(SRCTREE_KDIR)/Module.symvers),$(SRCTREE_KDIR),/lib/modules/$(shell uname -r)/build))
 
 ifeq ($(V),1)
 Q =
@@ -14,8 +16,24 @@ $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
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
+ifeq ($(PERMISSIVE),)
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) clean
+else ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) clean
+endif

-- 
2.53.0

