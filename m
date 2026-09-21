Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FFD44E66C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977588; cv=none; b=ZlV8XLlB39+vNzYaGeDQANmXP2IWL1knT8GRKDeBgAl6OMexI3DnZjzxLjm/SL03tzmrOLDT8i9d+BIT110XVeYsW8FQ5Sasrt1jy/VWbFm/9rShVoCvFMbGi/dwvL++ReXivvwMLOOyFU33X1O4nzY6Nzj6f76l2vIf4aNEwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977588; c=relaxed/simple;
	bh=VEjZ7BzXncJNlGo3RlD2aNFOahqTcUuJYVHqJBPd9Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWQ6mA2JEasGCG+1nw/xXIoKp3xi/JfVGMGQZ+KXqVL69wBO9Zu/XMFeYJhqN/jNqF6wHZBstDajVVCDCuwOp8lkOqZnpDaI3JVTU4poW9DBu326QIvcXg+j73VyM3FYXCaqI7CT8n29ofssxngSEc63++l6HwCQgebp+iMxye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQABJvMP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQABJvMP"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398c066106cso2067565a91.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977586; x=1790582386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCkOnhVYtx2sQM61UaTE4IZptt/G6SOtQ9ufb/7g7iw=;
        b=hQABJvMP833eLCW7N6s0409Aouht7PBNhfYTb5WWX39anEkSCpEoIXMcMCRGcZF1Dj
         Ouy/j/oyjx6mNsxESr5pXtfVoa8u+RVIXqV2jIvcnPBujm6D/YZr1Mx7ZPwHyVW9+LXE
         rYTqcGOEQmFGwkgd+ny2yeA+uAM3kgGOfLTkoqGaXpscu66EDISlLAQCG/cEFbbCCLeQ
         hiSzFR40iNIGlbHWtbuPq5o+KbB89QKr6P0CHL6luaSk4PJcJMqLckd1Bz2ZXZvmsWs9
         r+dbOrG2KWwkkQ0/zNR7sxWBuxWySmYg2fBmk0uj+y9TodQu13YGPDB9N0IAdo5LOfwo
         bgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977586; x=1790582386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCkOnhVYtx2sQM61UaTE4IZptt/G6SOtQ9ufb/7g7iw=;
        b=DeHS0ozejnOcQcbUq4irdHRmdwMYJ6ndsjYEUfWB1RsYDJ5x9Y+4mpU7gs01T8RzKS
         I0NeyBQfBGhWFG6+GT+Lu3FwvpR9vlGUYpvCjutooxvcvE0v4Npsyi0KY14+ey1yf56K
         ZLOpJKAo2LzcFDjnGETxjTi2iJNL/tDpf/x0P2DA2QORKnJ8SoDSuz/HqD5C11Pf/e/g
         bcug8eDW6/cjLhTl61X6wSyDz8YeMXFrFUjKkkywt6CzGcRDCYformoTf9rYDt7RN/Ju
         BMint/BPfGQ1/8QFRgBn1W9OLrLXmIKi4cf6W/3vKW8u2qYJGE+PdGvghz8b8a5c2zfi
         qVSA==
X-Gm-Message-State: AFuF++mqo9psmZOvMXHdaokue5Jjxa5CasgufL1pTBG2DL28h0G5yzTk
	rLFJLyKdWtHvQB0eJm38HI1VfuNbTN7yj9vf8sPg4Qm3O7G6sNPwDJy0SSTxv1nNfX0=
