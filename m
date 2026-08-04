Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B8463B6B
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862968; cv=none; b=La16pdo5FhrbZHM02YeQKTiBRKLNUjjSjSHnfa2N3XP4BHhOiVbOFHsAjXTAnRPOznKVDF6cniTvjfH38EMJJTH5JkW110HEPbOrg3JSOy6v1wkiNdBxIcmjVvgspDV9Xbvt1dtAznnFUHcNKq0QUL+DuIRxeIOvQeKtg/uNSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862968; c=relaxed/simple;
	bh=bJwVYtX6VMG5jg33yA/JnMiVpTntK2ujHbvf8E5yeiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbAgTEUpt1P82f/DHtVYg/Iu1fwRXk4So0EhSB1guUVvGKOgEnm0h9xL9OnlghfcqbaAwxumVadoN67XnBs1JouGUrzK/Rg9RrS0kut/O7l6W0n29JEdDfhbB7gVCCQOr1t/H1hn2GJEmfxTYdiRYLHPOMGl/zYkry4iRO7QqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brwh9kkg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brwh9kkg"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8453427d3f4so62746b3a.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862949; x=1786467749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjXhQ++KYuF73VSHk2EwcfysiBNZpJoA29BX6fP0fQE=;
        b=Brwh9kkg9hnuSpDWmudDLeMzYtMLFv6WQx9IqONL3JX0wjmMNzWbDRc1ayhd+5BPHd
         lKVi6EIT3ZHnUBDAckFzNt/m6rpTra5fm73uDAqFuUtMlT3QHHOg/6U0b4MrXoqd41wi
         pOnTU96IWz3qoOH7QziXZOg7iBSL68OldVs9XcS/fDzAC61m4O9xwWER5m49J3RuQIXB
         eskpxXCImlFML0LFlN4nTNLhJv9SVWMRxr+F2I/YWEyjxUmdYC2LQuDxYSsZ9Ytsh4R4
         CmO343gvlDGFfet6IHvVqJGlTQnQ5xQvr/exJoVzBAhdG3hetkHLGYOp9NjrRG0Ip+2+
         VjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862949; x=1786467749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PjXhQ++KYuF73VSHk2EwcfysiBNZpJoA29BX6fP0fQE=;
        b=bzAkkx7/qfPUX4/ubP78ckwK1dRVSzK/zYBzmM9z5vCoNToC8hC7I1ixSajqWn8qtQ
         WvcVwisvw5XKFNSJy9hx6zqrnzWrVDaUrQKq0FiRIuIPn6VkitVah/1mp4o5GAwyKaJs
         heJm8btNPFsM5/t/e8qVfFqvG7LV2z2YxGwk59TSYnV9Nmwd5hSC38AaQsIzju+1Z8by
         9swtsZe50tzD7bDxnES/mzbDkJzEF/MXiytnHk2605ArcgtpoCaZ/x2yYL1pWv+qDXSg
         rMSnyAKGFIjn8pNcBhQXUNdi8bE9hcLp9imyOjqIQVw2l2YYpZ+eeDPQgeSvaiCD7DJl
         cN/Q==
X-Gm-Message-State: AOJu0YzGg86RXs9YWXZbKp2fZWRTHFywzNFtfukWBDC8Obxt1ANtVUt/
	b9F8Az3O0lV6ysp3uxcXq2FEQw0WD49dXhMNJLIneBzRKYaRBHrX6NE2GDOBOcQ/Mws=
X-Gm-Gg: AR+sD11vEjWUU0HjfuNtcwM7i3tUHedu+54OsRsW1u1LkwiiiYc0X6k22A5zaCc8V5L
	kTZauDN1AEW/6ZVQ0hGStfHoyfPK5cspMt7JhPRt4AdEao3//Jeq/kbWMrBHQosohM9Ybc6Zpgc
	3DEbVx/KrQ/Qy0VXkm35+1eixvwebjH9atzkCbSkaAEtUAcJ5Dp3ZUDTsPYhNLiFLid1ujzdKOh
	sHU0Zu3fuTz17k+70O815qLYquJu1q1eCPvL2dYTJ5S9rJSZaemWEsXhLiN3Zw8j+fJlhB1hADA
	KqQVuQhiC++RUXBC6N6fxrAuzJ16ahEJqYN+xcospvL2E4zJ3CZk7nE3ieFLGnkPyC+JaNLk1R6
	YyOzK+cWVcScixytzKLaiouJhYAg9s8ZAL3JYtNEARxPlGhM73AxBEG/cuIeKPGswGFFNOKbCmD
	USHNQtxBlu1ZZDmG6/rZPbzuis0ufd7Cqwe06Z141vVSnGtj3leYNy+XY74O94EK+/8rNxeFnWX
	THThlR8jU8=
X-Received: by 2002:a05:6a00:4488:b0:848:56ff:6ce4 with SMTP id d2e1a72fcca58-84f2dfc533fmr369240b3a.5.1785862949252;
        Tue, 04 Aug 2026 10:02:29 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3926sm55508b3a.28.2026.08.04.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:02:28 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v5 6/8] selftests/bpf: extract BPF skeleton generation into a helper script
Date: Tue,  4 Aug 2026 10:01:54 -0700
Message-ID: <20260804170156.1709916-7-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
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

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile        | 87 ++++++-------------
 tools/testing/selftests/bpf/gen_bpf_skel.sh | 93 +++++++++++++++++++++
 2 files changed, 119 insertions(+), 61 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0ee02eeac..dbde2f6bd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -576,8 +576,6 @@ HEADERS_FOR_BPF_OBJS := $(wildcard $(BPFDIR)/*.bpf.h)		\
 # $1 - test runner base binary name (e.g., test_progs)
 # $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER
-
-LSKEL_SIGN := -S -k $(PRIVATE_KEY) -i $(VERIFICATION_CERT)
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
@@ -637,70 +635,37 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
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
-	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h)) && \
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
-	$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $$(call skip_on_fail,SKEL) && \
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
-	$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ $$(call skip_on_fail,SKEL) && \
-	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
+		--name $$(notdir $$(<:.bpf.o=))					\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h) $$< $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h))
+
+$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --lskel			\
+		--skel $$@ $$< $$(call skip_on_fail,SKEL)
+
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) PRIVATE_KEY=$(PRIVATE_KEY)			\
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
-	printf '  %-12s %s\n' 'LINK-BPF' '[$(TRUNNER_BINARY)] $$(notdir $$(@:.skel.h=.bpf.o))' 1>&2; \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked1.o) $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) && \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked1.o) && \
-	$$(BPFTOOL) gen object $$(@:.skel.h=.linked3.o) $$(@:.skel.h=.linked2.o) && \
-	diff $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o) &&	\
-	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2 && \
-	$$(BPFTOOL) gen skeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$@ && \
-	$$(BPFTOOL) gen subskeleton $$(@:.skel.h=.linked3.o) name $$(notdir $$(@:.skel.h=)) > $$(@:.skel.h=.subskel.h) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h)) &&									\
-	rm -f $$(@:.skel.h=.linked1.o) $$(@:.skel.h=.linked2.o) $$(@:.skel.h=.linked3.o)
+$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
+	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.bpf.o))
+	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh				\
+		--name $$(notdir $$(@:.skel.h=))				\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h)			\
+		$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $$(call skip_on_fail,SKEL,$$(@:.skel.h=.subskel.h))
 
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
-- 
2.43.0

