Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF053A75BC
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751157; cv=none; b=TzTSLO65Se5WE+SGKJ0vemeDLW2o+Ym0HoRDTfdnbS7NdybmbZs63PAMlmHbjeNfi+/6LEOxFOCbSgh/ZuGTJc+JHhSSSFfim2lBhEnzdy/1Y01MrZd17te+ooguA/igbcAY+eFvoOvN7mSqaaRnfD79TSD0UbLpWipM6NjDZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751157; c=relaxed/simple;
	bh=NfaBRDzFvFklhzTH9t4p9EVBdLk/XaHTDMg8o9QY524=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpwG1/ooHyQrDndGY/+oUoxSeA+/mPv3s0O29ds1iPYAj00wSyvc3eWyc8Tu0IhOu4SgdddlUPqAIpcWANBZbgywdyMEMOmBRwksyKVpkzm4b9ebPrGwlMdKawLU4HVkvOCyAmwY8kSvGBVhLkBoLD/t10g1Dyq0nPF9G909fSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecZBH/hJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecZBH/hJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso272005e9.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751153; x=1779355953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4dQGlI0To3jzdG+Zpi+3N86C8iuvnWf5obCtCx/S5c=;
        b=ecZBH/hJkgNSVKPCTs3mdmWAxFhb2nm+bIUu81YF2oo+6gCUbI+PODuz3DDXH8LaXN
         w7zsodEP/LOXMOYpB36om4KlkV3lhWxQRLWdU9GYq1L2BivOYHACtVMCK/Ovpl6fG6Bo
         JfpJNs0/GJM1n21YxXlRuEyAXkv8Jqt7ST4gicMgFiqaTvPeLf91XO62mzQZ/2UyC7Yv
         oNdPrkGDm7AARuTJ6/H1dfzYM2Dk30yDLntoEAW4NZQw2WDdhP9wE9zv1+q8BDTSpIsy
         2BiqnJQ9h1FDJS+fTFawnyZJ1X2efdqgZbqsAc9OEmz7UcPzIBvJcpb7zLPnvjC7u8Tz
         mNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751153; x=1779355953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o4dQGlI0To3jzdG+Zpi+3N86C8iuvnWf5obCtCx/S5c=;
        b=fWys+5Ua6ARLmeSifj4egRSTJklmI6fhEVWSSQBmtOWSnCgzUap4dZyydn0lH8TDsW
         1ZFSfUOJfhndKoNocG+YP1M6PlftaPCr/d0U9Z/m1I1lz6nOVo+AcBxjf/fhBnB5Tjfm
         Q7O9B4uA9dDMykETi64KdJHoasP5c5ln/L82rjqRYqbpOxrQukC4B8Jof5GFNIeYKy+Q
         xW/4rVl4/vqnxy7ciNh+9kFlIAicC6e/lPHwr80kly7Gg69HTd8xKEdWAtGvYb97tTHq
         X9aC3cQSOA3BEsyMqQ5YPnwTfDafoJnAR82QPieFitpQVjo++ICmrxFUb+tP9GHZUh+a
         uDlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K60u62JWQL0jyqrkEERgz/ABcliteq5B2GleC+azJKE3O0X0tTbmJyYlggNMswjnNA14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/WUy+rYCowOSJkFWowxU9seMTp7+vpSfMcqm/E7UnR307UAX
	Zf9mXO2QCo5Xh9OWLZ4mIjE6dvzx3ITKYR5c14iXG45KZEolWAALGzAdXfVrIRXaQWk=
X-Gm-Gg: Acq92OH52lflD8L+TMK6YqiAq1bHexwD0p+t6kaKeqW1aHDqYkmgUvQ7YTAPhraD0Ft
	Ei6crVx0DBeYKafeShA2Ohq8jBB0RZX/xTFuWGZx4LRfTLkD7m5yybptdpufc7usN0ZC3sY+ggu
	FkJ/hmjCljMnyGWn9DYPScTtA4UGTZHag+ZazBhYUBu9wh3IT6RZ9+V/TvOriEunku/2rY/66V3
	ukKgcCbDYbLmc9PBcpUwuNY18ogdlNTbL5MxIHpiOgjmFLoyA4B1A0ZynsqsTNjzH5ROjPe9avO
	Uv35nNeRNaf1A3tFU/zxJzjBp+P14SVSEvhLoGJvM8HvZHOOzDwFTqST2p347VN9c1c3H+4tYB5
	Lgjwaqroz+hGrjGeTHPXOCTP9ude6rVrhfpDKp/qXDp0AhECzACTQfzn2lguG7gvLUovaZXEFwq
	9eaRyXBQCqzagmfJoTK8uBtYTszMzTq1OJ
X-Received: by 2002:a05:600c:a15:b0:48e:89f9:9408 with SMTP id 5b1f17b1804b1-48fc9a3864emr95441075e9.20.1778751153371;
        Thu, 14 May 2026 02:32:33 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:32 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:09 +0100
Subject: [PATCH 2/6] tools/build: Indent if else blocks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-2-6cac1a9a4c8d@linaro.org>
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

These blocks are quite big and unreadable without indentation. Indent
them.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 7022e78208a2..e81e5b479c56 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -52,46 +52,46 @@ define allow-override
 endef
 
 ifneq ($(LLVM),)
-ifneq ($(filter %/,$(LLVM)),)
-LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
-else ifneq ($(LLVM),1)
-$(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
-endif
+  ifneq ($(filter %/,$(LLVM)),)
+    LLVM_PREFIX := $(LLVM)
+  else ifneq ($(filter -%,$(LLVM)),)
+    LLVM_SUFFIX := $(LLVM)
+  else ifneq ($(LLVM),1)
+    $(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
+  endif
 
-$(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
-$(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
-$(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
-$(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
-$(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
-$(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
-$(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
-$(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
-$(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
-$(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
+  $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+  $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+  $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
+  $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+  $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
 else
-# Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
-$(call allow-override,CC,$(CROSS_COMPILE)gcc)
-$(call allow-override,AR,$(CROSS_COMPILE)ar)
-$(call allow-override,LD,$(CROSS_COMPILE)ld)
-$(call allow-override,CXX,$(CROSS_COMPILE)g++)
-$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
-
-# Host versions aren't prefixed
-$(call allow-override,HOSTAR,ar)
-$(call allow-override,HOSTCC,gcc)
-$(call allow-override,HOSTLD,ld)
-
-# Some tools still require Clang, LLC and/or LLVM utils
-$(call allow-override,CLANG,clang)
-$(call allow-override,LLC,llc)
-$(call allow-override,LLVM_CONFIG,llvm-config)
-$(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
-$(call allow-override,LLVM_STRIP,llvm-strip)
+  # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
+  $(call allow-override,CC,$(CROSS_COMPILE)gcc)
+  $(call allow-override,AR,$(CROSS_COMPILE)ar)
+  $(call allow-override,LD,$(CROSS_COMPILE)ld)
+  $(call allow-override,CXX,$(CROSS_COMPILE)g++)
+  $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+
+  # Host versions aren't prefixed
+  $(call allow-override,HOSTAR,ar)
+  $(call allow-override,HOSTCC,gcc)
+  $(call allow-override,HOSTLD,ld)
+
+  # Some tools still require Clang, LLC and/or LLVM utils
+  $(call allow-override,CLANG,clang)
+  $(call allow-override,LLC,llc)
+  $(call allow-override,LLVM_CONFIG,llvm-config)
+  $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
+  $(call allow-override,LLVM_STRIP,llvm-strip)
 endif
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)

-- 
2.34.1

