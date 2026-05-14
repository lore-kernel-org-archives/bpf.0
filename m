Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C63B27DC
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751160; cv=none; b=oB50nwoHpkqrZj4SQ/18chE4xqt3FshXksuq02VpWy5EjkbKVO3C2Fh6/QFNt7XrW3oX6YGvwuO7Nj6mZ85DOz2H+/EC14fBioKdBEYWD+XKVPpRqBAkC3Uq64LevPhKFFcY+CL0HdWRlm6Pn2SbL3ZHrCBTFGlEFYSt7RVIoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751160; c=relaxed/simple;
	bh=XYN2OerTukpjvC5uTpCQ4LBfsGgqw8htnZqoFgokKo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/5cJ7/uZ6leTMjJPqFxxzlPZ8iE7yog2fybWcfIaob0FB6udmvfbm8aaemvYZRNH30osxkS22vD2n653AHJAm2ad5wnJiMUZa01DSnY2szRdKzSJ92vuwQE6ok2l0koLaU1PSGajyaU5PPh+T8N0v1r5f/2jqncqQ3RAP+uGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TunfDMpi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TunfDMpi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe62837baso4071906f8f.3
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751157; x=1779355957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuYOAkPGvNGtocwKIFKK4r5RpQsaxB3pkCmwnF/UVxs=;
        b=TunfDMpismFcIBOkglhgcNR7TWwOnPVhIB6B2/KAXl9VpEvTAQLaWOOQgLGw7DaMTQ
         aOUKxwncz0iBjCJqcU4yV02jwOeC/qPgn9dShDhcv22F+7qw8OH0lRQcrqAtivQnyvVB
         pBnrhyNUDsL98pYWYEQUSd80oy+Ofr4EambuGvPOY32wv4lmfi04gk0G5rXfc4EkZKnA
         HgnBvMyRmYFRqwgB5RQ0255xSqeRfv1wqaPnZlcu9P3Vo7+g71qMvp8Ob3zx/cKJY/mo
         xkMa1fjXxUUOMNkA7rbxCHOAo5TyTYh9/Y0TQk9Ht8dL00Pi+Tqq4j6AwqdRYTCEV9Ad
         Z/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751157; x=1779355957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BuYOAkPGvNGtocwKIFKK4r5RpQsaxB3pkCmwnF/UVxs=;
        b=X+xvaUfKiON4oJdq5Kw4g+jfTi3uz37jimoblulUANVv+ULCuqD1RvfBKQprT1Pvc3
         qQXa7Fym3mmrip6BxePnhNcuHAexwJ8kwiV17rUf0RZsHOWmWUYhkbo906ro7gEVj+N4
         A/3Vs6e6vfxOkG1eM5ncYSAh+eJujV8XW1VEDnFcxbXKwIRYHQRu5yUkUEh5APXsgQSv
         4Q7bEIYXLTpB+MgA96Nit6gPZYFNkPPCJOcLJZiWrA2OToYk4UU6l91II9k1WyC9pQWS
         VUrxc5A6VD1ZJvgdeniHB368Hym1SmZwbuO/7UbnfeY9ws/aA96fuQ/oSPo49K2TnFwt
         h54Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1Igd0/KjwEcXdiMcXD1+M8ngM0tql5rvPRXvqlwVYAASSMAraZp9Rdm046wWwutjxZYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztp3ovJwcUEU0fLICDMKd5tljUaXIBsda5Qi3MsiNBLK4LeDgM
	mDLruymdIq2dkN+gRajK1XYBcaZOWH/Ge0T5IdfAg22jIW98TXk25sirf1i80ZtMyBQ=
X-Gm-Gg: Acq92OHNZ8G8lTuqTwUu5NlRb8Asg16XSxbMANcIXoUZso5uBS4XwabiTRMPVqWc+3c
	UTYDz7d+SBgf1ddr4vrxBGTyl8cFH4QOZhV9ExONcr9p2xYJxdyD4CM95OlztvpOLFv/aS8EA6B
	dcer/sEdTQZGIS7wa5blIKUoeEmm5g08g7oxcZErzDz0z+a7zAbv448GOzk5ZpXiHVp2BWEwo04
	0w7UCXE5DR+luyvxpN/r8xb0hYmS4hHZxCawmdjVDMaqwMwygaHiOD63jpY6LRhgCIke9hVxqIr
	5rtTy6fLNHecgjIZGT092xZ2XZRY76j2Wg+L+D0r21AekaNZz7XEy5QvCgyXSlMw7FiTtlipOsP
	yRjZA+/fkEW1OC6Gh5DG59d6a2hCRYlHL2qj6C/FkK1XGWbAIaRn4pa2LGdl6ebIZMqNg9GwvaC
	taknYY5hl7vCW8XDdokBpW+IR0UTZJllPmbnc/0rPYGrQ=
X-Received: by 2002:a05:6000:2910:b0:452:2834:c690 with SMTP id ffacd0b85a97d-45c554747bbmr10469740f8f.0.1778751156557;
        Thu, 14 May 2026 02:32:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:36 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:11 +0100
Subject: [PATCH 4/6] tools/build: Allow versioning LLVM readelf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-4-6cac1a9a4c8d@linaro.org>
References: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
In-Reply-To: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, leo.yan@arm.com
X-Mailer: b4 0.14.0

Documentation/kbuild/llvm.rst mentions that readelf is included in the
LLVM toolchain, but it's not currently included in this block.

Add it so that LLVM=... options also apply to readelf. Users in tools/
were Perf which was hardcoding it, and another was the BPF makefile.
Both already include Makefile.include so convert them to use the new
variable.

It also didn't have the cross compile prefix, so either readelf didn't
mind opening cross binaries, or it wasn't working for cross builds.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/bpf/Makefile         | 8 ++++----
 tools/perf/Makefile.perf       | 1 -
 tools/scripts/Makefile.include | 2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 168140f8e646..180dca9c57c8 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -114,12 +114,12 @@ PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
 
 TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
 
-GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
+GLOBAL_SYM_COUNT = $(shell $(READELF) -s --wide $(BPF_IN_SHARED) | \
 			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 			   sed 's/\[.*\]//' | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			   sort -u | wc -l)
-VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
+VERSIONED_SYM_COUNT = $(shell $(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
 			      sed 's/\[.*\]//' | \
 			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
@@ -182,12 +182,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
 		     "Please make sure all LIBBPF_API symbols are"	 \
 		     "versioned in $(VERSION_SCRIPT)." >&2;		 \
-		readelf -s --wide $(BPF_IN_SHARED) |			 \
+		$(READELF) -s --wide $(BPF_IN_SHARED) |			 \
 		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
-		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
+		$(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0aba14f22a06..63276bf55856 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -215,7 +215,6 @@ FLEX    ?= flex
 BISON   ?= bison
 STRIP   = strip
 AWK     = awk
-READELF ?= readelf
 
 # include Makefile.config by default and rule out
 # non-config cases
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index e81e5b479c56..380ad84ac51e 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -73,6 +73,7 @@ ifneq ($(LLVM),)
   $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
   $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
   $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
+  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
 else
   # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
   $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -80,6 +81,7 @@ else
   $(call allow-override,LD,$(CROSS_COMPILE)ld)
   $(call allow-override,CXX,$(CROSS_COMPILE)g++)
   $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
 
   # Host versions aren't prefixed
   $(call allow-override,HOSTAR,ar)

-- 
2.34.1

