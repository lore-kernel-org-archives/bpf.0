Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0327B39F165
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127267; cv=none; b=iuSUEZdKojkcnKq56EGfLGlA165KCtUjc/gYVy/Uyi/Kr7J0g/qRxM6JHGnYMmEBeeQ/w2oLZe8dgIHmSKF2147jqKhmmVpZ8A4h6GrfndrzOpdP/8XVB533JI9AF5MEgzaOHG7rs2kuB+IlWDIqAvktR77RkcrTIcezA4NPsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127267; c=relaxed/simple;
	bh=YmoPzivoUVC4z+GD4C9dgp0VaLkJZwU+d/4+hGh3yNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCqR01JI7kCLKMrRYByCS+B5PCymmDAMPDSpaw451vSRXeAvdQwT/tQAK62Mct5th3jhFauNV+/Az76W7uedGNZfYdCg1EvjTBpOJJp7aMejx6mvxpanXgZ2C9UQf/CRPIT8Lb2JhwQsIRDsiTfPAH2mhbUt6WG+xnqJQjqYTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=baUP3uS8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baUP3uS8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4953ddae026so5131535e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784127263; x=1784732063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3q/mBxAob+M0XblmpPoJEXspUdOZwJaSDjVW/DAN13M=;
        b=baUP3uS8aGXTxlhxy4X5mPcBSDrzfiWlr/RIKQBnB5+TPXlkLUuuXKf/hdVUDVar32
         G/vLMlRi+1PqkPBbwBgIEBLj6+0dlWasEcUEX66y48hSlx1JwuFfkUwi2OzhLlR0jDSN
         By2BxrG8iaj6n20MDaH2MBEc3oRz/h4rBE6q4UtIswxJnq2kEDidlx1gz/4L1lCXRieO
         BuLxcHQkiTbjXdDPyZfv9dCZbwGnhoFrK9HbgvoN+iOV2Ohx7R7jCARYr2gscQBt0Eyz
         6jpT2egRbVSb8RnayvX9iO9VaZ6eFXkByZLuFS3UGhvMxpturw1q2mdDgGR1v/AYSd+s
         YHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784127263; x=1784732063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3q/mBxAob+M0XblmpPoJEXspUdOZwJaSDjVW/DAN13M=;
        b=G4pwJvJeElPczeEBGrPCB/PiuUkVqYhUSXlHsBXxhPx8L6j0MEeNFyHxxyLSpa7DvZ
         mpE7/tadLR1ikb4ZQ5hKtjqpcOrQD354x/pu1xnl53d5He7rRy6iSqV0ps0FAxNZui/E
         ctK8a0g6aZdZJ6D7iOJhjSNDfsT6A0L82kqQjW5+gM/+mV3nNnE7JTOyWocELtHPQ47b
         7SOsbBfJ70uECNAsXrUDj7NDbSHQGRpMaxfEn2k3DHu5rMHLBqIMa9Sa0HA0mLtsPZL5
         Nk/HeKRDUvFaLcIL2/bZGV0vCpoYEVy354pHUEaC0Sm3KK/fwm3TCkjWEG6EdkgDckQf
         CfKg==
X-Forwarded-Encrypted: i=1; AHgh+RrBwYAG+EocwQD2iPjVstNBG+sVt59+HonoLBw/9+hvAnAdsms59PORL915/ml1O6Go8pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GyaVrJvlbng6aagR8yGZwlm5yDd/kUx8kKtpBomdzp+m1J55
	WIpAafj76JMIAtvdnjBW5rzzH5GHWfIQYE9/qXL1tQCoD0gb6oIU3w3VavLN/wJs6BY=
X-Gm-Gg: AfdE7clDQT6UXw/DwzwFwYMaHgE8vkVXjxS1IcEfiYIFoE0IN5+kTKdVu8bQhSifcTQ
	H/kBFAcW3HvyuXaNUxOMPl3dPDouP8jbYswlssjxBZJHm46Qt2HLebLUL9zarsas1iKDBDWrSJX
	LYaBgT+759OyFQ+rI9/jQIQvvrTVJVbh1sxF6nT2fR5GXGZPTacJwCHi6mGSZaQMNh2TdMPtTne
	3+Hpjrw6lRhI/DKY5HkeMlQYbGVMfTnUO1e+Wy0Rnhy6YRlfLuLxQgf59KKSU4iDXLGSUf/0mva
	YyFFZQz/+0QleRCdJ2P5o3EnbHrDJZSQSCbiStyK1NjaVpPkOyGziAwEA++FEkzukYMWzl1JK2z
	06DLBEgwt4UISxOk8wX8i7k+nmJkfD5fX6cd0KX2xklFoO6pfO08tf6jIhQkV8fTK+FQopYuxj+
	0oX4/5YzCU9R4L7g/o/h54IA==
X-Received: by 2002:a05:600c:4f8a:b0:493:e947:b24a with SMTP id 5b1f17b1804b1-493f87e72a8mr183785635e9.14.1784127262701;
        Wed, 15 Jul 2026 07:54:22 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49510c8e220sm137649275e9.15.2026.07.15.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:54:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 15:53:51 +0100
Subject: [PATCH v4 4/4] tools/build: selftests: Remove some duplicate
 toolchain definitions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v4-4-6dfdf984b435@linaro.org>
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
index 7672208f65e4bc245c03603634d3aa0093a91096..6fdb6302e0a28e9166175822f42cfbb4f4eb24e5 100644
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
index 8665c799e0fa7155016e8bc6968ebe76a90e1d13..a228fdb5adba8d7f8282688964a9751a06cb0c79 100644
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
index 8703ab487b68c89406fed575217b57f58e71fb01..9f1ddcf0504d993249991e0af4589db1072465d1 100644
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
index 426b845edfaccf56f7c246c281a549c18d0f3919..d692abe8add6e243d7b024fe556cc0983eb4b443 100644
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
index 4d0d7ae02e06b117487a17691c4e62a138428ac5..ca67d4b6fc38367c63123332360ccf27102fc086 100644
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
index b642ee489ea64046a9b19852780c3a6f009cbd82..a1a4ae76365955f8f7c1193a03e74bef0d344f9c 100644
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

