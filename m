Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B046D08C
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656168; cv=none; b=iTJWQnyNUkSSGGWHndEyKdXH2IrZVCAZ91qL4CB6p2DaCgCHVskD/5zutp3nfe7/DqNj4mWIBFshLpNqv06tjjtdXbKoAKd6Avr2ilrqptDf2vxsJAeH+jDNaPRE+6NWGVEjy8KzvivMR/tJi8m4Megxp3sRVubUsbW4KmhCIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656168; c=relaxed/simple;
	bh=XOTCbx/yPYfbMEckdoesTm+VpweJe7ua01CvGtbRwpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT65LBY2XAYxt6/HKB0uNKUiJzCNJZ1Gfg3i6aj1acLkAowhp2uCbXxyQ3F40eZrH+Z60NN1m4/BZWGIs+6Eahg2NwKmPe2+jHWhcIGGAr/DVlvHj4IrOemBCLbSjwkbWyWpQ4B4dAaNuKblb86OYw69bt/WTxgMRdI40vZuV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHHmBO4Q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHHmBO4Q"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848761b5897so6419463b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784656166; x=1785260966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1RkayVA+vcfjy6aTsrdvwVfHdR1nQr/r7C44sBCmz+E=;
        b=hHHmBO4Q5Nmqz5k7BsRN3HFzHq6JmO14nj0wx25SwnCsLVXfdyDygRoopcMgEIYyME
         pfG7lIyrqrZEtrLs3kQJQD2FmEQ7qoVSwgh+2IOBJFiLbpbBfQiKAEUdbNvhydDvfMBx
         Kiml2VIMLmnsbDa6InHQJHUv0gsaE8f2b43QRbLXkFdhiYDZMSRF9Nnlb+AOf+gHPlQf
         L8DlBsoPnA1PFutiJUCYZONLYnw/u0bKG6buqGV6WpeYnWvchR5o7OFaDy2pwySKcPuq
         /iaBifpYCZEWYvCODUIyoNcDhZ0b9RDGk6SQ2JPo2aVh7YMMTiaD6dACRgDUmXYo6N8n
         zTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656166; x=1785260966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1RkayVA+vcfjy6aTsrdvwVfHdR1nQr/r7C44sBCmz+E=;
        b=KopwUO3GAhT908Zg7fwzOL+Kt37so7R4bSGoBWTFVY6vuSoHYdfRtPbLNNVsA4wjGI
         51/+ycOndKxOxZ0sn+fMEu3RVZ7JsKt4zWPy/McjHnsjCO6sNrnHff6qQmfpzu//fUQ7
         C4cjsKBJ6fIhioqh0KYld2/Y30kdy0llPgIGh1/aNsOt36x1THB3qQfgyNVdzsxoEsTv
         8zgBd/Jn6pyl0nmVU99c7sQXQejz4MnmiEeqoLEpxH5sIE0/ha89MRAZRS4OhW9lB3oZ
         cWDASI6NaZGSZY7n2QR2eLgkT7ly6Ud6weDuTWZ4asDrPAcdh/ZkFrSwErkVS9UqIooP
         j41w==
X-Gm-Message-State: AOJu0YwFRNWE9P6YPMgi7jB4+7E/TdOoe5pTU41qGL0AHtG0i34LbOuH
	+TC0m4a2xXvhs1ZM8/mQrZQsFEWTtdUK/I8ilTXKojO7gUt8CTHWbqb1vdAZ67/b
X-Gm-Gg: AR+sD10KN4gDMHHsUlnYetFFMDu9/cq6V8Fs/Ix/y6v90EBRqVUuLk6EwKyDP7iiS54
	5WCThQ/MjNHW3kzwt7gDMA+qDEBpT/nAAr640NzzREmZT9CJ4qj3bXdwX2RG2t9ZuI4jo4jBH/6
	g+I2Zp6EojbK8PFokntXFHjkYnnS37BSOqrZqHiXNmyMr/YCHhOUV6azJgnik/BsPKeOJTn1G6T
	ZABFUnCl1ZBWgcSkmhs1Y4p5XeRCxwYB5HzsroL+SloU8HQESP4xqNt+7pfTZWyeCsF9IM4zkVF
	peyWIxStR8I7lAteeJWr3GhVQWTAP1aSXxXWK2rToQv+CHb1rG5fotdUuY2D+cpPUW1uNNC/CL7
	TDB4LX4c/S9BULuVoBM/ia6/WDzU5DpFaW2LYH9md+Vyhpg8op8CjrVhKA+aXaKcN6GQ8MD9miz
	3hvNB05vmXn7A86vZlF6VPkmZU
X-Received: by 2002:a05:6a00:194d:b0:847:98ff:4af5 with SMTP id d2e1a72fcca58-84c293104e9mr20313589b3a.26.1784656165803;
        Tue, 21 Jul 2026 10:49:25 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172984b0sm85737b3a.27.2026.07.21.10.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:49:25 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 1/3] selftests/bpf: extract BPF skeleton generation into a helper script
Date: Tue, 21 Jul 2026 10:49:07 -0700
Message-ID: <20260721174909.8044-2-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
References: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
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

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Assisted-by: Claude:claude-fable-5 shellcheck
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile        | 87 +++++-------------
 tools/testing/selftests/bpf/gen_bpf_skel.sh | 97 +++++++++++++++++++++
 2 files changed, 119 insertions(+), 65 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489..e3a27403c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -631,81 +631,38 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY)'	\
+		--name $$(notdir $$(<:.bpf.o=)) --infix linked			\
+		--skel $$@ --subskel $$(@:.skel.h=.subskel.h) $$< $(if $(PERMISSIVE),|| { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h);				\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
 
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY)'	\
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --infix llinked --lskel	\
+		--skel $$@ $$< $(if $(PERMISSIVE),|| {				\
+		$$(RM) $$@;							\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
 
 $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
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
+	$(Q)BPFTOOL=$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY) (signed)' \
+		--name $$(notdir $$(<:.bpf.o=_lskel)) --infix llinked		\
+		--sign '$(LSKEL_SIGN)'						\
+		--skel $$@ $$< $(if $(PERMISSIVE),|| {				\
+		$$(RM) $$@;							\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
 
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
 
 # .SECONDEXPANSION here allows to correctly expand %-deps variables as prerequisites
 .SECONDEXPANSION:
 $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL) | $(TRUNNER_OUTPUT)
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

