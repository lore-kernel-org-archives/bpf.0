Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75C374A1B
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867185; cv=none; b=pDy78rmPUofrGIcL3mNvxAv8YyWjPoYJc1yVP6qCZ2DINS3ncju/jL5a9aO1DJ/b9lzwJK40VfiXxFdFUp2hLJOiePgXzdd+uVGBnBBEtNHztssYEJQH9lOV9NOeAlxEwPkf37ewHJTOVTUC9QKu5D3Ag0PpUZoaE/U9hSmQquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867185; c=relaxed/simple;
	bh=mwGvOFd97kkVr0YB+8+uqcJgRFAtHAlgmYaBhh+0PCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwJKHpReoeHRncUB48g3UASpC/2uQeAJC4+IL26iQOjMStL9cK4pB3VvaVkVDmwbEk6wEocrzQbKZN9N9aT/AKv5iVejhRBpmzZTHjTU5f12uU9w6IcP7QYVsp8T1tJps34ID7kbWg9hiqvvqavsEMs1jLuJxNY7tHjejN5PW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPjV1J9c; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPjV1J9c"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacf197759so346225ad.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784867182; x=1785471982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZrzHRZlne2U3Ak0CyvUeiuoB2I+Amcu7L1ipUr8OUY=;
        b=rPjV1J9cEtN7NNTx/w2RGssJbXKploZ49gjo9Ei00PQWlbvwoTWbaNqvY3QbhJ8wl7
         g4wnreCZPRMO7aDERjTNtlZT6NoWOIhhhEKkSFLo26F4OAmsGRY6LD7oNyLXAFUwXqNR
         +yDhZ7il03MFu7wx7UKNKTkEYuYK6dGKfrL77zF5FADehbXtpHauUSqGemVGIIzr6Wp9
         uM/FpOtMM6GTOI+6EKp47IJv0tPZv3YGztAwx8nxAC0xiEyMo0xxCTyZTGlZgXjl+XUn
         jDq/vXPQNXpZLPL1Q7JXYLk5phDrDNemfU2xaJ1SxMM/H/JwuT5fNwkCr0G7xH1PGdUP
         sIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784867182; x=1785471982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZrzHRZlne2U3Ak0CyvUeiuoB2I+Amcu7L1ipUr8OUY=;
        b=PSeeWMZTe/NCIwp+RxhayzDrYkckPlQ0gXCQxRBHCi8xzwkaotny8B16yYS4N7Vs+Q
         vytskEbUedJ11qcU7rzp++3tnEkW5kOZMWig7nDr3Zw5Xr2SoO4tS7oj9MLf4xp05+hh
         Yforju4O1cifBuQnqEHLxDPNtNeEY27aerunU1NxVH/bKrFr6w6qgiSWSov6n6AiK5DW
         d0apLvabrPNfWCOn9EDjU+EtshzlOfV+9P3eDuZpKleUVk65KynER0IEDwmBshXUu+83
         ghr7h1QqrM+O3Hj9E8xMfhT6zXxD1xwdQp4lriWMKtTOVLUJmw+eL8Rg/YSC4hvw37wL
         w26w==
X-Gm-Message-State: AOJu0Ywna4UcJ7XZPjrdgkPLroRZYjID+HkMxWZK4izTtYqu8aLyG0i1
	Ul/hHgNTPbGKnnvAPHvDcca9Fchc9bUa42wbGdHcB4Db4UPZ6m32eZqFpSJiVnZ7
X-Gm-Gg: AR+sD12NtVqMdcto1IujNXLYNj4LafJyyYADkcJbpsaGydZwUdfpIHOPye23cAKl6Kk
	qZNSq4d5wTT2igs4p0f/lE2jE2GCmm/V9U4Iro/y9rx5cwfsOhbzddWiotTXhlq47x7jrsCw+cM
	ggE6pbPAPObZFnQG9rT6pyzcB/XMyi/8H3t2WWLyVR2RS005Hy66KA0ODS316qJEVICC33h3kpN
	XXwcU1hQuhna0KtQdOFj/BtzcI9N9w5L4fruH+Xrp6Eu97ugV2/ft8PZEb+TLJxYaNQafBJP4n1
	ATS9J/X1SFnCLLD9Xkp9IL0cM2Zc6iR0pi30h9OUIOsVSPVGAz46f9JS9eiOv/3rGlVYfcgOxkj
	n0gDj7bXUwXCrDnRrJIi+ue3Nrk1xFuCxBrq0K3F6Y4BNVVhOQeBdEKCGPjT+AcDxa8aUaA9lsd
	tKSnhD1bQU5NtPlcDKjP2Z5Va77sxjD3R2J9435JHLelQ=