X-Gm-Gg: AYBFou10CJNd2oHIyetPlpsjKjgFrkFhTYU7sYXkBmZz/ePyq37Mm+IvXivCveQDY2r
	uLokkoF1QoZlntNPNr1QOVMPkCamdcVb5yX7SDddbTGwU+54ZasG5MRYDEtYhxwq4yDFL3E20v3
	iiBK0CqxE0hbo2Jg/Mf15ojpvqR6OZD7sUxA2sCmGwl4bK1JxISjx3QTGqyozzyc4svOrUkJx5u
	nOsNTZCR3da+j2OdJPGLC/wpakQANzXKmEhF1ijkmlnij/qAkKMcYbT0yd6WE9LLYG51cca8sNt
	esJeKYPibHErtDfInvoLn/magymBxkMwFb6OzJ0u0j2r2GcEv52C+AWaucTcezxxemCpoK8+vUd
	4xDkyJOqv808QAEQIiayBaN5uNznrhpY6VySQlh4FgnW1noiC3nqrwn+lbxyuExO6rnLLjWu1rz
	VL8EOIei562VGM2OXSt4L+Sa7ab3bLqqwMus7McJBkfuK2eDTQn//GsAYuNMiPKrniXevdeUMSp
	G5TojwzGuGEB+koXFz6dMzfAq9axJb1iTr/TwcOtwKpgEjG7QyZ8dtGIt5oNikw2A==
X-Received: by 2002:a17:90b:1c84:b0:39e:6c68:1556 with SMTP id 98e67ed59e1d1-39e6c6832bamr9372741a91.30.1789977586053;
        Mon, 21 Sep 2026 00:59:46 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net (d173-181-19-173.bchsia.telus.net. [173.181.19.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6f1835adsm12843830a91.6.2026.09.21.00.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:59:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 7/9] selftests/bpf: extract BPF skeleton generation into a helper script
Date: Mon, 21 Sep 2026 00:58:53 -0700
Message-ID: <20260921075855.2065871-8-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four skeleton recipes duplicate the link, determinism-check and
header-generation pipeline inside DEFINE_TEST_RUNNER_RULES. Extract it
into gen_bpf_skel.sh, with options for light and signed skeletons.

Intermediate names now derive from the output header, retaining separate
linked/llinked infixes for regular and light skeletons.

Keep the permissive-mode missing-input guards in a skip_if_missing
helper, so a skipped skeleton still prints only SKIP-SKEL. On failure,
the script removes intermediates and both output headers; previously,
strict-mode recipes left intermediates behind and .DELETE_ON_ERROR
covered only the target, not its subskeleton.

The determinism check names the skeleton when it fails, and linked
skeletons log GEN-SKEL before linking.

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
index 99237c3b32d5..a6fd107e357f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -54,6 +54,17 @@ PERMISSIVE := $(filter 0,$(BPF_STRICT_BUILD))
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
@@ -560,7 +571,6 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
 
-LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -620,70 +630,41 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
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
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) $(VERIFICATION_CERT) | $(TRUNNER_OUTPUT)
-	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
-		$$(RM) $$@;						\
-		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-		exit 0;							\
-	fi;)								\
+	BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh					\
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --lskel			\
+		--skel $$@ $$< $$(call skip_on_fail,SKEL)
+
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) $(VERIFICATION_CERT) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
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
index 000000000000..60942f24b094
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
+#   BPFTOOL=<bpftool> gen_bpf_skel.sh --name NAME --skel OUT
+#                      [options] OBJ...
+#
+#   --name NAME       skeleton object name ("name NAME" for bpftool)
+#   --skel OUT        output header ("foo.skel.h" or "foo.lskel.h")
+#   --subskel OUT     also generate a subskeleton header into OUT
+#   --lskel           generate a light skeleton (bpftool gen skeleton -L)
+#   --sign            sign the (light) skeleton, with the key and
+#                     certificate taken from $PRIVATE_KEY and
+#                     $VERIFICATION_CERT
+#
+# The inputs are linked three times and the 2nd and 3rd results compared,
+# as a regression test for the determinism of "bpftool gen object".
+#
+# Intermediate files are named after the output header with a "linked"
+# infix - "llinked" for light or signed skeletons, so that generating a
+# .skel.h and a .lskel.h from the same .bpf.o in parallel never races on
+# the intermediates.
+#
+# The bpftool binary is taken from $BPFTOOL (default: bpftool from PATH).
+# On failure all outputs and intermediates are removed and the script exits
+# non-zero; permissive-mode skipping is the caller's business (see
+# skip_on_fail in the Makefile).
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

