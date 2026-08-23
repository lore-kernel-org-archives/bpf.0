Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DC3AF668
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514195; cv=none; b=fLfi5QGU2DrgdlDbeSA2wGo6Zn051njlkn2y1QuN+zgQSL/ckL2kHGWpcbCPf+b546A4J7rt6PKi3ks2F6JDEk9cA02NgsgjDBCPLNMzdEefAyiYdJiVu7NErXu/pjmUlAZqLMMACwqqHL5Otrd0x178qeQtmJGi649uD1cbyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514195; c=relaxed/simple;
	bh=/fF9EnyZ5MQLr2oNAtixDVE1XmYTEbfF+ifFQtN9/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+f0TFYNn55f1UjRvsV7cnqbIsNTd/GQaNXlkxl6Tekqt60jmVfMIV96H8JWlbmLno/l996yoK2GPrOO/MGv9VEZ1N+5kP0wW2tOAVOxldyvGXcwUbiWo0tW/4+3sdS3+X3I4S4ddpGy9jGN3ZqTHTladgoZio+CNjxHOExjF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8qEWvVj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8qEWvVj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so29749325ad.2
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787514193; x=1788118993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMFICrnM7Mhuv1If98exS7/PIoQ60OrwhK3LwcA+N2k=;
        b=b8qEWvVjM2AjEjRJLC/nxDjU9sMDLDhFMIK1UtNQtyr1wtRUiSx0arJsThiVA/gDMp
         /gZvLWjmainT8Uhz1l/5qsWnIJ/RH2tRuUt9V91qYn2hd/5c/Jzo5rcJPChuidzdE19U
         +y9gcBzxHQ9MjRd1sDMClkNuB8BjUgqrHNVjq+uBVJ184LMum7LgAc5XF0DhWR4xoRMj
         XmT7OODx0PKxgjOlBC1zm0Z+52651wZ50jX23hmp/4tVWMBfiDxXWe4J/19knQ4Fu633
         Z5UoUjTcWJlsOSIjSD6AlvWv8kTD4VlLDl9604ZaIW9HLiG5fceKvsi/9qerVuo5swr2
         Nkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514193; x=1788118993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OMFICrnM7Mhuv1If98exS7/PIoQ60OrwhK3LwcA+N2k=;
        b=AR6vhlR6MCvtx9nZlw+I7/PW0aRTmgxbkYlks+O0G9wZNOsvm2AU7pqG4wuu8cQDBi
         HfIH+Rr1D8VvhEGt/VYOfxuytTxgxVJtK2xdcxKqyHOtPvtFpolQWSehs6xWd0RxNP1p
         KebglvV1C0lWDv5PropuYye+8eD9dau+XrFfz63ZgdTuVdmKNhrJ+AOTJdFr6Ipd8hUo
         NucWXB44TKYJ1j4yE7GZd9t8BEhSgoszrFuvVF/2sMeb7mGkzx69zWUNeXgQ9B8MScOR
         vvNdsXU/vtnor2HpBOFEtLhUL5lv/511QjwwuT3ylbxFWMI2BJ9q0IUbc4Q2FyjbA6PG
         U6EQ==
X-Gm-Message-State: AFuF++k/OeMX5/MqGUeZ3RyNWhd8+VUZiO/D03q/4g7FQt+s3HepeUaD
	xHXZs6pRxBCSSMSmx/Wq+rG9eww7EjQ0NntlvQFw7LL8oQ3ZHPZiRIkgX5xyPqG0
