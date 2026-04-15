Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1638D687
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286784; cv=none; b=jNPmOQonDmkb8/FDn/6FqgfZ0GHUXrTA/50BeLDKlFI0TihtJORVm34yL0KmXCXvDdbIJGQ2B3/6Dr9k7XoX2K+Njol/oKOB50LQqUcpw7GiUZlZn5ExPczhNh4/LvCnaXmOtayKf5EbUPgVuiFNe9Un0ytcXJ61lSX8uILATDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286784; c=relaxed/simple;
	bh=FhjfANddcaEijUdTgR5u6m0jgGERKsEm980Hv5Uy4zY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfZqxXhHhIz46FE2XDTEryGBTFZGIuScdYDc3GGe0s3J0WqKAgFM6G8ERmkRlF9wGeH0WbRZdtBnzDevt6OdGOrrym8gO4ZhGn135tUNCAYp419Co6Gq1MV6a01YQKSNVLcxlZ4Zi2ZOa13It0PIhmmasvDhJ3K/E946pnSh2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dX/MItMw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dX/MItMw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so66005585e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286781; x=1776891581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUqHI/ssQrLIALRlyiIzc3ygk+501f0qcP0OQItY+xI=;
        b=dX/MItMwDTUEFjB0mfFwCVMlJZArEvSskeenBypQ5gmQRCXi2HSy5qFjAYk4Qfo5nK
         QF9hZj9T4g9oWp59NfzXgnpHvyW/gUsPPRGlk+hr1+yZp9RsuhO0OgSiC0jmzmf2MPFu
         Xkd0BBp+uUozl0ojoOpwHx3N2BxqXkhGWLfhIoqA8qrWcI/nt7SAHPv40jgipa59FkGR
         3UMNxWKNtZQQHx/zKJkycw1esh/r6RsuG2GnKAoq4bv2bH3IfnoD3WcA9ZT7pOgn6+JN
         wMG1QVn5S3XzB3cfKZgprSUV6Q4Jsjf3W+gFdploCwabRDJ91hbFRjsO2yyWYxQcKI/R
         gCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286781; x=1776891581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUqHI/ssQrLIALRlyiIzc3ygk+501f0qcP0OQItY+xI=;
        b=UmWMVZh4AZ5Hs7dMsJ+fZWxHUaLw7diTiSUXqyiXZBCO67FrlLjRnKVDYpeZhlMcgc
         OCy2fRe8qjLra7+C7IKAkaVPBvXF6Kerq0BiK7O00TKzFlEC6K5TmDtGyo2QvamfRHvf
         GHeQm7XlVmOjre5DqcfZvlGJ1/vOuaf/e7OpxMAYOTPZZ2UuChV2ASt0Vt/VhhNbdUZ0
         F4tBxK0+q7WH9KI34wVmYr8+pPYx3ogzGMZjPSOMUIaB66o17BXBIceeHXCn2Z1QZjL6
         XLDQUc9I37aNXpOEvRvwlp5k2NI/k0JHsN21F+bVq25b6k7aoMdKCyH/E6djZBlgjaR+
         SWKQ==
X-Gm-Message-State: AOJu0YzCMsTitrQXUPrU+IrHtoGWW/mmB6gJlQakfqHukmXepDBdfbza
	wqkww7s09Qu5MTeOSQh9S+hVwDYzOCo0jPYXkjg1wnoGQf7rbLlBR78B7KNByNgcPEU=
X-Gm-Gg: AeBDieuAOj0zuIOaT5grRZaL5xYjdXLxwdrgKPB1LrE3YzKt7sPxoq5sbjcw4QWZOPp
	5/X8s7G9NjJ3KT85m23TkPt7k0jO3kaeJOgn4oDwQh6H2Ew/L2kg7pBBI9V3VOwbWuMTKOONfkc
	XkAMIRz5yB3xtq6pPEcSP55XUpKDNVmT0C8NwWcIhIc692Anask9ne/gRwy0Si1m/CysJSmt6jh
	GI8885pAocr8Sys/eOH/VQnv3Qgsu1gHLakmDj2u8bGvPusmiav6s2Fj9hg1nLxHPGeaPeqSA8/
	ld7I9Rv/a04o4slO1LX+uCaUtEEao7e0WYux9PNwv6pqiFNbHEzp7htOgZpiOJkpaCSoC20aJel
	V2i7mRBBnOq+LiFtctCdej0lNj1o2zo5Wba6oMcxFF6/08PeJehIdWDRGAuV0mj7m3OVRjs+mOD
	pcuYNHx45nAPo=
