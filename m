Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCF3E717A
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095063; cv=none; b=tz1D8Oonfos4qJagy0b84irgOODZHEuLnzHwKsNs8KMA3t4h++yP9wfH5NJIftAINJEwu89p8z4fwjO8riEFZ9GoO29zfP+9oAOHtBfVfFORw093CddD8mzbpmE55oCm/KHSdo25Y6+QCwc7AKIJVh/HIquyt15RsCebrwezGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095063; c=relaxed/simple;
	bh=fzYRY6fdwwtc2iRyj9RCOJMDAIdKHmJQQ+6ehPNKfyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVnHNtKpBbbBGNkaX7UP0+E1PY1G7fiV/4LtWrK2tQaZklSkX7XqRYmj0O85IxS9bEzkxJ5jEsv3AY/Dz6Q4+XdDDDbhBCioLI/YtMd7D+uc4aRUAmTGkepDdZ0BE5dfRu8KuOvk3mGzhi6X/gEBzQ52pQTpd8sqrCjzz2m0dR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=knq/CMsC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knq/CMsC"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcd0111ea98so308378866b.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095059; x=1779699859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eZhJfDWaDpr1HIAphXElaRatPY/KQEr+aNnKVotSAw=;
        b=knq/CMsCVaus/TiINPDj02am41TsRjY4ov+VlTNeAPR4IRhRGHEscb1/UFrRXKafyy
         V1KhjM1IEjpjEiqV/wXjRCgTFpzYvaZ0bmYcRJNur0Sxxt/xZ5LBuF2LRqq9HcDuNl5f
         P2QcRTWb5U4qK3faMDXTOBtTsQzIO/k76FXlUwBSLd12jazgWPEnD0ogrP6k2eFBZUWS
         kK4Z3O2L2u8h1qkA0OHB2ylvK7ElQI7Dj9q6NG9wzog1TUFRwFdUGSevc/1nUXR0V7PO
         rkxTItUCS6vlUnmUgD5FbohsC4RMQAtT7llysFBxZLMRcEpPnP/vYnUdKheTI7RXLXul
         BW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095059; x=1779699859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0eZhJfDWaDpr1HIAphXElaRatPY/KQEr+aNnKVotSAw=;
        b=ODU806wNEPuQ0VgmCuRueCHuYKBd88pd8XDJVnTKFaoV9TcZ5U3TLf+0L2S+MhI0BM
         lfT+KdRm52n0yaeQIrziFThSNzd2CeDv5lzMel0xVXavv7e/0yGMjF7jvd/jlIVEcr4h
         Ah/Uw19zXQm+ENmIwU6S3DSsyQdKHLhhk3svZ5TrJvNuOg1X5tw4DgYlTIm9qGVz12NV
         Vt9TRWCnqbDIG81J8DMp5OekBGGx/EooAKJfXt28uZUF8IhzQ2zBz9IjC+hSrEEJyZrI
         4C7i7ncuMt1DEt5putHrCq0+iURwZ8MMvEv7V86PSjo6Yye5tT2mMtIgzZ3Zs2gSjlFI
         RUdQ==
X-Forwarded-Encrypted: i=1; AFNElJ99Ltom97TtqD7N4kkP96Br5OUtLnl5NzOuZun51TJGw8ixgo0/fEcZqnoYIyrycCbNCdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62SsYj0/h4vbnQzScvFWktzRMuy+bok1PdM3h9vtcqA7QWK9p
	EHtWJw8YQj3orok+vBCDAviTKtCo+tt+fg6YeERZgUROvZkFCNmixG1iO0+wp5/pOmY=
X-Gm-Gg: Acq92OE5ZVF/9PpJVFD9xd4ZMfiJixS2lf5YyWLA0c79ZUZrxno2p0tHaPzP5bjE1Ua
	GSci7lY3126om496UCXXEuldBy1HqVmBRrSQGSzWJvFqRG5faMXfFobzeZNVJjkFnJfKAoo5O1g
	TQ4WIC4tJuaygDmic3TcvbeNWL8xVIRoBBwoqBWLBNgHKNIzcRai1g78NWYbafjl6ez/c2Ehf0L
	YJ/YWrM4NAAhTdjoF8ZkFMUb2NzSreSNn/oT5fJKNCEIl/8HIP8jRo7BZ7qtu+Cm29vm7zBsw9+
	2IHL4Eaitwcb5p0vNAV05ui7P9Aodb7MkVl/kyRt+5+lNolSxqGMV7MVjT7GzL0XnLvbGz/zO3+
	xKFteN58sAuVrLhlvn/V+JyjFa0K2/yaReTCMWrP/Wb1oePPq4xgm2/xbNJvB7zy4x/+IXZrLh8
	sVGqjs7aWtDsjx6R38OumDO9E/DHHKMPNN
X-Received: by 2002:a17:907:c248:b0:ba1:1181:b773 with SMTP id a640c23a62f3a-bd5177ee49dmr801041366b.10.1779095058404;
        Mon, 18 May 2026 02:04:18 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:18 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:12 +0100
Subject: [PATCH v2 6/6] tools/build: selftests: Remove some duplicate
 toolchain definitions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-6-f12cc4f031d8@linaro.org>
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
In-Reply-To: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
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
 Yonghong Song <yonghong.song@linux.dev>, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Try to remove some, but not all duplicate toolchain definitions. In
these instances, their makefiles already include
tools/scripts/Makefile.include which defines these in a consistent way.

STRIP is the only one that was set with an '=', but I don't think it
was significant so that difference can be dropped.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/bpf/resolve_btfids/Makefile    | 3 ---
 tools/lib/api/Makefile               | 4 ----
 tools/lib/subcmd/Makefile            | 4 ----
 tools/lib/symbol/Makefile            | 4 ----
 tools/perf/Makefile.perf             | 6 ------
 tools/testing/selftests/bpf/Makefile | 1 -
 6 files changed, 22 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 7672208f65e4..6fdb6302e0a2 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -20,9 +20,6 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
 		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-HOSTAR  ?= ar
 HOSTPKG_CONFIG ?= pkg-config
 CROSS_COMPILE =
 
diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 8665c799e0fa..a228fdb5adba 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-AR ?= $(CROSS_COMPILE)ar
-LD ?= $(CROSS_COMPILE)ld
-
 MAKEFLAGS += --no-print-directory
 
 INSTALL = install
diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 8703ab487b68..9f1ddcf0504d 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-LD ?= $(CROSS_COMPILE)ld
-AR ?= $(CROSS_COMPILE)ar
-
 RM = rm -f
 
 MAKEFLAGS += --no-print-directory
diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index 426b845edfac..d692abe8add6 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-AR ?= $(CROSS_COMPILE)ar
-LD ?= $(CROSS_COMPILE)ld
-
 MAKEFLAGS += --no-print-directory
 
 INSTALL = install
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 63276bf55856..948abfd2ee8d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -174,11 +174,6 @@ endef
 
 LD += $(EXTRA_LDFLAGS)
 
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-HOSTAR  ?= ar
-CLANG   ?= clang
-
 # Some distros provide the command $(CROSS_COMPILE)pkg-config for
 # searching packges installed with Multiarch. Use it for cross
 # compilation if it is existed.
@@ -213,7 +208,6 @@ FIND    = find
 INSTALL = install
 FLEX    ?= flex
 BISON   ?= bison
-STRIP   = strip
 AWK     = awk
 
 # include Makefile.config by default and rule out
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 836e783f0170..f038642b283f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -3,7 +3,6 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-CXX ?= $(CROSS_COMPILE)g++
 OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
 CURDIR := $(abspath .)

-- 
2.34.1

