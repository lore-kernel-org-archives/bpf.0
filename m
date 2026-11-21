Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244335;
	b=B/te5EFUatYmOOIj+OuqPYgWTmcayahNvL4ZhfaOcxO6O9FGmwJBzZmeSJd6I/Xz1K4o
	 igWQyLA9A3x84FprEsz+nYVsbuWCI/VUXcychFjEOxJY6fTUZ7brwRejvD8XshoANUy2A
	 PgldVDIPQsayYkGRJhNmtR3bFv8WyZxPgnKILuovSQECOsmmFUavt4Q7P1YhZYmaoyyCu
	 5LUDxL7rtNLJugcFrXHXoD2qyNYfTSz7NFmmxKNmzK145/l3HicUzTJqFVPbN9KKBg6eJ
	 CavHn5PwRoFNQIGtRHWaMghoBSHzPPZEPbDXph8se+BfvYYRo5WxPpNdwf/+y7m5xAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fuvtSLQkw2xn+flfUo7lSRyM8NUUkLIzaxviYb0ux+A=;
	b=v1HqITfBqPKiU5LbxnCfXrV2VED0hUIrwX8MxV15NcZyQIQog1AgygkGZIkcZxn1TRsK
	 ASsS7VoPqbPTOZWlwuWfabo/Eh3AL+fGYGHE2nqSMF4GA7THKZ+pVPVzAtcgQbthCWNtd
	 Dt5G57yTdn0Xj54T/nk3YPSOmbK0gJHWFSNbLxvmHrPQ62ZbG4DupYAzI2LF+qqRWMccY
	 zPV4GdoXf1WT++gcYAmACYNArkgL0WBZOYEmyXXgyKbGLOr00WEoNerHdpmiod2giQOnA
	 9ysqg4F1qSrt/d+VJRIMizuLunKIXuFohKAC9Z6RhUE4KRzCfztaX5oVt67H6HGCY7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BZv//PUI";
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CC606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 06:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 437CC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BZv//PUI
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3b4208826so1151768a91.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795244335; x=1795849135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuvtSLQkw2xn+flfUo7lSRyM8NUUkLIzaxviYb0ux+A=;
        b=BZv//PUIJSg3whhT4kTrxihWjUbhaUzqTiu9QlMdmaXwnCPb+rp6w1wxXHr8O60Rbf
         VTxSyVTFxZceP8MxcM+LbahNGbo3mr969h7WsOGm827gbdUe93ZiagpnPhHrf14mEsaA
         6ipzoLXgYg+rUMZiwBTUfiQmT3yunyYxIwOE/S6kHhJeRsDWORsU6RiR8nBy/5lbZ3SY
         PlzrMKQfhCNfMLyZHkac4dV7k+QQSAgjT7ksU3p1iWowTKEv/F8GIJoftzJcjVuM/GZG
         gOavYAyTRhOi7yBALy65JoL0hWoVd7PBIum3FI1CyiYH5rvOrNNf9hW2TfH+lVA9KOYV
         VRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244335; x=1795849135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fuvtSLQkw2xn+flfUo7lSRyM8NUUkLIzaxviYb0ux+A=;
        b=SGHt3S89rzkpslW30RGKiUScYgM8spgjEOh2DJQtnLlODqPlTiL2eJZ8ArAWHNrTDo
         jW2ApP6JoK+WGd0B4EmtmqBhTQ/m+RTofA9mEoG8b3sdtOlXap5Rd5r580sT9gME+8Ua
         1QP0Xb5m8Ki1vMzVi6DG2j4YJX4KqDUh3j4MnxjNDeiMF0tlrH24/KQwUHBYnxxc1JQN
         k+3QJgDM4sWQ3msaOwy5TKTK5qbStZ0WksHaSgNID/GIqKiFlPgoIohSAN9ThzbO9FnI
         IZbjSHsTJgxoUlFJDflBPmflFG3wNoCJ6r48ltNkf7XinAj8t+KCzeEfRGBpOD+KLMea
         ou7g==
X-Forwarded-Encrypted: i=1; AL+hErGGvLVeI8KcA3NQkVbsNm6lsMVtOWZJzTbhbRN+lv692bMhV0DFkf6LDX/7PuR3/rDtQXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gvJEpyCBnJMhEjE8g0Kfc06+wnZsuMll/9oede7777g7OyjzT
	UeTOTiJsRwaxupFDi+FIroMcJaClEldkHO36s0VCwCVBDEVpHtPFuGPL3PnsPI87dsZvMlr3NvE
	viHb9uRlt8A==
X-Received: from plgw12.prod.google.com ([2002:a17:902:e88c:b0:2ed:4e53:853d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164d:b0:3b3:a575:846a
 with SMTP id 98e67ed59e1d1-3b40a5de1bcmr4960690a91.22.1795244334321; Fri, 20
 Nov 2026 22:58:54 -0800 (PST)
Date: Fri, 20 Nov 2026 22:57:54 -0800
In-Reply-To: <20261121065813.4143649-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261121065813.4143649-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121065813.4143649-6-irogers@google.com>
Subject: [PATCH v15 05/23] perf build: Enable context analysis and Clang
 thread-safety flags
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Define -DWARN_CONTEXT_ANALYSIS for Clang builds so the context analysis
attributes in linux/compiler-context-analysis.h expand to Clang's
thread-safety attributes rather than no-ops, matching the kernel's
scripts/Makefile.context-analysis.

Also include tools/build/Build.include (updating TMPOUT to place
temporary probe directories under $(OUTPUT) when set) and use cc-option
to enable -Wthread-safety-pointer, -Wthread-safety-beta, and
-fexperimental-late-parse-attributes when supported by Clang.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Build.include  | 4 ++--
 tools/perf/Makefile.config | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/build/Build.include b/tools/build/Build.include
index cd0baa7a168d..cce5e4673ba6 100644
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -113,7 +113,7 @@ rust_flags   = $(filter-out $(RUST_FLAGS_REMOVE_$(obj)), $(rust_flags_2))
 host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
 
 # output directory for tests below
-TMPOUT = .tmp_$$$$
+TMPOUT = $(if $(OUTPUT),$(OUTPUT)/,).tmp_$$$$
 
 # try-run
 # Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
@@ -121,8 +121,8 @@ TMPOUT = .tmp_$$$$
 # automatically cleaned up.
 try-run = $(shell set -e;		\
 	TMP=$(TMPOUT)/tmp;		\
-	mkdir -p $(TMPOUT);		\
 	trap "rm -rf $(TMPOUT)" EXIT;	\
+	mkdir -p $(TMPOUT);		\
 	if ($(1)) >/dev/null 2>&1;	\
 	then echo "$(2)";		\
 	else echo "$(3)";		\
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1cee80c531ab..aed2e952c8f3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -12,6 +12,8 @@ ifneq ($(obj-perf),)
 obj-perf := $(abspath $(obj-perf))/
 endif
 
+include $(srctree)/tools/build/Build.include
+
 $(shell printf "" > $(OUTPUT).config-detected)
 detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
@@ -63,8 +65,11 @@ ifeq ($(CC_NO_CLANG), 0)
     CXX := $(CXX) $(CLANG_FLAGS) -fintegrated-as
   endif
 
-  # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety
+  # Enable context analysis (linux/compiler-context-analysis.h gates its Clang
+  # attributes behind WARN_CONTEXT_ANALYSIS) and Clang thread-safety checks.
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety
+  CFLAGS += $(call cc-option,-Wthread-safety-pointer -Wthread-safety-beta)
+  CFLAGS += $(call cc-option,-fexperimental-late-parse-attributes)
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.1.750.gf70dc682cf-goog

