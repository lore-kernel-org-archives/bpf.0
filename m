Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEF364043;
	Tue,  2 Jun 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411682; cv=none; b=eFWKvFO6IW2ZOuV6ZxUz5wgxXlP0x1P40v1U55/EtHopWchqMNs6+M64pW0kUaIRvFMPMz2x/vU97gT91ot+zOnJ2miZM++tPx3dy12oQvNHjG+JTZAxlNs9Z+oI5C/dSzGttic2RFaeWn/HWuBbKCMwJnr8jAKo928wQ3qFr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411682; c=relaxed/simple;
	bh=tBWghxOoy760LznhjWPLMsorMOUF8XUjgk8TeUz6l1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozzcfLEJRGcu4iTT6Ve49s1aek3Ddk6uxbBe3IBw6sqeuwiMv1Gc8ts7O07e/gm90az7GuE2TRfK5towT4U3Mcvb3SdAYiT+kP41pFF6Vkd93WC/0gTylIo3PpMTbg/nYkWF6pdGKbJCyfLfLh6O0WvWi7aY9hCNBwxjV3C7zCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LOg5ZGmu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LOg5ZGmu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E9619F6;
	Tue,  2 Jun 2026 07:47:55 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03F273F632;
	Tue,  2 Jun 2026 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411680; bh=tBWghxOoy760LznhjWPLMsorMOUF8XUjgk8TeUz6l1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LOg5ZGmu518ZkCsJLcqgYjJEUXyDouXNrnEbyTHw/haPfaoHe64obu0/YOWYA8W+8
	 xc/xRRhHAZFpQav0uV0r+tDCDQenff7W2P4XvbWwGCdQCtDwxsr5+ZN5OT32fj7+91
	 vbXs4/X1lAFXNFiwitWoMf4jHWlHMWGqH6SxlSLo=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:47:17 +0100
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Avoid static LLVM linking
 for cross builds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-8-c76e5250ea1c@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=1910;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=tBWghxOoy760LznhjWPLMsorMOUF8XUjgk8TeUz6l1M=;
 b=8ZY/PbHwZHO5k6Px7eSBt/bi2qfBHGuFSVLXyyi2bdr148mAam2GORwMsLTFSpZLDVHHlAZR4
 Ugv4muZoC5RAUElMAjnjNqYVa77OdmyxxJx2z8RvY9ys173jQJS2LUR
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The BPF selftests prefer static LLVM linking, which works for native
builds but can break cross builds. Its --link-static output may include
host-only libraries that are unavailable for the cross compilation,
causing link failures.

Avoid static LLVM linking for cross builds and use shared LLVM libraries
instead. Native builds keep the existing behavior.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/testing/selftests/bpf/Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1e47e29ba4214925c62afc0595a7edb859ace944..ffa90674e86f639d3a9cadb833e57f3693d77bdc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -188,8 +188,15 @@ ifeq ($(feature-llvm),1)
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
   LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
-  # Prefer linking statically if it's available, otherwise fallback to shared
-  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs >/dev/null 2>&1 && echo static),static)
+  # Cross compilation must use dynamic linking to avoid unresolved library
+  # dependencies. For native build, prefer linking statically if it's
+  # available, otherwise fallback to shared.
+  ifneq ($(ARCH), $(HOSTARCH))
+    LLVM_LINK_STATIC :=
+  else
+    LLVM_LINK_STATIC := $(shell $(LLVM_CONFIG) --link-static --libs >/dev/null 2>&1 && echo y)
+  endif
+  ifeq ($(LLVM_LINK_STATIC),y)
     LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
     LLVM_LDLIBS  += $(filter-out -lxml2,$(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS)))
     LLVM_LDLIBS  += -lstdc++

-- 
2.34.1

