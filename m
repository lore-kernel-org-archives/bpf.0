Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F69470126
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662904; cv=none; b=g0EyiYrByaWySywmL2LZ+mF92nK8lLWVi6wi9b7XxZ1g7S4MvxSnR2Yfxnc9SD2C5qC9wmV3kGiDSOU/4hAXXC6XJxeGFtnOomZA3iM40dRmhTHmojy3MlTIbGcD6mov+6O5l99k3/ASZW+0vHWZpxqciE6XrvR4CVxVNt4CLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662904; c=relaxed/simple;
	bh=W6zdG6I32xQ76mnzc1gY/v61WpLg7bKpAaUL8uEyva4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTHbErAt93l1U19U8W2lr8jw9+yqSWGfAgoXWFE3XsmWFT8WL3a4EciVjLXlQUP4pAilQZZFGIC6Sb5Vl8rTGI0OPxOi+534WybQLEU/k1DotpkwjX+qRY9QgSUP5fk73QhJLny7FMIWhB1Cw7fJ9U5qaIGKmdW/GkkKFU9BYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joQZ3BNb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joQZ3BNb"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so11918284b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662902; x=1785267702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yT7DY8XJ/aN8v+T2ZP9Ewe2DGZXAgJzTUlkFum8Zjag=;
        b=joQZ3BNbajJDHl/D21nZDS6vOz1RykoarR2DvELHffbLl5tEaWK0CHj1D3xQAaG2zZ
         a/GIudPHL95d0Fn4tumUww+H66A5NxFqEEtdfKkHG51Unx0CJ2DPuwOL1+GZ7DGBJa2s
         Bkmvp5Iz3WjqUUNcSRE7zOBNlaQkGItSc7ZnC7ok+r77pQyMTCsu2A0XkkJuZgxzDRq0
         Xh2AvgkmP+lmqNFqk6x7CHtyufVKFcI+6dx4O3fjBYMJmOt6QlwS009fJqklnLVLq7Vy
         I22Hk1Pumay9V6wlVBLbF/XOMKKOpxou+oKX4S0Y2Ysp3LaTlVkUEipoyPfjjnj1YPkf
         Nr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662902; x=1785267702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yT7DY8XJ/aN8v+T2ZP9Ewe2DGZXAgJzTUlkFum8Zjag=;
        b=TAcFPKHo5FaKew7g+MDK2GR4Whc4PISgy5HKPrIWPWDN70Mne7J4pUj5f9O8FgFyfp
         3MCh3COzi3oCAuMXnD0oTG9Rjwk1SxOT16gD48JUlqOSwXN0GSXUzOld32gS8TW3HsFj
         m6viHO6ODmu9GIwooc6js+fizCrY6cmaTXIODQoYMoBxeEJIRk3WotimuTIgT1Ppe+Mn
         RdNHLG3DnlUuc60dtt83zTsA/rt1A04PtRioD6Au1Fcls/kLyyf80UCDkSHZ0Md88eIx
         grBNSElqb3BNS6lQZnae1PGzb7DhMKdDmos2sLizoS3yuP+gI7SjxfFfusWAgt0wepsS
         UDJw==
X-Gm-Message-State: AOJu0YyPio//QvFAk8YM4bNf+boU04K4jfcXeRWtTXOjzk0PCKTMJYGK
	O9qrIcFpwJhcX2a0NdUn0RUfyM2v4/MDKaJyGZiFOCeJueVvMk9DvBL4iU9JaBl5
X-Gm-Gg: AR+sD10ucuSM3WH5kyULPug3s4GffEOat1T0bAsOL/pH3JfIDvBNFn97uNxxHUI6A0y
	Ffq51zv/W+3PPuk5vKfdMUL8Gz2SBATOUl/kIAXYsyFua/xRCgXKebO/y7EkXEZluBpmlZzM8Zq
	GhUaY18qFmCjZIgm81pR0nZw1oeNdtG090/hvoi2wex6X2FjE6jSt+09b8YuOBFVFP2yQeDB8la
	iZ5ycOTXnMmt2paEd4+ifQKradz5SphH+ottLqHKXPnaqRxZQ/dIz+Y1g3mNWX+BJMwgJn9A8ZK
	stOjx4jGfuUYJRjKPBVe9EHOlZVajxjLInz030kuGfRdvphoc7hiLtQ7wtWG3uZGKVX0+3Duz5t
	9nOWqRyGJ/0ZPmMh+djh7kT42IGXuCap2rUv//S92/zP448UFwTT8C4K1ABLadn1Nh4GnAmjlX/
	bIuQ4v7kLfQqPGNt8bJjJrBXuY
X-Received: by 2002:a05:6a00:408a:b0:84a:2dcb:5aca with SMTP id d2e1a72fcca58-84c2954df26mr20379587b3a.77.1784662902035;
        Tue, 21 Jul 2026 12:41:42 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237761sm214934b3a.4.2026.07.21.12.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:41:41 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 1/3] selftests/bpf: extract BPF skeleton generation into a helper script