X-Received: by 2002:a05:600c:4443:b0:488:8577:d9cc with SMTP id 5b1f17b1804b1-488d686be7bmr307907335e9.20.1776286781028;
        Wed, 15 Apr 2026 13:59:41 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c641d18a7sm107625c88.0.2026.04.15.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:59:40 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 15 Apr 2026 17:59:21 -0300
Subject: [PATCH bpf-next v5 03/11] selftests/bpf: Tolerate BPF and skeleton
 generation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-selftests-bpf_misconfig-v5-3-03d0a52a898a@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286765; l=9192;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=FhjfANddcaEijUdTgR5u6m0jgGERKsEm980Hv5Uy4zY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPiG33HXXQ/XXdT0fxBafTp1XGhE0Cb1jCBDTNDylBsgrSLto8jl22v7/Qu6R6pCHymRomnyf4U
 ZAPzyN+qZiA0=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Some BPF programs cannot be built on distro kernels because required BTF
types or features are missing. A single failure currently aborts the
selftests/bpf build.

Make BPF object and skeleton generation best effort: emit SKIP-BPF or
SKIP-SKEL, remove failed outputs so downstream rules can detect absence,
and continue with remaining tests. Apply the same tolerance to linked
skeletons (TRUNNER_BPF_SKELS_LINKED), which depend on multiple .bpf.o files
and would otherwise abort the build when any dependency is missing.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 104 +++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5c4cdf1dafc8..a305d13409e4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -477,22 +477,26 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $4 - binary name
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2 $(if $(PERMISSIVE),|| \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2 $(if $(PERMISSIVE),|| \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2 $(if $(PERMISSIVE),|| \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$4,$2)
-	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2 $(if $(PERMISSIVE),|| \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2))
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
@@ -598,47 +602,77 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
-	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@
-	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h)
-	$(Q)rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
+	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+		exit 0;							\
+	fi;)								\
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
+	$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$< &&		\
+	$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o) && \
+	$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o) && \
+	diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o) &&		\
+	$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@ && \
+	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h); \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+	}); \
+	rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
 
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
-	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
-	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+		exit 0;							\
+	fi;)								\
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
+	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
+	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
+	$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@; \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+	}); \
+	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
 $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
-	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
-	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+		exit 0;							\
+	fi;)								\
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY) (signed)] $$(notdir $$@)' 1>&2; \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
+	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
+	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
+	$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@; \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+	}); \
+	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
 
 # .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
 .SECONDEXPANSION:
 $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.bpf.o))
-	$(Q)$$(BPFTOOL) gen object $$(@:.skel.h=.linked1.o) $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps))
-	$(Q)$$(BPFTOOL) gen object $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked1.o)
-	$(Q)$$(BPFTOOL) gen object $$(@:.skel.h=.linked3.o) $$(@:.skel.h=.linked2.o)
-	$(Q)diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@
-	$(Q)$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h)
-	$(Q)rm -f $$(@:.skel.h=.linked1.o) $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
+	$(Q)$(if $(PERMISSIVE),for f in $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)); do \
+		if [ ! -f $$$$f ]; then						\
+			printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+			exit 0;							\
+		fi;								\
+	done;)									\
+	printf '  %-12s %s\n' 'LINK-BPF' '[$(TRUNNER_BINARY)] $$(notdir $$(@:.skel.h=.bpf.o))' 1>&2; \
+	$$(BPFTOOL) gen object $$(@:.skel.h=.linked1.o) $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) && \
+	$$(BPFTOOL) gen object $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked1.o) && \
+	$$(BPFTOOL) gen object $$(@:.skel.h=.linked3.o) $$(@:.skel.h=.linked2.o) && \
+	diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o) &&	\
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2 && \
+	$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@ && \
+	$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h);			\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+	});									\
+	rm -f $$(@:.skel.h=.linked1.o) $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
 
 # When the compiler generates a %.d file, only skel basenames (not
 # full paths) are specified as prerequisites for corresponding %.o

-- 
2.53.0

