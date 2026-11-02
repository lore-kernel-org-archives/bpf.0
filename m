Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657267;
	b=J9kh1EsyMClnaA6HqLwIKF8d3T1JqYyk1FpBcET+4AMvGP7qQKvn3OQozZB4cGDXV8dL
	 v5/4nrM7GyGBHuQy+btduI1kKvn627fA0NaiTXEeAX1HdW8BIJRFsnZIOYsb012xUYKFJ
	 jLhLmKjbpFZwETgtvj5KKqbK7CysljTGqMvYAMugB40kr+byXT4Po3cPdq+DeU2FVMEoz
	 qXqWjHRbmjMV51U7EVonSgoBSZbRKy4qKLfXX+lxwOAvs6xy/J2E9tTOuLrerZuILpRFl
	 Z/i3jbdJUg6xVY3BhrEwQmL8LDfPaXLXh4eVuTvklJ/STe1mnxV48xanJkGgeDBzphQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657267;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WSPVKTAbk+SR/VAwnNkr5dYCl/mMwEQQEo11sg6MJE8=;
	b=LBGVfGekMwopvUsXtDzYc9jkuLWGLQ0Gmy1vlawmJzDHtIztS23QxPeQWho+xv7YRBYb
	 vWILoIB/fsiSKRxQieoFxsMczAfXu2nty+vKIdChhiQ3Tq7iV+B/VxxeDXxDGOXpq4kCH
	 uvXId5NDsXxwqfFlbziV8Y6aP49iMhjjPnYDcnVeqe4wOnWhcBwWhesOy7xElfMp27a3i
	 tdpH777tgtzOa1oyLw5O/ETuquBiGeQqHMwSE6VaTawfq48BaPuYC2FyFf1fRF2RlyIDp
	 xjNBjfq9MmB9iroedz5KtKnvCCfhWF+UezyIwLreMPumziSVBRV2V/Cm94vap72Vdbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rY6mchjp;
	arc=none smtp.remote-ip=95.215.58.182
Received: from mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED416606A332
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED416606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rY6mchjp
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oCKqNYshv+mvVDoSWeudI8uV7hNBmVaIdXc8GtKyjVQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793657265; v=1; x=1794262065;
 b=rY6mchjp9m1I8vluO+CSYVm/MBAhplCQtsqNkkDiPDM/IVfLU7Fn+9J5Lz9P0aN8mEzP+a5K
 S3VDcSWM69VD3WaPDtkZu+RCRq9lAe0zxXNKhlqTgwMC3geHRgSn6F53t/T8o5XA6EFBSgQ0bfh
 d2RIVYaobfpVKTHv4/+3S/5E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 314a656f70197fe5;
	Mon, 02 Nov 2026 22:07:45 +0000
X-Mizu-Trace-ID: 314a656f70197fe5
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
Subject: [PATCH bpf-next v3 2/8] selftests/bpf: don't pass clang-only warning flags to GCC
Date: Mon,  2 Nov 2026 14:07:11 -0800
Message-ID: <20261102220717.4079739-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220717.4079739-1-vineet.gupta@linux.dev>
References: <20261102220717.4079739-1-vineet.gupta@linux.dev>
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
index c99e0f623e10..77682bf28c6e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -376,7 +376,7 @@ CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) $(CLANG_BPF_CFLAGS)
 
 # genkey writes both outputs. Pattern rules group them even on make
 # versions before 4.3, preventing concurrent genkey invocations.
@@ -511,7 +511,7 @@ BINARY := test_progs
 BPF_CC := $(CLANG)
 BPF_CC_MSG := CLNG-BPF
 BPF_SYS_INCLUDES := $(CLANG_SYS_INCLUDES)
-BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3
+BPF_CC_FLAGS := -O2 $(BPF_TARGET_ENDIAN) -mcpu=v3 $(CLANG_BPF_CFLAGS)
 BPF_DEFINES := -DENABLE_ATOMICS_TESTS
 include Makefile.skel
 
@@ -527,12 +527,12 @@ $(OUTPUT)/test_progs: $(RUNNER_PREREQS) $(BPF_OBJS) $(ALL_SKELS) FORCE
 
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
index d2a0c0031b87..4d25a736376c 100644
--- a/tools/testing/selftests/bpf/Makefile.buildvars
+++ b/tools/testing/selftests/bpf/Makefile.buildvars
@@ -132,13 +132,15 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
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

