Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD337AA77
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787447386; cv=none; b=VeEo2LnXAOesOMGv53hOdUSdDGyQZwyUO94rWME1L/m2Ab8G+55IhXyNf6jmlXZWWIEyxQawETgtXTWSFls87n9X9G0Ey7O+mec4NmyV9nDEsLJQMzOAIZtZpac0a5YVVGe+0/IxFu4F0UGCT1ArFP8dbBT8ydJRtknqG+3LAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787447386; c=relaxed/simple;
	bh=aVGR2QrAhPGXv30oNMrPckeggwC9Q/EVuBnGOLJGRa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4t6HaFMYGGNmrOV966zQtWLOWBypEqLt+fnQU7+ikOdtFrUXvKoxo/TVU8LHTThdthDElJN4g5t9PpYznynoFtWtbPT3f5L/DXGDTyl1uvMsOJ8W0HVTqiWHNok2pLKW+9/ib8nBMmkSwpSk7nTm/nfYprqS56i7eKl/Zr+ets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r60be4BL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r60be4BL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3038200a91.2
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787447376; x=1788052176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LAKZVGZ/bhrcrymSX9W+fOKfpVkNBa8EQ7tAz7Nks74=;
        b=r60be4BLPY+0r5DRlh70KH4sJD/IlzkckN0C6GA9mEEIwo4kloUvBFb7LfuUPKvJ23
         o+Dfn/AcJYNW0i+scPiQq2QZkiBGc1J+Fug3ZPF6dcyWMsGUrvff2sb5A3+HVYuWKFhw
         6cWr9dhghNdaJ9gBi78yZao2IvoihPR0OeogeZE/P20WsbnVqSzKZJG5v0IrfInn3FwF
         3N93kL3MCSNKf8wcnT4koUkF0k/Ycw04TfFJIb+Z6IFILQ9DRaCjiuJRcvA9RKmU4fME
         5uaOvVp/WsGCR+Jj1E4bYExVqH7d8mnLNQUb47SgWWvmpJGXCKMxuurAJWLQ4DLapjTj
         6EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787447376; x=1788052176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LAKZVGZ/bhrcrymSX9W+fOKfpVkNBa8EQ7tAz7Nks74=;
        b=QY7/AeQUQ17paMNvZ84fQNOZmgom/caeHsVS1YEOSLP4oUNDplQ/TqSdEuIOrr5hhB
         LGK2tmBFzK2YCDACOZdayBK4yDk8bVd2OM4u9LPUhMqk8RUZlh4OirLwXM1cdTziDtol
         WSiG6ObI87SnNz4sUmDrFVwiyB2ISvH+2t9CJL42y+yxd3S6zyebxEgt1GqIzi8yyqqU
         TrXvUrbdk/AGc9wTSFuxyxYehONa8P4qQAezZuouJGp/LHsJ4fBoCjz6qscigbNkpRm1
         FL7CUY4jjBbKWVy2XQEEIf2qeW+iNrWPL+7x5HCqaa+i1HLP7WjsejiMHnYafg1nnlTh
         1eJw==
X-Gm-Message-State: AFuF++l7+UlIJDf9fLGz7HFgde98Qspj7z3EtJUkjX3P+o2KgW5P7fXm
	yLSORtujtuSWpzHOiYatkfpg1pmpCY90/tZSH72OMfCkPVni75i7xfbCatWcdxOj
X-Gm-Gg: AR+sD125tFG7+9Ls43vkraN/cUQn6/jpE7nOHhIvx8MRyAcXR7qSq70mbzHoPd4nODD
	7TxmUNaQZm/7+bve6rsgpactH3jUe0PzBR3pzAn4zAWgoloUtkb+rSUXLEeOnxkevZm69ZUQ7CI
	U8E9+Eg6SGqEeQM/AKkN0btOokgLKMZ9SbDZNn6r7JQG607+xunysq036vKo3QXr0/lxGj164j5
	NWMLpCB8MKBLVfVkEOHlLyulU9KtavdqFoPr4xsgdNrg+4kV7kYKltykBqbqzxzA3hygMf3D1la
	d/lhJBW4KDY0Bjl6OTsaWMEztkbETkwgRjEcQuSM6uq1529urLJePuVfHUhVImup9KleDUD6pRu
	Z28OJPRJ2Rlr4ioVOb859Ac5UJ6mdTIP3zErKXujvtAFeg4WbewF/xkQnnNbe7XNw44hvi7sfB9
	56uwTVNjQPFwJEhr2JNzsd9lVvTyzyCETjtANhKLGxMcwZMcALuqdidK5vKhcMuo+TCTnav5pMY
	f4gR9a9eP3iQGwSR5TF1ivuxenzti+CGtKaTCOkCHuOSgTQ/ZRBeck=
X-Received: by 2002:a17:90b:3c84:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-395c3542369mr32271675a91.4.1787447375985;
        Sat, 22 Aug 2026 18:09:35 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b240e7sm4219994a91.13.2026.08.22.18.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 18:09:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 7/9] selftests/bpf: extract BPF skeleton generation into a helper script
Date: Sat, 22 Aug 2026 18:08:58 -0700
Message-ID: <20260823010900.1730708-8-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
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
names are what keeps parallel builds from racing.

The permissive-mode missing-input checks at the top of the recipes -
when the object's compile already failed and was skipped, skip the
skeleton quietly instead of running bpftool against a missing file -
are kept, factored into a skip_if_missing helper next to skip_on_fail.
The build-log messages stay folded behind the guard as in the original
recipes, so a skipped skeleton prints SKIP-SKEL and nothing else;
behavior is unchanged.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile        | 94 ++++++++-------------
 tools/testing/selftests/bpf/gen_bpf_skel.sh | 93 ++++++++++++++++++++
 2 files changed, 130 insertions(+), 57 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fdedfab25d72..57907859c210 100644
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
@@ -565,8 +576,6 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $1 - test runner base binary name (e.g., test_progs)
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
-
-LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -626,70 +635,41 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
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
index 000000000000..a752cb78c139
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
-- 
2.43.0