X-Received: by 2002:a17:903:26c6:b0:2c8:1c05:16bb with SMTP id d9443c01a7336-2cfa7488f3dmr65691755ad.24.1784867182223;
        Thu, 23 Jul 2026 21:26:22 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f0072a8sm44437015ad.34.2026.07.23.21.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 21:26:21 -0700 (PDT)
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
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [RFC PATCH bpf-next v4 1/3] selftests/bpf: extract BPF skeleton generation into a helper script
Date: Thu, 23 Jul 2026 21:25:58 -0700
Message-ID: <20260724042600.175440-2-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724042600.175440-1-nickolay.lysenko@gmail.com>
References: <20260724042600.175440-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The four skeleton generation recipes (regular, light, signed light and
linked) are near-identical five-step pipelines - link via "bpftool gen
object" three times, compare the second and third results as a
regression test for bpftool's determinism, generate the skeleton (and
possibly subskeleton), remove intermediates - duplicated with small
variations inside DEFINE_TEST_RUNNER_RULES, where every line pays the
double-expansion escaping tax.

Move the pipeline into gen_bpf_skel.sh; the differences between the
four variants become the --lskel, --sign and --subskel flags. Signing
takes the key and certificate from $PRIVATE_KEY and $VERIFICATION_CERT
in the environment, like the bpftool binary comes from $BPFTOOL. The
distinct linked/llinked intermediate infixes are kept but derived
inside the script: tests listed in LSKELS_EXTRA generate both a
.skel.h and a .lskel.h from the same .bpf.o, and distinct intermediate
names are what keeps parallel builds from racing. Build-log messages
stay in the recipes with the usual $(call msg,...) helpers; behavior
is unchanged.

Generated skeletons are byte-identical to the previous recipes'
output.

The script is a prerequisite of every skeleton rule, so editing it
regenerates the headers.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile        | 107 +++++++-------------
 tools/testing/selftests/bpf/gen_bpf_skel.sh |  93 +++++++++++++++++
 2 files changed, 127 insertions(+), 73 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55d394438..2ed953b84 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -567,8 +567,6 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $1 - test runner base binary name (e.g., test_progs)
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
-
-LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -628,82 +626,45 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 					  $$($$<-CFLAGS)		\
 					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
 
-$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h);			\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-		exit 0;							\
-	fi;)								\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
-	$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$< &&		\
-	$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o) && \
-	$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o) && \
-	diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o) &&		\
-	$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@ && \
-	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h); \
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) && \
-	rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
-
-$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
-		$$(RM) $$@;						\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-		exit 0;							\
-	fi;)								\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
-	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
-	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
-	$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@; \
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) && \
-	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
-		$$(RM) $$@;						\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-		exit 0;							\
-	fi;)								\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY) (signed)] $$(notdir $$@)' 1>&2; \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
-	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
-	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
-	$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@; \
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) && \
-	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
+		--name $$(notdir $$(<:.bpf.o=))					\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h) $$< $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h);				\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
+
+$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --lskel			\
+		--skel $$@ $$< $(if $(PERMISSIVE),|| {				\
+		$$(RM) $$@;							\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
+
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) PRIVATE_KEY=$(PRIVATE_KEY)			\
+		VERIFICATION_CERT=$(VERIFICATION_CERT)				\
+		./gen_bpf_skel.sh --sign					\
+		--name $$(notdir $$(<:.bpf.o=_lskel))				\
+		--skel $$@ $$< $(if $(PERMISSIVE),|| {				\
+		$$(RM) $$@;							\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
 
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
 
 # .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
 .SECONDEXPANSION:
-$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),for f in $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)); do \
-		if [ ! -f $$$$f ]; then						\
-			$$(RM) $$@ $$(@:.skel.h=.subskel.h);		\
-			printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-			exit 0;							\
-		fi;								\
-	done;)									\
-	printf '  %-12s %s\n' 'LINK-BPF' '[$(TRUNNER_BINARY)] $$(notdir $$(@:.skel.h=.bpf.o))' 1>&2; \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked1.o) $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) && \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked1.o) && \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked3.o) $$(@:.skel.h=.linked2.o) && \
-	diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o) &&	\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2 && \
-	$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@ && \
-	$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h) $(if $(PERMISSIVE),|| { \
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h);			\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-	}) &&									\
-	rm -f $$(@:.skel.h=.linked1.o) $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
+$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.bpf.o))
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
+		--name $$(notdir $$(@:.skel.h=))				\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h)			\
+		$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h);				\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
 
 # When the compiler generates a %.d file, only skel basenames (not
 # full paths) are specified as prerequisites for corresponding %.o
diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testing/selftests/bpf/gen_bpf_skel.sh
new file mode 100755
index 000000000..e234f3a57
--- /dev/null
+++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Link BPF object file(s) with "bpftool gen object" and generate a
+# skeleton (or light skeleton) header from the result.
+#
+# Usage:
+#   BPFTOOL=<bpftool> gen_bpf_skel.sh --name NAME --skel OUT [options] OBJ...
+#
+#   --name NAME       skeleton object name ("name NAME" for bpftool)
+#   --skel OUT        output header ("foo.skel.h" or "foo.lskel.h")
+#   --subskel OUT     also generate a subskeleton header into OUT
+#   --lskel           generate a light skeleton (bpftool gen skeleton -L)
+#   --sign            sign the (light) skeleton, with the key and
+#                     certificate taken from $PRIVATE_KEY and
+#                     $VERIFICATION_CERT
+#
+# The inputs are linked three times and the 2nd and 3rd results
+# compared, as a regression test for the determinism of "bpftool gen
+# object".
+#
+# Intermediate files carry a "linked" infix - "llinked" for light or
+# signed skeletons, so generating a .skel.h and a .lskel.h from the
+# same .bpf.o in parallel never races on the intermediates.
+#
+# The bpftool binary is taken from $BPFTOOL (default: bpftool from PATH).
+# On failure all outputs and intermediates are removed and the script
+# exits non-zero; permissive-mode skipping is the caller's business
+# (see skip_on_fail in Makefile.buildvars).
+
+set -u
+
+bpftool=${BPFTOOL:-bpftool}
+name='' skel='' subskel=''
+lskel=0 sign=0
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--name)		name=$2; shift 2 ;;
+	--skel)		skel=$2; shift 2 ;;
+	--subskel)	subskel=$2; shift 2 ;;
+	--lskel)	lskel=1; shift ;;
+	--sign)		sign=1; shift ;;
+	--)		shift; break ;;
+	-*)		echo "$0: unknown option: $1" >&2; exit 1 ;;
+	*)		break ;;
+	esac
+done
+
+if [ -z "$name" ] || [ -z "$skel" ] || [ $# -eq 0 ]; then
+	echo "usage: $0 --name NAME --skel OUT [options] OBJ..." >&2
+	exit 1
+fi
+
+infix=linked
+if [ "$lskel" -eq 1 ] || [ "$sign" -eq 1 ]; then
+	infix=llinked
+fi
+
+base=${skel%.skel.h}
+base=${base%.lskel.h}
+t1=$base.${infix}1.o
+t2=$base.${infix}2.o
+t3=$base.${infix}3.o
+
+fail() {
+	rm -f "$skel" ${subskel:+"$subskel"} "$t1" "$t2" "$t3"
+	exit 1
+}
+
+"$bpftool" gen object "$t1" "$@" || fail
+"$bpftool" gen object "$t2" "$t1" || fail
+"$bpftool" gen object "$t3" "$t2" || fail
+if ! cmp -s "$t2" "$t3"; then
+	echo "$0: bpftool gen object is not deterministic for $skel" >&2
+	fail
+fi
+
+args=()
+if [ "$sign" -eq 1 ]; then
+	args+=(-S -k "${PRIVATE_KEY:?}" -i "${VERIFICATION_CERT:?}")
+fi
+if [ "$lskel" -eq 1 ]; then
+	args+=(-L)
+fi
+"$bpftool" gen skeleton ${args[@]+"${args[@]}"} "$t3" name "$name" > "$skel" || fail
+
+if [ -n "$subskel" ]; then
+	"$bpftool" gen subskeleton "$t3" name "$name" > "$subskel" || fail
+fi
+
+rm -f "$t1" "$t2" "$t3"
+exit 0

base-commit: 87267b89459813cb50ab5377e076b639c07b4491
-- 
2.43.0

