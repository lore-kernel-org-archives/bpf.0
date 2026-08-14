Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D5470425
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728940; cv=none; b=JXA44a/R2qEbcN55UzAbUIYvYWzNDFe/VDlpaAQE34cF9GmGTpVoWbf1yro3gs1q6jJZH4Y9KgntH9nZwakBn/bJnYKurUtyAQevXvwjBvfxfG28FDKwHjadGXveSeruvNex1LW5PjHkFATyUPWucsTqRU5IucHZFQBrc3ZVxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728940; c=relaxed/simple;
	bh=yoRH5ciuOG+7ZYaIijD/I8iV9PMamsIgSHhA+UNzOBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQ/H113+xsiztlaysVdrs/n/seia2Bzx3WcIgC0VDGAhGbscL2buTvLxSYrDKhHDX1yMsuigUxUPbkL2eyUY1/urQYh0N6e75lhbqVpBtf3LEgSp9y47R7oahRjY9DYwGOYPj6CWXDVb0xfgsRPBnYM1DHkYdlqdDlcP8TOFHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GoNibmUN; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GoNibmUN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yoRH5ciuOG+7ZYaIijD/I8iV9PMamsIgSHhA+UNzOBE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786728937; v=1; x=1787333737;
 b=GoNibmUNwPVLbY3aUaeyJbPPNQNYdssD6lruDSXQ/kT4oDGzEgsDWDtjgGM1cMzooNvx6wCL
 sVfk+X5qpGOwXL+NOz1TlVUYqS0877pPmL+5BCpH5oSsYlcpIZ5eNPWUpN0TOr5egqLmDdWes4s
 MGEkSerwHzlk5nNBsZyEPBWs=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::4:b8fe)
	by mta12.migadu.com with ESMTPS id d461b8ccd12c1a37;
	Fri, 14 Aug 2026 17:35:37 +0000
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Fix selftest build after filter.h update
Date: Fri, 14 Aug 2026 10:35:21 -0700
Message-ID: <20260814173522.2783625-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream commit 7a1f400ff5e5 ("tools: Ensure tools copy of
linux/filter.h exports the UAPI") caused selftests/bpf build to
fail [1] with:

  In file included from progs/arena_atomics.c:9:
  /codebuild/output/src2365462129/src/actions-runner/_work/bpf/bpf/tools/testing/selftests/bpf/../../../include/linux/filter.h:9:10: fatal error: 'uapi/linux/filter.h' file not found
      9 | #include <uapi/linux/filter.h>
        |          ^~~~~~~~~~~~~~~~~~~~~
  1 error generated.
    CLNG-BPF [test_progs] bind_perm.bpf.o
  make: *** [Makefile:888: /codebuild/output/src2365462129/src/actions-runner/_work/bpf/bpf/tools/testing/selftests/bpf/arena_atomics.bpf.o] Error 1
  make: *** Waiting for unfinished jobs....
    GEN-OBJ  [libarena] libarena.bpf.o
    GEN-SKEL [libarena] libarena.skel.h
  make: Leaving directory '/codebuild/output/src2365462129/src/actions-runner/_work/bpf/bpf/tools/testing/selftests/bpf'
  Process completed with exit code 2.

BPF selftest programs include the tools header directly, but
BPF_CFLAGS only exposes tools/include/uapi. Compiler therefore cannot
resolve the nested UAPI include.

Add tools/include after tools/include/uapi in BPF_CFLAGS. This
preserves the existing UAPI header precedence while allowing tools
headers to include uapi headers.

[1] https://github.com/kernel-patches/bpf/actions/runs/31806678733/job/94787271162

Fixes: 7a1f400ff5e5 ("tools: Ensure tools copy of linux/filter.h exports the UAPI")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 384c6e8d9274..c0a73473d14e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -463,7 +463,7 @@ endif
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
-	     -I$(CURDIR)/libarena/include				\
+	     -I$(TOOLSINCDIR) -I$(CURDIR)/libarena/include		\
 	     -I$(abspath $(OUTPUT)/../usr/include)			\
 	     -std=gnu11		 					\
 	     -fno-strict-aliasing 					\
-- 
2.55.0

