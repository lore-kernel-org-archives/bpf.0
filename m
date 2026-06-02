Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6F364043;
	Tue,  2 Jun 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411678; cv=none; b=EzIgXeWF13rhajxVRCv6V7s7MHgxjUIZD4lg3fdVpAvTzQzr0iSIeHP73Y+tGh9vIeMAIZm8bAPU2Zno5TfOUlrLy1oWqYp278fj+OQfWuvZn6a/UCIx9bzphC/q2bNET37mYh6ZUId4+EXZngFt0I6bVzRKng4KPgfN59tJc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411678; c=relaxed/simple;
	bh=bMN9gphLJ0WpQVf2p7gRQo/4Ma444n+6RwFR/oCCDds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSEeJuSKC674z7UOtTefFKKMT2V+4FxPj73NyNjkTOrz5+PorjOftqAQLaZCKnUGRgDRxiB/2GOjEf2GHxOeg1OgzxVwKN0suOJvbCgjgfl6UGdyPXKKRwevqu7koAwjEE6y/lLxTpkZ3MXJOAIOxswH+PDNYZYkfzhBpAePLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uywKaYA4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uywKaYA4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B018A2B;
	Tue,  2 Jun 2026 07:47:50 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB573F632;
	Tue,  2 Jun 2026 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411675; bh=bMN9gphLJ0WpQVf2p7gRQo/4Ma444n+6RwFR/oCCDds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uywKaYA4ak3RTQezJyAobLlxIRE501WokpNfyShftwbwxg4zrYCbzAHWnG1NO1+Vh
	 oRHz8HvyAMdQWm89pu+z8xcR+Dpolarcg7kMdlYxKogL75oe3+c2j+utiSXvjCcu7N
	 +BUvq8BmNH4XERm52V7gS/bmu67G1+bU1x+MywiQ=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:16 +0100
Subject: [PATCH bpf-next v2 7/8] selftests/bpf: Use common CFLAGS for
 urandom_read
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-7-c76e5250ea1c@arm.com>
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=2847;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=bMN9gphLJ0WpQVf2p7gRQo/4Ma444n+6RwFR/oCCDds=;
 b=emrjfJPI9VdzcKeIN1ZDHuyaKSs8VnFdstQhCXZeZpQLKrr4TDaRvRiw1vOikCxNLP+JWsEuc
 oiYidFuvAKbA3KRz/aVYu4ly4pxS6Nw1dcKf+ny1PHsL5sX39aenybk
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The urandom_read helper and its shared library are built with $(CLANG)
directly rather than through the normal selftest $(CC) rules.

The CFLAGS variable can contain specific flags only for $(CC) but might
be imcompatible for $(CLANG) and those flags are not necessarily valid
for the clang-only urandom_read build.

Split the BPF selftest local flags into COMMON_CFLAGS and append them to
CFLAGS for the normal build path. Use COMMON_CFLAGS directly for
urandom_read and liburandom_read.so, while still filtering out -static as
before.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index bc049620c7745ce35976f5e0922eb680e38def13..1e47e29ba4214925c62afc0595a7edb859ace944 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -51,7 +51,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
-CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
+COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
 	  -Wall -Werror -fno-omit-frame-pointer				\
 	  -Wno-unused-but-set-variable					\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
@@ -64,7 +64,7 @@ LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
 PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
 PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
 LDLIBS += $(PCAP_LIBS)
-CFLAGS += $(PCAP_CFLAGS)
+CFLAGS += $(COMMON_CFLAGS) $(PCAP_CFLAGS)
 
 # Some utility functions use LLVM libraries
 jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
@@ -261,7 +261,7 @@ endif
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
 	$(call msg,LIB,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
-		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
+		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -Wno-unused-command-line-argument \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
@@ -271,7 +271,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
-		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
+		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -Wno-unused-command-line-argument \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \

-- 
2.34.1

