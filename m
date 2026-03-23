Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B53BADB5;
	Mon, 23 Mar 2026 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280453; cv=none; b=FYTJ1ti4CkYlhRVyswlGJUY9dAAj+0I/QtWYx9wEb/SvUipADDfRJjb+Uz9lkYLRDQpcy0vwGDTnLMZt/Jd4nGsdLckmsvr2gTARSJZaJKfssqecLQ8VdLocVSg0c++iFEkV6tRMeT5GHw58itP/eljcHrIGdQijUQ6icQVMxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280453; c=relaxed/simple;
	bh=K3wdiOIPmKzJb3V7P58ebfdxfQJMWLNeh3ipytoXWwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPKIa0tsLNxxwjvFSkoPp8lwmx/4Z4JFnx7ZaRg4rstz66uHIRsIQpfDp5FIGe0ccy4gMOADHeyZMLgWso8zLk/lhNqt6sFG4lIlkSg2/7RasC1lwAGxkwuyZqMsvH5ZfYJF2ElbpeE7RgvxCOE6FSvP/wUfnIP2H82i2k7Kq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0931714BF;
	Mon, 23 Mar 2026 08:40:44 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40ADC3F694;
	Mon, 23 Mar 2026 08:40:46 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 23 Mar 2026 15:40:07 +0000
Subject: [PATCH 6/6] selftests/bpf: Append extra cflags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-tools_build_fix_zero_init_bpf_only-v1-6-d1cfad2f4cd1@arm.com>
References: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
In-Reply-To: <20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774280421; l=2317;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=K3wdiOIPmKzJb3V7P58ebfdxfQJMWLNeh3ipytoXWwU=;
 b=6rkoiMv1f9bl/ohzee85t44Ww5uAMM1mVQPtXsR9tqgP/7amWpwxTqBrHN/Sm9C5YY0DfdRcn
 PAbEu+V1cv9CyO6twxqNxlpkHJyGSV2el40z9N3Tuk0qMa4QKtChMcg
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

urandom_read is built with clang.  Introduce URANDOM_READ_CFLAGS to copy
the compiler flags without appending EXTRA_CFLAGS, which may contain
incompatible options with clang.

Since lib.mk appends options to CFLAGS, ensure that CFLAGS is inherited
after including lib.mk.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/testing/selftests/bpf/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c02842541f385bc8cbaeab32d8195ed3..50bcf4c386ba52e6cceef4c15f999d9eec6efd6e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -158,6 +158,12 @@ endef
 
 include ../lib.mk
 
+# urandom_read is built with clang. Copy $(CFLAGS) before EXTRA_CFLAGS are
+# appended so that it does not inherit potentially incompatible options.
+URANDOM_READ_CFLAGS := $(CFLAGS)
+
+CFLAGS += $(EXTRA_CFLAGS)
+
 NON_CHECK_FEAT_TARGETS := clean docs-clean
 CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
 ifneq ($(CHECK_FEAT),)
@@ -255,7 +261,7 @@ endif
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
 	$(call msg,LIB,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
-		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
+		     $(filter-out -static,$(URANDOM_READ_CFLAGS) $(LDFLAGS)) \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -Wno-unused-command-line-argument \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
@@ -265,7 +271,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
-		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
+		     $(filter-out -static,$(URANDOM_READ_CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -Wno-unused-command-line-argument \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \

-- 
2.34.1

