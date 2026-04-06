Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CC3876C3
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491897; cv=none; b=YrmJd2bQyO6qfp5oj/pbc2GC1g7OIx+MTtg6zo55t4svmmNTHOomvSSsc8XqpzdqklE0qgUgSQGh1VFdgeRQNNszh9DIND9vldUlj97MCm5CgmXGb+NgePNONjFIFzAeREdYpkRbicCUr5dB3PZeo+4TXTbWBqh/snCrHiJdhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491897; c=relaxed/simple;
	bh=hAVHhP89HnimL0oLWLC0644/U3kawRazlk2a87ZKVDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiUtr184nxN3Oo61mg+7rqKBK+1R55xfC6ZJD1ccWR5g3aItIizZs4TT6OoNGGvba6q7+rt3EjJ0MaHUEBgyT68RKaiFiUvztdSQWI5rrG3moZUMYtEgmhagitS1j3LYYzFiMhBgXtSXb1NpB/OdDBt4Z4YriL/esHBW7Jh4PBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YqNt59q2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YqNt59q2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso18373565e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491894; x=1776096694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpHU6AK4GWIH/sbfOIo3yMGD1Gjj7cgz5YN351qEJrA=;
        b=YqNt59q25AJOTUik4mxzzGx+fmEowbdWCrql8j6ol3fqHytR/Jw/giJy3id1ZG1XQD
         OCdhgGDzP5rcxWtQhJERByz433v08LLVDneGse5ZLQL4JKRKmIw/Afx41PNrpyJMwM8v
         yrgAZCjX+CBEXRI1fZCmI90nIb1mMeZtKX4EiLgOv+XSkrjlPZr9a28qlJpHT53uMYW/
         WM+T5X3gwLnPVQcjp6wIs4bmvwzdw41OUWgFVHzYc+Cem8GCGZu+rjkqF/Z+DsWmO6Q6
         3GccKZvRbblQS3OYjE0+zvYSoHi+F6+UlYfwRf1VhvFy4XpQHD1I0zxoqMAW8lojZqvv
         Ebmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491894; x=1776096694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpHU6AK4GWIH/sbfOIo3yMGD1Gjj7cgz5YN351qEJrA=;
        b=j/TVeQAOcgQiG8m567tW0CPjK4ty4VcPhICb4VjjAj1EoAgcujpRUbnFtZBSQVsh24
         fx8v1jlj5ytwoh2SOEAynOihR+v40Liw51MeICC4REvu5H5MPecKSwfrtTNFIUe36Qmm
         iNixqdO5FJWk64FJ+2MGE903ZBNYXbhSZ6g4Tn3O5MT1vU51F/xLJ5mO8WSOayIdC/+c
         cnu1PHgdlc76tBlnppMq5grvCz+XncRSrkoWhtsjXtPKT9iYzMq61N0VXP5wAzKn1mOF
         OPcONqKXa56EqZCNKdgLiA9emQfb9Fsk99A75AOTMvaOjjmVt93BNWKqYUG16cMZAWyC
         zCwg==
X-Gm-Message-State: AOJu0Yz3XGgDbdAqS8j8hg0welyKp8r0nNwUsHuj2uX81PzKl5Z6WZTs
	1IrO0rhnGvi8/EZOCnvoh+DKf9/KLFAjukVzX094B93XbtP3IZOIrw/ZPolzTigLy7ZCzMtNdH0
	UT+Eu
X-Gm-Gg: AeBDievUSE4V1YUq772ulsRSLw7P/WhNwoDv8dh8Q1LJYukrBT8DAdmot4gbjaXQB85
	XEKF5pQGRthVDgSIO4DNNRs5fqKhj43NPFk+bwtu1S49azQPd0tpOP8S9rpompRpDEO8FXBgY3s
	Rwp+D495cbmVE6806Ag+lsQ5RUPr/5Nx6bVHSQgYkyK0KO4Of2t9oFF7TI8gm0Szb7U2DUzJdCv
	HNaRLLkIDAWq1eVRqzVH6AQ7mePy9X1DWOsK8ZjWGO89cZZw1oyvB/cr0B30wxd3XuvqEuznIno
	swxUHhQ8IIpewI3xg5303HtmVGbxcC4MWygRgMeOQF5ARnGvqhIk1JWbkCw+7CiwyDNRxPl9dRL
	ya2YV5UZWGRSex/c9A/6gRvaMLZCwipaenOybyhELI0hm6HItCso7+z/G72lxvWx0wKJr1LiBOL
	aV5q6eolfBJY/x2HoCLcw9lZk=
X-Received: by 2002:a05:600c:4752:b0:488:7ff5:2c67 with SMTP id 5b1f17b1804b1-4889976ea80mr196842705e9.12.1775491893645;
        Mon, 06 Apr 2026 09:11:33 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9cbbasm17235894e0c.9.2026.04.06.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:33 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:23 -0300
Subject: [PATCH v3 01/11] selftests/bpf: Fix test_kmods KDIR to honor O=
 and distro kernels
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-1-587a1114263c@suse.com>
References: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
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
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=2399;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=hAVHhP89HnimL0oLWLC0644/U3kawRazlk2a87ZKVDY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDeP13XzXftklBawabTHxLwO2wI9EQvIwa/FVGwg4dP+BjbJ6PtnN0K0zE+moJIbSNzV7I3+hN7
 gHqvarJypjws=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

test_kmods/Makefile always pointed KDIR at the kernel source tree root,
ignoring O= and KBUILD_OUTPUT. Module objects were therefore placed
inside the source tree rather than the designated build output directory.
On distro kernels where the source tree has not been built, the Makefile
had no fallback and would fail unconditionally.

When O= or KBUILD_OUTPUT is set, pass it through to the kernel module
build so module artifacts land in the correct output tree. Fall back to
/lib/modules/$(uname -r)/build when neither an explicit build directory
nor an in-tree Module.symvers is present. Guard both all and clean
against a missing KDIR so the step is silently skipped rather than
fatal.

Clear EXTRA_CFLAGS and EXTRA_LDFLAGS when invoking the kernel build to
prevent host-build flags such as -static from leaking into kernel module
compilation.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/test_kmods/Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 63c4d3f6a12f..47b1bd70e276 100644
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
@@ -14,8 +16,15 @@ $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
 CFLAGS_bpf_testmod.o = -I$(src)
 
+# Ensure KDIR exists, otherwise skip module build and clean.
 all:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) modules
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) EXTRA_CFLAGS='' EXTRA_LDFLAGS='' modules
+endif
 
 clean:
-	$(Q)$(MAKE) -C $(KDIR) M=$(TEST_KMOD_DIR) clean
+ifneq ("$(wildcard $(KDIR))", "")
+	$(Q)$(MAKE) -C $(KDIR) $(if $(KMOD_O),O=$(KMOD_O),KBUILD_OUTPUT=) \
+		M=$(TEST_KMOD_DIR) EXTRA_CFLAGS='' EXTRA_LDFLAGS='' clean
+endif

-- 
2.53.0