X-Gm-Gg: AR+sD12FBm2yowQbB2VrGiN/laJ+D5IBLtarHAYCqZ2n1efaRWeZF8MEhvPoAvGaeUo
	G65KOR3d3fk8mk/2DGuliwz9qR38YEdXZyLuYP3qz65PCEsWc/C0UdHFn/4+1n4po//ak5EhqjA
	N+GOqlDIsJjd9rbMCC0PSyxHc118XD/9J/nAk0F0+t7uidjLxe9xDJiP6361BMxCVtpGKMbYXv5
	wkrztGPA2DtTCzZrX7y6w8mttHDXGcXo+qDikMjbkcoD16l63Dc8WgtrtBbfntDCtzZtuF5H5sD
	OpsKAAohbNFK8LJEO2+UjUyTwMOiYiccaTyCGWhASsSu1QaSKOmmnjEFfgX5iWBUbdNWcAUjYDW
	OSymMyS0AWBvdlFuixHXtMTI9hPUosQ0cSC19U1QfXO/8+s1YI27pUUJaSCbDn7RtBgN5SWsqG7
	ULJO6PKKL9EPbFZ9JmZRGPNmldwDXlmbW8uWsD/+WC74l9QbqMHE6Hz2xhEDzu4qf6XcdMKdssE
	0uLGnWEMMQU6Cx0wCZQSIAP0A0gro8e3CB67CmQKWrekiUwrZ46mnY=
X-Received: by 2002:a17:90b:3c50:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-395dec98ad3mr21579126a91.0.1787514192925;
        Sun, 23 Aug 2026 12:43:12 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b2af01sm6839723a91.14.2026.08.23.12.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 12:43:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 7/9] selftests/bpf: extract BPF skeleton generation into a helper script
Date: Sun, 23 Aug 2026 12:42:39 -0700
Message-ID: <20260823194241.3415152-8-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The four skeleton generation recipes (regular, light, signed light and
linked) are near-identical pipelines - link via "bpftool gen
object" three times, compare the second and third results as a
regression test for bpftool's determinism, generate the skeleton (and
possibly subskeleton), remove intermediates - duplicated with small
variations inside DEFINE_TEST_RUNNER_RULES, where every line pays the
double-expansion escaping tax.

Move the pipeline into gen_bpf_skel.sh; the differences between the
four variants become the --lskel, --sign and --subskel flags. Signing
takes the key and certificate from $PRIVATE_KEY and $VERIFICATION_CERT
in the environment, like the bpftool binary comes from $BPFTOOL; the
script checks for both up front, before any intermediate exists. The
distinct linked/llinked intermediate infixes are kept but derived
inside the script (its header says why they matter). The intermediates
are now named after the output header rather than the input object
(foo.linked1.o instead of foo.bpf.linked1.o for the single-object
variants; the linked-skeleton variant already used that form), which
keeps the stems distinct just the same.

The permissive-mode missing-input checks at the top of the recipes -
when the object's compile already failed and was skipped, skip the
skeleton quietly instead of running bpftool against a missing file -
are kept, factored into a skip_if_missing helper.
The build-log messages stay folded behind the guard as in the original
recipes, so a skipped skeleton prints SKIP-SKEL and nothing else. What
does change is the failure path: the script removes the intermediates
it created (the recipes left them behind), the determinism check
reports through cmp plus one message instead of a diff listing, and
the linked-skeleton recipe prints its GEN-SKEL line before the link
rather than after it, like the other three always did.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile        | 93 ++++++++-----------
 tools/testing/selftests/bpf/gen_bpf_skel.sh | 99 +++++++++++++++++++++
 2 files changed, 136 insertions(+), 56 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9f18dd291736..8ac6c8844d4a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -56,6 +56,17 @@ PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
 skip_on_fail = $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
 	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' 1>&2; })
 
