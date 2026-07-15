Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148C39CCF3
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127266; cv=none; b=iZuDk6RMJsq1P4zrMduuYwXecrnBFa76N6MhLEazXbjUYNC6Jtvas/dAred6GqPjFKFxPBZbKLAgP0ybA1TE3Mds+6kAFEsRMth7DKaRo1HXLZ4CJwKOtuA7Q+19ZqOZvi9U0fAHAsxMkTRcpfHKE5+/byYZkXsAZTCf6jOkySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127266; c=relaxed/simple;
	bh=ZkYJs35jQmspYZV+7P7rdW/XJsOQuNs1+0xfbRaBumg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVglDCHPnQxyR4caBR3ZDh+++2Lj2prG1YB+om1PSyhrkPk7YzB/yK2PTvOZP1qnaohz5HHKwm6g8zEof7FtJEAc4Zumhr3/VIY8NqCKGHu/8RV9c2nSXKw9mB0R4JRAU2LaSEq8D1cLDoHPIUGUEaX9tsiqh5uxHORhVw0vkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9I+eCnr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9I+eCnr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f60208a5so47161955e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784127261; x=1784732061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYLoZSOwmX0k8MESmwiGJgNO1yzq3b1PVclurYMHFiw=;
        b=w9I+eCnr9TIpzu7GbUYL3zpPPIU6S0jloT5X6VGAEDiz/7On9oUBC23OrWcWvwJ3Fy
         XXhPEmRuAu3TMYM8U2QxRjA4rolyrFrxVozlWwpikuqabKxeg0js85iTK/h7nEf5IRgd
         LcnzjFcNHDDCslPC90GT19wToUdJDkJHj3s1rSsyofjcMLccC/pa3ga+ys+OPCU72DuS
         Cja0PTk2CeXJg/G8pS/IvOLQ+dsngjm2wUO6UFSBKOJwN/KQA33pxuLDIF9+6vHZYueg
         L5G9Rw4rpjuITSIDatvLu8wO4rwsQsGThqrdPO8P5WGw8DUDGMlz1+wruJOHQjDDvGgT
         HbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784127261; x=1784732061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYLoZSOwmX0k8MESmwiGJgNO1yzq3b1PVclurYMHFiw=;
        b=L6CwJEY2FMnDIQJyuMR0fPgtHYaA1IOb88/qQWPQzBuVkz0SBbfv5f93HyRZU0o1mK
         a+vmf+gMEAgko10xCsbCN93VoC7r9PmpmHbgucJgM3S70VnS4GxULMoo5XbzKTtw8c/G
         Gw+mJR60lZo1lnQAxSPXbRg7vEIZBAIXhP4IFXfX7xCy12viCjCQQpvxxBGNu59eNsqT
         pW9QUsV5gBFBpr7YnZEf9HliBvmC37o8eowruC8AGalG8QxZ4VRiuoGzxf6W4ezVvq7b
         DIqfPszOdiTtA3pHtNsNfCOfLx01l10qivGuEKfjs5AIZa7m2QiIT56QWir+fsC476Mh
         kKaQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwlicxnI5+8X1gL/JVQJcXJrmT3WwsqVnEN9UVi3ADLn11sPuUGHaG6icwt2dr5paplrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIoc97bpKL7tMLEQs0n73t9Clbp18Ui+QX0fy2pxDu6hnHphM
	tRFxnIhSpMqyoqGMpT98y2aT9rbnzNtBPaVpmb3GINNWBGmVquHCGIyYm81fJ9EhuDg=
