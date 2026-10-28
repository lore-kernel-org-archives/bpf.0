Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220139;
	b=JppEmIQYk7Nnp3oct9LQyckpxFQ+llrG9eBeR+YysFC0oMoqmdR6ubwOKfY0Ty5gyf/G
	 g2312zBlqZ52s8GmJcHySX82D8zw3ccqqJsaO8a7ZVHDSjUN+lAY2BNBkrV7so1ckqdyd
	 4zOZiu/rQzFu6hmvtaL5KdTR0X8hmvHT+pNmLIt6v1JJMqHxcLDbKVEs7ql72mijM/IHv
	 wMb65L2Gyj5LJcPiF8iRbBC3DW1ZWvvxoQOj+l5RG3shqRixngwRtC00Hp+8441zB6x2G
	 xPSoJpAjlbhx6+GLJ/WKJPesPNDcyRq6q+7pyzDW5Y7RRfWHOs05/amQLxzKUVEdb+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220139;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e2Gu+WtYg+b+BufeEKwovfJrZnzsq5njm/Oj2WFts14=;
	b=bnq2QzLeVsTc17tAzq0g8Zo/NdBzgFj+D8b4QNHNEiHztuDTrABVAwibkcsbSUTP1/+L
	 spYpb6vrJ2f9ejBELIuSX+B9gB5/e64lTBhvqNcgNci+XGGt0QvreD4QBSo2a+/iFlXz0
	 8hfP8m//2VEgL7X+b2KF43wFt50KHsl7XOXFli9DUg2C+MeCfdU3G4ttKUokDpgTH7Fag
	 VulKQ6TjEK3eAXMyDqD736PSH+LolWP6zLiKyVN/dDhlppf9j20EpRwS5gqEIT9UKjzbD
	 o1nbnaSk6FCERDHTu3gHCnU2oByJk1gGmmO+jJ0TsyBVXHs5smA1uRKlx+sUvCFhvyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nm7WN0I2;
	arc=none smtp.remote-ip=91.218.175.210
Received: from mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4C606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 20:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nm7WN0I2
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HvXm1nkfB3D6+zLr/zpDnWhSj8kJjYR8mhYehTdnkX0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793220136; v=1; x=1793824936;
 b=nm7WN0I2Vjv+jJ/ItLnU8ZQeSbO0Qf2FDBlL2e4WmJRmusp89b/81rEe3CYAGdYjUIkq1H4t
 SvpleiiMn6kJPsB7YWqiTnSahbweusLHTVFEEQR7YUZTb+nYoC14rntryhMJ/Rt91QbM8hmS9Zs
 xgjf+QL0ECjETUwYqLgRKLjA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 502aaee1b83b8e53;
	Wed, 28 Oct 2026 20:42:16 +0000
X-Mizu-Trace-ID: 502aaee1b83b8e53
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 2/8] selftests/bpf: don't pass clang-only warning flags to GCC
Date: Wed, 28 Oct 2026 13:41:52 -0700
Message-ID: <20261028204158.1021284-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028204158.1021284-1-vineet.gupta@linux.dev>
References: <20261028204158.1021284-1-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clang only togges are passed to every BPF object build, including
for BPF_GCC build.

GCC accepts an unknown -Wno-foo silently until some other diagnostic fires,
and then appends a note to it, so every warning in a bpf_gcc build comes with
two lines of noise:

  cc1: note: unrecognized command-line option '-Wno-initializer-overrides' may have been intended to silence earlier diagnostics
  cc1: note: unrecognized command-line option '-Wno-microsoft-anon-tag' may have been intended to silence earlier diagnostics

Collect them in CLANG_BPF_CFLAGS and hand them only to the clang
flavors, through the per-flavor BPF_CC_FLAGS that Makefile.skel appends
after BPF_CFLAGS.

Only these two are clang-only; -Wno-compare-distinct-pointer-types and
-fms-extensions are understood by GCC 14 and later and stay in
BPF_CFLAGS.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tools/testing/selftests/bpf/Makefile           | 8 ++++----
 tools/testing/selftests/bpf/Makefile.buildvars | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1e4af62e8312..b5303c28973e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -376,7 +376,7 @@ CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) $(CLANG_BPF_CFLAGS)
 
 # genkey writes both outputs. Pattern rules group them even on make
 # versions before 4.3, preventing concurrent genkey invocations.
@@ -521,7 +521,7 @@ BINARY := test_progs
 BPF_CC := $(CLANG)
 BPF_CC_MSG := CLNG-BPF
 BPF_SYS_INCLUDES := $(CLANG_SYS_INCLUDES)
-BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3
+BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3 $(CLANG_BPF_CFLAGS)
 BPF_DEFINES := -DENABLE_ATOMICS_TESTS
 include Makefile.skel
 
@@ -537,12 +537,12 @@ $(OUTPUT)/test_progs: $(RUNNER_PREREQS) $(BPF_OBJS) $(ALL_SKELS) FORCE
 
 $(OUTPUT)/test_progs-no_alu32: $(RUNNER_PREREQS) FORCE
 	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=no_alu32 TESTS_DIR=prog_tests \
-		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v2'
+		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v2 $(CLANG_BPF_CFLAGS)'
 
 ifneq ($(CLANG_CPUV4),)
 $(OUTPUT)/test_progs-cpuv4: $(RUNNER_PREREQS) FORCE
 	+$(Q)$(RUNNER_MAKE) RUNNER=test_progs FLAVOR=cpuv4 TESTS_DIR=prog_tests \
-		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v4' \
+		$(CLANG_RUNNER_ARGS) BPF_CC_FLAGS='-O2 $(BPF_TARGET_ENDIAN) -mcpu=v4 $(CLANG_BPF_CFLAGS)' \
 		BPF_DEFINES=-DENABLE_ATOMICS_TESTS
 endif
 
diff --git a/tools/testing/selftests/bpf/Makefile.buildvars b/tools/testing/selftests/bpf/Makefile.buildvars
index ff3476bc40a4..8ae2792c0c1e 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -157,13 +157,15 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(abspath $(OUTPUT)/../usr/include)			\
 	     -std=gnu11		 					\
 	     -fno-strict-aliasing 					\
-	     -Wno-microsoft-anon-tag					\
 	     -fms-extensions						\
 	     -Wno-compare-distinct-pointer-types			\
-	     -Wno-initializer-overrides					\
 	     #
 # TODO: enable me -Wsign-compare
 
+# Warning flags that only clang has.  GCC accepts an unknown -Wno-foo
+# silently and then notes it on the next diagnostic it emits.
+CLANG_BPF_CFLAGS := -Wno-microsoft-anon-tag -Wno-initializer-overrides
+
 VERIFY_SIG_SETUP := $(CURDIR)/verify_sig_setup.sh
 VERIFICATION_CERT   := $(BUILD_DIR)/signing_key.der
 PRIVATE_KEY := $(BUILD_DIR)/signing_key.pem
-- 
2.53.0-Meta