+# Permissive-mode recipe prefix: when a prerequisite object is missing
+# (its compile failed and was skipped), remove the target and $(3),
+# emit a SKIP marker and report success without running the rest of
+# the recipe.
+# $(1) - SKIP tag
+# $(2) - input files to check
+# $(3) - optional extra files to remove alongside the target
+skip_if_missing = $(if $(PERMISSIVE),for f in $(2); do [ -f $$f ] || { \
+	$(RM) $@ $(3); \
+	printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)' 1>&2; exit 0; }; done;)
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
@@ -564,7 +575,6 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
 
-LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -624,70 +634,41 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 					  $$($$<-CFLAGS)		\
 					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
 
-$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
-		$$(RM) $$@ $$(@:.skel.h=.subskel.h);			\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-		exit 0;							\
-	fi;)								\
+$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$(Q)$$(call skip_if_missing,SKEL,$$<,$$(@:.skel.h=.subskel.h))	\
 	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
-	$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$< &&		\
-	$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o) && \
-	$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o) && \
-	diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o) &&		\
-	$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@ && \
-	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h)) && \
-	rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
-
-$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
-		$$(RM) $$@;						\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-		exit 0;							\
-	fi;)								\
+	BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh					\
+		--name $$(notdir $$(<:.bpf.o=))					\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h) $$< $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h))
+
+$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$(Q)$$(call skip_if_missing,SKEL,$$<)					\
 	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
-	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
-	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
-	$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $$(call skip_on_fail,SKEL) && \
-	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
-		$$(RM) $$@;						\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-		exit 0;							\
-	fi;)								\
+	BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh					\
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --lskel			\
+		--skel $$@ $$< $$(call skip_on_fail,SKEL)
+
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$(Q)$$(call skip_if_missing,SKEL,$$<)					\
 	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY) (signed)] $$(notdir $$@)' 1>&2; \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
-	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
-	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
-	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
-	$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $$(call skip_on_fail,SKEL) && \
-	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+	BPFTOOL=$$(BPFTOOL) PRIVATE_KEY=$(PRIVATE_KEY)				\
+		VERIFICATION_CERT=$(VERIFICATION_CERT)				\
+		./gen_bpf_skel.sh --sign					\
+		--name $$(notdir $$(<:.bpf.o=_lskel))				\
+		--skel $$@ $$< $$(call skip_on_fail,SKEL)
 
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
+$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$(Q)$$(call skip_if_missing,SKEL,$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)),$$(@:.skel.h=.subskel.h)) \
 	printf '  %-12s %s\n' 'LINK-BPF' '[$(TRUNNER_BINARY)] $$(notdir $$(@:.skel.h=.bpf.o))' 1>&2; \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked1.o) $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) && \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked1.o) && \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked3.o) $$(@:.skel.h=.linked2.o) && \
-	diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o) &&	\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2 && \
-	$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@ && \
-	$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h)) &&									\
-	rm -f $$(@:.skel.h=.linked1.o) $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
+	BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh					\
+		--name $$(notdir $$(@:.skel.h=))				\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h)			\
+		$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h))
 
 # When the compiler generates a %.d file, only skel basenames (not
 # full paths) are specified as prerequisites for corresponding %.o
diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testing/selftests/bpf/gen_bpf_skel.sh
new file mode 100755
index 000000000000..e43ccf095575
--- /dev/null
+++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
@@ -0,0 +1,99 @@
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
+# Intermediate files are named after the output header with a "linked"
+# infix - "llinked" for light or signed skeletons, so generating a
+# .skel.h and a .lskel.h from the same .bpf.o in parallel never races
+# on the intermediates.
+#
+# The bpftool binary is taken from $BPFTOOL (default: bpftool from PATH).
+# On failure all outputs and intermediates are removed and the script
+# exits non-zero; permissive-mode skipping is the caller's business
+# (see skip_on_fail in the Makefile).
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
+if [ "$sign" -eq 1 ] && { [ -z "${PRIVATE_KEY-}" ] || [ -z "${VERIFICATION_CERT-}" ]; }; then
+	echo "$0: --sign requires PRIVATE_KEY and VERIFICATION_CERT in the environment" >&2
+	exit 1
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
+	args+=(-S -k "$PRIVATE_KEY" -i "$VERIFICATION_CERT")
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
-- 
2.43.0