Date: Tue, 21 Jul 2026 12:41:09 -0700
Message-ID: <20260721194111.334795-2-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721194111.334795-1-nickolay.lysenko@gmail.com>
References: <20260721194111.334795-1-nickolay.lysenko@gmail.com>
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

Move the pipeline into gen_bpf_skel.sh; the differences between the four
variants become flags (--lskel, --sign, --subskel, --infix). The
distinct linked/llinked intermediate infixes are kept: tests listed in
LSKELS_EXTRA generate both a .skel.h and a .lskel.h from the same
.bpf.o, and distinct intermediate names are what keeps parallel builds
from racing. The determinism check gets an escape hatch
(--no-determinism-check) but remains on by default; behavior is
unchanged.

Generated skeletons are byte-identical to the previous recipes' output.

The script is a prerequisite of every skeleton rule, so editing it
regenerates the headers.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile        | 99 ++++++---------------
 tools/testing/selftests/bpf/gen_bpf_skel.sh | 97 ++++++++++++++++++++
 2 files changed, 125 insertions(+), 71 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 55d394438..09e5be201 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -628,82 +628,39 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
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
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY)'	\
+		--name $$(notdir $$(<:.bpf.o=)) --infix linked			\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h) $$< $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h);				\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
+
+$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY)'	\
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --infix llinked --lskel	\
+		--skel $$@ $$< $(if $(PERMISSIVE),|| {				\
+		$$(RM) $$@;							\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
+
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY) (signed)' \
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --infix llinked		\
+		--sign '$(LSKEL_SIGN)'						\
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
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY)'	\
+		--name $$(notdir $$(@:.skel.h=)) --infix linked			\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h)			\
+		$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h);				\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
 
 # When the compiler generates a %.d file, only skel basenames (not
 # full paths) are specified as prerequisites for corresponding %.o
diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testing/selftests/bpf/gen_bpf_skel.sh
new file mode 100755
index 000000000..0b237f639
--- /dev/null
+++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
@@ -0,0 +1,97 @@
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
+#   --sign 'ARGS'     extra "gen skeleton" args for signing (-S -k .. -i ..)
+#   --tag TAG         build-log tag, e.g. "test_progs-no_alu32"
+#   --infix STR       intermediate file infix (default: linked). Callers
+#                     generating both a .skel.h and a .lskel.h from the
+#                     same .bpf.o MUST use distinct infixes, or parallel
+#                     builds race on the intermediate files.
+#   --no-determinism-check
+#                     link the inputs once instead of three times.
+#                     By default the object is re-linked twice more and
+#                     the 2nd and 3rd results compared, as a regression
+#                     test for the determinism of "bpftool gen object".
+#
+# The bpftool binary is taken from $BPFTOOL (default: bpftool from PATH).
+# On failure all outputs and intermediates are removed and the script
+# exits non-zero; permissive-mode skipping is the caller's business
+# (see skip_on_fail in Makefile.buildvars).
+
+set -u
+
+bpftool=${BPFTOOL:-bpftool}
+name='' skel='' subskel='' tag='' sign_args='' infix=linked
+lskel=0 det_check=1
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--name)		name=$2; shift 2 ;;
+	--skel)		skel=$2; shift 2 ;;
+	--subskel)	subskel=$2; shift 2 ;;
+	--tag)		tag=$2; shift 2 ;;
+	--infix)	infix=$2; shift 2 ;;
+	--sign)		sign_args=$2; shift 2 ;;
+	--lskel)	lskel=1; shift ;;
+	--no-determinism-check) det_check=0; shift ;;
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
+if [ $# -gt 1 ]; then
+	printf '  %-12s %s\n' 'LINK-BPF' "${tag:+[$tag] }$(basename "$base").bpf.o" >&2
+fi
+printf '  %-12s %s\n' 'GEN-SKEL' "${tag:+[$tag] }$(basename "$skel")" >&2
+
+"$bpftool" gen object "$t1" "$@" || fail
+final=$t1
+if [ "$det_check" -eq 1 ]; then
+	"$bpftool" gen object "$t2" "$t1" || fail
+	"$bpftool" gen object "$t3" "$t2" || fail
+	if ! cmp -s "$t2" "$t3"; then
+		echo "$0: bpftool gen object is not deterministic for $skel" >&2
+		fail
+	fi
+	final=$t3
+fi
+
+flags=
+[ "$lskel" -eq 1 ] && flags=-L
+# $sign_args intentionally unquoted: it is a list of bpftool arguments
+# shellcheck disable=SC2086
+"$bpftool" gen skeleton $sign_args $flags "$final" name "$name" > "$skel" || fail
+
+if [ -n "$subskel" ]; then
+	"$bpftool" gen subskeleton "$final" name "$name" > "$subskel" || fail
+fi
+
+rm -f "$t1" "$t2" "$t3"
+exit 0
-- 
2.43.0

