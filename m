Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B611712
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898886; cv=none; b=oP+ThXa8wsblJ/npcSIx22m0AQ5UkCniMlhxaXDvvFVoxAO/OIedJF9qKaYZKrfVacC6cxb5G3tXo3eMvOan8zym/SYvrvT3YmFTRuIiOoDj9FBPHHsDiLcFdaxlgeH2SZAiCSJqbIkOYSkPTt5saNeOpegj2aIK9rdZZf5CN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898886; c=relaxed/simple;
	bh=2RJRzbCNgtQJujYZPjM/whepPqFnpDuc/S8jlpUiWQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D3xWLtMNemF8CetEShnPuU0aQ9+De0MRhLnDcHkHWBDeoRnium5MA03pP1rmlhcxOz3x5sg/4GVzWwheLBZ4UpmTnhaAzP0P/bt9jWTaqQDzqFuqiEq/R+z8mir/YfhCRLiQLgFkUeBkCsfPM9yfj9swmpboqTQqDzFk2Kv/tNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uduKsTR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uduKsTR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C4EC433C7;
	Wed, 20 Mar 2024 01:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710898885;
	bh=2RJRzbCNgtQJujYZPjM/whepPqFnpDuc/S8jlpUiWQI=;
	h=From:To:Cc:Subject:Date:From;
	b=uduKsTR0T8c6vQh1EFWEzq98k2BOs0lcEyykfxeKh8Ejl3YVnUfXhcGtu0CDznhle
	 P+kGNNG4UdNEvYpcC1/ba/ccIRoJNur6QxwDKXR8SjCg5CAjzEhzd0ACII7r22UfzI
	 yayfP/PNtlQbZT40oibnlnukZkxM23Fmhq0i+fKUswLZTy9ABfr6t/F7p2pSIho59Z
	 KlXcv8XXI7xgbFEmw/hKHt3w+jjYR1gvudFe/LmjSGWVFd2YO1st/KdzdSKfpQX+mj
	 MvqPZm+XjqSw9N3cRaLpCWizmIqJ0fbA0WNzvFnH0NkHb9K3bmXFTSkIF5iEGH4sQ3
	 dg0e7GSfIPKLg==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next] bpftool: Clean up HOST_CFLAGS, HOST_LDFLAGS for bootstrap bpftool
Date: Wed, 20 Mar 2024 01:41:03 +0000
Message-Id: <20240320014103.45641-1-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bpftool's Makefile uses $(HOST_CFLAGS) to build the bootstrap version of
bpftool, in order to pick the flags for the host (where we run the
bootstrap version) and not for the target system (where we plan to run
the full bpftool binary). But we pass too much information through this
variable.

In particular, we set HOST_CFLAGS by copying most of the $(CFLAGS); but
we do this after the feature detection for bpftool, which means that
$(CFLAGS), hence $(HOST_CFLAGS), contain all macro definitions for using
the different optional features. For example, -DHAVE_LLVM_SUPPORT may be
passed to the $(HOST_CFLAGS), even though the LLVM disassembler is not
used in the bootstrap version, and the related library may even be
missing for the host architecture.

A similar thing happens with the $(LDFLAGS), that we use unchanged for
linking the bootstrap version even though they may contains flags to
link against additional libraries.

To address the $(HOST_CFLAGS) issue, we move the definition of
$(HOST_CFLAGS) earlier in the Makefile, before the $(CFLAGS) update
resulting from the feature probing - none of which being relevant to the
bootstrap version. To clean up the $(LDFLAGS) for the bootstrap version,
we introduce a dedicated $(HOST_LDFLAGS) variable that we base on
$(LDFLAGS), before the feature probing as well.

On my setup, the following macro and libraries are removed from the
compiler invocation to build bpftool after this patch:

  -DUSE_LIBCAP
  -DHAVE_LLVM_SUPPORT
  -I/usr/lib/llvm-17/include
  -D_GNU_SOURCE
  -D__STDC_CONSTANT_MACROS
  -D__STDC_FORMAT_MACROS
  -D__STDC_LIMIT_MACROS
  -lLLVM-17
  -L/usr/lib/llvm-17/lib

Another advantage of cleaning up these flags is that displaying
available features with "bpftool version" becomes more accurate for the
bootstrap bpftool, and no longer reflects the features detected (and
available only) for the final binary.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index e9154ace80ff..972f8d727130 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -89,6 +89,10 @@ ifneq ($(EXTRA_LDFLAGS),)
 LDFLAGS += $(EXTRA_LDFLAGS)
 endif
 
+HOST_CFLAGS := $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
+		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
+HOST_LDFLAGS := $(LDFLAGS)
+
 INSTALL ?= install
 RM ?= rm -f
 
@@ -178,9 +182,6 @@ ifeq ($(filter -DHAVE_LLVM_SUPPORT -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
   SRCS := $(filter-out jit_disasm.c,$(SRCS))
 endif
 
-HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
-		$(subst $(CLANG_CROSS_FLAGS),,$(CFLAGS)))
-
 BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
 
 BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
@@ -238,7 +239,7 @@ $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
 
 $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
-	$(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
+	$(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
 
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
-- 
2.34.1