X-Gm-Gg: AfdE7cnvm3Zs4wvXj9NQtM6eSvPeELZIurRX871/Z6pFcQbnrBESuJr3qQuu+0Mr1+r
	AR4PuVKMW0X/lClqnWgCrRX46hYIliFGZkNhPKTkNWnR1tjVj44MwX6u+feF0Wd/Vydm6Ow9MQC
	MdDBv0bVB9oP+e45+nWu1DAt6SpP/Ua9LzcIYRXIr4IgIiZuk3ETh5G6M9/GZ13EjWs5o06yL67
	JZlFh3nkvpMp57x+dIP7HLyC8AWDv5zT7gtpQNq66qDs5o3BJHQtuoZkexpsIIXM2pGzkMVk8DI
	QBXN+/QbumMv5NgXj7xNAxMO8/I5zA3HyQo3kvdyj2KadVkB4xu7PtB/zkvHQyNjRvnRW6cz0RD
	ZVf/Bg5kR9w6N4KcbFAkFJD3GWWR7BsogwvyALjVilmRn1OwrWX0LxS1wnpCsIGZi1ggCMktn8s
	MymS8PUHpNduVIxeoApq99kg==
X-Received: by 2002:a7b:c38e:0:b0:495:406c:81d5 with SMTP id 5b1f17b1804b1-495406c81ffmr2450405e9.28.1784127261341;
        Wed, 15 Jul 2026 07:54:21 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49510c8e220sm137649275e9.15.2026.07.15.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:54:20 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 15:53:50 +0100
Subject: [PATCH v4 3/4] tools/build: Allow versioning LLVM readelf
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v4-3-6dfdf984b435@linaro.org>
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
In-Reply-To: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

Documentation/kbuild/llvm.rst mentions that readelf is included in the
LLVM toolchain, but it's not currently included in this block.

Add it so that LLVM=... options also apply to readelf. Users in tools/
were Perf which was hardcoding it, and another was the BPF makefile.
Both already include Makefile.include so convert them to use the new
variables.

Where readelf wasn't doing anything arch specific, use HOSTREADELF
because it's more likely to be installed.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/bpf/Makefile         | 8 ++++----
 tools/perf/Makefile.perf       | 1 -
 tools/scripts/Makefile.include | 4 ++++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index eca584fb061e16013e76827e4203f6be0477a73e..269fe21fc8da73083367b3c122bdd2b718e12bc5 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -115,12 +115,12 @@ PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
 
 TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
 
-GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
+GLOBAL_SYM_COUNT = $(shell $(HOSTREADELF) -s --wide $(BPF_IN_SHARED) | \
 			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 			   sed 's/\[.*\]//' | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			   sort -u | wc -l)
-VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
+VERSIONED_SYM_COUNT = $(shell $(HOSTREADELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
 			      sed 's/\[.*\]//' | \
 			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
@@ -183,12 +183,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
 		     "Please make sure all LIBBPF_API symbols are"	 \
 		     "versioned in $(VERSION_SCRIPT)." >&2;		 \
-		readelf -s --wide $(BPF_IN_SHARED) |			 \
+		$(HOSTREADELF) -s --wide $(BPF_IN_SHARED) |		 \
 		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
-		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
+		$(HOSTREADELF) --dyn-syms --wide $(OUTPUT)libbpf.so |	 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 476b8dcaef58cb1f3fa75f46a647c2cfe2352767..4d0d7ae02e06b117487a17691c4e62a138428ac5 100644
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
index e81e5b479c563321e458b2a7ad8fca2b4607a254..46a3872b87624a7bf475d9b42a3e471f36789dfd 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -73,6 +73,8 @@ ifneq ($(LLVM),)
   $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
   $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
   $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
+  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
+  $(call allow-override,HOSTREADELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
 else
   # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
   $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -80,11 +82,13 @@ else
   $(call allow-override,LD,$(CROSS_COMPILE)ld)
   $(call allow-override,CXX,$(CROSS_COMPILE)g++)
   $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
 
   # Host versions aren't prefixed
   $(call allow-override,HOSTAR,ar)
   $(call allow-override,HOSTCC,gcc)
   $(call allow-override,HOSTLD,ld)
+  $(call allow-override,HOSTREADELF,readelf)
 
   # Some tools still require Clang, LLC and/or LLVM utils
   $(call allow-override,CLANG,clang)

-- 
2.34.1

